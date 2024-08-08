Return-Path: <linux-kernel+bounces-278912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785E94B681
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8651C219B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22559185E7B;
	Thu,  8 Aug 2024 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaCU5tqg"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A901850A4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097455; cv=none; b=qgjy4g2XI1O7CfRLXn/WC+EnGEmKv3mkxyGETG/pqrVwm60XjkVuY8saIDaNXi6YgH6OsA217o1bINK/hajdwQfyXtktbMcBhibbHjDNXV9UaU9bCaezjU3XclgPbSl+wGQJ9wH838dpYcLyUijhX/CutquK4FnIip0TZr+huWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097455; c=relaxed/simple;
	bh=GnzANAyK5yZinRZkfmrD4AbZCANrvhiV4oeBbHITLp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwIoe2i+EBtZRZpbdERbYX7eLJM/ZRz2KUAp9mS/bs5HwHoB8IZ1C14BGnzSdSaxZSIBWtYbZrlTxGTMM4jj4wEZvKCAb9qI5c/JMYQ26o1hrmL2Vxz9cb2My+TXXMpJr2sVLQirf1ji/4ZFh0918csXZsUXfbK7AETNEbmqJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaCU5tqg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so7468901fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 23:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723097451; x=1723702251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loYoNeVRY7KEJa81oq9hkQS+UMxLemJSRdEJ8Zs5pPk=;
        b=KaCU5tqgSDzpVqJjchFiFx5Z5fUB4LwNkx0T/v220vAMNuZobt6y/7iTyeooeF7w2Z
         4iNRcFFuMkMhAFfFRMdPG9pDxi7BkE0z8vDmk54hnPnVxMHCY3YaOKP5FE03PQdgFVDe
         hSm8vhvlB4jfiMLSfhRNiRFyRdylyJ63WFx96UKyXMeWO3WOvRm9UfZtR65hQunvrBxC
         S9wSacMWvp4OLXj3wu5Cs9eXAHL3DRQ6hB+16GO7NLDf9uDCyyzbv6oiiA3hGISTbJKe
         9y6aa1udkpuraoH+2DqhZShQh954e5m5ygrXJ32g0Ya3+rCsdar0xRc95ZVgOmw5w2uo
         IBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723097451; x=1723702251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loYoNeVRY7KEJa81oq9hkQS+UMxLemJSRdEJ8Zs5pPk=;
        b=vb5qTxRJalsUFbtTdMDOz+700dc+oVQeRM34nbQ4yg07XjLwt5SUINjrCu/mNpKV2d
         +rtzNw16exDcIER0RRjZ5Mmnb7kfMuedJQowe/7dpc4cSGIpNo0EY7YRXvBLWOWOdj/K
         i9dH12NGmnQe3Eaagqg5qcp1Pzd+FGg7xMbdqLTJpyZ7jVUMmSI81VVZwEps4zI2QEHb
         3eo9XYSshpo9FrjlIU5Fu2f9K5xpwstKWBBpWDhCTbRvDp9r42kUiPfGFloFPFys6KvP
         kndRo5HBusDnRGBiov3RQggCQcUwbdo0wUMXK507F7+apJxRSVgb6fl5xlssGjxY7RMP
         jdZQ==
X-Gm-Message-State: AOJu0YyiY4zuxHPcnb1aBUyXLMgeRfMF7GuAneKLpyLySdIqUqwmZf6j
	I0Sti9xXb6aWK0b5rCYHqGhvL/yzjnRWfLmF/MXD4MVKChHegVcFNvoy4KhFYiaOe4Scghdmf5T
	jxJyGKDOD2EJVC9v/WCWe9XYQi71I67e6MMA1tw==
X-Google-Smtp-Source: AGHT+IEf8Iul9A72tCFkgMPMtSg0A2K+9BVEBRqFN9OxVaOcHe8kdaaixpfxjbXUT41Qbxh4iHN1FaE5SLK3BxVmTBs=
X-Received: by 2002:a05:651c:548:b0:2f0:27e4:3a43 with SMTP id
 38308e7fff4ca-2f19de2d37fmr5737431fa.11.1723097450669; Wed, 07 Aug 2024
 23:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719112130.59260-1-ubizjak@gmail.com>
