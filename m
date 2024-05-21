Return-Path: <linux-kernel+bounces-184524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2268D8CA80A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC62F2828FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5B4776A;
	Tue, 21 May 2024 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwv8rfnz"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC82D047;
	Tue, 21 May 2024 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716273166; cv=none; b=tMdf18ONWsCkmWcbsF05ccfkB6zQE0fuVYgXekXY+HGAe3WmRRoj2uWynatA5eQ8q9sioe1Py6VzzCE6YCeVIMssJIzfl2SV8zfam4U49pqUs1f9KYvwpABY/R/8WTf2+QPGeB/yjhpvNg1sJDBz8qYLAVMgWWZHWnugamUh/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716273166; c=relaxed/simple;
	bh=D2e3UIWaaCZthfsLSaAtaf3JVExndOtoZAyJOWE5QtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C10+FyyvJGPPvlvUksWsPI3QV7eH+fenn/winwyiP8q1QAl3zywJosuxAo/5/43jwaNDv+Qb/mBiIRfXul3HhzNbUh395mz5/zGbGvUJmcgoZ3AVH9Kfyhd920tRzO9c1Zwbu1sNY79+cnnuWOA8Q8+vG0JInksIO5oSR7I9Wsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwv8rfnz; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36c947ff642so19740895ab.2;
        Mon, 20 May 2024 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716273164; x=1716877964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v5h6PC3m5viZM1uwwljp97r1zeipYab7bRIWScSl2M=;
        b=Mwv8rfnzXIpKesQe5W+CdAAr0lJPpGEAqv6FA39iBOci+IoAo+1fX64EBRRz9Fp/2l
         7aAvk4Fy+PMvEzCbTFFlWYR99s12W3pAGdoek5ReqNsd/71cnbpNn69ZRTloQ5Zjb6Aw
         QaIMSe3HvkRSqHPYvhFPE3Pa6M5gjqO/Z/T+JnhNbRhK7Awb2pRqaRvXF2FElp1fcE3G
         DP350JPEsGRSCatCm3R62CNnJ36nYJxM8Z5xKyXahY9i7IEaUP82FdohWvH4Gyc+eQzL
         Vvnv85StHSYkDCNH2mu5UBNDYkkbMpnKaAkD5S+idw84LVqyVCyxBkd/D42mbRrFW4MJ
         Ja1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716273164; x=1716877964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9v5h6PC3m5viZM1uwwljp97r1zeipYab7bRIWScSl2M=;
        b=gkCGRLr4+G/Ce/lcq6pPQwLKp36g7xWnkntjz8mSxg4CoBCByfFUi8fzp1IpvfGchq
         KVHNuMpRF4DFmyLdU/WRo0OCBJ88Y/kjU0q3DPv6oKbEdM8QOOdmUPc4OLwcxOG2HzHZ
         Dm/Sdwcc5W5Cy2nPfRrj/hHvrif76gSdmwgRnCEqZKXVOmTbkB7uz4578dV+w4Rd2Bii
         tS1lN8py9XXxsnbqoSgBJToutw0d09FxLsbNb/NKQC4NywJX6ll38ebdnEx4WQ+jY48q
         r8waSdV0TJf5Kji+Zmt/lIpbbEMQXUMKLo9t+aTwBLxslMtatAdoqjhA0ghZt/L0xTTm
         ZEGw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Qc66d8HeZ1dV0tHahlt3sgA+26aCQHA0OBjZqOG3Gynnur95EeqKsxYq08iWbXfwkS9ONg41n8uUrdtXCS30HWna5DngzRmxT22FoiLWzKW3QlMM6ehqeq2UcX6UR4TRuQA9mKtjSsYwXgEZuYeH6o3xulxhz80yaHekYir6ia4wgs6Y
X-Gm-Message-State: AOJu0YwKwkqnlE+CtxZ/sKJhCXztsw+intFHGJNXF+A2+Sm5pY0Hzolj
	tiHhebJWUPeoFGnb7pAhSUs8PVi1gMu0oqagR0UxsSkJ3JHk38QzS+Y3/VFJN4BQR2dEtFvXHEi
	wpdTMpRbZqPRi00G2RQg/I/iVfls=
X-Google-Smtp-Source: AGHT+IHxK0DDX2uyvGgjkFhMSHqcRRzxekD6O/b+tOay3l5GstPgFhvbAwzUrXw/5NT70QAMEfkIjbuJ3XTfQfLanXw=
X-Received: by 2002:a05:6e02:1fea:b0:36c:4b17:e06a with SMTP id
 e9e14a558f8ab-36cc148e51amr385802135ab.18.1716273163845; Mon, 20 May 2024
 23:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715939146-13031-1-git-send-email-shengjiu.wang@nxp.com>
 <1715939146-13031-2-git-send-email-shengjiu.wang@nxp.com> <4727a091-bc64-46ea-8652-db6797dd93d2@linaro.org>
In-Reply-To: <4727a091-bc64-46ea-8652-db6797dd93d2@linaro.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 21 May 2024 14:32:32 +0800
Message-ID: <CAA+D8APgcZo4fhmzft83ZFeG2bfF19Ew5Fi4o5Gqh3Ej=OPCuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl,mqs: Add i.MX95 platform support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 6:47=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/05/2024 11:45, Shengjiu Wang wrote:
> > In order to support the MQS module on i.MX95, a new property
> > "fsl,mqs-ctrl" needs to be added, as there are two MQS instances
> > on the i.MX95 platform, the definition of bit positions in the
> > control register is different. This new property is to distinguish
> > these two instances.
> >
> > Without this property, the difference of platforms except the
> > i.MX95 was handled by the driver itself. But this new property can
> > also be used for previous platforms.
> >
> > The MQS only has one control register, the register may be
> > in General Purpose Register memory space, or MQS its own
> > memory space, or controlled by System Manager.
> > The bit position in the register may be different for each
> > platform, there are four parts (bits for module enablement,
> > bits for reset, bits for oversampling ratio, bits for divider ratio).
> > This new property includes all these things.
>
> ...
>
> >
> >    clocks:
> >      minItems: 1
> > @@ -45,6 +46,22 @@ properties:
> >    resets:
> >      maxItems: 1
> >
> > +  fsl,mqs-ctrl:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 6
> > +    maxItems: 6
> > +    description: |
> > +      Contains the control register information, defined as,
> > +      Cell #1: register type
> > +               0 - the register in owned register map
> > +               1 - the register in general purpose register map
> > +               2 - the register in control of system manager
> > +      Cell #2: offset of the control register from the syscon
> > +      Cell #3: shift bits for module enable bit
> > +      Cell #4: shift bits for reset bit
> > +      Cell #5: shift bits for oversampling ratio bit
> > +      Cell #6: shift bits for divider ratio control bit
>
> Thanks for detailed explanation in commit msg, but no, please do not
> describe layout of registers in DTS. For the syscon phandles, you can
> pass an argument (although not 6 arguments...). Usually this is enough.
> For some cases, like you have differences in capabilities of this device
> or its programming model, maybe you need different compatible.
>
> If these are different capabilities, sometimes new properties are
> applicable (describing hardware, not register bits...).
>
The main difference between the two instances on i.MX95 is the register
difference. looks like I need to use two compatible strings:
      - fsl,imx95-aonmix-mqs
      - fsl,imx95-netcmix-mqs
to distinguish them.

best regards
Shengjiu Wang

> Best regards,
> Krzysztof
>

