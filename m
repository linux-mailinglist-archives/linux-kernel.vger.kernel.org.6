Return-Path: <linux-kernel+bounces-336054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F797EE86
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D735B1C216F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97E197A9B;
	Mon, 23 Sep 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iju+hA74"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783126AFF;
	Mon, 23 Sep 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106636; cv=none; b=X8EMCSPaA3ZU9peRe61Dayxv2Wj4+CGAM77EWNUzH17YPa6XQ2kg4k02SL+wtMvxt/UWbF8oaIviMK2z5OijNnWZnvgLugPdfKHTrG8PXwOKse1T9kwjBaKaZOJL0tr44K7OwGXt3ZvKS9lEaMW50NB5E+4mysY0AkwbwqoUg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106636; c=relaxed/simple;
	bh=SwgUatOVXZCU0ypiKRngwubUmXyeHEmeVCGfGcIeSUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glQJkYEJBfLinEh3omN+T0DVT8kl8TOp/mCL/uRXdmMSSugtMoR51ez10SgaBXi2Nc9lDSNinnlk2uuxnqGpjzM5MsWRip0O2107yJ0x+rC5AOBvSeBHS2tO6NjsOwMaVr+muwCr98hqsvBGxVSO/eQ4olfXM4Fx7Mi4CCCAI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iju+hA74; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5365928acd0so462605e87.2;
        Mon, 23 Sep 2024 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727106633; x=1727711433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=65WtYbgYhyGH8ZKmVPSvbniCCXdPVGnCxU6Ou+o5RyU=;
        b=Iju+hA74hFgHsVWAWhuQ43gCvpBcGysRF6IvBz403YiKvyr4ccabs6ONpTuoZKCDZs
         FCcuw+eAAw+PAAVcyUVEbY1yuMn9BnVNXQOkP9MOYOyAEeqLp/QP3DQP+6OlVC4ftjAZ
         zc9/Ll26jXOFm6BUFsWuYdC36CQ3kB4y13kAMRo2EeBCGLF8xzbG6D6XzOkcUxFr7IgT
         E+sYhmAnq28blu9UYTGzZwUWm+gM0Dq2aWvaE1SdwDVttjqINz7BbHCGAtYKLmQdflgD
         henafpXc8tDU6VgxRzrBGKeRF5vq9dLyP1AXZeBAcUlRVGNRieODA4sRIUYI12kdwr2v
         hC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106633; x=1727711433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65WtYbgYhyGH8ZKmVPSvbniCCXdPVGnCxU6Ou+o5RyU=;
        b=ETGcAKhhJhyVZ0DtCcvSHhNRBmi0YOY0TfCoM3wdscb6Qs7OkND37ao6AyaxBf9KB+
         dblpHkZIlGHMfLqunEFVmS8tO+p3Kq0oDX/BmlaSJK0ML6EyFZjgMkYVSZfYVkLjaqfA
         L5HxVhzj/guTPYOfl4peEWJV1SkFxKw26F5X0ARoZM8gkop/uydLls3f/JfsFp+5ldBD
         KKkMn9ydzfh3JMvY5XwTGIOk+s2gxWF0KmgI4cwpQKJNX4lo0XtTE2fkN3pl+Yo1wk2X
         AIGyzGqf6FyNCUNZ6ShfYNAYYfKrs1nb0ekjKmEkWiqeWvehJGcIo3wMWG+P48jw4r7z
         do5A==
X-Forwarded-Encrypted: i=1; AJvYcCVbRdYzS6ePJm8hwsiwhE92CHriZjJb6SXRoDCW7udQpRlvkqIywz12qwsox21E0QyC6h9QHWDWl6Nq@vger.kernel.org, AJvYcCWv1YxyaH3lgwpjEMeUEO5VCBJdT/gW3E37+wHM3mw0VNQcx6yTyB/35FY3I5VYXXfrTNWZgYp6qSgiVOqs@vger.kernel.org
X-Gm-Message-State: AOJu0YzM42NFV1D7dSYAacSNKXL/IAkoot0dxQyyL2b20AYKOLE3BDsv
	epJQ2x2Cg16tkJmn0WGXhPzyDqI75F7Y5q1e4F8ZiQ1nCEvzaR13BohVEnh7/ov5zYOoSyeferP
	wGRfsuigDVRYlCjcd2ypicX2olw==
