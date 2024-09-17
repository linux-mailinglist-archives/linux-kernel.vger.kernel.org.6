Return-Path: <linux-kernel+bounces-332084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFA797B53B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E199B26DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9FC192B6E;
	Tue, 17 Sep 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bknTGe2H"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C68446A1;
	Tue, 17 Sep 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608602; cv=none; b=uYMDW/9VtpZBHpajdb2n3/1JWzQ/14fLpDidV2MI4Q65m87wwtaW5vV/UuO9p4fIbmVM51AmQIMDAMLfMcaVilSQDVRfnWR2qLNPl5bIe9qpANlYL0VW+vSCvJbSPZ0G24Ccl08QGyvDwkyQqaonwaiHXZay6vv63PbgTp5vMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608602; c=relaxed/simple;
	bh=J3ZfIbWvV/pUT2sQiBwsH1xpKOvs6n7Ihgb2nMGi+cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tp/mek977Oi4xoXpZrZiEJISZ8FiNZc7gLnKLBfw6Tjq3JqNZnumL7T81oYKgKV/X0fwtREkP8JMmM60LTbJghjqTZ7Zen83nPrPohMukH9dOiRAVyyO2udwOuG8BJw339czj30jgQxt5dc+NMd8exZXEIruhKYbKn8xOJYBgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bknTGe2H; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c4226a5af8so6191849a12.1;
        Tue, 17 Sep 2024 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726608599; x=1727213399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/5yS1EFc2UkCNqUe9XkDS8zSd6iM9CaMBvaXI1VqENI=;
        b=bknTGe2HEpPKSfi0FDLIzYUr3FAbp6Owg5nDdtrVd9W3vhSjt/De9pIhm6Z8XxLakq
         stz5JtZoGDc/eJwV79vn6Y/OApxOz03JSjQB9CTWYZcPqE3xyCUALL5wuVS67viPbjSm
         JQMkEJGXwUtA9d8c4XQJ+HWyJZ3qrg3wUAQEIkeVEuftUTaVBfFq2jEBrtMxqOXpdwzZ
         RfESA7vXGnguA+yh9Ld+kwdPxH8c/C/+Jh8Svzo3iachjTty4Us1Jbb/mjqSkPGaaBvc
         38wOo9nIjWuNDb0IAVMqIBLzWn8lMirMVLxrJoS+J6RJXfL6eqBeCWi6hbnEoti1peRO
         ETog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608599; x=1727213399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5yS1EFc2UkCNqUe9XkDS8zSd6iM9CaMBvaXI1VqENI=;
        b=tYIz7X/e1Fx9BkXqtEum1GMKzS/e2NrPj8CPb3yGkt5VuM/Q1/JLBDVPF2WnAXZZNR
         34tnIrUVb9DhKKglgnJJe3lVwKe9Y6APhreDqwJ/v51G1xR6fOOri3FUo8Ks2vm0gsLk
         ebz1Bd/SpwQY0haGjfQ/a2X1PuSfNyM5jcJnVWb+hbCYB9Cy9BCVP1MF9YU5bqMwK7pX
         jnVsz3Ud2eDfD2OZD40pIDsCpsqUsligbquHQX4daDlEd2IW5nu2MXO7SS9nSCwnCMdn
         H2fEToWUQFcgl3PzyImYRkMOF4fnmJwr3X/l36Dz8o3NPC7txu2DmI6Fh5HqrJsLJvj/
         8s1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZJBO4fiPEKIfx7uEySDhmI2PVLEowl9xXPXbb4xRJuXocOKFbwbchujWyUoxs8p0O+BJp5SGv39N6@vger.kernel.org, AJvYcCXvMYPM5+Icve8LrsFAC5ED1oh6iMAFQwjeQAIjlKTGkgvRjeRdBdI5pBq4NmigCVFZEiW9i4DQqTWzX1wn@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxT7tWXzF6/iwB+YRhqsFTQwzSkJUtY9hdbu3hU4d8ZYfOCE2
	XX1SLocIeQq7BLh/k6632KKDvcJHfDCy3vSPxHx9NcAiXIFFzsdG2if3ri5H0nRdquqC+n3az2N
	D3svdGilZaxeOFwPb0h45vHyQxQ==
