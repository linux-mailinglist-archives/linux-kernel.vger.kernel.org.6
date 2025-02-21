Return-Path: <linux-kernel+bounces-525377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A0A3EF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2619C262C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD43201260;
	Fri, 21 Feb 2025 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh++8gj1"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6D2010F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128127; cv=none; b=n+k5UKopQbW/l43lPwbLMV8pi9Elof79u2SP/ztWuT2H3TXMIH1NRkaF9ywDabH89i6YOfs1hNGtIYlPdRgNfGWxYA8A2T9wpI7UlDtClzjU3Zvt9vMtbrdLLG0ib3EaVsEg15cj6GLIlvq9jEgyP1ohPIJHURnUmObPFgrdODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128127; c=relaxed/simple;
	bh=WYmZxiWZQBd1PtixBUM98h2J3Yz2UWp4UMCy6spo09M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIwIsG/r9yJdDM5G1C0xnzK5Yg2q15oO98mHl7enkEok5wqHaTnfvMmZgloL+RvF0aBgOhxJqSrNVkrK3V42bUPRcKwUwmjZG38gB1QDEFn0qgoXY5JHUoJ2Ziw96sQtdTRmcxn6dlsRcNo2abXFy5utn4VI0zSubE48b9We8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh++8gj1; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2fcce9bb0ecso3551311a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740128125; x=1740732925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvT1k2l3XeU5pNdodIBtmwWFocycPmhl++sLb9X13Tw=;
        b=Xh++8gj1tzsrIrwJbxaE/Dhnz6X4X5F400L/7VjuitVG3fTetBi7TcKFkZuLcXuw4N
         0KurNDedwkBl+QtVPue3bHru1u2N5Ut8b4h+9g/EZJLeozLSR3KlLyFestiVsXmloMvU
         faRy+08nWdMdr8ALzQK0QtqgfL/oCiy2B4wr33nhHzdCOUQp/4xEdpYB/bao/cjTnak/
         ibkMflg1gHg/1Fgwdl9oU8mrdBwSonEBJC7znRBvGEe4voHk3RNqzDoXM6EPMdoN+uek
         nUyq8EvdEIdauLZCz5s1FhtsBOrTtNhA+G5sePYVzkFPtPAHNIkhsAsFy7y0mcPmYvFq
         z8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740128125; x=1740732925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvT1k2l3XeU5pNdodIBtmwWFocycPmhl++sLb9X13Tw=;
        b=Le97pTpMPmdNPFaLh861FW3wCHEGXYvVqK71xgWm7q5LPjpleP/a4l7CxnDXxzkfdO
         YtgSSWiYfrHfsG6xhyYcQ2LNVAwQpo8glKvJv3qwCmOI7uhUrpUxs1TQM5YLmmt9Rcs8
         5dALTyNexsksnt++irfhDb+xDcaxXrWNGDiHc9NRvsXxMtgQKT03+nX/0aG92lqPovXl
         fWtiRRw4YFmYNZqpjNFJ+ZxolWwQAfaZo/3QTXJ6jXLuNcXTS3AF4bMWq3bJkL1Hb/ID
         2sRLksOzDQzJt0v1lIYcuc9uOfJQy2jgcZZmIjeoJWjgJnvTYzWIF44Ji2MEC4FtccEb
         ruFw==
X-Forwarded-Encrypted: i=1; AJvYcCUZpY/Dlg2vGW6YnXHAHnoRXJz4CnTSp/ixOGk2jqYCsny3i3wTTUDfcnvOp3Tw5iqXu1cwFJh+feDAz64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjxKDhLnAjXJvnlNvKMzj2gnSRc8fVhUcQiPMCc8c5iH+xS61
	FxxGBvq/VlGe5gOCaRJWXZzAcVIfxJ7BHfw/+ysyueSRaUos969B
X-Gm-Gg: ASbGncuYQi9ne9OlODttnUgQ5LeRo2foqKvI7sOEWSfMQGHekMy1+Nu1Nrr/zcJRGnN
	XGqT3CyLNYRM3ZE8ELy4XoTuQO3MB7mmzJqBdj5f4+Wx3nsQ0mf4QBRqMFbfrsMDH5AbcxHwDlo
	MiksEP11e07mMiW9BQqNSS4LFypmIFeU9p3r6O7jLTJ0D3e9kzavMLSBcwvKWJVQ+nJzuc2vU2h
	I8qMEbLZwkmHw2OczrlA1zm4clAFxH9A4fRCL+cT97jtkm+r/v6Y1Lz6sxtWRthjcjU9IZ7cOvt
	nJxOjKiaBNiomy2MBSuYlVfyIqwC2LCqcTKZaZB3hHHb8IfJgbmhpYw=
X-Google-Smtp-Source: AGHT+IFRpVxTVgjd+8RI+imhhtpHxKuk4io0KAj1jJiRLbU6ibi/GTmV38YfY/EgtQn7N8+vpTNnvg==
X-Received: by 2002:a17:90b:2e4f:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2fce78a5047mr4586929a91.9.1740128125390;
        Fri, 21 Feb 2025 00:55:25 -0800 (PST)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe2d:0:2:6253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb04b0c2sm816950a91.14.2025.02.21.00.55.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 00:55:24 -0800 (PST)
From: zihan zhou <15645113830zzh@gmail.com>
To: 15645113830zzh@gmail.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: [PATCH V1 3/4] sched: add debug for predict load
Date: Fri, 21 Feb 2025 16:55:08 +0800
Message-Id: <20250221085507.33329-1-15645113830zzh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250221084437.31284-1-15645113830zzh@gmail.com>
References: <20250221084437.31284-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can see the debugging information about load prediction from
/proc/$pid/predict_load (task se) and /sys/kernel/debug/sched/debug
(group se)

