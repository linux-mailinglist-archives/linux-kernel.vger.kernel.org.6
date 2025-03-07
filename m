Return-Path: <linux-kernel+bounces-551167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2287A568EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DC1895897
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB9219EA5;
	Fri,  7 Mar 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezg82fuS"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7A22EE5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354070; cv=none; b=Gznr9KVVZVwzNz3/Lr312Eh6E3/fid6HyXpu53tSEe1RuwYILxf8i/UFGf214olB0X1KcFi6OOxy+coEBWtf8YNe2Y2SGq66Sn+O775JRnlin94WF4IKxqCocDmMNnkKj4WvM8I0uSE8iphtSbSdj2I58mLmwGhl3QouZQn+hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354070; c=relaxed/simple;
	bh=gBBUEiTDNnZs+NjNjRaxtc2yhW49RP2DF0pimsVRQY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI0dQVqOVm7MEHPSgMqKufQEgNzDHgP/jtAVGbDLf90f7bYF3KM/BkrTMDdWNjGGFbZDAy+icyRsC2VoOlrIvebsnLVMUGtowGxyLTqymTUezSGycB4h9cM+6DPlRwX46majAVnjJDoJ40UUE3tEoFlFVHUW1tS16eCDqJDwHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezg82fuS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390e88caa4dso1023955f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741354066; x=1741958866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85pEC8KCcI89C4WR+hGbDu9vRGoE5Gebzb+PlByP0LU=;
        b=ezg82fuSDSDcvDd/k4CUhd/USr+w/+uFK7V74j8rTQAGDUe4k6KRBZ/JQe/UhLz2ud
         WqnHjrHhAz22WkT30GWp6npqbn/Yb+PAuti0ImFhfrceSxTabblhEXKAQF+9mvJtzZD0
         LuRJ9NLXe1kO86wxAxwVV5i0o0iafND5Pso40DI9GR46fPv8MtrLf9r9pGD8OfCP2KYQ
         1YfHf70JVrsQ55YmNqp0u5AlVObMTSCQhrfTU4sNFYplgxbzM1onIQQwv9/8xFi1vIwW
         WmmvEx9qTtWp+iCTIE1FEkzg9LbtdpEyUwoCT4byHXQSeXPCo2/Q9A1gpis48HaGE8kP
         ir0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354066; x=1741958866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85pEC8KCcI89C4WR+hGbDu9vRGoE5Gebzb+PlByP0LU=;
        b=kD7GS1TYILbkb+OPgU91xAfv7N2ru5ygl5AF05GkmWBhGlsc/v0Hjol902NFhcpv6R
         belbPlnkeurPbDy6Wvz0tytM/7WcwTbSr7K3MHJM6magH5Qe3Yltda0V/yJ1Rzwy0yQe
         Lrx4tG8I/s3+ztvU84RDLS6/jnALXiHiwqZoxvLDJlqO0CwzlKCQREGuVYNoRFBzouSX
         LcYVXa2inGfFXAtpqn46nogbPPWYo/hUUV9Xw9SqeTkP/6nhtEan/w0FWlef2GLiJ8FK
         LkIHPON//C5Hgp0dhL4bDXSxIpQv5d5CvvrCtX72L7w7Yf3XaAP2EQmz96R3rw/PiB4+
         iyAw==
X-Forwarded-Encrypted: i=1; AJvYcCX7KzLbJMG0uaFGlgEj/8bbFkXDOJcJ4ZuLVxgyvpnIv5COvucrNDIfnx4MxaEKeMvOL+4F+eQQT5QDuLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDAdpT8T1FNI38WHD2xCToBTvGw6e8n4VZMMyTbkaz4vqDF/j
	U7W09yp6CMnQHaXqAjAe+AwQ4LFa5D/ovsOo8Joegq6QnfpP79+K
X-Gm-Gg: ASbGncvTFtPIoLKBTeuDOVx16c+7kOsNdj/anAp77XrSStrkRFkLVeVTUqkDhZQeRSB
	qtcOHWDgxikQnqCn5JUbVcZPjJbA+dCulRkNIerAiAuJe+fS3r7F2OUUtaFc+aEMoR1C4Tga6kD
	CQwuC6oqfY1MG+xvagPaFBHmciGNYlew9XNtTzOJZqStRcsw9k9ylXnZaWc9u0REsOgFLWsNL4U
	FVse3CfzfF4ynpGmEOa298xaAxhAt3aUQj2tv9w5vpbCOGGc4IDMJO2SFowBJsCAps6N3lJRnR9
	/X7AtI5grpx+a3NdDhcRW8Xg7JenCureK+M0dw/2qtWLm++EEhlMYbOiyMn4JFqKkhqUMA6/mmD
	TNVZso+I=
