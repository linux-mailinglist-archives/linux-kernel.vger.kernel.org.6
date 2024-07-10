Return-Path: <linux-kernel+bounces-247070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E001492CAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D3B1F21431
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7735914A;
	Wed, 10 Jul 2024 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jC9lX+ju"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5394A3E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592141; cv=none; b=FdZ+LID/u0fvUB1dWGOffy93cs600Ikr3uGCVexqhQ9InnHu5s4uQgJBtzbTkpj5X1rhDXvCcN469zjglcNwz2Nxr8oiNha5SjOPGTblg5Edg3gCOcYf5i1NC4LIW8BUyj4/+drfcBURUNf1RSQXv4sbPwRJpf53PoEGTclReXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592141; c=relaxed/simple;
	bh=x58WhQ7etFsQVZtCXZu4tY1OB+k0z0c2wcqS0/1zYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/uerXGLoAkZrB1aqRogHQsH4AoVFWyn7/GFeyqf+dG+A4H3o7qPNdyZPrQz6nhQm9qPQovTqozQ0RmMGt/03MAa+cSKh561RcZb4lCdDB3Gm1hSsD6kqNqSjXdHKsYi90DWUmf6BCYusESAafd61oz4T68iB1jyWX+9AYzaQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jC9lX+ju; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720592140; x=1752128140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x58WhQ7etFsQVZtCXZu4tY1OB+k0z0c2wcqS0/1zYhM=;
  b=jC9lX+jueTpT9ahrFSD7hXCuK696rF1CGZVL51xfTuH/WrpG45LDuuvV
   58bhNWstT63LtT4AbvWYSHZNRdiFT2+Wbdo+11cuOkBbHAj9AgEs/dQjZ
   r0vuHVR9Xd7voGsLJPer3HW3G48X6WxSiDfVFUq6utFcHnvVDLEaPoJNh
   oUJlbaGgIdVlZ5O6XOjaq84ltbtNjtcFZe8AcXvXWiw+JpVGvzecm6m9t
   GJjkUgJuwp2wrIgbCJcL/1wk+sP4/1sT7VQ3dHvkdEtEBr42N4Kgqhv68
   95tVkjHtvAlb9Y3reGXKtrY/GbHTFG6FxY/U4JGW7Dla7RXJdQr/JQQFy
   g==;
X-CSE-ConnectionGUID: Rf+sEdntQBq4j56uP1mWVQ==
X-CSE-MsgGUID: 45aIY66HSvStlaa58lOK1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17709624"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17709624"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 23:15:40 -0700
X-CSE-ConnectionGUID: rRQkPTmuT56j1vvRSQve9w==
X-CSE-MsgGUID: qJJpVziqTTidtkwdgt+B5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="47873124"
Received: from dskiper-mobl1.amr.corp.intel.com (HELO desk) ([10.209.88.162])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 23:15:38 -0700
Date: Tue, 9 Jul 2024 23:15:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Shanavas.K.S" <shanavasks@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intel CPU vulnerability NO_SSB whitelist for AIRMONT
Message-ID: <20240710061526.so5rjsg3trw337ep@desk>
References: <CAEJ9NQdhh+4GxrtG1DuYgqYhvc0hi-sKZh-2niukJ-MyFLntAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJ9NQdhh+4GxrtG1DuYgqYhvc0hi-sKZh-2niukJ-MyFLntAA@mail.gmail.com>

On Tue, Jul 09, 2024 at 01:21:44PM +0530, Shanavas.K.S wrote:
> Hi All,
> This is in reference to
> https://github.com/torvalds/linux/blame/master/arch/x86/kernel/cpu/common.c#L1169.
> The whitelist for INTEL_ATOM_AIRMONT has NO_SSB enabled  which means
> cache speculation vulnerability(spectre 4,CVE-2018-3639) is not
> applicable to  this processor. But NO_SSB is not set for
> INTEL_ATOM_AIRMONT_NP and INTEL_ATOM_AIRMONT_MID. Are these settings
> missing for AIRMONT_NP and AIRMONT_MID or is there a real difference
> between cache speculation between these processors?

I believe they were released much later than AIRMONT and hence should be
enumerating MSR IA32_ARCH_CAPABILITIES[SSB_NO](bit 4). If you have these
system, is bit 4 not set?

If it is set there is no need to explicitly add NO_SSB to the table.

