Return-Path: <linux-kernel+bounces-566587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514DA67A24
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE64A17470E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0062116E7;
	Tue, 18 Mar 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJJdeyB5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC017DA95
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317018; cv=none; b=Z3wqcvKchIlsYnDn78kUA1eYhCI/SeUYqkXB/Kr3haEHvVfkooYRRSvMbvVNH166F1zlcoaG6vWcXSa7/KXJH2PK9uQjs0OQZiOp3suxDZ3T/2cuBZQa14mjEgD8FpbGFXur1wbOgZWCavKPtyaBtjchFoAGw4ToWfnUcvev6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317018; c=relaxed/simple;
	bh=L8V6jfJN7SQ1flEiJyMtrfP1R57ohXQfUmzhu8MHfLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsjltSnKNyxjf+TxVTvs5/5Ym57gEgeK2XPPhIXvib9jJ09Wpo5AfWe3i+xYY8mizQ7ILo0adYZW26vQ8/o7On2VKKyZ8ade2noutvLyS4Qm9FMe7B83dqanNqYpb8hXmAsFWxlMzGmYZZCx7iS2lrXYu9nLJsrCS3vt0SPwiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJJdeyB5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742317017; x=1773853017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L8V6jfJN7SQ1flEiJyMtrfP1R57ohXQfUmzhu8MHfLo=;
  b=DJJdeyB5wylAzgJEcGYiuKNIVnBthey1iM7vasQLm7MPvQRk5a0zjcJE
   aGns/I631DUnM+XTWn8spKVsXESG2H5rfE/zNr3KVcSoq0/eq2R/ACeDl
   LS7CgTLyX5PmoesomCxZxsZFrv0qYbHGCJgv/Mt056KC7eayIq0/CqwE7
   OxZBn7s0jSDF5V7mR79pjY6KMDPUUnVgY1Ld79aU5Fjf8Q4YtIuCN8oXs
   7VzKbh9FYmi6iVecJsfaDEDIdCcS5TSO7dSTfUhUzI8cZpw5LYk+6B/aR
   SntF4uQLtaVRKuoJU2dAIhtu6Qm/kvRnaNN8cEIJjcOIShkmrqFOPi/bn
   w==;
X-CSE-ConnectionGUID: JpTnuvObR0GVvEIVOGCNrg==
X-CSE-MsgGUID: v1iFqqyrSqiQYLw0ZGbyyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43208052"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43208052"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:56:55 -0700
X-CSE-ConnectionGUID: 31OAnG14T52SK0JDRCsYnw==
X-CSE-MsgGUID: F2VsEEI8R3q7EZkfM3sbTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122797108"
Received: from eballerx-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.191])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:56:55 -0700
Date: Tue, 18 Mar 2025 09:56:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: MMIO and VERW
Message-ID: <20250318165645.lnutevfmtld3vu4d@desk>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
 <20250318141659.GDZ9mAWwa3dkQDHkCk@fat_crate.local>
 <20250318162505.3ptnegnjz46hchep@desk>
 <20250318163451.GEZ9mgq7XsE1kIyiSy@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318163451.GEZ9mgq7XsE1kIyiSy@fat_crate.local>

On Tue, Mar 18, 2025 at 05:34:51PM +0100, Borislav Petkov wrote:
> On Tue, Mar 18, 2025 at 09:25:05AM -0700, Pawan Gupta wrote:
> > Rocket Lake, Comet Lake, Ice Lake with tsx=off only require VERW at
> > VMENTER. There are other MMIO affected CPUs that are not affected by MDS
> > and do not support TSX or disable it by default.
> 
> So all those CPUs are only affected by MMIO and not affected by neither of
> those:
> 
> TAA, RFDS, MDS

That is correct, they are not affected by MDS, TAA and RFDS.

> Or is that the case only when TSX is not enabled/not present there?

As per the affected CPU table [1], Ice Lake is not affected by TAA even if
TSX is enabled.

[1] https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html#tab-blade-1-2

