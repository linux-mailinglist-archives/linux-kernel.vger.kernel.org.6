Return-Path: <linux-kernel+bounces-559324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C6A5F252
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D623D19C1E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFBC2661A8;
	Thu, 13 Mar 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvUcXAQV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0D1E8325;
	Thu, 13 Mar 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865273; cv=none; b=biAw1u1Ig5/pBDLDkWB+CmSbyDidvq0czETBx9DvWAFsNDruFtX/sSDbKk9cqNLwFaiPa4v/eee6ZJUS69nMBl0qcOryrkwRi3+Fte7bneX28DT6ilwV6A02gn/VEwXZK1lAo/cYZLottF7lXaSGX88yDTSx32WizrDK/poLX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865273; c=relaxed/simple;
	bh=2Z7GlnJiaoHH38Zi1CEzV+vopmIxgrXcCdImuy/MZjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrAhhxMpBI9n8ItG9Z8SRmQFb6nf8JVQkZyDpLaIcsn7UqqJGmoM5+MMVgw3DG14JnwufOSoU2TivV/QPzY0RWs8UOnewFJxDu1eM0/YJ3mMWMQJwDjDiVnkOhzpLMQ5dSl9hNUr9GqH5s7QpZsv/uJ4u6qTCdoOvf6o1EFnfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvUcXAQV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741865272; x=1773401272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2Z7GlnJiaoHH38Zi1CEzV+vopmIxgrXcCdImuy/MZjI=;
  b=WvUcXAQV+l+HNqvlrCYCHR2NmTDrYjJ6EBNy5QCLCMAmmqtnTwqUmP8c
   fOdgFek3In/8ATJu3pY3vQReh/ZZRiRBoykxVsLgJiF/akoC0NdkTYYu7
   BDE4noXWsAfoDBREVEDFzPmXQYZhwNO3fQbnINyZgTL4SbblL8eHapKK5
   GNi8OM04s5WOxaGnHmp7EXTiQYbOpsbF6lo3YUjJq/MRfftJxAJ+8mlmy
   IRjkmIICUU62967M0USQ9aM63OjO8MsjbcoZLXxRwqvoU7eo1ReB3kRtT
   PBxsteLoHk2Rixbb33+osFK/uQtV79wAkM35Z6jphjLaYEnGRISSIJbe+
   g==;
X-CSE-ConnectionGUID: HV8CF+ATQyi575rcUaHhew==
X-CSE-MsgGUID: IrhrwbZAQI6RytQvTcGNXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30565690"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="30565690"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:27:51 -0700
X-CSE-ConnectionGUID: 1rZWs2wUTwyfL1lBc8aiKQ==
X-CSE-MsgGUID: 9JQub84FToGxUBGtW3Z60A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126112297"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:27:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsgj2-000000029nV-16NK;
	Thu, 13 Mar 2025 13:27:44 +0200
Date: Thu, 13 Mar 2025 13:27:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] ASoC: SOF: ipc4-topology: Allocate ref_params on
 stack
Message-ID: <Z9LBMEvlRoiVNsvi@smile.fi.intel.com>
References: <20250312160516.3864295-1-andriy.shevchenko@linux.intel.com>
 <bdc7b218-8f14-4bfd-8a76-2f35e5a9393c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdc7b218-8f14-4bfd-8a76-2f35e5a9393c@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 01:21:17PM +0200, Péter Ujfalusi wrote:
> On 12/03/2025 18:05, Andy Shevchenko wrote:
> > Currently the compiler (clang 19.1.7) is not happy about the size of
> > the stack frame in sof_ipc4_prepare_copier_module:
> > 
> > sound/soc/sof/ipc4-topology.c:1800:1: error: stack frame size (1288) exceeds limit (1024) in 'sof_ipc4_prepare_copier_module' [-Werror,-Wframe-larger-than]
> >  1800 | sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
> >       | ^
> > 
> > Work around this by allocating ref_params on stack, as it looks the biggest
> > variable on stack right now.
> > 
> > Note, this only happens when compile for 32-bit machines (x86_32 in my case).
> 
> I don't have better idea for fix, apart from somehow refactor this huge
> function.
> Thank you for the fix,
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Thank you for looking into it!

-- 
With Best Regards,
Andy Shevchenko



