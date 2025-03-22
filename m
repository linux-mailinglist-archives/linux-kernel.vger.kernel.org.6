Return-Path: <linux-kernel+bounces-572148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EFEA6C75E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 04:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B079B466F26
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F25E80604;
	Sat, 22 Mar 2025 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGfLRWgl"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380E2E630
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742613649; cv=none; b=O0Op2lg0i9ESxBX0seYTgeK68hhjX4i6kvAxAyFXxyrIvbCcm+ULsZqErGtGLiV50Ar+h/HbQIc3/MQMZK6UQu5wVMGMOIZnM37WZrBAvG7Izas3aOPkDCI9Lf6jD0ygmK7CI1KOJmNyvEa5q/RW4k2IDjJuTg55kTR0EyH40jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742613649; c=relaxed/simple;
	bh=qk0UOeEthKzKwyFC1aqRwkMaMPiiUFnae/ukvrvILL4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HzUiNp7PQf0tYZAVXeFvnOXRHUi5Oq4jekAbwfy/Y+qUiaAabP2CdREAx/bxw5/lPQZ/Jmpb97jw+wXZhhIEwtMVCUv0HYIGCHdTn2Wi4YN/QhXgDL3OM2DC/uB96pNWRnsDOVJPBMwpp1U4J9ifGHY8uUIem/1+hi+ykLn5A0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGfLRWgl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso3722681a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742613648; x=1743218448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTPWXTU4WZTCTwq9wC/iKQlj6UfK/fbRfxPhJz+SZoM=;
        b=aGfLRWglE0Vpwvhk5KMS8XTAZ/9/+e/DH8RE/kKJZy8Ce4mmDJbvHwN4a3kJMWAnp8
         u/FmQoT/HX+GPwT0V8/QX0w4BqydGId5dd8Ns5ukaVgZPm1PH94RJu2EM9A5YgxFCpVN
         9qnhdedX7RsZCZluQUbXLOEShddQtr56T8J+fU+eekpQd1C/IO78C5WjaBgzuMN8YgD5
         AsXv9/IHnhK0slXnm0xZ09QalKZf0GoKWkhH/1372Bewd9u3jwR4309iRltq6CLukUIW
         tvvoMOmd+heVXaMjxrHsO0c89h4v1u6W9yayMjZU0oJFDnfIaxXgk+AIcS0Ej/FAM1Jh
         zu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742613648; x=1743218448;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTPWXTU4WZTCTwq9wC/iKQlj6UfK/fbRfxPhJz+SZoM=;
        b=ky8+vD2yARqLtddMB1UTxv22ZBXKyAiWFxnxpl0fIx8zZkoLYIiIAJ5N1AHCmvK6PC
         QjHyMmVF0Y3zdhwUCJNHO/rkc9OkOn1iUi9C4Edgt9git5h0n/K2cuAmWtR3raABSGAt
         W4IXt/shKP2G6s3XS7tAwLJ1aR8Iy56ZEReiYvd+vwLWUOmMoSQtPVlb/9IBmaZsh8kK
         6iPtHCw4eiFzgLiDq4CtdLJKTBeTi4x6rtX4RYVZjpGfQC/c/MhGGBob2pYcUDOfqlNv
         sZoxg2aHylNAqSMSIo/VNR/fs+QAkyXlVR6NVy/LFSuV2HV7pIt49UiM4tQEvkExrXZE
         oqqg==
X-Gm-Message-State: AOJu0YyqQ3DbP7p0SfDNEawA+Dpn13jncB9ddQonbtK/9XnY6sytSbJ4
	kfpnK3f4BaxiLWw2ymALFpa4tnwNCRAx5F2Fb25mNa8BFw5TFTVANh8D7ZJqRx3WfrkuBOJbZBe
	XoYWja4XZwuEgUQ6/kGA+jlYH2Ecax3bz
X-Gm-Gg: ASbGncs3ljM9DmnQa4vDrNc3WzoRRLgaL2LyI4a1f82HQtFgHZhrNaJgUUZpuokWGKy
	boqO2l83xDKKMMJ1MzqQAhqCZMDGe0u7Qc5joAKU1QH28Fpt9aIZDJnPVt5/PjWZ0TDD5dL1xTB
	WLt0YpI4Uz+sLN9J3Cik89o//5bKtt
X-Google-Smtp-Source: AGHT+IFfnjtNam/LY6TFm5/GU/fwnrf5tYKht+oVi1Xq7kvfi6yfjD2djAwwYbLRPMs0E1oL9zi8WICPliINmreZ75E=
X-Received: by 2002:a17:90b:48c2:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-3030fe83954mr11239419a91.12.1742613647502; Fri, 21 Mar 2025
 20:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: richard clark <richard.xnu.clark@gmail.com>
