Return-Path: <linux-kernel+bounces-440090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F539EB8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91384281560
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A050E1AA786;
	Tue, 10 Dec 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q4lGdvjv"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8E86358
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853021; cv=none; b=QJuefDqO6dRYSIamGYCWbr2qvyJMLQHxF7MYVZMY66jPTK5dSsYP0MuOTXZVUwdeLIULi2bmQrHAreqQcbsGeHhtEIae5BblxJ3OegeU2L4KvJ3ybND7bIFeFq1nnejfd7xUnjaYzrKt9tttNaWgW8YsJJZqwDHE8TG8nXdkJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853021; c=relaxed/simple;
	bh=zyY+LvfKIlfyAiCLJWS7+1JGxiO0FEIr6sylV/Xgzzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8YO7OozZfsvSPPxrXY0pRGLue3bucPxzaclqeOdbwB3O7wadk9/4fyWYtXTOxafVUmXYCrIwUedkHowDmG0OtLKJzEtcRdpSTtNjawsbXEpvb38LarrKE2zO3Op1HA95ygvN1DKwc85W1N/ONAU8TI+YAv9A6JGx0BOyWysZwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q4lGdvjv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so7766672a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733853017; x=1734457817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjuuFtemyP+DI+76rQdawmoZ3eTqeNEd2wfGxX97PdQ=;
        b=Q4lGdvjvpwRiJIrC5oygd7IB3QdpPyGxley4I7UmG37NJvMsznl/nwS1w/ooZWc5IE
         4EADgV/K2YQF0xTnCGXROxRODu82QsCgr7VMY+Dx0gT9JFo6drKy0a6Hu912xaiayPQW
         TUzo7WwCJURtbn7M41sF7fxQJhOFn5PPy79/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853017; x=1734457817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjuuFtemyP+DI+76rQdawmoZ3eTqeNEd2wfGxX97PdQ=;
        b=I/OV31UeN4C3CCmo1JAtkPfR3fhtvui+bNkxdn6jB7Ip4LoCnSRb8q6+7KbFCJVJvh
         9yYY+pNOJd07id2G9AkSTbt+/2oFO6Nez2S//FzT5Vk4rBBTw4/VZezDyr+HWYEuyfz2
         IaAa/Sj1pfcvipv1UeS49jb3kfbB8gJ25cCPqd0I9uVJEgXP9X/XN+CqOY/g/hX9QgwU
         EHE7yKcIXff2M38KFuWX+JXqR+apVK3ZY1rdTSc6cIeeVO6CpiELP6nTtRlABPSwHBm4
         9CpOMqTYRDVTJAL34l1M7aQx0SpzKYDxjcG13QUvF6ykr5qaw4+9bItTbfCItpvAXfGV
         QEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+n0boKyMjVOWli0YPJCdimwJFSY79HGO1mI99SlvHFYZalui+LmaT4QxZxcU9tH7payPp7G1Ymn6JOt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH19RWb1eR7O/weUkorv0dxFbeg/ZAMZhmwDrZ+/ivR1Yn/P3K
	J0fUBLT/buyzAvWWTExtvZkp22iXPD9RVmTzQUtAy3xjyRvEnBQyzPg8ozqvT19TXr1vBdlO/rR
	s21Ub
X-Gm-Gg: ASbGncvQK/kBwsgzp6KHAz/QkaJXIdXDJ841F0GSAtOY9G8m70qanYAGwur+gcg59Y+
	DXoGyPS/5celFZT574h7vxHXScpyRnjb4Yw5n6ImJ+HOY5fhd8+BTVjILq5Xy9zQAdohaf/0u64
	Ka/Hz8GUFqyO1CMTupwYdxcBQuip0BgUBA9S5G9dIoF1Y8GqjgciBGV9cWCHRJgK0zqDjtDR47Q
	4xtYtUdNv9OQk5LoptRmc79pJsi12KztRSPwgFsH8ByzY88znOnwl7ylJR06Kq0QOlMFQGMXHyB
	2pzLzGyi2ZvqyrK2LQ==
