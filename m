Return-Path: <linux-kernel+bounces-219062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306E90C97D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B58286A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DBB149E08;
	Tue, 18 Jun 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnXP2JNv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9D1459FC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706805; cv=none; b=V2qVSu9EHbJ2UIq0MS1vPL2e/DAZ7gYMSTt3kr9sh2lImLU1qW+jPE7Ou2gLR4w1OJ/OBWJAg3CPfYVSXV6po9Vfn3Tb+ulE96QsFmrBnleJoSjVfr+X7/cYY0Sz6z9LGb5QhwuVui80C3NEF8/aRKDmaZXJbE4MXrkVV3kZesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706805; c=relaxed/simple;
	bh=Xbsc4VENQqTGqL/ZwoOjc/hBAB6+yy+PsdnO0JKD194=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNz6Z65CJNtityrEi/ng/v3S7TOMpMb82uUyt+cyEWHK2KAYXO2oZ9P6Q5TdaEqvBvFhzmIXc28YwNFLPVt1QM2UkDOFhVW+QTOuODrsTwAIDJXChdcPEvMTiYjxuhxTE0eyCrF6MdRp2UyrIHyUfFgBqzcthyFYApByIujjkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mnXP2JNv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c83100cb4so5996806a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718706802; x=1719311602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LrSWMgyFt1tGbnNO2P7UCfeEdrvDolnINBnHsaSNfo=;
        b=mnXP2JNv7ujTFLCDHh4N6vjmqzwqKywCDRE7+pCAuG8V57hmA5P63icyP3Rj1NouMH
         hH0pJmq6n7Ie4Q5lQNa0DNcp/j741fFsMxY3QXh3cmDvH0Fz0a11qcJh3c/dHqfyH4pm
         nRBc27eAA5XyWccXMmPZ0F5j7pGHb2BWDrUzFZKfKhdNhHiFoW66KxeUTF/P+T7bUT8i
         fXvxRjSfxfjB7f7YBMKFyiv/e+QGGCJ2W3Rx3Bix/LD+yW6VyudggY6+gC5ITRAMZUGf
         0qVtWs8L+SAf4sU2bYrnRJPb7Ie0tD6kVWEe1i58e3TL1C/yLWzoPz849Fix3Uhpm+oR
         tf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706802; x=1719311602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LrSWMgyFt1tGbnNO2P7UCfeEdrvDolnINBnHsaSNfo=;
        b=UhJ1hE295NN55YmYhuhYGe15C7mJkjiQrqG8JwHygGUOTbydPxf00ToqKvBLugpNil
         Hhf63De1zIJUo/imA1GdPXQEdu3t1k2mSz9ZMLuuzgrCXxijjZXi5JSwXab0oX6lsiFR
         wZe+D+woYPvQj58yTwWD7Iuc3nL5QfPYn5rv1yi9lLT0utDniv3bXlEMJek+NFWFhKTH
         GnhQessZsGMufjLEMuORZRXsP5JfaoAH/Hws5yH4ZmUmn8870PyrSs+QSPsgCXoMSgQ7
         nrY38bC9dYlpcUQr+wAheRUeunuVRnfMzIwOCJ/EKhTa2YXsXP1jS1MPbneSQcAfilp3
         fQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCXZAKiHJSw0Nnlw2NDtIc2salKbU9zr/acjk2xJmt9ISi08ZicqWnKK1Deqz7QcseyG2QII1JrGiaUUWw+aYKC7TfejLeokzYOofwn9
X-Gm-Message-State: AOJu0Ywf2NOYGl6hwxo6K22HyN0Nz8MNM9vjx80fNbNccRIZTw4NpNeM
	dUdtsXKRc53lzx2kFQjCua3QbxLgsicmACEk9eHkUkKpWfENtvHlw9ZNfIKPyGM=
X-Google-Smtp-Source: AGHT+IEzJMrjAiuI3Fy97ZNQPTj97n9ZkgzQpZtU1gf7Kf7ZnduaPgCs6MOMVJ5nYE5CjVduo2rTjg==
X-Received: by 2002:a50:99d2:0:b0:57c:5637:b2ae with SMTP id 4fb4d7f45d1cf-57cbd69dc7emr7152005a12.12.1718706801663;
        Tue, 18 Jun 2024 03:33:21 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce12fsm7610410a12.7.2024.06.18.03.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 03:33:21 -0700 (PDT)
Message-ID: <76f8be4e-3050-4ae6-93b4-9524a0689022@linaro.org>
Date: Tue, 18 Jun 2024 11:33:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 e9hack <e9hack@gmail.com>
References: <20240610074809.2180535-1-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240610074809.2180535-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/24 8:48 AM, Michael Walle wrote:
> Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")

That commit did:
-       { "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
-               NO_SFDP_FLAGS(SECT_4K) },
+       { "w25q128", INFO(0xef4018, 0, 0, 0)
+               PARSE_SFDP
+               FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },

> removed the flags for non-SFDP devices. It was assumed that it wasn't in
> use anymore. This turned out to be wrong. Add the no_sfdp_flags as
> well as the size again.
> 
> Reported-by: e9hack <e9hack@gmail.com>
> Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> Hartmut, Linus, could you please test it on your boards? Also, do
> you have a real name we should put in the Reported-by tag?
> 
> This will also need a manual backport to the stable kernels due to
> the new syntax. But that should be straight forward.
> ---
>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index ca67bf2c46c3..6b6dec6f8faf 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -105,7 +105,9 @@ static const struct flash_info winbond_nor_parts[] = {
>  	}, {
>  		.id = SNOR_ID(0xef, 0x40, 0x18),
>  		.name = "w25q128",
> +		.size = SZ_16M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,

and here you add dual and quad to trigger SFDP parsing I guess. All fine
if the old flash supports dual and quad read. But please update the
commit message describing the intention. With that ACK. Would be good to
have this merged soon.

>  	}, {
>  		.id = SNOR_ID(0xef, 0x40, 0x19),
>  		.name = "w25q256",

