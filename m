Return-Path: <linux-kernel+bounces-380749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E139AF584
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D5D1C23040
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50962185B3;
	Thu, 24 Oct 2024 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vqs3Mhn/"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638B2170C5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809505; cv=none; b=UbO6ObbFlGfbTGBIb77rNZXpQkqvKiCyIYsLsvtnabnQeSsRc6T4On3PvbMClCN/y7TPjfMDsgOF9v+rw8XX2/0ZtfRaN+T8juoRb7a9RN/BsoQHlTrFLucJEH8wL9sz0BrOKscRdUTgWvDD5hNzH3QWFbcIQLGkoddeHk73ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809505; c=relaxed/simple;
	bh=X8VlimnOpM3aYSaRCVCsg/PKQwzSkTGsHNQgqT+QXbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNQmsCoMBMwBx5Rf8O2zweqAH6L2JhA8fLmxhXaYmo7Da3UGFFsfB78dALCvxTaJWu41bq2Kt0fLhythmoY33VrwpB3svaY6JD12AkQRQLltgsSGppSqE7GcXou9WLJGG102dZXqQyTtT+W4SjJbTWSSF8Hkx32smZP0co2058I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vqs3Mhn/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53a007743e7so1760270e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729809499; x=1730414299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd8x1e93gyeJX8KDkGrIIHUTJan7juKooq/kAucfUrQ=;
        b=Vqs3Mhn//W33/enae8vuFIx5z323FRts3jxve4kgRbrT+DsJqkH9oQEh2Ct1edco6x
         vO2q0nyOdP5FVMTMc7mOaTbgiYYTJkablH+Ef4mffbWVJZtxf8M/OBQGQTJcsSB+PV6L
         Ro4Cwbyco6Xwnc/QHAU2vP8D9BNJ8vpeuhu40AZ2S/9owwj9vP/oya+/XOw2MMzqv19Y
         f1jPRwzipoNuPThalOsRlbUAe6303AmIcMMkkJpSChNVgmH864vCDl8mqIoiDK68ChBy
         /Uv8Ro65HiwtDG6Ph4S6V0K1xkMSadM7TgeQcLHrNVFkvRPWy6hZHYWvVOwXYm6uQMGO
         rAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729809499; x=1730414299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd8x1e93gyeJX8KDkGrIIHUTJan7juKooq/kAucfUrQ=;
        b=u2Sv3i8qVEkOcShP4LgAiBOHeP7FeCQYOVTNuiUhqK+tAZsVjYbIu9tYn8vnYNNxjx
         F5LehA7ghtmPipIXe1Zx+sqimg0zRZUM//0odXBFuCgLuYAgne87x+Jt5vPGtcz5hc+i
         spIWbwF8lHazaPWQQsVMlb8R6pPfRo/dwKBV6frKJA6xX5nI8kwR2/7qYcqa43Yv85S6
         aEAxzQ4iiiX2uvQHcyTAeJLGdqcjxb3nshbgyxynzRvB8K2ngiEqBknlhz9I+amBq0Z1
         76bUlL740x8C6/QGvB3OCO/756oWi8DaxTl71jAU7lNEdwm3yC3KNP8SM7shI5RVO26f
         ZFpw==
X-Forwarded-Encrypted: i=1; AJvYcCUNtU1NZgEapWBa9xImt77im6BSew6POcFI4t/RXN9dMeDYy0tf9Yy/HrEtZIZr5w1hFbLCEMGRm5M8SXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqjQKV+fUVeV2+UhB6mq9WAOuv59cqGMEV2KQaL/yDibv5bjS
	0ov+sMl1IhFqiQdaj46YXMfrNrgCac7sXZlUvd5Q3y6iF6PfjS5avt/FM84hNA7C1hFVj/YY/Xg
	Q79uqKkHGn8MduP7iyuV0zA310gJ6j+wJlEAvLw==
X-Google-Smtp-Source: AGHT+IE5xxtC2Rc24n40JWosDcNQf9KHvHXEMlpBefnnaFUNn8d62HXfg1mRdDkM6cR/UQGw/6tcJB7OYxes1hC/wMA=
X-Received: by 2002:a05:6512:a8d:b0:539:fbfa:4a9f with SMTP id
 2adb3069b0e04-53b1a3a7a4bmr3558958e87.58.1729809499262; Thu, 24 Oct 2024
 15:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022155658.1647350-1-antonio.borneo@foss.st.com> <20241022155658.1647350-8-antonio.borneo@foss.st.com>
