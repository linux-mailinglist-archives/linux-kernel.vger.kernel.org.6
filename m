Return-Path: <linux-kernel+bounces-275815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA351948A51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A141C230EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB25D16A38B;
	Tue,  6 Aug 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjtWyPL1"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FECC15F3EC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930132; cv=none; b=n9bR7D8CUuHoop1Y6kBQZMKlHQYB4HjmbdBedq2AEV967y9DwVEyo/m5cpJjiznXUoix8yDzEcsxHcbaFeK+F74AtoGRU03DyJaiWeuoDpGqkRbmJLaKGgPxyJEIoZ3y5hcGdrSwrcBIo0CnFiF9YLYTGvVa0Cn6QlCdMORamj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930132; c=relaxed/simple;
	bh=aoilqGsUCLDf1T9anZQ9gON6RuQOHGvUtpUM+dtwg0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YtKWYmCyyZ8qcydkIDWXUU+l7Sn1WixcoZchSeKw57jw9lD6DcsVEN7pOxBC8GtyAX36e4AUUowNzxdLYh77Aou/CkGiUK7Nu5XngloqzTECfrFL9IaPXO+LCbB4DA2wpCMBl9pJLLNRGsmhYbPqh/QBYvdDA5dTfYFnalSg2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjtWyPL1; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fee6435a34so4272555ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722930130; x=1723534930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ePFQQE4duKN313CK1/o5Vgzgzewc5sx0G2Zibc7FTE=;
        b=LjtWyPL1jCVN2fpeh9HhmQ23Ja4bwq71pSSFOXj1F4APs2G/uACN88CKEneP9Z7wSz
         pazxhbbPSE4hQiSJUR15EarhusF2dcKL2Tzhj6v1fjPSBFm9NskvtYg8wvrrJzxrq0rE
         TegJeDfJBWfnZu0wMjtOiEErFezNrWbtlesGbbhLbaOwWMjRKWH6WMiGrT28SYJ5fKjG
         B1Tgc6sLrwHw34eLP5aSm049HP9K158YD/Lo3ENQOSrJoq/UmztMp5JrVZ+AsykD9gfB
         Zx09klWP2s981hEW5YZQ4AKXq7EcivT7WHbWZ5wFQYL5mPays69NWIsGtVzjmrShr5T4
         nZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722930130; x=1723534930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ePFQQE4duKN313CK1/o5Vgzgzewc5sx0G2Zibc7FTE=;
        b=Ma2sl7xAqA6cHlGujetK+OIb3lN0f8U6wFaNylsfG8GOEBN2+x8/Q+4zSzLqNuRG8v
         c6RluXDe98E7lsyMGhFeI90diFrP664QXwsGSsdhMSxp0+PDLLxI89Jd+rUcroHGHc3w
         QcN9f4QN3xaSh7rDJzHp+8kOtU+CIs4e4ZdclJ/aOqqeuLuAQAvjankW//mUCZCftieE
         JEdjfkpl3ggAx8LLvTJ3oJrPQiTOem3d9odpkAn+tx7CjhgtKrgY0ghWSz/tmZx3q/V0
         nEltonSF+8HSuuszIv4OCQOJWViwhSaNiIzzl4bRCdpPFFJZBnTMsm1jzxU6+Z49B168
         mklw==
X-Forwarded-Encrypted: i=1; AJvYcCW3uiDxT+KhWI4ZbZKnjCdAEaLa3NfYjaR2mEi30hUQ+9hUsQZDDT0ey0HkaEqBtU5652Khowf4jnujyddCJ7BRtD3Z9w6QPRalxMah
X-Gm-Message-State: AOJu0YzbLb835PCfbaMWiTWfem1zfgVTU9qi7O/Fv9WxJl3GGV+hYb14
	xS3HIXc18m6TjLAD7YM6UfuTcWpCa7Gx6JdvwuTp+5eHeOOMrEqG
X-Google-Smtp-Source: AGHT+IExS+U4CjO7QK99/NX8DkOe1Yfz9E5HnHJt3Pb2tltqwJdv/35PSgyQQuwB7m3tC6EHRk0UbA==
X-Received: by 2002:a17:902:c405:b0:1fa:fc6a:858a with SMTP id d9443c01a7336-1ff57261ba9mr162197585ad.15.1722930129540;
        Tue, 06 Aug 2024 00:42:09 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f57aa2sm81186835ad.68.2024.08.06.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:42:09 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Bin Lai <laib2@chinatelecom.cn>
Subject: [PATCH next] sched: make printk safe when rq lock is held
Date: Tue,  6 Aug 2024 15:41:31 +0800
Message-Id: <20240806074131.36007-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dead lock can happen if we try to use printk(), such as a call of
SCHED_WARN_ON(), during the rq->__lock is held. The printk() will try to
print the message to the console, and the console driver can call
queue_work_on(), which will try to obtain rq->__lock again.

This means that any WARN during the kernel function that hold the
rq->__lock, such as schedule(), sched_ttwu_pending(), etc, can cause dead
lock.

Following is the call trace of the deadlock case that I encounter:

  PID: 0      TASK: ff36bfda010c8000  CPU: 156  COMMAND: "swapper/156"
   #0 crash_nmi_callback+30
   #1 nmi_handle+85
   #2 default_do_nmi+66
   #3 exc_nmi+291
   #4 end_repeat_nmi+22
      [exception RIP: native_queued_spin_lock_slowpath+96]
   #5 native_queued_spin_lock_slowpath+96
   #6 _raw_spin_lock+30
   #7 ttwu_queue+111
   #8 try_to_wake_up+375
   #9 __queue_work+462
  #10 queue_work_on+32
  #11 soft_cursor+420
  #12 bit_cursor+898
  #13 hide_cursor+39
  #14 vt_console_print+995
  #15 call_console_drivers.constprop.0+204
  #16 console_unlock+374
  #17 vprintk_emit+280
  #18 printk+88
  #19 __warn_printk+71
  #20 enqueue_task_fair+1779
  #21 activate_task+102
  #22 ttwu_do_activate+155
  #23 sched_ttwu_pending+177
  #24 flush_smp_call_function_from_idle+42
  #25 do_idle+161
  #26 cpu_startup_entry+25
  #27 secondary_startup_64_no_verify+194

Fix this by using __printk_safe_enter()/__printk_safe_exit() in
rq_pin_lock()/rq_unpin_lock(). Then, printk will defer to print out the
buffers to the console.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Bin Lai <laib2@chinatelecom.cn>
---
 kernel/sched/sched.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..ba06dfdaea55 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1632,6 +1632,7 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
 	rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
 
+	__printk_safe_enter();
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
@@ -1648,6 +1649,7 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
 
+	__printk_safe_exit();
 	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
 
-- 
2.39.2


