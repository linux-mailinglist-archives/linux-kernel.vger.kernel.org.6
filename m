Return-Path: <linux-kernel+bounces-203246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52EF8FD852
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E6F1C224DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68215F41E;
	Wed,  5 Jun 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nInm2ApI"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF319D895
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622510; cv=none; b=S7eXOxpBdcEKSbQEn9KRNWd9xVFPboIl65hSuw5FKi8pX5AbOoPOTWNSR9YQYhRHpTiqSO6Y3IAOeU3e22KJMoIJhHrJPjWcNwVviSNQn7Nz+dr9zLjKmPeCui/+/aSDtUMYJCC9Af9XPnRzjytiidhgV9luPt7iOUlLQ2iWyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622510; c=relaxed/simple;
	bh=EqsVKyEcVPdVssyAnSUWWQH6de+AhVDwTiAoP+flfbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6ZYxA3ukbsFc9/MUU1ZQyeWSIQTz0jJWQ6ZqdGYkzY+8Dmvo4g3ijoDYGxQ+7fS+UnKD4gf/wQyiYN+TVEbqIf1jPcY1kYnFKbXdsYzsfqgqg4ASgAdymSJCHulBqxwJHS/SVtzmwLkzrV0eFO8WzE1oA8NsDSeOtIZrxhyHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nInm2ApI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b8b638437so347013e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717622506; x=1718227306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHWDjujLIHNJtgMnjtgIy2d3mqKEQ4RI39wDCXw+ApE=;
        b=nInm2ApIBPuWA55Ljc/O37bypOCDIVMMa+QBy0O80z09m1XEPK7if2DwUSN7qFNdt0
         RazaoAbO5k6bzJ8RYMEAiG9hzXP9wloX88lD5rjbGiUSkUJtktYcZ2tK+TME6NWq0XxW
         zws9PpZvAk0ev5uOcVjCwousYuu0gHdswQ1pYE3BEhb2DkPUgV4MJZworwrTo2JA8QuQ
         zo83d0bZCHQwm+izK0fColRxhS1u2gqoJc7WGkGx47PbllXwVEZFSZGbpUXxcSWtruSJ
         VaQP5ivdBWGgnfyJJ9Z0YtAM5PBWXYoLOCWR2bh92KowfL4lhGwSLDpQVjOEFn9Oausv
         F+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717622506; x=1718227306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHWDjujLIHNJtgMnjtgIy2d3mqKEQ4RI39wDCXw+ApE=;
        b=cgduHEG9cayZorgepHeqVg388hUzxG8/sZhPzBXAejoJ2VdYK1tkon6Dc8x8dHXbns
         zBB3ipRjUQNWvM5hXpbGEOIzDAtMp2UPOdq7MaqcqzgkjL+QTlzooP2QvyT3+HdzMMTW
         Kf1VE5jqNu20HJzDCD9Mbobc0+yKITG3sPqLdYDpv5gyeQ6n4bk4/gfGUaTaVYci/+nF
         nrOpBG8wtD0lDL0G0uYStFMbh7ATFj5GUxK8bnCrfuUmpFzOZw1Svn4GES6xLdDHhQXU
         VT9zXNdoIZXMxMNU1Qp5/UCei0JSc+aFqPt6EqZDxNhpKKwEJb1wIEhzbAb5uL1Eant0
         YFJA==
X-Gm-Message-State: AOJu0YwiG1HzAiwzFWU1tZwuRXz5ZIB5xM3ZYzpO1S0K0kzG0Ub1HGDE
	li2O5dQUaM3LqihIaNYpk2fiN1nxNOAqVuDdIJeJ0MqmLBCJv1x1TdcejL6JCaIgku3cV5I2GYq
	71nlmKYHjEFTTZPOEWRqUj+Hjqg==
