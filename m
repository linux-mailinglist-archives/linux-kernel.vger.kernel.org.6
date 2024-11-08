Return-Path: <linux-kernel+bounces-400923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ED79C1403
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160AEB251B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A86208A0;
	Fri,  8 Nov 2024 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH0+7OV7"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46C1BD9E5;
	Fri,  8 Nov 2024 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032582; cv=none; b=h5KS6pvtcwDgphSDMKId1ooT2zpd5QzWFs4yLgqpFmiuFa5e7jIDaakj/ySy3EMYbgWaHW6Aw5O6Cg4+6/PTLePLv8+JrvPCQqLOp9h3Fx28MTzDnfT35i/UmIEt14KgH/RW/3CryU/u6mVJp7Xk9s0YkQYeR3nYr9XC/+FfZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032582; c=relaxed/simple;
	bh=APyRPtDpOSsz2jYrIwghzGR2bt5juoTmWmJTI3E01SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyQemkoivcKqktlQJpiaCT2HtO+oic1QrKhQbFgmEbff4FuLkB0xycSeKXVTHU2WqGjpsXw+Cl984mvo+cUo/VO+5Qrjx28gumGuxUxNDs8MvIojb6F/h+XPBpVU9+D0yVMuz323AJdis60jHt3qrViegIoa0ObzEz1kxvIxAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH0+7OV7; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83b430a4cfdso65229139f.2;
        Thu, 07 Nov 2024 18:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731032580; x=1731637380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR7AyViXmeWGMVONEZ/pRYURocoexzHBT2dgSZdiLJc=;
        b=PH0+7OV78FktjzbAzGnpQ+abNnFE4Q9THdTtcSovQIzPO4uzUEFCtdtiCmXRVoHnoG
         HO0GsJznOb9j1xPEJlrB7oTgyBjzLX51iU6TxIRcT/Nw0u75pfIL1LabasSHdzO5F/Nl
         7GSdLKPFTdXaybUyJR03UkRxgJOC5uLY4gYA65dVCBNnsi5OYSbzcWd3GQMZkpCELQ5Y
         WigTW1c+euGe/hViR61wMyp7+khn6iZcABWS7++KY2YQiX9Dsk0LS7H3DRlaSS55vbV/
         XWAgAWprzzgKu+dCWDZ4G352lX49+OWifT+CB6sO/mOgqOxvucXqrIPQx151SSwKbQaL
         UWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731032580; x=1731637380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eR7AyViXmeWGMVONEZ/pRYURocoexzHBT2dgSZdiLJc=;
        b=fN8pmBgFr3M1NzGHZqbNlyefC6myQuALLRHRgOrZnNycQrnK+hOqlD8HOSWgBCYNT3
         /YGFWZvS3AZxxNPsZid+e9OwMn5aE39WK/XRk3Atg5607d0vPURZVIki69jOZq1dQkAo
         jz3EJwhJpC70zOxWnCJo5RFNb23n7OVaSuoT7iEyxUdTaQssIf+1QciITuywDo4K06tP
         veGIFO0KvfguCrdH0PoElfAxhdDHsUMFIxQe9v+pOEhTDyqaD5XcWkzpinZhmsGz3uqf
         KJsf5JdbLl6q2RTqDBEDbFQaTq2LhHPn4QOMm3NOWf0oMgRMN2r3zFOLklV21R3zXAon
         j0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVy26YY/00d3ondo02iVpsP+KJlvae05CeQ8Xv5RewqrAvxYED69ACvsMyRFN82K4hKGwyKzx1kQLDMbnnd@vger.kernel.org, AJvYcCWA4CwNS61iKAIXVihxt5wQKNMoEf3I40S95KegSzZxCo9P5u37iXSg2Bf2ZfCL+4sMjYtr/foE//P0@vger.kernel.org, AJvYcCWIpgnnfaLtiysNK+Aurv0lhWEMaYQ/iqZSirDPGbWTSO0CI/p3EyZ6PkuJEJVjzkfOWj/xtfnTEg+R@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUfWymNObWIQQE8HVfWD8MNfhxB4cQRKZibb/sqS2K1fSfUZK
	r0RTyDLNtrSf2/pFXGMwErrXnkQqic11ubFKpZDvImcTShLOWEYMVXxJFBkwT7SB5TxoBqZOngV
	vuwtAHRUxwBWR/GruKhmkUA9DbXg=
X-Google-Smtp-Source: AGHT+IGQ7gpv66XfauvZZ5t0zmt5b2BZyWV862s4RrmNacvxmqQJFFeOQYZ68mwOrld/NXiqMMkWEyD3aFFzolHNfM0=
X-Received: by 2002:a05:6e02:1350:b0:3a6:da79:12bc with SMTP id
 e9e14a558f8ab-3a6f199ff96mr15159245ab.7.1731032579956; Thu, 07 Nov 2024
 18:22:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
 <20241107102008.3626023-4-shengjiu.wang@nxp.com> <Zyzod4k+LNkpJdMA@lizhi-Precision-Tower-5810>
In-Reply-To: <Zyzod4k+LNkpJdMA@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 8 Nov 2024 10:22:44 +0800
Message-ID: <CAA+D8ANhznTNCt5RqaF17GMYHqYdggMpR_LOWuP4GX5ECApHzw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as SPDIF
 IPG clock
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:19=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Nov 07, 2024 at 06:20:08PM +0800, Shengjiu Wang wrote:
> > IMX93_CLK_BUS_WAKEUP is not accurate IPG clock, which missed
> > the clock gate. IMX93_CLK_SPDIF_IPG is the correct clock.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
>
> This should be fixup. Add fixes tags.

I will update them. Thanks.

Best regards
Shengjiu Wang

>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> >  arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot=
/dts/freescale/imx93.dtsi
> > index 688488de8cd2..56766fdb0b1e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > @@ -925,7 +925,7 @@ xcvr: xcvr@42680000 {
> >                               reg-names =3D "ram", "regs", "rxfifo", "t=
xfifo";
> >                               interrupts =3D <GIC_SPI 203 IRQ_TYPE_LEVE=
L_HIGH>,
> >                                            <GIC_SPI 204 IRQ_TYPE_LEVEL_=
HIGH>;
> > -                             clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> > +                             clocks =3D <&clk IMX93_CLK_SPDIF_IPG>,
> >                                        <&clk IMX93_CLK_SPDIF_GATE>,
> >                                        <&clk IMX93_CLK_DUMMY>,
> >                                        <&clk IMX93_CLK_AUD_XCVR_GATE>;
> > --
> > 2.34.1
> >

