Return-Path: <linux-kernel+bounces-394718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC3C9BB322
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC72843E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B721B6D0B;
	Mon,  4 Nov 2024 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPT1GkV2"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A711AF0DD;
	Mon,  4 Nov 2024 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718970; cv=none; b=ONFkNp8PfO6cmTosB5hhwxn4FIkEu9v2pwnRKVDBvq8piNWJmAxos66oHdg1nrGSy4H8Ay+cQ/LQkVaRcRbbxxgVkYRRBZcPHuwf/I457ZhX512BwusruHDWSjV4Yriy7QNc0J8aZQ0r32sMk3Q7OFN5u/6Elt7DiYYQUTagkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718970; c=relaxed/simple;
	bh=6lPauIiTscqKMOQTLUHijuI2aQyYBb6lw3dYwjsi6bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVueEZXo/PIM1aIGkTNCssJ27r2SJ2mbYThNAAzRIvCMYtMcNUWrEk7CBFHDuIPksQt6bzqH4rXS5+1qLhL+HJ8q9C44wwbodokeigSuHxLQKK2n7HZ516mfKsAnp9e1hCs5tz5MpAeo2cOF/o29FbFfTf7GJ7BvEOQCPR1EFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPT1GkV2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb49510250so40521801fa.0;
        Mon, 04 Nov 2024 03:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730718967; x=1731323767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SMwMlud9VpFJug/GEuyhyAfU63OEE3p7Bt9+6mizC0=;
        b=IPT1GkV2HfLgpH4LzzOO9VABJlll4PxLa3gyXXXXOLStHoUgab8ORuqK2mSAqqGIUo
         PYgQosr9fhKGfKKZhW+0m8aLJWICBvhtaoQfkPs1OyPz6IWGb3GtWMh8vxGH+7FS5HRh
         rEmeTqd8G7ZSajcvZE6NODVQIleKiTZR3+rEIGrpnumhVRxEf2sN//2nZcx2CJUHaw+z
         ltNGxcwDJgTQEROb8ZOmcsbMc4hMfMrr/KHaVIkiR9S4SvEDba/9lbFk0o5gVyjKHYPf
         iCVAQlHY+NUbThk/O04TR9EsndlYdoWH6a+ZVExWgUaMKSMeXLbcslebIxd9hcXy5mvK
         AjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730718967; x=1731323767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SMwMlud9VpFJug/GEuyhyAfU63OEE3p7Bt9+6mizC0=;
        b=bdi5bALx09Eeygo+yJjNLZ5+SUXgPRRp8A4hpZfLeHDYbrXZx97mLHVKz0QjxDcPYo
         JF7sIMLXWJfIuKs18HMxZgGIp2xy8heN/WAPtq6wbRRqChphGHL1c1Lr/U6y5/zHHF0C
         fXg1H82l+9h6g0Q6cNS6co3WZHLpvvHCc08lGSPhBXFFlL1eVFRiLreBXqZRYzkgiZof
         1wJemqyrGQiiXVn7DmPeoO/8ULhxiz1N+EEUMSSi24HHu3JMAiR9W4Q7hPJXe9E1yXXD
         IDo0QrwHlDhh/7A0mxbO6jEmlXKs1BBRvg+zhyegr/HGQmapAVE99qJ+EsAiUaWpYq7J
         lbfA==
X-Forwarded-Encrypted: i=1; AJvYcCU14i62Sf5NcqQwgtmvZjlvUmQGympcNOKtCCTWPr+J26pSwSCACS07rNFGCS0rjvGo/Ypm3UtwiXE3@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEFzzogC+W6CrKoBQs+FDtwlFoGaNHlq6IIP+BUGeQytphGb9
	SbPnI3senTKoZDIwCOBBBp8/O06vFDM7sMZ8wAYrJDKNEyTHuI65Qmu/bnwO5Pb+zZECtUBk05Z
	Ef6MNY88gXs3M9mYtrgiEHJ88SGw=
X-Google-Smtp-Source: AGHT+IEzN70NkrF6BWT0VQctKNPsc9mfubq6riSTtLOV3QRjwhMFt9r3TqokctCja3a9zuoI92aSnDqOznprk9dMpPU=
X-Received: by 2002:a2e:bc18:0:b0:2ef:2490:46fb with SMTP id
 38308e7fff4ca-2fdecc2f714mr74133011fa.37.1730718967005; Mon, 04 Nov 2024
 03:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031151238.67753-1-hs@denx.de> <20241031151238.67753-4-hs@denx.de>
In-Reply-To: <20241031151238.67753-4-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Nov 2024 08:15:55 -0300
Message-ID: <CAOMZO5ACMGbhySUbR8r1UUimc53YDaRbfEObyUrf0GLYZcQfjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mp: add aristainetos3 board support
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Thu, Oct 31, 2024 at 12:12=E2=80=AFPM Heiko Schocher <hs@denx.de> wrote:

> +               brightness-levels =3D < 0  1  2  3  4  5  6  7  8  9
> +                                    10 11 12 13 14 15 16 17 18 19
> +                                    20 21 22 23 24 25 26 27 28 29
> +                                    30 31 32 33 34 35 36 37 38 39
> +                                    40 41 42 43 44 45 46 47 48 49
> +                                    50 51 52 53 54 55 56 57 58 59
> +                                    60 61 62 63 64 65 66 67 68 69
> +                                    70 71 72 73 74 75 76 77 78 79
> +                                    80 81 82 83 84 85 86 87 88 89
> +                                    90 91 92 93 94 95 96 97 98 99
> +                                   100>;
> +               default-brightness-level =3D <80>;

One suggestion: a more succinct way to represent this would be:

brightness-levels =3D <0 100>;
num-interpolated-steps =3D <100>;

