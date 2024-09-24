Return-Path: <linux-kernel+bounces-337436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C236984A18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18CF28432F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A2178370;
	Tue, 24 Sep 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3qorGeM"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FD2E62C;
	Tue, 24 Sep 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197385; cv=none; b=BDbjzoZ44epUtrOMdgJOpFehe5MM5LN+R3Y6Q8DXmGZlwhgPMoACGmYOeIrlHPiP5AxFSueWgqDBXfioCj7XPfGkB5CzOKRbolkEY8v1me0kkyuLxvqBTPtjTryu26nRzKpXupD00snV6Zw1cSKv+VZzsDILQzdl1ICeoYzJiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197385; c=relaxed/simple;
	bh=2OpMkPIwvrCs1mSsYtTeavFVMt2m/J/G+IqR/gjs/6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGa3k93qndaveKPbZc9uHrdPGu196ITBz5EMlNSCJgom2I6HnzXDZlCvH7J9gnrXLC6kqQ32dHhsxyMOviVisKAmM+Cezq16IZdMmtjMjotCHVXzHuAFtYOVi0XpBkLsWPJhzPgoHNY0uC5bsVsSvbD+4VFlOQ6Zv63sc6NQQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3qorGeM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d86f713557so3787124a91.2;
        Tue, 24 Sep 2024 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727197383; x=1727802183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ri+GAU/GeYWJ7kAA7IwGhSHyAI6OloJr9cBh+i/4KD0=;
        b=g3qorGeM/nqwA/yQgd16Lfjo7p23qgQkTtDF4mL2x1eWYEsF/G9930SxLaGZq6rSzu
         rzSxSu4cxoVPuU2cfOw9TNGlT4cwIyicSGxZ5kTsQg9C//cYlNaWBuhytigSWCx6muIv
         xbXr+Y6wCIhVcHVZxcFKOD49AfAw76uSX9b81tMafaLvleZHM3WtW8jPp+PTthU/gsJ0
         EQTUJQAoP8mAClZeswShooBQFEz2FEoI8HozOVezQ8Gsi80pIq7nfBnjYBJRp6dwX+EO
         oSkyBG5gRvSAVsrkzFpSHuJBR3LgWiL3Zhf3vX296pk/i8DVT9hmUAm1lRcSsIEGv0eV
         fIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727197383; x=1727802183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ri+GAU/GeYWJ7kAA7IwGhSHyAI6OloJr9cBh+i/4KD0=;
        b=s+OExVg4Wtk+E4tJypGgrbt4/BepPklZe3kJsiAhxDbtpFRgdrwuP+ZFmhqgkY8TsK
         Cek8BwLpn4SM53Rt6YZph8T5f0ZMOfRatsvn45LfZgkcchk1jvItj6KAHXg7ybBOrc83
         fnnssAnhY5IyI4JsKp88gbpsh41ptgJoYE43IQ2nNLdAFh/2PAKrOkoCeaYX0BfkW/64
         uycDjCIUwYBtPxRDSULJ1ifsGypNXKwUmLbbQkUCAi4zqjgW1FP47Eo1b7FSKV9pT4ny
         CumwySLPVFqWLnd0ziUpfCW48WCwuFjdfskDTKtMkQ6jTVoh8SnZQdNCHfEvYAZHIpXB
         ND1w==
X-Forwarded-Encrypted: i=1; AJvYcCVMaPNqLTCJ+14PkfLkq9Fd/eoJqhP9/wSNwQ4P86q1j6YzsE/+rE76h8scdyUVRKQiy0fpDNoVl3sx@vger.kernel.org, AJvYcCXQiVtQjsOwJIfGZizSvGOsXEAjeDc08BEix9hrjZ7nJ4LvPVyGu+JF2pSPc44V76YpDXHvTTb3/GDAJfQU@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/GvgHJqZCErpOwiNZe4zhkC/G9xMo6xt3Z+Zl+2NO4VHudIp
	UUzmzw7iFeuD6CJJjkv2HpWMrtk8Q4Jrn8xqFHKbFLX3wA0LMKNq
X-Google-Smtp-Source: AGHT+IFKCI4MDKi4ygHlEjuHRjdP+HLRKNnYJF/sTyPhgmEdcEPM4C9gNFo1BFv48YUeTBRut9mF3A==
X-Received: by 2002:a17:90b:1286:b0:2d3:c892:9607 with SMTP id 98e67ed59e1d1-2dd80c175c9mr17637988a91.12.1727197383448;
        Tue, 24 Sep 2024 10:03:03 -0700 (PDT)
Received: from joaog-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd837875d2sm9908018a91.21.2024.09.24.10.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:03:02 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:02:54 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: freescale: imx8mp-verdin: add labels
 to som nodes
Message-ID: <20240924170254.yx4v2m23evppfa6l@joaog-nb>
References: <20240924114053.127737-1-francesco@dolcini.it>
 <20240924114053.127737-3-francesco@dolcini.it>
 <ZvLUmqM5FWqKPxoi@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvLUmqM5FWqKPxoi@lizhi-Precision-Tower-5810>

Hi Frank,

On Tue, Sep 24, 2024 at 11:02:50AM -0400, Frank Li wrote:
> On Tue, Sep 24, 2024 at 01:40:52PM +0200, Francesco Dolcini wrote:
> > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> >
> > Add labels to ti-ads1015 and fec ethernet mdio node to make it easier to
> > reference them from other nodes.
> >
> > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> > index a19ad5ee7f79..e9518b7c7aa8 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> > @@ -320,7 +320,7 @@ &fec {
> >  	pinctrl-0 = <&pinctrl_fec>;
> >  	pinctrl-1 = <&pinctrl_fec_sleep>;
> >
> > -	mdio {
> > +	verdin_eth2_mdio: mdio {
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> >
> > @@ -591,11 +591,12 @@ hwmon_temp_module: sensor@48 {
> >  		vs-supply = <&reg_vdd_1v8>;
> >  	};
> >
> > -	adc@49 {
> > +	verdin_som_adc: adc@49 {
> >  		compatible = "ti,ads1015";
> >  		reg = <0x49>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > +		#io-channel-cells = <1>;
> 
> Why add this? it is not related with what descript in commit message

The #io-channel-cells property is required to reference the ADC
node as an IIO channel producer in consumer nodes, otherwise, DT check
warnings will occur. I agree that the commit message could be improved,
but I consider this a minor issue. Would it be acceptable to keep it as
is, or would you prefer a v2?

Best Regards,
João Paulo Gonçalves

