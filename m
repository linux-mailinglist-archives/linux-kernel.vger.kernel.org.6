Return-Path: <linux-kernel+bounces-566728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D3A67BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A501893AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659CF212D79;
	Tue, 18 Mar 2025 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXi36EM/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCC20D4E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321726; cv=none; b=MlMsyUiuswxgmVvgphD2G7QirdXwy7QX9pdEX3YNjdqIpDVzMdOleJvq5UuTXH0GCrQv1gef/5b+ujjE+keKc+HiKWbuzMDSkOqlG1hQGGNcQzg+KzC/NhnIXeCm3pO4mLQOFX4qJhyAt76wL4qhEdPBvnG/fYAsGuQjx5SmESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321726; c=relaxed/simple;
	bh=HgtPkbYi6NryqqJTd5YSJpSV0MhbufHtaVrMe4A7N3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ2nZNQGtqqZeH6c9REmyPehI+OpPxkC3wLjFXll8Q0z7RlSnVETPwqf18BH/w9FyE2iYB1ulWfYDw1hcfyF+flbDSyvqIu1XiB8Syl3WIWdb1qGrcvBif4+FZt+DiEiUXc9l8ahhvyHcLvgE/JN1XJe2q210qRbIwEJMaFHEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXi36EM/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742321725; x=1773857725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HgtPkbYi6NryqqJTd5YSJpSV0MhbufHtaVrMe4A7N3k=;
  b=JXi36EM/H4V7rsNWB4gDnGK4uAkc+G6J9QBezxJRdXVPHNB4M4HNn5ZE
   DMz6tJoTGibHQyitc9VSHJT5KTk+ea1GEza5KaJqq6L/fLi4mhBmP7gwt
   juLQeWovyMaRy2M7O9bbY1zcvwtjQMB2zNoJ9nSTOpWUykvPJs6co7U/0
   LcmVsGsE3KBY1KsB7OEWzRq8t38AKYEACsiBjjFGimQSe0vvbRLDt2NP3
   W5koyxSNt9hlFdyaFNrdnua27uXKl2z/75EkIhf1Ony265Uw6Ap73tFc0
   t35PFgO1Vb+LNuGCJbO88dqlzJUAA65Z4NfBPaaQvcKbXAtPTOxoXb81Q
   A==;
X-CSE-ConnectionGUID: tmRT+/B3RWiCPfIDDkqEmA==
X-CSE-MsgGUID: iCKEMpStS0eGuOZ4ldj4kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43497482"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43497482"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:15:24 -0700
X-CSE-ConnectionGUID: VDLhsQGsRt++vQGXXdhFFw==
X-CSE-MsgGUID: ywsTV+rwTeWatrjN2APeLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="123092523"
Received: from eballerx-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.191])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:15:24 -0700
Date: Tue, 18 Mar 2025 11:15:15 -0700
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
Message-ID: <20250318181515.42jf2p5onoueeg3v@desk>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
 <20250318141659.GDZ9mAWwa3dkQDHkCk@fat_crate.local>
 <20250318162505.3ptnegnjz46hchep@desk>
 <20250318163451.GEZ9mgq7XsE1kIyiSy@fat_crate.local>
 <20250318165645.lnutevfmtld3vu4d@desk>
 <20250318173708.GFZ9mvROyNagmhawEV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318173708.GFZ9mvROyNagmhawEV@fat_crate.local>

On Tue, Mar 18, 2025 at 06:37:08PM +0100, Borislav Petkov wrote:
> On Tue, Mar 18, 2025 at 09:56:45AM -0700, Pawan Gupta wrote:
> > On Tue, Mar 18, 2025 at 05:34:51PM +0100, Borislav Petkov wrote:
> > > On Tue, Mar 18, 2025 at 09:25:05AM -0700, Pawan Gupta wrote:
> > > > Rocket Lake, Comet Lake, Ice Lake with tsx=off only require VERW at
> > > > VMENTER. There are other MMIO affected CPUs that are not affected by MDS
> > > > and do not support TSX or disable it by default.
> > > 
> > > So all those CPUs are only affected by MMIO and not affected by neither of
> > > those:
> > > 
> > > TAA, RFDS, MDS
> > 
> > That is correct, they are not affected by MDS, TAA and RFDS.
> > 
> > > Or is that the case only when TSX is not enabled/not present there?
> > 
> > As per the affected CPU table [1], Ice Lake is not affected by TAA even if
> > TSX is enabled.
> 
> That table is insane - I need at least 4 monitors to stare at it properly. :-P

:D Totally agree. A machine readable format is here:
https://github.com/intel/Intel-affected-processor-list/blob/main/Intel_affected_processor_list.csv

> Anyway, so I'm wondering if we special-case those CPUs and have them select
> a special
> 
> MMIO_MITIGATION_VERW_VM
> 
> case and keep them separate from that whole
> CPUs-can-be-affected-by-multiple-vulns and the mitigation for all of them is
> VERW.
> 
> They will enable mmio_stale_data_clear and will be out of the equation.
> 
> Which will make this other logic simpler.

Likely yes, I will give this a shot and see how it compares with the
currrent implementation. Thanks for the suggestion.

