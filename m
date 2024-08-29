Return-Path: <linux-kernel+bounces-306256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9544B963BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC01F256EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946E9176AAE;
	Thu, 29 Aug 2024 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qefp23w9"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6C16C853
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914215; cv=none; b=fOeoyZ6oXW6K3mP0jkvuz1onpQoExPndxPDvLkNHYncvTJNCBGahdBdpSJUrf1ZwNhTNdNgt0L3DqJKLRUvHTlNnSpz5ZC1s/K3Yv/2jaPNP0okJkyGvihHeKUeR+pYth2JvxNrkgDWepuv5PKZjZcGb1vBS0vJuRIwCpfMlyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914215; c=relaxed/simple;
	bh=C774xcfWLXiYC7HVHXCktC5RtuHU3NRdVERX0aWozKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq2NF1n2bPgI4XV/sxIVQxiY2XgRK1k3gHNcK8M9o9P9IQa4Z8HMAYNbw1RIoPVNellc9bMYQ3kaN/6HuSPJDuW7SAJ73SeCkAFtZ/bnhhVyngGX9Q/Bdjk+WAK4XJ3ToUaG5MWLC73Fd3hBlTRnO1it/8yLwfQwV/eTUu1tNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qefp23w9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso2883681fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724914212; x=1725519012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTbYTU+eEXbesQ1w5uX4PXo79wYQYLg5UgyyuYRsTM8=;
        b=Qefp23w9mBseSKX3RfSEvjF6bOdPkZmi019mI3LD64HK7lQRodhXedxKbBt8DcOzH/
         wB3JCe8f6GV5xa5dUjOSTO4t+CJsJDjDtyiulIMKzEdOwNXBxaU40NlTbXKLlVYyijOf
         3GUW22aLoADXxzCrZsu+Nk8OYlnITH+J7GAhDaN7j3R2YFQGVRJUjwqDEHPzWIkUCLRs
         z8twE+qu1SZjuLMb89MOYkEPAwvv17epFoMC2mL3PlF1azpwT5yHCNUU9DIdLq25qprD
         aTl64AxQDXw245TYAOORoAFL2gL1MCfWfxJ6fOG/is8mbcHkM8v8ISI+6M3ejY80e+G/
         xDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724914212; x=1725519012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTbYTU+eEXbesQ1w5uX4PXo79wYQYLg5UgyyuYRsTM8=;
        b=a2o6yp4iicPXnsD1O6yL82egyXaj4O1Huzmy9XMUflDI9s1hIBY7khy50wQeMVR/W+
         UVQ4TzXRB1KEhpcHH4xNIVu3Pc5goYtMs3KvmNXnbg2b14EAeJEiIYNOCyff1vuWaCsV
         Ndjl2rSKuZOBTamgWkI/oyI0VDezqm6+0g43pt+V2zBsHKy2r4bbJNWhdrKyhoHTx9Gb
         KAVsCHCmdJu+orEnkYw7ttOobXymrK2tzIJBzLQ/MeBiokouSXyibTbc1azNW0fpqQg6
         ZMedfWYctVHEP++NirpGheQJq///YhrW7DqCZ1gUUmNiltVmH5SxDsvY95R+m+DnxJZ5
         HImg==
X-Forwarded-Encrypted: i=1; AJvYcCUPJpljmvUZk5SvrNVCsGCb0Nv5q7fcuAaJVM/ymoN5sQ+TqWQL/C/HFG5hj5YN5jIdQcYZdDhJ4A+qixo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGuDhft4G6P48R77oSNMKyPjcvMRHccFlWmzDxuUNK7N/3Si2
	hLvpJC4DwiwNFJPP+EfO3qukzYndZqHOeU9cC5UveE/Td0qgYDQZDHhDgnL/T5w=
X-Google-Smtp-Source: AGHT+IFD1KFQKXHD2NsxEWGSGcXcBDNM5IA3aCJrru/ZgnQkD8KFd2PJDDxrXBnQQUmUPXuRwBUgtw==
X-Received: by 2002:a05:651c:2226:b0:2f5:2e2:eafb with SMTP id 38308e7fff4ca-2f6105b5e21mr15165451fa.7.1724914211870;
        Wed, 28 Aug 2024 23:50:11 -0700 (PDT)
Received: from linaro.org ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a3f5sm317407a12.2.2024.08.28.23.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:50:11 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:50:09 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"abelvesa@kernel.org" <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND 1/4] dt-bindings: clock: add i.MX95 NETCMIX
 block control
Message-ID: <ZtAaIRQqC15QPoMQ@linaro.org>
References: <20240729012756.3686758-1-wei.fang@nxp.com>
 <20240729012756.3686758-2-wei.fang@nxp.com>
 <Zs7jvCHO+ifC3VaT@linaro.org>
 <PAXPR04MB8510AE921AD67C110F135BB988952@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510AE921AD67C110F135BB988952@PAXPR04MB8510.eurprd04.prod.outlook.com>

On 24-08-28 09:31:08, Wei Fang wrote:
> > On 24-07-29 09:27:53, Wei Fang wrote:
> > > Add 'nxp,imx95-netcmix-blk-ctrl' compatible string for i.MX95 platform.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > index 2dffc02dcd8b..b0072bae12d9 100644
> > > --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > @@ -17,6 +17,7 @@ properties:
> > >            - nxp,imx95-display-csr
> > >            - nxp,imx95-camera-csr
> > >            - nxp,imx95-vpu-csr
> > > +          - nxp,imx95-netcmix-blk-ctrl
> > 
> > Move this above vpu-csr, please.
> > 
> > Also, for some reason, this patchset doesn't apply cleanly.
> > 
> > Please respin.
> > 
> 
> Okay, let me update my local tree. I use the linux-next tree as the code
> Base, is this tree okay?

Sure.

