Return-Path: <linux-kernel+bounces-565586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F02AA66B42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688C97AA254
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FFF1E5211;
	Tue, 18 Mar 2025 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2fvfv1v"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349981E520F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742281799; cv=none; b=aSbz31zUc7u4HxGKuahLpDRO3xldDojQSj+9YZPDTQRonN3UUG7jLXI1shQXrZko4SOoFHJ1H8BLfUfGdKgDLjO0RnCfp0b5TxVsDe3VlLaiQWXSK1TO6M97r37ORnoeDyRWXaBfEJKJXkjDjYOwHFDXIeksLpyL3qP4sDvVBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742281799; c=relaxed/simple;
	bh=9cwqudxnQKmzlwlTHiS/dtzIcq74/7PSmfkkNdqLQlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDvsmn0brjYOi7dzTtMvfWRJJv5Wn2XGMJa9u/QFsr322kHaJ4utFTqNu8LnlD6KYFXJgJtJzjB5v/hFjcAggteK5nNxkZx6xjjh0nKdz/wybvRrArkQFzlSKEPaJZJLTzaDZrtoCUJU3h/87jN1VAgA8pKG8ROuQvA9PM+mWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2fvfv1v; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso30906195e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742281796; x=1742886596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pX1FLmGF0QpaVz+3C9gkeV+HuMIyKRUJE6MVHoPVhA=;
        b=t2fvfv1vL0LY/m1vj1DUfzrFnTW6uaDjl5IpMyZt9tsy+68XRsdcy64D/X/93owmto
         wUFZyulTchphJoMgv/8Uy6JYGzLwpjZC0Dy40nBCVhcibYU15PFPLUl8+gKgZmmmbdmv
         OYZBgpbQe8jJjVMBnsMOsm4J6uS12JIaro5VBXyHaBU01Ciy6LZ25ygo8Q2jNI48GdP1
         Rny/VF4axtWMiNABsgp120KIrCjhEDJVkhk0aIW+pqV5Tt8AMtNq1wVrofedQX2FBpUw
         rJQpPA7rtMDA/jmOPpd7cgZlL+SdYdtwFUAh2z/tFRNDM4oswNAEtDKZN/1tnvsLAxq/
         fh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742281796; x=1742886596;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pX1FLmGF0QpaVz+3C9gkeV+HuMIyKRUJE6MVHoPVhA=;
        b=nJpd06wSMU5XyS9UdGuWltmldoJkZR2wFHh6Tb6CnEGa3BBVQLHqciCssLlVilB1KN
         bCJV1SGEDlt9mm7sU8Q6XRBsSgidGWb9y4Uo/Y0Fw85JCDtp3wXf2O2qSQcxBhzxfNn7
         85+96jSnDydQFgIy7ZqbozSMmnn78vVIepUeAfNuofy79RBaDHXU5/A8XdfNl370T5yo
         p1faidhzDx0X0ojGvHPPv2rnrdFp1bgBCbt2tL5x+TXfLtKObwyHpjSPrV+Gn62UGEO+
         hFGbNewOpLF0ap65Qh9C85Ue+MSppG2mFe6QNtGAd2FYT6/2Kjd6Ky8DAZ7hHD2WX61j
         Djkg==
X-Forwarded-Encrypted: i=1; AJvYcCW5VOpqBugmsk48luoAQJ019U0aJAbiZ7mJnHKYqHYeIlkZWC30dgLNd6+JO4QsExPOoglotUZ7zIsV/UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZx1NloXoDr2Q5rOQNAfZ4SjCXu0sAnbTcOnkLau12nXFgIv9
	1cdqvKGgZ2My0VnaJURgtdHow9hvY4XRVvoSNCaFMQKw0E45ZYC2bz+1SGm5yro=
X-Gm-Gg: ASbGncuFqEMMuE9JiYuc1ZOyDpso4W6xNvBlRrQKOihMYocUFbLsUeTWuxdkhlgaAqs
	xg+JXBuoHomiB+tJqra+tQ0eO1pAIP+mVHBoKY8fSfiV7nnRVVh33eQDcETd99H09zZFIJInHWf
	UIu/haxXxqWMtdK+n1iOCFlrBzCyuQMR6tv403PRbJmdt0SBTcCGsr25p+v5RbYq+iNvbTTPLO5
	8Eq4lhKqd/cODwumaiNJ+NiioJ2wJS/Bge/ND3uGfk9IjkVsKKsj1N62v1wD5vDnW7NklXobgMR
	X7tdIfFNkwtHhsSI9UlIArmDm3Gn2xebQhITmqCUe1DE1sb+AcBw9g==
X-Google-Smtp-Source: AGHT+IGa8J4JxzKKGh0/XPpOyesw3o5rqSQlTd10QJ3OEEApVDmd/NM7aAXGbyEgafvjSSRXvrYOow==
X-Received: by 2002:a05:600c:450d:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43d3b9b2b2bmr7662605e9.18.1742281796357;
        Tue, 18 Mar 2025 00:09:56 -0700 (PDT)
Received: from [192.168.0.62] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc3ee7sm125566505e9.19.2025.03.18.00.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 00:09:55 -0700 (PDT)
Message-ID: <4be8afd5-65a9-4cfa-89b5-42caea3a9f93@linaro.org>
Date: Tue, 18 Mar 2025 09:09:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: add lock flags for GD25Q128/256
 and GD25LQ128D
To: Jakub Czapiga <czapiga@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250317182047.2060036-1-czapiga@google.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20250317182047.2060036-1-czapiga@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.03.2025 20:20, Jakub Czapiga wrote:
> Set appropriate FLASH lock feature flags.
> Set top-bottom protection configuration bit flags.
> 
> Modified chips:
> - GD25Q128 (+lock, +tb)
> - GD25Q256 (+lock)
> - GD25Q256D, GD25Q256E (+tb)
> - GD25LQ128D (+lock, +tb)
> 
> Signed-off-by: Jakub Czapiga <czapiga@google.com>
> ---
>  drivers/mtd/spi-nor/gigadevice.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
> index ef1edd0add70..8eec6557b036 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -16,6 +16,7 @@ gd25q256_post_bfpt(struct spi_nor *nor,
>  	/*
>  	 * GD25Q256C supports the first version of JESD216 which does not define
>  	 * the Quad Enable methods. Overwrite the default Quad Enable method.
> +	 * Otherwise set TB to SR(6).
>  	 *
>  	 * GD25Q256 GENERATION | SFDP MAJOR VERSION | SFDP MINOR VERSION
>  	 *      GD25Q256C      | SFDP_JESD216_MAJOR | SFDP_JESD216_MINOR
> @@ -25,6 +26,8 @@ gd25q256_post_bfpt(struct spi_nor *nor,
>  	if (bfpt_header->major == SFDP_JESD216_MAJOR &&
>  	    bfpt_header->minor == SFDP_JESD216_MINOR)
>  		nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
> +	else
> +		nor->flags |= SNOR_F_HAS_SR_TB | SNOR_F_HAS_SR_TB_BIT6;

why do you tie locking by SFDP absence?

