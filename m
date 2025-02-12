Return-Path: <linux-kernel+bounces-510456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E6A31D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD4B188AD01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391401E7C32;
	Wed, 12 Feb 2025 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6h6wo88"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121E81E0DB3;
	Wed, 12 Feb 2025 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332307; cv=none; b=fZPhsxC4VyU7mCiY0tianPw7CnbotKvIT/1qOg3MiXk8ZjCHpr9lH16wlnZbtnyYuhQwb7lNJB+y/sfFF5GGwhSxVQqb26tgfPD2ZcvdO7nQMo0a4qthKOwkH5TXu6Opcq4sr1CiwrwGnkTT3BwgrP+t4RIo3wqTcb7NlORv21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332307; c=relaxed/simple;
	bh=kozFMohFM7Fntd0TGvXH1XXN77KIL5Uk6EH9MHO1Jiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwqntHaMDspheA9XmCvBC+2J5PAW+yxiQ88EAsKRPtEs4+v/xQqnJBwmrrl9pXg9pvnN+6/JlobtyOhGmRwq+zb0Xwb7sQdSjI3rsANqAiPhz7QcbJBPBinnbhSguqiqCddxBcL8Q1P4ozOOJ+JaqiaheP8RNnBei+7pN5hUIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6h6wo88; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d15ce78fecso23793195ab.2;
        Tue, 11 Feb 2025 19:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739332305; x=1739937105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOjNpQnzjVItcjZQzSaRVqafGTbidnsz64LyMqqRnyg=;
        b=A6h6wo88QOZBsQoVyq2N6gTqC2/25GtViUKeZ+BCLShe0kUCeD1RqTB7gvMiSfzNiT
         PmPvmC29WvXGFN2vq6WRcnTmtApIPaCpOyl8TBxCEZkagUDQweh29F3ro07trncMEm/f
         hPbh6M3XWIwXm3Sc6LbKGo9YonA37WA+SwumtR8KsobGZ4eA6FE+2s0G3XUso68KBDyo
         oxeqtzwTXQ8wOO+KiMrCOMHwUi27AukcwLmCdKWhcCfqosQKI+8dKgYX8oF5YkakB5dG
         ql0yCaudeBFN4N+gXlPkeHyt54g9s7B3CiHlAUDiXkbFSi2HR8BfU9gWxv6zsLfRYpCt
         gWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739332305; x=1739937105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOjNpQnzjVItcjZQzSaRVqafGTbidnsz64LyMqqRnyg=;
        b=RVG1xqW0GPRr6Xx0XDjg6VrSmjN0oYCMoaah7HPmqdXvxWtwfrfAYmmvoE1VQZMvYn
         eRhAooPl6rJtVvAQmC9/1r+FdAsLKUbMEf3w+zDAL7PWXwcDFsx5rb5GOQ0Gdwgjhr30
         RjcP9ARXLAH/6kkRfcbmpifEGPGnnqe7VZxvIb7CXIDrOZdYCuS1Kmrv5tX/EHtr9H7g
         wpsI67iz3bR+ScI1I0oKo18H5bHIGv9HtVyglTJuHHvlnm0FL/vz4dL4X4FzeQPIR9JI
         YAMAK+eiNEAGxQrGdz+2l/B32kjyx6DP/zICGVZ0/L04klTQFAmRaB9Pv5zfBeTyIev/
         9Emg==
X-Forwarded-Encrypted: i=1; AJvYcCUj6foOsGHUbIc+PLmLwzLX+f+2QX4glNWo9GVmDji1eMdCOJYBKeXGJdIzVCk8maAJZYawHRRan+IWRhI=@vger.kernel.org, AJvYcCXBC7Eiq+RnuPVHvwKBZiemN3ysa06FRQ4p0ZlhvAVXO6h+UzGy3iRcpaC2EydllwlWQw5shiCP76r9@vger.kernel.org, AJvYcCXY7cTNQChUUjhYyWXxynz5+xsO4l3C5zRS1DT32QaNx86dEdt7B2UGfM19gijiSPMpVK5Jj3RWzhbY1iSL@vger.kernel.org
X-Gm-Message-State: AOJu0YwadZM+9yhFomYpSuvZYtOLeJapFHAMYlWPEgEBPlxkM/SEQgUk
	2G9QcS8MxG45fjmiEXk4a05/afaIMERUfksibX6qQ7JlmAsFvimMVZEG5bEqgs+LSS1/iI3y2Rg
	4DL1p4LA9f3h2Jn9drRSnPiXBUT4=
X-Gm-Gg: ASbGncu2GJtR2qfG9cayu8zfUirJ5p0Kztk7I+ZxxzYT5vM61+Xzj9wx/AEQl6pvmY4
	tFw850uAL0Je6Ph4pxrYFgj7hkO/aK3m3IXi3MpAFSrFDPJlTusWVp5aGfJ+b4OQCT8Jhd2YD
X-Google-Smtp-Source: AGHT+IELmMC+rEqMtc5H2YZuEE1iKouS45lV6N0hJ5Or/LuqIGNtJHv3ZlrPMODm1vA23GJ/GTBsAYKKjidNOlR17CI=
X-Received: by 2002:a05:6e02:180b:b0:3cf:b365:dcf8 with SMTP id
 e9e14a558f8ab-3d17c21ba5emr21495995ab.21.1739332305183; Tue, 11 Feb 2025
 19:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211035737.3886974-1-shengjiu.wang@nxp.com>
 <20250211035737.3886974-2-shengjiu.wang@nxp.com> <Z6ttkyfUapRKGMsk@lizhi-Precision-Tower-5810>
In-Reply-To: <Z6ttkyfUapRKGMsk@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 12 Feb 2025 11:51:32 +0800
X-Gm-Features: AWEUYZl3szAb6kdvVRYt667G1aLNreWAtpJFe-4jAXLL0jVOJ3awo1RObh0k1-U
Message-ID: <CAA+D8APFPKGGNHiiRYFgGVM-AL4LrE-q0zy9i0mErjeJU+KbuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: imx-card: Add playback-only and
 capture-only property
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

On Tue, Feb 11, 2025 at 11:32=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Feb 11, 2025 at 11:57:36AM +0800, Shengjiu Wang wrote:
> > Refer to audio graph card, add playback-only and capture-only property
> > for imx-audio-card.yaml for the case that only playback or capture
> > is supported.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/imx-audio-card.yaml         | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audio-card.yam=
l b/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
> > index f7ad5ea2491e..86571fa930f6 100644
> > --- a/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
> > +++ b/Documentation/devicetree/bindings/sound/imx-audio-card.yaml
> > @@ -46,6 +46,14 @@ patternProperties:
> >          description: see tdm-slot.txt.
> >          $ref: /schemas/types.yaml#/definitions/uint32
> >
> > +      playback-only:
> > +        description: link is used only for playback
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +
> > +      capture-only:
> > +        description: link is used only for capture
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +
>
> why not ref to audio-graph-port.yaml?
>
audio-graph-port are based on 'port'. which is not used
in imx-card.  imx-card can't directly refer to audio-graph-port.yaml.

Best regards
Shengjiu Wang

> Frank
>
> >        cpu:
> >          description: Holds subnode which indicates cpu dai.
> >          type: object
> > --
> > 2.34.1
> >

