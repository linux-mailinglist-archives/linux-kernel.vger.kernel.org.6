Return-Path: <linux-kernel+bounces-358176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73DF997B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8DF1F23272
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67014293;
	Thu, 10 Oct 2024 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHHb6XuD"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA718E02D;
	Thu, 10 Oct 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529590; cv=none; b=duscsPs+DbS/zz5wMQyf66FXSgyDfUGaRTxWLXLVgWJc3fuuGUFYCTxLBkmnnmJ1TQigbU7R34Qu6HPwzSzHiMN85z99cr600lEA6l9GA1P+f5HB3KIoRIKdt7Esg/WMX5LZ8KZu08h5+undxIlp12Np4jfyy+vazPLQ8BP3esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529590; c=relaxed/simple;
	bh=6Dm3mrwwOt+/YGSsRNsgDFHyQmDUOxNDIGoiEwlaCtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxVDNGHO5KrQ6FH/3KYmwJXCrd6hJWG9GeRVS6ypCoaJwGSOjUbLSLnahgBaHyNTUjdXL7VRWOOTaUe9zAQFkvNotUkp/W9ZW0IjJaq6Ovk51+wsL7kQiag4CEn0LdpzMzyI//Q/bxkT7dwJkqTpczygQ4iQTgJHyOO5pD5TD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHHb6XuD; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093997dffdso156542a34.2;
        Wed, 09 Oct 2024 20:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728529586; x=1729134386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0S9i0QsKrTEFXoLHFccDF34hrvX9l0HAkJSbDJmtsuk=;
        b=fHHb6XuDk2cfFkuB3avr2mzXAmRbYIdn/QuQrbpViA5sfVFY7ssOLbpFkI5y9msYe6
         P53s5gXnTPAQW3zddBIVhMqOuFM4XpnijZr196TuT3R7kIoUlG3EpEIj+MhNH9Zb82nJ
         R37u9q1kMcO/HHiqXrroBedu1IzhMNvlNbG6pgVYF7rAgOWcC0bUj7YpeBXngXNOxpqS
         ERjN8dX6rmmoNbFDLhBXruMgfowyWxlndFG2B1zbuVzdaqb8tEpeYZ4+i54J+lv0UXpc
         7pcf1IkHW9YlDzBELBf45AnjForMV06O8iPfCv4+Ho0fL4DuwtMhMSEEUnsZvTnS5DBx
         vtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728529586; x=1729134386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0S9i0QsKrTEFXoLHFccDF34hrvX9l0HAkJSbDJmtsuk=;
        b=wTxs805Dx2pbOIUNzdu5/TCLgzadHTcvthqJu2lEg1vhV7qeTEkXDZoWCeVQO0AEGY
         RisjfCy/lHcoCWed8+itJGHl9GV0y+8jFqNwXPYulHte6llqA9EZbBSMjTb3vVZjIfNS
         LzjDZTmgtng0CBRLaixO16hdq7ykuV/CwW9mt0k0n1x7x2OzrCSGmAAz14fBr8ffF2F8
         Re6jpbLqYA/UCv+p3oWAo+IJmvcp0k+Cvl/H5NsnJ5xVY38OBE2f0ih01HcHjZIU/yKm
         NVBgtFUxZtTuUS3SmV30vgEmwHCbzyt68pKuNG1uAoCOU2chXU6dMY0TgCo1OjdWE8T9
         D73A==
X-Forwarded-Encrypted: i=1; AJvYcCV44vch2z8zXChIBl6PC3tvv4yd36cV+WJ2iM1JSCCzSFiu8vWUB1Mr7KZRr0m86wxHNjCTHbSxeV/OJLo=@vger.kernel.org, AJvYcCVmFp/o+jcXJCGi7/MndhkC6EOw0hx4YRUBLg0Nv+SWXMvsWYxw4a3XkryrMLqnvpeujrao4usT51QRs/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+jVsDABfCQ2CpGHSM2TambG0H5VsC3OA7ttBTI3E1J5jk7RGS
	wCQyr2tm9spIRAaUDaBlMfoKJFm+RLcnAh6Bznn9oJF5kGq0n9kc
