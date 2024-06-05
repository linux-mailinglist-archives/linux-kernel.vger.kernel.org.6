Return-Path: <linux-kernel+bounces-202014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29848FC6A5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404491F2495D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EDB1946BA;
	Wed,  5 Jun 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTutUWFX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839704962C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576579; cv=none; b=VzbjaQ9i+474uYNFJe2K6PfFCvAtOwHJEnp0rk3dnS19WbIce9zkluVXA3DzkhBq3RyQ/BDzUzUpKhS1u6gpUEZA2vQK/eOeoBT3kFB1jbkSIg3Wy84rHWc4IywugDM8gg3gawskEKS0ozWK70y7c+w3yIV3S22xZ0acUDxuw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576579; c=relaxed/simple;
	bh=muohkQHM4xGVqaMFOC4b3LZBXk6gCJb0TTTyktpFYFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvMMfgBmEN3brRx5Fth8HavIN0vyANQ4t45ANjKpJ+bALuXjGszFjGuFMU+6HC6gIePHhjG0mR04oXqNEyk1IO+2rq/RjKu6YuK48kxxHkCV/XchOOCWDePjKAAcQTmA1iL0CwKYMTsKyN0jEjM+xWnr5bsCljOxT9nWWZbhDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTutUWFX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso2917015e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717576576; x=1718181376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=74218/qTlQX5R13IzjLgr2DOxfv8K30mXmcKDFS7i+o=;
        b=cTutUWFXBOoXO08SV3iZI6rcqzY5hG0zYNzq4ARdxqo6suLp16S0QYp7D5kwIjU2Wz
         Sma/GmH/aP49AOR+m9LR0Vi/jOko5AUTRNxLIke+XN14O48PT86Egwf6DvSnsh1QeS7v
         WIYXVw6D7APO0hex7qr+jCwf/OJGG3jZlSqdmJq39q/qjCUK6MmMfb/Dp3J0HOk+zecD
         STqGTYLb6WjC6jCT9i7fl+74flEqaaDGr7DhMs7B2MrvIsAjGw/xzSCG+ajSPmHY9/Ov
         5jJfSpI2ogGzkIKBT/mLyQs3ZMsuq4R6MJJQEXybTnrO73Yn6mdt4lEbGCZfJPCmm+9I
         IJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576576; x=1718181376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74218/qTlQX5R13IzjLgr2DOxfv8K30mXmcKDFS7i+o=;
        b=LtIu3GT530vZTOKgnV+uwBXzd8CkIzxzfSPwu/Span2qUKVnJO+1ZW4W2PKlHS6ZKP
         6mZDZNBcJv0km0OgPz26L/YhaK8wjIPGOyY3bAFDfikIO8EvXuxG7I6rsZa7ur6DHELv
         UgtPYpVBRLfGVfo9xxw2lqQCD7iTj1/QEhNZ1oFpkd9D3G7soJ9PHM3Fn8/Qy0XzScYZ
         M9gwQg8lYEDqwf4YTAk75HypVdYe8eiGSrg8np1ehgLaxyXY6ZuA3ywS+8N2g1xwBabK
         /k9AUmiu3xk3AKpvwT8tq0TucNXMsLTPw+jqIbIUb7CItYz8Px+qCwOmBVuVjsK7o5Lo
         lHPg==
X-Gm-Message-State: AOJu0YyJokVJNuaeoaXFqedz0sTs4/aP76tNQbdkZIVJGTOPrULMbFbS
	IS4K3WxHOq1jAcSuMqWj+IJlPneBcc6g4uo/7BzkXkklr5I1Zmx2QvClQLlX
X-Google-Smtp-Source: AGHT+IG07th/gojxw6KZAyaItF2AJx1hysTGqzHVTJ/6Q9zucdsggjvd3hTpqHOKYVgTdchNzOKlQA==
X-Received: by 2002:a05:6512:6c7:b0:52b:7c3a:423e with SMTP id 2adb3069b0e04-52bab4d470dmr1325612e87.20.1717576575327;
        Wed, 05 Jun 2024 01:36:15 -0700 (PDT)
Received: from kepler.. (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b3eaeb69sm611933766b.92.2024.06.05.01.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:36:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 0/3, v3] x86/fpu: Remove the thread::fpu pointer
Date: Wed,  5 Jun 2024 10:35:54 +0200
Message-ID: <20240605083557.2051480-1-mingo@kernel.org>
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
via 'struct thread::fpu', and the series below attempts to resolve it
by using a calculated &task->thread.fpu value via the x86_task_fpu()
helper.

Code generation: without CONFIG_X86_DEBUG_FPU=y we get a small reduction:

   text        data        bss        dec         hex        filename
   26475783    10439082    1740804    38655669    24dd6b5    vmlinux.before
   26475601    10435146    1740804    38651551    24dc69f    vmlinux.after

With the new debug code - which I think we'll remove soon-ish, there's an
expected increase:

   text        data        bss        dec         hex        filename
   26476198    10439286    1740804    38656288    24dd920    vmlinux.CONFIG_X86_DEBUG_FPU.before
   26477000    10435458    1740804    38653262    24dcd4e    vmlinux.CONFIG_X86_DEBUG_FPU.after

The Git tree can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/fpu

Thanks,

    Ingo

===============>
Ingo Molnar (3):
  x86/fpu: Make task_struct::thread constant size
  x86/fpu: Remove the thread::fpu pointer
  x86/fpu: Remove init_task FPU state dependencies, add debugging warning

 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/processor.h | 19 ++++++++++---------
 arch/x86/kernel/fpu/context.h    |  4 ++--
 arch/x86/kernel/fpu/core.c       | 57 +++++++++++++++++++++++++++++++--------------------------
 arch/x86/kernel/fpu/init.c       | 23 +++++++++++++----------
 arch/x86/kernel/fpu/regset.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/signal.c     | 18 +++++++++---------
 arch/x86/kernel/fpu/xstate.c     | 23 ++++++++++-------------
 arch/x86/kernel/fpu/xstate.h     |  6 +++---
 arch/x86/kernel/process.c        |  6 ++----
 arch/x86/kernel/signal.c         |  6 +++---
 arch/x86/kernel/traps.c          |  2 +-
 arch/x86/math-emu/fpu_aux.c      |  2 +-
 arch/x86/math-emu/fpu_entry.c    |  4 ++--
 arch/x86/math-emu/fpu_system.h   |  2 +-
 arch/x86/mm/extable.c            |  2 +-
 include/linux/sched.h            | 13 +++----------
 17 files changed, 104 insertions(+), 107 deletions(-)

-- 
2.43.0


