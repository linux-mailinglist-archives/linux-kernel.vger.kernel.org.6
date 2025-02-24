Return-Path: <linux-kernel+bounces-529165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2248A42097
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6513AE315
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F7123BD03;
	Mon, 24 Feb 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCZtX7yG"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E011B041E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403548; cv=none; b=J+AA4QfmxAHTCT6oevzX1pDQQ0cOLO6DWJhFrQp/vsGJICMs6L0d1imMHDTvEytVZiQnTjsvyQXfmAjzGTJlPP1rophsONDiJ6k7gDAVxp8ECyv5zHtKRwRndal9vbhHjhgBruaeNKli4KOOvbO0sWGpMzcXm8ut65IY0DAW1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403548; c=relaxed/simple;
	bh=9BCfC+8ynSYJhn7A3qCQzNz22cMKqfpqmKxlWSQqtqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH+63J50szF5YbMY3d8HEh9UDEP/bAE2rmyesUnJDoKGWVPEUT2tnj6l4vIMODv1YIR9u7lus6FpspXHSO5o+Gl7o7WYsMPW6/wyBVXDZnZdUDIEImfbk14ApzVTovO56stsp2IBrG43i6L3DvNSW5iYyEwmV+rhJaz2ifYjtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCZtX7yG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a04so46837751fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403545; x=1741008345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LguforzV1cctzoXKfI3/XfT9PogudIuxpoZjne3ovFs=;
        b=wCZtX7yGxu8EPgo9rSISG+itQx4vctdaU8L6kgIjXxpwhRGtvaL0dTSYUMAC2VEF4f
         eqwGnlBBa8QFWtLNM8k0q5fp6hOWOLp56XkCi5xc2t4mAy/Osl6667aBXO2tbQYK+wtl
         FI1g98J6DnbsMRX79rnwag8HqrsHin7FSvQy4wrUB8prLANyexmVcEuJN9Z438Kv5gui
         bTk5KNsDzMmKQX+VJJEFLDDrJbKXDtXNhkRoGnPqE3ZeLwGj57Z6rMrgvgPZY8QSTNqH
         0hClzuw2EIpSDf68kzWreyTyP0TfN3gIm7ntwrtJbUqUbh3c401SKGYt3ZI8rV3cDM0s
         sm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403545; x=1741008345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LguforzV1cctzoXKfI3/XfT9PogudIuxpoZjne3ovFs=;
        b=TiMsVA+F6mlmp3nXANiGKJzmkwCLkzd3sHoeYNziWpJv9n0q1B2FsvTI2tVws1uaEB
         udylkk8jMvoMxsGWvrO752lGPAeVkvhESGTgpLg+/GBDkhD/Kny/YTOhWStU0T80Dm8M
         sehL0fc2YcdaSpahw7R8ArmGtcYq93rgZ3wrbnPjQh7HIj8/XI0VmpknkWrjDbyJdJpj
         izsh7vrZltrbbc/RoIfmjhfZqrDF43IN1QYGCKctNdBg8JqpNeygpYOE2B/f0vJm4YCX
         93HKPym1DNW2WqLjtggGoajfhDcYBTkPYNSpe4+0GeEuXRibrC9T1jW5cayuTwVS4CBg
         +O0A==
X-Forwarded-Encrypted: i=1; AJvYcCWdpe61R3DWwBxvhcduqGy6dE1PgqzrDPNW7TH3LJCT0+UgcWSRi9apmN6yoXK655Et2sD5yn8a8d3qekY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZTLVVHdlfE1zXYeFyaEDZU/7+g/OWjss1asfesJisa8X2orj
	NAb8qLk51nZNWqNyLXRAjg0WKb7lwCLGp5oa95DkNDThIb9Ky51D1+RF/+mmOD3Kwj6QmNN+zxa
	B8LqcZXAurzXrQnG6BcwHj1GrX35JeteABDos
X-Gm-Gg: ASbGncsL2x2xLuJ2wJLWaiXSfj56tehQalfWYKG8sY9UJSv9ulETpdEbcoHRXxoRwqV
	7ShCWc7lMa/RB+Oq1oAuzxcNlpx3ulv7yRvvktkZ2wC9Gr6fhrXJDfiUnGrHfqgD00bvtSduZJ3
	FRavQEs6Bc9GeK4yKfHPP/s0vIhOvitbK2xmeA
X-Google-Smtp-Source: AGHT+IEvJJz3AXeS2if/gS5fNHN0PriuMRn6lq1wE2xe476HpL6/1oGBJ7JvTfopbuR2zXhulUqv2kuhqvuMIdKXwDQ=
X-Received: by 2002:a2e:9495:0:b0:308:fec4:5a5f with SMTP id
 38308e7fff4ca-30a5b168746mr37300101fa.4.1740403544856; Mon, 24 Feb 2025
 05:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
 <32af68b8-4280-4c15-8e5c-be807c282f94@intel.com>
In-Reply-To: <32af68b8-4280-4c15-8e5c-be807c282f94@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 24 Feb 2025 14:25:32 +0100
X-Gm-Features: AWEUYZmcriZEjN8lf7KQ--7ThyHoKK5NDz-O2U1ohiwKRqN2OU82L55DeVk0viE
Message-ID: <CACT4Y+YmWrEW9m5zxKoD-Hu0TXKWPVAr0_Xe_X9WGtZWH5W1_g@mail.gmail.com>
Subject: Re: [PATCH 1/4] pkeys: add API to switch to permissive pkey register
To: Dave Hansen <dave.hansen@intel.com>
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 18:01, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/17/25 03:07, Dmitry Vyukov wrote:
> ...
> >  /*
> >   * If more than 16 keys are ever supported, a thorough audit
> >   * will be necessary to ensure that the types that store key
> > @@ -123,4 +125,16 @@ static inline int vma_pkey(struct vm_area_struct *vma)
> >       return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
> >  }
> >
> > +typedef u32 pkey_reg_t;
> > +
> > +static inline pkey_reg_t switch_to_permissive_pkey_reg(void)
> > +{
> > +     return write_pkru(0);
> > +}
>
> Just a naming nit: the "switch_to" and "reg" parts of this don't quite
> parse for me. This is writing a _value_ to a register. Maybe:
>
>         write_permissive_pkey_val()
> or
>         set_permissive_pkey_val()
>
> would be a better name.

Changed them to write_permissive_pkey_val/write_pkey_val in v4.

> > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > index 86be8bf27b41b..d94a0ae7a784b 100644
> > --- a/include/linux/pkeys.h
> > +++ b/include/linux/pkeys.h
> > @@ -48,4 +48,26 @@ static inline bool arch_pkeys_enabled(void)
> >
> >  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> >
> > +#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
> > +
> > +/*
> > + * Common name for value of the register that controls access to PKEYs
> > + * (called differently on different arches: PKRU, POR, AMR).
> > + */
> > +typedef int pkey_reg_t;
> Tiny nit: Should this be an unsigned type?
>
> Nobody should be manipulating it, but I'd be surprised if any of the
> architectures have a signed type for it.

Since this is a stub type, can matching the real types do any good
besides masking programming errors?
I've changed it to char in v4 to surface more potential programming errors.

