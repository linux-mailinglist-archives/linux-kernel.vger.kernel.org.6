Return-Path: <linux-kernel+bounces-565551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C4A66A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D73517ACE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33F14EC62;
	Tue, 18 Mar 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqJmK8i7"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA696FBF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279462; cv=none; b=YdEotq8aCFrBCKNyJp6zQwn4F530x4r/cRlbCblVaKvp8OVwqRjNv1zmkD8hVq+xRSdHmGCQGUHng0tAGG7VYftJl2iWL1SopzRmLrDSNupux36qzLunXVu28MVG750JNDkX7u1gTflbcNgYl03r2mcNjMnPw6wkuKnBwdSvp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279462; c=relaxed/simple;
	bh=sWRavboZOPMDQYy8rO56oVINpm5jyxeLBzt/P7E6CvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CywIptuQt1uCId97SEAJrcnRIPmScNznPApgvEcvnF4sSsV2/aMhz7O47pEgvk084YLeerC1sG59bzD7fj0Xja+1mgIQ9gHb7QWP/t1GHROb/19na+/MlLY3zwkC4zzUIybw28BUbpe7YWSKsvoP1rDacIryFVkUsG1a45hZ+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bqJmK8i7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso3922927f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742279459; x=1742884259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXsRVC7+O52roT2qjifznXtTujlYjDhziLvEJ4ugGCE=;
        b=bqJmK8i772wyv/WLYg4t107Bs8+7OQUhf2LWAx2R2SevjcGOGK/IwXlvlvC1VSc4x+
         gupjeDbt7D13FOBTEjmFG8dl61vlnUp4DctIvq3l/9efp5sDoBFXPJRXqXtHryAdKl5k
         +yC2BURlPeTDEEZqoo1ToY9EYlG4dQTEs1lOC9An3gnPzHT9oxwkx8lFUy0gATGNjcF7
         6/mJExt3EEg0xzUorqF5YhgDEAklXomkuQrj8rRpSZx7yJWoMcubT4hvxDtK3difdd9v
         jI8dpAOiL1z1lstL/dRIpFC0my0Mc4Md32jvbRccs0I2Dd3zRIPUCwp3czs6WMInhNx1
         A09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742279459; x=1742884259;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXsRVC7+O52roT2qjifznXtTujlYjDhziLvEJ4ugGCE=;
        b=uAJ4/K9yALtUQkXMp5u6ODqhjWV0V6zop96VtO7IUNmQnG6Wq8uO2KIEtLFxz3SVAO
         pnOaJDaCQ6+XMOaZxnL05Nf7LTbvMW7bI06xi+6Ne/GZNEJgDSAzWcsQnnuRll6IQanv
         a5Wo6mbqAZ/chrMeEw4nwGMdOFm5s9jrQ05pwZ03jMH5tG37QxOBXu1GX5RqoiHUpmp2
         a7BDgv0YAyEbXWtKKoBEuVBH1WI/kE02d/w2BiAYkv3NPHBK/VHQ86eb4dfmAIs6q9AI
         YzwHMsj3fd6ZVtIsABnmx1Sw1NtEPtox1awZPhZYS1VjIA0IPP42J+2zROHPbRmzHckN
         kT9g==
X-Forwarded-Encrypted: i=1; AJvYcCX2HVzhBjshgaecfx/LjC/naMFidEXqYc+5vCbfYrGwjgyzoDpgRs5SVWcaQvzsKiUcAb0fFNjeLAPQl5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8MH+DmvP/3oc6YS/r08KABsf4gueSKtgt+zyGq95fFWejcae
	pfFOLZrjpZbL17gwo0mPcoppEe3YaXqm/0c/gv5BO0rTHKxKL0ZOgpK3r5pEuBg=
X-Gm-Gg: ASbGncufAIPcQcGMQCEh3Zw9TX3hK6dHWO2CknmGM9lTyO2kBMsxzvMKgt7ejQmHt/k
	hMAePWHsZvCkHIZ+J0dQqY60LVraPOC+0wMl5rKR2LtF41FOhfA6PbIq+6SYAEYoCR3Jo1oohFi
	tzm8qn2Bo1lfdJnYavj84IyQPevq+8d/+wva6nUZlmc2jvlnznFxqxoGoudWX0pl9yHT+wOVH3E
	i+q1NPSE36DvdKCNhIuuRSLBdKJfDbojd6jX6+/yzh6LtP8Y4jai/FeApG15xkSYrbfAwo7KYR7
	a2ocndOY6rjZvSKwY3f7HIWSRVLnyRa6OWHd7MEFbdq7EQVU2Fk/Hw==
X-Google-Smtp-Source: AGHT+IEvxvjjCIFKWh3dRxXm3eYkJA+qlr6RAryA7+n3CuEq0jX4K981fmJidDv6Ey2as6qSMTEnOQ==
X-Received: by 2002:a05:6000:2ce:b0:391:bc8:564a with SMTP id ffacd0b85a97d-3996bb7747dmr1627926f8f.22.1742279459362;
        Mon, 17 Mar 2025 23:30:59 -0700 (PDT)
Received: from [192.168.0.62] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16752377f8f.26.2025.03.17.23.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 23:30:58 -0700 (PDT)
Message-ID: <b3065eda-e224-48e5-a5fe-2d5c8f4e5b6c@linaro.org>
Date: Tue, 18 Mar 2025 08:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: macronix: add MX77U25650F, MX77U25655F and
 MX77U51250F
To: Jakub Czapiga <czapiga@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250317182058.2060277-1-czapiga@google.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20250317182058.2060277-1-czapiga@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.03.2025 20:20, Jakub Czapiga wrote:
> MX77U25650F and MX77U25655F are 256Mbit chips with SFDP and block
> protection support. MX77U51250F is 512Mbit chip with SFDP and block
> protection support.
> All chips also support top-bottom lock configuration, however this bit
> is SR2(3) and is also OTP (defaults to top). Due to lack of API to
> support TB in SR2(3) and due to it being OTP these chips will only
> support top blocks protection.
> 
> Signed-off-by: Jakub Czapiga <czapiga@google.com>
> ---
>  drivers/mtd/spi-nor/macronix.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 99936fd25d43..c65e7cdab5cf 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -193,7 +193,22 @@ static const struct flash_info macronix_nor_parts[] = {
>  		.name = "mx25l3255e",
>  		.size = SZ_4M,
>  		.no_sfdp_flags = SECT_4K,
> -	},
> +	}, {
> +		.id = SNOR_ID(0xc2, 0x75, 0x39),
> +		.name = "mx77u25650f",
> +		.size = SZ_32M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
> +	}, {
> +		.id = SNOR_ID(0xc2, 0x76, 0x39),
> +		.name = "mx77u25655f",
> +		.size = SZ_32M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
> +	}, {
> +		.id = SNOR_ID(0xc2, 0x75, 0x3a),
> +		.name = "mx77u51250f",
> +		.size = SZ_64M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,

drop name and size, add name as a comment and do the tests for the next
version.
> +	}
>  	/*
>  	 * This spares us of adding new flash entries for flashes that can be
>  	 * initialized solely based on the SFDP data, but still need the

