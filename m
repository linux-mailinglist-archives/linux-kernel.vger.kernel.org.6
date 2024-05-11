Return-Path: <linux-kernel+bounces-176500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469638C30C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01817281D83
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48854BF7;
	Sat, 11 May 2024 11:06:44 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A154278
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715425604; cv=none; b=XS8ufaZ2QXo9SjFNmZ/uXr8nDqgJ0jfeYfNKTgCWIeddoK3zBx96OEDrFq5Bo+gWhkdIhqqCuHv8+NzeyzBGsqdKmhEB/yhb9dVwRn2g/xtcea3PeYaZ1bfBgdSw/SSyeAtsAWHGdKUN/gToBrJ2sfKFElOncOfJiZlRCtdV6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715425604; c=relaxed/simple;
	bh=GrnHtzDmmpOQkvoubtHpC2uVUFQc9kT4JVAnb8NIbNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4mUg0ylhl5v2IN4NX1kiqqvRxsPF0sWLi8Q0UY+kV+V7Fi1DGF3MM5/2HeUb3MWTJK5cg1SA+D70hYaTe8kouxSTOmW2SklkDYxYG540FWOURP5cPaRRAb8t1+Xzdhy50WcQ7upPGsIVE/DDH3LUf+w15OlrqoFpsTPZ+PRLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.48])
	by sina.com (10.75.12.45) with ESMTP
	id 663F512F00009783; Sat, 11 May 2024 19:06:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 72137031457800
X-SMAIL-UIID: 0900A24BEC5546BF91945EE12F452966-20240511-190625-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+afcbef13b9fa6ae41f9a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] INFO: rcu detected stall in handle_softirqs
Date: Sat, 11 May 2024 19:06:14 +0800
Message-Id: <20240511110614.2636-1-hdanton@sina.com>
In-Reply-To: <00000000000086d9cb061828a317@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 May 2024 00:31:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    ee5b455b0ada Merge tag 'slab-for-6.9-rc7-fixes' of git://g..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105fcb4b180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  ee5b455b0ada

--- x/kernel/softirq.c
+++ y/kernel/softirq.c
@@ -517,6 +517,7 @@ static void handle_softirqs(bool ksirqd)
 	bool in_hardirq;
 	__u32 pending;
 	int softirq_bit;
+	unsigned long lt = 0;
 
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
@@ -542,6 +543,7 @@ restart:
 	while ((softirq_bit = ffs(pending))) {
 		unsigned int vec_nr;
 		int prev_count;
+		unsigned long t1, t2;
 
 		h += softirq_bit - 1;
 
@@ -551,7 +553,14 @@ restart:
 		kstat_incr_softirqs_this_cpu(vec_nr);
 
 		trace_softirq_entry(vec_nr);
+		t1 = jiffies;
 		h->action(h);
+		t2 = jiffies;
+		if (t1 + 2 < t2)
+			break;
+		lt += t2 - t1;
+		if (lt > 200)
+			break;
 		trace_softirq_exit(vec_nr);
 		if (unlikely(prev_count != preempt_count())) {
 			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
--

