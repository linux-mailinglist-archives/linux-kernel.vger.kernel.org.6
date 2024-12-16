Return-Path: <linux-kernel+bounces-447210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C14DD9F2EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0F67A1B64
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6942040B6;
	Mon, 16 Dec 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+c+WaX/"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19CE20100C;
	Mon, 16 Dec 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347882; cv=none; b=urQOQaFZRh6DMgYRuq9ECdrD9fDPkiSYS3oYiYBxWYmxjvg3FzjezidV/owuLowU1TjgCFoVuu0bDxRJ3ZgxrNkagXNtsxI3uk9hfnX755LBD8N3NqVGWDG2p2pQdQosKeO6Ps7TvXF0mUh2utQLcRlHxa1ltZsoGZQVjtYSxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347882; c=relaxed/simple;
	bh=wKjmhvKYD07EopEeQPjDLUkwhtYq/L/Vck46jr0VYDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g95N5qiwdUdVAJMRFycgRa1l6zK4xmjx7JoNtk+T0urHZc6A8tMBNzMgoyeOahNVe7Lc2codXmtDBhayZSMpuUstvjUTyK41rf6lBHJ1Jm4LNYstUD3HGWoIIT7FpZbomMISiYUIdMpvK0cF9u0v5yUyZHylndf7nHt/E7hEgpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+c+WaX/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30229d5b22fso42196251fa.2;
        Mon, 16 Dec 2024 03:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734347879; x=1734952679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uDRPKicjyBVsF4oHmdLO3paC9eyCdN1Hcuw2KWmcs4=;
        b=B+c+WaX/PdP5aE1hZfSVId5WuK7KUnNcWcvmUzu0B8fhLGEhSYK5AmW+WeJ9vrzG/r
         TwkZYRSAzUGyxgQiti25mwtZF5Zp1sRIv6Dk1cnLz7l7bHxxOSGOR0o0Ou6+gI0GHb4L
         4T1yhpEcMOf8uGOIsxucaq4c6azfuGoM+YJmEkWtl4BCWe+w7XMKXSw1RGQPK3BLE/L4
         tJ6YaCF9RfHVXZ/hS74gmVdiZHU/UWgV150jz89CGWehwSvL1zfd4ijIOQd4lBVTvwbF
         bNxdZNckniGawjd9RsP0fBf3G0+4XuT9VK3v2tYbSd7Tm0/SAlblJGlfBmikIy2Ln/ZG
         D0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734347879; x=1734952679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uDRPKicjyBVsF4oHmdLO3paC9eyCdN1Hcuw2KWmcs4=;
        b=a7wmaNyl5pFSk2SDZ6jqXWsgfrE8x5zzEqD5XzTIZT1LybiPqBSGmFnnXgI3nC1ihS
         w2Z1K0kqouAB5hkdw69xOpPVm6PWh0TPKnzI376Pd1uU41QoxDP+pIhegGfUgbgBA/w8
         fFL6Q3Bq+XxDRNkZMe1JulVuQ1gerG30MIOzl5kBBGykxvQjJBz29MvoVXW3CGq5QtNG
         U+tDt1SorwZglat4LokYO2mKtSVHeDVUQMEhytEue8gxvLB4n6lMa3N31+21cE6nVi7t
         d0Lb+0WHqN1rd8z4hJmCE1G14XrUxEtDg1swZzxWKOp8H28STKhQ88F75xr8L2YrLPVy
         xq1A==
X-Forwarded-Encrypted: i=1; AJvYcCUMnDe/5L7liffuZCsV5o+aAhHrmz/m5r9pI8upTK3PwlnTy779tLCKaJeZdBozsaNsHw1F/etC/ZY7@vger.kernel.org, AJvYcCWxfIhzRsQuNSHZm/ilB3E7eN1J+6f45k15zE63kNPjO28QPjuGo7rMwcGuGinvhOw40nfiQbWPVQCCrBw=@vger.kernel.org, AJvYcCXz4a5iwfYVUZqNQrB9xLhDnhr1xxHTF7LgsYvFQSG0t4pjRJ9gum6OYdgs6UeNWDqAfj7Ov8uYoVg5XxJe@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMLZmGQrc6WZzODK0XxToQN/TT8PTiJvrIvFp7hHMs6hb2tXE
	s+paB1gbHu5e5BTCmyXyP1ObmlzG5TGgJOqKA3CFYyT6RUMubmLld75piwPu9Mo5J/S9JEL4jRR
	pWgkWiwhcuki9tW7Hbdhr1B1XXHQ=
X-Gm-Gg: ASbGncuEv4mB2NZsiOYIkIPgFi3l4YctZLUM4QpY54K7bsT2xzg2ifJY63YvzGP83HY
	2JRBHaVEj4yjGdS+swmWykCcA9oBxCOJOpPvZ5B9+y3UFjV90dL/Ga4/Qf+6rR+J/kAKA
X-Google-Smtp-Source: AGHT+IHBsS2PddzHPY0JrugNy6kUWAuwhdz0KaOXh0YDC+P4UW91f1Yu31DKnJnF4Ubc4Esc8DSwQoM13m9LUd/UzJE=
X-Received: by 2002:a05:651c:154a:b0:302:1c90:58f5 with SMTP id
 38308e7fff4ca-30254444ae7mr38625311fa.1.1734347878643; Mon, 16 Dec 2024
 03:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216110341.3707-1-quic_pkumpatl@quicinc.com> <20241216110341.3707-2-quic_pkumpatl@quicinc.com>
In-Reply-To: <20241216110341.3707-2-quic_pkumpatl@quicinc.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Dec 2024 08:17:46 -0300
Message-ID: <CAOMZO5A6_8eygyEY-U2WNOKVtUcQTbBiVV56aX9ypkr1AmOW=g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: Add support for master clock frequency
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_mohsquicinc.com@qualcomm.com, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:04=E2=80=AFAM Prasad Kumpatla
<quic_pkumpatl@quicinc.com> wrote:
>
> Introduce a property specifies the frequency of the master clock

"a property that specifies"

> -    enum: [ 0, 2, 4, 8 ]
> +    enum: [0, 2, 4, 8]
>
>    micbias-voltage-m-volts:
>      description: The bias voltage to be used in mVolts. The voltage can =
take
>        values from 1.25V to 3V by 250mV steps. If this node is not mentio=
ned
>        or the value is unknown, then the value is set to 1.25V.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [ 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000 ]
> +    enum: [1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000]
>
>    lrclk-strength:
>      description: |
> @@ -64,7 +64,7 @@ properties:
>          2 =3D            3.33 mA         5.74 mA         8.03  mA
>          3 =3D            4.99 mA         8.61 mA         12.05 mA
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [ 0, 1, 2, 3 ]
> +    enum: [0, 1, 2, 3]
>
>    sclk-strength:
>      description: |
> @@ -77,12 +77,20 @@ properties:
>          2 =3D            3.33 mA         5.74 mA         8.03  mA
>          3 =3D            4.99 mA         8.61 mA         12.05 mA
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [ 0, 1, 2, 3 ]
> +    enum: [0, 1, 2, 3]

All these enum changes are unrelated.

