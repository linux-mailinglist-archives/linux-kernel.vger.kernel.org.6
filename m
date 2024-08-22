Return-Path: <linux-kernel+bounces-297590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62695BB26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5A828455B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFF1CCEC7;
	Thu, 22 Aug 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXIu4vNS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B81CB33A;
	Thu, 22 Aug 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342182; cv=none; b=gJcar+9S35s1PrBSFvogHb5YDkoxDOr/Ssg5uk7GvIdJdixEuvPca5CnN48P7NuAk/xT4wAqBG6m4xxd0kAHCCqtQh568huP1u3AQ10Nv0TKCR0La0//ZQCBdr4/yQfANo4PE7Ff4Wh9t5XRfx8khCWj+gJHev1hGCv4LO2cJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342182; c=relaxed/simple;
	bh=AYv2NG1gnSTU3l2rG0Fniv+7XIySWiqxl+b4a2LziGE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P5ZngNaUjL7qhxE3IbrTruxJBVx/v2yHMq4gMfxdAiBxVpjIqXsRgIlfnqES6NUJ6HnLB//7b8yjDpig0iMOD31ndjN13li/v0rESPW+m1ftp70iWebk6WoXh767mwWrM6FDkdK7WWHgxbgf9U2kUns47K1xGsvs0hADGM5qNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXIu4vNS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724342180; x=1755878180;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AYv2NG1gnSTU3l2rG0Fniv+7XIySWiqxl+b4a2LziGE=;
  b=OXIu4vNS571FsZN2TXXN6FhHXbuf8UxvDZw9b6uHDpozaDpcEA3RZzsN
   h93xzsVO5ZB6aA3Bs+fCZw9w5O+9Wrj02mS6OthPKXWNGhzBX+DQzvzAQ
   hVhcwFrpEctWLALAOpwNdtYCSDCX4lCoEtX69+iqPrAHFOPDuoaMHRN+E
   dL2iE+s/eh4GajOj7hO/a/CyGpqNAckl5k2kn5bfPIIOLoa/BMA4KTaLm
   /QWZ2oGwDB34c1KRL/38qTfK2DIZ3MnaD4pYnFuwd8liEAb2lkGOJ3yO8
   GioOdIgqbgi0tSQU+ang4xFiTM8FgWTqgZSPWUw+iScPyIsiwSTDR2xAq
   g==;
X-CSE-ConnectionGUID: ztTSvwIHTkiHC95N2gR0bQ==
X-CSE-MsgGUID: gbEXpwu6T9qberzB4sJNvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22645988"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22645988"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:56:19 -0700
X-CSE-ConnectionGUID: jgCS9kbxSJylIZIAvlNa+A==
X-CSE-MsgGUID: yb132zZyT0+QDApjTmFsLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66422828"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 08:56:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Aug 2024 18:56:14 +0300 (EEST)
To: Gergo Koteles <soyer@irl.hu>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: lenovo-ymc: Ignore the 0x0 state
In-Reply-To: <08ab73bb74c4ad448409f2ce707b1148874a05ce.1724340562.git.soyer@irl.hu>
Message-ID: <4da8fe7a-8889-e9df-67b8-5d02c027fc42@linux.intel.com>
References: <08ab73bb74c4ad448409f2ce707b1148874a05ce.1724340562.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

A quick comment as I failed to understand your commit message.

On Thu, 22 Aug 2024, Gergo Koteles wrote:

> While booting, Lenovo 14ARB7 reports 'lenovo-ymc: Unknown key 0 pressed'
> warning. Because lenovo_ymc_probe() calls lenovo_ymc_notify() and that
> time the YMC part is not triggered yet

This sentence should be rephrased as is it doesn't seem to make sense.
Or is the . before it in wrong place and should be removed?

> (which is mandatory for this
> model).

If the latter of the options above is the right one, I cannot connect the 
meaning of this parenthesis part with the full sentence. That is, what is 
mandatory in that case? So you might have to rephrase it as well.

> At the end of lenovo_ymc_notify() YMC is triggered by the
> ideapad-laptop driver and then lenovo_ymc_notify() will be called by WMI
> to report the actual value.

--
 i.

> 
> Add 0x0 YMC state to the sparse keymap to ignore.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  drivers/platform/x86/lenovo-ymc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
> index e0bbd6a14a89..bd9f95404c7c 100644
> --- a/drivers/platform/x86/lenovo-ymc.c
> +++ b/drivers/platform/x86/lenovo-ymc.c
> @@ -43,6 +43,8 @@ struct lenovo_ymc_private {
>  };
>  
>  static const struct key_entry lenovo_ymc_keymap[] = {
> +	/* Ignore the uninitialized state */
> +	{ KE_IGNORE, 0x00 },
>  	/* Laptop */
>  	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
>  	/* Tablet */
> 


