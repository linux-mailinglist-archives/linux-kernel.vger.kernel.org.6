Return-Path: <linux-kernel+bounces-196971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F98D6479
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A6AB28E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7041CD3D;
	Fri, 31 May 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtGAo6f3"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385B56448;
	Fri, 31 May 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165512; cv=none; b=E8uZ7v38buRxE/huVjOkkaA8a/rQBjGtqczCE/P3seak4Hyarc13o2Mw94aDIQ2r/Fa6tDClxxzZZKvB9qs2KVSCC7Z12Qr2F+duOpquLWjveDWVjwl/XzlpUiz7YWweFqS+nOIyVR6neu1IiEd8KAVAozs0MGThr2EvBIengBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165512; c=relaxed/simple;
	bh=cOofNTY/oXTRZ81RXzPrmeOruTYdnOEFZTR+wvJ4FfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeC2huJ4Y5DsdppunQ+aqpqw8Fuvfg6N+xCKGLQGLVZ+Wogbl2j/7+KoaxaeRDsg7uUrYw7Uyk96sBE0xWc4P61KPE/m6/kQeX8LT7NhnhBu/hY/pzbr7kEaWttAvX2rpCzTREgODvuGldIZ/xVHgA6buzp+QAA6neIf12UCUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtGAo6f3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1451965a12.2;
        Fri, 31 May 2024 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717165511; x=1717770311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvrZTCq64hB5lHJheyU2TPKqgbbvFWSIbyIIWaCcr6w=;
        b=FtGAo6f3qR5kU+3ZtHO+i2eBpRZvw5me1eLAXUmvjqJerBIKd6+JCHQznme32TVzk2
         Z6FAzAiGZR3NxB/oepUQ3FyTaCaAP+cMFeEeiKU2+GnjqfBuefLQmfcG/2Olc3GoIgs5
         3AAGRCyZjh/5C8zjuTvtBSVY/Eo/F8NQNXLk8zHft0eNuwdc/zDqvmyZYqEqn/4FbwQD
         Xwi+uCgNvifToizW16HHY7Loi5CFdNwaUQq5b2ooTtBY9MFXNxjLCSPSnMP+/H6CVLGN
         xyw57/ttSTYWU82uzaBwibXCgxU0s52KIjkqiKrDjEtBRHD+zgxQPi75uCAzxV951vtP
         4THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717165511; x=1717770311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvrZTCq64hB5lHJheyU2TPKqgbbvFWSIbyIIWaCcr6w=;
        b=PtOwS/uAglEmH4U72kEEmKgTEBtnyNSQrD+Sb+W8x74WBYtzIogBxZVmrDNazJGu+f
         sBRHdImEjkJcjTYKW5HKeWocqdZU9BKxFdZQPzTeucx8ALMxdu71PnVNf/+64kBBT0xD
         sTPemradqpEJkB3bmEjVokfbnlB/oEg0wWL1BznZYtduX2JeKcw87gRdEWB5fWMAcFSY
         8ztkiFZrRm2rbCCVpxBbR8u6AU8YJ91pc4uaGMWjNkSOFw1AiEMrcSZFLPbU4Kv8/Hnv
         9jLQF1latFEQXgDvcB29lIyRrZ16suXhrzML82ipvWu/sHMk7NFr9mfeJ4SSkLmzv3QC
         SwlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxvf4JH2ZMROmeZBBtMbLJ2HWZUXQICyLdjLAASghMx4xwg7dBPtbfNon7YqKH39uCXly1TTGMpgimNR9r2lh4jawhviAHPlGJDTffZC+HHVJioC+D/A6xuVXy4wzjGKl0MhZYXc3vC2B/RtDfpzovC3Ez1oy/1Xh5xuvh37GNdnAGOw==
X-Gm-Message-State: AOJu0YxJIPQv6rfKUMt57XRIYlJ6qB7FQh58Gx3mnXLVHn/0OhF/HxmP
	b4q2KO/sOXyvi9id3/v+jt1X4zA2HsXHvfZzSag0N/njmtOFyyvbdrnCGbBb7qsuSLgyEdI8gxh
	UchC8Xz8LDDaWbzPHMXyayWZgFyM=