X-Google-Smtp-Source: AGHT+IG0zwu7WHEUC6jQ/fiEGqK1rZqKLAsj3mVWqXEiVlvU34yosGTRz+FQ+v8otKgr5mlGF58jB8qeD7PmkQx5YO0=
X-Received: by 2002:a05:6512:3095:b0:533:7ce:20e0 with SMTP id
 2adb3069b0e04-536acf6b2b5mr5285760e87.8.1727106632289; Mon, 23 Sep 2024
 08:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-4-erezgeva@nwtime.org>
 <2fo7pndjqieq6lfydmq2pnwb374oqoqnrcsezycgougmr7mtl5@2wm6fe3inf5u>
 <CANeKEMPjLYbBi0AXkEdNum=kqtVe_mfTcVf4zUvJsszVhnh+pw@mail.gmail.com> <bcb4fcf5-b49b-4e1c-a5c4-e417d04097f0@kernel.org>
In-Reply-To: <bcb4fcf5-b49b-4e1c-a5c4-e417d04097f0@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 23 Sep 2024 17:49:54 +0200
Message-ID: <CANeKEMPSfGNLs+dwd0LWQUGpkGkShu5zOJhDbtMWyg-8SQaJKA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 17:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 23/09/2024 11:21, Erez wrote:
> > On Sun, 22 Sept 2024 at 22:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On Fri, Sep 20, 2024 at 08:12:29PM +0200, Erez Geva wrote:
> >>> From: Erez Geva <ErezGeva2@gmail.com>
> >>>
> >>> Some flash devices need OTP parameters in device tree.
> >>> As we can not deduce the parameters based on JEDEC ID or SFDP.
> >>>
> >>> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> >>> ---
> >>>  .../bindings/mtd/jedec,spi-nor.yaml           | 39 +++++++++++++++++++
> >>>  1 file changed, 39 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>> index 6e3afb42926e..4f7bb3f41cb1 100644
> >>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> >>> @@ -90,6 +90,43 @@ properties:
> >>>        the SRWD bit while writing the status register. WP# signal hard strapped to GND
> >>>        can be a valid use case.
> >>>
> >>> +  otp-n-regions:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description:
> >>> +      Some flash devices need OTP parameters in the device tree.
> >>> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> >>> +      This parameter indicates the number of OTP regions.
> >>
> >> OTP regions where? In DTS? On flash itself?
> >
> > Where can OTP regions be?
> > Can you please be serious?
> > If you have any suggestions, I am happy to hear.
> > I did ask before.
>
> Yes, I am serious, imagine that we do not know what you wanted to say.
> At first this just sounded like you mix nvmem-cells here.
>
> Out of blue this binding starts mentioning OTP and you add bunch of
> generic properties not really matching anything so far. Instead of being
> sarcastic about reviewers confusion, rather improve your description

Sorry, no disrespect.
I just prefer to be explicit, same as you ask me to be.

The patch seria is under review in the MTD-SPI-NOR.
This patch is under hold at the moment.

Thanks for the feedback and your time
Erez
.
>
> Otherwise, good luck.
>
>
>
> >
> >>
> >>> +      The value must be larger or equal to 1 and mandatory for OTP.
> >>
> >> Don't repeat constraints in free form text. Add proper minimum and
> >
> > Sure, I will add a minimum.
> >
> >> default, although it is confusing - property is not required but it is
> >> mandatory for OTP?
> >
> > You are welcome to suggest a better rephrase.
> > Using OTP settings is optional.
> > If you set OTP then the number of regions and region length are mandatory.
> > While offset and base are optional for OTP settings.
>
> So properties should be required?
>
> >
> >
> >>
> >>
> >>
> >>> +
> >>> +  otp-len:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description:
> >>> +      Some flash devices need OTP parameters in the device tree.
> >>> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> >>
> >> Don't repeat the same.
> >
> > Is there a grouping description?
> >
> >>
> >>> +      This parameter indicates the size (length) in bytes of an OTP region.
> >>
> >> What if each region has different length? Is it possible?
> >
> > Yes, there are. Old Mactronix have chips with the first region bigger
> > than the second region.
> > As these are old chips, we may skip the support of them.
>
> Other devices can come later re-introducing this approach.
>
>
>
> Best regards,
> Krzysztof
>

