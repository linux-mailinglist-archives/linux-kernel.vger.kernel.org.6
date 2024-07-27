Return-Path: <linux-kernel+bounces-263947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1AB93DD04
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3CA1C2227C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB21FA1;
	Sat, 27 Jul 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="e3v9DHdd"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D715BB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722046402; cv=none; b=PqhR7SweRh1H796JpfBkk0Anjd/5tcQ3HNqpzuadY/Yrdk1nQE1F7qnyqIfpX4dTzfrRv167Iuy+gyjpPsAhdf6wo31stDLIHlV+9N47kq20TND69OZ1kTQcrXang0cXEnTlYYt5uWTHlJt/7ATfophvCGeT9tie4K3d0FIChC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722046402; c=relaxed/simple;
	bh=wEE3KKRF5KdmT21NgICOuk2eCzT7AGUZk6K06BAa0iA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hA5w2rq2x4PUCliq12BAn8Bwlpzqhq0mZCIksDjl4pn9QqQOh1mDlP2m2/dll2+cTWX7OTZDhPLyz1J5Bonaea63iYbOj7C8nVuox8+XhfKvQilNirUgj6nCHOuut3RJqECYvsQjgZdWDuVAPB20C4R/L6272p+HkEKPg+oKO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=e3v9DHdd; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722046098; bh=NR6gWVG9Sg6CKvElz/M5UqHb/XcudCPVakxUrk+/l9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e3v9DHddVq3zkfV9pL6atWr74PaAmY24SK6CyxuXbl+LYjxCgqSpesixR5atrrZ5y
	 f25066Kwe1HiLOQReGcZ92bqA/qnc/x8t3m1s8V3AR7/hvPIpp9CpaoJOWqcXov5hs
	 vwaaRwcV52i0NxFWgRRzVquKBZJ2OrV+9Tlw1iRI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 2101C6DF; Sat, 27 Jul 2024 10:08:16 +0800
X-QQ-mid: xmsmtpt1722046096tgu0podq0
Message-ID: <tencent_250DFF9261DD82DDDA19784F898D9625D107@qq.com>
X-QQ-XMAILINFO: MdoRYM9mYrydHHQCVZdW4A3o7Zk6uP2K1XScDEco4gA81+zCI9yf+ukbtpQ9PR
	 iImuEeuyEAxEFgVqS8Fv1MLOmgJcf/lMgUROkg4k7Z0b8SDS/bM2vHsCtRbYj6CRU/50Wk0JvZBs
	 uRozWPyf4rYVX333fTBDg210+SgpEZfkP2/4fdLyzn6PSUIKCq4ozLmv84wfFszNP3HvPz9WzMgM
	 bqRVZJgHyU6Gw1aAKQHMKgBaju3BUcO08plXzuaD4E/KEVD+89yuK2IZb0BpEmqkQ1x8ur6tM08L
	 qQKK850nX6Qy0eHModfdi94HS+mhIVKQHdSyP6aEprvF3fqi1C5bMtfOSwR57586eaPuIrbZgoFl
	 NKaO/vWaUAASHYmZWMXdDnfUMk9mT8IPC4DzeVYSeGhKKUqJv2iuc6MPa03zwA6qp3vEVpAagjZR
	 Yv23J7iYXR5IrzwcVHHswd++zg2OYRHLr4Qi2FZmkzyo3hc+2IbtRLVJFgNSReHjAHL4Jak0GTLQ
	 8gm73A+So09dZFrAJirucSRUaPR1k2mI1tObmJUDMVBDXoCTJp20DNgkK8h403K/tKrbu+80nKGH
	 rXIttT2LrSIYgHUJWVYU1pqmTl1EYArp69vGJkZbB5MVn11GfR4oZC5BUVJkasARRrVaQCOuNhcK
	 9iPVJOP5y0ItexIBXkv4vqPHlBqRTmj6xs7qwGQevxdQ8+vqTUmOHSaXmSA3n5EeT/o+9mWkcAOj
	 duAjFmN4eMZvWTxfhJfYbg5eWE9eXiuMI5tFkDi54cX7ngvarhWlOzJruefRmT4+PzTO3nmsLE4k
	 GJi+klZxyiBTD1I55HKVbjer+Wpi8AU1789HDsHGe91KQPYCiWy54+6lmBBdMBoOjcdFDmwgy0V8
	 zU/6QtEz8a0igSHJoHwKGWzuevsqFrDSCfdudKvaRdj6NV+NBfvW+Jk4lQ30xqYS/yfONqEAy8Ec
	 WxiPMcS+w=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
Date: Sat, 27 Jul 2024 10:08:16 +0800
X-OQ-MSGID: <20240727020815.2493999-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
References: <0000000000005c7ccb061e032b9b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add mutex sync remount and shutdown

#syz test: upstream 2c9b3512402e

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6066c6eecf41..1f4542a899c3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -27,6 +27,7 @@ static struct kmem_cache *victim_entry_slab;
 
 static unsigned int count_bits(const unsigned long *addr,
 				unsigned int offset, unsigned int len);
+static DEFINE_MUTEX(gc_lock);
 
 static int gc_thread_func(void *data)
 {
@@ -203,10 +204,13 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th;
 
-	if (!gc_th)
+	guard(mutex)(&gc_lock);
+	gc_th = sbi->gc_thread;
+	if (gc_th < PAGE_OFFSET)
 		return;
+
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);


