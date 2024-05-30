Return-Path: <linux-kernel+bounces-195355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767F8D4B77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656D01C20CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B899B1C9EB7;
	Thu, 30 May 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsnGuFHP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49B16F0C1
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071867; cv=none; b=iFYlp6Xs5XE9++lCX8v2I0odq0xLkfsww46NH88w4760aLn6io8x0O0RbGawmKei0MJbZiUKjSOaWZQH2Fi4GUbRM7Vt/9nqDxeY/8xuUuYsXANisj6ykVSyfOBeNsEUipyleNw9RHzqBIxxA4c2I8qC8pzx4uGxtj2ouIde3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071867; c=relaxed/simple;
	bh=fq9tWX8EVrYYwkxAY6ecyjUvx+GGMcChLe/JfqCswhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9/gr7rrN+j408V860BIfBmKxabIm8fi3JkuTUwlpevqy2Up3Ora9WuLUI7VUcWmWvoKZeqdGwbLUNE07+ugazIYXtd+8EM1TFZ2/Hhc9PsOS8ZCjFBjAUd3x7gr/lmRDr0sgFzmQ7y2+dh+HPNoHHpTerbZQh16NVcOGLiJPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsnGuFHP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f44b59f8daso5199425ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717071864; x=1717676664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+enHyvCDfrlV8I1SIAZtQt+FfqmLa2z6v5AbXG0cKe0=;
        b=nsnGuFHPRCw2D5W3xF9H2DnY/22pBuhD/n/x0YmnBbww9n+G5Dj1z8DxoEv9Yaxa/H
         bLIeRNmW9pedahl1Zlfvgn79RATbufqClmFjubHeIBj4K4v+7/JLsNORtPcAn2LlzZLs
         yHC/ZE7tL/tjYf4K/EAhJr8Yj4GAcnUE3oF1lrLMS0SeHPLgIB2+6oFVB474mFzou8JL
         U0Qirygo6We31lXL822/hY6KRYT+kLJK0Y2XmUK7HmryAjNuWIqw+CilwupTtLttUl51
         mR8XCHwaa0MDIi+0dKmNXeoLFhJqE5tujnmQmsCEyUxUiGtezs7NgIC4b1jl3NEItDBz
         W4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071864; x=1717676664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+enHyvCDfrlV8I1SIAZtQt+FfqmLa2z6v5AbXG0cKe0=;
        b=YcffIsQSyv9DcBT6ZbhJpD16dVeck9pdar1ZNblHd66Iu7KlDV1QFkDEQtb0wAZIP/
         9eeTLB487R4WD+moTxMVec98EPzR9iBFPczK39xoszNd+sW3k178pKh0AOeSiGSf89Q+
         gxVdPDvw/brE8K4DabEQEMHhmA3qrOM20PKf0gmbZPdaBlQ3zisx72OVf4iLRrzZuMri
         YAj5M3eNP0nb9Uj84Q9VBufHXzIYPpLMqXk4Xtd1ayj/wBtNM/k0zpu0UCPK3ilWjSay
         1KPfK8nty70GewA5r0s1431joBY/i8sDyeXMV/L74qeAyVhCpDsXMlk6lR8uEZ3EMmOa
         1vNg==
X-Forwarded-Encrypted: i=1; AJvYcCXufUCgqewrXcQ6IgBmTXLOPlfyZlCh4MUhCZlskaAkOnP7P2bBniSGjNx1mUULOkb0YUD6slYpdLlLL7zEL1gJSF683+JuCezbKuIP
X-Gm-Message-State: AOJu0YzsaNwrg9er1p7fA6E6htwztbwQOO3LObluisWiTwK3CiEkPuyh
	crUGQtp7vB8Sc9I5UnwNhmI+K19p3fICoBy+TKREJqUB5vSITTN9YntGEDvn
X-Google-Smtp-Source: AGHT+IE27hpQJnu5HozOnXkSqQgeUEPPUiJOKE+eiuvVvXCTwo4dPZFBSiH+s2HJ8JlM8feprFaelA==
X-Received: by 2002:a17:902:d490:b0:1f4:4631:d6a3 with SMTP id d9443c01a7336-1f61983a885mr19991425ad.42.1717071863973;
        Thu, 30 May 2024 05:24:23 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.28])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f44c558ccdsm120548185ad.0.2024.05.30.05.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:24:23 -0700 (PDT)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>
Cc: Cruz Zhao <CruzZhao@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH 0/2] nohz idle time accounting cleanup
Date: Thu, 30 May 2024 08:23:59 -0400
Message-ID: <20240530122401.3826022-1-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear all,

Currently we use is_idle_task(current) check to decide if we need
to call tick_nohz_irq_enter() on irq entry but use idle_cpu() to
decide if we need to call tick_nohz_irq_exit() on irq exit. 
and we rely this pair (which internally calls tick_nohz_stop_idle()
and tick_nohz_start_idle() separately) to do accurate idle time
accounting in most cases.

IIUC, idle_cpu() now is mainly for scheduler and for tick user,
we seem to ask less than what idle_cpu() gives us and the use of
idle_cpu() here only make things complicated which can be proved
by the introduction of sched_core_idle_cpu() for forcing idle
time accounting.

So I make this RFC to do this cleanup and make things simple again
here and it should introduce no functional changes.

Reviews welcome and please let me know if I'm being stupid
or missing something obvious.

Regards,
Ze

--

Ze Gao (2):
  timer: Use is_idle_task() check instead of idle_cpu() on irq exit
  sched/core: Remove sched_core_idle_cpu()

 include/linux/sched.h |  2 --
 kernel/sched/core.c   | 13 -------------
 kernel/softirq.c      |  2 +-
 3 files changed, 1 insertion(+), 16 deletions(-)

-- 
2.41.0


