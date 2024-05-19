Return-Path: <linux-kernel+bounces-183115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BC8C94DD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE4C1F2126A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962D487A9;
	Sun, 19 May 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+sRleG2"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5A374F6;
	Sun, 19 May 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716127198; cv=none; b=s2gE+olKuag7di1H98VOgqaAQR7g0XKh0qAnFX6NZWmRv0RmgrJ/2wG6QOph1d0uBi0HwNal0HQ8v5H1we+vHu6nNA0GE7/HJzEqm9R0xb8LwuWQvjRQUGBMTECc4Ap10wwXe1Y+g+LDp0QnpY5B3PUG6YKbKDGmvfxKEPQ12Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716127198; c=relaxed/simple;
	bh=7DTeiiURBxztZOz15EO00MnA/drHsel5+qO316YqUSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjgTnnuaTmWdrVopCHa+LZDDAdkSWmvvNm6D2nJfNEbBGRczM+S1gbZOlrjx3Aoo/FElqyvW+v7sUGr/tgPj1m/0aiIiu75wJqeaqr8FQcHeVd0bI6gR3ydmc3dVZ24fkfuEDoSDosLlbG9yWeF69zk5B373qsUwwjzuTAp+OoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+sRleG2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so7080278a12.3;
        Sun, 19 May 2024 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716127195; x=1716731995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZcAosKVRRNn3zbNdga7WpFXthPaMuTi09+NpFi9cn4=;
        b=Y+sRleG2z590MtNr2M6L53LeuQEE4PI7Dtil20GPuNYvW5EPJb+YDJ/6WNoBoUNM/9
         oLMAV0PNfNSGxKdAOxOlmEQ6er3ESDgwRX8fFlVxtfy1sLoGI312piD1T5vhp0JJ+eFS
         8FBsO5EVcAxU2ZaLMQxLA4Au3X1ld/xf3XPduugxK9Puc1Gf30W+QNMmTulzEq3N2NEV
         e1OMxcZ4JAuRlYfhL2dZ3KFF6x2pUFmfyu3zemopMO33RtfygEa0qffoNQ+eb2gQP+cS
         CnwBHwzv+elXRcwCq+y3/kdroyUJbqIBIikZaSRkGhn0w6aOdAWIJqYZMHQBMWkSItki
         aotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716127195; x=1716731995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZcAosKVRRNn3zbNdga7WpFXthPaMuTi09+NpFi9cn4=;
        b=S1dNp23ewRFhL9z1d9LAw7KKV9LS294GmnGC/txiVGSObJ8tmDY08DyyCWLdF3bDd2
         la8FgA2rhVTLMBhvu4lrKwaltgNtaDyqiU8kMcqVRgGQ8dXKaA69QrRTYdgxFoWdZ9Eg
         hZjFr4c0tv23YrdzunI2bVzlh29yUGtsc8FIbhDQzW3gWRnBJz1V+29om8+Mtc1mmQBO
         btCt8g/wIdNGib8ZtbmlOeE9Nc9FTAIy6ofT4gQTYKwADk112JfF8uwvsmA6/KZwodJA
         9lSNtyyGLP8pKi3w2v4S/I7JaEwigp7qiAmtkMJLRuDVj5zrjWCvy03SLEWSQlb2DqLX
         U22w==
X-Forwarded-Encrypted: i=1; AJvYcCXNsDE+1tewWKEcjG6yhGaGUihytCzMOgpvxbCWteOVjhabI1VoTuxFnKFku13SBWrvrzqAktZ3/5jnmGGYEgT+1lUuR4s8+5wUtYv9S5K2mv2wKpQjK7xWB/tAGP0HI39OtIr7oGrzeA==
X-Gm-Message-State: AOJu0YwDdrpEImhV/Pqo+gL1grL3FdrRWLQAHAxwdgYsGn+0Q5TT7J8B
	JZ9jxLbIS/0ixxCXC7q2RfRh1I7SW9GhE19hsJEbKs8eW7CSPM7M41bqawDUyux2tKbJVAh0WTP
	C+XJ1l347ornFpW49RFS0HVkeoZw=
X-Google-Smtp-Source: AGHT+IH6xNDTbIhtdz7Y3rIQnrvN4RVVfAL2ZOJM/V7vjiY8AVeMhq3fp/vw7cqOpjmMsLzsCi0dGK2mS4SaJR/2EAY=
X-Received: by 2002:a50:ab0c:0:b0:572:459f:c7ab with SMTP id
 4fb4d7f45d1cf-5734d6f004bmr26176500a12.28.1716127195350; Sun, 19 May 2024
 06:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518061925.43549-1-kanakshilledar111@protonmail.com>
 <20240519-ideology-nervous-eb30a92e1e42@spud> <CAGLn_=ugjbdszvN1PQ2eN-pLFQmz-EUmhj=2kOUKWWEsbFMKNg@mail.gmail.com>
In-Reply-To: <CAGLn_=ugjbdszvN1PQ2eN-pLFQmz-EUmhj=2kOUKWWEsbFMKNg@mail.gmail.com>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Sun, 19 May 2024 19:29:44 +0530
Message-ID: <CAGLn_=uuTOXRGYJGe4wV6u77Ew9aBakg99TNRRcAxo4W_khuGA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: riscv,cpu-intc:
 convert to dtschema
To: Conor Dooley <conor@kernel.org>
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> > On Sat, May 18, 2024 at 11:49:21AM +0530, Kanak Shilledar wrote:
> > > +allOf:
> > > +  - $ref: /schemas/riscv/cpus.yaml#/properties/interrupt-controller
> > > +
> > > +properties:
> > > +  compatible:
> > > +    $ref: /schemas/riscv/cpus.yaml#/properties/interrupt-controller/properties/compatible
> >
> >
> > Unfortunately, this is still not what I was asking you to do :/
> > I said to make the copy in cpus.yaml a reference to this binding.
>
> Sorry for misinterpreting the comments. I will fix it right away.
> > Cheers,
> > Conor.

I have done the changes and created two commits for the respective
files cpus.yaml and riscv,cpu-intc.yaml.
I am having v3 for the riscv,cpu-intc.yaml but cpus.yaml will be on
v1. So shall I mail them separately or
merge both the commits in a single one?

Thanks and Regards,
Kanak Shilledar

