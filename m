Return-Path: <linux-kernel+bounces-536541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D03FA48180
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F676424450
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3077235BF0;
	Thu, 27 Feb 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVBaQDNq"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70497270052
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665377; cv=none; b=bmrLgRgDdezX7guI8zG0Lp/olWgmk0cXi5AvwUQ0IA6qq7BjP6tvhNg4HYKRtkzOJ3OHMO+A0uLHkEuK6mUzNauKEP0VyNkO/wO3vjzazMiQT0h584T0rYd4u7zCl3FRYKlTAuwdBlSUtURsHMvElA28cU1N7fI2DPk3pX8f0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665377; c=relaxed/simple;
	bh=y9vG1iPWvDAF6zCHpOPL2jFeK1V+D/mgCVDXY8fpOwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2V5Or5whcwe3sLODZRRRCZcQWdRdz3o3S0NDxgTv/NTmfC7XO55UlzSKIMiVJFdgyDDuY6GQurYYm73BI/5oHH1TJUUbQFvwPCtRbVAQlQ/WlgSqlizMlm7RLM12STKT261jFPSRhsLwKsCaJ4lPQgNQXGMKYV8EigEtvvbS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVBaQDNq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb86beea8cso180030566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740665374; x=1741270174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcmsmIYz/UFt1MRrhtx6/mjCLzpAXjuKYfnRdAxYePk=;
        b=HVBaQDNqtVUv59TMN+x9onoFn23OAbilh1xRj9bvbYN9SBlgjnOsLq7+/N5hXxkoo4
         zwZQnOO3ipZpJjpo0KLJD/dw6BvkMCTvirAyxvZPPK9ip5sqOU9ajwG2PkKJ1PPJogj3
         O+29PZVRWad+LOvY45VZOSsmJoDAuxVrpp4b/b5r0S1pfeEd6HbaT2z85WvKbVK3XlHq
         imLF5eLUeWawszTWK/VOTd5dN7ACWh05XHGF7oZeGN5NkT4tkRlek9/3LWXBv5xM9Uex
         OxYFD98coELs9fyzGBmVlA+HYsFMa14A9+AaoyyvNLzi2KhpXDNxPvrLBzarPmdrK5bC
         99oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665374; x=1741270174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcmsmIYz/UFt1MRrhtx6/mjCLzpAXjuKYfnRdAxYePk=;
        b=FF4vkv8gdDhKiN/EJ9w5UM3ZFWME6NA8Ozd5IzV+7mg7CYv8GipSFrHVr+EdPzmlOt
         xPPL3eyN+PXsiXnxlniVM8S4VlBPuvMON1lTK1IxMRqGrALgEDVcGVbmiF7AStpmv1/N
         Qw7ZPaWhmmri6yJbXWo6RcFCevCZKyHCL7LzkgqiMGQWgSrEGvkIRbvnIBZD0ARFxdM1
         7XHpWUaOFp4Nzy2Tv4lrj4iQJ6Wx5lGdMcKP1vZiZjVu8QnJ836IxrxpylPwU17XMKiE
         UyCjTjULJWxA1bYWeDzPSUEkXGSHx6ZI/8eXl+7m0Mxd+7Hx7iNhQBygGzcxPu8Uq+hj
         Vp+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9WvqsIkNSg00XrHrDWqPNSyIFcAn6sx3zK7cwDFYTHzlURgcMS0nTzml5dEmF0pYa0GNqT3hjc8cajpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMMc9EX5KWvnCCPsXXDcFOyyHRDT2kz1l4Xsp1QgrmHnPKowa
	0y+bdi0mlEWNZ5s9Fp5tdj/5psBgnsXbi2f3B2Ow7qM+Ep1HFyl/Bguoh2oqRvlFpgcntGNLrvp
	O39Vv85I/Zu4iOVMECxOMD+gGFBc=
X-Gm-Gg: ASbGncuAsGRkFqTKp6x4JJbR50NKSQ2sUiMwMR77uqw1Mrgw0WvepUehYBF9hUjlzd/
	Lqd6bF1q+lg/Y8DdwYGtqY0EPameIWIG2BDnNi5clSpfq0+b+IE7pKa5iayjGjQq/MAnGEHeqL9
	XDVKg86AOUdQ==
X-Google-Smtp-Source: AGHT+IE907VD9IHhyD6lPe//n/YbGaTUME1RK0u3EwA/uCGPb3q9y1DGFusOkBD4Fv5rnhnJo+jEfi76/BFyRVYloUg=
X-Received: by 2002:a17:907:2cc2:b0:abc:cbf:ff1f with SMTP id
 a640c23a62f3a-abeeef42910mr1090435566b.40.1740665373408; Thu, 27 Feb 2025
 06:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226213714.4040853-1-arnd@kernel.org> <Z8A_wAbpavm3Ydab@gmail.com>
In-Reply-To: <Z8A_wAbpavm3Ydab@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Feb 2025 16:08:57 +0200
X-Gm-Features: AQ5f1Jr9iaICHLVJjScnuMMtRh3FXYUrlzUYmGgdaTjD7F4tb53LiPgw-uRO4zY
Message-ID: <CAHp75VdUU-=2vjNAjeaQ0-sNVv-Q4GBw3J-ivz9_Bqn_V=M16Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] x86: 32-bit cleanups
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:34=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
> * Arnd Bergmann <arnd@kernel.org> wrote:

> > While looking at 32-bit arm cleanups, I came across some related topics
> > on x86 and ended up making a series for those as well.
> >
> > Primarily this is about running 32-bit kernels on 64-bit hardware,
> > which usually works but should probably be discouraged more clearly by
> > only providing support for features that are used on real 32-bit hardwa=
re:
> >
> > I found only a few 2003-era high-end servers (HP DL740 and DL760 G2)
> > that were the only possible remaining uses of HIGHMEM64G and BIGSMP aft=
er
> > the removal of 32-bit NUMA machines in 2014. Similarly, there is only
> > one generation of hardware with support for VT-x.  All these features
> > can be removed without hurting users.
> >
> > In the CPU selection, building a 32-bit kernel optimized for AMD K8
> > or Intel Core2 is anachronistic, so instead only 32-bit CPU types need
> > to be offered as optimization targets. The "generic" target on 64-bit
> > turned out to be slightly broken, so I included a fix for that as well.


> Sweet! I have applied your series to tip:x86/cpu with some minor tweaks
> and a conflict resolution for pending work in x86/mm. Let's see if
> anyone complains about the removal of these obsolete features.

A bit of offtopic here since it seems I have not noticed any activity
in your header dependency clean up series are you planning to rebase
it at some point? And what is the status in general?

--=20
With Best Regards,
Andy Shevchenko

