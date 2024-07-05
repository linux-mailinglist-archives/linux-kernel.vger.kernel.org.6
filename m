Return-Path: <linux-kernel+bounces-242064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1D992832D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFBC1C240C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1847145359;
	Fri,  5 Jul 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="phQoJucs"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68B14535B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165876; cv=none; b=c7o8Flu9SnpSrqYtt6zETyIfR7NnUZkbjh3bWuOHh9bl/xq7wT0bJs1z0I5ZjFmGlzPNziybdvjVqp39l17adroJGqqF666UvzOlzfZLJaI4yNQo34skxP7cnx6wSZ69Z+nDNWaNYOU19ii5VT+N8i2oQwmFI/XrU0JjaFD4K3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165876; c=relaxed/simple;
	bh=boWUJ2Cm1+3DcMqLVBSXF3S/hXfz/ilxevRYq8Qyut8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwdQfWIDqhXNbi+SqXZxZszcp5DCWHGHmTxWthcCvG8/q7KexPsem3eRZFk2oIsjfBQSr8ElhPOvOuTJ/KuPPKHgzBJEDJBiz0UbdBjwHKvFdNrvUjlC4BMYYBMHw0BNNUecH/N05TO7OqCwaN4pTkd8NQZNaEcRPwIBwEzCPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=phQoJucs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77baa87743so149134566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720165871; x=1720770671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCVjbUVohH3p2wf5gVftnpB2o8+RU21ET/afoPI30m8=;
        b=phQoJucsYDuPYodRBscNk9nMZQRNkI7pN5AskDuNBVghlGmdW/I6hkr4Ji7rNsiSm8
         BQ8+3gYicSAOtL0ERYjzPV6zOpncn2PFqWVNhk+Jst86oxWSAKLkcCsWFU3RiCdyMc9/
         2XKgKVEWmsS50x//YjEsT31HI7wxSxvWiT6c1Q5A17fjOk1pAVA35yLRMWz2ALcZ8cAf
         CbuboGNMO1teRHfgedQDfj2dYt228jGN7vpwIPZTKhIdMLd/n0LTMvyRH3CGywk4wu7B
         q9bJZlSjABDcfFPxhALnCNSqTvHr4IBjSmsBbCdUa+1uwra9zjfYINp0Xw5zoMLhAXyq
         pDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165871; x=1720770671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCVjbUVohH3p2wf5gVftnpB2o8+RU21ET/afoPI30m8=;
        b=asvypUo7Sd+PsraahkqvhfaKTAEZbxVFbWDBJEvCprK99zxGIq09uHX1m49ZV2vmlw
         bnRb774V+EhvGXSAIgxA4ks+gnjiVNmtAbCuGHrh+PFm7C75YMK/t8iXPL/Jzl2EV+ig
         pP900l71GxcIzIfCk8pTaQA0nOqPQr12s/dLlPDu0+KTjsnf/wq8NYEB9fabhZRGlqq1
         aU6hK6A5p65lu3iNTtd+DsKcDybj/TI85UxvXb1rnRewqrRRv+s3zZvRyvJ/UMMUS1rM
         L9F7e1wzIyv13ysLCvggboLdC+25bCptwO8hf6Cu5Nk2uFa7sluvc5Drw/ZEoo+6nd9H
         rM3g==
X-Forwarded-Encrypted: i=1; AJvYcCUmtSrF83O5izBniclasD9c/uk+OGXMNFTI94MdMW5ni9d0qyQrc74XCQwPt4AcUQ2Vs37slukeEp6P3hd7L6Q+eQQMGznpna72ZNw0
X-Gm-Message-State: AOJu0YzR5gUUZAYmef7l+CWBpR+dp4KOSJUAW/l/rzEpClS50d+eGIjr
	sMrlZ/LuR2ijYyDNVilFg37BpSZVYFKzWMFZ6ZeaWz4TcjWNR1WH/pm1lufBAoWfJQflT/8BxQb
	5GkRsK6LptVR76gZlfV1tAxNvGp/eIoYquVTYDw==
X-Google-Smtp-Source: AGHT+IGiaxqLW45+/BQEWvALCzSarefavKbKnT7hrlfo4M8H4kt8dKuBoLog/WCakFxhFLqIDWrDmp7QDFKEUN7e2xw=
X-Received: by 2002:a17:906:40d0:b0:a70:c02f:8a7e with SMTP id
 a640c23a62f3a-a77ba70c75dmr276948066b.54.1720165870596; Fri, 05 Jul 2024
 00:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-add-mtk-isp-3-0-support-v5-0-bfccccc5ec21@baylibre.com>
 <20240704-add-mtk-isp-3-0-support-v5-1-bfccccc5ec21@baylibre.com> <20240704-catcall-stubbly-9258b056e42e@spud>
