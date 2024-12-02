Return-Path: <linux-kernel+bounces-428138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BC9E0A98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D23C163C00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C091DC734;
	Mon,  2 Dec 2024 18:02:48 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997EF70818;
	Mon,  2 Dec 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162567; cv=none; b=dxmfQR3TNgpuZTIqp7DN1743evI+eLp2/a6Rwq/K1aE7I2r+/iBb5oaL4ZuHuS/Q1W7FUlqdxr2vhp0WleXqLjJYBxEJDJBuH5iaQzDerQC8Q+yb/rch1+0cHB9HJl13xUuSSjW95OsTVqygbeNXdi9WnZ+r4zM7W//182FS+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162567; c=relaxed/simple;
	bh=LVuZUa24WaOmzfyvxHMhny2Hxp6afc/nbtxIS6Y1I/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfODmEwsfMqewcMHrFrqKxcpiM873CuwL3wmgw976VZhs2kj+e2yw3yCVZJ+DlcZuKrrk1ZVy4QDeaRWL1mCkgJA7GBXFaQive1nB1sJ8eOMyfI6kcJ2KeUt/Wp2tF22rDdXlAiPPklEQce++RVI/aKniZr9NaUektrJBFhbNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa55171d73cso1003190766b.0;
        Mon, 02 Dec 2024 10:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733162564; x=1733767364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5gHcQ4FCTGNFnaCtGHvpnPCQcPDHMQwxknwgQhKcio=;
        b=Erhgivk49lpHA2GJTjVcQGOi736PgKLzvBbhpEJnfpvRAmmRyCfjg66oZe+AqG/e9i
         q4nPG7ypQ5V5umMvLqMQjExssTKfiNZpM39v0PUtMao3iKcKEiOyDHgABqB9EP5gRuLk
         NqaBOk6kuKZ4T3xxKYzPbyLZgoFHJzs7VOgZza3JX/kZnlawjQzOChw/T95GFYtgRCpY
         n6NMeKh4N8IanC73FuWD4VgenT8yBlMh6l0O2qLa3XCk6GDAiVaavkS4MvayaBx9CcHs
         FFmHGtN7AFTMeej3c5RSiLVrrNf9otQ+s4BFlWpqgErQVywKx/eSwZDtfM3zAIcOH2LS
         Uu2g==
X-Forwarded-Encrypted: i=1; AJvYcCVTd1JH21VWQ+4JvX8PY4Hg/m67mOQLKu1KyTL2IdexHMv71q5q3TCq/P8pOruCuFu2X4Pp0BMbPMZU@vger.kernel.org, AJvYcCVVbxe0iE7vZuKQm8IPaErEctzrUZhR/h+I4ZHFU7EDplgYVVDs+iRPGaraBylshV4A4RqWqCA9h+hAdLTn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CEBrn9JVz8UajkWgCEC0OeNWvN/QCwxsTdCWlCQCM5shIe36
	dA2ot4Hq9jFgAAusr6wD/lNW55aAiATLVj/dC6HUTWudxV3Z2OVfktposJRTIC0=
X-Gm-Gg: ASbGncsNDWRHE0xxs8aj8dNtXlfoubJu10PqAzvXcmTJyyEYsYQy1DeCEnWK5392nXc
	VX3aq+SDIHLDSbcvFZ2e3Nw9SG8vb1BHeA+lgcehe4JX+P/ztC0qc6SHLBLpnH1JnqQaOYuQHdU
	Mu5I57dHIEXj0LmbDni7yDcOYfk2UbMYEBPjI69EL//+kV1F8HhX+eLq4wtCfcRu+e4b/Cd8KBl
	MQ7Ya18Wf9ZAgPQMQU3hMED9eF8Mxkw6Y23ZuClLcttjj2mMPbBZrAu6tTcXuEGoQRyst3pOi1z
	MCox
X-Google-Smtp-Source: AGHT+IHqH+RXpiHj2HSPOSUU3Knk7DPh8DqmSqIhMb4UKXSYS6ukJYTT9fNPjk+TZ9PpbJflCx6yeA==
X-Received: by 2002:a17:907:7ea6:b0:a9e:82f3:d4ab with SMTP id a640c23a62f3a-aa594535329mr2319592666b.9.1733162562169;
        Mon, 02 Dec 2024 10:02:42 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5999058fbsm530281566b.143.2024.12.02.10.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 10:02:42 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so826505766b.1;
        Mon, 02 Dec 2024 10:02:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwjbl9bkYmc+hcM/hiHY8/wSVd+WGKr3FnlKUpylSxRB7zLpai6Rroh+QXsBTtrIijBxGWe8KPpgrF@vger.kernel.org, AJvYcCVNTnhQ+TGtIHfaBaTv5FgNduAtTIwCKYwB4iXcul4C9skf5J7R3K2U+Ubx948vn9fhY6LpRpcoJGl8ukrr@vger.kernel.org
X-Received: by 2002:a17:906:2181:b0:a9a:616c:459e with SMTP id
 a640c23a62f3a-aa59467032cmr2043918466b.27.1733162560648; Mon, 02 Dec 2024
 10:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201155820.29259-1-towinchenmi@gmail.com>
