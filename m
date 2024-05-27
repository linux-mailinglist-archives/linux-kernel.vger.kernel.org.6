Return-Path: <linux-kernel+bounces-190581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2128D0008
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56ADA283929
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0415E5AD;
	Mon, 27 May 2024 12:29:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0915DBC0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812968; cv=none; b=lgu49XOjGx/XBfVv9TPl7CAuUeE/AdbZu11cm88RjcS7zUustW+tL3BGBMFBePdb5dGUiZezXxOMA9QX24LFE3hnlNheYaGpx7RuIx9xenzZV1BSCjQcAKQBZGTtANpKPPAOFG2+O8454dfxqDS8A2J/gVr0ELWVScQYowU4W8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812968; c=relaxed/simple;
	bh=ms9VXN8D1NATqDWtwOpSreufyoC7PyZATKQgJfLKKkU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GWGfhA2SWYqeXmWy218qv3mGd/NCztKQFQUyl7clQLOpgtFcRDnXZXuxGSRN8JsqT9H9OptzmM6YmIi+oL2We43YlxSLgYTa3GqrUwCMMQ0aNiR0xaiXDXKY5mp8Y8Tg4ddVhHgyCR4QVJuIFq5RAJeDWzPUeJ+5wdyM6/Wiiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eac3b73a53so165168239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716812966; x=1717417766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPzW7UX5wznXxQBLpB5LbS3U4R1DB+9hPgb7NPzC2Io=;
        b=uLgby+0+WOSmVFigaRmKMbZGoky+OvSa1llIaOnWdJ6Nqh/jlTOsdJtLbeST8MdLxE
         XlghWjQpyjeZgwyGScmpC1U+05eRDJiybx80+cnrXleqfcXLFPxXz8YHtrs5Tyjg6Voy
         m3J7BswpuEv1iemLZANvHY7mbb8wyd7KCYv8zreeEvGqX3g9vZV5GBa4F/yuAaio1ncX
         4K6mhXG3W44nvch0t6LQQZiWP4Qc2d1uqOM3Q6/aLkEWwWQIZBngdEqDELpGnAz6sfBT
         /J4vndeSLN/oxkcmBk1AzKEU0CnjBTwLbNHPZTFobkOr3ctVn5r3rwyMAz5C6iJvQgWF
         6VEA==
X-Gm-Message-State: AOJu0YzchlwXXf6S/H05Lo5hOLlIBescdAiRg3xW8i5TexpsHVd2HYsm
	tklopFrHqW3opXRvGMu923WIAYWrYgghIVrwxqRs4Wh9C7qFZdwMkffFOqzo8ZLxb9TzbwC6Z6k
	FyeHr0X+m0ibTgH1Wl7qO4FA+tu2asLYr+2Kki9887Aw2tiesk6I3wmk=
X-Google-Smtp-Source: AGHT+IFMuOQbvKl+uejf1nm3Nnf+yfAB8DraI9mE+91WF5Q9V3BwymwmL4ZASQG7nGOeMzp9RYgyuEBd48FcPvsNhtZNjKW5C+13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cd2c:0:b0:48a:37e1:a545 with SMTP id
 8926c6da1cb9f-4b03fccefbamr154311173.6.1716812965144; Mon, 27 May 2024
 05:29:25 -0700 (PDT)
Date: Mon, 27 May 2024 05:29:25 -0700
In-Reply-To: <00000000000089427c0614c18cf4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eef89706196eaad4@google.com>
Subject: Re: [syzbot] Test
From: syzbot <syzbot+c4c6c3dc10cc96bcf723@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test
Author: radoslaw.zielonek@gmail.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 71b1543c83d65af8215d7558d70fc2ecbee77dcf

---
 net/sched/sch_taprio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a0d54b422186..41add4a1d407 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -44,6 +44,8 @@ static struct static_key_false taprio_have_working_mqprio;
 	(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST | TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
 #define TAPRIO_FLAGS_INVALID U32_MAX
 
+#define TAPRIO_MAX_NUM_SCHEDULES_BEFORE_NOW 10
+
 struct sched_entry {
 	/* Durations between this GCL entry and the GCL entry where the
 	 * respective traffic class gate closes
@@ -62,6 +64,8 @@ struct sched_entry {
 	u32 gate_mask;
 	u32 interval;
 	u8 command;
+	/* Used to skip some cycles to prevent other tasks from starving */
+	u8 num_schedules_before_now;
 };
 
 struct sched_gate_list {
@@ -111,6 +115,9 @@ struct __tc_taprio_qopt_offload {
 	struct tc_taprio_qopt_offload offload;
 };
 
+static void setup_txtime(struct taprio_sched *q,
+			 struct sched_gate_list *sched, ktime_t base);
+
 static void taprio_calculate_gate_durations(struct taprio_sched *q,
 					    struct sched_gate_list *sched)
 {
@@ -919,6 +926,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	struct sched_entry *entry, *next;
 	struct Qdisc *sch = q->root;
 	ktime_t end_time;
+	ktime_t basenow;
 	int tc;
 
 	spin_lock(&q->current_entry_lock);
@@ -977,6 +985,23 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	taprio_set_budgets(q, oper, next);
 
 first_run:
+	basenow = ktime_get();
+	if (ktime_before(end_time, basenow))
+	{
+		next->num_schedules_before_now++;
+		if (next->num_schedules_before_now >= TAPRIO_MAX_NUM_SCHEDULES_BEFORE_NOW)
+		{
+			end_time = ktime_add_ns(basenow, oper->cycle_time);
+			next->end_time = end_time;
+			next->num_schedules_before_now = 0;
+			setup_txtime(q, oper, basenow);
+		}
+	}
+	else
+	{
+		next->num_schedules_before_now = 0;
+	}
+
 	rcu_assign_pointer(q->current_entry, next);
 	spin_unlock(&q->current_entry_lock);
 
@@ -1074,6 +1099,7 @@ static int parse_sched_entry(struct taprio_sched *q, struct nlattr *n,
 	}
 
 	entry->index = index;
+	entry->num_schedules_before_now = 0;
 
 	return fill_sched_entry(q, tb, entry, extack);
 }
-- 
2.43.0



