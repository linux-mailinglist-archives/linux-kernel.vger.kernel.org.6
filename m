Return-Path: <linux-kernel+bounces-444603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5599F096A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AA6165D70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EC1BFE03;
	Fri, 13 Dec 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mIegUPR1"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26D1B87E3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085660; cv=none; b=mPtH1o65pzSwUDr0vHtS1IX7AwXaCjXklx8R4L164EpR01YzPCbgCs42c2DHzAuFD/mSAyeeDcUWRoiN1gQ8V9CpacYUEAxBl7/Fze+qwuR6+HwKDaYpQYr9QaIS8sYPRsjJd07SUxCuLOWpYEM9LJDb7+4LduY/afVye+cHuHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085660; c=relaxed/simple;
	bh=Vv/kdwvOFAD2D7I9lSzGtcndmi+6+0l6EG303RWQO94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2SYCTSeDMjbuFKjfyZVdvMVMzriwUkEkEpcZgWP4ZstYFJchwubaF9TNoluN3gmKAOdLpOQyd2OiAnrAYZk+nhhrDa5uIRBcegRCNCm7a9ZPPbBMGySTZMbBh9/jMlhdxatKvsuhvciH+sBuR8z/8+0/FK27GBlfJwZwyWYi6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mIegUPR1; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb8559b6b0so833048b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734085658; x=1734690458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/OBIbUmmLhH6ku2Q4LAkA6a0Sfj3H64xsbU21U06po=;
        b=mIegUPR1LHa0vnT3POBetM2YMZngrysDfTZXfFoZYMHIFWGLsyARxHPqlMU8JaneXE
         /HXhIoRGOtkgDMaoozRLxRxtz570NdvooJot0oqn/iqbKqZL8lHfiFJ5c7NFmJc0jDwK
         JFPU0KOQvat6NSbqIVwC6Qae9WCeyUq8yWKzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734085658; x=1734690458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/OBIbUmmLhH6ku2Q4LAkA6a0Sfj3H64xsbU21U06po=;
        b=aLKzk0KeCs1h8yD1ZmVl8I6i5ZYN2B/FE9ePtrsalgWms1nbW849A4H1rXIeAfupIj
         2zc6DMHTHUr+tONVjv4pwRGycK+YR+D9EQclPs6Mqga92YggDYHzGDdBxXisvv8do3JL
         I81EBO+QQNqALaHo+QNci2vlV6GV/sY50c049MAigL0i45r7GxWbADru91YppEslPWz5
         q4I3kfkv6ckV8eCs/Dq3ccNQrA4N1huRZN0qfFj11JkeuHV5AETwmT6aJi9ynsruRVU2
         rOX/EBuy2b24/ST/KMp6KzoBtNxC6WfYgNqa3A2lPhU/1AAds0i1u5dJLFjyMd4wnjqV
         fHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4n97559gXunGEQIGGLrQRw99qXyYa1vTujGxy53VrEnX0x53aeWHfMJAsnt/n/b7HF5rz52UfBR9vPmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFMi4Oe1WlrOKB5sOFw67j1iKvauBXzF/q9Rt+kDHvyk92u7c
	vJF9pa3qzQVLjAWBeKWIus5xC4j31BH0Ez17Eq3aYknujKuHI4/4bFHPvJoIQmRyhkMBOrvHn1I
	8XBCea5lXTeJsaDJa6KNfjRPj13o8FKjnM11C
X-Gm-Gg: ASbGncv/fj42fXirh9530IGZcd88gHBLassJah6wezmHrsTiMZYC+eSQsw1xYI1h9MT
	NuVpMumz/1b8LBdgzCw6a8F+gHw0kROxCdbHL/ebociHzmiQUUFJDrqOGCQ3XU/0I
X-Google-Smtp-Source: AGHT+IESbjIDYq8Dv7WLZv3lnv+V/UUSCvVg2kJFhXxDh3T+YFv70IgQ6Vlt7dxY7YDS3GWUp1Xn0M9xXxcOalecsrs=
X-Received: by 2002:a05:6808:3447:b0:3ea:5be6:a68a with SMTP id
 5614622812f47-3eba68640b4mr591582b6e.15.1734085658025; Fri, 13 Dec 2024
 02:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213095044.23757-1-jason-jh.lin@mediatek.com> <20241213095044.23757-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20241213095044.23757-4-jason-jh.lin@mediatek.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 13 Dec 2024 18:27:27 +0800
Message-ID: <CAEXTbpfOv876s3NLTO3oMTtVi_BwBtgb-816Gt5ZjKMjTZZKQg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dts: arm64: mediatek: mt8195: Remove MT8183
 compatible for OVL
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
	Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, 
	Fei Shao <fshao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Fri, Dec 13, 2024 at 5:50=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> The OVL hardware capabilities have changed starting from MT8195,
> making the MT8183 compatible no longer applicable.
> Therefore, it is necessary to remove the MT8183 compatible for OVL.

Similar to patch 2/3, we need a:

Fixes: b852ee68fd72 ("arm64: dts: mt8195: Add display node for vdosys0")

>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index ade685ed2190..137ee8929e01 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -3138,7 +3138,7 @@ larb20: larb@1b010000 {
>                 };
>
>                 ovl0: ovl@1c000000 {
> -                       compatible =3D "mediatek,mt8195-disp-ovl", "media=
tek,mt8183-disp-ovl";
> +                       compatible =3D "mediatek,mt8195-disp-ovl";
>                         reg =3D <0 0x1c000000 0 0x1000>;
>                         interrupts =3D <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                         power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSY=
S0>;
> --
> 2.43.0
>

Regards,
Pin-yen

