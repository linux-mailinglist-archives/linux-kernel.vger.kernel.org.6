Return-Path: <linux-kernel+bounces-406057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A29C5A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299DD1F23BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668541FF052;
	Tue, 12 Nov 2024 14:36:03 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7411FF037;
	Tue, 12 Nov 2024 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422163; cv=none; b=norr6HWjpZbRt09lP3vfx5rJ8ZKTde+K0/yNvvg/QTeQEw+XDtieHYYpcMhVTu8IVhApPNlAtcjpQEsLpegj26Egz2KgI8TfI09rB29VgaGJzlxgcYJiRjMzHZvyaOM/FZhdrtq7qsGK1ogg5zW90NRuJ53ftU6kqTsqmIaC444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422163; c=relaxed/simple;
	bh=z6wXrTyhnVn+itxOawVwCYRcAi07QMtXojdxaGdMHmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/E6Z3cwa8YHXRHSiVG0sWvRW9y3Os622KuUpVov90wi/3SK+nLWQdl9so0IAf+ql/JiciXUTsmRRWgC1+TxzPkw5CNrqNjYBHxHxlzx2AY9o4LnDsohYkjO3H3xJwnEiPAR4MXHdsoNQUhG0XQl8h4Z3z8XoMPHz+C67Xk0mB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ce5e3b116so51012845ad.1;
        Tue, 12 Nov 2024 06:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422161; x=1732026961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/b6whg1Fuu9dsUqH1kstDqi5ac2SXC82I/0cqQa6CQ=;
        b=tAKIeTR0qUXXSeymcHE4vU0hPjb7lqVd8WwFQGYunGciePfys23fj3C2GdLbBJyz61
         ub7ymXvZ3oVy/bVqBhIfEJpvRwvHyiz0B6Yq6ZB/788FvVZksEiBP3AEgYpCOLunCc/l
         r/31neBLkFFkL2aFZuq62XphdRZp3kqhhaMkdO+w+cVxRR2B/NfFF0vIv2yl36dyS9F7
         CozAqqdUQ6RaDTf6sxOgkmco9p3gM12sc5KlfT9FjX8gOL2O6GQRjabmydHlay7kNVOD
         0rteCquc/i4JMMH0JCtgRZU9cKFfYCTHVCX5OXOLGYBIrLSBj2yCe8q9pD44SsZ601wo
         YmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV477djBqLJxtHAU0LekdR7SKnpP/2tfR+XQtkcC8TpAhnber5UKNTe2XIFa94c6SlOFretOFlrE0Nh@vger.kernel.org, AJvYcCX2al1XBjvzhWW8EzCZBnOMi9oyc5bax2/JOWWQ2589E6EelUaY5Izbg84s4G1RkVrKDAk5IPBaCo3M+nRB@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfXsbpdfL4OObs0blAY138lEkyZmeWKrlv/0ITxHsnFtRiB1c
	Nu94IL5igOIf+3DbIh+vwax4hakiciXTffXEAPKLZg/aehHZSPY00QHyhNnAjAy8Pw==
X-Google-Smtp-Source: AGHT+IEvylM1Sz6Cjl79eHiLdMLsrfhmTxFJkqLW6o1ZZX1q50Vz3S5gYK40ZlIuouKZgymsV44e8A==
X-Received: by 2002:a17:903:1c6:b0:20c:8cc4:cf1b with SMTP id d9443c01a7336-21183e11495mr226690465ad.43.1731422160890;
        Tue, 12 Nov 2024 06:36:00 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5a4a3sm94765295ad.185.2024.11.12.06.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:36:00 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso4552753a91.3;
        Tue, 12 Nov 2024 06:36:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4nno/1Sy2rYNW4FNt+VTkx4GMZv8TFEzKGZOyLvetwNgtM22KtrTZwNGX6eWkEBXor7mvnau0wCJxQRbN@vger.kernel.org, AJvYcCWVNRHYcOw7mqirhlEbNDSywM/2L1Doca5Vi6608BRrwmo5gBcBz+C/D3PR4eDMJGisggmaDxTnw19L@vger.kernel.org
X-Received: by 2002:a17:90b:4b84:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2e9b16e26b2mr24419741a91.1.1731422160606; Tue, 12 Nov 2024
 06:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-4-tszucs@linux.com>
 <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se>
In-Reply-To: <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Tue, 12 Nov 2024 15:35:49 +0100
X-Gmail-Original-Message-ID: <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
Message-ID: <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable UART8 on rock-3b
To: Jonas Karlman <jonas@kwiboo.se>
Cc: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>, 
	Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

I agree; it's not possible to tell if the user will use a PCIe/USB,
PCIe/UART, SDIO/UART, perhaps USB/UART device, or any other HIF
combination. The way I see it is UART8 is hardwired to the M2E, so
there is a reasonable expectation that it should work too if need be.

Kind regards,
Tamas



Tam=C3=A1s Sz=C5=B1cs
tszucs@linux.com

On Mon, Nov 11, 2024 at 8:12=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Tam=C3=A1s,
>
> On 2024-11-11 19:17, Tam=C3=A1s Sz=C5=B1cs wrote:
> > Enable UART lines on Radxa ROCK 3 Model B M.2 Key E.
> >
> > Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@linux.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm=
64/boot/dts/rockchip/rk3568-rock-3b.dts
> > index b7527ba418f7..61d4ba2d312a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> > @@ -732,7 +732,7 @@ &uart8 {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&uart8m0_xfer &uart8m0_ctsn &uart8m0_rtsn>;
> >       uart-has-rtscts;
> > -     status =3D "disabled";
> > +     status =3D "okay";
>
> This should probably be enabled using an dt-overlay, there is no UART
> device embedded on the board and the reason I left it disabled in
> original board DT submission.
>
> On second thought maybe they should be enabled, think PCIe and USB lines
> on the M.2 Key E is already enabled by default. I probably only tested
> with a pcie/usb wifi/bt card and not a sido/uart wifi/bt card.
>
> Regards,
> Jonas
>
> >  };
> >
> >  &usb_host0_ehci {
>

