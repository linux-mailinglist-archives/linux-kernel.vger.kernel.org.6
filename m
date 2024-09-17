Return-Path: <linux-kernel+bounces-332009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E5597B42A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA791F253C5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAAD185956;
	Tue, 17 Sep 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcD6Nhe2"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A32628C;
	Tue, 17 Sep 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726598429; cv=none; b=DtMFHx7l36ajNXZKvqYcdLOUQ+GXSzdWdNlgMaUg/nHf9nfMYucKw64w0gnjXL7qUfrihqkbspljU94JEsCWrwI5LI0cKL/f21A+0+YOFHrhxvZCzS3TrWAiq4nE144OPd+ONLijSYsy5pqxl3NLlpVXBEE7alxFnBfIP1kWn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726598429; c=relaxed/simple;
	bh=2dvbWOKfE4e5sPCB8d1JuhBqAKN4+RoZhwdHc2/w+l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LykTC/q5aKo93iIG3KvVClsPHDiq6PVcHFEaRroyWtverrAeTa7g9czb+ew4EBRbda1JMg6ESYWryHAsUADSipojFJ5NCc/MrihNyllD9uI3jLOBIVIJDYK5kqAkSloSIk6EODHn/SdmuRPUFS0pEemAUtMk+1s61n4UU5+oHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcD6Nhe2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so857796a12.0;
        Tue, 17 Sep 2024 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726598426; x=1727203226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3W43sCdJ9cKmQgVhii/XmReCdXpMFSO7vySLNva3/Fs=;
        b=fcD6Nhe2pSzb/s0aNNrjsiEfRSh5mZPsR3m/id7kBZKt01xbwMFuphvwVzrZ0XLVUh
         u7Z4qmsqwbKj+0u/YyPjVvi4/W1NzOucXrBnT2e6Cg+F01mgwT0WGF8t3DMNu5tlAbCm
         MeHSQhPqkFISZeMw3jI3YmG2pbZbzevNSz0zVPrDjwiOJzNyEG4kPS19QxmuXuGQyBJv
         hIOJY/XIV5ZS5aNt8gTGPAwR2cUAyUdH3sEwvK9PnjBs6fcwt00WUG7NZ7Gt9twPzfuY
         a9YzKJsLJkByUxTKwZs51/uLt3CnfuBnWZxPEprIa4nvzuhAyo4oCQZUm+9ki/pDoNKS
         OyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726598426; x=1727203226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3W43sCdJ9cKmQgVhii/XmReCdXpMFSO7vySLNva3/Fs=;
        b=HPh2h3gO1ESpeBepDgUedNWBWkv5Tkd5aoH7hycWyeeYIs8df8Y5WXcnagY+KU3GFU
         UJV3LL46SmEOmBZ5eNGjZNjvgpihDhHA6UkhA9rDxjTUAqmJBxEl70Y+wdIS4pgILYF5
         a0yMUx5m1olgYipLaiuOcj2bY4Ljy+zWdX1kwSLxm4XubMPNGSr0cNVLoAMX9ny0c9Sc
         9wwo31Ae9qF+f5YNZCKThF9B6m+6DCdlE2o7zErToBmBI6c3rFyGCOBKzujk0KenfgHX
         V3dfHBWXhJSxIeaUfx+11nFPMmhkjD6uWw6+Q+BR6AIWsc9/y9ZYlgiPa4c4jOpSxq2j
         3e+g==
X-Forwarded-Encrypted: i=1; AJvYcCWzqUbbv6Jl5ANRK7mwODs2JNg8pfCHdnqMHH4chjvIvYahe89NNrGP+WiWUJ42prQcpaFukTED8T//@vger.kernel.org, AJvYcCXReSg8RKhCow7uQUNAEUYtuqMRrQmng/WifR3uD0DyXBgdjfW03Cw2tN1MVIH0ipzl7HLFY2/epumE12jc@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHzPsUHmM4YaDknyBgx2DHKa/CGO8vC8rIu70tWBRFuBUSG0f
	a6pW9jLaAosWGJtrShxrRzp0odpHVsZOe8RS+OaewBtEhTXguYU9KBUAMuDyzvjOkWaqEp0O6p0
	LOTpHo9evxQk67YCSd57m57Epxw==
