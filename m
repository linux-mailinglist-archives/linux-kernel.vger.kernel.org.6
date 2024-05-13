Return-Path: <linux-kernel+bounces-177330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B578C3CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41151B21BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223E1474A0;
	Mon, 13 May 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc6nznAe"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7F146D5C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588070; cv=none; b=pZx9nRZtqsPx/2T9ZT1h8iSJxyUKp9lc6XP6lNmWM6R6jHh3PM5RmkKjdcG8GWg2Kt8PsYqTS3AMFV7enHJaGux771aOOQsl5BP8zex+C6+GKntkl+HzWHvkqWwpLDm8SkULnOtbSt9gWU9GHgo5iahG8Apn/nO3q9jWZfliwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588070; c=relaxed/simple;
	bh=12ml4wWfxQl4jhbhqgvB8GySKJX6FlqTruuxJO3r50s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKdpLN7xIhGltfOIQAZ02WP6/f+9I6+2dVLnFCCJ/SDcVgtQgbglUbo6HvIdo68+oGWa5GatA9u+VvHcnXFgs0YcHvrMYidCroQceSwm4fRHL0gFtjVS1guLh3fokrCAOxT7Ev6f4wYv9klEIMV9cjAAAIocM3UEKnCBVbuB+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mc6nznAe; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-47efc592d9fso1149994137.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715588067; x=1716192867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0QsI6eg5FRHjsJ3EXAYkOdUsRM9QF3yW2xylikNfdY=;
        b=mc6nznAe164x80c7YoJMbtDNP7Os9yNeaBOuOgoZaxVmnTpTXhM7aXwA/BFq3OedU5
         ozmMpKEAjtcIUyHUS2E8C5Qu9VOhR49+rPByIeMFdjknlTmKXJpUjLA0foRWY6F8M0sp
         8nlnj6toixhcQdyJZcf+sKVX6kP2soHeskCQBs4a1kaysSECppmX5ikLPgM474QfHQ/N
         7ancMeBGBARY+K26FXcTt899+m5rFU0XBWPg1brekvl4RbVG9n3wgzPk5/nvfoNZGMs0
         SBvg/Js4n5la2qTIYka+5cqf1HqH2PRcgXeBWJ3aL1jtVKx09Y6wzpyDo1dfYYSLbKdJ
         rEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715588067; x=1716192867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0QsI6eg5FRHjsJ3EXAYkOdUsRM9QF3yW2xylikNfdY=;
        b=lRs3pxihxoeL3Yeje/YKRDbWiinMBFLEHMaGT44+PziruW632vuliuFMjgAGXW1QiA
         5fHwsql4VHuL1IUSaPpPbF3DSvjrMzuFHiC+/wKjh2BflBb893gb0azmt3gFd+38SGiT
         a4IJa207aTKluZ/fe00q9NeMCwMsQ+/Secw3JYBnErFeZ3MBfdRbddu7dujx0L+Hglrt
         7C6FCfKPyT2DqBmrZnEn58Hd2/RuIn5TTD3qKjGfefPPK+EAPWhW35pjT1v6lCwrFo4J
         wdu2ICCiEc4boE0R5tW0WLZMjGv8hLMsezgnxAM31A/haTDEB42L4+CXGsiZAN920cq3
         Qlog==
X-Forwarded-Encrypted: i=1; AJvYcCVzZkSd5gO0HbNYONeBgNMF54pn93UD80roqFWFmag80Vg5DeR0+/AZ40rwTU6Pb688M93BYBC8VujsQ0PE+YkGhkTHi26bB077TRxv
X-Gm-Message-State: AOJu0YxkeVjnDpsnXShAxYqMZj5YxEurTII/mZE9MKrvRFJNGH8Yc5+H
	8ZhJTfW6cP1KdqYH6eVTTNz2SlZgGDxRkOPAUf1au2ytxBPlO1krl87G9DHJb0nzVX58OCPDOe2
	dUZ8PuDcNi2jUYXznBFj8/0xV4VL+eZaL4R7g
X-Google-Smtp-Source: AGHT+IEN0CwwIMvMPcNvYrtwL0GHvXK2FmCEs3NcLvhxj5VrVLU78hu+gqQv8TlnVYs4qK+0BgkSJwJf7Ph04NygmMk=
X-Received: by 2002:a05:6102:38ca:b0:47c:2c87:f019 with SMTP id
 ada2fe7eead31-48077db706cmr10268656137.5.1715588067255; Mon, 13 May 2024
 01:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510141921.883231-1-leitao@debian.org> <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop> <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop> <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop> <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
 <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
In-Reply-To: <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Mon, 13 May 2024 10:13:49 +0200
Message-ID: <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: paulmck@kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 02:41, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> ------------------------------------------------------------------------
>
> commit 930cb5f711443d8044e88080ee21b0a5edda33bd
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri May 10 15:36:57 2024 -0700
>
>     kcsan: Add example to data_race() kerneldoc header
>
>     Although the data_race() kerneldoc header accurately states what it does,
>     some of the implications and usage patterns are non-obvious.  Therefore,
>     add a brief locking example and also state how to have KCSAN ignore
>     accesses while also preventing the compiler from folding, spindling,
>     or otherwise mutilating the access.
>
>     [ paulmck: Apply Bart Van Assche feedback. ]
>
>     Reported-by: Bart Van Assche <bvanassche@acm.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Marco Elver <elver@google.com>
>     Cc: Breno Leitao <leitao@debian.org>
>     Cc: Jens Axboe <axboe@kernel.dk>
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index c00cc6c0878a1..9249768ec7a26 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -194,9 +194,17 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   * This data_race() macro is useful for situations in which data races
>   * should be forgiven.  One example is diagnostic code that accesses
>   * shared variables but is not a part of the core synchronization design.
> + * For example, if accesses to a given variable are protected by a lock,
> + * except for diagnostic code, then the accesses under the lock should
> + * be plain C-language accesses and those in the diagnostic code should
> + * use data_race().  This way, KCSAN will complain if buggy lockless
> + * accesses to that variable are introduced, even if the buggy accesses
> + * are protected by READ_ONCE() or WRITE_ONCE().
>   *
> - * This macro *does not* affect normal code generation, but is a hint
> - * to tooling that data races here are to be ignored.
> + * This macro *does not* affect normal code generation, but is a hint to
> + * tooling that data races here are to be ignored.  If code generation must
> + * be protected *and* KCSAN should ignore the access, use both data_race()

"code generation must be protected" seems ambiguous, because
protecting code generation could mean a lot of different things to
different people.

The more precise thing would be to write that "If the access must be
atomic *and* KCSAN should ignore the access, use both ...".

I've also had trouble in the past referring to "miscompilation" or
similar, because that also entirely depends on the promised vs.
expected semantics: if the code in question assumes for the access to
be atomic, the compiler compiling the code in a way that the access is
no longer atomic would be a "miscompilation". Although is it still a
"miscompilation" if the compiler generated code according to specified
language semantics (say according to our own LKMM) - and that's where
opinions can diverge because it depends on which side we stand
(compiler vs. our code).

> + * and READ_ONCE(), for example, data_race(READ_ONCE(x)).

Having more documentation sounds good to me, thanks for adding!

This extra bit of documentation also exists in a longer form in
access-marking.txt, correct? I wonder how it would be possible to
refer to it, in case the reader wants to learn even more.

Thanks,
-- Marco