X-Google-Smtp-Source: AGHT+IGfU4YGQuhOO9Bv26J/Ms+j7sAh164qumml7KuVabmx9a8E8CLcpExir3IdqsURTi9sTI6I0kbmDU5eOWvSc7M=
X-Received: by 2002:a05:6512:3da3:b0:51f:5872:dd8c with SMTP id
 2adb3069b0e04-52bab4e8a85mr2579083e87.39.1717622506251; Wed, 05 Jun 2024
 14:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605083557.2051480-1-mingo@kernel.org>
In-Reply-To: <20240605083557.2051480-1-mingo@kernel.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 5 Jun 2024 17:21:34 -0400
Message-ID: <CAMzpN2hms-cpsaief4j_1LhXXznreE+it8nnsH2-8yoQ2Bn0Rw@mail.gmail.com>
Subject: Re: [PATCH 0/3, v3] x86/fpu: Remove the thread::fpu pointer
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave@sr71.net>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:36=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
> This series is one of the dependencies of the fast-headers work,
> which aims to reduce header complexity by removing <asm/processor.h>
> from the <linux/sched.h> dependency chain, which headers are headers
> are fat enough already even if we do not combine them.
>
> To achieve that decoupling, one of the key steps is to not embedd any
> C types from <asm/processor.h> into task_struct.
>
> The only architecture that relies on that in a serious fashion is x86,
> via 'struct thread::fpu', and the series below attempts to resolve it
> by using a calculated &task->thread.fpu value via the x86_task_fpu()
> helper.
>
> Code generation: without CONFIG_X86_DEBUG_FPU=3Dy we get a small reductio=
n:
>
>    text        data        bss        dec         hex        filename
>    26475783    10439082    1740804    38655669    24dd6b5    vmlinux.befo=
re
>    26475601    10435146    1740804    38651551    24dc69f    vmlinux.afte=
r
>
> With the new debug code - which I think we'll remove soon-ish, there's an
> expected increase:
>
>    text        data        bss        dec         hex        filename
>    26476198    10439286    1740804    38656288    24dd920    vmlinux.CONF=
IG_X86_DEBUG_FPU.before
>    26477000    10435458    1740804    38653262    24dcd4e    vmlinux.CONF=
IG_X86_DEBUG_FPU.after
>
> The Git tree can be found at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/fpu
>
> Thanks,
>
>     Ingo
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> Ingo Molnar (3):
>   x86/fpu: Make task_struct::thread constant size
>   x86/fpu: Remove the thread::fpu pointer
>   x86/fpu: Remove init_task FPU state dependencies, add debugging warning
>
>  arch/x86/include/asm/fpu/sched.h |  2 +-
>  arch/x86/include/asm/processor.h | 19 ++++++++++---------
>  arch/x86/kernel/fpu/context.h    |  4 ++--
>  arch/x86/kernel/fpu/core.c       | 57 +++++++++++++++++++++++++++++++---=
-----------------------
>  arch/x86/kernel/fpu/init.c       | 23 +++++++++++++----------
>  arch/x86/kernel/fpu/regset.c     | 22 +++++++++++-----------
>  arch/x86/kernel/fpu/signal.c     | 18 +++++++++---------
>  arch/x86/kernel/fpu/xstate.c     | 23 ++++++++++-------------
>  arch/x86/kernel/fpu/xstate.h     |  6 +++---
>  arch/x86/kernel/process.c        |  6 ++----
>  arch/x86/kernel/signal.c         |  6 +++---
>  arch/x86/kernel/traps.c          |  2 +-
>  arch/x86/math-emu/fpu_aux.c      |  2 +-
>  arch/x86/math-emu/fpu_entry.c    |  4 ++--
>  arch/x86/math-emu/fpu_system.h   |  2 +-
>  arch/x86/mm/extable.c            |  2 +-
>  include/linux/sched.h            | 13 +++----------
>  17 files changed, 104 insertions(+), 107 deletions(-)

This series would be better if you added the x86_task_fpu() helper in
an initial patch without any other changes.  That would make the
actual changes more visible with less code churn.

Brian Gerst

