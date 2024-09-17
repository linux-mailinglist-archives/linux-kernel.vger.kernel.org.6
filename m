Return-Path: <linux-kernel+bounces-331973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F59797B386
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC8B22B66
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70133185E6A;
	Tue, 17 Sep 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgNEYCMw"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8AD17107F;
	Tue, 17 Sep 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593894; cv=none; b=SrbuurD2Aq0cRyE9/Egb1Pqgy5EZS/KWO+mIO0e0oHJRi2Y/2gHB7z4wMsA0hMc+f1z2qAErca2cMgbfX7Pzopgi2bXfuvhnR+VzfuAChNl1F3FWHPg6DZf0YrIW5U/bXlT2Ge0sPuAbRKTfWL9vBOV0vSuH98pwr224jQcU70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593894; c=relaxed/simple;
	bh=0K3ja/4E2/iLn6ccMlRhM+NbNCrsYQVzgmreDO5J0Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHKo67sb3bOLwqW9gSmIwByAzlDWAz7ku0+Goffq6wIygztZiig+NJHHaQUtJSIIlTumcaPeWs9+V4/XsyLvf6ZoyrGDPiGqdrmQRqRJzK0/4mK/g60AXK0Gy9RHMsKWMhn6FI5eV45R5piZjn9dxkzgbZvm75d4RbXoNhnmu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgNEYCMw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so4998069a12.2;
        Tue, 17 Sep 2024 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726593891; x=1727198691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnRoikBSLAdyHdgiB2Nvl7M+y+qgJGkvLu1aR7KRctc=;
        b=FgNEYCMwoTylgfGcM9ks2fKGekB6LWM17anXxu6A8elB4H0Pp5oD3HWE/J7nYPgSC/
         HxgpnUH6y2RSUQMv9tKeuzRTmB8kONfh3/u8Q1e8wjTgtNRo8swuNdBKq1HfXx42H3Rp
         ibJfS99XRZgMQpzLAlvsjAIh4Q75zQUi7hiAHa6LeM7tnrZmj1Q4G1lbHBPIbklzzOnz
         9uI9yMAnmt9Kyt1prftgskU+GKwDi5NpQ1uagcHLq6TGB+Wp23c210A8PgAZfpvCkJpg
         kS6NAbgaaAMsMHrDwCPhxeaEE4NrWjPjPICW3RyrdlppuBrlpGUPx6POeJnURooJdLLW
         B1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726593891; x=1727198691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnRoikBSLAdyHdgiB2Nvl7M+y+qgJGkvLu1aR7KRctc=;
        b=RkvXpzXdXUlvPSfjxWvXRR7xbsTq5knWkFI27tE+ropwwfpp4SbVtzDVBLB+NvGzQP
         UZK5jkAXwKcyO52O3UZ6hFdQkigw8SfQLbfCU5KyxjnwcbTZsdjlfWU0DYMQL5JnnT7Z
         YSu8DHYEBlsOHnswzCEIjgpped4E9GrREWStMNDxZE7oP+pHkm0RJa3jiwDA7Sa1KYjM
         laV81nSfQ05+kt4Fz5vpuULJTC8jXgjiOjMD68EHeyaakk3kBx55/klWu8aTeV63u+bq
         Pey/fKusTy0T7OygQ7P7ei0ZpRqaPv1nQSb5cmdQgmiOySYMIHVJJ4VmbNX3OqPT3nHi
         py/A==
X-Forwarded-Encrypted: i=1; AJvYcCW+/Oz562mCbMYPV2VFeK1K9dIAe+XrrawtUwusmpQbOTlL9OPDnFMd8fM0tZpNsirrS5IFqhHc8aLI@vger.kernel.org, AJvYcCWqrx7aLM8UKy/ob9MyFLzXI1kaA0o4+u5mmSRR9vm+IfbSUv52HQYeEio8zahYRi4ghYYVHZpj2iFa3A8C@vger.kernel.org
X-Gm-Message-State: AOJu0YynBffluks8+7GSRr+7jP0nZs6QynfJgKhLYdV1YaXkRW/IKAtg
	zl0vsfIQXFp+7h6edhp3VwMI3XZbSKPYKlzGZ4v29tH97K4C2NFeMEFYicHDrYG0ZcOX6gZQofF
	wfm9qOh1O5Zp5YXn1X2skUSEAhg==
