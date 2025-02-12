Return-Path: <linux-kernel+bounces-510453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BB3A31D16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86B2188A4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA831E7C07;
	Wed, 12 Feb 2025 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwuK3068"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB174271838;
	Wed, 12 Feb 2025 03:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332138; cv=none; b=N9k4saBqFt/wzadR2GxahOrUq7rlmDydCCQlRQg7YDhrSKA6s/co+85ah5dur8LaV56+BGp/mswogkhkfLkWw4S0Bfq+SefWxQlqpGjN7afejGV/X+wNIHxq7eotHU6OGM1CBS46kqZJtNh4crx6aZFqdINykYhcLe5ibM7XVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332138; c=relaxed/simple;
	bh=Tu60nQ1Ayd/KSwNymWx/IJ/AfafrXcJ87nUpbCbFfjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lhhm0tUliB1aj3Yt/Xhso4L8FbvvY5ghocuLByx0iXC33Oh3qFNDl0cIM1BSVqIcOWxHthTDoXWtallYyA++SrtKYmGFsLhzSJTJQEz/NUTC/ZPlerkDxfnvMjxZwtPh5WebrTQUBU15Hh+lh6MB706UP+OyzBoTpqcDP3cWa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwuK3068; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d15ce78fecso23775855ab.2;
        Tue, 11 Feb 2025 19:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739332136; x=1739936936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcryBZKe0HwOZ15GXClthjY5efiSUbIeZQ+SYJvbj2k=;
        b=UwuK3068rttsK9spyF5Oo6MvVjr6CW2mg56JRoPGX4A6CENFzgN6N31xtiKUw0iSfQ
         Vo/c3tzxU60HK880qVr8sf+Cy21PeC49mhYXDftCW18DMvsJC57cx9XvvjqsbiY3Xagw
         ItEil1YzdY28ZmTkQvPuFjSjdMKHlUqyg5ksVUuGZkoc8NVtWfEiPlZoMXDQz0kZJcL/
         7BSX0OxMu2fAOAdIWX2dhaYB6i5h2aa+Cl/ZNoyVTvrt4/5cANBYSNPSBGdI98P1bfkV
         aY6n0OQRfLpLIY0H+EaN1mtjbCcl/dbigutR4ouDmGU+Tc28DisH8WOrOT03AP1oWU8J
         FMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739332136; x=1739936936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcryBZKe0HwOZ15GXClthjY5efiSUbIeZQ+SYJvbj2k=;
        b=jCXyYRwlUAV8zbDX97AlVIRQhu4cKM+CffkfYyElr2La+D0MQYpwtvNMZjdUM5sEgX
         FqTrtoyF5Lyi7xyfs3b6W6t//1GZWACfx5TsT8EZ/rrRPt4EOxNr6FIry3S8hdPojJ/w
         5UBVCLx7vUwkrkeesDx8LaHEC+zJDqT9udBZpa8JpOPdCNDhiYAk/0m5u5XcD3zi5l7d
         C5QnKjSZlTxpOoNhJHYyRc5pDFFyonMjHKLABz6FLo8LwkbBsyjEiepi4piC/tGHnpNs
         KMLoV4RZMdKQ7jnxxvFCKjUh3SoQ5c5WgzLvlz/oUkj27aGdY9ZQH3cigCfFvrYESoxE
         0kdA==
X-Forwarded-Encrypted: i=1; AJvYcCVMq5uQXgcfRGHDrP2GHdEYfR/STY/4wCO5CwrK8C/8X4dh0sKCrldKKKLoYzFX2eImSsBeX3tEXtXQ@vger.kernel.org, AJvYcCWNEPKuTbvEfzapWAag40a9w54/2m5s30XHXo30PhHHq2uJvolmM1RsSMka+/1Nx7LDp/kevIGHf+NyEB0=@vger.kernel.org, AJvYcCXoRo7hV+BUSmAQeNgRw72YLM1Uom9T7fqtHqrT+73dGtoViI/TpImgLLOONxI72I6ffPmPfDT4VOzYE9zw@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkkdVH6/zE+boAhF7UP8c9vcmVD9ipCGsZUOSF7fYP/iKlUhe
	ERxSsatarUhcCnvw4MmOoC/uRExA2zNbjwVVUZJ4DQSFZQzd4Z4kgx0VWVwgtRwBaC5OHAIcr3n
	8HyhGnyq//ibRPcN3sVr+PdDTyHk=
