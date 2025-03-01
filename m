Return-Path: <linux-kernel+bounces-539645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D7BA4A6D9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976F6168017
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64DC258A;
	Sat,  1 Mar 2025 00:06:16 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1ADA29
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787576; cv=none; b=X5P/QatljE6YeKidr8fziGXx0StDAcinzI7GdQ+E8p5jxqSLh0lMtDnL7Bt5XcpsU4oQSlIjUyiKK2bASn7UV5wN/jjC4Me4E6QeGTOrxwNMmorwPYv3nJ45cBKCzetiSAPv/Hri0IkqICcqAvzXba13xASfprom8aoY1qKe4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787576; c=relaxed/simple;
	bh=iChraW5fYfz879cdDEMbtaFKsKKiIW3d14zkBazhG2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGY0mxU8uBtDKlIh2q5XG+MQzrlXTaQrlU6gKKTQlp2b1iEJy7SiPC+sWoY3DYNeNJlHn3jdzdERjJEKnCPNVFXd8B+lv6FcemOS5VKmVMbvk8YDIkDoTNDDf+V/XbCOsSoM+Ps7bTLmHBdb91a+S4LjonA0slbfKZsFl/WEaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.41])
	by sina.com (10.185.250.24) with ESMTP
	id 67C24F65000030E2; Sat, 1 Mar 2025 08:06:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 39645810748436
X-SMAIL-UIID: 862E2A4533524B34A0C26AD31574A6FF-20250301-080600-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+aef8e425f1a85ee5ef1c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in task_work_run
Date: Sat,  1 Mar 2025 08:05:51 +0800
Message-ID: <20250301000552.2827-1-hdanton@sina.com>
In-Reply-To: <67c099eb.050a0220.222324.026a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 08:59:23 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    63817c771194 selftests/bpf: Test struct_ops program with _..
> git tree:       bpf-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d306e4580000

#syz test

--- x/kernel/events/core.c
+++ y/kernel/events/core.c
@@ -5368,6 +5368,7 @@ static void _free_event(struct perf_even
 
 	exclusive_event_destroy(event);
 	module_put(event->pmu->module);
+	perf_pending_task_sync(event);
 
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
--