X-Google-Smtp-Source: AGHT+IGwwp6ZGJvzsQTeNC0u7Fy37kDIWdvbQ/4lRre03Vts9cqGVpEQqd1peAQbt9PnTy7wvU5Qk2ltX9t6HDvGnGo=
X-Received: by 2002:a05:6402:5186:b0:5c0:902c:e195 with SMTP id
 4fb4d7f45d1cf-5c413cbb42bmr19797345a12.0.1726593891251; Tue, 17 Sep 2024
 10:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917094956.437078-1-erezgeva@nwtime.org> <20240917094956.437078-4-erezgeva@nwtime.org>
 <9c273945-5a70-408e-a9da-a0797aa6d935@kernel.org> <CANeKEMN+ZUAGKGsqnaToDB3AxX9NN_JeCBWHwd-wwnTWLU3R+g@mail.gmail.com>
 <64ef46b1-7908-4b15-866d-9cabe2e5dc9e@kernel.org> <CANeKEMPwgtECfksgz6jXkR+bjVFwCB9DOh1q7t_3WeojReqxbA@mail.gmail.com>
 <e0db2f62-b2fd-4b61-932c-cc2caf5dd647@kernel.org>
In-Reply-To: <e0db2f62-b2fd-4b61-932c-cc2caf5dd647@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Tue, 17 Sep 2024 19:24:14 +0200
Message-ID: <CANeKEMNCFKX2thq+Ws0vy9ovbQ7dve3YPh_FbRaoOEgL+7c_Mw@mail.gmail.com>
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

On Tue, 17 Sept 2024 at 19:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 17/09/2024 19:11, Erez wrote:
> > On Tue, 17 Sept 2024 at 19:00, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 17/09/2024 12:42, Erez wrote:
> >>> On Tue, 17 Sept 2024 at 12:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>>
> >>>> On 17/09/2024 11:49, Erez Geva wrote:
> >>>>> From: Erez Geva <ErezGeva2@gmail.com>
> >>>>>
> >>>>> Some flash devices need OTP parameters in device tree.
> >>>>> As we can not deduce the parameters based on JEDEC ID or SFDP.
> >>>>>
> >>>>> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> >>>>> ---
> >>>>>  .../bindings/mtd/jedec,spi-nor.yaml           | 37 +++++++++++++++++++
> >>>>>  1 file changed, 37 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>>>> index 6e3afb42926e..d502b7fab2ce 100644
> >>>>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>>>> @@ -90,6 +90,43 @@ properties:
> >>>>>        the SRWD bit while writing the status register. WP# signal hard strapped to GND
> >>>>>        can be a valid use case.
> >>>>>
> >>>>> +  opt_n_regions:
> >>>>
> >>>> No underscores, but hyphens.
> >>>
> >>> I'll fix this.
> >>>
> >>>>
> >>>>> +    type: u32
> >>>>
> >>>> It does not look like you tested the bindings, at least after quick
> >>>> look. Please run `make dt_binding_check` (see
> >>>
> >>> I run "make dt_binding_check" on kernel 6.6.
> >>
> >> Yeah, we are no on kernel 6.6. You can run it also on kernel v4.1 -
> >> still does not matter.
> >>
> >> Don't develop on ancient code because then you ask us to review same
> >> broken stuff we already fixed.
> >
> > I test with Beaglebone black for testing, it is difficult to run the
> > last vanille version.
> > I did backport the spi-nor driver.
> > As for "make dt_binding_check" on last kernel, it need to upgrade the tools,
> >  and I did not think it could change that much.
> >
>
> Well, it is possible to build kernel on small embedded board, but that's
> quite cumbersone, slow and inefficient, considering that it's just
> easier to cross compile. But anyway, binding check does not even need
> cross compilation.
>
> Sorry, the code is obviously wrong, there is no such thing as u32, so
> you did not test it. I provided link which explains how to test it. You
> must do it on latest mainline kernel. Just like you must develop and
> generate patches on latest mainline kernel, because this is where we
> apply the patches. We do not apply them to v6.6.

The patches are based on the lastest  mainline kernel.
I do not understand why you think otherwise.
I will run the "make dt_binding_check" on the mainline kernel.

Thanks for your feedback.
Erez

>
> Best regards,
> Krzysztof
>