X-Gm-Gg: ASbGncuO9Dzs/fcYUUSpSP06cXWVZDqUNq2ag7Rkyx+a1endiBgsmYDtLyDGYN82rET
	vqAnULr2YJWGcuKVKSvARnMlJxsj/nXvxZW0LS2Ebj/hjzLoFB4JjLpas2y0AcNLawhnR3Xp/
X-Google-Smtp-Source: AGHT+IFCnz4li/5IWRttFgFQdRpTdkwg/3j1LKC5VF8mycMo5avGb6iiANRdvRcmxPBkiquPSP6pJyx2R6uQlujKUaw=
X-Received: by 2002:a92:c54e:0:b0:3cf:cd87:1bf9 with SMTP id
 e9e14a558f8ab-3d17c21cd04mr17637315ab.22.1739332135646; Tue, 11 Feb 2025
 19:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211035737.3886974-1-shengjiu.wang@nxp.com>
 <20250211035737.3886974-3-shengjiu.wang@nxp.com> <Z6tuFp9nZFMJMgDa@lizhi-Precision-Tower-5810>
In-Reply-To: <Z6tuFp9nZFMJMgDa@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 12 Feb 2025 11:48:43 +0800
X-Gm-Features: AWEUYZnXrLA9vESn8DWyjyXL304FuAyCkB66xQG7feWsbb8dSRpLkjhc6mEjDb8
Message-ID: <CAA+D8AMyXVdAWOTGHtrOyXjSLiMioAhZ1awepX3nproom87azQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: imx-card: Add playback_only or capture_only support
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:34=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Feb 11, 2025 at 11:57:37AM +0800, Shengjiu Wang wrote:
> > With the DPCM case, the backend only support capture or
> > playback, then the linked frontend can only support
> > capture or playback, but frontend can't automatically
> > enable only capture or playback, it needs the input
> > from dt-binding.
>
> wrap at 75 chars

On my side, there are in 75 chars...

>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/imx-card.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
> > index ac043ad367ac..905294682996 100644
> > --- a/sound/soc/fsl/imx-card.c
> > +++ b/sound/soc/fsl/imx-card.c
> > @@ -518,6 +518,7 @@ static int imx_card_parse_of(struct imx_card_data *=
data)
> >       struct snd_soc_dai_link *link;
> >       struct dai_link_data *link_data;
> >       struct of_phandle_args args;
> > +     bool playback_only, capture_only;
> >       int ret, num_links;
> >       u32 asrc_fmt =3D 0;
> >       u32 width;
> > @@ -679,6 +680,10 @@ static int imx_card_parse_of(struct imx_card_data =
*data)
> >                       link->ops =3D &imx_aif_ops;
> >               }
> >
> > +             graph_util_parse_link_direction(np, &playback_only, &capt=
ure_only);
> > +             link->playback_only =3D playback_only;
> > +             link->capture_only =3D capture_only;
> > +
>
> if only use once, needn't local variable.
>
> graph_util_parse_link_direction(np, &link->playback_only, &link->capture_=
only)

sound/soc/fsl/imx-card.c:683:53: error: cannot take address of
bit-field =E2=80=98playback_only=E2=80=99
  683 |                 graph_util_parse_link_direction(np,
&link->playback_only, &link->capture_only);
      |                                                     ^
sound/soc/fsl/imx-card.c:683:75: error: cannot take address of
bit-field =E2=80=98capture_only=E2=80=99
  683 |                 graph_util_parse_link_direction(np,
&link->playback_only, &link->capture_only);

There are errors with it.

best regards
Shengjiu Wang
>
> Frank
>
> >               /* Get dai fmt */
> >               ret =3D simple_util_parse_daifmt(dev, np, codec,
> >                                              NULL, &link->dai_fmt);
> > --
> > 2.34.1
> >

