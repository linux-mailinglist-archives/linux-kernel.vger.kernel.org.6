Return-Path: <linux-kernel+bounces-510890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8FA32344
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669BF162B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226372080CB;
	Wed, 12 Feb 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvMFP3n8"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0561F0E5F;
	Wed, 12 Feb 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355017; cv=none; b=cyY74LLTYI1zaf/eli8VKoir1mBLVxOrEhNovLo3nErVmjJblv49lcGU/GrUorPtfZtomD8jf5F3DZ4yCL0P3jRczMt3Bw2FVZN4mv6lw/Ha5dJnzEMj7w9Wp0ryuu1hVLulXfgGb3VgTDhpMEenL8LVXI1CFoWuJ2NPnUylos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355017; c=relaxed/simple;
	bh=dksiq7Wu+Tr8U4ZmasPxlXsm3FDPqcOrzej22bOgA+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Og3Ov5ADEedg7NFZ2vbGV6d2q2o2C/WWmRiZNDkD+XrdwTHZ8wBK/ktraYVeYIf7tix3If7a0tF6fsAIRi7OSLlDaQTlI60wF7pvSnG9HBAILvt9nj/beTP7YlRdQfs2u35XjpO4FTJ7RMcMD9bIEllJgXVjcNmZtvrNIWpolzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvMFP3n8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so502304a91.3;
        Wed, 12 Feb 2025 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739355015; x=1739959815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88AwpE99PaoAeek/DCfv+c+a/zWXUaUFSdw15oFH2AA=;
        b=fvMFP3n8wen3rXeUxELDe3Lc0vbWKkqdRo/eDORvvN4BOSTZ9htdZ8nQYjEL7nBluZ
         pa3kKrWQjWtP6Ix+l7DvYiIKWfOTLFa+SW11a/7plEBFhKonkWMGCnZejkQMFjalHseN
         P+MYd0aXHCGTEzSD5K6PL+NAa9m1KrLqFGqvWwre7otyfvtkt3KEUcyXRAnzZOwLBG4V
         iOX0oPRgMwa4NAGozHUaH1SuQLHRCwJGkDaR48prEqlgLjbghRWAqVdzVmieE49fuLkO
         6n5qYHmETfX6f/yGRRHzlAySvX/4ka2rvKyuFKXpHy6PfNW2gQzEsbAyNnraykS8uH+3
         zBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355015; x=1739959815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88AwpE99PaoAeek/DCfv+c+a/zWXUaUFSdw15oFH2AA=;
        b=lgkg2TFH6Tfv146aJrpV+KhDYBcxnErqJ1K0VssbiOCQymtEIZSdQoiuk+yiybLkbJ
         NwaYUW6g+hFdW5Y2n8N4Gms2pOcfjdt0FBFCCnNH85oTlnGPgbYH2HN/xLkTtIsoTSsL
         OVfTafPGF1qAT0Y73B+gUNZ+mceIdF56KrQOPu/sfUYpHXY5+khOK562YSGoxlPvueG2
         O6hQffILf257XZo6SKXFnjv5u1ZS/YtxnqJAml/gCKXQHUqhBAwlCgAVMRoEsQibedP2
         cax+Dx4RKYwWWjqG/EO+AuYNt9uHqVlnl2ujD+Y2omLRUuzeUPsl9cqFAPNYdM3+XvBy
         yGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEERpoPh0hYENYtvpGMz82vR+l2i45thKjoU2boF8c1Mx56IBeGs/SCt56/yuSDTM6z1QblBNjvh84wHD8@vger.kernel.org, AJvYcCUne8zTp0yZg3hGQ2NBXbTUYZxwsaXYrwLmPzM7l+K4IQKzxdIOP2fne79W/lnbEU4Bxgkg9EQD/Mje@vger.kernel.org, AJvYcCWvhJl0x1tSyUrHWzu6v5p6D0OAF3F/lyfkqYM597UCzR+XKTodPjC1o4A40yBs1JT6GjkoOL6094CUJhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/h/ZSPZQBo542/ZtYwyJSERrUiC7UGDlhqq5XceWe0jI+tIRO
	FbZpBibzVe8SXKjO5vuhB3rxphvtEEM0KSCcvDxATQ6lXaC595XR8EQWTPIbQ/IG3b5SR/jkSwV
	Hqmy0YTE1ROaFQ9wyAHbSJfc8ZFg=
X-Gm-Gg: ASbGnctvIKeGY1O1Fiy8B5xvjFTt/3xiUlZVwz7wZXhUakG8oBUK+W/C/6endtaUxkk
	yHDxBXfEaU528bgppkApAILENtcSSbprFv3M0FhKgpfizsV+seFiUcwf97iXyp8LP9y28gg==
X-Google-Smtp-Source: AGHT+IGmuZRdGl3j3qwqlGA+I6iMmpaYMwad+794x21O14HpgAdBUJZvPf+MREMoJEJJ7oo0IQ1nHPq82m46EvhwjX0=
X-Received: by 2002:a17:90b:50c4:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2fbf5c0f645mr4582577a91.16.1739355015327; Wed, 12 Feb 2025
 02:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-2-laurentiumihalcea111@gmail.com> <20250212093610.x4ixrackmn3u2xrf@pengutronix.de>
In-Reply-To: <20250212093610.x4ixrackmn3u2xrf@pengutronix.de>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 12 Feb 2025 12:11:49 +0200
X-Gm-Features: AWEUYZmaBc7oKF6zAnQ7CZxr3zaURFYGkUGsn3Z_TJnj1f8vLuCQ0QWTQQTBMT4
Message-ID: <CAEnQRZBeQdnC+K92+Udb5awTmom10YHHNt7Ld-pYK4A1i8sr3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ASoC: dt-bindings: support imx95's CM7 core
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:38=E2=80=AFAM Marco Felsch <m.felsch@pengutronix=
.de> wrote:
>
> On 25-02-11, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> > Add binding for imx95's CM7 core, used for audio processing.
> > Additionally, introduce a common binding for NXP audio processors with
> > Sound Open Firmware (SOF) support.
> >
> > Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > ---
> >  .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 64 +++++++++++++++++++
> >  .../bindings/sound/fsl,sof-cpu.yaml           | 27 ++++++++
> >  2 files changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-c=
m7-sof.yaml
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.=
yaml b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
> > new file mode 100644
> > index 000000000000..f00ae3219e15
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,imx95-cm7-sof.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP imx95 CM7 core
> > +
> > +maintainers:
> > +  - Daniel Baluta <daniel.baluta@nxp.com>
> > +
> > +description: NXP imx95 CM7 core used for audio processing
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx95-cm7-sof
>
> Albeit Krzysztof already add his Reviewed-by, can I ask why we need to
> add the -sof suffix instead of -audio or so? SOF is a software project
> but you can clearly run different software on the audio-copro as well.

Sure you can run a different software project on the audio DSP but
you will need a way to distinguish between the different projects.

There might be different mailbox, memory configurations. So you will  need
to invent another suffix specific to the new project.

We can make  const: fsl,imx95-cm7-audio as the one used with SOF
and think about a different name later for when another project will
want to use the DSP.

