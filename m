Return-Path: <linux-kernel+bounces-231257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA929189EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEF11F2316E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7F18A945;
	Wed, 26 Jun 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVZsxCmz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EED770EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422153; cv=none; b=qXU8JCdzNijF2DRgHfOEHA6JoBr9GNzVZnP2HdNZVc9QcQBuEyX5gVP+E4yj+YR1GHM4FuhdPDN91UigimCYjDSzSMtPZ335CFJrfak/FPNgrTaXOEuZ2Hl1sEl/ETkUK/pwnZzq08LZ2m+Fzx/wlQL9BaQ/LJQoh8x5HqHm/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422153; c=relaxed/simple;
	bh=sp427o3rZDx4S1VNJsPJfamV4IgudOcdAwjp45MMNQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWpTs8AyEh24z90Ifijw3ZE/tCXDq7iptJAjVzWrqWzvz1XduRhbltP6I7oBX7rsOgbLjOnezFYg9QTptSUsoxNV1q1WAjcAyNfhg7n+JkA1b6LLFQMrgEKTk9xu7zyRKaU2EHiLsSoHWxyaTvnn3DTnOWxCXqcix6oawDi1poM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVZsxCmz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719422151; x=1750958151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sp427o3rZDx4S1VNJsPJfamV4IgudOcdAwjp45MMNQs=;
  b=iVZsxCmzFTVyoJMW/ofPIQ9gGtV+atv7f/6yv3fyQo44n2fUSGBx140k
   7aoTXxROrWccyZWiI1xzJZrJpgEPz4cMYDtWwGaGB+oiJ5Ld15ylnEDoS
   vW3szLuI/sx7ZuqqsStrmqw9Mwkmgsh54TfmRGbxBPVX9QXcp3RQ0JSeB
   8GR2bmbsJkv0hGx7frz9QADv/NpW/+Eew/lXkmk2KidWafA2go83i/puM
   2PDhAl2vT0hkXnmbrzIHsO87fq83dv15EifJyDcFjvVAhBTf/T0rrOSsA
   CVBd1hTbDF5bj5azaiSdKptuB/63XszeTaS+OveQAy3TytkJhmN4LlrkJ
   w==;
X-CSE-ConnectionGUID: tH0hQN/JTR6d9YTo9nyPFg==
X-CSE-MsgGUID: 6Z6rIPwnTguwd32c6aQJyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16646638"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16646638"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 10:15:50 -0700
X-CSE-ConnectionGUID: 3HUef8wDRqWye5Ail6FmWg==
X-CSE-MsgGUID: HqrWXsYNSamTAREVfMmURQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44042812"
Received: from bfarshch-mobl1.amr.corp.intel.com (HELO desk) ([10.251.24.95])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 10:15:49 -0700
Date: Wed, 26 Jun 2024 10:15:41 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v10 1/2] x86/mm: Don't disable PCID if "incomplete Global
 INVLPG flushes" is fixed by microcode
Message-ID: <20240626171541.eeisf66vhuyspv4j@desk>
References: <20240522020625.69418-1-xry111@xry111.site>
 <b901776293d19271a34bb14f79639c4b574b6174.camel@xry111.site>
 <e2cb23a6-60d4-49b1-ba48-1ded846e5292@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2cb23a6-60d4-49b1-ba48-1ded846e5292@intel.com>

On Wed, Jun 26, 2024 at 09:50:39AM -0700, Dave Hansen wrote:
> On 6/26/24 06:10, Xi Ruoyao wrote:
> > Ping.
> > 
> > Ok to queue these two into some branch for integration?
> 
> Please don't top post, and please trim your replies.
> 
> The code looks fine, but this has zero acks and I can't find any public
> documentation of which microcode versions fix the errata.

Based on an internal document, I provided the microcode versions used in
this patch.

Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

