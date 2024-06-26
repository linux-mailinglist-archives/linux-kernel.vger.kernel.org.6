Return-Path: <linux-kernel+bounces-230407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC5917C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4970B20BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061E16A94A;
	Wed, 26 Jun 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buQNJp+0"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BB168486;
	Wed, 26 Jun 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393967; cv=none; b=u2AGXsoAmBr1brDY6JJbA5rzwhK3GvbyioeZphCVLYxslMU1THTpHwDThmAPSojFym4+FsONxg/kZIuaaL/RMPDmc5s1cGZ2OiEhGP/Pw3t2+9F4Q05ascmhJJSlTQahjVHFXX22IdDNIsWoB6FVyztg3QIOeMx6Wt87V4eFBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393967; c=relaxed/simple;
	bh=TImSq2cjy7qGSTtQ6Zpc4gpMXPfbpIIxDoWk49mkmDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lR4klfFcDRW8wx2Vj3fLNFOo72uXkAybfv5wJeNeNkMXNua3uwZXMqr2Gxpqkdsa5MM6zm7l5vOjK8Qlqnkt3w7nHuQG42pDNFHPtRkkyevjexDRR3cJiSbx6gPqQt9ex27ULUYuOo2p4UQtVDVGGQ7FAyfbLLg9Nql6W7MQseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buQNJp+0; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375df5af253so27990755ab.0;
        Wed, 26 Jun 2024 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719393965; x=1719998765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS9tBWagV/aB3ttYbZvRx1MNDmH3F8EWYX4OiWc3MUM=;
        b=buQNJp+0+Qb+7ONwBKLCjK78HAsGRREi1JUzK5+0P90qAR6hr/jc2VcXh7PLA2l0yp
         vyaV5Md5z/6HCgpMZhsEFG1c8Cc4HPm/jm6MfWq2M4cvhIYGcmK/j2sESVoVDNPzwLBx
         2yxfjIoNpkxIhIB1DJ8i8HLDeXSQAfIF4mvUXJ6h1eGL3yTEQ+Hvs80Tqo4U+GKRCZXW
         l1Hr0rJbkII5p/1W/gI7nFEVqj4HwntevKLfNO8a91FpftTX5psTWI6bcGkBAjSaq03V
         SykDoRHj/DLDMMERCEixgBNQ74QjlWNXyPxIck8bWS9UYEEGhbJmENr5gkiwFNJlznLa
         i3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719393965; x=1719998765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS9tBWagV/aB3ttYbZvRx1MNDmH3F8EWYX4OiWc3MUM=;
        b=qUZC7r4vAJz9d9WYD7mH7astYJB26KfWSmbBe1R9HXg5CU5PezsumXSMFoTZa02daX
         Gk02YJrp8fFbzyNmNUV2E2vw7yYR7SvWzoyyvhNHQHQ4OgZ3Uy25vHBh1xdsMzcd1VeG
         tntjzyTUT+MDEbtXTfNsAZj2DBE8oUxSWcPq8s7pbZJuQvh6cGyM1cDoo8C8N/19tfRl
         1kYzBCs1mr3/gii0ZO9UBMcDTpGe8gsyWN4bb+QRAhvqQo6TjKY6Bz9dE4kiaQlxlZ+B
         /Y/INN9QTrFmv9MQPfA/g53aOpr534qRqNGixyTGBrrrHSEhlai+NbCGP3bG++smkr5/
         nXvA==
X-Forwarded-Encrypted: i=1; AJvYcCXUm0DdqqX8Ss0Qrbf8/d8+O5RWHVKnk9ib1vZIdPG7TmPrGChhCxDw7xcj5aAcbxBQr3+4n3MMI9s/J8IeS/lQPKwoD6QjJoDC4ulM8xz4XUWHAafKrx5niRjSbuVTiI/rnmzZtdOZgCht6suf23TNHadCNIITBBTCW3RzpGdROSn6B9yK
X-Gm-Message-State: AOJu0YwP9oQnkquk7bP1wVUvZr1Os/A1wYGuhaJLiVu8CGpMjgca0Tnc
	lzVm2cuCxlUlsn7A8ujo3rWnooKnlJiI0bBnOivNbI1XD/RrG+hTXsLhawK9WJFg54knSZB7C43
	3QJSq1sKuT082VIuo1eln2I3SoCw=
X-Google-Smtp-Source: AGHT+IF8vqv2H6BpcX/e8E9ZnvoMnUjyW3sSLUDB2oJsF3VziNS1XQjch9E28MYtledL6iD1NEAUZ0Me343FM2X83XI=
X-Received: by 2002:a05:6e02:1526:b0:375:8fb7:7a32 with SMTP id
 e9e14a558f8ab-3763f6ac1f9mr146620995ab.29.1719393964771; Wed, 26 Jun 2024
 02:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719291415-1168-1-git-send-email-shengjiu.wang@nxp.com>
 <1719291415-1168-2-git-send-email-shengjiu.wang@nxp.com> <293fb3d5-9b77-4321-8b31-d060cf96565d@kernel.org>
In-Reply-To: <293fb3d5-9b77-4321-8b31-d060cf96565d@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 26 Jun 2024 17:25:53 +0800
Message-ID: <CAA+D8AMQv_=X3hC5uQbrDBN0EGo3U6EToGFVjUYcOVHpf5b=aQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 5:23=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 25/06/2024 06:56, Shengjiu Wang wrote:
> > On i.MX8MP, there are 3 interrupts, the third interrupt is
> > SPDIF wakeup interrupt from PHY
> >
> > Add ref: dai-common.yaml for #sound-dai-cells is needed and
> > XCVR is a DAI device.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Do=
cumentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > index 197ae8ba9c30..7470866e11c6 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > @@ -42,6 +42,7 @@ properties:
> >      items:
> >        - description: WAKEUPMIX Audio XCVR Interrupt 1
> >        - description: WAKEUPMIX Audio XCVR Interrupt 2
> > +      - description: SPDIF wakeup interrupt from PHY
> >      minItems: 1
> >
> >    clocks:
> > @@ -88,6 +89,7 @@ required:
> >    - dma-names
> >
> >  allOf:
> > +  - $ref: dai-common.yaml#
> >    - if:
> >        properties:
> >          compatible:
> > @@ -112,7 +114,7 @@ allOf:
> >      else:
> >        properties:
> >          interrupts:
> > -          maxItems: 1
> > +          maxItems: 3
>
> I have doubts this was tested. The existing example should fail,
> although I did not see any reports. Not sure why.

it is tested, because the minItems is 1. so the example can pass

Best regards
Shengjiu Wang
>
> Best regards,
> Krzysztof
>

