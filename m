Return-Path: <linux-kernel+bounces-275686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB394886D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D96280D46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41E1BA885;
	Tue,  6 Aug 2024 04:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AofDpENf"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364564A8F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919019; cv=none; b=mDKh5mcBC+bmquL2oqVGOI/LlWI86rwvokomfQCpCtUDIAPgxlE1TmK03y42WSNlu7E/3n3u1eQsYyXG6vS7TBq7jOQOKh8CnkUUiigGba/TWOyl/wIe8vh81820KBEaeQGLwjb92BDODEEMnk5fKXSqdmyVcdi7M31lOX5kesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919019; c=relaxed/simple;
	bh=C0XbZuk8zqHuNcCHOb0mh6FpNfUNRP/FVzL26YJzAgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0SSwV3BkCYURaHXP+NqQkK3MZt0axomynMD6GwZeA/10PG5Rqb142X85CrGDlD9pc1zBQDgVGNsQnYgtFavvTawWOVLY52vCBqYRDjzqEjPFRxE1so/rImBNOHWGtIU224QBr+9mhtWAcPEE6JXV+cXJZLJicBvlgPb4HlgDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AofDpENf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efdf02d13so285626e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 21:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722919016; x=1723523816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjQAjmGk1n7ajuQcs+KaJPCMDM2UdVWblEx6MXLoPhk=;
        b=AofDpENfUp4qBUa7CJCBRyBEEiy+nvUdns4YxLuAObZrq7Uf04SKIZfPhb09pIda1n
         WlOlEAUr7DymrFAlhzFGgBux+IX8alHXAqCCHQbddZVKymFRyaPdOepWjZYOGT3SxdzR
         ggmJEEsFnmaQ/uCpInQyQmPh0JFzqsvFpd7n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722919016; x=1723523816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjQAjmGk1n7ajuQcs+KaJPCMDM2UdVWblEx6MXLoPhk=;
        b=PxXn08txppcOKMnEGZ8xDA9PzyCnNT8nl78yaX+cyCNd3xBVcZ6ilN2V6Xmc8iRj5t
         RHygwGKsIM5k0Z/kWA2EQ9Jq8Px4UTu+0f82PUmFAamk7ucjxcBNoktramgxjmSYGmH2
         9bYWa/Y4RpEFgIz18Xg51RJ+0PEswDg/ueP2nJxC4/9LX3GzeNxAM5PUAL86HOpcd5Ko
         Jvc8nVhvsYYGHSpEe7K12r1qrZyQeEdpfX3Mz5MRC4GekXg8FTG23lEkqBmLwNXn80n5
         5dM5G2xL3+xW2qjkqCnNLBvjeePuaR79QFC+2BoTv0CLWqnuF2Z2ZzTT1cyKFUUZYsn8
         7jpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjh7JzXvZ5/IThLgx16kSYMvN4XmgQ5rpcdTZLESrSc6kI/DdaMFqipnQD83ziDFJiGWni8g9/8FIwr7cB+Bu1RZcr1CUoUFT+LHo6
X-Gm-Message-State: AOJu0YzMAG2h7SdzB8i0g8J0i7dRMP7iFnv3UE5qzjT+nmmtEjcZbWO7
	ddSRUEPjZxSEx2+6Bs8/B/1I6g8e8ZPIxyIr+wlCiQtedCYFL21nH+unqMjBSkcPa2qqFJF4jtN
	Ox1tW5OI8uh09+4Q62hsucunpM/hcwTiDGtpl
X-Google-Smtp-Source: AGHT+IH6osN8AiHIsz3iGxVmsYDHTrZXNZkckgohptXBOcaV4KXsXzyqgFu5HOFrpie8oXsv/eCahc96/S2ayEDpeWY=
X-Received: by 2002:a05:6512:2308:b0:52c:9ae0:beed with SMTP id
 2adb3069b0e04-530bb3bc202mr11441300e87.52.1722919015831; Mon, 05 Aug 2024
 21:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805065051.3129354-1-treapking@chromium.org> <8e089dc0-9342-480f-ac8a-93b5bfe1241e@collabora.com>
In-Reply-To: <8e089dc0-9342-480f-ac8a-93b5bfe1241e@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 6 Aug 2024 12:36:44 +0800
Message-ID: <CAGXv+5GnkhyT+nKq7j50G+Lpm720wLX3Jqfa5QWP6p29yUKq7Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Remove clock from mfg_async
 power domain
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Pin-yen Lin <treapking@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, Kiwi Liu <kiwi.liu@mediatek.corp-partner.google.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Enric Balletbo i Serra <eballetbo@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 7:46=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 05/08/24 08:50, Pin-yen Lin ha scritto:
> > This clock dependency introduced a mutual dependency between mfg_async
> > power domain and mt8183-mfgcfg clock, and Mediatek has confirmed that
> > this dependency is not needed. Remove this to avoid potential deadlock.
> >
>
> Uhm, have you tested this upstream with Panfrost, or only downstream with=
 the
