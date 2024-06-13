Return-Path: <linux-kernel+bounces-213308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3F907396
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02B51C226D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61BA14533A;
	Thu, 13 Jun 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsBZ+G+H"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785F144D00;
	Thu, 13 Jun 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285007; cv=none; b=qy43gQMd4HOdOxifhCTnVmnLbrDWHUmV0HKL/yDBgXwH26xUPbo+JjI5zFZ320Eng91387M0BXM7yK4Gg9npWwI3TMM822cupify/SSU5QLrncaQc1lOVJiy9r+U5EVZ770suWwh+uYvqDZHIyPODLI/2e6pIgxOeRf6NiDSFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285007; c=relaxed/simple;
	bh=6SUWhYLUvPu0jUI6jw+gwsAu3EpJiUscax3yC3oq0HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqHyPiBxPih/8N2LePY04ssSLcNPYba2ObleTIyZkvLG0/9YrXVFTbhqgpFaqRgW/An4D3LiZx7sirA/sWx/h3fASwlbPGKmsSDZvpg5e/5gUTpHmfuXx3+WFEeLo1S87WLJljBr+IGBG0V2mpAXshYeqzYaQB7OJTa5ThC2aQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsBZ+G+H; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6ce533b643dso752771a12.3;
        Thu, 13 Jun 2024 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718285005; x=1718889805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY7+qVTCBnkic8L6HrX2KqWBFLJlyWpgMqTcC8mYb1g=;
        b=hsBZ+G+HbIqp5N+MGswiz5r+Ix0p33odmCWMl76r3w/Ua+OWeKgtARfJRm6jWeNUVo
         ERriOuue1VTqDLdq+YoQjs5flgw8YRr/HJyeG0nsZwpogDoTiFdrZJfjZZVnvrh0hCbS
         xrA9kyOjZUcBJG3Dn+leQ6KAFkQ8k0ftz1sBhhtChfnXKLM5HW/xxi6aAed57lA0b5wK
         IXYA7eBUUzWP3OrbE8Dd1sgtXyQbhq3kNrzBkGHWtE4iDS8oP/I6G63kqm8r0xEYjNKI
         Xc3bHd/l59D6HI39EbW+HSVhENiIW6b0x6dDh3e/+jLB3PPHA7SdQflN8hVQ/R2yMOVU
         ls6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285005; x=1718889805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY7+qVTCBnkic8L6HrX2KqWBFLJlyWpgMqTcC8mYb1g=;
        b=JHnRyjgWJzNHKC6XmLwZryCOtb4++nJgXaCxpB0lPhil+TFDG4KgEnmWfNB8+iTmk6
         a9v9NQgMhH19r5xFecJbYYEaHqzhJzKR94vkHmuaXddo/T9t/JEJGPgLU6ciH+KHVftg
         FF5iBc/xwHsRD+ZoJDguUuZtUXC+uXlSp7O6CtuvyNwV+6IJA8IStBVPFI6Om2tsTzcQ
         OY/eLfsQ7yApks7/32CamPFT3D5/ciUMdVmoT36cavoKCWVfonvaKWouRYQGa/H8p51f
         XW/L4CWL73M1I+GYHtJsMz8MXeQDCVCRpLwxL48q6rDdj2BmvcfwLxJBx2RGM+Io6jYz
         T7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiFWEHs/CGRgfw7rzr+SCOJW9AUL3QF1Xgk8EAO7pxXGTIxkqUvm+9eqvKnj223rr6dTIBiOlDfwXuYwY1UfempB7DfxiXgdy49QVKXJ2jXFuVeB5uZ4ertQxNYnYh07cP+ZJqLYP1nfTuWqwt25WKU7/MUxvAjgSYkDsVGvp2vzIAQw==
X-Gm-Message-State: AOJu0YzdByBLA8ZnPqjbKxnC7LaOJgoLVz5DVWXrLZ65PwBV0q/99Vu1
	T1Kt24lLFVFa3/utLAFKsu8JekG+s/vHLJMnWufOZ5BYCQ5MD04kR6/7IdoCjQ0IR8trP46Ahly
	QYoGZVIvz+sagBT8Ji8nenGwj49s=
X-Google-Smtp-Source: AGHT+IFjS6qqHBjZXHKWN1u+dasS0C5YOlgGO92F1+LaOmoGNT/BOCRy3ovZaMBx8lFhb6yb/cyp8I+kce1iGOhlNQM=
X-Received: by 2002:a17:90b:1909:b0:2bf:de54:f5b with SMTP id
 98e67ed59e1d1-2c4a762fdebmr4954256a91.18.1718285005354; Thu, 13 Jun 2024
 06:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530083513.4135052-1-wenst@chromium.org> <20240530083513.4135052-4-wenst@chromium.org>
 <cc5847a486a760921375f069a4f65cd29453a624.camel@imgtec.com>
 <CAGXv+5FBqcXjTc+DO8VQierzcxTYhyNxpw+AuuB4U1H_Xo6wPg@mail.gmail.com> <CAGXv+5HC_spBAc-t4cS+aCOQKdfWRzMkXK94HmD1Qg02ML4Uug@mail.gmail.com>
