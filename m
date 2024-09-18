Return-Path: <linux-kernel+bounces-332485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5E97BA53
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426232816C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747D717AE0B;
	Wed, 18 Sep 2024 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfn7z9Am"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9D6FCC;
	Wed, 18 Sep 2024 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652848; cv=none; b=KjDWOjf1zKmx0CT0NAkKCi++TJeWtsxSIJ0l0bH1UsHjpnlFGIW/91QU+rvMuSHBPVQ1WvHPTRFvYPSHSej0xarVVG76WW1lMGWq06ne+xK4M7XQ+ZalYtKhMot2oLIDZ73IKNLDRlX53YScDBrS7n4eENxku/hnl2MHLBR5iBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652848; c=relaxed/simple;
	bh=KYURACM8Ml+oXgLpSqcW4uefRW+H9KKlh2+cTgne97g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI0e8J2NvJGUWRHq5biVjKrR3E2h9H6a8ls/qEW+uATi1T2bbNZlQau4Uz/y5kKqZpYHU6wq+mtMmQIW5rAIuHTq7EIhqxoLj0+vaivvtA3D+oLHXJnd3koG0mnbvVaZYM3sep0rJTnxWxpYcILZMVq86+eZLAbTwvIga3LQXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfn7z9Am; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-536748c7e9aso7920067e87.0;
        Wed, 18 Sep 2024 02:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726652845; x=1727257645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TY2rYPGlE0vWg6gT7yYeg30ZK7sblLGMWQMlgB7ozqM=;
        b=gfn7z9Am3fNm0mo1CsUabIc9pQWnjBleHxfgvqjMhAb95R8GxEK7jrVCJLuNxOHrQA
         otClPwmARAxDquwJNQK4ZPwr8XZi7GEAdsePOgR0YBALYr2+37MDHxI302b9tLYdG3mp
         jVakJXW5m1NG4IrG2EAFx8syzS1rDZbBprrfnWleJ/FlEVwqhF52ii8Qm1UYpYlXdksy
         4dNekd3IeyWq2c/jpOFPADnda8aqLGL5dInJfCDOVrmwljK0H7sqgQA1ZVhyGroSjYmU
         b6/E82gdKVfO4eGfq3ClkRrq/ysDAg98p+EetZ81QyMnRXbhtVVb3BL+b/1a0ZFLSQau
         N7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726652845; x=1727257645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TY2rYPGlE0vWg6gT7yYeg30ZK7sblLGMWQMlgB7ozqM=;
        b=SaT7efm7xRCzURvLXyjTQ+fLtIfNw4Nett2iagKO1a25OwHfcZiCVriOepjFhJ9KOG
         Fouyh/iW7dEEFwXpcYshDijIA/gC7joqdXwXGggPo2dNBThR9vtlWiQ8G3EBQ4OBlVEZ
         5A3tOpwnzXC7fN+0CLhL0skcoPV1EHYzetYJA57zTum5u62JEjRKrfbip6oPfki50/5f
         IPdAW38ESe3jZH4oQpo+kYm0haTNB813DOgHladOhxNBffwTdp4KdSByFKfEbXsJlowW
         Wg8i0876phZ+75MLL5a8hSVR4B3pIvrAaxY59FhLS0lKoagJWJ1DqVLVkLj4sH/SYUvZ
         xZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUo0JLMZC048fxgl72/tYVE9g7VAzlZUW6iEdhRULRQnFgU/pKTAFTTaPFsFyRBBH0vIydr0RtGnIuFEhN4@vger.kernel.org, AJvYcCUuaJSVB6tPZ4oITVd4wesmegc+lH7f6F2ATe3aW4Q+PnchmWniLDoVD6a9lWgoK84l2PrltuvY0saP@vger.kernel.org
X-Gm-Message-State: AOJu0YxFR59DX3hrXKoSNX0Kk0sn3BkgqJ3sXMDQPZWCu2piQByAvsgj
	13Qoxp7nzn7UyEmckbrzZBO1ubEdZTQKeJA4eGPZzc8Qo+CCI85wtlUgl5TI5uhx7myXyQtOcGC
	aZZd/cal9QF3oOEoHrhWiGGE+rw==
