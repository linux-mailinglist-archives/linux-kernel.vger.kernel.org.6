Return-Path: <linux-kernel+bounces-430485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C355E9E317E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF18B24B89
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CFC5FB95;
	Wed,  4 Dec 2024 02:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IoInubMZ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097129415
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279935; cv=none; b=s4rV2nmETtgBsjIQ8CdseA1cjBtHEN/zqO80k5knUptYm/vzW9M4IkaApuoFeTKmoNzA2zcKplQlMzIa2uLII1hqz95uyzkvlzrrRsGMNiEguyD2KdyydKDwRuW20TqzB30F/0EVcPWw5LiMDnyqmhSea5jEGiY+Z8zjNa02g7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279935; c=relaxed/simple;
	bh=T1FMb456onK7tNgpsqAO0c9tdE6wfx49yPNJIRqPNhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt7SR69jwDwVKd5bnqDlkBZZ32j32ePOynHshObBzZkcIAdg8GZtAB/f3bLmtGyHN3Dw21YQTans1e2ZIrHYByY45HX/uuAj+cEsB0pxcb0AaEMVm6AL97brCNXHSQICFYxJL06pg3bUyhFHhBCesW2NBpEPasivQVZ5rjLmHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IoInubMZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de035ea13so6376381e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 18:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733279932; x=1733884732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78THJIZs/MA15yj+ru7yg//2Ko53Pnaq+srDYQqZaEg=;
        b=IoInubMZRzJ4VZK1pCoDN+j2mfSBGtZEfukOLoNItH0AjuPEyhJ7VTtkvbNdSawHQ3
         EX69p049GMzbaW5QYZu64xR3tmgi3RNbuMMhxTiIN2mPorGePtBjHWU3jsUWmKTL5G0U
         oiy7kaaUJNoNzy7XoXONGcW+66w6STO9uMUXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733279932; x=1733884732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78THJIZs/MA15yj+ru7yg//2Ko53Pnaq+srDYQqZaEg=;
        b=SKlhbx/kI36iKr8rSd/XU0wpR5GeQ2jh80Sb7EEF08eaVTulE2bAEdSSudy6G14+e/
         cYwDibL183AUpwFw9HDo7Oj1Xd04dIlwrWiLw58U89StVs7oG9n+YFLG3HQaCGhHJA0T
         lIERhD990AEhoXYzI5YRuaRWUMN41AZ+zLBerIppC3qfy3zOkyT8lyf7jX5TYYMvJUGF
         Dm6slV73/Ky8HtG6ntQWHbI5c8AHSfTX9yw3x5HkciQnKzo7lRMUduFW7TSFgdg+4bX0
         UPYLc59QM+zzC/x2O88rC1BU0rYFbnK4RkF4CYBeoswH7AKda8SmQM5W1V7r4kGrKf6Q
         5a9w==
X-Forwarded-Encrypted: i=1; AJvYcCWHQRZRh5wZJphd3y/WPiSmQaachqY5peaczOGPGTLPPOhElOi07jB2205U/CVabqf2ODr1/720qA6rce4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPwdXsQIwHDypC+dGZqHuTS2VZ5mui2EVDT/IK0i3fYL77ISb
	VURRgr7bmEuvovFfv3jRE4pXJkFNUvoLg1jpQLaqapf+DvSkTH4tdcGsVXJFInTFQ2ixtyJkdpK
	2S52UJTKT5zRHwmWqInosL0ESTzsaC4IaXOyN
X-Gm-Gg: ASbGncvMGO25dP7SBJKwi0hETh0iiHwEOHoCo5D85/xbUY679rbfaMMnhpqeAZ9yHMp
	zyaek4tMRquxi1XCugqxuWWUFe3TUBjc11C0LTIdGy+bhJS7DWgCFpm6VrIM=
X-Google-Smtp-Source: AGHT+IHuw72icjrfxzdu36itc3o804934USQfay4OuNOvOLlQt8ZUuZrboi9UituymewJ75cgmh/8dMhPio3+m/+Hac=
X-Received: by 2002:a05:6512:b19:b0:53d:eec6:4622 with SMTP id
 2adb3069b0e04-53e12a3523fmr2296114e87.48.1733279931341; Tue, 03 Dec 2024
 18:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202045757.39244-1-wenst@chromium.org> <20241203172026.GA1988559-robh@kernel.org>
In-Reply-To: <20241203172026.GA1988559-robh@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 4 Dec 2024 10:38:40 +0800
Message-ID: <CAGXv+5GPacXtcrxJVHUGuRWOSY+k5tn4kvwgu_nkjdQ6=srayQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: fsl: cpm_qe: Limit matching to nodes
 with "fsl,qe"
To: Rob Herring <robh@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:20=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 02, 2024 at 12:57:55PM +0800, Chen-Yu Tsai wrote:
> > Otherwise the binding matches against random nodes with "simple-bus"
> > giving out all kinds of invalid warnings:
> >
> >     $ make CHECK_DTBS=3Dy mediatek/mt8188-evb.dtb
> >       SYNC    include/config/auto.conf.cmd
> >       UPD     include/config/kernel.release
> >       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >       DTC [C] arch/arm64/boot/dts/mediatek/mt8188-evb.dtb
> >     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible:0: 'fs=
l,qe' was expected
> >           from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe=
/fsl,qe.yaml#
> >     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible: ['sim=
ple-bus'] is too short
> >           from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe=
/fsl,qe.yaml#
> >     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-control=
ler@c000000:compatible:0: 'fsl,qe-ic' was expected
> >           from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe=
/fsl,qe.yaml#
> >     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-control=
ler@c000000:reg: [[0, 201326592, 0, 262144], [0, 201588736, 0, 2097152]] is=
 too long
> >           from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe=
/fsl,qe.yaml#
> >     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-control=
ler@c000000:#interrupt-cells:0:0: 1 was expected
> >           from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe=
/fsl,qe.yaml#
> >     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-control=
ler@c000000: '#redistributor-regions', 'ppi-partitions' do not match any of=
 the regexes: 'pinctrl-[0-9]+'
> >           from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe=
/fsl,qe.yaml#
> >     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'reg' is a requir=
ed property
> >           from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe=
/fsl,qe.yaml#
> >     arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'bus-frequency' i=
s a required property
> >           from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe=
/fsl,qe.yaml#
> >
> > Fixes: ecbfc6ff94a2 ("dt-bindings: soc: fsl: cpm_qe: convert to yaml fo=
rmat")
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: <stable@vger.kernel.org> # v6.11+
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  .../devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml        | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.ya=
ml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> > index 89cdf5e1d0a8..9e07a2c4d05b 100644
> > --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> > +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
> > @@ -21,6 +21,14 @@ description: |
> >    The description below applies to the qe of MPC8360 and
> >    more nodes and properties would be extended in the future.
> >
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: fsl,qe
> > +  required:
> > +    - compatible
>
> Update your dtschema. The select is no longer necessary. dtbs_check will
> also run 5x faster.

That did the trick. Thanks Rob!

And sorry for the noise.


ChenYu

