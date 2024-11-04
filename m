Return-Path: <linux-kernel+bounces-395214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E89BBA5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8011F23777
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7691C07F6;
	Mon,  4 Nov 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dqioo0hv"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBEA2BB04
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737937; cv=none; b=ilJo0FK/r1EA6Vy273HEVMQ92E6/iGr/D3Mcj3Q/2/kOfKvo0+mB2YfkO3SMHEdCX3mvYH08BIb1YFYYmpyk0nExNBH6RVxAMSYiNvSlJ313ftpIw5VwO7YvI0TE5Gd48UdYVnXftF5DMQz6VAKmlg1VjPvHScb0WZVAFGwlG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737937; c=relaxed/simple;
	bh=sGi3fK0LjnVxIOV1LLmeuJSH/YuBzL60e0cJVML6LeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POYnASnXJ+v0DsnOc9h9EWbPZx1cIKRXT+YuEPTBpSI1jsuLiId+7DEbKl0mIRGWjTpMisW/77WCaF3L/saGgT0iEu2vEnz9E4XLugbZybPey2+1MMmfnUSAI60wFmbBjQRsVt2oHMqDWxXnpih8JyWdYxkp7MYRI2HWKqcbhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=dqioo0hv; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e291f1d659aso3988799276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730737934; x=1731342734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NvqcwznYJEbOfJTrxk1An08MpWkBKh12Fm23xyda6E=;
        b=dqioo0hvkrSZm+QpHe4XHQmTbNXK0x5VoI4sMIwCUK0S6Cx+TwjHeQa5TdnAZ9l6WK
         LZzkgGvCKlOSJq8CZSADfHwQOz3ypjcLuzvQl6t7IxXfEM2vJ3kGCECM2ghhEB6+vRFp
         rVMS/712CSyLptalqhv6koGUpnZoY3KshwFR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737934; x=1731342734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NvqcwznYJEbOfJTrxk1An08MpWkBKh12Fm23xyda6E=;
        b=XEIn9pGBhg3VQ4GydU53R2Yp4jOBFyaH2vnj4PObWohzICyO5Uk8ypJ/UYHhYpOakK
         MKctSQxQK0rWujovKOLmXegGHHl25DdRpw1GJxHp7kfDrPXfaYQaL6Q25b06qK0ID1HV
         iIQe8q5YTsVLEddKCFExzouRqgDFOPNibPRHZem4AkjaeHbPcs8BN+GylZj1v0ywLeaA
         DOvyzDziSPewBi9V/P7V24DgFwGNay8Rt54Vdh7FzdpzVj/2WXg6JEo6z+Muo/5xNTjC
         D40TVrgYvZwHa72tVMK1ilwjSWWt8HW7zmFem7kyBLggaof/aeMqGhCWZGUp7uNmYS8n
         Do1w==
X-Gm-Message-State: AOJu0YwAbZXyDQPrzjq6ZMCeQTCdqg3166XsM93S6BwhiwvNbQo8QTWA
	bi14lWpW7rdPecCXh5NtqrMByw5aYHy+KKG2yPAUzv16R82CrBvFKTuzHcPZMgOPPZWiUO3Ll/a
	RQgn02SyL29wU99dpisRODoYkHEZR2B8e6xc3qg==
X-Google-Smtp-Source: AGHT+IELYvUmczkoinr/h7h4D5wovUbn46OmYDOIs9EuWMuur0hSgIUPkzT189bHxP5gqhspJGZhWZ+bvDCtj3+rRX0=
X-Received: by 2002:a05:6902:10c3:b0:e2b:d610:9d67 with SMTP id
 3f1490d57ef6-e330254f5ebmr11392789276.9.1730737933890; Mon, 04 Nov 2024
 08:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
 <20241028102559.1451383-2-dario.binacchi@amarulasolutions.com> <20241101173914.GA3786619-robh@kernel.org>
In-Reply-To: <20241101173914.GA3786619-robh@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 4 Nov 2024 17:32:03 +0100
Message-ID: <CABGWkvrC6N4ujWfJSVyktyyAODUM5TTucFneqsX1H4PQK+nbvg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] dt-bindings: soc: imx-blk-ctrl: add
 'fsl,power-domains-boot-on' property
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Fri, Nov 1, 2024 at 6:39=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 28, 2024 at 11:25:24AM +0100, Dario Binacchi wrote:
> > This property lists the state of the power domains, indicating whether
> > they have been left on or off by the bootloader/firmware.
> > This information becomes relevant, for example, in the case of supporti=
ng
> > the simple framebuffer.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >  .../bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml       | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-=
blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-b=
lk-ctrl.yaml
> > index eeec9965b091..00aa0b8d8ea9 100644
> > --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctr=
l.yaml
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctr=
l.yaml
> > @@ -56,6 +56,15 @@ properties:
> >        - const: csi-aclk
> >        - const: csi-pclk
> >
> > +  fsl,power-domains-boot-on:
> > +    description: |
> > +      Provide the on/off (1/0) status of the power domains. It allows
> > +      specifying whether one or more power domains have already been
> > +      initialized and left powered on by the bootloader.
>
> Sounds like a common problem *if* we wanted to fix it in DT.
>
> Why can't you just read the h/w registers to see which domains are
> powered on? Perhaps because some are on, but you want to turn them off.

I checked, but there is no register on this platform that indicates
the on/off status
of the power domain. So, I cannot readout the power domain state.

>
> Also, for simple-framebuffer, I think you can list the power-domains to
> keep on.

I did it; I added the power domains in the simple-framebuffer node, but thi=
s
doesn=E2=80=99t prevent the genpd.power_on() callback from being called. An=
d when
this callback is called, the power domain is re-initialized, which does not
maintain the persistence of the image on the display. Adding this DTS prope=
rty
prevents re-initialization that has already been performed by the bootloade=
r.

Thanks and regards,
Dario

>
> Rob
>
>


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