X-Google-Smtp-Source: AGHT+IE8mSq9PP7PwdXQaB8swlr8wM6nQTvYf7oqaQMdaVQ5EDeydZlbEtu51pTvRiG7d2NjtJwikQ1Y/YBCFxmQE7A=
X-Received: by 2002:a05:6512:280d:b0:536:5413:2d47 with SMTP id
 2adb3069b0e04-53678feb11fmr12885649e87.41.1726652844767; Wed, 18 Sep 2024
 02:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917094956.437078-1-erezgeva@nwtime.org> <20240917094956.437078-4-erezgeva@nwtime.org>
 <9c273945-5a70-408e-a9da-a0797aa6d935@kernel.org> <CANeKEMN+ZUAGKGsqnaToDB3AxX9NN_JeCBWHwd-wwnTWLU3R+g@mail.gmail.com>
 <64ef46b1-7908-4b15-866d-9cabe2e5dc9e@kernel.org> <CANeKEMPwgtECfksgz6jXkR+bjVFwCB9DOh1q7t_3WeojReqxbA@mail.gmail.com>
 <e0db2f62-b2fd-4b61-932c-cc2caf5dd647@kernel.org> <CANeKEMNCFKX2thq+Ws0vy9ovbQ7dve3YPh_FbRaoOEgL+7c_Mw@mail.gmail.com>
 <fe98e49d-96d1-462f-99ac-93d8a53e55fd@kernel.org> <CANeKEMNg_hPcVHVo2c9u1Vdzaso0ODT+2uLmip6sd26uK8d_FQ@mail.gmail.com>
 <20240917-taps-applied-6c0d411bbe08@squawk> <CANeKEMOXZjgLm-Wb8+9RMJYNN1a2Oy81P3MXZiLxNaAerLhYEA@mail.gmail.com>
 <a74cf534-b8ce-4d06-b15b-3df349b48c4e@kernel.org>
In-Reply-To: <a74cf534-b8ce-4d06-b15b-3df349b48c4e@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Wed, 18 Sep 2024 11:46:47 +0200
Message-ID: <CANeKEMMGChm54BNJL6P+-K6OoD6U=OVXo8ss9JgxCQMY+_roqA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 10:23, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 17/09/2024 23:29, Erez wrote:
> >>>
> >>> I install dt-schema_2023.11-3_all.deb
> >>> with Debian trixie
> >>> I get:
> >>>
> >>> l
> >>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >>> Traceback (most recent call last):
> >>>   File "/usr/bin/dt-mk-schema", line 8, in <module>
> >>>     sys.exit(main())
> >>>              ^^^^^^
> >>>   File "/usr/lib/python3/dist-packages/dtschema/mk_schema.py", line 28, in main
> >>>     schemas = dtschema.DTValidator(args.schemas).schemas
> >>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> >>> 363, in __init__
> >>>     self.make_property_type_cache()
> >>>   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> >>> 420, in make_property_type_cache
> >>>     self.props, self.pat_props = get_prop_types(self.schemas)
> >>>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> >>> 187, in get_prop_types
> >>>     del props[r'^[a-z][a-z0-9\-]*$']
> >>>         ~~~~~^^^^^^^^^^^^^^^^^^^^^^^
> >>> KeyError: '^[a-z][a-z0-9\\-]*$'
> >>> make[2]: *** [Documentation/devicetree/bindings/Makefile:64:
> >>> Documentation/devicetree/bindings/processed-schema.json] Error 1
> >>> make[2]: *** Deleting file
> >>> 'Documentation/devicetree/bindings/processed-schema.json'
> >>> make[1]: *** [/home/builder/kernel/Makefile:1435: dt_binding_schemas] Error 2
> >>
> >> Have you considered that this might be because of the invalid types you
> >> used?
> >
> > I remove the types.
> > Anyway, scripts should report on errors, not crash.
> > This is the purpose of syntax scripts, to help us, developers find out errors.
>
> Yeah, things can be improved. Help in that is always welcomed.
>
> The package you installed is very old (almost a year old!). I suggest

Debian tend to be old and stable (althguh this packages comes from sid).

> using pip or pipx (or virtualenv or whatever Python setup you have).

I'll try.
Though I am not a python developer. I usually do not use pip.

I did see a version checking:

$ make dt_binding_check
sort: -:2: disorder: 2022.08.2
ERROR: dtschema minimum version is v2023.9

Thanks
Erez

>
> Best regards,
> Krzysztof
>

