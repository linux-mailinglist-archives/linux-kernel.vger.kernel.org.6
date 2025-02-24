Return-Path: <linux-kernel+bounces-528447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C4A417C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501CE18874C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6A23C8C9;
	Mon, 24 Feb 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35bQaqVJ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD520A5EF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386915; cv=none; b=HY7L2EOdvj5oAum4TGdygcHmfJTOx8FRo4/zNw3LaEnAm+2yo/IlLXLsQslwPnDm1mOmH6cN00N4p6XktB4gDB1XuzSjiFXUTMc1K0Ymc66K5tWoCmnh3yDPpX9EwF0Udj2RDnsPGyQYFnJB+1bFUNeMs28fFdHHaPOPy9TSvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386915; c=relaxed/simple;
	bh=7RbjGvmVrtFqA0ZQvxGPPCHbndaFIwxjUK767xQvYow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuQE1ancriBtHm0Xdcf1+MgNATkgr8pko1YkJRYCj8ApigYDCeGAYbr1ACqmrbZEqsl77qwo2zd1I6sAk89g2t2u/m/Ssj62mX2tuYNfZ3NtxxsH1+ngxPlmVFs1rhHlGAEPfjN3ilYiyZETXQaVqxp+9g2U9EHWTHP+V5rhAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35bQaqVJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30761be8fa7so38335941fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740386912; x=1740991712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M4OIur9r2TccLLhBHIsDK1vsWiP0yZKdzQkTaFNLmec=;
        b=35bQaqVJY4WOdYhQNnSz67aw741QEiREBPYN7xL2yCV+BPd4pm7fAL0YXNGkTP/RpG
         CRiklOdT07oICU75BVNXX90xKxOL9wwkkpLRkWWBMSg2OlNzBdPt3eJRaMsUiv6/4p5e
         ny72vDWJlzOrWEgkd1jJRMgavP4zujNZTHSWkHWbbXj//xv4rOeSGAPIjZd/TE9QkRBH
         3uAh7xgUTVex4HnvqY6Y72+JM0RsxTQRo1xNTpBh1b/yHKi9lyrVI3mog57lOlGhe7aR
         eOnjgaP8sxrNeqxlisuX+IxlBkz+yCwSZoluobIIUHCYJR6hK9aOdt5kaInk0iaJe7td
         EzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386912; x=1740991712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4OIur9r2TccLLhBHIsDK1vsWiP0yZKdzQkTaFNLmec=;
        b=cqV6ZvkKR1kyKHBEG7w4oJXtTR4f6RvrZ/ZVmILh8bx2ruVDYzcb9lIU4saHdQyDGa
         qrXCeigWAvGw53Q4dnQSoyEwlBYYJ7vDII91akxQbX5dIQNG+36ntTS/E1U5Ifyb79hr
         gfrXBOp8xhWvV9rp1OS4xndoodnQYS3dsNBC9IGZOoP9Zh+MHfjhuXCrb5vzNQwmwOHr
         8Rb0qfVjugUE1CzdkvXK7YlCczOg6sbfWpfH/QqpoC//IKHaeCkOT0cGJBH8lbIN1uki
         uGisU72rGy4TpXdunSjAxbgX2U+FioAX5KVBTN6nSgOKxy8eFNQBGY2qCbivVVxvdXOQ
         NJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVbvHspggGZ4s5XFO0NE/IykWcU5T1/PJCj7Udn5uFpQlpaFZH/Oo/VsowvVs2DEh0a5SAoQP/61rDcjdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oZKxldERt0gqVj7wulIBhc/qN1Cavt3JvRdZQy9ugt0YeLk4
	xcPsWYHhlC07pMvSaP5A14jdGAj2D0S0lm4QEqC//vhr/FjkUpw7W9L6mzV0YoKaROFAg/PRPih
	JCixOObYnLkTYKeLCnwmicjxoZO2l8rVBzJAv
X-Gm-Gg: ASbGncuywFX4q6Yyj9ETft0Nt+khn+J9NahAIseibvVWnN+qxDE4YsSfrvlZ1P1uSvf
	CAM068IQI8oarDHn2uaIc3QVUsT8Kud0U4a+ZedocTkmaeGaUjhy3T+I8GX+Ft6hstB/wE3d+X2
	3CxJeETGdc7js4H5LY3+sOoAoYUmg2RmcXiR/GX8nV
