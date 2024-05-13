Return-Path: <linux-kernel+bounces-177552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21E8C40A9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF2D1C22C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5FB14F13D;
	Mon, 13 May 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIKpq9JJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC814F119;
	Mon, 13 May 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603091; cv=none; b=GKYitgAvci8zLqtPYPyq2iZSTYwxYhHXwLU460ScERJN998sJ9cndkEpAxNsQS5V2/F6cRoxS/oRFa3kj0XWu8Lv1/AF1tuk5QYkB3cLSJgYAl5L25mKgBn5KIwwC2TOx0hFA+OwsquzkpltmoAFQhPnj9IpTJgrqqMvaNLZB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603091; c=relaxed/simple;
	bh=gGMG42Zz0ybZm0xvlkq65MZ8X026PNiCDiLOel1ltDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUaMMhbLRl8O04yx81mfJY5bHDMswFFiHldy6kgsm6ecmJ/LIx0+i+dmXpLZ3wKmRs+yj1Cy/aJ21rBXVE6q3Jjn/YC7PTp/4WmxYL7+bJO94Wlyd9E36JSTmsza7TNWgsTlM3vm3T30xrAAE9QS3cp7/5Mp0uS0gWAXTsHR5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIKpq9JJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eca195a7c8so35356885ad.2;
        Mon, 13 May 2024 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715603089; x=1716207889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uEdXqbZ7OmVXroYRzO4MQldyt0w8o8Vs1CnZronQ5I=;
        b=UIKpq9JJGtwlNf48WQcj7Z1grGybPE+RGeu5VmxrOH1SOZpdWlzcAxNiFBWWusOYBb
         gOT/mstx9RKYwTspIik+qtbqqu/linUrCaimQP3Wu8BUiYZTjxw/FjDyXyr7+Kadw31w
         uj34izmOO8aZkg4BPvcWsix6MJhQmgKsjsqI4GdjeDHcZcYeHynAA5i6hez1996IsVO9
         kABLSNzytUVsIg8fV/Ba7s33dzPRsdljobB5xZtf7A2sVr2sxEIl1Ap5n5zbxdqZqhZd
         CNZgziaTJ+Tt8zoI/sdwtGkLqjRK/Y/3JAcuPDdbxcIGC8sY4bYAz4CXhJxsBFOyHh3l
         bmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715603089; x=1716207889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uEdXqbZ7OmVXroYRzO4MQldyt0w8o8Vs1CnZronQ5I=;
        b=WIiqPlmpAjts4YIlNnbJ4Odk1efI2rWsGMntRcAHlzbP5Wf/uj1I7Eiwu3rViv0Kag
         UF4V9U7Nsj2wfT3mRMWIlzuVy5jYNUwSZRlCUkHeODGT8wVz9/kMFfPpWB70y4ePtyGe
         3b9h68h2ae21pkWz4wOVyRvlavvZVlPOMO+PiHyK2HYB8wMVxCAmQ+AS3j/PXqdwCv17
         yG9Iw2Vi+ixcy7LzQ2eNNEJMVHZswjjajzNwvSV314R3KuEoASsT7nr+XO0FUWVlJ4m6
         nNgEdopRE1kVmWFjNpf470Gk2ISHVp95aYAc+uei7BMdIw6G3QQXBDTLf3HdJX3XREIs
         On7A==
X-Forwarded-Encrypted: i=1; AJvYcCXbAgIHHP3vSIxI+e3GHjKBuuQE+Qy5s61F0I31CJu7H4jjWTvTC7sR5mQcNyKsQyioKvn99nxlvMyyrXmutnRMZAewbfjds4RV76RaQlLysv+3ex47+Yjr05D0yYtf5wsq1qCNxNgAXA==
X-Gm-Message-State: AOJu0YwEU/N568RYF7MmzjeHI6qvzla4vYYpWW6CcOGG9h5AzxembbgW
	YpAc3DhTgH0VK59W3tW6Wa3ix5ivZdahFUyvjqF/as5+QntVdVKiGzqNe1fEqN1LIfl8PDJY7YZ
	ftVfplsoZcNw3DqukNsKnzlcH0Ko=
X-Google-Smtp-Source: AGHT+IHdqWutAgLlnkeZq9lfl0ycFYjE0nnS3IKxHwLVKS8LDItaYXZI9kZ+SBHOfXOhLhe5WXWhAIXZE8Bv1REbIiY=
X-Received: by 2002:a17:902:e847:b0:1e0:f473:fd8b with SMTP id
 d9443c01a7336-1ef43c0f5f4mr119026505ad.9.1715603089219; Mon, 13 May 2024
 05:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305004859.201085-1-aford173@gmail.com> <20240305004859.201085-2-aford173@gmail.com>
 <CAHCN7xLsEvP0A3mQJRzX=nXGr30WD4RU9vQVw9ynqzSi6cDNRg@mail.gmail.com>
In-Reply-To: <CAHCN7xLsEvP0A3mQJRzX=nXGr30WD4RU9vQVw9ynqzSi6cDNRg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 13 May 2024 07:24:36 -0500
Message-ID: <CAHCN7xJGnutJ8szxqG+AHyEU5ULOMAcn8Q21N0=FBp18EYSqmQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] arm64: dts: imx8mp-beacon-kit: Enable HDMI bridge HPD
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com, laurent.pinchart@ideasonboard.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:18=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Mon, Mar 4, 2024 at 6:49=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > The DSI to HDMI bridge supports hot-plut-detect, but the
> > driver didn't previously support a shared IRQ GPIO.  With
> > the driver updated, the interrupt can be added to the bridge.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Shawn,
>
> Patch 1/2 has been applied and sits in linux-next.  Are you OK to
> apply this to the IMX branch so the hot-plug detection can work?


Shawn,

Do you want me to repost this patch separately since patch 1/2 has
already been applied?

adam
>
> Thank you,
>
> adam
>
> adam
> > ---
> > V2:  No Change
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch=
/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> > index a08057410bde..fba8fd04398d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> > @@ -304,6 +304,8 @@ adv_bridge: hdmi@3d {
> >                 compatible =3D "adi,adv7535";
> >                 reg =3D <0x3d>, <0x3c>, <0x3e>, <0x3f>;
> >                 reg-names =3D "main", "cec", "edid", "packet";
> > +               interrupt-parent =3D <&gpio4>;
> > +               interrupts =3D <27 IRQ_TYPE_EDGE_FALLING>;
> >                 adi,dsi-lanes =3D <4>;
> >                 #sound-dai-cells =3D <0>;
> >
> > --
> > 2.43.0
> >

