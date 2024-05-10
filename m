Return-Path: <linux-kernel+bounces-175211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A09A8C1C65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FC6282FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4213BADA;
	Fri, 10 May 2024 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exc4bzm5"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F933EE;
	Fri, 10 May 2024 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715308048; cv=none; b=oj2xBtH2LEjumhZjTNuwoOVTNoWL2fYlQqtStBC3oD3kLq6tzYyjcIr1lF7R0SGLQPt4ixN1PDWhjwTz8zt/tlg2qYdvcg9kf9ZAR4mJZhJafWys7cbf08SWTrshcbhaNhIscq1r6PUyYXubesMd2o+YoxVpxlaPrfPdOY6uk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715308048; c=relaxed/simple;
	bh=bvd3blX+RJMgsJ0g7k7yJaqxHwFVzRJsAHzoNG3fBQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEOB22SQwQOHxtO5YUjmoEZP0F9vucYbOHYq25wo/WUmbRXlJjqeIbUyqOea8iqKakk9koyRbN3ILlkMLPBpl72vRzCpnnT/PzOTudaKsE2+898EFRAZwV9hFP3+tE10+z70KBrA2c5LYk6qQBPEhgX8g/Vj5QsJx2On0RqvPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exc4bzm5; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e180e2b288so72833539f.3;
        Thu, 09 May 2024 19:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715308046; x=1715912846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJIg9+M0Tl5oWYiRO4lX+sJC4I6tROA3nCXlHyRlexU=;
        b=exc4bzm53+DMrgywo+dPJvA1oFvg0LXy2WVa0SOGBLCrfy1TFgjctwhJpH6/eQg51Y
         TQu0f6wMg9dgp/YSdjYRSN1jZZXZ8bssZpvLOTxS66C2v3DbBwFSa9m9ZurdfZoI3re0
         qKkv3TfwyDIAIroNzmB8qzdmpyhHx0h8+htGrYzMkBlgNb3GZRBYZxs7u5TxeXoqYjUt
         ySYC+sDH6RxcEU1dZIGqzuIyuDDRFJ2Ppv1mfTdKQ361vOiucYr4QhR5VE/+9qp7loVP
         J9aCE/qo6l1hqCBfhPBhahgSPUxz3d3hmSSDGlu/FHut1mb8JdrGw29uDo47WScZG03z
         kB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715308046; x=1715912846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJIg9+M0Tl5oWYiRO4lX+sJC4I6tROA3nCXlHyRlexU=;
        b=TKIUl3tkSGGyA2OcYwravdE7MSJpMdgnQK3TCEMsbCafmfw6y3pHqOF1Pkt+MADbvv
         r3HHPvKHc4RpcUUN6ZL93wDDQlLZj24t4X6JEhFNyz2GnMGDvYYVrFxbO56FMtb2sgGw
         2BALw+qYtKywZoTN9VKwiqCKSwQrIVT+ZyF+VHqabMTbfxAQryCIYP+Hx65LS55XnIG4
         KAUskrydwUZRDcRclE3IzW2iER4B5gZoOa71MWSNMjuMDZh0vRMftOY+BUqSXcL57V20
         1Etgn7ktB+zZYwDOhEOQeyNreZS672Z3lQVAvERum8tw0LS/t7Gx2USJCplOkmT5CXrt
         IdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+fRMxUDxDrz2+aDIB2cGJzdUJfX7/Det4ttA51KTLiUFINkoXgpnVW3HteV7WMGZ7sjEBigdvUmVLV4c1eqW0vOL7GDyXDSox+qTS0c05Xf8upMXd3VC3UOUZhcHLcj0+gSY2SRWKSUDO2/ktQnuOE3GsNN+jkCaicneICa41rA0D3TRY
X-Gm-Message-State: AOJu0YzL10dk4i+ji8FINVN2Xin5o1kkDVet90zKvkHi8WzldHtQddEs
	culMKaPnYooGsEIUaIxLaSb3XNNp/+seD441VQYtwg4qUmJbLANZet0RYM2A1rB3hKAmbS4+NBw
	TAjoqgW969U5COZC89IfmkeVmB/M=
X-Google-Smtp-Source: AGHT+IHBDYC2n71XP7WOuLCEc5J/fR/L9KPq4RQs/MbDRpyTSl0Iy+I8EcqM5V65ejYgeqpob2OgmskIn0fzTVIGW24=
X-Received: by 2002:a05:6e02:1387:b0:36a:3f20:8cb with SMTP id
 e9e14a558f8ab-36cc14ae0dbmr18245525ab.18.1715308046371; Thu, 09 May 2024
 19:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
 <1715223460-32662-3-git-send-email-shengjiu.wang@nxp.com> <20240509-repurpose-dumping-156b57c25960@spud>
In-Reply-To: <20240509-repurpose-dumping-156b57c25960@spud>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 10 May 2024 10:27:15 +0800
Message-ID: <CAA+D8AOkDbj_QsF9VescuAfFjKcB8FnOXqwjXVrrBM1Ck4ut4Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: fsl,xcvr: Add two PLL clock sources
To: Conor Dooley <conor@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:14=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 09, 2024 at 10:57:38AM +0800, Shengjiu Wang wrote:
> > Add two PLL clock sources, they are the parent clocks of the root clock
> > one is for 8kHz series rates, named as 'pll8k', another one is for
> > 11kHz series rates, named as 'pll11k'. They are optional clocks,
> > if there are such clocks, then the driver can switch between them to
> > support more accurate sample rates.
> >
> > As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
> > clocks and clock-names properties.
>
> Despite the detail given here in the commit message, the series this is
> appearing in and one of the driver patches makes me a bit "suspicious"
> of this patch. Are these newly added clocks available on all devices, or
> just on the imx95, or?

These newly added clocks are only available for the imx95 XCVR.

Best regards
Shengjiu Wang
>
> Thanks,
> Conor.
>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Do=
cumentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > index 1c74a32def09..c4660faed404 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > @@ -50,6 +50,9 @@ properties:
> >        - description: PHY clock
> >        - description: SPBA clock
> >        - description: PLL clock
> > +      - description: PLL clock source for 8kHz series
> > +      - description: PLL clock source for 11kHz series
> > +    minItems: 4
> >
> >    clock-names:
> >      items:
> > @@ -57,6 +60,9 @@ properties:
> >        - const: phy
> >        - const: spba
> >        - const: pll_ipg
> > +      - const: pll8k
> > +      - const: pll11k
> > +    minItems: 4
> >
> >    dmas:
> >      items:
> > --
> > 2.34.1
> >

