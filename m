Return-Path: <linux-kernel+bounces-523769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D191AA3DAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1321899BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926021F8690;
	Thu, 20 Feb 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnfvHoIa"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F71F3BAF;
	Thu, 20 Feb 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057106; cv=none; b=ui7ABsBaXtbSMmWv/opLTAuT0eTVPUXrJvE8dr/QfOXr9SJSJ0lW/niLv2MqfsLkvPXkW9Q9mVtqtEo2hITQwMtcLQbGqKZfz+z9LlW1NBfsPMjfdhY6PiFlXKw0hBJAwUPnpzhvsvgZhlGuErmh1WJbgjH/qNSrQ0y46IREUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057106; c=relaxed/simple;
	bh=1rFDlxPm9dOSxZVbvPEae5HPKIG7G0vod8A15RjRzcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFayW1in7qwMhsc742+YTjKPgVpBeAaeYhGLK2KFuo+1rOKwUT+m7W8MMzOH9sw7arHtZlgGK9y5E393UPWR41hAiFbnS3lGTHt1nO2/2rh0ojByLYT5D3AgFmm81Ct2GTcW6hVAg6N59XA0gka2X7u0KYX3lNxqBHyiDSGOGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnfvHoIa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so1789941a91.2;
        Thu, 20 Feb 2025 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740057104; x=1740661904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF5QN09m8wD/DAxZp57pL5p7sOu+zrVbutsLKLdh4Cc=;
        b=JnfvHoIaLrEbMLjp84Tw9biNKNaCmeYitMV5MddxypoZE0mzF1u5MtXoX8GZ0f3sgb
         2gk9PZ1krdK8OIGjG9K0sB8JEfHQWTXNqmuc/2popocho6zyRnNYdkMAt/aWfOnB2XcB
         xj5/H1lBDx1DSEpoyZWgQ7+xqpvz7z06511LcKMVxKNYLjawe/hSAmCa1ufBusJqFjT0
         rGVYcbuPM80Y9IlrZhx58JR10sxJoj2tjEGNtPw2GU+NBNnSNwVxaasPNfV0c3ECr58a
         TPI/v+ZtFpHJaE6+Eo16Z71aP3naJtfkBFGeIaiAuoE8QMyb3r+mehuBIB0Nq7mxDnpr
         Gz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057104; x=1740661904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF5QN09m8wD/DAxZp57pL5p7sOu+zrVbutsLKLdh4Cc=;
        b=nyMGSlWwv5rbCp/6QFG0cwlq7DdcPHLrv7kF7LAflZATl15DMeELVB7pwXyp8fe5pK
         6F/tyvII+EUZvc9Sv7L0JG9pA0jM9xNeK83ZevR9wVDrRS0dklKYoC3FjW0n2ZFkWDyd
         v7XZXqRWyx2/YmaYUBWOGkipHljc5enV+WNuOMyfYRBvceUYFCbIOdYw3wOLMrs77Cqb
         4Ckq9xh8WbdHjbRoCp20xP/YbPg72amKqGbWuZ+gjRN/5DJsH9qtdltqeqS+cc3hNMcc
         J0thAvsPtSNEjLmnihPzYYLMyDz1fQtGAxxO2VHSVu8hupjcJV0MLlQOFMUHES4/ydE+
         YlJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtaxczASbEUjXikrd1dUjMf/WAtQCLGSMAxdUNTjOqQcy4WJLVY5Yz6no57I+ViB1YlUNQTmbQP8Hv@vger.kernel.org, AJvYcCWBbaRmSOkBYT1iaqTtO+oKXh0SrIGW/8h1ZcfKzW8QFS/itxpThgg0KqZsxyLivS/QNXYn0+OuGP2BmqPe@vger.kernel.org
X-Gm-Message-State: AOJu0YwJh45y71GzQZG/SKjL14XcS85dm6b3GHPo5zqKpRgRVV9RIs8M
	OeYn2L+34MDkUhIEvMUMJi6WbNJhvu4ic/bAN9i4V7wk3Z6dFo5eiCAR4RaRiAqpmd2DARvWkNC
	UCjTQBnfcieaO8NCNQKpgPEAe6x4=
X-Gm-Gg: ASbGncsFyRBAiVLXVi162qCTScmz2OSgS3XMG8kc7hYdcEPrPjDHcwZr2vrPy8F0MO2
	oXYoF+kCVwALckFk29/qDbhqU5kQ/7yMJkoAAKzsbz6XHqa5aba5CFYP7u8h3MiwNYoIfb/R8Bl
	bwnwUwNhE4ooCBSe0W2Fce8GbXmkofh9o=
X-Google-Smtp-Source: AGHT+IF6yx7qrSwJDRsToFTnlYa/h0A1YhshZSR5dL4PvWKAo3vckuyvm/Wyqi6jEyYBH3tHibJkW5A+JtSeL88Uo4M=
X-Received: by 2002:a17:90b:2f86:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2fc40c1d548mr36337290a91.7.1740057102215; Thu, 20 Feb 2025
 05:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-3-daniel.baluta@nxp.com> <12614210.O9o76ZdvQC@steina-w>
In-Reply-To: <12614210.O9o76ZdvQC@steina-w>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 20 Feb 2025 15:11:30 +0200
X-Gm-Features: AWEUYZlFjxlk4pWxNFB2rtjCHWnzpKUBBv6ujaPIet0mutNPJ0j906GL3_pdrJk
Message-ID: <CAEnQRZDU9HoiD9uBNi+inrZcn8KCRp3pUZQfRqaq5kauuxOi6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: dsp: fsl,dsp: Add resets property
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org, 
	linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	mathieu.poirier@linaro.org, shengjiu.wang@nxp.com, Frank.Li@nxp.com, 
	peng.fan@nxp.com, laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com, 
	Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:37=E2=80=AFPM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Mittwoch, 19. Februar 2025, 20:20:56 CET schrieb Daniel Baluta:
> > On i.MX8MP we introduced support for using a reset controller
> > to control DSP operation.
> >
> > This patch adds reset property which is required for i.MX8MP.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Docum=
entation/devicetree/bindings/dsp/fsl,dsp.yaml
> > index ab93ffd3d2e5..923e7f079f1b 100644
> > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > @@ -82,6 +82,13 @@ properties:
> >      description:
> >        Phandle to syscon block which provide access for processor enabl=
ement
> >
> > +  resets:
> > +    description:
> > +      A pair consisting of phandle to audio-blk-control and an index r=
eferencing
> > +      the DSP Run/Stall bit in audiomix registers.
> > +      See include/dt-bindings/reset/imx8mp-reset-audiomix.h for each i=
ndex meaning.
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -164,6 +171,16 @@ allOf:
> >              - const: txdb1
> >              - const: rxdb0
> >              - const: rxdb1
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8mp-dsp
> > +              - fsl,imx8mp-hifi4
> > +    then:
> > +      required:
> > +        - "resets"
> >
> >  additionalProperties: false
> >
> > @@ -220,5 +237,5 @@ examples:
> >                 <&mu2 3 0>;
> >        memory-region =3D <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> >                        <&dsp_vdev0vring1>, <&dsp_reserved>;
> > -      fsl,dsp-ctrl =3D <&audio_blk_ctrl>;
> > +      resets =3D <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP>;
>
> Am I missing something here? fsl,dsp-ctrl is used to get the regmap from =
syscon.

fsl,dsp-ctrl was used to control the DSP. This functionality for
imx8mp have been now replaced by
using the reset controller.

The example where the diff happens is for imx8mp so for this reason I
changed it to use the
new way of doing the rest.