X-Google-Smtp-Source: AGHT+IHoulG8yAuPTtFY5mi/Qv8Hzh39cGA58YppozdQkacVGZqNqCguNZ60Yz072X1oNPnaQgYje/Vw05VduO2Mkq0=
X-Received: by 2002:a05:6512:238a:b0:545:d7d:ac4a with SMTP id
 2adb3069b0e04-54838f5a594mr4606853e87.36.1740386911883; Mon, 24 Feb 2025
 00:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739894594.git.dvyukov@google.com> <5e105b1382cd43d05f1d3a80958e4f50f32144c8.1739894594.git.dvyukov@google.com>
 <Z7dHid-IL7OAPmUa@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z7dHid-IL7OAPmUa@gourry-fedora-PF4VCD3F>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 24 Feb 2025 09:48:19 +0100
X-Gm-Features: AWEUYZlAU3W0s0mngiGlITQm0EeoHzeog8X8ALg0WE5m7tuuOWEewj68nHv7K4s
Message-ID: <CACT4Y+btS62MDJLRToydRfK-QAMBiihv9d7Du=zEf5U_GbiOMg@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: Extend syscall_user_dispatch test to check
 allowed range
To: Gregory Price <gourry@gourry.net>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org, 
	peterz@infradead.org, keescook@chromium.org, gregory.price@memverge.com, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:17, Gregory Price <gourry@gourry.net> wrote:
>
> On Tue, Feb 18, 2025 at 05:04:36PM +0100, Dmitry Vyukov wrote:
> > diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> > index b0969925ec64c..fa40e46e6d3e9 100644
> > --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> > +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> ... snip ...
> > @@ -110,31 +111,15 @@ TEST(bad_prctl_param)
> >       /* PR_SYS_DISPATCH_ON */
> >       op = PR_SYS_DISPATCH_ON;
> >
> > -     /* Dispatcher region is bad (offset > 0 && len == 0) */
> > -     EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
> > -     EXPECT_EQ(EINVAL, errno);
> > -     EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));
> > -     EXPECT_EQ(EINVAL, errno);
> > +     /* All ranges are allowed */
> > +     EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
> > +     EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));
>
> A 0 length is ambiguous and nonsensical in every other context, not sure
> why you'd allow it here.

Yes, but it's also not special in any way. One asks for a range of N
bytes, one gets a range of N bytes. Works for 0 as well. We can move 0
to an own special category, and add production code to support that.
But I don't see strong reasons to do that. It's like it's possible to
do read/write with 0 bytes to get, well, exactly that.
How strong do you feel about special casing 0?

> > +bool test_range(unsigned long offset, unsigned long length)
> > +{
> > +     nr_syscalls_emulated = 0;
> > +     if (prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, offset, length, &glob_sel))
> > +             return false;
>
> This creates an ambiguous failure state for your test. Is it failing
> because the range is bad or because you didn't intercept a syscall?
>
> Better to be more explicit here. It makes it difficult to understand
> what each individual test is doing at a glance.

Good point. Done in v2.

> > +     SYSCALL_DISPATCH_ON(glob_sel);
> > +     return syscall(MAGIC_SYSCALL_1) == MAGIC_SYSCALL_1 && nr_syscalls_emulated == 1;
> > +}
> > +
> > +TEST(dispatch_range)
> > +{
> > +     ASSERT_EQ(0, setup_sigsys_handler());
> > +     ASSERT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel));
> > +     SYSCALL_DISPATCH_ON(glob_sel);
> > +     ASSERT_EQ(MAGIC_SYSCALL_1, syscall(MAGIC_SYSCALL_1));
> > +     TH_LOG("syscall_addr=0x%lx", syscall_addr);
> > +     EXPECT_FALSE(test_range(syscall_addr, 1));
> > +     EXPECT_FALSE(test_range(syscall_addr-100, 200));
> > +     EXPECT_TRUE(test_range(syscall_addr+1, 100));
> > +     EXPECT_TRUE(test_range(syscall_addr-100, 100));
> > +     /* Wrap-around tests for everything except for a single PC. */
> > +     EXPECT_TRUE(test_range(syscall_addr+1, -1));
> > +     EXPECT_FALSE(test_range(syscall_addr, -1));
> > +     EXPECT_FALSE(test_range(syscall_addr+2, -1));
>
> If you are planning to include 0 as an allowed length, you need to
> demonstrate what it does.

Done in v2.

> > +     SYSCALL_DISPATCH_OFF(glob_sel);
> > +}
> > +
> >  TEST_HARNESS_MAIN
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >

