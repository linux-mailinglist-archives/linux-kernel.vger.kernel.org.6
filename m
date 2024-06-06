Return-Path: <linux-kernel+bounces-203531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DCB8FDCA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1633EB211AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11A182BB;
	Thu,  6 Jun 2024 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEr57owC"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B2440C;
	Thu,  6 Jun 2024 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640381; cv=none; b=JECThFXDd/1IsMFfGD+hc2QLmAqOkJKcSbyD6fZZoxwXg1lPJvs8ADeBwVPQoA4KR/nMAickQS2gt3DzuG0K17ZOxUS9NHjp5z6I2g6jKnfPMFGskGMzsS8iZUkDhwasYreyYbBzwKT67UdWrdHOISFmUjddFvHU+Ii/sQZANzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640381; c=relaxed/simple;
	bh=yHnbLg4xPUbK99cwmxufgEME6D4RSpyJmscguwNIqxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh2LTEuO+Pp4vfM03LUpPBSczdcVVIOQ3uq8W4wSVMp34VWGjKbMigmV8U8Jvpf3g5b8U4qDqQr3Je9aXeHfs92CwuFZ9TCAZmLy9d29fvVukqn8BzxsFFnosHw5zXAbCyHNbCCCYcCl8FP1bvirrtnQiVRuSwpu/51aYHLLIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEr57owC; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2508a32bb57so205241fac.2;
        Wed, 05 Jun 2024 19:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717640379; x=1718245179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PRDuWYjFtULWNP5TyyV5JrKa8zniHjDTaMzzJR6qvs=;
        b=eEr57owCCWzPIqVSbCAa62Eym3uzQTH69WM0dor3XSlf5ZccgJZ6ta76DraULjnszb
         XcwnWkzDeMzeu2B7jQb7WXPsXa4WWVMWTXOObc6PzriEhheICjUW1k4Ycde61MjHIz9G
         /2aKIDXUsIt/FjO3i7ZjWaIa8YGOB2jRJpSxJoH++8tUjtdHFOskjMrhMUQtSKwnwsdY
         GLo4l3GsvJxoeUxFFz6j6rawdxk+Qlwpdn7mTrVPMs8/x34KeTlqwgVLQ/9+CbJIlFzn
         cxnAaH5JRkkvt4VU7U2e2wcV35WA/MWnPlt7dElBwaJCfONvo2vFoaKrDgOSRnsKwvsL
         6W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640379; x=1718245179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PRDuWYjFtULWNP5TyyV5JrKa8zniHjDTaMzzJR6qvs=;
        b=RQ/SXYVV2EofsLx6DLrg337jamDe2JcISQAd0aEARq/S5iJp34LBMyT1vjG6o5l/0H
         1JlqHYJiGJ3bUHANn2xr536A67gy/0rer9M/SGMZmNLbiwcXAgqSQDRWR3kncVNLz19Y
         18EUhVEPTZKtEbguW72pG3sPU+C7RuuOF/ZEoCFXbqSKCEA1z1B0v5aGsWTDnCVQKI25
         bEZwRWfDIuroSXUAVOjcWG0B1j+3vt7SBqzMc+OQ4mripN+ghhK7gX0fiUWqk2r5XKgL
         Gb9z+JPKb9KJFVq54jtbQ7CCD+bzOJ/D5wZ3+q2ZbppSJd1SeP+KLrr1IFo24CCNOrVG
         3new==
X-Forwarded-Encrypted: i=1; AJvYcCWGtoiGne1J8pi7h1Uy54eGnuumqPPBmkoSvnP3lujMYhGun9zmVOjviSsUOvy2wnA5DsJMjOc2rQ7cWg8cbLLxKceJegTRIE0iMlajTLL2ZvIFPWyONj8VanJ/f5Lew1Ze9/HsJ0syX7I3QpfYBUJ5NqRqUbo0LUFYWcoNb9yFkslZlVUx
X-Gm-Message-State: AOJu0YxIkjXhOka4gQigi+EgzaxTKiRq+3UTLqmI/ZcYx8RLTPMOWBlv
	peJMehDGcHFjmPwIavuyHWEze36/BDnSWV10xhZ29UZ0P8jW6i0zcTUzAx4948nuB2AUmOEUtEG
	hby8MPS8Fq+9gLYyfHfyex8VllJM=
X-Google-Smtp-Source: AGHT+IGI2K1g3B7qYS6BwwmPcpX2RQj6rZ42i3F0xPY/m/Y0EHecq/RK0GNeKe2kbCes514aFL6DXF5HBy95D6RZ94g=
X-Received: by 2002:a05:6870:8202:b0:23e:b430:3f87 with SMTP id
 586e51a60fabf-25121c94fa4mr4945606fac.2.1717640379095; Wed, 05 Jun 2024
 19:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605112301.8171-1-animeshagarwal28@gmail.com> <20240606005332.GA3526959-robh@kernel.org>
In-Reply-To: <20240606005332.GA3526959-robh@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Thu, 6 Jun 2024 07:49:27 +0530
Message-ID: <CAE3Oz82TsuDq5wAW4TSNeUuR0DTixAQPtJnCc3-5J7MnBYtuRw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: linux,spdif-dir: Convert to dtschema
To: Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 6:23=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 05, 2024 at 04:52:55PM +0530, Animesh Agarwal wrote:
> > Convert the dummy SPDIF receiver bindings to DT schema. Make bindings
> > complete by adding property "#sound-dai-cells"
>
> 2 conversions of the same thing in one day:
>
> https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-conv=
ert-spdif-receiver-v1-1-262465adbac2@linaro.org/
>
> As I said there, I would just add the compatible to
> linux,spdif-dit.yaml. But this is fine too.
>
> >
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../bindings/sound/linux,spdif-dir.yaml       | 34 +++++++++++++++++++
> >  .../bindings/sound/spdif-receiver.txt         | 10 ------
> >  2 files changed, 34 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/linux,spdif=
-dir.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/sound/spdif-recei=
ver.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/linux,spdif-dir.ya=
ml b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
> > new file mode 100644
> > index 000000000000..61767873200f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/linux,spdif-dir.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Dummy SPDIF receiver
> > +
> > +maintainers:
> > +  - Liam Girdwood <lgirdwood@gmail.com>
> > +  - Mark Brown <broonie@kernel.org>
> > +
> > +allOf:
> > +  - $ref: dai-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: linux,spdif-dir
> > +
> > +  "#sound-dai-cells":
> > +    const: 0
>
> It wasn't in the txt binding, but users also use 'sound-name-prefix'
> property, so that should be added here.
linux,spdif-dir.yaml

If this is the case, I'll add the linux,spdif-dir compatible in
linux,spdif-dit.yaml instead of creating a new file in v2 of this
patch.

Regards,
Animesh Agarwal

