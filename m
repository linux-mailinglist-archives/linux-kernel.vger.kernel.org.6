Return-Path: <linux-kernel+bounces-273288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B99A29466F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 04:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A2D1C20AEF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 02:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1021078B;
	Sat,  3 Aug 2024 02:43:54 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A269FC01
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722653034; cv=none; b=YscHHaQYOUhgszEUocwphWzVYZr6atqVls6NR6MwKcNlAqtOqN106vey8b//oHjoPkrRMEE2Zbg0LGBI3gyWnuHChn+uW8AHqLA8uCWN0j+r5X6SY/q1+J/MMsUww58FS7UxNNwY2BIltBPElPnNG+8pqaN4dqB86iaqVkedQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722653034; c=relaxed/simple;
	bh=WxPKDSnEHfB3o2okSXonpqJGn79oynwLOW2pf2Uu2nE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEKAUuAGy+JprslUxkZFikGPcezINRAxVT/cyKngjK8X/nT1o/y9pWRuflZTQrkyYaNHobsPp28i/uj0987ffIcP3up7fHzbpzbtnhdtpeUWRLnz8aeXqHxk70MaCuNeHZdS7wnnYg7NL+fCVv0qhrp6IIY5ZlcxfnHP6M/QAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.72])
	by sina.com (10.185.250.23) with ESMTP
	id 66AD9957000071CC; Sat, 3 Aug 2024 10:43:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2420968913403
X-SMAIL-UIID: 65CF14EEC5DC408D9089C8ACDC1238BD-20240803-104338-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs (2)
Date: Sat,  3 Aug 2024 10:43:29 +0800
Message-Id: <20240803024329.2596-1-hdanton@sina.com>
In-Reply-To: <0000000000007fca5d061ea7b850@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 01 Aug 2024 16:39:23 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    931a3b3bccc9 Add linux-next specific files for 20240729
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f437f1980000

Test Tetsuo's idea [1].
[1] https://lore.kernel.org/lkml/5136bcc7-3db7-4fc2-abde-a3aceeaf17c2@I-love.SAKURA.ne.jp/

#syz test linux-next  931a3b3bccc9

--- x/arch/x86/kernel/dumpstack.c
+++ y/arch/x86/kernel/dumpstack.c
@@ -192,6 +192,7 @@ static void show_trace_log_lvl(struct ta
 	int graph_idx = 0;
 	bool partial = false;
 
+	kasan_disable_current();
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
@@ -304,6 +305,7 @@ next:
 		if (stack_name)
 			printk("%s </%s>\n", log_lvl, stack_name);
 	}
+	kasan_enable_current();
 }
 
 void show_stack(struct task_struct *task, unsigned long *sp,
--