X-Google-Smtp-Source: AGHT+IGLbXNCTP7kEEDSMq48BUCNTcGq4/Bj168zhaicbZLEfBju50BxyoEC44nEYY/K5zSXtSoOZMn4twkyQ+dOxks=
X-Received: by 2002:a17:90b:2282:b0:2bd:fa57:b361 with SMTP id
 98e67ed59e1d1-2c1dc56fce1mr1799546a91.11.1717165510580; Fri, 31 May 2024
 07:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530083513.4135052-1-wenst@chromium.org> <20240530083513.4135052-4-wenst@chromium.org>
 <cc5847a486a760921375f069a4f65cd29453a624.camel@imgtec.com>
In-Reply-To: <cc5847a486a760921375f069a4f65cd29453a624.camel@imgtec.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 31 May 2024 09:24:56 -0500
Message-ID: <CAHCN7xJ7X9_yNJa7-HyU=FzN2G1cV8i9R+PoTHm-DKyiOPenUQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
To: Frank Binns <Frank.Binns@imgtec.com>
Cc: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	Matt Coster <Matt.Coster@imgtec.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"wenst@chromium.org" <wenst@chromium.org>, "mripard@kernel.org" <mripard@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 8:37=E2=80=AFAM Frank Binns <Frank.Binns@imgtec.com=
> wrote:
>
> Hi ChenYu,
>
> On Thu, 2024-05-30 at 16:35 +0800, Chen-Yu Tsai wrote:
> > The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is one
> > of the Series6XT GPUs, another sub-family of the Rogue family.
>
> I've added Adam Ford who sent out some DT related patches [1] for the Ren=
esas
> variant of GX6250 and the GX6650 (another Series6XT GPU).
>

Thanks for including me.

> >
> > This was part of the very first few versions of the PowerVR submission,
> > but was later dropped. The compatible string has been updated to follow
> > the new naming scheme adopted for the AXE series.
> >
> > In a previous iteration of the PowerVR binding submission [1], the
> > number of clocks required for the 6XT family was mentioned to be
> > always 3. This is also reflected here.
> >
> > [1] https://lore.kernel.org/dri-devel/6eeccb26e09aad67fb30ffcd523c793a4=
3c79c2a.camel@imgtec.com/
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  .../bindings/gpu/img,powervr-rogue.yaml       | 24 +++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.ya=
ml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > index 256e252f8087..48aa205b66b4 100644
> > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > @@ -12,10 +12,17 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - ti,am62-gpu
> > -      - const: img,img-axe # IMG AXE GPU model/revision is fully disco=
verable
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8173-gpu
> > +          # PowerVR 6XT GPU model/revision is fully discoverable
> > +          - const: img,powervr-6xt
> > +      - items:
> > +          - enum:
> > +              - ti,am62-gpu
> > +          # IMG AXE GPU model/revision is fully discoverable
> > +          - const: img,img-axe
>
> The Series6XT GPU models have differing numbers of power domains (either =
2, 4 or
> 5). Whereas, the AXE GPUs have a single power domain, so I assume there s=
hould
> be a related change here.
>
> The GX6250 has two power domains (lets call them A and B). There's a cons=
traint
> that if domain B is powered then domain A must also be powered.
>
> In patch 6 [2] it's setting the power domain to MT8173_POWER_DOMAIN_MFG, =
which I
> believe corresponds to power domain B. I assume this works because the MT=
K power
> controller driver is encoding the constraint above, meaning that when we =
disable
> or enable MT8173_POWER_DOMAIN_MFG it's also disabling/enabling MT8173_POW=
ER_DOMA
> IN_MFG_2D (domain A).
>

In the cover letter of this series, it was noted that the GPU
enumerates, but it doesn' fully function yet.  This is also the case
for both of the Renesas variants I have been testing, and I was nicely
asked to postpone my series until the driver was closer to being
ready.

Even if the driver isn't ready yet, it would be nice to move the
bindings forward.

adam

> Thanks
> Frank
>
> [1] https://lists.freedesktop.org/archives/dri-devel/2024-February/443548=
html
> [2] https://lists.freedesktop.org/archives/dri-devel/2024-May/455833.html
>
> >
> >    reg:
> >      maxItems: 1
> > @@ -56,6 +63,15 @@ allOf:
> >        properties:
> >          clocks:
> >            maxItems: 1
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: img,powervr-6xt
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 3
> >
> >  examples:
> >    - |

