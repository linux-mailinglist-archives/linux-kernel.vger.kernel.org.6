Return-Path: <linux-kernel+bounces-433617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B389E5AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE492163B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD51DB346;
	Thu,  5 Dec 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwZ6JNiE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC821B59A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414720; cv=none; b=BGZd853OL/GCqXPQOjrfdFgvQ7flBcVbCq7iw2Mu6tq1Enxps6d4jo7sH7+ppajBMsJYDntxNAQ9NYJaFHGwb3D5iO601YFY54FO4X5p4HkfgqJdh3hTndxe9v1EQdTx9BNv4POFP28wQWQMfBQQDZ6eKB5b7yCnuFEr9nXY3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414720; c=relaxed/simple;
	bh=u9QX2+pIoH2Al5QZ8QZs2KAnTDcUERdiYp/V6oX7kTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKnOBQ0zaSTKjkmlvTjvxvBVSIG2gpPUcp/T8DWoVaJks26jf5S15iQADT4gxCgVahJJMCtL9u3EoP9L6HBK8XKOkezWX7+0L4nt99RH3BnH9rtrHlfCv5vPbbWJ1ONaa2HYwP1CavFnVjJ/dQ+VF4jlzDjcTYiPpYd2L4479Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwZ6JNiE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e0844ee50so1204126e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733414715; x=1734019515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ5d5sWXsxgKfva721xjRxamGcpSQF3w9qVhACzhMV4=;
        b=PwZ6JNiEr7bhOltCtbKSTVMR3jeU1Pt4FDrKIXOcLKdyHlrfvpIxJ3B+X3SGSi3xOq
         HBCcZGANnbJNsvh1w+Ssox4Z88nWo+j1TWrLooQ0DDZhvk55HnKss4ewL6c8jeD0zCwb
         RNeRAQSLdl8M/lAMekNuPx5sHZvHD1+mabFJF+2LdRLKf9Gc4Pa+pD8XTBcNDenGJF+E
         iYtopQIJr3j5glDYiROorEwh831snBe0u393guuyfm8YLsJBoutXMT3QW0MQy9Th5Yns
         GEL6SjAIBiKUKM/XRj6U56AzpGORJho336Ux7V2/LVjLnxo89P/zcwvIC+9atWAez0vV
         oCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414715; x=1734019515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ5d5sWXsxgKfva721xjRxamGcpSQF3w9qVhACzhMV4=;
        b=gPH6mU3NJ/Uqyr+CLUORMMwZTyZgIeF8BlTHV+AfoHw1A8otrW+snjAUSauiYrt64V
         JyNxJ20L1c+RZjv4UNbi7KVSDLvxQaYuIQ94pPCqzwUlf4yXzsMoysIyVxIBPNY7oyGZ
         4tpdWvk/jcXYetMuW263yx78hvEbITQn0EbyLRIIlGlal3htxof4Hoqwf7i79GSBziKF
         LmWFqXoJTAtVsYlJ3Ps2bXusja8MIoDsbOuMN8qyPQoAlzv4uATWZQ0CMk28XKfYIlHH
         d5kCXAbnJ4RnQZ3I9INrZrnwgr7wkDqzoRM4KW3eqk9t40cQuuWzR0xdk8bBRuOM8z3j
         2UdA==
X-Gm-Message-State: AOJu0YxIusENQRvRUzKzqL0BZ65ntb4mM1lN5kcskALCUlepbAF5Xxzt
	upSdyf81mbbTod2OfG/5QOUU+xvTARB3/pQPkOD1HwoEtazM0Gdi1cP9TtSir695rk9c/X68QmQ
	D/UanY7wzom7ugorbhpto2VeoueKG
X-Gm-Gg: ASbGncs/4vA2dhn6sLiTu3o3I+OCPmHuKIzRAETXTF3wyEI8S8orvNHnWE7bXpIjG3T
	AVm44voHElXL8EkhVYTT86tUO6NZ1QbwssVSV+zze5PWl5A==
X-Google-Smtp-Source: AGHT+IET8lAGPGDAaHsW2eCIqnkxYMPnlV+KmafgPn29Y9evMdfwUlu9cT0NGWtdoPSTjcOLDMelOCIeygN+miUA8DU=
X-Received: by 2002:a05:6512:3f10:b0:53d:e732:158f with SMTP id
 2adb3069b0e04-53e12a058ffmr4233815e87.33.1733414714206; Thu, 05 Dec 2024
 08:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-3-brgerst@gmail.com>
 <CAMj1kXEWJVhCrH0AzgEbBXsQYTAuwmUxR2kLJDU2vzVxx8GY-A@mail.gmail.com>
In-Reply-To: <CAMj1kXEWJVhCrH0AzgEbBXsQYTAuwmUxR2kLJDU2vzVxx8GY-A@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 5 Dec 2024 11:05:02 -0500
Message-ID: <CAMzpN2jAV3MVO7OQEKJwSdjB=q+3rRNa+kBD6=DSZ5-EAwRBFQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] x86: Raise minimum GCC version to 8.1
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:44=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Tue, 5 Nov 2024 at 16:58, Brian Gerst <brgerst@gmail.com> wrote:
> >
> > Stack protector support on 64-bit currently requires that the percpu
> > section is linked at absolute address 0 because older compilers fixed
> > the location of the canary value relative to the GS segment base.
> > GCC 8.1 introduced options to change where the canary value is located,
> > allowing it to be configured as a standard percpu variable.  This has
> > already been done for 32-bit.  Doing the same for 64-bit will enable
> > removing the code needed to suport zero-based percpu.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  scripts/min-tool-version.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index 91c91201212c..06c4e410ecab 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -19,6 +19,8 @@ binutils)
> >  gcc)
> >         if [ "$ARCH" =3D parisc64 ]; then
> >                 echo 12.0.0
> > +       elif [ "$SRCARCH" =3D x86 ]; then
> > +               echo 8.1.0
> >         else
> >                 echo 5.1.0
> >         fi
>
> There appears to be consensus that we can bump this to GCC 8.1.0 for
> all architectures:
>
> https://lore.kernel.org/all/20240925150059.3955569-32-ardb+git@google.com=
/

That may be, but since the scope of this series is for x86, I'd rather
not have to depend on signoffs from all other arch maintainers.


Brian Gerst