> proprietary Mali stack?

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

With glmark2-es2-drm on linux-next-20240805:

# glmark2-es2-drm
Warning: DRM_CAP_ASYNC_PAGE_FLIP not supported, falling back to
'mailbox' mode for SwapInterval(0).
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    glmark2 2023.01
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    OpenGL Information
    GL_VENDOR:      Panfrost
    GL_RENDERER:    Mali-G72 (Panfrost)
    GL_VERSION:     OpenGL ES 3.1 Mesa 22.3.6
    Surface Config: buf=3D32 r=3D8 g=3D8 b=3D8 a=3D8 depth=3D24 stencil=3D0=
 samples=3D0
    Surface Size:   1366x768 fullscreen
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[build] use-vbo=3Dfalse: FPS: 134 FrameTime: 7.485 ms
[build] use-vbo=3Dtrue: FPS: 391 FrameTime: 2.559 ms
[texture] texture-filter=3Dnearest: FPS: 378 FrameTime: 2.652 ms
[texture] texture-filter=3Dlinear: FPS: 329 FrameTime: 3.046 ms
[texture] texture-filter=3Dmipmap: FPS: 369 FrameTime: 2.717 ms
[shading] shading=3Dgouraud: FPS: 367 FrameTime: 2.731 ms
[shading] shading=3Dblinn-phong-inf: FPS: 372 FrameTime: 2.690 ms
[shading] shading=3Dphong: FPS: 342 FrameTime: 2.930 ms
[shading] shading=3Dcel: FPS: 338 FrameTime: 2.964 ms
[bump] bump-render=3Dhigh-poly: FPS: 336 FrameTime: 2.978 ms
[bump] bump-render=3Dnormals: FPS: 376 FrameTime: 2.663 ms
[bump] bump-render=3Dheight: FPS: 328 FrameTime: 3.052 ms
[effect2d] kernel=3D0,1,0;1,-4,1;0,1,0;: FPS: 316 FrameTime: 3.169 ms
[effect2d] kernel=3D1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 118 FrameTime: 8.5=
11 ms
[pulsar] light=3Dfalse:quads=3D5:texture=3Dfalse: FPS: 372 FrameTime: 2.692=
 ms
[desktop] blur-radius=3D5:effect=3Dblur:passes=3D1:separable=3Dtrue:windows=
=3D4:
FPS: 51 FrameTime: 19.764 ms
[desktop] effect=3Dshadow:windows=3D4: FPS: 191 FrameTime: 5.254 ms
[buffer] columns=3D200:interleave=3Dfalse:update-dispersion=3D0.9:update-fr=
action=3D0.5:update-method=3Dmap:
FPS: 49 FrameTime: 20.746 ms
[buffer] columns=3D200:interleave=3Dfalse:update-dispersion=3D0.9:update-fr=
action=3D0.5:update-method=3Dsubdata:
FPS: 49 FrameTime: 20.437 ms
[buffer] columns=3D200:interleave=3Dtrue:update-dispersion=3D0.9:update-fra=
ction=3D0.5:update-method=3Dmap:
FPS: 53 FrameTime: 18.997 ms
[ideas] speed=3Dduration: FPS: 117 FrameTime: 8.554 ms
[jellyfish] <default>: FPS: 282 FrameTime: 3.559 ms
...


Thanks
ChenYu

> Regards,
> Angelo
>
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > Fixes: 37fb78b9aeb7 ("arm64: dts: mediatek: Add mt8183 power domains co=
ntroller")
> >
> > ---
> >
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8183.dtsi
> > index fbf145639b8c..267378fa46c0 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -872,8 +872,6 @@ power-domain@MT8183_POWER_DOMAIN_CONN {
> >
> >                               mfg_async: power-domain@MT8183_POWER_DOMA=
IN_MFG_ASYNC {
> >                                       reg =3D <MT8183_POWER_DOMAIN_MFG_=
ASYNC>;
> > -                                     clocks =3D <&topckgen CLK_TOP_MUX=
_MFG>;
> > -                                     clock-names =3D "mfg";
> >                                       #address-cells =3D <1>;
> >                                       #size-cells =3D <0>;
> >                                       #power-domain-cells =3D <1>;
>
>