X-Google-Smtp-Source: AGHT+IENQKCoupa70Rsc818NrmBzIViwc1MsXFBDTbFtlqmHkomz1zji8Ovv17zTYRXXBs8loHJsUg==
X-Received: by 2002:a05:6830:349e:b0:715:5494:5d34 with SMTP id 46e09a7af769-716a421dd6fmr3309545a34.20.1728529586370;
        Wed, 09 Oct 2024 20:06:26 -0700 (PDT)
Received: from ?IPV6:2603:8080:1400:9f00:1ac8:ba3e:b226:eb6a? ([2603:8080:1400:9f00:1ac8:ba3e:b226:eb6a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717d0035698sm47835a34.76.2024.10.09.20.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 20:06:25 -0700 (PDT)
Message-ID: <d1941b10-0549-4a0e-a3fe-a8d7c50c175b@gmail.com>
Date: Wed, 9 Oct 2024 22:06:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Upload dsp firmware for ASUS laptop 1EB30 & 1EB31 and
 Update WHENCE for both
To: Shenghao Ding <shenghao-ding@ti.com>, linux-firmware@kernel.org
Cc: baojun.xu@ti.com, derekjohn.clark@gmail.com, 13916275206@139.com,
 romangg@manjaro.org, linux-sound@vger.kernel.org, robinchen@ti.com,
 linux-kernel@vger.kernel.org, k-yi@ti.com, navada@ti.com, philm@manjaro.org,
 jlobue10@gmail.com, luke@ljones.dev, antheas.dk@gmail.com
References: <20241009101807.1473-1-shenghao-ding@ti.com>
Content-Language: en-US
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <20241009101807.1473-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/24 05:18, Shenghao Ding wrote:
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> ---
>   WHENCE                     |   4 ++++
>   ti/tas2781/TAS2XXX2234.bin | Bin
>   2 files changed, 4 insertions(+)
>   mode change 100644 => 100755 ti/tas2781/TAS2XXX2234.bin
> 
> diff --git a/WHENCE b/WHENCE
> index a9c8bb5..00096eb 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -7487,6 +7487,8 @@ Originates from https://git.codelinaro.org/linaro/qcomlt/audioreach-topology.git
>   --------------------------------------------------------------------------
>   
>   Driver: ti-tas2781 - tas2781 firmware
> +File: ti/tas2781/TAS2XXX1EB30.bin
> +File: ti/tas2781/TAS2XXX1EB31.bin
>   File: ti/tas2781/TAS2XXX2234.bin
>   File: ti/tas2781/TAS2XXX387D.bin
>   File: ti/tas2781/TAS2XXX387E.bin
> @@ -7516,6 +7518,8 @@ File: ti/tas2781/TAS2XXX38DF.bin
>   File: ti/tas2781/TAS2XXX38E0.bin
>   File: ti/tas2781/TIAS2781RCA2.bin
>   File: ti/tas2781/TIAS2781RCA4.bin
> +Link: TAS2XXX1EB30.bin -> ti/tas2781/TAS2XXX1EB30.bin
> +Link: TAS2XXX1EB31.bin -> ti/tas2781/TAS2XXX1EB31.bin
>   Link: TAS2XXX2234.bin -> ti/tas2781/TAS2XXX2234.bin
>   Link: TAS2XXX387D.bin -> ti/tas2781/TAS2XXX387D.bin
>   Link: TAS2XXX387E.bin -> ti/tas2781/TAS2XXX387E.bin
> diff --git a/ti/tas2781/TAS2XXX2234.bin b/ti/tas2781/TAS2XXX2234.bin
> old mode 100644
> new mode 100755

Hello,

I tried to process this into a MR on Gitlab and it failed CI.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/311

Please run 'make check' before submitting.

Thanks,