In-Reply-To: <20240704-catcall-stubbly-9258b056e42e@spud>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 5 Jul 2024 09:50:59 +0200
Message-ID: <CAEHHSvb6Y8g_KCmu0bK__EP2TyPhf8i-ctMNfOGdyMUUGoKQVw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: media: add mediatek ISP3.0 sensor interface
To: Conor Dooley <conor@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andy Hsieh <andy.hsieh@mediatek.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Louis Kuo <louis.kuo@mediatek.com>, Phi-Bang Nguyen <pnguyen@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 4 juil. 2024 =C3=A0 18:27, Conor Dooley <conor@kernel.org> a =C3=A9=
crit :
>
> On Thu, Jul 04, 2024 at 03:36:40PM +0200, Julien Stephan wrote:
> > From: Louis Kuo <louis.kuo@mediatek.com>
> >
> > This adds the bindings, for the mediatek ISP3.0 SENINF module embedded =
in
> > some Mediatek SoC, such as the mt8365
> >
> > Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> > Signed-off-by: Phi-Bang Nguyen <pnguyen@baylibre.com>
> > Link: https://lore.kernel.org/r/20230807094940.329165-2-jstephan@baylib=
re.com
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
> I'm really confused by the link tag here. At first glance this looked
> like you were sending out something that had been applied by Laurent,
> given the Link, Rb and SoB from him. Why does he have a SoB on this
> patch? What did Phi-Bang Nguyen do with this patch, and should they have
> a Co-developed-by tag?

Hi Conor,

I was not using b4 for the previous revisions of this series, so maybe
I messed something up here :(

About Phi-Bang, this series has been in our internal tree for a long
time, and Phi-Bang has his SoB on it, so I kept it.

About Laurent's tags, they were already on v4. But maybe it was an
error ? Should I remove them?

>
> > ---
> >  .../bindings/media/mediatek,mt8365-seninf.yaml     | 275 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   7 +
> >  2 files changed, 282 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-se=
ninf.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.=
yaml
> > new file mode 100644
> > index 000000000000..aeabea9f956a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.ya=
ml
> > @@ -0,0 +1,275 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2023 MediaTek, BayLibre
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/mediatek,mt8365-seninf.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek Sensor Interface 3.0
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +  - Julien Stephan <jstephan@baylibre.com>
> > +  - Andy Hsieh <andy.hsieh@mediatek.com>
> > +
> > +description:
> > +  The ISP3.0 SENINF is the CSI-2 and parallel camera sensor interface =
found in
> > +  multiple MediaTek SoCs. It can support up to three physical CSI-2 in=
put ports,
> > +  configured in DPHY (2 or 4 data lanes) or CPHY depending on the SoC.
> > +  On the output side, SENINF can be connected either to CAMSV instance=
 or
> > +  to the internal ISP. CAMSV is used to bypass the internal ISP proces=
sing
> > +  in order to connect either an external ISP, or a sensor (RAW, YUV).
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8365-seninf
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Seninf camsys clock
> > +      - description: Seninf top mux clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: camsys
> > +      - const: top_mux
> > +
> > +  phys: true
> > +
> > +  phy-names: true
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: CSI0 or CSI0A port
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              clock-lanes:
> > +                maxItems: 1
> > +              data-lanes:
> > +                minItems: 1
> > +                maxItems: 4
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: CSI1 port
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              clock-lanes:
> > +                maxItems: 1
> > +              data-lanes:
> > +                minItems: 1
> > +                maxItems: 4
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: CSI2 port
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              clock-lanes:
> > +                maxItems: 1
> > +              data-lanes:
> > +                minItems: 1
> > +                maxItems: 4
> > +
> > +      port@3:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: CSI0B port
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              clock-lanes:
> > +                maxItems: 1
> > +              data-lanes:
> > +                minItems: 1
> > +                maxItems: 2
> > +
> > +      port@4:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: connection point for cam0
> > +
> > +      port@5:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: connection point for cam1
> > +
> > +      port@6:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: connection point for camsv0
> > +
> > +      port@7:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: connection point for camsv1
> > +
> > +      port@8:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: connection point for camsv2
> > +
> > +      port@9:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: connection point for camsv3
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +      - port@2
> > +      - port@3
> > +      - port@4
> > +      - port@5
> > +      - port@6
> > +      - port@7
> > +      - port@8
> > +      - port@9
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: mediatek,mt8365-seninf
>
> The binding supports only a single compatible, why is this complexity
> required? I don't see other devices being added in this series.

Right. The idea is that the number of PHYs depends on the SoC. In the
previous revision of the series,
the number of PHYs was not fixed, and Krzysztof asked me to fix it by
SoC. So I wanted to make it clear
that the number of PHYs depends on SoC but maybe I don't need that
complexity for that?

Is something like the following enough? And if complexity is added
later if some other SoC are added?
    phys:
      minItems: 2
      maxItems: 2
      description:
        phandle to the PHYs connected to CSI0/A, CSI1, CSI0B

    phy-names:
      description:
        list of PHYs names
      minItems: 2
      maxItems: 2
      items:
        type: string
        enum:
          - csi0
          - csi1
          - csi0b
      uniqueItems: true

Cheers
Julien

>
> Cheers,
> Conor.
>
> > +then:
> > +  properties:
> > +    phys:
> > +      minItems: 2
> > +      maxItems: 2
> > +      description:
> > +        phandle to the PHYs connected to CSI0/A, CSI1, CSI0B
> > +
> > +    phy-names:
> > +      description:
> > +        list of PHYs names
> > +      minItems: 2
> > +      maxItems: 2
> > +      items:
> > +        type: string
> > +        enum:
> > +          - csi0
> > +          - csi1
> > +          - csi0b
> > +      uniqueItems: true

