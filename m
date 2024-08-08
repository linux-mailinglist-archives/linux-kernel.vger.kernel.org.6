Return-Path: <linux-kernel+bounces-278753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD8594B452
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D407B22C41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E2120ED;
	Thu,  8 Aug 2024 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhv7BKci"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CE1361
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723078374; cv=none; b=Q9A8J5rxOWfkb5z8iqz7/sjVCAbSUrZOam1CPeDmDnTZ9uHD/xqGHSwYIlDM1mkIKB2myqJyOy7m4OwvR/y3ojx388ZEky1FZ4qskUbOPIVKVSYCGo5c7bqXB/+/cmVnkMOlLpjwNtWmdcL7wyohizm4p+w+iN22ITtj6I/EH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723078374; c=relaxed/simple;
	bh=5JehHqIAMUdAtJDR4lZFH0vcAOlZLtvN89JJgT4TAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NY5eyH4knCAby5/Icgd4q2Ro1qmyEmGX8VC7rO78Z0K00T341O2Zi2Uuk7Lyupoi/Tx/Q8X75nE40HggKg8Qh/XgH/C2IIyvW0ETtQdJJAo2/HI6+ektuEYPLdMVnIHIQo6TMM84S9Sbiushsd+MkV/S6I7am7MQoB3h/Ag503A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fhv7BKci; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70eae5896bcso392481b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723078372; x=1723683172; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kEKdv9GuG1MlaNTO7yle1enYe9ugFoxYkavIcBcl848=;
        b=Fhv7BKciNwfBtUDKCkM0h8V2RcDk8AvzeuVzw8ij2VwACgK0SVRlk8j9HdqcGfwbyz
         4WBLw8xasPWbbm5TStxYejqygGVWDSz2gS2yJWe/oEQcfElpzGHVjNSsyo/z/c/0vElb
         +bmZEpxMq7e2cTbLafmwJB+r3ImAF/9zt7A8hhHLAIzotDWmvpwJcS0ieOuEu9Lm/w5B
         Tda2B9un5MqoaQ9pecvsqdmye1uJ3ZmQCGUH0TKDDALqzQUS+ynUlBSOkFdX5uP6jEH6
         ZZqznts1vxZzbS41+VF2V5Nf7mEtrX5/l6Ga/z0JS7s9L+gIwAFAdSVz/CCKVM1cuqfp
         7TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723078372; x=1723683172;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEKdv9GuG1MlaNTO7yle1enYe9ugFoxYkavIcBcl848=;
        b=TSizb8EuIVm89R0bhHw5+gE0LcD1UuUaggX7IPPpv3zwWnymslhN69LKnXc/M2nH+n
         hwv6BgLYb9xx5foSI3vJJdXRndoPc/1lDwfBvncENrvLSrst6Birr1slxeoH0nDyonIW
         Ln3hqpHb4p5l2BvWzd19E43LxmkZDuh834Isue22yWP9ZKy31POjwb/QiMSHGkszccoO
         Udkxt5XQt6CCOjEu8YcpLszyOdvLV9+RtN/tk6sKKS9zNVOVt/h9XP0OPJI9XdL45Au6
         Bq62Dw3h3o/iWiI3cAQw5fiTbeCFjXxPRzkpv/pFagS0Enja4n594Q2yntIOkOuFpLX+
         84gw==
X-Gm-Message-State: AOJu0YxycgWBYLPt0u75/zRdDjo6lwj6IK3pBjwNEHhlWvGSpGYLwuna
	SnPMl9q/ePpphaUZOk4ervAOgjaGShh4Ic2atETqwKNqnalrRxDr
X-Google-Smtp-Source: AGHT+IG+lzTTwgWyN0MmarcVUKbvUHT/8kqIEqY4Q9ZGj2JI4nTq2Cl1N0D8FIPyb6Y7yoYihkDdlg==
X-Received: by 2002:a05:6a00:66cf:b0:710:4cf5:c570 with SMTP id d2e1a72fcca58-710cab623eamr586652b3a.0.1723078371848;
        Wed, 07 Aug 2024 17:52:51 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763a3c6bdsm7602502a12.43.2024.08.07.17.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:52:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Aug 2024 14:52:50 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12] sched_ext: Improve logging around
 enable/disable
Message-ID: <ZrQW4gqIr_hTgp0z@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sched_ext currently doesn't generate messages when the BPF scheduler is
enabled and disabled unless there are errors. It is useful to have paper
trail. Improve logging around enable/disable:

- Generate info messages on enable and non-error disable.

- Update error exit message formatting so that it's consistent with
  non-error message. Also, prefix ei->msg with the BPF scheduler's name to
  make it clear where the message is coming from.

- Shorten scx_exit_reason() strings for SCX_EXIT_UNREG* for brevity and
  consistency.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Phil Auld <pauld@redhat.com>
---
 kernel/sched/ext.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 60a7eb7d8a9e..eea2fda8e099 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4004,11 +4004,11 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 {
 	switch (kind) {
 	case SCX_EXIT_UNREG:
-		return "Scheduler unregistered from user space";
+		return "unregistered from user space";
 	case SCX_EXIT_UNREG_BPF:
-		return "Scheduler unregistered from BPF";
+		return "unregistered from BPF";
 	case SCX_EXIT_UNREG_KERN:
-		return "Scheduler unregistered from the main kernel";
+		return "unregistered from the main kernel";
 	case SCX_EXIT_SYSRQ:
 		return "disabled by sysrq-S";
 	case SCX_EXIT_ERROR:
@@ -4126,14 +4126,17 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	percpu_up_write(&scx_fork_rwsem);
 
 	if (ei->kind >= SCX_EXIT_ERROR) {
-		printk(KERN_ERR "sched_ext: BPF scheduler \"%s\" errored, disabling\n", scx_ops.name);
+		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
+		       scx_ops.name, ei->reason);
 
-		if (ei->msg[0] == '\0')
-			printk(KERN_ERR "sched_ext: %s\n", ei->reason);
-		else
-			printk(KERN_ERR "sched_ext: %s (%s)\n", ei->reason, ei->msg);
+		if (ei->msg[0] != '\0')
+			printk(KERN_ERR "sched_ext: %s: %s\n",
+			       scx_ops.name, ei->msg);
 
 		stack_trace_print(ei->bt, ei->bt_len, 2);
+	} else {
+		pr_info("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
+			scx_ops.name, ei->reason);
 	}
 
 	if (scx_ops.exit)
@@ -4808,6 +4811,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
 		static_branch_enable(&__scx_switched_all);
 
+	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
+		scx_ops.name, scx_switched_all() ? "" : " (partial)");
 	kobject_uevent(scx_root_kobj, KOBJ_ADD);
 	mutex_unlock(&scx_ops_enable_mutex);
 

