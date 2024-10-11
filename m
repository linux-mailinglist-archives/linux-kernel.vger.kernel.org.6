Return-Path: <linux-kernel+bounces-361900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190ED99AEA3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EFE1C2180B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E261D279D;
	Fri, 11 Oct 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfYElzHk"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6B1A070E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685665; cv=none; b=keBvhZBujM+22pecX7ndM3vkMCHjsHrAnHuHmprsNXpgiF7FILX4ZRkLRAxL6PB1VxFmgO8UeAUElzTkTyB8naF7kWDKLqR14MbCLax54hA/5J63Wvv/lXRzpG/kUr7Cixy3/LInf+SNUY2A0MlacRljeB+W34saMeT3nssXHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685665; c=relaxed/simple;
	bh=XpfQ/8ANSakz+1OrHfeuAfLdOL6Di6vnxD3AKYtRJCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoAEWg6CUMkZQA/d8i/h6gGnYIiw4hvmjeAoz9DUCdSertBWOzHptbjdqCYyXSvWv9O3ZgqMr3294DDo57/IOEPWfi2S9JQvFtut8xdPbSlicLDiqIQqUsAtCPW1YQpWAz00/4VwyABlqdhfZCcNPLoSlCSwU6Q+kubbYpuLc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfYElzHk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e617ef81so2771e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728685662; x=1729290462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+gUxSDkWsGEMXOFebQ5Xw/lGRc6XJ08PqAablVeqL4=;
        b=vfYElzHkb52isYENpIwqjNg6h0yBI/F9gbmORY79m+cZT8aGM+HnCBNj+6YNOdl89k
         XBah9H6MVef0dPSzCRDAYBfIEY//xODyXAqa52LinGavrcX7g7P9aTZNUyuCOHhDu7Y/
         mY9G7+Om1y9QE/YfcfElQv1tz3r3Ldr3unUEnaZ8nXi4feq1ojonPIRgAmbHGJbj46k9
         Jkv+64hHd0Y/i/WRYZTgeCJJ8/mF3LKJnTIlqEaM4T/ihG1Gj9NIRz3ri1g0bnuz5IfI
         Lv31/ecBbMIOe0zgiaFhPQ4HP92VbCXwrMKi2CLX/S80Tl4PKQI4THPDysHz2QcmcLku
         YBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728685662; x=1729290462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+gUxSDkWsGEMXOFebQ5Xw/lGRc6XJ08PqAablVeqL4=;
        b=N0cBc0sVcPvpBd/TsyF9+dYAkFUCROX7OGlFpUibAdaaGIZ6EYSYbuCoQZgcnCbbly
         JsIhs/hWF3c+oL4ZWW91lFhpaHaw2IOywxYdytigos3dOyNoBjJbw6kZv4PHIMEZXZdR
         CdMu8Ha1t1ivvPDDTxzpwy8VDZQuoslPbZMTCO7DGqMIZ363iyu/9BzsS23NaC/+j9YO
         8Dq/5fxnCcHjuX/zoawvCXAWERfPvBkFt6wiOc3wNThfqVFJXcVGX1Z+Nc2/HaeE43C/
         BCIS+QfMrQI71HWVOmN915/dJS4xRlkJHjdBloG7JbMHaKkhHPWR0J/oq9EmmJ7AU0nn
         fPUw==
X-Forwarded-Encrypted: i=1; AJvYcCWSK2tSyf3o7FucN4WBPTT0wBpelWuLXoBDsvrfiyvq+yeRpynSF97MNb6sjQnONzGj9Iv30XBPTCvLaPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTqH4uoY9SjMgbkdFUHrZZJ6j7K4+/kbLqIdOYP6Pg/kM4tWy
	qPSZ6Ihpzmhs5kLooJQQ1tl8Ofjg9bzuUu3eiSReQPInzhe3k8ovkenvlJWNpWzYLWfrnf/55/N
	jt05ITLaUt1KjlboW8B1u4t+bBhCRtfuRp1xO
X-Google-Smtp-Source: AGHT+IGXZUm50H+t70ubPlGJraz2/HksPndIYC+fI6Hrd+oxzT344/Iv2iwsY7fhvWCT2jXrm4nAx6oX34CJ6qkR/Wc=
X-Received: by 2002:a05:6512:3d05:b0:535:68b2:9589 with SMTP id
 2adb3069b0e04-539e5f0b82cmr146927e87.2.1728685661778; Fri, 11 Oct 2024
 15:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com> <20240925233854.90072-15-mmaurer@google.com>
 <ZwmlEYdS0aPVF32k@bombadil.infradead.org>
In-Reply-To: <ZwmlEYdS0aPVF32k@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Fri, 11 Oct 2024 15:27:30 -0700
Message-ID: <CAGSQo01o4fWYwSzZHX5dyTUKcaCSZ7z-hPQ8w63tgBPGbM_UCA@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] modules: Support extended MODVERSIONS info
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, Michael Ellerman <mpe@ellerman.id.au>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	linux-modules@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 3:22=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Wed, Sep 25, 2024 at 11:38:29PM +0000, Matthew Maurer wrote:
> > Adds a new format for MODVERSIONS which stores each field in a separate
> > ELF section. This initially adds support for variable length names, but
> > could later be used to add additional fields to MODVERSIONS in a
> > backwards compatible way if needed. Any new fields will be ignored by
> > old user tooling, unlike the current format where user tooling cannot
> > tolerate adjustments to the format (for example making the name field
> > longer).
> >
> > Since PPC munges its version records to strip leading dots, we reproduc=
e
> > the munging for the new format. Other architectures do not appear to
> > have architecture-specific usage of this information.
> >
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
>
> I'm all for the ELF validation work so far, all that was nice, thanks
> for all that tidying up. This however is not considering when we really
> need all this at all, and not making it specific to the build times when
> such things are needed. That is, yes I'd like to see the need for this
> clearly explicitly defined through Kconfig, a *select FOO_FEATURE* for
> when this is needed. No need to extend a module with bloat if we don't
> need it, likewise if a kernel was built without needing those things,
> why bloat the modules with the extra information?

To make sure I understand what you're asking for, are you suggesting:
1. A config flag for supporting parsing the extended format
2. A config flag for supporting parsing the existing format
3. A config flag for putting the extended format into produced modules
4. A config flag for putting the existing format into produced modules
or some combination of the above?

I'm currently reading this as #3, but figured I'd ask to be certain.

>
>   Luis

