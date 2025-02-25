Return-Path: <linux-kernel+bounces-532564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C1A44F55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441167A877F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52E211A36;
	Tue, 25 Feb 2025 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSO1b6Me"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAC198A32
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520627; cv=none; b=DR+lBrsdduCbMcJY/zKdtGHIyxv2teNtUvzt8TeTCvysEDxzSitVojUYrkJkUVy/QLsN2wBwIgxwyKhbtPwJstfZfQ9IPWYhfTvKVbAf8ek+tVC4u/ZqqV4sw5wrTQ3Hr7MImuR0WtIEH7tc0A4E/Cw0gFz6ZZ4Ets1uec1O5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520627; c=relaxed/simple;
	bh=ggH/rv0zrxGn17AKAJevu64PEOEFU+cC4ctj2O23jHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C48xCt43It0fRGZE34wJhH7d80J4R0a0A34p5JayhP+scT1u/tBM4GrjP2WxfgfMfDS1ZZUTJS6M0zAgYvRooNSsMD3AIZk4X56nedmHeh48RVN+MvEXJUcpvhC5DMHZVqWCjrxTMTfUJ02ZmG2PhyATVVoO+wkbNjOYIX+GXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LSO1b6Me; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30761be8fa8so67106411fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740520624; x=1741125424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ggH/rv0zrxGn17AKAJevu64PEOEFU+cC4ctj2O23jHQ=;
        b=LSO1b6MeInu6Vp/UMP7od0cRbL9K/JJls2xqsNMisd8r8DRCuMcFu2JVYUPdrLsaSg
         v2pxnCDBj2aamhBKPwcv/auXIg2CcNkw6G21GPWLu3nSLesCCqzSF5Mo5hkPzF1hAWW6
         S+Nog03TdJflLjhIDqDCZ++PY4+vEIHdEBNcp5USLHV3JjMMVsryo4EjvPaWV2FosHEC
         SMqGpRghrMmeG0D/nzbkv3E9cfTaIwhqFhQ2AHYh4UHTFIzaX17F76uew7wbRyzvAGVd
         4KAC8zpWu2dSYZPhda8P4jNfe9FqDj4XwVhTwmVrP2qZjF3eA1de5Lu/Y/9esZ8NIzHV
         r0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520624; x=1741125424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggH/rv0zrxGn17AKAJevu64PEOEFU+cC4ctj2O23jHQ=;
        b=pvcNUGDC3+UnI/6CYSg2Si6CYnAadShGjjiMSM07JjeVtcJKAVUJ8QeSejc5vQ+PkQ
         mXnhE9ymkwNHQaI5gW/9vY8o+8kwRXGZSJPzlKkzc4URJVUNl86s9Ilai7ikHjPV3EIx
         6hdgoP/yAaVY9qXSun4/2hhzUvuEpSNm8jq+Zty2NvUTqyOfaBn4u5snUSu5YkcMJ+qQ
         OGCikahTexFJDyWvGBZkxhW910GBxaLKeOO096JKYxwnlXyWG3/by8Zuy0kk3WHLdO3q
         y+G2Fvlk4p/m+HFKDU/0h7I9MBM57P7WwTz6dODJYFTdiGVzE2itl/AXUyQ3H1KhlgY5
         ZZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCWI2ucLaOkk9JrJh6CxuV1HKssMoNsrleswdtsNYHPcNfgdjMwgVVhuqZrnusppjOM5fCWkrWeuOZUcmao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/P78dXhef/RfDjdkGO0qGBu4PkoFy5j45dpbMI0rx6/LTrMSW
	xpiT4dF1jcMXr/qbn/G+rnPCORXgDaKeII7yBnDPfJV86pL3oHfHNXc73w6wBr/SMYz7YU6jBbx
	uW9HRSj/47yUtkioXLtcpJLu5u76BBkiqpYbe
X-Gm-Gg: ASbGncvb+8CEF5TQgwypIjU7gUfRy6FnpsN2fQe7kxeYMh+JXHniwFc7IHewl8ppHo7
	u1cMX6+CsH6+kf8nfT2lvBhFjnJVGv7B0dbTovnKWZZcDv1DU4dRzpfeK5OVALxOTJkebBuh0mx
	k+QudXm1vO4TQG84Z4B1+3HgiIERyYSp9Dp/vTYDT9
X-Google-Smtp-Source: AGHT+IFXOYk90HMvua9LKDnybbyVvftTCDxipLFybKYbrDxATJIKE8rV5+qkvdMzNlPSSVVMO+3M3FZUBL0+pcoQcJw=
X-Received: by 2002:a2e:8197:0:b0:308:e54d:61b1 with SMTP id
 38308e7fff4ca-30a80c7dc01mr32910131fa.34.1740520623821; Tue, 25 Feb 2025
 13:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com>
 <32af68b8-4280-4c15-8e5c-be807c282f94@intel.com> <CACT4Y+YmWrEW9m5zxKoD-Hu0TXKWPVAr0_Xe_X9WGtZWH5W1_g@mail.gmail.com>
 <d352ab70-6c13-453b-a018-dcf19d1a9924@intel.com>
In-Reply-To: <d352ab70-6c13-453b-a018-dcf19d1a9924@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 25 Feb 2025 22:56:51 +0100
X-Gm-Features: AQ5f1JpNQuRlQogqyMUr4S60L9V2UKjAak2_7Mf9mxRQEoJBqthLumVCnyc1Tiw
Message-ID: <CACT4Y+Ynq=21v0gwZxQ2sQhrJHibYoP6QvcfPoGBFYNXjzodDA@mail.gmail.com>
Subject: Re: [PATCH 1/4] pkeys: add API to switch to permissive pkey register
To: Dave Hansen <dave.hansen@intel.com>
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 17:15, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/24/25 05:25, Dmitry Vyukov wrote:
> >>> +#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
> >>> +
> >>> +/*
> >>> + * Common name for value of the register that controls access to PKEYs
> >>> + * (called differently on different arches: PKRU, POR, AMR).
> >>> + */
> >>> +typedef int pkey_reg_t;
> >> Tiny nit: Should this be an unsigned type?
> >>
> >> Nobody should be manipulating it, but I'd be surprised if any of the
> >> architectures have a signed type for it.
> > Since this is a stub type, can matching the real types do any good
> > besides masking programming errors?
> > I've changed it to char in v4 to surface more potential programming errors.
>
> I was more worried about copy-and-paste.
>
> I agree that 'char' is the most fragile, but it's going to fragile in
> subtle ways and I'm not sure subtly broken code (whether it's expected
> to be compiled in or not) is great to have in a code base.
>
> Do we have any types in sparse that would be appropriate? Could we mark
> the pkey_reg_t as being in a different address space when pkeys is
> compiled out so that sparse knows not to let it interact with other types?

We could typedef it to some fake struct. Such a struct can't be passed
to any function accepting an integer type (real pkeys), and any
arithmetic won't work on it.

