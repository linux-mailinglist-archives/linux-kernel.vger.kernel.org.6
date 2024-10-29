Return-Path: <linux-kernel+bounces-386362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD089B426F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575A11C21C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9EE2010E4;
	Tue, 29 Oct 2024 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgeaEC5n"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7B201037
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730183716; cv=none; b=CQ+lt6GilZo/BCIrCJqP4SG9O52OfK2v6YnhG8tIpMVzFJPQBStckXivhVBH+rdqSaTK75ch8Asozy/0ltK1QiBLtgR3sSODuRqWlSo6p013BMEt64huiKMVVOF793BPXnjwveFzgEWhRnAIchtNF6/kX2wx7gRU4Ij3v1npsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730183716; c=relaxed/simple;
	bh=xZ0ywlKYQnGSvGl6ocRP58hWH7a+wAhBTGsX9huPv4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajhWo7ex0PviaVPu0ts60MsMBE4lTuT7XXp00hR/x/1CZLwOJauNgA7ETjNv610lqPTR779rMO4HPACWRVaGtMz06vUH+petYgMd9rj76vbtQlH5GalUH02VMV/6Sx7deRUHrb7KnQ6lUfphqkoNaIavx3KHRj5bCLzf5p3q9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cgeaEC5n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43169902057so49153545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730183712; x=1730788512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGmWguF7wto3ubSTB9eGE9Fa2Zb2k0XycKxxaDv+zCk=;
        b=cgeaEC5nOlgXB1C19SPqtuDYUZ5vo4idK7bYTNsKwP5Wl5Uu3T4a40NIdN2c+jL1u2
         qrfPFx8R3QzhVi5/I04fD20SVhuOCk1XlEEfTGtRqZlSYgV0CvmY2rqr7oDKoiX59K+Q
         QTRBKldks23k/H7sYhFVaHCL6fja7qBacjb5ES0J4a+5692YdPT3ykxVlokAWJHKc4Lw
         kYmunwZOnU3qDuTxoRCFmz72OrXEJdl0Yo23GFq89l0BhK/lEkfYWn7lttMpEqZ/JaFY
         xbm81ySx/qvTWWFERN7lTMyfGyrk7n23Ni5xEWK186T61iz0J0n8Hh5f+22iOJ6InhPS
         FB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730183712; x=1730788512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGmWguF7wto3ubSTB9eGE9Fa2Zb2k0XycKxxaDv+zCk=;
        b=HldHzNRBlPpcVua4meGUHkff1q3pkOEOrmFRNRfYsVgoxiuLj5T0HC3Ej423jBtiap
         3UdQg9QcO8Hp2EdY/TcWkfDflfkR8KoKOI+frkolciljRXeMJiDSzZJLySyKNbv7t088
         P6TQVxJr5nBb6MMVxT38y1QFi/0jcoZNCRFE7i2s7RPPtLqU7tupnXK24rG/XlPouTcc
         rwoewpwFjZsKEomXGV82wxgtMCc9uTiQ6vf/77qkjvMhoCMNzE1kWgxFbnyobi80b+OR
         RwSndXYxrcxfrVYH/RMpTMIe/BUzXAezTjV88gpJMIcsppgiq6UUuZn5ZMoJJua83JO/
         Qyvg==
X-Forwarded-Encrypted: i=1; AJvYcCXs6zxVp/MblWYEn2/TBFEWcYF/zOCJx+O1XWgJ/4BFeo97dShGc5YaH0Lzd54/kTEg+nTzrNy34S8zA+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm61NWMrv7mBnocoW5AtJCdbMB6dRyv+B2t7PJehy5Kue2PFm2
	75kJw9l7WEe1C70dr3YCVRON0dx1aaRj2dV7xNTVcVhVecM6Lj5AVJGc5bfdFBw=
X-Google-Smtp-Source: AGHT+IGxj96uvuoQOa/k6xLtZvRpxvyjCrAdeB52b2mJkIZWiWOsgfuAxw3Jj1MvCjKhES6LQdaIEQ==
X-Received: by 2002:a05:6000:a90:b0:37d:3eec:6214 with SMTP id ffacd0b85a97d-380611f579dmr7898417f8f.50.1730183712539;
        Mon, 28 Oct 2024 23:35:12 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b4e56csm11540408f8f.65.2024.10.28.23.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 23:35:12 -0700 (PDT)
Message-ID: <bbb8f8c0-3676-4846-b4d3-70e1c533b66d@linaro.org>
Date: Tue, 29 Oct 2024 06:35:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: atmel: provide .size to the at25ff321a
 entry
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241018-at25ff321a-v1-1-c8380f80c289@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241018-at25ff321a-v1-1-c8380f80c289@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 10:57 AM, Marcus Folkesson wrote:
> Set size of the flash for the at25ff321a entry.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/mtd/spi-nor/atmel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 45d1153a04a07b7c61f46b117311b24ab695038f..cc7217e96d0139a06d46f10e35c545f604464b3c 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -214,6 +214,7 @@ static const struct flash_info atmel_nor_parts[] = {
>  	}, {
>  		.id = SNOR_ID(0x1f, 0x47, 0x08),
>  		.name = "at25ff321a",
> +		.size = SZ_4M,

The flash size is retrieved from SFDP. BTW size of zero triggers SFDP
parsing, see spi_nor_needs_sfdp().

