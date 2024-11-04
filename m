Return-Path: <linux-kernel+bounces-394911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34F9BB5D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CD01F2248E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D73175A5;
	Mon,  4 Nov 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu4kk/++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8A6FB9;
	Mon,  4 Nov 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726539; cv=none; b=JBLg5gICa4Y9dRqkUWhdkhzEU5tZEThjFm0a5BSVj3RgJuMWo9fPL6EgGzxrT8HtcJzEEDHjAjjWCLwQ24g8aE3WaqmPC5iXPiX7bnIEAfxVDfohzaj5/zpt4qli97NHsR0u8Ag6g/0PnJXmjluTk0WIQOh1Da8zu+m4G4fnEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726539; c=relaxed/simple;
	bh=Tj2FqFQ7r2b4f3vcnV2ejn2hN8icLGVwIvwRHnFu6LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbAi0VrC0gA9q56bXMTm4ec0CNl+dRjVMLQ7P1xqlUwTVOOFnz+uNx3E/49k8QTGcY4S/4bnK3+E3K3YSdYACw1uGKLhAuy7zq4NUvFVsusMoIEnnaW3hzF3BlOCWO35hcP1w0hGeRryPmEw41Hg3zUJe8Id2Ib4Byv7tISFW+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu4kk/++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA785C4CED1;
	Mon,  4 Nov 2024 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730726537;
	bh=Tj2FqFQ7r2b4f3vcnV2ejn2hN8icLGVwIvwRHnFu6LA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lu4kk/++HaJgFQNzO2vYoHRA/4OazSta4k/aueQRYLiY+Db/YoNkBsR1VUyz55OZH
	 7fDpYM5kelv49kFSvd6A5TRWCyvRbhbMyYW/N5BZar0JaS2+LS1EDECQUm68+4XORX
	 Dfk5XxrJJKdFdkb5EM4GfkVJlbZ15jklzRWWoZY6IhbOEgy9kUz4LYSCoPoo1HGf7u
	 rd1DMHceezwsg9p8g7qodXrAqMlpu4JtqoDTSFv8ZAHOqNXBiSLFYKdt67SCN/jYkh
	 tnR+gsNjFA+L6/Uiv+hNUAB2FZpTmwW91g0TJwvQoZOSvYdBZd0Pc+fq8S1d6QtR88
	 DfNJ7F4zO68hA==
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2e340218daso4124166276.0;
        Mon, 04 Nov 2024 05:22:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU296Lv2CKO3ciTMCzlqJ+TL1Ajg5wTV02xY2Kko7IU7OUuS00mtxSf3cFJ8AW/6VQ9W4lQ9WMhFSGl@vger.kernel.org, AJvYcCVj9ucTu18L3Hmx3KntSf2CPO1frW3957+y9uOunT2tIIP95Amczl4wRQfAAVvRd20At4AXUeEwEb2wSOp0@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGZDSQz+vQgUdaF22Hb6Y9ZprdufCZr1PgkcSOhwUeaAynxbw
	bXtUsEBdqVrMGoVrUr3mctDlu4jcdM8puId+8g4YVbPVB2kZrTkqe8VDkZj802rvWCd4DmqmYwD
	O80kw0G+U8A2qSL5/zD46uSa8Pg==
X-Google-Smtp-Source: AGHT+IGeqHEHHvv5WLP3SxrhgX6E1Sdt1m4eiSmZCbSQ1YICeESTFlOi/vfYQlC2v1SaGAP7PYV4swW7rypB4eXi2xE=
X-Received: by 2002:a05:6902:2701:b0:e28:a4f9:c2ff with SMTP id
 3f1490d57ef6-e30e5b79503mr12339543276.55.1730726537038; Mon, 04 Nov 2024
 05:22:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014193528.1896905-2-robh@kernel.org>
In-Reply-To: <20241014193528.1896905-2-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Nov 2024 07:22:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+QdfZbkeeY2PWAq_5OpeSF=QpcL7OKWpz7byuXNLRG1w@mail.gmail.com>
Message-ID: <CAL_Jsq+QdfZbkeeY2PWAq_5OpeSF=QpcL7OKWpz7byuXNLRG1w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: Drop undocumented SATA phy names
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Wunderlich <linux@fw-web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 2:37=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> While "phy-names" is allowed for sata-port nodes, the names used aren't
> documented and are incorrect ("sata-phy" is what's documented). The name
> for a single entry is fairly useless, so just drop the property.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Cc: Frank Wunderlich <linux@fw-web.de>
>
> There's also this 2 year old patch fixing other SATA errors[1] which
> was never picked up. :(
>
> [1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-3-linu=
x@fw-web.de/
>
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 1 -
>  arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 --
>  arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 1 -
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 2 --
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 1 -
>  arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 --
>  6 files changed, 9 deletions(-)

Ping.

>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/=
boot/dts/marvell/armada-7040-db.dts
> index 5e5baf6beea4..1e0ab35cc686 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -214,7 +214,6 @@ &cp0_sata0 {
>
>         sata-port@1 {
>                 phys =3D <&cp0_comphy3 1>;
> -               phy-names =3D "cp0-sata0-1-phy";
>         };
>  };
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/=
arm64/boot/dts/marvell/armada-7040-mochabin.dts
> index 40b7ee7ead72..7af949092b91 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
> @@ -433,13 +433,11 @@ &cp0_sata0 {
>         /* 7 + 12 SATA connector (J24) */
>         sata-port@0 {
>                 phys =3D <&cp0_comphy2 0>;
> -               phy-names =3D "cp0-sata0-0-phy";
>         };
>
>         /* M.2-2250 B-key (J39) */
>         sata-port@1 {
>                 phys =3D <&cp0_comphy3 1>;
> -               phy-names =3D "cp0-sata0-1-phy";
>         };
>  };
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b=
/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index 67892f0d2863..7005a32a6e1e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -475,7 +475,6 @@ &cp1_sata0 {
>
>         sata-port@1 {
>                 phys =3D <&cp1_comphy0 1>;
> -               phy-names =3D "cp1-sata0-1-phy";
>         };
>  };
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/=
boot/dts/marvell/armada-8040-db.dts
> index 92897bd7e6cf..2ec19d364e62 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -145,11 +145,9 @@ &cp0_sata0 {
>
>         sata-port@0 {
>                 phys =3D <&cp0_comphy1 0>;
> -               phy-names =3D "cp0-sata0-0-phy";
>         };
>         sata-port@1 {
>                 phys =3D <&cp0_comphy3 1>;
> -               phy-names =3D "cp0-sata0-1-phy";
>         };
>  };
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/ar=
m64/boot/dts/marvell/armada-8040-mcbin.dtsi
> index c864df9ec84d..e88ff5b179c8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> @@ -245,7 +245,6 @@ &cp0_sata0 {
>         /* CPM Lane 5 - U29 */
>         sata-port@1 {
>                 phys =3D <&cp0_comphy5 1>;
> -               phy-names =3D "cp0-sata0-1-phy";
>         };
>  };
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/ar=
ch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
> index 42a60f3dd5d1..3e5e0651ce68 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
> @@ -408,12 +408,10 @@ &cp0_sata0 {
>
>         sata-port@0 {
>                 phys =3D <&cp0_comphy2 0>;
> -               phy-names =3D "cp0-sata0-0-phy";
>         };
>
>         sata-port@1 {
>                 phys =3D <&cp0_comphy5 1>;
> -               phy-names =3D "cp0-sata0-1-phy";
>         };
>  };
>
> --
> 2.45.2
>