X-Google-Smtp-Source: AGHT+IECJd5OITwJrgAvmPoPUp1WjB60zneXScskT4O3dLRIBnJRVPEv+DFlE+wbnkSAaEMTjQygVA==
X-Received: by 2002:a17:907:784b:b0:aa6:a9fe:46e9 with SMTP id a640c23a62f3a-aa6a9fe480cmr228073866b.29.1733853017210;
        Tue, 10 Dec 2024 09:50:17 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69f67ab64sm173345866b.204.2024.12.10.09.50.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:50:17 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4540414f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:50:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFSxzMzA9G4l6zpCIDMbHws+i+dx1HIDFnychjcsoJCHOyxjDFR/n87bVVHlKI959TOhGWE/f8mqtyQXc=@vger.kernel.org
X-Received: by 2002:a2e:800a:0:b0:302:1c90:58d9 with SMTP id
 38308e7fff4ca-30240ced962mr314001fa.16.1733852563643; Tue, 10 Dec 2024
 09:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <20241204150326.1470749-2-quic_vdadhani@quicinc.com> <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
 <6736db20-127b-45c3-ac90-3e3e359c343b@quicinc.com>
In-Reply-To: <6736db20-127b-45c3-ac90-3e3e359c343b@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Dec 2024 09:42:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VReNQ3nw+wfZizL7JjxEX9z=GwDEJAFzheNkW7rSrB5Q@mail.gmail.com>
X-Gm-Features: AZHOrDkKw2FmHmZQUJPUfL4ELobjfrjI9icl10Uq0FkzH_2PdMnaEbBKyuOx5E0
Message-ID: <CAD=FV=VReNQ3nw+wfZizL7JjxEX9z=GwDEJAFzheNkW7rSrB5Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT
 properties for QUP firmware loading
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_anupkulk@quicinc.com, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 9, 2024 at 9:28=E2=80=AFPM Viken Dadhaniya
<quic_vdadhani@quicinc.com> wrote:
>
> On 12/4/2024 10:55 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Dec 4, 2024 at 7:03=E2=80=AFAM Viken Dadhaniya
> > <quic_vdadhani@quicinc.com> wrote:
> >>
> >> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> >> support SE(Serial Engine) firmware loading from the protocol driver an=
d to
> >> select the data transfer mode, either GPI DMA (Generic Packet Interfac=
e)
> >> or non-GPI mode (PIO/CPU DMA).
> >>
> >> I2C controller can operate in one of two modes based on the
> >> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> >>
> >> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> >> ---
> >>   .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 +++++++++=
++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.=
yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> index 9f66a3bb1f80..a26f34fce1bb 100644
> >> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >> @@ -66,6 +66,15 @@ properties:
> >>     required-opps:
> >>       maxItems: 1
> >>
> >> +  qcom,load-firmware:
> >> +    type: boolean
> >> +    description: Optional property to load SE (serial engine) Firmwar=
e from protocol driver.
> >> +
> >> +  qcom,xfer-mode:
> >> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI DMA=
 mode respectively.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [1, 2, 3]
> >
> > I'm a little confused about this. I'll admit I haven't fully analyzed
> > your patch with actual code in it, but in the past "CPU DMA" mode and
> > "FIFO" mode were compatible with each other and then it was up to the
> > driver to decide which of the two modes made sense in any given
> > situation. For instance, last I looked at the i2c driver it tried to
> > use DMA for large transfers and FIFO for small transfers. The SPI
> > driver also has some cases where it will use DMA mode and then
> > fallback to FIFO mode.
> >
> > ...so what exactly is the point of differentiating between "FIFO" and
> > "CPU DMA" mode here?
>
> Yes, correct, Will update in V2.
> I plan to add 2 modes, GSI and non-GSI(PIO or DMA based on length).
>
> >
> > Then when it comes to "GSI DMA" mode, my understanding is that the
> > firmware for "GSI DMA" mode is always loaded by Trustzone because the
> > whole point is that the GSI mode arbitrates between multiple clients.
> > Presumably if the firmware already loaded the GSI firmware then the
> > code would just detect that case. ...so there shouldn't need to be any
> > reason to specify GSI mode here either, right?
> >
> > -Doug
>
> GSI firmware is loaded from TZ per QUP, but to use GSI mode,
> we need to configure the SE to use GSI mode by writing into SE register
> QUPV3_SE_GENI_DMA_MODE_EN and SE_GSI_EVENT_EN. This register is
> used to configure data transfer mode for Serial Engine.

Can't you detect it's in GSI mode without any device tree property
like the code does today?

-Doug

