Return-Path: <linux-kernel+bounces-206923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D4900FFA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F0428425E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84EC1667FA;
	Sat,  8 Jun 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juoPaTWB"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125C8495
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831939; cv=none; b=p2hfeALJXy+baF+rC6KwOEN2oWSQAwhMkT1qHXbSxFMdzm/85j/61A2bcgorD/lGy/DSqJ4J0W+B74VBRP8nUWk4UElPs5JVwcApkeczhBCH/tTVZhjbSGJCZK4QxS3gAS9J5CSPpjiieqXRl5MEymb/wRkjBnAKZWjhmVIjZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831939; c=relaxed/simple;
	bh=AZKBFN90tKnMMc/N26fS8u6OF7W3eyf/sCjLniLMvoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPujPDpVFWm0Jd1quRPtkXJCXCmlWREQXI3TyPxCeMr5YlpA5MXHzYFimkVUqdYJS4c4FeVrQEax7jSjX0TnspOTeIP5fKQ1EBiAbS/jFijNwdbC2iZdq3HaBKotJKW5xK7L2zqf8InakiGKb32A/ChXqYHzJSKp1xbyYmBtgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juoPaTWB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so3591520a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831935; x=1718436735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cqNcSIg+6dYdCCgXrXKU0UnjWVh0bWICssUxVg3vCx4=;
        b=juoPaTWBeNExpcr6KR72EpSj0a5J+JbzEnaVX54J+fZ0y4xu4/yv9SPMc6JYKHWzuZ
         kp1Ny2Cxy9LmPLgxNLYqRJaaX7XrcrcBQxYnprhJB8+1jmf6W30JLoiylpx1zNTvnsEV
         UPh3c+TBLszDtIias33mv0CuG+GM1KkN2SMBpSsYPxjZlRuQXK6Y+eHY31SsvlAEYUWi
         GdogKHnjzauq4NHf4eqb4SgLzHYNpWi8TeadgpAytqNXlpHcZ05KY1JZUJdKVaDzdSmk
         6k8Dk8FMyGYEM+WnLxgVxSHydeyLeeU8ZoqmTtrHRF0LRQgdXBjk54I86aRtSzCapgTZ
         pepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831935; x=1718436735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqNcSIg+6dYdCCgXrXKU0UnjWVh0bWICssUxVg3vCx4=;
        b=VJAB8o3rw+tSTZkqSQLEJYM23uvt235OoWEy/mzC0U7++GWKWdhV39mHKT8goBinKG
         dEZnoELtujBmruxgCIUPWgihSYvXBbMoIrGHlygSVKgq60rH/BNyrEUZ0ED6JKaxHnGN
         WgkPeHC8/elD3uV6LDCcgOKx5laDQhK3lXUBgk/Xhyx1gf4xX8khpankqAZtNZzewhdV
         JVhDv4703m55khsIQT5yAdOKmYFFTvCnaM68RPUzw4k7CuOoeaJ63vaYvItrZKiYCmle
         nAMx54Lx9BPRAWlg5I3kyJMlJK7mjLoZ0g4cYwzIyQ6wMIBWu351W4BnXQgRjwIJoxTf
         kgmw==
X-Gm-Message-State: AOJu0YyejE2nZZ0v/gzAU2rPHBQOC1rhHFMGo88B2Wz/daXvbkE3Lu+/
	kRHNFTAq4TNGH8X1qExNsy3kgbGVWHrXfeIvOsPBYo3+8YJYti0j/d6K+2D+
X-Google-Smtp-Source: AGHT+IEQuFOBC9oPtFcqW44DOAiTv8V56oJrNlu7W93IftDAcZm9vwNJz91TZh3ps1Sz2s5vEaL9jg==
X-Received: by 2002:a17:906:7705:b0:a6e:b1f:5e17 with SMTP id a640c23a62f3a-a6e0b1f5e6bmr195540066b.54.1717831935042;
        Sat, 08 Jun 2024 00:32:15 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 00/10, -v4] x86/fpu: Remove thread::fpu
Date: Sat,  8 Jun 2024 09:31:25 +0200
Message-ID: <20240608073134.264210-1-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is one of the dependencies of the fast-headers work,
which aims to reduce header complexity by removing <asm/processor.h>
from the <linux/sched.h> dependency chain, which headers are headers
are fat enough already even if we do not combine them.

To achieve that decoupling, one of the key steps is to not embedd any
C types from <asm/processor.h> into task_struct.

The only architecture that relies on that in a serious fashion is x86,
via the 'struct thread::fpu' variable size structure. The series below
attempts to resolve it by using a calculated fpu context area address
value via the x86_task_fpu() helper. The allocation layout of
task_struct + fpu-save-area doesn't change.

Changes in -v3:

 - Restructure the series to be easier to review
 - Extend the debug checks to all PF_KTHREAD tasks
 - A few cleanups on top

The Git tree can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/fpu

Thanks,

    Ingo

======================>

Ingo Molnar (9):
      x86/fpu: Introduce the x86_task_fpu() helper method
      x86/fpu: Convert task_struct::thread.fpu accesses to use x86_task_fpu()
      x86/fpu: Make task_struct::thread constant size
      x86/fpu: Remove the thread::fpu pointer
      x86/fpu: Push 'fpu' pointer calculation into the fpu__drop() call
      x86/fpu: Make sure x86_task_fpu() doesn't get called for PF_KTHREAD tasks during exit
      x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks
      x86/fpu: Use 'fpstate' variable names consistently
      x86/fpu: Fix stale comment in ex_handler_fprestore()

 arch/x86/include/asm/fpu/api.h   |  2 +-
 arch/x86/include/asm/fpu/sched.h |  4 +-
 arch/x86/include/asm/processor.h | 23 ++++++------
 arch/x86/kernel/fpu/context.h    |  4 +-
 arch/x86/kernel/fpu/core.c       | 80 +++++++++++++++++++++++-----------------
 arch/x86/kernel/fpu/init.c       | 23 +++++++-----
 arch/x86/kernel/fpu/regset.c     | 22 +++++------
 arch/x86/kernel/fpu/signal.c     | 18 ++++-----
 arch/x86/kernel/fpu/xstate.c     | 27 ++++++--------
 arch/x86/kernel/fpu/xstate.h     |  6 +--
 arch/x86/kernel/process.c        |  7 +---
 arch/x86/kernel/signal.c         |  6 +--
 arch/x86/kernel/traps.c          |  2 +-
 arch/x86/math-emu/fpu_aux.c      |  2 +-
 arch/x86/math-emu/fpu_entry.c    |  4 +-
 arch/x86/math-emu/fpu_system.h   |  2 +-
 arch/x86/mm/extable.c            |  2 +-
 include/linux/sched.h            | 13 ++-----
 18 files changed, 126 insertions(+), 121 deletions(-)

