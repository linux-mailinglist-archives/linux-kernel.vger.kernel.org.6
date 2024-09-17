Return-Path: <linux-kernel+bounces-331952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE997B368
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86FE1F234F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648917C7A5;
	Tue, 17 Sep 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awl5pKWL"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34C17A58C;
	Tue, 17 Sep 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593109; cv=none; b=tnkDJR14xHLlRRXbmUZPzFyPS1yP7MGjLkNrLQmwXP824FVlQotKtoTORw6qEHroRRGP5Et+bic7U0H/hhwpoccwU7DSng10nKDBknOHEBBKqWpEuFZIctulYGzkjp1UbyFnEi31dRPNYOi/ai2sM3LQY2MB1JrdgMFJQiW+Vjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593109; c=relaxed/simple;
	bh=Vtoqqgabc1G9E2/dP2uAse7Ulql+c0ta8ey2Ot5gIOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhZJBPerBqKOjGiU4daKIBNe+11TdzZrE/O1RpUDmCykD7G7DSmyaeL0WjLI8rYkAwLO1Pn4bpWVkbjs3DTKvMtloLW6cIsxbkupCfFYhi9C3W30M6k1FxH/T4rcdTTJyTFVOvKjZuVgMze8LGZQ/oTsGvVaJTxXQ36pByfH55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awl5pKWL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53568ffc525so6950697e87.0;
        Tue, 17 Sep 2024 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726593105; x=1727197905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hog72szpbcL8yTpsTavAS2Iy/j4igbX51PMgLnhSTu8=;
        b=awl5pKWLHDUMq8SehAvqksjMg2BX3A/7L4NEIypscFbzPkvpSQguwKdtV3+rPUY9Tp
         /O0NQcrEsObPteNSQLtNKGxO/YSbGZsPq7mcqZofY5WxCij4m/g+hscgpG2XDmd02/C7
         X8R3+i6IHxXeULYjgwAT51u3g7bmmlZXZd748/IKLQfGiblULgTTJxL0gZjSx3Sv0xq2
         vvyoM2EsDYPrIR2KxyJc7yBkusAQQYBpEYCRrIqGDQVvJbRclnMqr2Rprb1fEX3eiWZ0
         imQZzTixSz2KPACW4eCyaoHaIqGZskClANvwqjv9ZOJRMFbCE+TSCzXAqFZGU6bGDZ8v
         bVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726593105; x=1727197905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hog72szpbcL8yTpsTavAS2Iy/j4igbX51PMgLnhSTu8=;
        b=EDkZNSdIGIk/sJeCQZ1Y0c2f3XotARDVn5aAt7euh1qMtYgzhfYkmLBi69FPtUWj75
         BUuchoTATYqbsb3SMZuYzwbr9O413LVMoZ9KW8Z++b4LJvcFgcXFnmc4PVJhKQ/njy4W
         XV7Vj0p1RxfZthohmGY9YrTLV7e03saW+pTCqD5YtRXc1G8CnEfT1pJWXwQXswL1bkO+
         2L/k5go6i8HxAKTOXmhBqOJo7+pE8fGbU6W90eMXb/IuVx6Bvh4CX+PerigNIBecq++J
         cnxlcSqLroQfaIw1JGVNNDadTBGwq2ofeje5EWDeZcil+QOVM649sgrJoAFZnH449kCe
         yw/g==
X-Forwarded-Encrypted: i=1; AJvYcCUYdydm55DkYSXb42tBUJlGh2eqJrHb+n+JS6ALfBCo6Nma6lfiV2Cm7GaGsqr2/fxy8a3onjgJ5QkS/kA9@vger.kernel.org, AJvYcCWBGjgw57wNnRazWVGkZ95DTymOiLgE1n7HoN2PL5xvc9uCDmB4JpVlfAy68sLMAH1bV4S5d5ozPOZW@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUz8pVSxf3vvGi7xvaWQTlJ8wyEZDFDNwAWaEDFU8USPaYNfJ
	cicAvqnDvRoQ6ZIX8/HRlddJLlzfKdBEKyccK/rusMx9rDlILV0oru1tyNduHhjb73K0Q8rBxYh
	m0vXJPBobyalzjpIdtmBKlNWi37eg37XVJg==
X-Google-Smtp-Source: AGHT+IEG1JAQrUiK4lsLr7UsmqM4zC/fV3ngtm8n9NhSvVhCx0F0+RZCQqwayMWioWesSUM7H3D2Pj8ZAa90UpX9750=
X-Received: by 2002:a05:6512:1154:b0:535:6a4d:ed74 with SMTP id
 2adb3069b0e04-53678ff2ec8mr11166979e87.51.1726593104166; Tue, 17 Sep 2024
 10:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917094956.437078-1-erezgeva@nwtime.org> <20240917094956.437078-4-erezgeva@nwtime.org>
 <9c273945-5a70-408e-a9da-a0797aa6d935@kernel.org> <CANeKEMN+ZUAGKGsqnaToDB3AxX9NN_JeCBWHwd-wwnTWLU3R+g@mail.gmail.com>
 <64ef46b1-7908-4b15-866d-9cabe2e5dc9e@kernel.org>
In-Reply-To: <64ef46b1-7908-4b15-866d-9cabe2e5dc9e@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Tue, 17 Sep 2024 19:11:07 +0200
Message-ID: <CANeKEMPwgtECfksgz6jXkR+bjVFwCB9DOh1q7t_3WeojReqxbA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 19:00, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 17/09/2024 12:42, Erez wrote:
> > On Tue, 17 Sept 2024 at 12:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 17/09/2024 11:49, Erez Geva wrote:
> >>> From: Erez Geva <ErezGeva2@gmail.com>
> >>>
> >>> Some flash devices need OTP parameters in device tree.
> >>> As we can not deduce the parameters based on JEDEC ID or SFDP.
> >>>
> >>> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> >>> ---
> >>>  .../bindings/mtd/jedec,spi-nor.yaml           | 37 +++++++++++++++++++
> >>>  1 file changed, 37 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>> index 6e3afb42926e..d502b7fab2ce 100644
> >>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>> @@ -90,6 +90,43 @@ properties:
> >>>        the SRWD bit while writing the status register. WP# signal hard strapped to GND
> >>>        can be a valid use case.
> >>>
> >>> +  opt_n_regions:
> >>
> >> No underscores, but hyphens.
> >
> > I'll fix this.
> >
> >>
> >>> +    type: u32
> >>
> >> It does not look like you tested the bindings, at least after quick
> >> look. Please run `make dt_binding_check` (see
> >
> > I run "make dt_binding_check" on kernel 6.6.
>
> Yeah, we are no on kernel 6.6. You can run it also on kernel v4.1 -
> still does not matter.
>
> Don't develop on ancient code because then you ask us to review same
> broken stuff we already fixed.

I test with Beaglebone black for testing, it is difficult to run the
last vanille version.
I did backport the spi-nor driver.
As for "make dt_binding_check" on last kernel, it need to upgrade the tools,
 and I did not think it could change that much.

The patches themself are based on vanile kernel
commit 6b0f8db921abf0520081d779876d3a41069dab95 (origin/master)
Merge: 6b4aa469f049 f50733b45d86
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Aug 13 16:10:32 2024 -0700


Erez





>
> Best regards,
> Krzysztof
>

