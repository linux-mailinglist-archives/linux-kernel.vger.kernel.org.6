Return-Path: <linux-kernel+bounces-568926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCDA69C27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D42178025
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2021859F;
	Wed, 19 Mar 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X0mJ27Io"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16E21B9C5;
	Wed, 19 Mar 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423787; cv=none; b=YLjURmcQBDsi9zBcI0r9BK5N7wM4NT8/x02Bnnjob0SgHOmyJMM6LoyFc0P9xfjxhPJzXsEi9PacYpMhyhXBAG1g1nuVdPtV07wnohAdjgtmiSEpSJH1NiITkE1ojuDPFDvayKsGGIyr8dB01hLgJ8soJU4GlVfV+XBwh3Oo1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423787; c=relaxed/simple;
	bh=nhVhqBd1yE3jTfM+D2yxMe2FOz3t3kE8iCizqfolqmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FM77nyJHaQmthu6ZxQ3+Q6xNwMO0IS4aXTO//AQ6IHHZpsd64Xc92rY2UwGzL5Sk05I5EkiKNRXHuzbZSUhyUWnouV84XaFHYgzcIBATZ7mSW5wSzEwZrO1jEfuCQGquFkJF3nqMUdN5xZbEjB/q8qpsoU2Ha0YwRSy8zAUbPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=X0mJ27Io; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso1226145ad.2;
        Wed, 19 Mar 2025 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742423785; x=1743028585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxV/xJXYWKCtENMVxUm3wS9i0eN0MZ3pOU2llzz4bL0=;
        b=X0mJ27IovMTiO+KMo1OLkrvezWniVRNGVitmFuEARVU8XaeeCM1pHxDyhcYESMuMyy
         CG7V2G8q3iLuJ0e8KYJNth3J+4OtsgWRtcvrfl12EbWJ7lUyhz+fyCi9Tb5kcoQRhPjp
         9NZmhZNFyzEInvj/wjx3pNa8zX1EDmGrEX3jagCT8EdBs/9jG4pUavWSHlXJ6lny+w22
         kDBfkv6/gqX+kfZYFj6m0s4lr1kFF0/p7QSMwMZiALpDfwOsWmMuS8N1O7HME/Mazrvo
         tiTu6FUFzveZdwIrCD2cqYB/bJxv5gVJ2IcsZ3PHQT7PXDxZoC+lurOFH89p2PgnNt0x
         MPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423785; x=1743028585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxV/xJXYWKCtENMVxUm3wS9i0eN0MZ3pOU2llzz4bL0=;
        b=PVhAPW3ZRD1VKaD5tKrHSGY8pImHA7MEMUJ4WH+GYPzeeQ9GwLol9rV6ZeQcIqR2ko
         Qi14UTteyWYTgSIsUYF6AWvqI0QzuaWWPdKbuwpTjPicDJ889Wv35epnWmLlBXmFHE8/
         MJT82rcct8aOpcG+o37xCVufPMNZXdHrz2vqeltDxIXC4rNFrae3+a3+0d0Xzm+OIkVh
         7LXnQR9+VP1rNWoaCqil2STj3e8VKfxAwHFlGtW4E9u3ZDyw7GCTXsv0euEag8e+W3kx
         kD1d/d+qvD6tN7UsKjid+JPgA9lg8WsMyuGnAmZOZFu7W3YmQQtRujihDJZPqL/Ors9X
         lAzw==
X-Forwarded-Encrypted: i=1; AJvYcCULwmUTQN9vpJdh6lmCXaJ764WzsYVfxpWz+VMLIQAR9GMiiaFLIrzWhHlppNj9hJ5Ok9g70V1B6CpSBizk@vger.kernel.org, AJvYcCUa8rexu/GyRlwQ3+nFeKHwSNbsNaQ4NOb154cgObykghzEK0L35TxK4BJ+QAcwpIBvMseE5FwkzrPz@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGj0QanPUTiGCl2Z8dYZriHqA7vdko+veQdFuTas/ZOAwnkkq
	di+FmO2ujv6PVG/krs0wTIag5l9kRo/DCX8cmDV2bD0aHi6VbfhcfXJUKeIf1MzNFIiyZtzkPbA
	pY+T8cq+9w7DAFfQfiEdMyNASIrg=
X-Gm-Gg: ASbGncu1jDTv2Z/+/qqv55Lc8ux20AvVWepjd9CT4sf9dzRklBoN8qDAuqxgbG8xIqD
	HwIn9CVGzqVZisCqyeS6hXkZRoNfBG+zTKMsUXXOyS8oWbZWvo7yOM0pLmWqhhESM8nLttU8M5l
	dZeG43oCWj2Di9wCcdRtz75rz+7p8gG+allM4bJIp5dY/ZXGfP/bO4sb+n144=
X-Google-Smtp-Source: AGHT+IG/YIc6tBx54GZTNVesuUZ+0/SBrY5cBP76NGT3Y8BVMBK0uT7Wgcmqazmw2tp0JyM9BJP74tIXaQ45IJ2dJyM=
X-Received: by 2002:a17:902:ea07:b0:223:325c:89f6 with SMTP id
 d9443c01a7336-226497fffc5mr90923125ad.10.1742423785134; Wed, 19 Mar 2025
 15:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319190150.31529-2-funderscore@postmarketos.org> <20250319190150.31529-4-funderscore@postmarketos.org>
In-Reply-To: <20250319190150.31529-4-funderscore@postmarketos.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 19 Mar 2025 23:36:14 +0100
X-Gm-Features: AQ5f1JpXkKwFQfXcHg1AOK80prLkwU3fTrKPn2VwdZF1QFdP8C6Judb0z-mEhaY
Message-ID: <CAFBinCArRO-F59tOv9m27f+DV+qhy69OGUunGOAbDdfOdd5_Xg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: amlogic: add support for
 xiaomi-aquaman/Mi TV Stick
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, Artur Weber <aweber.kernel@gmail.com>, 
	Karl Chan <exxxxkc@getgoogleoff.me>, Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

thanks for your contribution and sorry for the late reply!

On Wed, Mar 19, 2025 at 8:02=E2=80=AFPM Ferass El Hafidi
<funderscore@postmarketos.org> wrote:
[...]
> +       au2: analog-amplifier {
> +               compatible =3D "simple-audio-amplifier";
> +               sound-name-prefix =3D "AU2";
> +               VCC-supply =3D <&vcc_5v>;
> +               enable-gpios =3D <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
> +       };
I couldn't find any pictures online that show an analog audio output
(typically a 3.5mm socket).
Can you confirm that this is really present?

[...]
> +       sound {
> +               compatible =3D "amlogic,gx-sound-card";
> +               model =3D "XIAOMI-AQUAMAN";
> +               audio-aux-devs =3D <&au2>;
> +               audio-widgets =3D "Line", "Lineout";
> +               audio-routing =3D "AU2 INL", "ACODEC LOLN",
> +                               "AU2 INR", "ACODEC LORN",
> +                               "Lineout", "AU2 OUTL",
> +                               "Lineout", "AU2 OUTR";
If there's no analog audio in/out then this section can be cleaned up
as well - together with the references to acodec in the dai-links
below.

[...]
> +/* Wireless SDIO Module (Amlogic W155S1 / Realtek RTL8821CS) */
> +&sd_emmc_b {
question to Neil: since we know that there's two board variants out
there (with different wifi chipsets) - are dt overlays down the road
enough (to enable Bluetooth / wifi - depending on the chipset or board
revision) or do we need to split the whole .dts?


Best regards,
Martin

