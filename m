Return-Path: <linux-kernel+bounces-416021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4249D3F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DB2B2A646
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997413B2BB;
	Wed, 20 Nov 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv3QcEkC"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F3A939;
	Wed, 20 Nov 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117185; cv=none; b=hMBjyCtsTeVpYb7M3+SWalXOk0EDt+XbHpEcyFnbkxv1jzpdQNr/46gjvIPZdamQBP1nN430ZsEoAe2x/go3FMu3MiZiltvK7DEC0MWCJaclcTX5ozIK1ZXWrLpMSUnfN9x8YlUZsScY41Wl3B0+Kt1RrPqt11NOmbKPkHnkj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117185; c=relaxed/simple;
	bh=gvszAwBmM81FZKcpUq0PwEIiHeLEdt1nkAQ9S4kXO5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyW7Sh9fKo12z4vWKsmptxlUyUAinT7Bed6usofhHlhCqZeze4V2bR99INLVoF2Tf+uwrh1DQ3uYKe1edDfwmkejAwmS3prpZVQg7TemkUc04+9CTSvKaLRn0dDwFOLH2i8UgPZ+aGx7V778YOkWXkjzAjiagiXFpXBkDyRwYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv3QcEkC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7edb6879196so1705583a12.3;
        Wed, 20 Nov 2024 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732117183; x=1732721983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GT0pzREV3J2zvk7nPHKF5lsRBHdeeSGwYUopMf2XrA=;
        b=cv3QcEkCQMLGTtc6Y6ZZFkVSEx/QIJCgOwYTqnS/GWvBgDDphO7bOuy2MqJN6/aXCj
         yxhM71muhsyn+XCaSZ10GMoYyYMlN/IntZcf+kP1/4p/JwSeU3whCcLFNAFhUCDf8KyG
         U26+U/4Bcta7yk+BHrGBU+/p+ZD9JnnTvn52SL9Tlv9qwRUOnYB8wlm24zoX7Nlgnnx3
         ix+3CLwfCvQ505Nf4N73l1ZE1ImyW/88onwgEZe8adn/pdWKtzWxmW6+wRcixqRHh9GN
         Mm2vS1wmbscLB8jSlNcSnk3US8d7tisEWNW+whbLwvPU7KKBHjLIPc2Gw+kE3wV12T8p
         RKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732117183; x=1732721983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GT0pzREV3J2zvk7nPHKF5lsRBHdeeSGwYUopMf2XrA=;
        b=Ni1FpBmtbvoMWEcMDOmMTtejAx4+0pk78foTXxVFCb99qTlcpFiKz6zwxbzggbtGcn
         UPoa8xGLvkATDRelyoWB6v+gB0JlkBxelDTtU3FBmQzXDGXVsxOTJ+Ab7X9w0ZBpr3ZX
         hqUwBWKSl5Pj4njgvbRzSP0ayUTU53af5MiGKsNkgppjDMPy6cl+9W9WulFnKtiQhmwt
         RMkrZd0BGqnl5Un8aYLLO5rNvxEfjxSMJcUiTC/aYC4lqg2zEKXcD95vUiZLvCgR+u3X
         YsPuWhQs4VZZSmHkeiWBouTHMwE3EtQH16TJxAe/PpYLEBuf6D3Vcu+9czWm+6NwrYeY
         KSzg==
X-Forwarded-Encrypted: i=1; AJvYcCWuqn5FDFlNrrATXCBgkmG8nsM2Odjz9sB69Ylaa/qnFYdZ+qbDwd/H8xyOuTfKIALNDdmkjI4Gzu5g@vger.kernel.org, AJvYcCXNNJ+MQzahw0+ecd/cNQyT78kRjt7VeKLtFx1ONsgigXeHvSDy5nwC3CC/OcqgMS2dp6uiue1J21M38vp/@vger.kernel.org
X-Gm-Message-State: AOJu0YxabwyiB5o0ZyL3BeRJYRZT+MCs+7AkWnBhWIAUhUXs//OoQUz6
	7RR7rxwYdHPobtNl/oFYtXFMdqjroZWjbjAuLrmw26YbvrSAa1kB9Y8vJJnHJGqvFksAVgSMxFp
	KgfjIsgS5tbGnkxUKf7hpiLbj+wqLtLcIyMU=
X-Google-Smtp-Source: AGHT+IHtExCHm+hnVUXyYz7nTokaTlgnHFY6hCDnZrAs3FKOIXQBuExWWJ5/go5fXw69nnGBgXV/+vib6N/Ya2OTMnU=
X-Received: by 2002:a05:6a20:2587:b0:1dc:7d9f:948c with SMTP id
 adf61e73a8af0-1ddb09139c5mr5284381637.46.1732117183019; Wed, 20 Nov 2024
 07:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
 <20241120135859.3133984-6-daniel.baluta@nxp.com> <11dd729c-df29-4d10-bf47-73e1fa01322f@pengutronix.de>
In-Reply-To: <11dd729c-df29-4d10-bf47-73e1fa01322f@pengutronix.de>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 20 Nov 2024 17:40:47 +0200
Message-ID: <CAEnQRZBh7=niaH_yoHD0uQQs=4GEB89mf_7nqVjfAWums=tTpg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: Add dsp rproc related mem regions
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, aisheng.dong@nxp.com, imx@lists.linux.dev, 
	conor+dt@kernel.org, robh@kernel.org, iuliana.prodan@nxp.com, 
	shengjiu.wang@nxp.com, frank.li@nxp.com, linux-kernel@vger.kernel.org, 
	laurentiu.mihalcea@nxp.com, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 5:36=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutronix.=
de> wrote:
>
> Hello Daniel,
>
> On 20.11.24 14:58, Daniel Baluta wrote:
> > With imx8mp-evk board we are now configuring 'dsp' node for rproc usage=
,
> > so add rproc specific memory regions.
> >
> > Also, enable dsp node because it is ready to be used.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> >  &eqos {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_eqos>;
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index fa4ff75af12d..e6f3ac02689c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -282,7 +282,6 @@ reserved-memory {
> >               dsp_reserved: dsp@92400000 {
> >                       reg =3D <0 0x92400000 0 0x1000000>;
> >                       no-map;
> > -                     status =3D "disabled";
>
> This reverts commit 010dc015b811 ("arm64: dts: imx8mp: Disable dsp
> reserved memory by default").
>
> Please enable the reserved memory node in your board DTS instead.

Thanks Ahmad that's a good catch. Will fix this in v2.

Will wait for few days to get more comments on this patchseries and
then send v2.

Thanks,
Daniel.

