Return-Path: <linux-kernel+bounces-331622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE197AF17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F062818A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97116A37C;
	Tue, 17 Sep 2024 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIgE5YF6"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29416131A;
	Tue, 17 Sep 2024 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569765; cv=none; b=DmCzsVw7Mrt5CBpD4vmNizx+Vb14TYzXTHWWU57Tjyd53f5ChJk/FXi8q/FfxVw+4kSFHzxOeGGDN1G/mjNmGQon1Rd7mj+NwRlVJeUuxshRwGvB33Jb5W0Um9YVzo8llRtsMTpAvA2wBG6EhdosTMECIWmvEg2kkCtE83TBWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569765; c=relaxed/simple;
	bh=E9a/nxXo2KiCHfXmLHA8W5nWpSHl1mkItmUZHHEd060=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IghpCZpoEvWIxMrDq0lk7I1dagZxNjbzjAvnhzqyo1U6nRJO5Eimz5kur1VSi310sSZVuCyGjvmCN5M9o1kus1V58rYF3p8o7OvwT0iNyGr6j5f/1Kx9yRNWwPfZ865j15o/RSMJt91AYkJrGg0O/qMHljE2ubwPQ+u4VbGsAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIgE5YF6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f763e9e759so55786611fa.3;
        Tue, 17 Sep 2024 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726569762; x=1727174562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofmX+HKXE00WtuM13hFGpW8n7y4t1BDYpJWpTwCfwYg=;
        b=BIgE5YF6Ue3O9OXMIy5gRbmp0Sqh1SPHjYjge27rEVylgFZ1NoVm6VMXSeqlQTMDAp
         R4wC86o/yevVzYXVyrMkxa+OVtw14PrCu8UU6efHA7OCt0ZUymawoAntST2IH/VeEAyy
         lFI0GeI/dtDrsFrLVGyDgLfnwQngQyZAyGg/yV+tI8ENXNLXYmj9EsawI/U0BstAXfrF
         lPCcvPgWUumIgn22xLyWh1yj3ZwbMPvYSf0SjJhGR9rslDAHKp6Pkw7lMEkMuHkw4aZG
         HqlMbeMdPR7v/lmqhEaNTJR8+aDUCwD4+BcZevh/e+mxRr4OrP2CA9Qvmt9Fo7In2L9A
         XEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569762; x=1727174562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofmX+HKXE00WtuM13hFGpW8n7y4t1BDYpJWpTwCfwYg=;
        b=DmfH893KnxQsj10NPAzqf7OojQG19YinuCXjQ3uv+4oWUjW8XV1sf+5YST3a5TfUob
         4KbZcnaDJOwR9G5thsCUN4DOzLkm/5ijwykPWpojO8xRCdAKukP1+DUjBIWZQdtNKfRN
         mQ4tMKlley4rE21UoMyGrv6A65c/FsoShpfwkR8BgV13akdkY0+gIe7qKbPmOP1icccr
         0flioI9ogYR1ZrRV04dFE5C1GO5bjUVxm1HUAXBUvfJ08+89sahg5TQoLMFH4zGupAzG
         VSdNhReWBlHtSWwDsueiPCeLFUKbvXCgrHuQ/0ExDGiqy0l7GOeBGZzkHEP7159WYieR
         XbGA==
X-Forwarded-Encrypted: i=1; AJvYcCVrWGW0d9nBleISW+Dc70yK2HbiHEZJhpg1ujuc0h48aYhNG5Rhn9Re8+sQDB+wo87wtn2wK2IkS8uiH5XM@vger.kernel.org, AJvYcCWjlWCpGN87zJOkt+d085rM0TDBOChbjc9qT1FgHzxDukBl7Rpl5EzAPY3Uj3kO/aM84MIKB8mmcCgY@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2GdQbtTTr5h0criq8r4oMTTsTAbNiDGfYAJdqGrplz7VMAjN
	aEdyWVQ+h4zpX21YVdDGh76SEsQ967jNfQ1TFCzVve6BvzMgzNtXZ45okmWnoGDvEK2FK79BWPp
	PCt2BKX7UrQ3Zi+TEVJIwCtaq8w==
X-Google-Smtp-Source: AGHT+IE7wDEsYvo3hu0cfYozzAesa6JgzseU8Or3sJo+TYtS5n5WmyOVSXkx1QfoYY8onXcByFX6eMTMS9XFQBUU0jU=
X-Received: by 2002:a05:651c:b12:b0:2f7:6812:d0ae with SMTP id
 38308e7fff4ca-2f787dc301amr101396411fa.13.1726569761761; Tue, 17 Sep 2024
 03:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917094956.437078-1-erezgeva@nwtime.org> <20240917094956.437078-4-erezgeva@nwtime.org>
 <9c273945-5a70-408e-a9da-a0797aa6d935@kernel.org>
In-Reply-To: <9c273945-5a70-408e-a9da-a0797aa6d935@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Tue, 17 Sep 2024 12:42:05 +0200
Message-ID: <CANeKEMN+ZUAGKGsqnaToDB3AxX9NN_JeCBWHwd-wwnTWLU3R+g@mail.gmail.com>
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

On Tue, 17 Sept 2024 at 12:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 17/09/2024 11:49, Erez Geva wrote:
> > From: Erez Geva <ErezGeva2@gmail.com>
> >
> > Some flash devices need OTP parameters in device tree.
> > As we can not deduce the parameters based on JEDEC ID or SFDP.
> >
> > Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> > ---
> >  .../bindings/mtd/jedec,spi-nor.yaml           | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > index 6e3afb42926e..d502b7fab2ce 100644
> > --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > @@ -90,6 +90,43 @@ properties:
> >        the SRWD bit while writing the status register. WP# signal hard strapped to GND
> >        can be a valid use case.
> >
> > +  opt_n_regions:
>
> No underscores, but hyphens.

I'll fix this.

>
> > +    type: u32
>
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see

I run "make dt_binding_check" on kernel 6.6.

> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.
>
>
>
> Best regards,
> Krzysztof
>

Thanks for the feedback.

