Return-Path: <linux-kernel+bounces-203688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE038FDF14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D9028E35B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5AE12AAE2;
	Thu,  6 Jun 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i3wUwkdq"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76E19D898
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656428; cv=none; b=J9JdAX61/WYh0vTaMjiyCuHmu6PUJYami3V2Kj2u9R3IHhpCeKCmthmnVWCmMdqs7AJfz2gCCe/0Qt0cAceQsh2jFWySSKAiuVj5HodtsXTih5uBcHzu4SdqUVFHFx4gRvwKzFB43ZK8vE1HXdL6vnlbZynXlif2fLW8p51f1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656428; c=relaxed/simple;
	bh=I225HpwCGaHXdQhB102rRz5DVwR3ebWC1Av3wFv6dVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVx1pu/vEWSgeJdOylIXvYpvItxg8J3L5LowAhqySLUphzC7FlpRaht3tSE4G0DpGnl7Rfn7oUOa7mOZsrMF4cEqG4/FUNFykKaFNgWPAu3CPvfVG3Yo5T0iSuMZ6BP2LVrftVidlIk+TqWb3Lfhff33f8vuKZBXqpeLRRovE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i3wUwkdq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b7e693b8aso1614550e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717656424; x=1718261224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rv1sDHR32RWCfZmFBg17q325stbG/XmstQRsoUj80I=;
        b=i3wUwkdqzf5H54tiYMeOYxt4gc6dgeuc8T00M97HJK9pRdxP59qDErSOIJJayFSkPk
         WJmefzlPW0qG3YA6evD79q2F/ROpk3+CdLoVhNELMAyQtxQ4GhDJD6P1HEznov9aaQXB
         paVsYcpbnU9EDzSntyeAsQe1/wUt2xq3xJlYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717656424; x=1718261224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rv1sDHR32RWCfZmFBg17q325stbG/XmstQRsoUj80I=;
        b=Xv32OGxiObl1pOBxUV5O4soYy/cRwhXHrmTHI4AjnKBy6cHSMFMUEK3vLUL5IVKxs0
         IUAXqLLMMDCBSpmUX5WWNLBdfSW8Ov1l0KOyo17gX7X1twre4VsRKdoqfswZwiIp/y3c
         ZlVrfKKRmDz+hpMM+/Z2qFka4fB2BowVANxleZTMQyeEqB4XSiYSgVjx7Ek/oLZTzdyE
         0lln2kILJxOwK2m+F59HmANIZMyxowM7IUls53RJ9Pb6xHUMqs6rZrRKh/eqUl5ZyNBn
         lqKcjUavAi7e8uuCG4DgPFwNe45IBVPugEvTMSVl8t+KgF+3Hd9ZAVtoCf5U2gruE1Yr
         atLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+9Tzxy6CspK/zIi5Y1pjWucM4tqSw7rKeTaV7oFy608fjJEwhy1BfV53dD63PD0YLDhp4cld3bsemKbPnvs0zK3QogBg2TfStq9aF
X-Gm-Message-State: AOJu0YwthBVUyWJ7u1298PQ+21cXSjo96fRLWe2KRCakUfLeRnpEWwi2
	k/Uy2SJhgOw32s/DbNtGaJcKpjzMimPvDfAdfvY2hAqjjHNRJRCTvKrgc5UZvGw6r9Mp8beXYbN
	BJ1YFhM0hW7WpjbouzdvDw0ORYFC7CvSJoZiq
X-Google-Smtp-Source: AGHT+IGeuCm9PsqMZJSdhMHCIrhen6KLNJPY05qssC+yap37aeWf5ikwB9VlUACAq1ji5UH3ecZrST5zcf6cfOqLI4U=
X-Received: by 2002:a05:6512:2825:b0:52b:a50c:c23e with SMTP id
 2adb3069b0e04-52bb2195a3cmr495256e87.34.1717656423496; Wed, 05 Jun 2024
 23:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521075717.50330-1-angelogioacchino.delregno@collabora.com>
 <20240521075717.50330-3-angelogioacchino.delregno@collabora.com>
 <e7845300fa822413f6308cb6297222cde89c39e0.camel@mediatek.com> <0e0fe86c-92da-43f5-89d7-8084274a908a@collabora.com>
