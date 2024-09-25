Return-Path: <linux-kernel+bounces-339474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC69865A9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D17285BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF506E614;
	Wed, 25 Sep 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBqTVA5Z"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303451D5AC0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285624; cv=none; b=USuYb6KvslAhCP2IUxTi1Nv+4KSCS0Pry4vf+kEzll6nuhJHinI/JSnQAu1FMmms8id2BS7V/8SmYbLdWIY9/tvdWLOwM12RoZW4EZ63cXNYJcA8zC6xUtJDOQu6pVbFtU9ko05kHUfnT77/9fSZ2TBa2eghplmMNWE2LKFr+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285624; c=relaxed/simple;
	bh=sRZR8qh7UzzgZh+dnd71Rif1yJr40LYLdX/AWA02/dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foI1H/q1XZD973QrdAezlrFgvAhVKqbAlPpOlCxpo8uysj641i+msMI73EfqaMplPRpn9zxTaS2v1D5OwnoYf3WRf3e/pFiG9DZ90UCIEfzUDPvTY1yJwFn5cvxJ0VlWEdxIDGzbwLD+df8XbE8IKEMQDJ7DxtYUnLjEDwQ3Kho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBqTVA5Z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso18726866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727285621; x=1727890421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0mE3cmG1UxBKNjTv38VsA/8AlwoySypDMzbCz8nx40=;
        b=eBqTVA5ZQzG/VCDq6Ltrwax38xIt36CpmpJlrTZDU0gjNZ0IDfLim0RoQbMcQ4NvFk
         N+x2vahRAAb/Ie5CZVd1QoVBmPNlKhFQ/XSAfJjm02NZp2iB6fMwd6Adw2Ykor8+ObCv
         JexWve7NHIkW1mAsg+4mHxIvKaMRwnvIxUJ9JWoTH6bhIg8x0o8UxvrK1LehR+tCG7n2
         GhO8hER4yAsaOyxv3bb5M0QMigT+jp+b43j6fSvDy7xNEGAIBrqLhl51UTetddzy0OUp
         iW/nWCCm3dYi3S21fZeqi+XLghhgXHBybOL598e7XbydkpvBH7sQd5WkKMCWd8xTtweV
         +pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285621; x=1727890421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0mE3cmG1UxBKNjTv38VsA/8AlwoySypDMzbCz8nx40=;
        b=FnqDClyNv1/smp0rHw9Kcz9OIBLSxnEdn7pQw6OYyTa0kcAuZrKTck4SGlaGi7NJGJ
         BfVoMV/G44UoMwIZriz5PIgQB9HDeEdkKc5H9J6N3ZEEGit8ON3wlWSybAII/5+TC53F
         X1JuCzY7zXt9QwGa8VcINakornfhOS8gI7mNP5af8w7iIcEqKwlgsjoS0C/83EOoZ2rz
         165W4rku5XOjhxq8gcAq1hoK3B2JI7Ozd1I1bwFZgzlUYGLjTyscGasDM38knm3OQ9M1
         z2LKdqRWfJTLM2Cdgk/mIoUwDkJ0slBPs0iE8e7i6IBAi7MKAXDSpr9c/YkpSkywjDcC
         M2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxb577WUPOFuOvC8T7UIPjnCZHrKH3lMWmJQqyzCPDaV1ruI3zEZclcuZcmOGnt3fNZAHm1JhwvhCANyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsvHF6DCx57zmuqyo3OKMPmzMkbwudWXN7zg9kGNWMO5QNNMG
	lqEGeKkLPlq8VHxBhOUTTjUCVBRSEL7TkCdmZhT6aUK/d8xvIx1c5KUtURauFIr1pBodPF6Od1e
	x19cKHlfUP2IoddQYjavwvkouiQ7Wx+lqscA=
X-Google-Smtp-Source: AGHT+IEKYCfjzY+zOC7A8PpoeNigo2nDiTdRzgKt6xy0G8xhUHZWn/4IMc8JYMsjLyQdX2eBiO9PWPy+ZE41r41NKV0=
X-Received: by 2002:a17:907:ea8:b0:a8b:154b:7643 with SMTP id
 a640c23a62f3a-a93a03abebamr302057466b.28.1727285621170; Wed, 25 Sep 2024
 10:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727191485.git.skhan@linuxfoundation.org>
 <f797bc704d8eb03234a3447c77fa7b704339f89a.1727191485.git.skhan@linuxfoundation.org>
 <CANDhNCpsEQL+S8gadXMjvbE-6r8c6owzz+_DhN6JAVqQ8Hg=_g@mail.gmail.com> <b0647b67-5cba-4e42-9d42-d12ba2aa2174@linuxfoundation.org>
In-Reply-To: <b0647b67-5cba-4e42-9d42-d12ba2aa2174@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Wed, 25 Sep 2024 10:33:28 -0700
Message-ID: <CANDhNCr18_+dQxPqjMCvEU3Z4s9iypFYUNFZT3CrONmeGxJZ1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: timers: Remove local NSEC_PER_SEC and
 USEC_PER_SEC defines
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:20=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 9/24/24 17:59, John Stultz wrote:
> > On Tue, Sep 24, 2024 at 8:57=E2=80=AFAM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >>
> >> Remove local NSEC_PER_SEC and USEC_PER_SEC defines. Pick them up from
> >> include/vdso/time64.h. This requires -I $(top_srcdir) to the timers
> >> Makefile to include the include/vdso/time64.h.
> >>
> >> posix_timers test names the defines NSECS_PER_SEC and USECS_PER_SEC.
> >> Include the include/vdso/time64.h and change NSECS_PER_SEC and
> >> USECS_PER_SEC references to NSEC_PER_SEC and USEC_PER_SEC respectively=
.
> >
> > Nit: You got the last bit switched there. This patch changes local
> > NSEC_PER_SEC to the upstream defined NSECS_PER_SEC.
>
> I think what IO have is correct. posix_timers defines them as NSECS_PER_S=
EC
> and USECS_PER_SEC and the header file doesn't have the extra S. It could
> use rephrasing thought to make it clear.

?
But the patch is removing the local non-plural NSEC_PER_SEC usage in
posix_timers?

-#define NSEC_PER_SEC           1000000000LL
-#define USEC_PER_SEC           1000000
-

As the headers do have the values with the extra S.

So I'm confused (sort of my natural state :), but this is a minor nit,
so apologies and just ignore me if I'm really getting it backwards
here.


> Is it okay to fix this when I apply the patch or would you like me to sen=
d v2?
>

I don't need a v2

> >
> > Overall no objection from me. I've always pushed to have the tests be
> > mostly self-contained so they can be built outside of the kernel
> > source, but at this point the current kselftest.h dependencies means
> > it already takes some work, so this isn't introducing an undue
> > hardship.
> >
>
> Yes. At this point it would be hard to build it outside. DO you think
> these defines can be part of uapi?

Maybe, though they are so common I fret it would cause folks trouble
with redefinition collisions.

Thanks for doing this cleanup!
-john

