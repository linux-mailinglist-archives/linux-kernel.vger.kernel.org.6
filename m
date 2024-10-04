Return-Path: <linux-kernel+bounces-350817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F23990A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436E51C2225E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A61CACCE;
	Fri,  4 Oct 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLucpN9i"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFE1E378D;
	Fri,  4 Oct 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062485; cv=none; b=QTUtUfWhljRAhutFwUaOQcSkjcn960UHPumKSWpvM1dXQV8CO95z5LwCnHJ+sFOE/Gju9f5rTPCDcpJOE1Lu+HLML/fKc9yUzCs2r/X4yK3U2O/hw+oOs3mlTruoMA1YgyN0IjHk8o9MpdXG3okyQTEi2/xv4yHqEXwJPDPfhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062485; c=relaxed/simple;
	bh=FxtugPPjDGBDG/VhYXLkyNRSWT2yuy3cs+P6moYSCgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He4i8Zlmaul/AgswSpOSjz7buOKsdgUUC4MROd2mOtO8jnhuQYygDP0WXoGtV0MNTjb+/a8tDF85nX+AGL1AhUKWnLqYQ0b6E54j4FbmH4jjJ1ToNZ8bm0T4jHyaXcvKfI1NYOLac90+p7Wl20Bu/J6ImHVzAwKtJNlOEs0PfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLucpN9i; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso352837566b.0;
        Fri, 04 Oct 2024 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728062482; x=1728667282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtEt46o4Ndi2PXXzbxTMO9O790Da1zaXcWeKDybGOss=;
        b=LLucpN9iN46Ct6er8cjIl3cIFYotR/8ziD9xeoLjaZvBKaja2j5o3ZnmfDsC6kLqTT
         Bgb8C6fAcHbcm9c8Ww/8XFWa975nRxPM3AenCsii9k0pHf4Cwx7rfpUpqQ4zGh/4rqhR
         1CHgygKUIwVcKdmvv+s2bTvZokI+OVaqXcI74x6tNJmNk0sF8Ixxk37oGIz19QlVP5Nu
         dIJH+2AM/D2E8jne2dJl1CL3EQNGaJhRjvGOi7yE0ZfRLxVnGKYjBZr1Nd/SoIgl6GIs
         a5UI0vEtnoW8rtwc/AIjC6NUx/R/5zMNYQrWlEFsj2s08EATW9NTRPAzQ1b9BjHcsQLR
         TchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728062482; x=1728667282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtEt46o4Ndi2PXXzbxTMO9O790Da1zaXcWeKDybGOss=;
        b=azTpCCTGBEQ/vPO7wHXuCDwwWee0fRLXopRmxMQHjLpX7ky9hmS9gyPwQCTBeEVkeJ
         coBqd9YVX7ftGKh4yS5jVd6ObZsnZEMfhOwUk/clE94uxKbY3f1IpoiuLavRVxYb6rs/
         lm84rhl1P2zX+Unni2jQKKivYj0ForCSaPdy0uQOixXmTBPR/8Oh4biLgXjfH6K5Xsyk
         vE2j07dONwgA+BbLPkEnNlNvKV+b3Qf2Cbhv9P/7QKHMithQ8A8wNGzJOmS0ZXmXbVjV
         lea5Hw/oGGp9XbdnGer4oufO2afLoxZ1UvWA1CvV2UNz4BaKII6QjgrD8AZyyq4VPV9O
         YfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV04H6ixZLFzdVIxv/lmP8kuUvLa1C5/gCzDcfSdHo6KRxJDFv+RIzRR4lQNCDGujqLIj7Dt424PR+7@vger.kernel.org, AJvYcCXdDwOKTNg38YVOoUTzeLZZ/OcVNpxbXwOk+Hs6YkukmAlPZSOsi08pTPyYGXNoPAYRWi64SjpFMx0j5A+3@vger.kernel.org
X-Gm-Message-State: AOJu0YwloW7ZDwA2UJC+7bMBjrwPGw1Sg0A/CvJK8v37VqJLbDQNlfSs
	xrYgKgeAOk5btBApY7Y4Lk8LF8kPhiiRGi51X7+/SlPdcEvMM/sXptjA8cYjeVoN9EG+LWckHd7
	ek/km0Ta6DgRNNoI09I7MsASjKhk=
X-Google-Smtp-Source: AGHT+IEATOErbfMYiCskMnNmX7b8T2OHyXRqo7SzJoDTS8Me5Ghk02w2erYS38AFob2cAnvZM96Hw+yTA62pTHrUPIA=
X-Received: by 2002:a17:907:e282:b0:a8b:154b:7643 with SMTP id
 a640c23a62f3a-a991bd42f3fmr324694666b.28.1728062481898; Fri, 04 Oct 2024
 10:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003220820.1345048-1-CFSworks@gmail.com> <20241003220820.1345048-2-CFSworks@gmail.com>
 <3okd7byomwmo5vjsyaaxsorhn6ldw3mp3k6whcklqnw2stx5tm@jpv2e5ydswzw> <80a9ec34-52eb-41fa-b068-3c9552065927@kernel.org>
In-Reply-To: <80a9ec34-52eb-41fa-b068-3c9552065927@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 4 Oct 2024 10:21:09 -0700
Message-ID: <CAH5Ym4g9hmX3mT5+Eqm=KHKYd+s_PM4qdho2a8FkAZmhMHOV4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based
 on BCM4906
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	William Zhang <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:51=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 04/10/2024 08:49, Krzysztof Kozlowski wrote:
> > On Thu, Oct 03, 2024 at 03:08:19PM -0700, Sam Edwards wrote:
> >> This is a series (EX3510-B0 and EX3510-B1) of residential gateways bas=
ed
> >> on BCM4906, a stripped-down version of the BCM4908 SoC. Although Zyxel=
's
> >> marketing materials call this a "series," the EX3510-B1 appears to be =
a
> >> very minor revision of the EX3510-B0, with only changes that are
> >> transparent to software. As far as Linux is concerned, this "series"
> >> effectively represents a single model.
> >>
> >> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Good day Krzysztof,

> >
> > Can you use the same email as for SoB?

I have sent patches to the LKML from a work email before, but I just
double-checked that I am using my personal email for everything here:

$ git show ec8e6d96a05f04 | grep -E 'dt-bindings|Author|Signed'
Author: Sam Edwards <CFSworks@gmail.com>
    dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
    Signed-off-by: Sam Edwards <CFSworks@gmail.com>
$ grep -E '^From|^Signed'
outgoing-ex3510b/0001-dt-bindings-arm64-bcmbca-Add-Zyxel-EX3510-B-based-on.=
patch
From ec8e6d96a05f04df00d05dec00df80172d233d8c Mon Sep 17 00:00:00 2001
From: Sam Edwards <CFSworks@gmail.com>
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
$

> I meant, same for patch author and SoB. How is even possible to generate
> different data? You had to change it manually, which should make you
> wondering if this is correct.

Hey, on a meta level: I=E2=80=99d appreciate it if we could try to rule out
other possibilities before jumping to conclusions. Reading this made
me feel accused, and I think framing things collaboratively rather
than assigning blame will make it easier for all of us. How about we
start with what you=E2=80=99re seeing and work backwards?

Wishing you well,
Sam

>
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Best regards,
> > Krzysztof
> >
>
> Best regards,
> Krzysztof
>