X-Google-Smtp-Source: AGHT+IHZDSOWH5g2mse3vvoQufmbyrZHOiOqYeHvdcDTmjg09A/dKV48ek5QF2G9EkhG6CVgJbewgqf3PB397EjBApg=
X-Received: by 2002:aa7:c882:0:b0:5c4:b33:1f with SMTP id 4fb4d7f45d1cf-5c413e4d733mr16483402a12.28.1726608598858;
 Tue, 17 Sep 2024 14:29:58 -0700 (PDT)
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
 <20240917-taps-applied-6c0d411bbe08@squawk>
In-Reply-To: <20240917-taps-applied-6c0d411bbe08@squawk>
From: Erez <erezgeva2@gmail.com>
Date: Tue, 17 Sep 2024 23:29:22 +0200
Message-ID: <CANeKEMOXZjgLm-Wb8+9RMJYNN1a2Oy81P3MXZiLxNaAerLhYEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 22:39, Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Sep 17, 2024 at 08:39:48PM +0200, Erez wrote:
> > On Tue, 17 Sept 2024 at 19:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On 17/09/2024 19:24, Erez wrote:
> > > >>>>>>
> > > >>>>>> It does not look like you tested the bindings, at least after quick
> > > >>>>>> look. Please run `make dt_binding_check` (see
> > > >>>>>
> > > >>>>> I run "make dt_binding_check" on kernel 6.6.
> > > >>>>
> > > >>>> Yeah, we are no on kernel 6.6. You can run it also on kernel v4.1 -
> > > >>>> still does not matter.
> > > >>>>
> > > >>>> Don't develop on ancient code because then you ask us to review same
> > > >>>> broken stuff we already fixed.
> > > >>>
> > > >>> I test with Beaglebone black for testing, it is difficult to run the
> > > >>> last vanille version.
> > > >>> I did backport the spi-nor driver.
> > > >>> As for "make dt_binding_check" on last kernel, it need to upgrade the tools,
> > > >>>  and I did not think it could change that much.
> > > >>>
> > > >>
> > > >> Well, it is possible to build kernel on small embedded board, but that's
> > > >> quite cumbersone, slow and inefficient, considering that it's just
> > > >> easier to cross compile. But anyway, binding check does not even need
> > > >> cross compilation.
> > > >>
> > > >> Sorry, the code is obviously wrong, there is no such thing as u32, so
> > > >> you did not test it. I provided link which explains how to test it. You
> > > >> must do it on latest mainline kernel. Just like you must develop and
> > > >> generate patches on latest mainline kernel, because this is where we
> > > >> apply the patches. We do not apply them to v6.6.
> > > >
> > > > The patches are based on the lastest  mainline kernel.
> > > > I do not understand why you think otherwise.
> > >
> > > Because you wrote:
> > > "I run "make dt_binding_check" on kernel 6.6."
> > >
> > > The command is either part of build process or final check process
> > > (static analyzers etc). If you say you did this on v6.6, you got such
> > > response.
> >
> > I know you are NOT a service.
> > The device tree is not the focus of my work.
> > It should not be broken like that.
> >
> > I install dt-schema_2023.11-3_all.deb
> > with Debian trixie
> > I get:
> >
> > l
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > Traceback (most recent call last):
> >   File "/usr/bin/dt-mk-schema", line 8, in <module>
> >     sys.exit(main())
> >              ^^^^^^
> >   File "/usr/lib/python3/dist-packages/dtschema/mk_schema.py", line 28, in main
> >     schemas = dtschema.DTValidator(args.schemas).schemas
> >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> > 363, in __init__
> >     self.make_property_type_cache()
> >   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> > 420, in make_property_type_cache
> >     self.props, self.pat_props = get_prop_types(self.schemas)
> >                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/lib/python3/dist-packages/dtschema/validator.py", line
> > 187, in get_prop_types
> >     del props[r'^[a-z][a-z0-9\-]*$']
> >         ~~~~~^^^^^^^^^^^^^^^^^^^^^^^
> > KeyError: '^[a-z][a-z0-9\\-]*$'
> > make[2]: *** [Documentation/devicetree/bindings/Makefile:64:
> > Documentation/devicetree/bindings/processed-schema.json] Error 1
> > make[2]: *** Deleting file
> > 'Documentation/devicetree/bindings/processed-schema.json'
> > make[1]: *** [/home/builder/kernel/Makefile:1435: dt_binding_schemas] Error 2
>
> Have you considered that this might be because of the invalid types you
> used?

I remove the types.
Anyway, scripts should report on errors, not crash.
This is the purpose of syntax scripts, to help us, developers find out errors.


Erez :-)

