Return-Path: <linux-kernel+bounces-258171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA519384AA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E71F213F2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97116132B;
	Sun, 21 Jul 2024 13:16:11 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF81E49F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721567771; cv=none; b=hB4pBA8RPpB6CtR7T+rpPT1GCWLmKtpPVmlaDGnBgBbOzzRLyR/e+vr+CcPGfwe1mxop8b0PAyfAl/02orW72G51lnX1Ah54x2mD2Ad+yIPedmLjvfqJ9aQq45SD8OzilOWqJJUjPNub445khzF93cfOkki324PvONGdX68XJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721567771; c=relaxed/simple;
	bh=CaKoYVXrxQ+9JPAcdKGaqOY52AKDN7sVoCePwisbqmg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oUqpyEA0z3sPjds4oP7CQKQbadgbXgjIf73/EpsAk9CCS2hVUWJmV6uaII/w+R7SJk7Dkd+I2HsE6XRrG4jIrp6zCeDipwzu/jC/x6uvX2VDHzp+WzAeihPWqueqXWraRG3sFML+P3QqGSPTAGufmPTrO0HaPZY9gSFxpTwmuUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so581378739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 06:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721567769; x=1722172569;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fURXluOxv6X6hFtzsft1gPRQ0VYCqvZKzvY0qAYYfYY=;
        b=reHs7jl5qcT+TnkXEAbGOITE4tXe/xkFT7yWdTCuWHg6cprsBHh9ODnfw7XPGIAJP8
         Nnid+zT+AEWURdbvOOY7A9Og7zidSGcewCMYcrlKAYkogccgxDu7FyKj+8Smoufby81H
         PHIPdXEWk8Bw0Q7VEaxXVqC6pwhmD7L6W1zs3r/qPHJBkbYtuWDeByfgqmK/M+B0VNDX
         p+6jvsSTmbHGobxy2R9N/C7EWSQRVWqQQy6EfBBrhY5f6aW+tZKN0pHPVQUi41bXi4/P
         OJE3P/EZJcqTwAlKBStQJKAKKPF0stXPt6KeHLbIsABb3kEJcbH/zFoPBHyzRZwahHd0
         /KXQ==
X-Gm-Message-State: AOJu0YwE5fMibh4uWeDIyXpebAza5xEzXzoxhLsli5tc5esd5oVl4YL+
	2nMD5wLWYKlBGEmY81O5tDXtw7+n9mkQl+BC+ky3y5QWAQGvNja0h0AiBX34lLh7spaWJig1PZA
	jT73EhmTDFIRIK6eg7mPpgRzD2qRspF6gAOUo4TfO+rws/gSBQ3dhrNY=
X-Google-Smtp-Source: AGHT+IFKOV+SuDRZEtJOYbcLgyYEi9Bk1NhlUGUGadaATg3bquknjZU6t0iwSfYkweMXvV8WFZgYHyu5cYxxvP1b/fa+d4b0eVNn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0b:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-398e859c215mr2259185ab.6.1721567769280; Sun, 21 Jul 2024
 06:16:09 -0700 (PDT)
Date: Sun, 21 Jul 2024 06:16:09 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000585625061dc1bb1a@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free
 Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 kernel/bpf/devmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9e0e3b0a18e4..5e2ee97ad09f 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -378,7 +378,9 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	int to_send = cnt;
 	int i;
 
-	if (unlikely(!cnt))
+	printk(KERN_INFO "bq->count = %u\n",cnt);
+
+	if (unlikely(!cnt) || unlikely(cnt) > DEV_MAP_BULK_SIZE)
 		return;
 
 	for (i = 0; i < cnt; i++) {
--

