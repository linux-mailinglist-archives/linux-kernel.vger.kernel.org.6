Return-Path: <linux-kernel+bounces-356917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1CC9968AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C1BB218A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FDC1922F4;
	Wed,  9 Oct 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQkj8Ab2"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC6191F8E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472958; cv=none; b=uNfy730dyBOymynOQu2zE6Mo3p6EeneZHQ+USEMYWUOGHd4p89UH0CpQt8/MvxKjxzQBYyELYr7l2362Wm2wg/nGIighTFzTSHr2yr1V+MpAfZzFNwga2DicjWnntL/42c6c+uyWWKfYAX0J0NzbBB04/hVvcq6GWrmWYJjwbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472958; c=relaxed/simple;
	bh=LGiw/oc9ETyEARgRG3P57WvWVitY9aVPClt8FRfIOtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoqXVdkdc3UKBCG4VKnOQgp8/WPIm8w9g9BdNtkBKJZegm0MDi15fB22O4V4fQ2Q7b8ZaH+zQMj33Mc2gyPhliuTRj4zTzoTN3+z+00aBZdL5Li/cvGjMPEXDVGekwQ7N+5tzRFb7MLOF1LVJyQPTKyA4U8UhnKqpd2ii6om7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQkj8Ab2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so7428631fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728472954; x=1729077754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGiw/oc9ETyEARgRG3P57WvWVitY9aVPClt8FRfIOtU=;
        b=bQkj8Ab24KLc7ZmUzcepDf6xshLlQ7KL2rKVtHKrfN138HHwTsRaRbySjyCISnjIjb
         suGwrTxdKzVHM2BXDrNxOTe/ylLjAo5ZMg9GDCaqifo5wynlO230qzCMlncbtYANhOrS
         l/a0HMy/OwRGCT5ye0U3dSjVvtwUYfLKa5yq2WUx9WU7f8NpI1R1gKQH3giUO4IhcdNh
         5b1FYti00nHQj7u2ugbStGqDKp3O7FusgpVLkxG3aGUf43KAEIgHp4YaYqTVNaXpOxip
         sx8Ji52k+jua7hyurFCanal31+amM1XzbyuSL0DALX/ERG+syOUgXfA6H6T1KLiL54wn
         6pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472954; x=1729077754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGiw/oc9ETyEARgRG3P57WvWVitY9aVPClt8FRfIOtU=;
        b=pvzhXpiJlKPkkksR6fzdpmIvnj8MFD5tvdxSHmTPGUpWaoNYLbkQqG0Gc+dnMZUlj5
         +qOeQejfMYLltFkXglOkXCW/F2wdulSDcR7WBs3U11fG/uYeY6sPGTt4fy3yERA6jC3i
         kwu2Kfdpnro706ssp1TFtDu2tBxFdaGiqgGAsn3YC3mogSXWm7wuryzT3BeQI/E1aJMJ
         SxnbmjgvAidkC8ePzdpIM9S1hxMTCcBiXnIOQ/4PSyRKjXeh1WSSgtrP6/X9woonY/e6
         X5oLuir2mJLIc8NYiaK6sQUF+zjESGqFECVoGZQaNojCSesKlp77CYsx9R8W7fzI17Of
         aJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCUQtSQR8sLJAD546+gp2jykQLJTtORRPgAWVv7qQWEZvv6BgTx2Yn8CIWP3EOaY5HW64KEYVDK/81JEQZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDRQETS5feG50Mhv9NeStmQIsgmPRJZtgjdpSbnw0ijbfCHc2
	c//Nf+xnsw6FssiuQvqtid00nAdaj9vY+IkrR25u9Tmje/+bs0BQnTc1rJe5v0Vd7lQPc19Zmjh
	/06YB2fhC6gT9t6EHvdbZvUdoRgdwmfxLMX7PvErIh4/55CYcaWs=
X-Google-Smtp-Source: AGHT+IF9zAl8DQPl7zn/Ing4gQVNbPa2pljdHpuKWGx3GBhCA9FkwWGI/USumIRp9+/7OCW4AwqSo0p20trwIzg0dTU=
X-Received: by 2002:a2e:809:0:b0:2fa:be1c:7ed7 with SMTP id
 38308e7fff4ca-2fb0de96d8dmr16651541fa.12.1728472954225; Wed, 09 Oct 2024
 04:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-mbly-i2c-v2-0-ac9230a8dac5@bootlin.com> <20241009-mbly-i2c-v2-4-ac9230a8dac5@bootlin.com>
In-Reply-To: <20241009-mbly-i2c-v2-4-ac9230a8dac5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 13:22:22 +0200
Message-ID: <CACRpkdbyZMzEb2i-tjeUdns+cODBeQdgXPH7EAaEHQZ8=gAkaA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] i2c: nomadik: support Mobileye EyeQ6H I2C controller
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:23=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Add EyeQ6H support to the nmk-i2c AMBA driver. It shares the same quirk
> as EyeQ5: the memory bus only supports 32-bit accesses. Avoid writeb()
> and readb() by reusing the same `priv->has_32b_bus` flag.
>
> It does NOT need to write speed-mode specific value into a register;
> therefore it does not depend on the mobileye,olb DT property.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

