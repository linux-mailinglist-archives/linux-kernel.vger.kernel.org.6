Return-Path: <linux-kernel+bounces-417228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772569D50F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EC6284D90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA91A0BD7;
	Thu, 21 Nov 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXc45Td3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968EC198A3F;
	Thu, 21 Nov 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207744; cv=none; b=Yidqbh7YdfcymAmnIVpI2iejebLEyPMFYhsjpjCWu9i3YJ1GDZsV+bKMEQG4usdjfW2i2DjckQOfQDRHgw3qB0jqom9Jp4zPTRdmggVf/e7pyj0OoSozexTjPaP6NK8/lABr5OS6BhfcnloaONZDR2aVujl64tyAu/hB8X+eO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207744; c=relaxed/simple;
	bh=8TnNgT9BSGeNnV9Q4psaEUNm1Db9V2po/4TACtO0ZMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXYXUGAnPJ5hLhAp/YEzUOyTGGRLQMT44M1Bx8072nJ/cofdyTB7q8HVGiKPRG0VtQJj8osaHXLLg+7ux8H163w7x0MhFSjq9xna0WPapkwTst5VugWhTqul8wmfK+7wZh4Se2vwUgocvCCScqOb1pc0kl0JFaAzBgnQtjgc3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXc45Td3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732207743; x=1763743743;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8TnNgT9BSGeNnV9Q4psaEUNm1Db9V2po/4TACtO0ZMo=;
  b=mXc45Td3ZBuw+cbXgyrpbI7W/0AYbqHK7ucUYhikjkvEGzwKQwL3uINn
   hkSQRoDiW98c+cO+qZwPFTn5Kl3EC+LeaXYBus6bVGDyWQ8ejfDibxG8y
   qXZnElG472uQmX+WfYcj22/81YerxqlrCwYt9R8hO/13rndtz7n6UaOjo
   IZjTekQ6Fa8x8T58qS3KWVXjxar7E0PQAmo2Aoxwm2lmVQVHB7O5fUWyl
   Fu3GcpaguUJQTDHv+dFHBSjDIlj9mTZWHO5xGrgda7rn4h9vKcF8exV3c
   k3vQgJXQ9pNcxLlj8xl1UmBSeqpEO5qdoTHHoDL5Sivsi0p+CKTSI/mly
   w==;
X-CSE-ConnectionGUID: jyAn31n9TvioGUb5FIMvpQ==
X-CSE-MsgGUID: up+klhdAS4m3d65mA7vKVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43730767"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43730767"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:49:02 -0800
X-CSE-ConnectionGUID: Rujrdt0hTzqYMp2r60LyPA==
X-CSE-MsgGUID: lgl1DRxOR3CLJ7GljqRlqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90431340"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.229])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:49:02 -0800
Message-ID: <56b6520093f5a0aca6738d2114c5ae08db2660fa.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Fix the wrong
 format specifier
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: liujing <liujing@cmss.chinamobile.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2024 08:49:01 -0800
In-Reply-To: <20241121130028.6259-1-liujing@cmss.chinamobile.com>
References: <20241121130028.6259-1-liujing@cmss.chinamobile.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-21 at 21:00 +0800, liujing wrote:
> Because clos_config->clos_min and clos_config->clos_max
> are unsigned int types, the output format should be %u.
>=20
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

You need to have for your tag:

Full Name <email address>

Thanks,
Srinivas

>=20
> diff --git a/tools/power/x86/intel-speed-select/isst-display.c
> b/tools/power/x86/intel-speed-select/isst-display.c
> index 07ebd08f3202..5ecf24bda6dd 100644
> --- a/tools/power/x86/intel-speed-select/isst-display.c
> +++ b/tools/power/x86/intel-speed-select/isst-display.c
> @@ -617,14 +617,14 @@ void isst_clos_display_information(struct
> isst_id *id, FILE *outf, int clos,
> =C2=A0	format_and_print(outf, level + 2, header, value);
> =C2=A0
> =C2=A0	snprintf(header, sizeof(header), "clos-min");
> -	snprintf(value, sizeof(value), "%d MHz", clos_config-
> >clos_min * isst_get_disp_freq_multiplier());
> +	snprintf(value, sizeof(value), "%u MHz", clos_config-
> >clos_min * isst_get_disp_freq_multiplier());
> =C2=A0	format_and_print(outf, level + 2, header, value);
> =C2=A0
> =C2=A0	snprintf(header, sizeof(header), "clos-max");
> =C2=A0	if ((clos_config->clos_max *
> isst_get_disp_freq_multiplier()) =3D=3D 25500)
> =C2=A0		snprintf(value, sizeof(value), "Max Turbo
> frequency");
> =C2=A0	else
> -		snprintf(value, sizeof(value), "%d MHz",
> clos_config->clos_max * isst_get_disp_freq_multiplier());
> +		snprintf(value, sizeof(value), "%u MHz",
> clos_config->clos_max * isst_get_disp_freq_multiplier());
> =C2=A0	format_and_print(outf, level + 2, header, value);
> =C2=A0
> =C2=A0	snprintf(header, sizeof(header), "clos-desired");