Date: Sat, 22 Mar 2025 11:20:36 +0800
X-Gm-Features: AQ5f1JpL8Yar2IU1nh9obKfbQ7efjzog02pd34QJZZvlxserP8sIJW65IMDaLis
Message-ID: <CAJNi4rPaPeVWzBve6Toi8hhrxP6GROAGRug7+c3zg1crDeOt7Q@mail.gmail.com>
Subject: hrtimer precision issue/question??
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

With diff below under the 'cyclictest -a 0 -t 1 -m -p99' trigger from
the arm64-based linux box, the interval is 1000us and the arch_timer
in the system is: arch_timer: cp15 timer(s) running at 31.25MHz
(phys).  1tick = 32ns for the arch timer, I am not sure if those
durations less than 1000us are expected?

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 11c704bfd4fb..691d1fe6e944 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2036,14 +2036,25 @@ int nanosleep_copyout(struct restart_block
*restart, struct timespec64 *ts)
 static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum
hrtimer_mode mode)
 {
        struct restart_block *restart;
+       ktime_t t0, t1;
+       int c0, c1;
+       bool hit = !strncmp(current->comm, "cyclictest", 10);

        do {
+               if (hit) {
+                       c0 = smp_processor_id();
+                       t0 = ktime_get();
+               }
                set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
                hrtimer_sleeper_start_expires(t, mode);

                if (likely(t->task))
                        schedule();
-
+               if (hit) {
+                       t1 = ktime_get();
+                       c1 = smp_processor_id();
+                       pr_info("[%2d-%2d]t0=%lld,t1=%lld,d=%lld
us\n", c0, c1, t0, t1, ktime_to_us(ktime_sub(t1, t0)));
+               }
                hrtimer_cancel(&t->timer);
                mode = HRTIMER_MODE_ABS;

Part of the real output:
[  165.555795] [ 0- 0]t0=165550399226,t1=165551394303,d=995 us
[  165.556802] [ 0- 0]t0=165551398751,t1=165552400997,d=1002 us
[  165.557797] [ 0- 0]t0=165552415141,t1=165553396106,d=980 us
[  165.558794] [ 0- 0]t0=165553402090,t1=165554394160,d=992 us
[  165.559794] [ 0- 0]t0=165554398832,t1=165555393941,d=995 us
[  165.559995] [ 6- 5]t0=165545533151,t1=165555594519,d=10061 us
[  165.560802] [ 0- 0]t0=165555398485,t1=165556400795,d=1002 us
[  165.561796] [ 0- 0]t0=165556415259,t1=165557395457,d=980 us
[  165.562794] [ 0- 0]t0=165557401601,t1=165558394086,d=992 us
[  165.563794] [ 0- 0]t0=165558398694,t1=165559393996,d=995 us
[  165.564802] [ 0- 0]t0=165559398188,t1=165560400785,d=1002 us
[  165.565796] [ 0- 0]t0=165560414673,t1=165561395671,d=980 us
[  165.566794] [ 0- 0]t0=165561402327,t1=165562394108,d=991 us
[  165.567794] [ 0- 0]t0=165562399068,t1=165563393890,d=994 us
[  165.568802] [ 0- 0]t0=165563399362,t1=165564401640,d=1002 us
[  165.569796] [ 0- 0]t0=165564413640,t1=165565395885,d=982 us
[  165.570104] [ 5- 6]t0=165555639767,t1=165565703087,d=10063 us
[  165.570795] [ 0- 0]t0=165565401421,t1=165566394739,d=993 us
[  165.571794] [ 0- 0]t0=165566400531,t1=165567393816,d=993 us
[  165.572799] [ 0- 0]t0=165567399800,t1=165568398270,d=998 us
[  165.573798] [ 0- 0]t0=165568412702,t1=165569398115,d=985 us
[  165.574794] [ 0- 0]t0=165569404451,t1=165570394249,d=989 us
[  165.575794] [ 0- 0]t0=165570399145,t1=165571393838,d=994 us
[  165.576801] [ 0- 0]t0=165571398606,t1=165572400276,d=1001 us
[  165.577796] [ 0- 0]t0=165572414260,t1=165573395417,d=981 us
[  165.578794] [ 0- 0]t0=165573401561,t1=165574394015,d=992 us
[  165.579794] [ 0- 0]t0=165574398975,t1=165575393957,d=994 us
[  165.580208] [ 6- 5]t0=165565749263,t1=165575807879,d=10058 us
[  165.580801] [ 0- 0]t0=165575398405,t1=165576399978,d=1001 us

Thanks

