Return-Path: <linux-kernel+bounces-286302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A1951957
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628D61C215B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125ED1AE04A;
	Wed, 14 Aug 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyzjhCm7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB60137772;
	Wed, 14 Aug 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632485; cv=none; b=XFHuQbi8XatbBeswbVOEOToGCWWiox3rvh7CpvkDbskvdyD8dbphPEuyWVvdq+7nu2c5fVt58vT0NgqxPgR7YJoRq865fBjioL88lmYkJSDoaNcK2SxVWDqnJzpieKLuTBd6hIRDOHezK6LTuchQupnMrqguTNqF+DZmBW4LxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632485; c=relaxed/simple;
	bh=ed9PSRbjdBoJE6YSK0h5LMqBoewJ/LBav9/nx1+yJ2Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JhsrnhGhJ9kv9aJyuMfIOA2XKQS1dnY/JaPbx3neN4gg2+ehso2DtbVmti+R0hH0hRLtajQiO+xK2z/haKpkI4UFbEAgk0YIaXiZwDo0SkVccP9qEJP4WAzeuV88os3aPTddyvuEhns7PYs4+yhodW0Tj2ILE39Mmn8y0iChlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyzjhCm7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723632484; x=1755168484;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ed9PSRbjdBoJE6YSK0h5LMqBoewJ/LBav9/nx1+yJ2Y=;
  b=NyzjhCm7ZthZEdC/jcUtM4U6K2gcvDdz541Zk8BknqnRKEnJYI1yc+/b
   8FtTRs8J/yfMq/MWKhvx+U18HArw4Ppx1Lzhc+FaH+kZV2xHcvdKVi1vm
   zOfroZgbekGCu8hh083yV6ScFpztOoQuVSNv4POI1jEUt4p3v+AfD1llh
   fBKZzzRlab8CmMVpKXdV34Qn/zX6J6IvZH+PVLGIr3tFimd1TRgskPvuF
   doqHbHkYahs2QA5P19Z4sSPJ8+hAIVXEx7Yz/7WKs7LpEnYlZXRG/QsQT
   C7isGITcckRqho8dPM+sOtgDIrSwIAHDITx1tLwNILDRFTUCys7ris4xW
   Q==;
X-CSE-ConnectionGUID: CxR+xo0BTK2rKoL4ehj2Zg==
X-CSE-MsgGUID: ONERSYX/T1yynrvacWId+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32515017"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="32515017"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:48:03 -0700
X-CSE-ConnectionGUID: CbWaKToYQuG+HQh3iuo0hg==
X-CSE-MsgGUID: +41xfZaFRem5rC0SrJQpCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="58853322"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:48:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Aug 2024 13:47:56 +0300 (EEST)
To: Matthias Fetzer <kontakt@matthias-fetzer.de>
cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
    ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531
 fan support
In-Reply-To: <20240813212403.92245-1-kontakt@matthias-fetzer.de>
Message-ID: <e4e32316-509c-28c6-fd18-38ed17e9e35a@linux.intel.com>
References: <187b6058-c41a-4767-af47-ba35451f2049@redhat.com> <20240813212403.92245-1-kontakt@matthias-fetzer.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 13 Aug 2024, Matthias Fetzer wrote:

> Fan control on the E531 is done using the ACPI methods FANG and
> FANW. The correct parameters and register values were found by
> analyzing EC firmware as well as DSDT. This has been tested on
> my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).
> 
> Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>
> ---

In general, you should have the patch history/changelog here below --- 
line (what you changed with different versions of the patch so reviewers 
don't have to guess).

> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 397b409064c9..31e5de21753f 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c

> @@ -8157,6 +8213,7 @@ static int fan2_get_speed(unsigned int *speed)
>  
>  static int fan_set_level(int level)
>  {
> +	int rc;

Please, add newline here as required by the normal coding style.

>  	if (!fan_control_allowed)
>  		return -EPERM;
>  

> @@ -8915,6 +9061,20 @@ static int fan_read(struct seq_file *m)
>  			       str_enabled_disabled(status), status);
>  		break;
>  
> +	case TPACPI_FAN_RD_ACPI_FANG:
> +		/* E531 */
> +		rc = fan_get_status_safe(&status);
> +		if (rc)
> +			return rc;
> +
> +		seq_printf(m, "status:\t\t%s\n", str_enabled_disabled(status));
> +
> +		rc = fan_get_speed(&speed);
> +		if (rc < 0)
> +			return rc;
> +		seq_printf(m, "speed:\t\t%d\n", speed);

Hmm, first of all, this should use %u because speed is unsigned int. But 
to find that out, I looked into that function and realized this is 100% 
duplicate of the first part of the case below it, no?

...And that case code block already has additional if for 
fan_status_access_mode specific handling so why not just change the else 
-> else if (fan_status_access_mode == TPACPI_FAN_RD_TPEC) instead of
adding all this code duplication?

(I know that other case block uses incorrectly %d when printing speed 
which you can fix if you want but please make another patch out of it,
don't mix it with this hw support add patch).

> +		break;
> +
>  	case TPACPI_FAN_RD_TPEC_NS:
>  	case TPACPI_FAN_RD_TPEC:
>  		/* all except 570, 600e/x, 770e, 770x */
> 

-- 
 i.



