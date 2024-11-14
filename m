Return-Path: <linux-kernel+bounces-408596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C549C80DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E6C1F21592
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144371E3DE6;
	Thu, 14 Nov 2024 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1t3BCKd"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198772F5A;
	Thu, 14 Nov 2024 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551881; cv=none; b=cFEsx4e+0bJedso3CNxOZpglfjzBP0nlkHmy6mPy5IeWs27iMrZ9yhvim8qF4Fkp4czWPckduSJw8QyJerYt8xBKgLaFpu+6VpJxgP5FTpIEbwR/MGU4asJ6fXoyGt9psKJ1neUYNP+1VJf2uXKX1YnPCWbHvIdcmDIvB54WzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551881; c=relaxed/simple;
	bh=S4IFutQpnD3EFzpHxLT6cMh43oP/wbiKwdQWUo6R1nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggVxsUkORZvOk5J8ZHcs4FcTNYeqfRCHPLhQN93D7aIKUmdw9JLjAiAiXVym3uRpa8oKUyec1QgVtrk2sa/GP5KVglPH6eDPkcdO9hpedlCeQrOw9ZQehSu3zUPcKvGHyduM5lFSBXPaJyhJ9Hz4K/bqao+joQFsqCvOjvPTR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1t3BCKd; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a70315d38dso451305ab.0;
        Wed, 13 Nov 2024 18:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731551877; x=1732156677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StFhRyIpCM9Uu8eeMJnktRCq06AyyCXEprdzl0A/TJI=;
        b=K1t3BCKdzjIqY2VfoORbSKqwnrxejncR+867IvpfTzKT3fCdPU0ptNcpUk3QDYn1Vz
         kXFT92bao/wvCoRDgnD0ZqCSKr2V5Su/yFvGAxlsq3mPtcv/Uyah0F8Cmsnmd6Nu2hSy
         y8nmscmrK7qK0SDcJnGr5siUuXi1zXWtDF1A9u7ultdZBPObBrOtt2tqU01ehppcVvxX
         JrDfymq89b1WBMwcHu+uAMKr+XFEZ0+ABxVqyVWAt8oaGWZHKOVaViKpQXky+nK5Z1lf
         ZtGYdojARxjYA61J/FYprTMkruqVnYgrT3EyL6TzbzuF1OgsQAmbc6kADc6SlFE0zi5q
         SLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731551877; x=1732156677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StFhRyIpCM9Uu8eeMJnktRCq06AyyCXEprdzl0A/TJI=;
        b=YfVYOkU9XCO2qc2vWmV313/2XgsI79ng659cOovXW+6yczisCM/S/v1h2NflWTNqtl
         fDVUAjSXXrMQYJyPI/CU2T3Qkfp42koP9elGbdpsF8ddZb06i1LnsYiISXJnoniFTBHC
         ZfWTN0J2LlaEeEHDwuc4CsrpqCWL7aj794+kIlmhwci86/9c3kJazPKJFNULD5Vt4ofy
         P37htM3vp91/79PFNbFsb1a7VjxbLJPBPNn6QyS0MCR0eksspuvjAJoQpsrIxCDWVxCX
         adCbq4j+hywhBibRMOB54Nn22qqmtkUDw4A7C1k1nhMCalp5RWzy21xKbIDGbaZj88Q9
         mNfw==
X-Forwarded-Encrypted: i=1; AJvYcCUFhTon12sfxT3SfVn9bjQnVkUjt7f10QWhoOOYoJ081zb6qr8d4btdxxnHzr0Mwo45JiEIDGpNS6RbtQbo@vger.kernel.org, AJvYcCVwl51g+0PITM6a5+F96cPvSkehF/4CPQM+Ncn1kyQz8I7giYHQ6hqOb7/EoiKndhjBhdhyCjEdUx4/@vger.kernel.org, AJvYcCXFqoYFbrTwHPe7w3/DI2Z/cPs7wFZcm2Ie9LTC+iOB7d3TuiApd2JAf3q2m223dZtdB2Hi7A0q1zT4@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDNNYdD0rZ/sCiHTT88eA2T0dPZPAV8mjVte6tl31sHoZ0DKB
	JU/aAHC5RwLFCrYdUAE50goxj4WZG/sGDBxmmyhuKZvErKI1LIY+Uma0PAOaSaGw8daiGTgcbDd
	6Bs+XgPDf8xS8I42ZHsOPiU0lFp4=
X-Google-Smtp-Source: AGHT+IGcTJSj30ycrQ3ffIAZN66OsQquO1B46KfWjrwu9f3E/Tq4Zk70MH8L6VADeTi2CDkmD1g2VJE9cA/VEkQCcgQ=
X-Received: by 2002:a92:c56d:0:b0:3a5:e1f5:1572 with SMTP id
 e9e14a558f8ab-3a71fed5de0mr5894775ab.22.1731551877130; Wed, 13 Nov 2024
 18:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108100759.682260-1-shengjiu.wang@nxp.com>
 <20241108100759.682260-4-shengjiu.wang@nxp.com> <PAXPR04MB84596DD01E6A066A621F590188582@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84596DD01E6A066A621F590188582@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 14 Nov 2024 10:37:44 +0800
Message-ID: <CAA+D8AP=cdyvhtzDib8-T5GuHU9pXhPVgdomTQj8R=8CCFr5HQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as
 SPDIF IPG clock
To: Peng Fan <peng.fan@nxp.com>
Cc: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>, 
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 11:11=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH v2 3/3] arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG
> > as SPDIF IPG clock
> >
>
> This patch has a fix tag, but the other two not have. So the other two
> will not be backported and cause issue.
>
> So use fixes for all or drop fixes for all.
>

Should I add the one same fixes tag to all 3 commits?

Best regards
Shengjiu Wang

> Regards,
> Peng.
>
> > IMX93_CLK_BUS_WAKEUP is not accurate IPG clock, which missed the
> > clock gate part.
> >
> > IMX93_CLK_SPDIF_IPG is the correct clock.
> >
> > Fixes: 1c4a4f7362fd ("arm64: dts: imx93: Add audio device nodes")
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > index 688488de8cd2..56766fdb0b1e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > @@ -925,7 +925,7 @@ xcvr: xcvr@42680000 {
> >                               reg-names =3D "ram", "regs", "rxfifo",
> > "txfifo";
> >                               interrupts =3D <GIC_SPI 203
> > IRQ_TYPE_LEVEL_HIGH>,
> >                                            <GIC_SPI 204
> > IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks =3D <&clk
> > IMX93_CLK_BUS_WAKEUP>,
> > +                             clocks =3D <&clk
> > IMX93_CLK_SPDIF_IPG>,
> >                                        <&clk
> > IMX93_CLK_SPDIF_GATE>,
> >                                        <&clk IMX93_CLK_DUMMY>,
> >                                        <&clk
> > IMX93_CLK_AUD_XCVR_GATE>;
> > --
> > 2.34.1
>