X-Google-Smtp-Source: AGHT+IFrmws0QRJibrAQb0TzahsD1hhkLY5E++lh2fAWSvEQc4XtAQW0XxSrln4LJs/Uja5JO15rng==
X-Received: by 2002:a05:6000:4103:b0:391:3988:1c7c with SMTP id ffacd0b85a97d-39139881e97mr198214f8f.24.1741354066257;
        Fri, 07 Mar 2025 05:27:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352fa3sm80977135e9.30.2025.03.07.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:27:45 -0800 (PST)
Date: Fri, 7 Mar 2025 13:27:42 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@ACULAB.COM>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and
 non-asm GENMASK()
Message-ID: <20250307132742.150a3a77@pumpkin>
In-Reply-To: <bdce7d99-7f02-4667-acda-9ffc62c92af2@wanadoo.fr>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
	<20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
	<20250306192331.2701a029@pumpkin>
	<bdce7d99-7f02-4667-acda-9ffc62c92af2@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Mar 2025 18:58:08 +0900
Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

> On 07/03/2025 at 04:23, David Laight wrote:
> > On Thu, 06 Mar 2025 20:29:52 +0900
> > Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel=
.org> wrote:
> >  =20
> >> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>
> >> In an upcoming change, GENMASK() and its friends will indirectly
> >> depend on sizeof() which is not available in asm.
> >>
> >> Instead of adding further complexity to __GENMASK() to make it work
> >> for both asm and non asm, just split the definition of the two
> >> variants. =20
> > ... =20
> >> +#else /* defined(__ASSEMBLY__) */
> >> +
> >> +#define GENMASK(h, l)		__GENMASK(h, l)
> >> +#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l) =20
> >=20
> > What do those actually expand to now?
> > As I've said a few times both UL(0) and ULL(0) are just (0) for __ASSEM=
BLY__
> > so the expansions of __GENMASK() and __GENMASK_ULL() contained the
> > same numeric constants. =20
>=20
> Indeed, in asm, the UL(0) and ULL(0) expands to the same thing: 0.
>=20
> But the two macros still expand to something different on 32 bits
> architectures:
>=20
>   * __GENMASK:
>=20
>       (((~(0)) << (l)) & (~(0) >> (32 - 1 - (h))))
>=20
>   * __GENMASK_ULL:
>=20
>       (((~(0)) << (l)) & (~(0) >> (64 - 1 - (h))))
>=20
> On 64 bits architecture these are the same.

If the assembler is naive and uses the cpu shift instruction for the >>
then a lot of cpu (including all x86 since the 286) mask off the high bits.
So __GENMASK_ULL() may well generate the expected pattern - provided it
is 32bits wide.

>=20
> > This means they should be generating the same values.
> > I don't know the correct 'sizeof (int_type)' for the shift right of ~0.
> > My suspicion is that a 32bit assembler used 32bit signed integers and a
> > 64bit one 64bit signed integers (but a 32bit asm on a 64bit host might
> > be 64bit).
> > So the asm versions need to avoid the right shift and only do left shif=
ts.
> >=20
> > Which probably means they need to be enirely separate from the C versio=
ns.
> > And then the C ones can have all the ULL() removed. =20
>=20
> In this v5, I already have the ULL() removed from the non-uapi C
> version. And we are left with two distinct variants:
>=20
>   - the uapi C & asm
>   - the non-uapi C (including fix width)
>=20
> For the uapi ones, I do not think we can modify it without a risk of
> breaking some random userland. At least, this is not a risk I=C2=A0will t=
ake.
> And if we have to keep the __GENMASK() and __GENMASK_ULL(), then I would
> rather just reuse these for the asm variant instead of splitting further
> more and finding ourselves with three variants:
>=20
>   - the uapi C
>   - the asm
>   - the non-uapi C (including fix width)
>=20
> If __GENMASK() and __GENMASK_ULL() were not in the uapi, I would have
> agreed with you.
>=20
> If you believe that the risk of modifying the uapi GENMASK*() is low
> enough, then you can submit a patch. But I will definitely not touch
> these myself.

I don't think you'll break userspace by stopping the uapi .h working
for asm files (with __ASSEMBLER__ defined).

But someone else might have a different opinion.

>=20
>=20
> Yours sincerely,
> Vincent Mailhol
>=20


