Return-Path: <linux-kernel+bounces-413387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE009D186D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215521F22BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E31E1028;
	Mon, 18 Nov 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="Eb2fSfgv"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650B1DFD90
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955818; cv=none; b=j7v4JW6FyU26tKO+IoA1LjqjR5pC3ii/9DK41VBohs1Ppp9PM2H1LdYB0ZmPhnOZTBOIYQNnLfKZNniXarSo6LaXQK/XkTLljhjVTb+MMVq7cZhx7hP6OGqBoNvK3I2i8q8NYuLzbf/BOKN4at3/b3H6v3eQH06eJRc14MyV43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955818; c=relaxed/simple;
	bh=2QY3a2Uk/8gqH7WQfMRHioz5YMXfb3X7onn+tTaevAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nozy0/XgLMIMKc+IriuTqCP0uJwxlpRQYVElsKTcNiOulByxWt8GTdrr5KDPea0U70F5zGCyG95mqfsvnEYU0QcNpjFwun4lhAG+gj940UhQ1bNFh3tJ+q/Ir0mJ7iQFvUHfsi1Rx4XsNBooihXtdqABPMFv9LAf2/HSyzC5KwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=Eb2fSfgv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ed49edd41so21733366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1731955815; x=1732560615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPj/zJyl+iBTZNeNPnPjulGAj1EfNYv6wlquTzB4Fos=;
        b=Eb2fSfgvrrWxhoYxqNqjm9KY3WAwugm6DZI8qiEtxNm/3XrrTWsZ6eq6gVYv1jLw4h
         6KuFpIjE/ki+t0lwIgMFenP+mfpveNPxgHfDkacsco/cKbzeId6x3ho6OXRWSxTm5poe
         am4ILHt29t+s9PwzmIIHuSDsJlWge1a6BX0fdarITcFEBoba3LrPDF9caH0d5RNgJwEN
         a/CVp/AgqpfOrgDg4Lvs0MdI+27BEz4lZ2BsDAfAGPJlCMq6BZwHkpAnXJlzFRqJ9XHo
         LwocnWSr68HaeF0vLxbgYp5uHwF0S6OL/2MDZxIHeEC4fK+5hh59RtcU+iPaw9ham/Kc
         Ee5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731955815; x=1732560615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPj/zJyl+iBTZNeNPnPjulGAj1EfNYv6wlquTzB4Fos=;
        b=ATpy7kn1muD9z2Let/5jyoz80Y1olZXPAa5OLDFhRH5IFR/mPPrBHYwruX/xGBy4Ty
         O+dq1zOzWfExnQpYyX08gI3/MaZUNwPDW2T1j1JM1PjiSsYrO1nlOTE4o/oeRCr0AQ75
         W4GQ0LkhSuaY+tHu1yNTS/RgUkzjxIuBrUW20auT3ogcbeoDq8CpBJ2Fo8AmeClIE/UD
         MS/heEDSlGthzd6ZbH+TlnK5WpZq0WpkbzmfRvd7mNdVpQt+7Wzq7CsUeelh8LFCoo3y
         FvbfUNDRr+vxkzdjDdSiXs2xzxWN10JXWUw3UbRV9j/Fhyno17dmO14iOruI3FjHYfYw
         EpKw==
X-Forwarded-Encrypted: i=1; AJvYcCWLDkgqX4k0bSC3L+thoirTf1Tw6iX2IqDj9VJotjvQAKdisinzaLktURp9IIzuFzbAD2/7C0NHW3N0Bx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdfyD6yymOvHo/7NXvaXtSyhuzPXRSeQ4jV/hb7KCWp8LKr6m
	g4l+70G4Gc6upy+N6Ase1S1MHHw2qNc0cvBeYYzeHC8bclGRtXUOgPZnzoeJFtHZok2yJzirpvW
	Y164/44kx4RlYUvX45JEtW/ptGUFvrycE5o1C
X-Google-Smtp-Source: AGHT+IFfJmdKn/zNImT7l4QO7Fi2ir7TwUttjVFKSek/OFfDMGfS7Gvt2c45q8Ed4/UdpiH0ZuP7Sx4z+gzbVPQA1XA=
X-Received: by 2002:a17:907:7b8c:b0:a9e:d4a9:2c28 with SMTP id
 a640c23a62f3a-aa483552c2bmr1213767666b.53.1731955814987; Mon, 18 Nov 2024
 10:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com> <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
In-Reply-To: <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 18 Nov 2024 10:50:04 -0800
Message-ID: <CALCETrWrdK9-g2VK1h8E34kRNHbfdX0zjUqwZ+xpNqkEmrdLsw@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Eric Biggers <ebiggers@kernel.org>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net, 
	corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 10:43=E2=80=AFAM Andy Lutomirski <luto@amacapital.n=
et> wrote:
>

> Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
> exclusively use TPM2_PCR_Event.  I would expect that passing, say, the
> entire kernel image to TPM2_PCR_Event would be a big mistake, so
> instead Linux should hash the relevant data with a reasonable
> suggestion of hashes (which includes, mandatorily, SHA-384 and *does
> not* include SHA-1, and may or may not be configurable at build time
> to include things like SM3), concatenate them, and pass that to
> TPM2_PCR_Event.  And Linux should make the value that it passed to
> TPM2_PCR_Event readily accessible to software using it, and should
> also include some straightforward tooling to calculate it from a given
> input so that software that wants to figure out what value to expect
> in a PCR can easily do so.

Whoops, putting on my "knows a bit about crypto" hat for a second,
this is not great, as the algorithms aren't distinguished, and one
could hypothetically add a wildly insecure hash to the list that
breaks it.  Instead it should be something like:

"SHA-384 48 bytes: [the SHA-384 data], someotherhash 71 bytes: [other
data], ..."

It might even be polite to include some human readable text that also
indicates what got hashed, e.g. "initramfs", so that anyone reading
the event log can see what got hashed.  On that note, maybe making the
whole thing human readable and using base64 would be nice:

"initramfs\nsha384 [base64 data]\nblake3 [base64 data]\nsm3 [base64 data]"

Whatever format is used should be unambiguously parseable.  And who
knows, maybe there's already some kind of industry standard for how
TPM-using software is expected to behave here.


>
> And then software that wants to use a SHA-1 bank will work every bit
> as well as it would if Linux actually implemented it, but Linux can
> happily not implement it, and even users of oddball algorithms that
> Linux has never heard of will get secure behavior.
>
> (Why SHA-384?  Because it's mandatory in the TPM Client profile, and
> anyone who's happy with SHA-256 should also be willing to accept
> SHA-384.)
>
> >
> > Even with these clarifications, the conclusion does not change. If the
> > firmware enables SHA1, there is nothing that can be done to disable or
> > block its usage from the user. Linux Secure Launch sending measurements
> > to all the banks that the hardware used to start the DRTM chain does no=
t
> > create a vulnerability in and of itself. The user is free to leverage
> > the SHA1 bank in any of the TPM's Integrity Collection suite of
> > operations, regardless of what Secure Launch sends for the SHA1 hash.
> > Whereas, neutering the solution of SHA1 breaks the ability for it to
> > support any hardware that has a TPM1.2, of which there are still many i=
n
> > use.
> >
> > V/r,
> > Daniel P. Smith
> >
> >
>
>
> --
> Andy Lutomirski
> AMA Capital Management, LLC



--
Andy Lutomirski
AMA Capital Management, LLC

