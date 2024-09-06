Return-Path: <linux-kernel+bounces-319269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81196F9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DD71C222F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4421D4611;
	Fri,  6 Sep 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUBUUuYm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A61C8FB6;
	Fri,  6 Sep 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643408; cv=none; b=il9L4nDygtCfl9XRLgf02teonlHLgnrxZ6M1trK0/WtreWYLYVCVhvRC81YMRV5vhp1rSxfiG1+p6S2/5ux1Rzof293srYKzbukmSKp41eviAJOkcCuw+KiiX2z1UsKIZr6AhSQkVzYL+bTfi/jOhV+yAeWB4ALqyzNuIlAqwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643408; c=relaxed/simple;
	bh=S/xfOfBAVd383A2ps41ogLm4fB4uodo4b5sPLt+Eg48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWQQuzkPIhc4gMfRT5VEf185T2ast0LGUPUbP3RESEVki/7YTeScVLIGUow21shDfKExwsNjvhULMaDAg/hFCacjx5iSmVp9VPa8ssiumyT5FU/BqYzNxwGDeTYoT/oNHm9OvtafGLuscis1yzQiPC3MueftX6kgOGuPnqtW/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUBUUuYm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725643407; x=1757179407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/xfOfBAVd383A2ps41ogLm4fB4uodo4b5sPLt+Eg48=;
  b=PUBUUuYmdzi2Mn47vKTqOHnUuL+APYGJXJ4qFVGEQx2js6lHFyrpGcEy
   CuwORlosQCO8lUCmZIcJtyGPD0QkpVMVqYrVeitm7a7hZALeaKPn7RLc8
   16uiFtAZrNhL1/aW5dcDrkEK38T5azepnFp+cXbxdDwXfL4MLHrXzizP0
   37ch3FdByOAaGtqbD4EwKfdE8ZRm/ic+L7XaGQgJXbeOMuSR0v4bfLxQ1
   PtQ/B3VYIOsmPTR97xstbNp7aLMvv7jVH72rGzEtJheIaZTwgDpsMdDe5
   mU2RAT+W+RwUS+S7m6boMg2tfwj+8wU8r3lyzMhAeZAqlYylQ7yhj5Upi
   A==;
X-CSE-ConnectionGUID: krhcKgUJTxeN2PPv/Of74g==
X-CSE-MsgGUID: XKQFqwUqQsq5UuBDQPEoFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24560376"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24560376"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 10:23:26 -0700
X-CSE-ConnectionGUID: 42Wl4SCkQx+XFqEdRaObxg==
X-CSE-MsgGUID: 11faES5nTj+CEoy/h26+rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="65658758"
Received: from sokwuosa-mobl2.amr.corp.intel.com (HELO desk) ([10.125.147.109])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 10:23:26 -0700
Date: Fri, 6 Sep 2024 10:23:17 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Takahiro Itazuri <itazur@amazon.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, bp@alien8.de,
	zulinx86@gmail.com, jpoimboe@kernel.org, peterz@infradead.org,
	tglx@linutronix.de
Subject: Re: [PATCH v2] Documentation: Use grid table over list table
Message-ID: <20240906172317.ohiokq7fzoc5emnq@desk>
References: <20240906104936.15558-1-itazur@amazon.com>
 <87zfoknc9y.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfoknc9y.fsf@intel.com>

On Fri, Sep 06, 2024 at 04:26:49PM +0300, Jani Nikula wrote:
> On Fri, 06 Sep 2024, Takahiro Itazuri <itazur@amazon.com> wrote:
> > Using a simple table, a line break in the first column would be
> > recognized as two rows. To avoid that, list table was used but it
> > is unreadable for plain text readers. Uses grid table instead.
> >
> > Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> > ---
> > Changes in v2:
> > - Use grid table over list table (applying to not only GDS but also
> >   other vulnerabilities)
> > - Link to v1: https://lore.kernel.org/all/20240903132533.26458-1-itazur@amazon.com/
> 
> I see that Jon asked you to use a grid table.
> 
> But when I look at what's being changed, I can't help but think a
> definition list [1] might provide the best compromise between readable
> (and easily editable!) source rst and generated html. I don't think it
> has to be a *table* in either.

I second that, definition list looks to be a good balance between ease and
readability.

Roughly this is what it boils down to:

  **Not affected**
    Processor is not vulnerable.

  **Vulnerable**
    Processor is vulnerable and mitigation disabled.

  **Vulnerable: No microcode**
    Processor is vulnerable and microcode is missing mitigation.

  **Mitigation: AVX disabled, no microcode**
    Processor is vulnerable and microcode is missing mitigation. AVX
    disabled as mitigation.

  **Mitigation: Microcode**
    Processor is vulnerable and mitigation is in effect.

  **Mitigation: Microcode (locked)**
    Processor is vulnerable and mitigation is in effect and cannot be
    disabled.

  **Unknown: Dependent on hypervisor status**
    Running on a virtual guest processor that is affected but with no way
    to know if host processor is mitigated or vulnerable.

