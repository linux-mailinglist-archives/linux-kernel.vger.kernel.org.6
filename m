Return-Path: <linux-kernel+bounces-258421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE09387BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135041F2176A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FAE14A90;
	Mon, 22 Jul 2024 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WHeQ1pAo"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89830168A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721619485; cv=none; b=i6pjNtRwQYn+idue+Rvct6hGfCu/BPa62H40kkEVofvjKu7Mun7L2TZa6kfOLv3dWlHlUZSCc4aYp8C8dcziLuuaQ44Qx7zWmyINiqadL6/GXlGtf6B/Ul5N24PPylmuy72oMu0B5TX047RQFKq5LkxRmHVe0Xj21uOaBdE2yfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721619485; c=relaxed/simple;
	bh=GX17TbH4p7z5Qab1CaLT1H0sGB8ak8//Dpt5jXZ/teM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ez6X4jWviJqv8d9bIaZX6Q/HzgPQkWIVJR+9k4ZCI1FTzTjbSs+HxUbmIhuB0DIFelkwd+oS1ZGny4g8f0UmdbsSj2oR0szDDvGjCncYXvXbq9O4izopXYkwMfCyVkCzyFd35PTcE3InfI7JxvR6GYDTz9JEjdHFRo79orJ5WgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WHeQ1pAo; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f51c1f9372so334361e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721619482; x=1722224282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUQ9SOJBhew070r/TnrnXwfyJonEGUyPXY5zsdc2e5w=;
        b=WHeQ1pAoOCL5rcg32X6Ql0Spo+RrQUyiht/IoahX/pOlD55pn5XtWAUwRyRq2Yyoip
         NOmEF0GmXd9EVStbx/UzPkhQxjvcIvkWEd7MGvxdsLkEaYHjY05COXV2Og2TX6HvgFZo
         repwvmBl4syy7UQHsBCd7BlcL8LSUzt8Raf+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721619482; x=1722224282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUQ9SOJBhew070r/TnrnXwfyJonEGUyPXY5zsdc2e5w=;
        b=uDFdAYETTG+5N2r4dyBYEylfZtmcAXgSK/Nn6Y4XHnWPUKIqjm9cRXYgl9l3a5+8m7
         kFXe67Zp9QWJ6z4C14NZfHa1Syv/nVnLUZZ8jAx5nncZhY+JLSQtWhdqUbPI8VdCCsvM
         pORJ1GUcg+Y6sed9L9WZw/6kkKrbk2DBKHkO1gfh1ARG3ZPbWB4krIKK8y7rN7QS9GSa
         MmR94Z5vgP1m0I+7qxev/r2deL0NlwcFJKQBWOyVjrD4l3lwv1dGGmn5PE7PdjpDusmY
         KL2Vzu6tby7Kb3rf2DN0d37/5GQlf8aDL2BpNq8zPFY+ptsS/s8OdGGKvSOeOzlGi6FT
         jasg==
X-Forwarded-Encrypted: i=1; AJvYcCXBOdLTN1O+LAVyFlQoJ7+mHji98Tbf4zCYtO8DIy7eQN+NAy8EMgMHT2VWUwT1eqRYUpy4/TrvndHKldEHiJfHGW/2NNYXvGv0/7Bh
X-Gm-Message-State: AOJu0YyB8VUQ+OSNY8unD0mGHFIK0gtteAxrUzfJNYm6XVlkoaFE807B
	hl3oKRg4sj2X/0th7K9OTPbATZPlSSsxQUFKH8bCR9ACVnsxy5qNDUbT3zvuJ15qHvGAQN15TOY
	=
X-Google-Smtp-Source: AGHT+IGyR2yL7DsuAeHY9ZRwIiK0HN4gvBZFZsiZX7YiaLyKEz7HSHbtQSkULM2E683JwqJtGovjpQ==
X-Received: by 2002:a05:6102:f9e:b0:48f:de85:2b57 with SMTP id ada2fe7eead31-4928b93d1e0mr6859816137.5.1721619482139;
        Sun, 21 Jul 2024 20:38:02 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-826dfe3dd8bsm1127856241.25.2024.07.21.20.38.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 20:38:01 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8231d67a168so847879241.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 20:38:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgmnENg6pf0Kh6Z6ENIIncRd8Xo/hwYpWi5azQ3GG1zreT6qPcxOyfpWplc6tbafCHbz1XVPYtZA6JZ/+qWxF4mhhw8pUuQQd4ftIY
X-Received: by 2002:a05:6102:800e:b0:492:9927:a5c6 with SMTP id
 ada2fe7eead31-4929927a897mr4197274137.12.1721619480758; Sun, 21 Jul 2024
 20:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719045823.3264974-1-fshao@chromium.org> <7edb3361-9e53-44ad-82ec-b2c81834b2ea@collabora.com>
In-Reply-To: <7edb3361-9e53-44ad-82ec-b2c81834b2ea@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 22 Jul 2024 11:37:23 +0800
X-Gmail-Original-Message-ID: <CAC=S1nh0c4HL2uUcz_zMmtuJvk7+3iWT5mEtmtpDrp1+nWp2cQ@mail.gmail.com>
Message-ID: <CAC=S1nh0c4HL2uUcz_zMmtuJvk7+3iWT5mEtmtpDrp1+nWp2cQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Update ADSP
 reserved memory region
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 5:22=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 19/07/24 06:58, Fei Shao ha scritto:
> > Corsola firmware reserves the memory region of [0x60000000, 0x61100000)
>
> Sorry but if the region is supposed to be 0x1100000 long....
>
> > exclusively for ADSP usage.
> > But in fact, a 6 MB "hole" of [0x60A00000, 0x61000000) didn't get
> > assigned to the ADSP node in the Corsola device tree, meaning no audio
> > tasks can access and utilize that memory section.
> >
> > Update the reserved ADSP memory region to fill the gap.
> >
> > Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform =
based Tentacruel / Tentacool")
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >   arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/ar=
m64/boot/dts/mediatek/mt8186-corsola.dtsi
> > index afdab5724eaa..0c4a26117428 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> > @@ -169,7 +169,7 @@ adsp_dma_mem: memory@61000000 {
> >
> >               adsp_mem: memory@60000000 {
> >                       compatible =3D "shared-dma-pool";
> > -                     reg =3D <0 0x60000000 0 0xA00000>;
> > +                     reg =3D <0 0x60000000 0 0x1000000>;
>
> ...why are you making it 0x1000000 long?

Because 0x61000000-0x61100000 belongs to another existing region,
`adsp_dma_mem`.
It's slightly confusing because the diff doesn't show that directly...
here's its snippet for ref:

adsp_dma_mem: memory@61000000 {
        compatible =3D "shared-dma-pool";
        reg =3D <0 0x61000000 0 0x100000>;
        no-map;
};

Regards,
Fei
>
> Cheers,
> Angelo
>
> >                       no-map;
> >               };
> >
>
>

