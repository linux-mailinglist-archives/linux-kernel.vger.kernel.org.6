Return-Path: <linux-kernel+bounces-388392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E949B5F05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D3DB21CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D01E2314;
	Wed, 30 Oct 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrcTSY4P"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75C1E22ED
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281156; cv=none; b=Dfm5LE7i6MeKsxBFLdfu/YCMQNmsn3pfmTXC+hphWonGcHXzs5mpBPS6yRPGcUyQ+Cl3ozjVkYWbPWFABjNICyT68Ja6S6aDjD/To6qnCAI1EF0k1FK8qp/DV15tt7qOMFHQXgvo8CAsJ/GHoeiYfJWi/VNQO58TOq5DnoYxvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281156; c=relaxed/simple;
	bh=gExNcjrUtvag1nDOnOiDLd7cvI4wjdQFmT0fqwMb11A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4yoXy3NYe7X0rvdNivchJweTm7nOHERDDMcO2imZ3HK/ELWWS3RPlgSCcpN/uhWOicQY3S4MIAQzzgFiebQERcJnnAE+azaFOjVxCp6DGoKna5kMACWmaYcy4/lMDvzJ0sJwdMipuNqOX2FpgIWCJZvLkPSaLfYHPiBzWRC7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hrcTSY4P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43169902057so59808595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730281152; x=1730885952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gExNcjrUtvag1nDOnOiDLd7cvI4wjdQFmT0fqwMb11A=;
        b=hrcTSY4P0PsxcOUusUi/CL6E//NGAce1CbDjPrQIjROhXQ2FL9WPCLRNiUK9lkp1xi
         ZJ6M9pDLtAeeJxwE4H2ONZeaK0LjriLWHFKpk7L2rvSjYUhYb19PkzP7+5ipllozolKU
         wU2/7h6HQrXRIXyF2qrWSMOijWeyENbtMjndskfwByOOEh2/QsGiEk6J0tGNciatYjh0
         DOGleFq3eIGYYGSc5V8MgPawUAr7Rkumsw7peggkFuNA6gzqtNXIJYdZRpz4AcE3xk3L
         LqVzPJEwpCqadtuCoe4V6iqtqqsWcEpx901Fvt6YtMPOuCbCKwrxePuaKlpw6Nv7GPVS
         LgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281152; x=1730885952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gExNcjrUtvag1nDOnOiDLd7cvI4wjdQFmT0fqwMb11A=;
        b=NT8urB/C5fdl9dyNxyRHbaOiSr13dGz9E4W/KV1xql1f7DwMptjyCgA/y15VT60y68
         +VI+QCLmX/dMSVRdn2XsBcwp88r399SmTCtlXJ4JC0XR2t3dUBjG8tHch50qw0zBTu5r
         YxpiqqdE7OYonUz22xr0+ZamSgNYnSAvj2g0F9vxrQp1r1CBrAE0wICEyuPZyoZgy1QG
         W0W93YyJlEUsI2RACeVozYMdplNAj6dYE3oJc/RHuUeTqW0oDwbHrtGm7PJ8ZaIBeulx
         96rotGMAK/kB7Ze9COwVEmCeCRbZFjCqWW+EY4ub5alLk1dcK4ubYCydlAeCygsXSWIQ
         m71w==
X-Forwarded-Encrypted: i=1; AJvYcCUvn1c73mCJ4uRirtU9hFtnIhLDfdYkIooJAzxEjv76ytg0fLa6fsBblgfsP2UV2scL5Imbnz8bYyTJ47c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2I8uDc2o9N63DOxfxQQvrP6FXjYQxWmsiXC9VmEOxrmx570kG
	NtD0XRcV7xNgf6f2U8cgFcHx5aAQeDCAxV5S+RQzkKsnSEas6dFqU9SFe8ovmTY=
X-Google-Smtp-Source: AGHT+IE32/QWwJxt5SXFpIYLSDpj6WX3oAgieA0BND3K1CgVJXvPCDBSisVF5SvFS5ZZDNzolgjR8w==
X-Received: by 2002:adf:ec4f:0:b0:374:c614:73df with SMTP id ffacd0b85a97d-381b710f3f4mr1868603f8f.57.1730281152021;
        Wed, 30 Oct 2024 02:39:12 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c44sm14816858f8f.80.2024.10.30.02.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 02:39:11 -0700 (PDT)
Message-ID: <430e6dfd-4a7d-44d9-9dd6-64d99c8bc91e@linaro.org>
Date: Wed, 30 Oct 2024 09:39:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] scsi: ufs: exynos: remove tx_dif_p_nsec from
 exynosauto_ufs_drv_init()
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-7-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025131442.112862-7-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:14 PM, Peter Griffin wrote:
> Firstly exynosauto sets EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR so setting

exynosauto and gs101, the users of exynosauto_ufs_drv_init().

> tx_dif_p_nsec has no effect.

Both set EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR, the conclusion is correct
for gs101 as well.

With this addressed:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

nitpick/personal preference: I wouldn't use the commit body as a
continuation of the subject. I would specify what the commit does in the
body as well. No need to address.

Also, as a side note, I thought of removing tx_dif_p_nsec from
exynos7_uic_attr, but it seems that this struct is used by
exynos_ufs_drvs as well, which don't set
EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR. That's a little confusing, I guess
it's more clear if each driver has its own required settings specified.

