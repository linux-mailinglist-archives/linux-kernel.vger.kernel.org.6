Return-Path: <linux-kernel+bounces-175218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418F28C1C81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCC21F21B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDDA14884D;
	Fri, 10 May 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXZ7yQLv"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43F3308A;
	Fri, 10 May 2024 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715308724; cv=none; b=nUOyJIq3BapdxtjQWqNuU/7xHxbptEvsGJ66Ku8m8elvjS2b9uaa2k7knQJpuzn5pQ0zcINDZSNyz4IJnGmfRX6BTJwMjfPBZ1o8iMnTHxjbNmVYJwjTGNNThK8ahoRDmAPAdgu0wQD2fkVoZj0EbU7rjNc5N4RK4OjLoOX0TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715308724; c=relaxed/simple;
	bh=jddQeaqQrXTs71+YmSJw9dqzVBsK8JP9xHEAhWEFVmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeAz37py6fsd9VuH9EOghlgtrbxJ70YzTF0HxQgFzgdwXLgcv4H8UcEbEvkt81Z8EUB/TAlPFUtIJC7i3f8fTULiQisleVqe+nzNIsstETsP8QhBFkGbIsl0tMRH/ONodUyqJLXicUiUHYc7R9hv93AAfaEAIR2xqs+nT9t+N2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXZ7yQLv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36c846689d1so7046825ab.0;
        Thu, 09 May 2024 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715308721; x=1715913521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+FQEvC344Cq4qFk7Z5iGhz/jJmHyyWFQPf8LCbmeGM=;
        b=BXZ7yQLvRQQ+AdQbx6C4SUGhS4ctmMsFAjFrxaE5l+FLfSWTfXP9kP4M94O1nV+eZt
         er0PYWLx2HIsgFzn0d0dkRMOtj+HrF8Lngo737UVvg3glh8ymW4RYzgYrhlV4bjdzI44
         B5u5aLHzzgt4b+ZdACtCdw1sBWru/ydTXqnNcULwwYeq5G/CzbzoCB44U+uaYFXQ4TeM
         tgID6R0m0PGDYxMAmwKRxnCtQnV4kneTYNVefo1a7jsRWb6cbZVw81x3mt4OBNCzKgS9
         fwCh1pUftgi1oOLulC/iYL+0YpmaNJo3LGYK9P1Nid7pQMnPrKtdVUbJmc51Wm1UQPtj
         CQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715308721; x=1715913521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+FQEvC344Cq4qFk7Z5iGhz/jJmHyyWFQPf8LCbmeGM=;
        b=e09UF7vQTjlvp54mCZeWlKq/4yuS8hrrMZNTBu2xJjOCGx/mVFANsba6Vw5hNtF54Q
         f+YZWSgQ6Nawf6kxeNT8r54J9qpaX89zrgoV3I8uyYzCSPLXaRRuvrqCiY690qJVlA/d
         Gn/kSp7XU+gnztyzBhZph20d3RJN8uH7AQWbhT9XsPxT2LGAFPZMi/+Sp5OIItgGTGeg
         Z74qVuC6n8yUZ3HH+LHDi+eF1yFRlsGIYgRhX20F4tkUNFv333Oz5y0c9oxnj6IJEk96
         gAozbQryrRY+oO8+SmKO1A8t0THIj2F0HWj2ywftru3n3R3NvdSmWGRDme8dwnlZVTqe
         4tyw==
X-Forwarded-Encrypted: i=1; AJvYcCW/neL0rn57Sjy9ngfPdoC29UtlDdO+wjoDYkdMc0d2RK+xGeJSe/Oj1nfC+rtKymL4xgO/oGZfDOn6W6KtdWHbu4DaSWcrx7Y1Bd9yQDYgMk9Smx2GHwHfYrT4Ix+sfyEnyr0ulDrmhQI3fhXftcOac48EBpjgOwaDYQ/YG/EhbO8c03rC
X-Gm-Message-State: AOJu0YyIJztk1GZjJqzn2TvqPiLkBpC433NY0jh8uhDunWKIAsBRKoji
	xLjkF/rdqAHkJIT1KLfP/w7WJIl8mnEEQUww7ZjAPaI1pi6FYDR4DJVwiory3VZ1O6LKB+2m3ur
	9Qqwv5jize1uK+bTmEAKUfoaoI+h9GsvQ
X-Google-Smtp-Source: AGHT+IFA5hOZHgUdtXLvvH+1m+oDwQZM9Yg+0AcRzMwCh6Ow6b69t1K2O1QS7dF85eTT8GVCCff9RckTga5FTH0HhIE=
X-Received: by 2002:a05:6e02:12ce:b0:36a:2a57:9393 with SMTP id
 e9e14a558f8ab-36cc144b65dmr16566235ab.3.1715308721696; Thu, 09 May 2024
 19:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
 <1715223460-32662-3-git-send-email-shengjiu.wang@nxp.com> <20240509-repurpose-dumping-156b57c25960@spud>
 <CAA+D8AOkDbj_QsF9VescuAfFjKcB8FnOXqwjXVrrBM1Ck4ut4Q@mail.gmail.com>
In-Reply-To: <CAA+D8AOkDbj_QsF9VescuAfFjKcB8FnOXqwjXVrrBM1Ck4ut4Q@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 10 May 2024 10:38:30 +0800
Message-ID: <CAA+D8AOQtwHTLsQcqh_LCvVP5CWXqiHc3-at8jv3B-kA8ORR_w@mail.gmail.com>
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

On Fri, May 10, 2024 at 10:27=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail=
com> wrote:
>
> On Fri, May 10, 2024 at 1:14=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, May 09, 2024 at 10:57:38AM +0800, Shengjiu Wang wrote:
> > > Add two PLL clock sources, they are the parent clocks of the root clo=
ck
> > > one is for 8kHz series rates, named as 'pll8k', another one is for
> > > 11kHz series rates, named as 'pll11k'. They are optional clocks,
> > > if there are such clocks, then the driver can switch between them to
> > > support more accurate sample rates.
> > >
> > > As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
> > > clocks and clock-names properties.
> >
> > Despite the detail given here in the commit message, the series this is
> > appearing in and one of the driver patches makes me a bit "suspicious"
> > of this patch. Are these newly added clocks available on all devices, o=
r
> > just on the imx95, or?
>
> These newly added clocks are only available for the imx95 XCVR.
>

Looks like I should merge patch1 & 2 together, patch 3 & 3 together. right?

Best regards
Shengjiu Wang

> Best regards
> Shengjiu Wang
> >
> > Thanks,
> > Conor.
> >
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/=
Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > > index 1c74a32def09..c4660faed404 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > > @@ -50,6 +50,9 @@ properties:
> > >        - description: PHY clock
> > >        - description: SPBA clock
> > >        - description: PLL clock
> > > +      - description: PLL clock source for 8kHz series
> > > +      - description: PLL clock source for 11kHz series
> > > +    minItems: 4
> > >
> > >    clock-names:
> > >      items:
> > > @@ -57,6 +60,9 @@ properties:
> > >        - const: phy
> > >        - const: spba
> > >        - const: pll_ipg
> > > +      - const: pll8k
> > > +      - const: pll11k
> > > +    minItems: 4
> > >
> > >    dmas:
> > >      items:
> > > --
> > > 2.34.1
> > >

