Return-Path: <linux-kernel+bounces-343906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5B98A120
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9440AB26628
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAF18CBF7;
	Mon, 30 Sep 2024 11:48:16 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF421E87B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696896; cv=none; b=c2GM2Z9RyFR+m58Dt++E4i0dC4jETVMUefoqA4QkQl3n1mhpj/9Uy792vgKgjmgT7mZjbre3KIsu+0yCpwJq/Ymld7xYxTKmvC8KBGroFSmRWUGq4NuuAOhSW0JUGWh7GiaoxUSzyvm7Y924lBsChYU1u/kGK3q+z8LjtzAs2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696896; c=relaxed/simple;
	bh=1lUpS0c60kl6kJP156hD3i7uTR3mqFNHLISOlaZeBPk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GfpoytrdUflO2Uz1UIQK+lqY7FkWiSPim3q+jmILDWg0FFdz0sFpuay1XmB6ID46sHFQjwB+//z7fixjKeZZ3ure4isxZGHGbxWrZ6C2zY2x5pgH2Tjdmp8SszPWstFXOZ89XzOAGQaVm83Uy6piJpU2cpgh3xa6xN4RHbxw9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa499f938so394923639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 04:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696894; x=1728301694;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlXt2Tddg+NN24BKvRqdbtpbBKqBkjjYRKckFBM/rOU=;
        b=p1SByhbgX9paeEXePbGl0gEBX5jTzZUqrlYnlcUe5j9cCsD1K9sW2rIwcNKl3Klv5E
         JZNbj7UiUiuEhhUIgz5G7nRHpx2pwQqBVk9riDx8GhqZ0FHUW7oRTK2g4Gk1g4MwN/qQ
         0DeNmo2GjaiT1s/JmpOjTe4Y+KA5vNsQ1bDKDQt25jROBWdHPHgpF9VQywNc1alU8sX9
         HEB3N5ck7/gZ8KSPv1XRtrgIaQYlcUtAO0VVibkVySYnX9eaunI4ayOo/sdsyglR8V6N
         pKn20zBQVkG1FEdhGUs2mIDuLnB8k+X0NfGAe5seXBOoeNsFhQeCgpcnGinm12iGjN8b
         XyiA==
X-Gm-Message-State: AOJu0YyDEaumB0VW42CmF/WXWPs3CWhrLdP4s0iJaBhHK9XGk8+BEjgj
	mDqwMQafkKg+Yc30XQ5xwiluqYGxItkB6FPPi4jZTWcTig9PrpmeT0NC353od0A8rpo2EN1ps3X
	tkkL6EAx2fEZPTfC7U1TKk7fXw8fep3M26YF8ywVeFCkABznY1CmGbqU=
X-Google-Smtp-Source: AGHT+IGuimoVP1NOKh4Fp3uvF6Ro+6qZ5WXcrfPxxFRSnHDKjQuPREsdpH8Gx18ruNJnou0UXJ7opOCimJvsdrf1LguYKCl9zLcV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:3a0:9238:d3c with SMTP id
 e9e14a558f8ab-3a3445ec927mr79396825ab.3.1727696894191; Mon, 30 Sep 2024
 04:48:14 -0700 (PDT)
Date: Mon, 30 Sep 2024 04:48:14 -0700
In-Reply-To: <000000000000c848d3060cd1d16a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa8ffe.050a0220.aab67.0031.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
From: syzbot <syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
Author: dmantipov@yandex.ru

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux 75078ba2b38a38d94017bd334f71aaed205e30a4

From 5450d2cda2e81d3fd79526e1efb76578472851fb Mon Sep 17 00:00:00 2001
From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Mon, 30 Sep 2024 13:25:01 +0300
Subject: [PATCH v6 1/2] net: sched: fix use-after-free in taprio_change()

In 'taprio_change()', 'admin' pointer may become dangling due to sched
switch / removal caused by 'advance_sched()', and critical section
protected by 'q->current_entry_lock' is too small to prevent from such
a scenario (which causes use-after-free detected by KASAN). Fix this
by prefer 'rcu_replace_pointer()' over 'rcu_assign_pointer()' to update
'admin' immediately before an attempt to schedule freeing.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v6: adjust to match recent changes
v5: unchanged since v4 but resend due to series change
v4: adjust subject to target net tree
v3: unchanged since v2
v2: unchanged since v1
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8498d0606b24..9f4e004cdb8b 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1965,7 +1965,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 
 		taprio_start_sched(sch, start, new_admin);
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 
-- 
2.46.2