In-Reply-To: <CAGXv+5HC_spBAc-t4cS+aCOQKdfWRzMkXK94HmD1Qg02ML4Uug@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 13 Jun 2024 08:23:13 -0500
Message-ID: <CAHCN7xLHWCmeHJJY9tHFOng4EeJOqXCm9H-EA7cbABd-jogmfQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Frank Binns <Frank.Binns@imgtec.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	Matt Coster <Matt.Coster@imgtec.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:10=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Tue, Jun 4, 2024 at 12:18=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > On Fri, May 31, 2024 at 9:37=E2=80=AFPM Frank Binns <Frank.Binns@imgtec=
.com> wrote:
> > >
> > > Hi ChenYu,
> > >
> > > On Thu, 2024-05-30 at 16:35 +0800, Chen-Yu Tsai wrote:
> > > > The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is one
> > > > of the Series6XT GPUs, another sub-family of the Rogue family.
> > >
> > > I've added Adam Ford who sent out some DT related patches [1] for the=
 Renesas
> > > variant of GX6250 and the GX6650 (another Series6XT GPU).
> > >
> > > >
> > > > This was part of the very first few versions of the PowerVR submiss=
ion,
> > > > but was later dropped. The compatible string has been updated to fo=
llow
> > > > the new naming scheme adopted for the AXE series.
> > > >
> > > > In a previous iteration of the PowerVR binding submission [1], the
> > > > number of clocks required for the 6XT family was mentioned to be
> > > > always 3. This is also reflected here.
> > > >
> > > > [1] https://lore.kernel.org/dri-devel/6eeccb26e09aad67fb30ffcd523c7=
93a43c79c2a.camel@imgtec.com/
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > ---
> > > >  .../bindings/gpu/img,powervr-rogue.yaml       | 24 +++++++++++++++=
----
> > > >  1 file changed, 20 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogu=
e.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > > > index 256e252f8087..48aa205b66b4 100644
> > > > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > > > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > > > @@ -12,10 +12,17 @@ maintainers:
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    items:
> > > > -      - enum:
> > > > -          - ti,am62-gpu
> > > > -      - const: img,img-axe # IMG AXE GPU model/revision is fully d=
iscoverable
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - enum:
> > > > +              - mediatek,mt8173-gpu
> > > > +          # PowerVR 6XT GPU model/revision is fully discoverable
> > > > +          - const: img,powervr-6xt
> > > > +      - items:
> > > > +          - enum:
> > > > +              - ti,am62-gpu
> > > > +          # IMG AXE GPU model/revision is fully discoverable
> > > > +          - const: img,img-axe
> > >
> > > The Series6XT GPU models have differing numbers of power domains (eit=
her 2, 4 or
> > > 5). Whereas, the AXE GPUs have a single power domain, so I assume the=
re should
> > > be a related change here.
> > >
> > > The GX6250 has two power domains (lets call them A and B). There's a =
constraint
> > > that if domain B is powered then domain A must also be powered.
> > >
> > > In patch 6 [2] it's setting the power domain to MT8173_POWER_DOMAIN_M=
FG, which I
> > > believe corresponds to power domain B. I assume this works because th=
e MTK power
> > > controller driver is encoding the constraint above, meaning that when=
 we disable
> > > or enable MT8173_POWER_DOMAIN_MFG it's also disabling/enabling MT8173=
_POWER_DOMA
> > > IN_MFG_2D (domain A).
> >
> > It could also be that the power domains are split in the glue layer and=
 there
> > is some sequencing handled there. I'll reach out to MediaTek to see if =
they
> > can dig up some design specifics.
>
> Unfortunately they said they no longer have that information.
>
> > I assume you would like to see the separate power domains properly mode=
led
> > in the device tree?
>
> So how should we go about this? Adam, do you have this information for
> your platform?

In the Renesas platform, I only had to add one clock [1] and one
power-domain [2] to get the GPU to come up.  In Renesas' downstream
driver, they only use one clock, but Geert, the Renesas tree
maintainer, sent me the three clocks to assign to the 6xt graphics if
it's determined that 3 clocks are required.  In terms of the power
domain, there appear to be 2, but one is dependent on another, so
turning on the 'B' power domain turns on the 'A' power domain
automatically.  I should note that I can't get the graphics to
function, since the 6xt isn't supported yet, so there could be some
elements missing that I am unaware of.

adam

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/drivers/clk/renesas?h=3Dnext-20240613&id=3Df7b0dfffd3e0897ca73916a0c3=
d3fb61c61df51e
[2] - https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240227=
034539.193573-3-aford173@gmail.com/



>
> Thanks
> ChenYu
>
> >
> > Thanks
> > ChenYu
> >
> > > Thanks
> > > Frank
> > >
> > > [1] https://lists.freedesktop.org/archives/dri-devel/2024-February/44=
3548.html
> > > [2] https://lists.freedesktop.org/archives/dri-devel/2024-May/455833.=
html
> > >
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -56,6 +63,15 @@ allOf:
> > > >        properties:
> > > >          clocks:
> > > >            maxItems: 1
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: img,powervr-6xt
> > > > +    then:
> > > > +      properties:
> > > > +        clocks:
> > > > +          minItems: 3
> > > >
> > > >  examples:
> > > >    - |