An example:
[root@test sched]# cat /proc/1/predict_load 
se.pldp->predict_correct_count               :                 7699 
se.pldp->predict_count                       :                 7820
se.pldp->no_predict_count                    :                  263
enqueue_load_normalized: 0, dequeue_load_normalized: 0, confidence:255
enqueue_load_normalized: 16, dequeue_load_normalized: 16, confidence:42
enqueue_load_normalized: 32, dequeue_load_normalized: 32, confidence:14
enqueue_load_normalized: 48, dequeue_load_normalized: 48, confidence:5 
enqueue_load_normalized: 64, dequeue_load_normalized: 64, confidence:8 
enqueue_load_normalized: 80, dequeue_load_normalized: 80, confidence:9 
enqueue_load_normalized: 96, dequeue_load_normalized: 96, confidence:3 
enqueue_load_normalized: 112, dequeue_load_normalized: 128, confidence:2 

/sys/kernel/debug/sched/debug only have predict_count.

Signed-off-by: zihan zhou <15645113830zzh@gmail.com>
---
 fs/proc/base.c              | 39 +++++++++++++++++++++++++++++++++++++
 include/linux/sched/debug.h |  5 +++++
 kernel/sched/debug.c        | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..e66173ce941b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1541,6 +1541,39 @@ static const struct file_operations proc_pid_sched_operations = {
 
 #endif
 
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD_DEBUG
+
+static int predict_load_show(struct seq_file *m, void *v)
+{
+	struct inode *inode = m->private;
+	struct pid_namespace *ns = proc_pid_ns(inode->i_sb);
+	struct task_struct *p;
+
+	p = get_proc_task(inode);
+	if (!p)
+		return -ESRCH;
+	proc_predict_load_show_task(p, ns, m);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static int predict_load_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, predict_load_show, inode);
+}
+
+static const struct file_operations proc_pid_predict_load_operations = {
+	.open		= predict_load_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif
+
 #ifdef CONFIG_SCHED_AUTOGROUP
 /*
  * Print out autogroup related information:
@@ -3334,6 +3367,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_SCHED_DEBUG
 	REG("sched",      S_IRUGO|S_IWUSR, proc_pid_sched_operations),
 #endif
+#ifdef CONFIG_SCHED_PREDICT_LOAD_DEBUG
+	REG("predict_load",      S_IRUGO, proc_pid_predict_load_operations),
+#endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
 #endif
@@ -3684,6 +3720,9 @@ static const struct pid_entry tid_base_stuff[] = {
 	ONE("limits",	 S_IRUGO, proc_pid_limits),
 #ifdef CONFIG_SCHED_DEBUG
 	REG("sched",     S_IRUGO|S_IWUSR, proc_pid_sched_operations),
+#endif
+#ifdef CONFIG_SCHED_PREDICT_LOAD_DEBUG
+	REG("predict_load",      S_IRUGO, proc_pid_predict_load_operations),
 #endif
 	NOD("comm",      S_IFREG|S_IRUGO|S_IWUSR,
 			 &proc_tid_comm_inode_operations,
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index b5035afa2396..5b2bab60afae 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -40,6 +40,11 @@ struct seq_file;
 extern void proc_sched_show_task(struct task_struct *p,
 				 struct pid_namespace *ns, struct seq_file *m);
 extern void proc_sched_set_task(struct task_struct *p);
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD_DEBUG
+extern void proc_predict_load_show_task(struct task_struct *p,
+					struct pid_namespace *ns, struct seq_file *m);
+#endif
 #endif
 
 /* Attach to any functions which should be ignored in wchan output. */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..619b96333f6a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -690,6 +690,12 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	P(se->avg.runnable_avg);
 #endif
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD_DEBUG
+	P(se->pldp->predict_correct_count);
+	P(se->pldp->predict_count);
+	P(se->pldp->no_predict_count);
+#endif
+
 #undef PN_SCHEDSTAT
 #undef PN
 #undef P_SCHEDSTAT
@@ -1160,6 +1166,39 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 #endif
 }
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD_DEBUG
+
+void proc_predict_load_show_task(struct task_struct *p, struct pid_namespace *ns,
+						  struct seq_file *m)
+{
+	struct predict_load_data *pldp = p->se.pldp;
+
+	if (pldp == NULL)
+		return;
+	struct record_load *rla = pldp->record_load_array;
+
+	unsigned long index, enqueue_load_normalized, dequeue_load_normalized, confidence;
+
+	P(se.pldp->predict_correct_count);
+	P(se.pldp->predict_count);
+	P(se.pldp->no_predict_count);
+
+
+	for (index = 0; index < (PREDICT_LOAD_MAX >> LOAD_GRAN_SHIFT); index++) {
+		enqueue_load_normalized = index << LOAD_GRAN_SHIFT;
+		dequeue_load_normalized = rla[index].load_after_offset << LOAD_GRAN_SHIFT;
+		confidence = rla[index].confidence;
+		if (confidence) {
+			SEQ_printf(m, "enqueue_load_normalized: %ld, ", enqueue_load_normalized);
+			SEQ_printf(m, "dequeue_load_normalized: %ld, ", dequeue_load_normalized);
+			SEQ_printf(m, "confidence:%ld\n", confidence);
+		}
+	}
+
+}
+
+#endif
+
 void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 						  struct seq_file *m)
 {
-- 
2.33.0