In-Reply-To: <0e0fe86c-92da-43f5-89d7-8084274a908a@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 6 Jun 2024 14:46:51 +0800
Message-ID: <CAGXv+5FgVk9z3DhAC5oYoGXSJ+wJf+sa6wFSyJ_Nhy3JrKkCng@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	=?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"kernel@collabora.com" <kernel@collabora.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	=?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"amergnat@baylibre.com" <amergnat@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:15=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 05/06/24 03:38, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) ha scritto:
> > Hi, Angelo:
> >
> > On Tue, 2024-05-21 at 09:57 +0200, AngeloGioacchino Del Regno wrote:
> >> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
> >> per HW instance (so potentially up to six displays for multi-vdo SoCs)=
.
> >>
> >> The MMSYS or VDOSYS is always the first component in the DDP pipeline,
> >> so it only supports an output port with multiple endpoints - where eac=
h
> >> endpoint defines the starting point for one of the (currently three)
> >> possible hardware paths.
> >>
> >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> >> Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   .../bindings/arm/mediatek/mediatek,mmsys.yaml | 28 +++++++++++++++++=
++
> >>   1 file changed, 28 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,m=
msys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.y=
aml
> >> index b3c6888c1457..0ef67ca4122b 100644
> >> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya=
ml
> >> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya=
ml
> >> @@ -93,6 +93,34 @@ properties:
> >>     '#reset-cells':
> >>       const: 1
> >>
> >> +  port:
> >> +    $ref: /schemas/graph.yaml#/properties/port
> >> +    description:
> >> +      Output port node. This port connects the MMSYS/VDOSYS output to
> >> +      the first component of one display pipeline, for example one of
> >> +      the available OVL or RDMA blocks.
> >> +      Some MediaTek SoCs support multiple display outputs per MMSYS.
> >
> > This patch looks good to me. Just want to share another information for=
 you.
> > Here is an example that mmsys/vdosys could point to the display interfa=
ce node.
> >
> > vdosys0: syscon@1c01a000 {
> >            mmsys-display-interface =3D <&dsi0>, <&dsi1>, <&dp_intf0>;
> > };
> >
> > vdosys1: syscon@1c100000 {
> >            mmsys-display-interface =3D <&dp_intf1>;
> > };
> >
> > There is no conflict that mmsys/vdosys point to first component of one =
display pipeline or point to display interface.
> > Both could co-exist.
> >
>
> Hey CK,
>
> yes, this could be an alternative to the OF graphs, and I'm sure that it'=
d work,
> even though this kind of solution would still require partial hardcoding =
of the
> display paths up until mmsys-display-interface (so, up until DSI0, or DSI=
1, etc).

I think you might be misunderstanding CK's proposal? He's simply saying tha=
t
instead of pointing to the start of the pipeline, point to the end instead.
You can still use the OF graph and work backwards from the output.

> The problem with a solution like this is that, well, even though it would=
 work,
> even if we ignore the suboptimal partial hardcoding, OF graphs are someth=
ing
> generic, while the mmsys-display-interface would be a MediaTek specific/c=
ustom
> property.
>
> In the end, reusing generic kernel apis/interfaces/etc is always preferre=
d
> compared to custom solutions, especially in this case, in which the gener=
ic
> stuff is on-par (or actually, depending purely on personal opinions, supe=
rior).

Here you are mixing hardware descriptions and kernel implementation details=
.

I think this goes back to whether the mmsys/vdosys is actually part of the
graph or not. It certainly controls the muxes within the graph. But that
doesn't mean it has to be within the graph itself. It can just have pointer=
s
to entry points of the graph (for which you would have a couple lines of
custom code [1]). If the data doesn't flow through the mmsys/vdosys, then
I would argue that it is not part of the graph.

I would also argue that the data path should be fully described in the
device tree, not hardcoding paths based on board usage. The latter is
a policy / design decision, not a hardware capability.


ChenYu

> As for the two to co-exist, I'm not sure that this is actually needed, as=
 the
> OF graphs are already (at the end of the graph) pointing to the display i=
nterface.
>
> In any case, just as a reminder: if there will be any need to add any cus=
tom
> MediaTek specific properties later, it's ok and we can do that at any tim=
e.
>
> Cheers!
> Angelo
>
> > Regards,
> > CK
> >
> >> +    properties:
> >> +      endpoint@0:
> >> +        $ref: /schemas/graph.yaml#/properties/endpoint
> >> +        description: Output to the primary display pipeline
> >> +
> >> +      endpoint@1:
> >> +        $ref: /schemas/graph.yaml#/properties/endpoint
> >> +        description: Output to the secondary display pipeline
> >> +
> >> +      endpoint@2:
> >> +        $ref: /schemas/graph.yaml#/properties/endpoint
> >> +        description: Output to the tertiary display pipeline
> >> +
> >> +    anyOf:
> >> +      - required:
> >> +          - endpoint@0
> >> +      - required:
> >> +          - endpoint@1
> >> +      - required:
> >> +          - endpoint@2
> >> +
> >>   required:
> >>     - compatible
> >>     - reg
>
>