X-Google-Smtp-Source: AGHT+IH29/+BYE5mln0xpsH/jdA9PZESe+dgMZVTcHlxigwJB+Zea9uFdnvKEpDTHJkY5FarGlJrUhlikAmay0I7goM=
X-Received: by 2002:a50:cb8b:0:b0:5c4:95d:da34 with SMTP id
 4fb4d7f45d1cf-5c413e4d368mr14908962a12.26.1726598425680; Tue, 17 Sep 2024
 11:40:25 -0700 (PDT)
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
 <fe98e49d-96d1-462f-99ac-93d8a53e55fd@kernel.org>
In-Reply-To: <fe98e49d-96d1-462f-99ac-93d8a53e55fd@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Tue, 17 Sep 2024 20:39:48 +0200
Message-ID: <CANeKEMNg_hPcVHVo2c9u1Vdzaso0ODT+2uLmip6sd26uK8d_FQ@mail.gmail.com>
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

On Tue, 17 Sept 2024 at 19:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 17/09/2024 19:24, Erez wrote:
> >>>>>>
> >>>>>> It does not look like you tested the bindings, at least after quick
> >>>>>> look. Please run `make dt_binding_check` (see
> >>>>>
> >>>>> I run "make dt_binding_check" on kernel 6.6.
> >>>>
> >>>> Yeah, we are no on kernel 6.6. You can run it also on kernel v4.1 -
> >>>> still does not matter.
> >>>>
> >>>> Don't develop on ancient code because then you ask us to review same
> >>>> broken stuff we already fixed.
> >>>
> >>> I test with Beaglebone black for testing, it is difficult to run the
> >>> last vanille version.
> >>> I did backport the spi-nor driver.
> >>> As for "make dt_binding_check" on last kernel, it need to upgrade the tools,
> >>>  and I did not think it could change that much.
> >>>
> >>
> >> Well, it is possible to build kernel on small embedded board, but that's
> >> quite cumbersone, slow and inefficient, considering that it's just
> >> easier to cross compile. But anyway, binding check does not even need
> >> cross compilation.
> >>
> >> Sorry, the code is obviously wrong, there is no such thing as u32, so
> >> you did not test it. I provided link which explains how to test it. You
> >> must do it on latest mainline kernel. Just like you must develop and
> >> generate patches on latest mainline kernel, because this is where we
> >> apply the patches. We do not apply them to v6.6.
> >
> > The patches are based on the lastest  mainline kernel.
> > I do not understand why you think otherwise.
>
> Because you wrote:
> "I run "make dt_binding_check" on kernel 6.6."
>
> The command is either part of build process or final check process
> (static analyzers etc). If you say you did this on v6.6, you got such
> response.

I know you are NOT a service.
The device tree is not the focus of my work.
It should not be broken like that.

I install dt-schema_2023.11-3_all.deb
with Debian trixie
I get:

l
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
Traceback (most recent call last):
  File "/usr/bin/dt-mk-schema", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/lib/python3/dist-packages/dtschema/mk_schema.py", line 28, in main
    schemas = dtschema.DTValidator(args.schemas).schemas
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
363, in __init__
    self.make_property_type_cache()
  File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
420, in make_property_type_cache
    self.props, self.pat_props = get_prop_types(self.schemas)
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
187, in get_prop_types
    del props[r'^[a-z][a-z0-9\-]*$']
        ~~~~~^^^^^^^^^^^^^^^^^^^^^^^
KeyError: '^[a-z][a-z0-9\\-]*$'
make[2]: *** [Documentation/devicetree/bindings/Makefile:64:
Documentation/devicetree/bindings/processed-schema.json] Error 1
make[2]: *** Deleting file
'Documentation/devicetree/bindings/processed-schema.json'
make[1]: *** [/home/builder/kernel/Makefile:1435: dt_binding_schemas] Error 2

Erez


>
> Best regards,
> Krzysztof
>

