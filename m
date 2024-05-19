Return-Path: <linux-kernel+bounces-183191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2FF8C95C1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2761F21A81
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749D5467A;
	Sun, 19 May 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZycKx30L"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F250297;
	Sun, 19 May 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716141805; cv=none; b=tpGhtKSrpAXvaGDYcSa3fsbvwZa6+5ErDh806Fx6TDSYTlJqVF7B+vomRPA4e3tZK5e6wDsvP/+/ct30FYzbkkYDuW6VpOxr22W5invUVUl9dR87gboCnWrIrGWwhCgjGPjPX4NuJoMw07sjsNQXoajnK7ZD3jY5rhtmQZf9s74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716141805; c=relaxed/simple;
	bh=O1s2Qv2YbwPox/EW+4f1PjpmmaG9nU1GvX/WuNsC83A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmUVRh6NL25O2eh9Y4pgMthhg17AqnYOFJv5XNOdKrPfNwBF6s50EZ9xBm2KqERY11Yn4Lp6iqr9UxBWdpm2BYiZJPwt+yzaVbPfBxnrloxCZcCKkM/n+SjYX9YxGIWksWT0KJfynXmXrSDuOc2HbgdV6I9RuC9rtL4xTQjAOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZycKx30L; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so6758295a12.0;
        Sun, 19 May 2024 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716141802; x=1716746602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/YRdnvMtWMhxlbEh050IDdP/xmTW8QB38Z1f1o0cz0=;
        b=ZycKx30LK2tXS8986w2DnVh1JU1I0GQE6CCq4SglmF7FP0C4YVG2kdJumZqy9j69Ka
         55Usg0UIIm3MojdCduaZKfx0/Fxfcpc+PYj220f9qNBz9FeRaCp33etAaEWYXvcS51j/
         QyXApCZFoF1QdliQ/EVCdxxtoeHOnNoBj893MdDSH52oC1hp8ixfXm0wRFQr4kcKQcsU
         ufji1L7h93XLUYmzhSntl4+iVT3A3ILyPB9nEN5gbHdyMht9mJnQdKhqGmF8nrFixmfH
         oONTO7KXk9znNczVLBC4cPypCLTur7BhjNJfLeHLnOgCL3mT2Q8jzeJBAAXLrO7g80nZ
         +xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716141802; x=1716746602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/YRdnvMtWMhxlbEh050IDdP/xmTW8QB38Z1f1o0cz0=;
        b=Ozje4jWAZ/8VkSMdLvP+SFvDADbbL+/rb0qxNv4g4iu5GWu72K9clckj8iv5GISDUn
         BKucjIVjbXHgNUlsDaMQSkqpLIPt5AGL9V23VK+RrzNAlGFwf/m3GSppoaC69g6TQQoI
         Go0yPXsAoQeNXjSclwZVVqP5C61sE7nH9z2yfkbRE9evir6kxuaLrLrCMzC2crZ3WCx3
         pzdyaB6/BF/6nNmEW7OzAPDoaOIUgdviGNKvUwsC0kf4t9RnNtnZF89MywRS/9OFRibV
         YOxZpwFmGVD+RkYo+raCrW3Llm+trklbbLlcZQDfIvbJXpxP9j7ooqCmzKiJiMIt6SBk
         3cgA==
X-Forwarded-Encrypted: i=1; AJvYcCW7G5l7s2i4Dq8lzB5HoI/+3TVuthq5n5MxhA5XixWu6YImAPDn3r3FTmt7Qtr13ptQ/9IJbszzcCBFBav7B9ksbnvam1ntwo4DTyWlFEctMP6SIc1MYuh6UJQ+bF+nWMLM+rCB+4z75A==
X-Gm-Message-State: AOJu0YzLdqANyCvDiiLTmkEAGEfT1xpmHls+D6oSNZDhNK+N3yDmk8NY
	aABfhKNHPeHExXV9PFn2eKRjzcZd0qb3vi1bjGULdica5M9WqsnNncMuwngiwl5FMNBfPRCgcmz
	XBSY/WREPe3807rj6AtBBRZUcRYc=
X-Google-Smtp-Source: AGHT+IHVtG0K3UlTS0c2FjdhwQXLY6J7tGPhlwYRSFokMmUU2X3FUGCIHNd3a7VofRVJUhFDf+h4G4S2/KpV6v1hYZo=
X-Received: by 2002:a50:d653:0:b0:572:7d75:a715 with SMTP id
 4fb4d7f45d1cf-5734d6b4120mr17882439a12.28.1716141801886; Sun, 19 May 2024
 11:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518061925.43549-1-kanakshilledar111@protonmail.com>
 <20240519-ideology-nervous-eb30a92e1e42@spud> <CAGLn_=ugjbdszvN1PQ2eN-pLFQmz-EUmhj=2kOUKWWEsbFMKNg@mail.gmail.com>
 <CAGLn_=uuTOXRGYJGe4wV6u77Ew9aBakg99TNRRcAxo4W_khuGA@mail.gmail.com>
In-Reply-To: <CAGLn_=uuTOXRGYJGe4wV6u77Ew9aBakg99TNRRcAxo4W_khuGA@mail.gmail.com>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Sun, 19 May 2024 23:33:11 +0530
Message-ID: <CAGLn_=sqQPnAN+y10j1P9y9JP8thkhOZaTtZ7R+ZktO=NxNZBQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 7:29=E2=80=AFPM Kanak Shilledar
<kanakshilledar@gmail.com> wrote:
>
> > > On Sat, May 18, 2024 at 11:49:21AM +0530, Kanak Shilledar wrote:
> > > > +allOf:
> > > > +  - $ref: /schemas/riscv/cpus.yaml#/properties/interrupt-controlle=
r
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    $ref: /schemas/riscv/cpus.yaml#/properties/interrupt-controlle=
r/properties/compatible
> > >
> > >
> > > Unfortunately, this is still not what I was asking you to do :/
> > > I said to make the copy in cpus.yaml a reference to this binding.
> >
> > Sorry for misinterpreting the comments. I will fix it right away.
> > > Cheers,
> > > Conor.
>
> I have done the changes and created two commits for the respective
> files cpus.yaml and riscv,cpu-intc.yaml.
> I am having v3 for the riscv,cpu-intc.yaml but cpus.yaml will be on
> v1. So shall I mail them separately or
> merge both the commits in a single one?
>
> Thanks and Regards,
> Kanak Shilledar

I referred to the documentation and created a patchset with a cover
letter to have both the commits separated
in different patches.
https://lore.kernel.org/linux-devicetree/20240519175906.138410-1-kanakshill=
edar111@protonmail.com/T/#t

Thanks and Regards,
Kanak Shilledar