In-Reply-To: <20241201155820.29259-1-towinchenmi@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 2 Dec 2024 13:02:04 -0500
X-Gmail-Original-Message-ID: <CAEg-Je97QmLUrOV+dvg2zbV56R44Ouj4gLwV36z-RdvG-H+hGw@mail.gmail.com>
Message-ID: <CAEg-Je97QmLUrOV+dvg2zbV56R44Ouj4gLwV36z-RdvG-H+hGw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add PMGR nodes for Apple A7-A11 SoCs
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 11:00=E2=80=AFAM Nick Chan <towinchenmi@gmail.com> w=
rote:
>
> This series adds the PMGR nodes and all known power state subnodes for
> Apple A7-A11 SoCs, along with the associated dt-bindings.
>
> Changes since v3:
> - Add "apple,always-on" property to "ps_spmi" in t8015 power domains.
> This is required for cpufreq to function correctly which will be added
> in a later series.
>
> Changes since v2:
> - Removed "apple,always-on" property from "ps_pmp" from s8001, t8011,
> t8015 power domains. It is not on at boot. (Mixed up with ps_pms which
> is required to be on)
> - Add asahi-soc/dt back into the subject prefix, missing from v2.
>
> Link to v2: https://lore.kernel.org/asahi/20241102011004.59339-1-towinche=
nmi@gmail.com
>
> Changes since v1:
> - Removed "framebuffer0" dt aliases. It is not standard and not needed.
>
> Link to v1: https://lore.kernel.org/asahi/20241029010526.42052-1-towinche=
nmi@gmail.com
>
> Nick Chan
> ---
>
> Nick Chan (10):
>   dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
>   dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
>   arm64: dts: apple: s5l8960x: Add PMGR node
>   arm64: dts: apple: t7000: Add PMGR node
>   arm64: dts: apple: t7001: Add PMGR node
>   arm64: dts: apple: s8000: Add PMGR nodes
>   arm64: dts: apple: s8001: Add PMGR nodes
>   arm64: dts: apple: t8010: Add PMGR nodes
>   arm64: dts: apple: t8011: Add PMGR nodes
>   arm64: dts: apple: t8015: Add PMGR nodes
>
>  .../bindings/arm/apple/apple,pmgr.yaml        |   5 +
>  .../bindings/power/apple,pmgr-pwrstate.yaml   |   5 +
>  arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi  |   4 +
>  arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |   4 +
>  arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi  | 610 ++++++++++++
>  arch/arm64/boot/dts/apple/s5l8960x.dtsi       |  13 +
>  arch/arm64/boot/dts/apple/s8000-pmgr.dtsi     | 757 ++++++++++++++
>  arch/arm64/boot/dts/apple/s8000.dtsi          |  22 +
>  arch/arm64/boot/dts/apple/s8001-common.dtsi   |   1 +
>  .../arm64/boot/dts/apple/s8001-j98a-j99a.dtsi |  26 +
>  arch/arm64/boot/dts/apple/s8001-j98a.dts      |   1 +
>  arch/arm64/boot/dts/apple/s8001-j99a.dts      |   1 +
>  arch/arm64/boot/dts/apple/s8001-pmgr.dtsi     | 822 ++++++++++++++++
>  arch/arm64/boot/dts/apple/s8001.dtsi          |  22 +
>  arch/arm64/boot/dts/apple/s800x-6s.dtsi       |   4 +
>  arch/arm64/boot/dts/apple/s800x-ipad5.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/s800x-se.dtsi       |   4 +
>  arch/arm64/boot/dts/apple/t7000-6.dtsi        |   4 +
>  arch/arm64/boot/dts/apple/t7000-j42d.dts      |   1 +
>  arch/arm64/boot/dts/apple/t7000-mini4.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/t7000-n102.dts      |   4 +
>  arch/arm64/boot/dts/apple/t7000-pmgr.dtsi     | 641 ++++++++++++
>  arch/arm64/boot/dts/apple/t7000.dtsi          |  14 +
>  arch/arm64/boot/dts/apple/t7001-air2.dtsi     |   1 +
>  arch/arm64/boot/dts/apple/t7001-pmgr.dtsi     | 650 ++++++++++++
>  arch/arm64/boot/dts/apple/t7001.dtsi          |  13 +
>  arch/arm64/boot/dts/apple/t8010-7.dtsi        |   4 +
>  arch/arm64/boot/dts/apple/t8010-ipad6.dtsi    |   4 +
>  arch/arm64/boot/dts/apple/t8010-n112.dts      |   4 +
>  arch/arm64/boot/dts/apple/t8010-pmgr.dtsi     | 772 +++++++++++++++
>  arch/arm64/boot/dts/apple/t8010.dtsi          |  22 +
>  arch/arm64/boot/dts/apple/t8011-common.dtsi   |   1 +
>  arch/arm64/boot/dts/apple/t8011-pmgr.dtsi     | 806 +++++++++++++++
>  arch/arm64/boot/dts/apple/t8011-pro2.dtsi     |   8 +
>  arch/arm64/boot/dts/apple/t8011.dtsi          |  22 +
>  arch/arm64/boot/dts/apple/t8015-common.dtsi   |   1 +
>  arch/arm64/boot/dts/apple/t8015-pmgr.dtsi     | 931 ++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8015.dtsi          |  21 +
>  39 files changed, 6237 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8000-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8010-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi
>  create mode 100644 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
>
>
> base-commit: 9ad55a67a788c0806b0fe23be36fae6dbfbc3fc5
> --
> 2.47.1
>
>

These seem reasonable.

Acked-by: Neal Gompa <neal@gompa.dev>



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