In-Reply-To: <20240719112130.59260-1-ubizjak@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 8 Aug 2024 08:10:39 +0200
Message-ID: <CAFULd4aCfMzi=jtxJpv6DCUQh5HXeTjbz=2xnJ0ap92d+R-1-g@mail.gmail.com>
Subject: Re: [PATCH] locking/osq_lock: Use try_cmpxchg() family of functions
 instead of cmpxchg()
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear locking maintainers,

I would like to ping for this patch. The patch [1] brings several benefits:
- faster and more compact code for x86 target (as demonstrated in the
commit message)
- better code also for other targets (due to correct likely/unlikely usage)
- prevents logic errors with wrong compare variable

[1] https://lore.kernel.org/lkml/20240719112130.59260-1-ubizjak@gmail.com/

Thanks,
Uros.

On Fri, Jul 19, 2024 at 1:21=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> Replace this pattern in osq_lock.c:
>
>     cmpxchg(*ptr, old, new) =3D=3D old
>
> ... with the simpler and faster:
>
>     try_cmpxchg(*ptr, &old, new)
>
> The x86 CMPXCHG instruction returns success in the ZF flag, so this chang=
e
> saves a compare after the CMPXCHG.  As an example, the code in osq_unlock=
()
> improves from:
>
>  11b:   31 c9                   xor    %ecx,%ecx
>  11d:   8d 50 01                lea    0x1(%rax),%edx
>  120:   89 d0                   mov    %edx,%eax
>  122:   f0 0f b1 0f             lock cmpxchg %ecx,(%rdi)
>  126:   39 c2                   cmp    %eax,%edx
>  128:   75 05                   jne    12f <...>
>
> to:
>
>  12b:   31 d2                   xor    %edx,%edx
>  12d:   83 c0 01                add    $0x1,%eax
>  130:   f0 0f b1 17             lock cmpxchg %edx,(%rdi)
>  134:   75 05                   jne    13b <...>
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/locking/osq_lock.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 75a6f6133866..4f89ac8e6a69 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -58,8 +58,10 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>         int curr =3D encode_cpu(smp_processor_id());
>
>         for (;;) {
> -               if (atomic_read(&lock->tail) =3D=3D curr &&
> -                   atomic_cmpxchg_acquire(&lock->tail, curr, old_cpu) =
=3D=3D curr) {
> +               int tmp =3D curr;
> +
> +               if (atomic_read(&lock->tail) =3D=3D tmp &&
> +                   atomic_try_cmpxchg_acquire(&lock->tail, &tmp, old_cpu=
)) {
>                         /*
>                          * We were the last queued, we moved @lock back. =
@prev
>                          * will now observe @lock and will complete its
> @@ -157,12 +159,14 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>          */
>
>         for (;;) {
> +               struct optimistic_spin_node *tmp =3D node;
> +
>                 /*
>                  * cpu_relax() below implies a compiler barrier which wou=
ld
>                  * prevent this comparison being optimized away.
>                  */
> -               if (data_race(prev->next) =3D=3D node &&
> -                   cmpxchg(&prev->next, node, NULL) =3D=3D node)
> +               if (data_race(prev->next) =3D=3D tmp &&
> +                   try_cmpxchg(&prev->next, &tmp, NULL))
>                         break;
>
>                 /*
> @@ -215,8 +219,7 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>         /*
>          * Fast path for the uncontended case.
>          */
> -       if (likely(atomic_cmpxchg_release(&lock->tail, curr,
> -                                         OSQ_UNLOCKED_VAL) =3D=3D curr))
> +       if (atomic_try_cmpxchg_release(&lock->tail, &curr, OSQ_UNLOCKED_V=
AL))
>                 return;
>
>         /*
> --
> 2.42.0
>

