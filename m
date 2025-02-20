Return-Path: <linux-kernel+bounces-523850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D087CA3DC11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CE217E7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462C1ADC9B;
	Thu, 20 Feb 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0l8SLY6"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F01BC4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060278; cv=none; b=F4yVFiGfTMsWFpyQH8RvrjnTkttaMjIEq3CchkdAE+QfNB3FzVcF0yBH2aaUsIPAAi6h81AF7H9CiKpAy6usGxChxRz6gAqqCWR2efX2AdE+i+PAab0rOjY/nKN9HKNKx5ykxgciQHObkgXGs1dEoWMDZfaXqv1bK104doTaBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060278; c=relaxed/simple;
	bh=tTUF0DuUbP1pVYp7uJb9H/AIJkbO9/EfJCsgtNuuF6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N10OBsOLdqGZrc7Q0ZMTNbyALd/R5D9PYp4Fuj9h1r8Qg/VQZMfZnfY288TPaftdUYR1l9cQ48a5KWWG564gQwDcOYxmpuLW4HeWBLYa1Cs8ejx13fJ19U/ZgTGACuOBnXM6Sbmcy9TyV4O/X8P7JL+JR11AH182xxYJX1o9rlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0l8SLY6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543e47e93a3so1180257e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740060274; x=1740665074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY+NBIYy2gT0zvxaoVTjE3mqscsqAzDhfABvZ+XFdRg=;
        b=B0l8SLY6HOhWRiZb4FwHwOVJm5qBtIJTDgJv75dU0+EXVnRKf1iBly2tWJEq6I3Jtc
         HFiotpUgDamcymFp5Qg0eQJ4NKbBaVOa5JVG0FieyEUs2ICqP1U5mFKVGIxPNl2Ek7Z5
         DgkiX5TbkyLf6odK0mkW/zW46hK0Qoai7m2zvXs4QA0CMlTNUgfgmPgwfgMaMsgqR9J3
         wrmBemuhfOiqG6FTB+NBpiZCVB5maWzAtE28OGBkvqvWDRYLqU5y/olvYgINwwshj5Uq
         TpmLA5g5d/onUbTnHQMmsvs200iN04ceD1UgI53z1eC1EkIw6S5AGL+YX66lYPMNIJJg
         7cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740060274; x=1740665074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY+NBIYy2gT0zvxaoVTjE3mqscsqAzDhfABvZ+XFdRg=;
        b=GuD/ds8FYKWDfiDPWpl9XkGyfn9EbaxwvAtXaa6Dn4ZMYGV6FwA5pqTl540WlDynOT
         F8kCZfl3zBxzt+8VdRjhUFaldReMb/eRMZVEqwzfiwyssVgkYAGqcXkkOQ/v5qokLTqV
         NdCiKEPoTN8Dj+VOiXcbyuqEpRltJKTNwlxhSYI5SriU4wnLLG7q2Lez0WoTG2FlDBFG
         8BGUauhnWlcQatiD07LqMjNYyWNOe6yfw2Q4c/ObQmq+Pmez7ugqi1FXCEBq5P77nlk3
         Xme1NIRhXF28I9ubWDkatUvxBPiBCmpmjf6Mq0exD/IxV/4wSivKVi9K4M6JKSohJLkz
         fI0w==
X-Forwarded-Encrypted: i=1; AJvYcCXVNdd+Fw3jeNI1K0tTzxZuU/bT1eBvST2URYghwl8PVFODl0lXfMNsk/FL9M+iR1ZC2KxddOVaEOSR+iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKbBJ+BKmvJ35/X2rC8yb7h/yDpqzmBylAJZwsx/hZFcUYSjN
	AMPAw19XowBFb9TrVUW8ahcSUZb1JXppXwxPPG/lcPGcv0VxkrdyEotpVC0mMunEiZq0J36NxSf
	yqDPqctz88xRFwoeo764xHElVw06TODsGM+ELfw==
X-Gm-Gg: ASbGncvuhD+SOrHafB2k+XewHbKEPWSNmouGeLu47TK0EMUNCM6I9THOXTgWNRw6q8z
	FcL3HmFUPXK8AZIVxkeBarUBG0cw6UK0xK76SpPojjxABhxAftO7oB3u/yAZmrZ7lSqdsZQ+T
X-Google-Smtp-Source: AGHT+IGJwZJ+HnwUiO5AZPnqLuBn5q7vQJN93vatOpb00wYq/6/uLggOK7k4mc6rL8mIKuVW88nuIEu1nK2DEGYr7YE=
X-Received: by 2002:a05:6512:688:b0:545:6f1:9494 with SMTP id
 2adb3069b0e04-5452fe6fbe0mr7094057e87.35.1740060273484; Thu, 20 Feb 2025
 06:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
 <20250214010325.GA12626@strace.io> <CACRpkdZJYFUhmPg3EWJeU42fzJMzWm7Sgn3XfELB2-PSCf6Ssw@mail.gmail.com>
 <20250214110508.GA19194@strace.io>
In-Reply-To: <20250214110508.GA19194@strace.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Feb 2025 15:04:22 +0100
X-Gm-Features: AWEUYZmkc4EjePowUwFakXU4c6G7RgBFrQLnwon4iEz2BqS1QCkM5_sbNQssIk8
Message-ID: <CACRpkdbmOiapucnzyd9-x4WJsRBs2pRdcgZ2-AoN3bdkNJaW_A@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] ARM: Switch to generic entry
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Eugene Syromyatnikov <evgsyr@gmail.com>, Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:05=E2=80=AFPM Dmitry V. Levin <ldv@strace.io> wr=
ote:

> > Sure, where can I find this test suite?
>
> It's a part of strace, you can find it e.g. at
> https://github.com/strace/strace
>
> To build and run it one can roughly do
> ./bootstrap && ./configure && make -j`nproc` && make -j`nproc check

make check produces some test failures on v6.14-rc1 on ARM
even before I apply the generic entry:

FAIL: filtering_syscall-syntax.test
FAIL: qual_fault-syscall.test
FAIL: qual_fault.test
FAIL: strace--tips-full.test
FAIL: strace-r.test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Testsuite summary for strace 6.13.0.27.bbda4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# TOTAL: 1409
# PASS:  1106
# SKIP:  298
# XFAIL: 0
# FAIL:  5
# XPASS: 0
# ERROR: 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

But I create more fails after my patch set ...
Some have to do with fast syscall restart (I need to look into this).

Then there is the fact that I had to add the  PTRACE_SYSEMU and
PTRACE_SYSEMU_SINGLESTEP as stubs returning -EIO
(modeled after UM) to use generic entry. Do you think this affects
the results?

Is there a way to run a single test? I tried to check the docs but
nothing obvious to me ... I guess I'm not used to this unit-tester.

Yours,
Linus Walleij