In-Reply-To: <20241022155658.1647350-8-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 00:38:08 +0200
Message-ID: <CACRpkdZKimfE_00kxa_qAf+jjwxBtuKizDTd3RvOS_PDuZ_JKg@mail.gmail.com>
Subject: Re: [PATCH 07/14] dt-bindings: pinctrl: stm32: support IO
 synchronization parameters
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Stephane Danieau <stephane.danieau@foss.st.com>, 
	Amelie Delaunay <amelie.delaunay@foss.st.com>, Fabien Dessenne <fabien.dessenne@foss.st.com>, 
	Valentin Caron <valentin.caron@foss.st.com>, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio/Fabien,

thanks for your patch!

On Tue, Oct 22, 2024 at 5:59=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> From: Fabien Dessenne <fabien.dessenne@foss.st.com>
>
> Support the following IO synchronization parameters:
> - Delay (in ns)
> - Delay path (input / output)
> - Clock edge (single / double edge)
> - Clock inversion
> - Retiming
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
(...)

I want to check if we already have some of these properties
and if we don't, if they could and should be made generic,
i.e. will we see more of them, also from other vendors?

> +          st,io-delay-path:
> +            description: |
> +              IO synchronization delay path location
> +              0: Delay switched into the output path
> +              1: Delay switched into the input path
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1]

This looks related to the st,io-delay below so please keep those
properties together.

Is this path identification really needed in practice, isn't it
implicit from other pin config properties if the pin is used as
input or output, and in that case where the delay applies?

Do you really have - in practice - pins that change between
input and output and need different delays at runtime (i.e. not
at startup)?

Otherwise I would say that just checking if the line is in input
or output from other properties should be enough to configure
this? input-enable, output-enable to name the obvious.


> +          st,io-clk-edge:
> +            description: |
> +              IO synchronization clock edge
> +              0: Data single-edge (changing on rising or falling clock e=
dge)
> +              1: Data double-edge (changing on both clock edges)
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1]

This looks like it should be made into a generic property,
it seems to be about how the logic is used rather than something
electronic but arguable fits in pin config.

Isn't this usually called DDR (double data rate) in tech speak?

What about a generic property "double-data-rate"?

> +          st,io-clk-type:
> +            description: |
> +              IO synchronization clock inversion
> +              0: IO clocks not inverted. Data retimed to rising clock ed=
ge
> +              1: IO clocks inverted. Data retimed to falling clock edge
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1]

Doesn't this require st,io-retime to be specified at the same time?

Then we should add some YAML magic (if we can) to make sure
that happens.

> +          st,io-retime:
> +            description: |
> +              IO synchronization data retime
> +              0: Data not synchronized or retimed on clock edges
> +              1: Data retimed to either rising or falling clock edge
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1]

Can't these two be merged into one (generic) property:

io-retime

enum [0, 1, 2]

0=3Dnone
1=3Drising retime
2=3Dfalling retime

Retiming seems like a very generic concept so I think it should
be made into a generic property.

> +          st,io-delay:
> +            description: |
> +              IO synchronization delay applied to the input or output pa=
th
> +              0: No delay
> +              1: Delay 0.30 ns
> +              2: Delay 0.50 ns
> +              3: Delay 0.75 ns
> +              4: Delay 1.00 ns
> +              5: Delay 1.25 ns
> +              6: Delay 1.50 ns
> +              7: Delay 1.75 ns
> +              8: Delay 2.00 ns
> +              9: Delay 2.25 ns
> +              10: Delay 2.50 ns
> +              11: Delay 2.75 ns
> +              12: Delay 3.00 ns
> +              13: Delay 3.25 ns
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 13

This looks very similar to the existing "skew-delay" property:

  skew-delay:
    $ref: /schemas/types.yaml#/definitions/uint32
    description:
      this affects the expected clock skew on input pins
      and the delay before latching a value to an output
      pin. Typically indicates how many double-inverters are
      used to delay the signal.

can't we just use that?

Feel free to edit the text for it in
Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
if that is too clock-specific.

Yours,
Linus Walleij

