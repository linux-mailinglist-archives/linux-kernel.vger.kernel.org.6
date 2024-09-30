Return-Path: <linux-kernel+bounces-343839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5398A020
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB671C2123D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082B18D627;
	Mon, 30 Sep 2024 11:14:55 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6E189902
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694895; cv=none; b=EtBHU7qWeE4o6QhjS4kGKcXpCnhvLb0pHm51wUhG0Duroa0Ei43mFrQVVos/uIrxG3r3u/1H/iu8Nr8JrKbRR4NP6lmL6UD5/sUbnvPb2UvPGxD03fWnLQ52IxLeWRti+DMJaRVHlgLO6gNne79jtYyN/E43b0G0AgbSdp8a3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694895; c=relaxed/simple;
	bh=Muj4u1jXspjCCD1s0hKhK51KRt9DDCkn/lFDY2vnQ4U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Au4zrPcXzgVaTequzDNgerAR0XZukaCWsgGZud8FPjYwqx48lw6wtXo3OMufffIcZhpWJQq/UTjvmX7bOFYoB9mcncd1D5TB+79i2vn+E/0gV0+yBGafjoFBM7T0JB7OyjpUQ02Q3eAp2WvldVjrbWoplkLVLy2M0XP6BALyZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cf147a566so335289039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 04:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727694893; x=1728299693;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn8u8b4MNSgHRWmASvsbSPMzBxf6cvqbUY4zQ+OWk+w=;
        b=ekJj2zq/fP+NEaWOoKbAaiJ6f9zUI4EWJgkiJ15N+eAURR25H1XDEORW0OgwOW7HC5
         6rayhGkpWDzIVuliKaXwuBBxTUsiyehLfW5w0GpLw/Eec/ioI3fbMrvH1wXHV0YyRwC3
         qZeel0EPdO1hFw8QQDA6I3XLLWx2uTa9xr5ssCWxMqGFhcAG8XmQZn8OgSfrab7Qzovt
         LpCnnuwS5tIE9OMRJvmEjPX8ghMRGi+/PPXK2FJ7bwQP4EfIfCAwhox2KLOimdX2IzfN
         ki2kvbrf79D52GVp0IncnlmaeiNsnY6gkc++gzvVuUwD8t4zX5MKAQs+l/PLNYZFOEZZ
         Ja6w==
X-Gm-Message-State: AOJu0YzY/r+YSj+N+c0BIOj2hplMiUZH+W5/QUsi82u1DQrTrhMzGIdF
	/u/yPqrDu2E75L5WzDOvDI7m7g566NwfL6HlaWTDMqkKkd7ixb29LZDdyeRvaBiW9uHxRW5/+nH
	FSnyX7TRta8nwGtYcmtrROQ3K9sxQ0pa6n1A3u/oadlldX6LXt+K41Uk=
X-Google-Smtp-Source: AGHT+IGRyAFE76oIKij/VUq9Bv+xUQaUhdDtsHKlEHQ0jmBrbg/De03YldRTWeSn8pTwPwrhTNorgCTTQNZ/OsH9am5i7xV43nFP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:3a1:a57a:40a1 with SMTP id
 e9e14a558f8ab-3a34515565emr77321885ab.5.1727694892663; Mon, 30 Sep 2024
 04:14:52 -0700 (PDT)
Date: Mon, 30 Sep 2024 04:14:52 -0700
In-Reply-To: <000000000000c848d3060cd1d16a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa882c.050a0220.aab67.0030.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
From: syzbot <syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
Author: dmantipov@yandex.ru

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git d505d3593b52b6c43507f119572409087416ba28

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


