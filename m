Return-Path: <linux-kernel+bounces-431982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A069C9E436E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA18281E03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AD1A8F83;
	Wed,  4 Dec 2024 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WkZpB7lI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584717E010
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337042; cv=none; b=MnfCyziUnPnpWej4biJ4SuWcCKsXckVfPpqNQwieqsHjBzytR+u9v2S0szWydiOhDkLQ+tQ6tjOOdqGvqRmAuLPP+6g6EXY8LJrsB4SPRprZMfiVR25kct1Z0IXSHUAvuitVmoKRm2u6V5CH+VjmlsgU9QZMFTkQ0wjGykXtRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337042; c=relaxed/simple;
	bh=nojpG4c1beIpZhf4bvivZiXALWDMVCjD1bi2Z20bOYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=msbMLkXrgCT0t2A71FM+T12z+rS7cHo/B9J2rWvBhctFsaP5h1xd1ZBVm68hRYB7gGKNFUvQN33thoMGelc3sTfdWdnnF21VjnL0xEI7QbjBI3mem65BVIwzTwksihdM5thabgljHJyDVVvYt7TjuP4/OaORuwJ9rpVTgckHzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WkZpB7lI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a45f05feso1181615e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1733337038; x=1733941838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2R/rtBiTMeXkad/LAKBxDDqxrSG652bI00BQUuuZU=;
        b=WkZpB7lImq5KtcFpf9Oz/AxgYnOmvbumGosGyOQ4/chXg52BmIc4nI4Q25UrDDK0bX
         rBhz/vJq7zJbmlcJHJ96aCspntPIhxnwRXmq6E5LM1mIiq4DkS55GTSLqbPniywOPwB2
         QCIzYo3YbSXg6mDC0xrEGVlSG25Xri+k7SO8jWAZUoB9st47DRGybP8JhO3jhcx9Vgpx
         o1a2z0/Vh51I7q1Z1UK5LlIdEPr+sOluqwztHPID4RAfTirFeGb5AwCc47WT+CRNLm2y
         a3EtJoBURv2teyFf0YtzSNdSoknLa9p4etPJuiYCVpsWwad11Ga6poQV+gwauPDvn+sd
         vGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733337038; x=1733941838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c2R/rtBiTMeXkad/LAKBxDDqxrSG652bI00BQUuuZU=;
        b=L4dYESEd5IP9lz5F30PmQQuyuE7Nv3Mr1b5aF53ZNTmy06Lsu898UdcpD69Z5I6l09
         lQ8YarYJDY3H4MlxfuiSUN9/ZMVuCuU9m5EodEFxrYhfjYEwdggzqQOMDSIeSXpUNcNO
         e8v1123lctOfUFQ6KzVQpqQR/JC6S5u6NNKrCb98FWZ+QqbEZJ2O2Vd3P/lsOZRgAH81
         bLLb/cRVmctos8GDVCJsoFk77IIt1gshk6YmtFXHKXDvxS5BJfSJSvG+d9Jqy5MidvnE
         DCUHz8r3bMAe8ZhqeQBtn/uGnraFJfFU/owX1ajrj5GnfpKswW20TNM72yIDxZo+TO1T
         E8Uw==
X-Gm-Message-State: AOJu0Yyh+lA/8yLGZcfxkgJccJ+m2mMO126Na7wJsi8ofzlOURCEy2Ar
	QJE4LaxZN32rDqEVXQk69K9L4k3aq3wqQNn6nZ4O5mYj0/Xzayhb8X7BaCLyH1U=
X-Gm-Gg: ASbGncsghc57nNaJzUI1wYZW+HautYdqlgZ0xJhuj5Zt4JbEVEeXKo+qTP2c0sbM336
	P9TZa9lVwGctXwgRdCdBEMoTJHn3qJ53coB8d+pzRdU2eufUuju5Pe5hmH8cRt7HmGqcwLFofGa
	LGa8BEIxNtAhgxwWe9WuNqnsokLRCYHDfqsw3vwlYLrLRLBGN9nQyTs7wVOEC3CGc/JedkmlFmi
	Fk3PEFHtlBgQ5WvRqn+EFYZ7MnomLSPxqNiqbk44uw=
X-Google-Smtp-Source: AGHT+IFu12LYNC/Tx/9klPxHSPQBN9yUlRrYTOt5CkHJCzoKsicqwGPJeTwNeO94pltwtaAxw7Samw==
X-Received: by 2002:a05:600c:4511:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-434d0a284f2mr58025425e9.28.1733337038406;
        Wed, 04 Dec 2024 10:30:38 -0800 (PST)
Received: from DW927H4LGF.lan ([2a09:bac5:37e5:ebe::178:1c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm32199055e9.13.2024.12.04.10.30.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Dec 2024 10:30:38 -0800 (PST)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	oxana@cloudflare.com,
	kernel-team@cloudflare.com
Subject: [PATCH] hung_task: add task->flags, blocked by coredump to log
Date: Wed,  4 Dec 2024 18:29:53 +0000
Message-Id: <20241204182953.10854-1-oxana@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the processes which are terminated abnormally the kernel can provide 
a coredump if enabled. When the coredump is performed, the process and 
all its threads are put into the D state 
(TASK_UNINTERRUPTIBLE | TASK_FREEZABLE). 

On the other hand, we have kernel thread khungtaskd which monitors the 
processes in the D state. If the task stuck in the D state more than 
kernel.hung_task_timeout_secs, the hung_task alert appears in the kernel 
log.

The higher memory usage of a process, the longer it takes to create 
coredump, the longer tasks are in the D state. We have hung_task alerts 
for the processes with memory usage above 10Gb. Although, our 
kernel.hung_task_timeout_secs is 10 sec when the default is 120 sec.

Adding additional information to the log that the task is blocked by 
coredump will help with monitoring. Another approach might be to 
completely filter out alerts for such tasks, but in that case we would 
lose transparency about what is putting pressure on some system 
resources, e.g. we saw an increase in I/O when coredump occurs due its 
writing to disk.

Additionally, it would be helpful to have task_struct->flags in the log 
from the function sched_show_task(). Currently it prints 
task_struct->thread_info->flags, this seems misleading as the line 
starts with "task:xxxx".

Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
---
 kernel/hung_task.c  | 2 ++
 kernel/sched/core.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index c18717189..953169893 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -147,6 +147,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
                        print_tainted(), init_utsname()->release,
                        (int)strcspn(init_utsname()->version, " "),
                        init_utsname()->version);
+               if (t->flags & PF_POSTCOREDUMP)
+                       pr_err("      Blocked by coredump.\n");
                pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
                        " disables this message.\n");
                sched_show_task(t);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a..7f3dd4528 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7701,9 +7701,9 @@ void sched_show_task(struct task_struct *p)
        if (pid_alive(p))
                ppid = task_pid_nr(rcu_dereference(p->real_parent));
        rcu_read_unlock();
-       pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d flags:0x%08lx\n",
+       pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_flags:0x%08lx flags:0x%08lx\n",
                free, task_pid_nr(p), task_tgid_nr(p),
-               ppid, read_task_thread_flags(p));
+               ppid, p->flags, read_task_thread_flags(p));

        print_worker_info(KERN_INFO, p);
        print_stop_info(KERN_INFO, p);
-- 
2.39.5


