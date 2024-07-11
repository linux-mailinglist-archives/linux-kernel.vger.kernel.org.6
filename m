Return-Path: <linux-kernel+bounces-249581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6156692ED87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9269A1C21130
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777EF16E897;
	Thu, 11 Jul 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjepNAzB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776416E884
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717880; cv=none; b=rIR8UUpZQjPZSSFSrZoEjtRjaWsr4SkX7ATDCiOvWyK8yTgg/I4Is6JfaKvV0NFzM71TlnR/zXZSyhQ0xDyLHxLi5prxetbZCHvRaOOGCIDIeMcYqIqYZsHNB6QcE3rx7j4vgDrdg/Suf/ws1w4HhU/u0ueSTb/9dpxUhakoFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717880; c=relaxed/simple;
	bh=ybLm2Mh70JkPHjadaTUG9Ccy0wH8e2FzaoJ7biYYUkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCoBMVW7OT5+zNVKGe0pJmhXnCIUzqQ4g5OhOQAvbXGJvWBspNUtM6IYqfZSr42WVowjUSYUWIG73yB5efqCDGK7VU1BCWZKhEiK5qbd69XWCkgR1h7C43UdzuCmwShd7E1YJft+kJMF60G1ScQ7BvIHPGsMh98TQ5pdXA1fjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjepNAzB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fbd1c26f65so6909415ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720717878; x=1721322678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U5JA9G9Mz2ca7U7rdAg2xh6eWn3oK/tMDxHq4OtzSQ=;
        b=PjepNAzBSzHLHECXtdHvQW7e7TmHUuwxHAw2h9CLgUz2Cs0EJPt9hsh0MIQKOg6Nvi
         8ZXVoDtpXXAqDJh5AtG3/9SljYoJj7Q4nq6k3RNkr1pDqk7aKzlidN7/8YIVWVCy7jF+
         iL6uZxiCAbmrBDMApRofPkSP+WE2VEeBSdeHMv6O7rC991xbxT3RmP6t/qEY6gvTL3Ai
         UzcK2CItc6UO6s4KQib5AbB7omygIX8Ujmm8QrEYSeovdhbkL1ZZfAiybGJ6qFS9i6o0
         3YRoJxRf+RE8Stw9IwQ8FqANLYUURLz/XyA2VQep/pITYzWGxS1wl0H2RUB6xMHNALak
         vEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720717878; x=1721322678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+U5JA9G9Mz2ca7U7rdAg2xh6eWn3oK/tMDxHq4OtzSQ=;
        b=mAplqcsWwnwy4Zsbbarbs4xIX1mAwr2Ak4z/vLch3msXgaiuBoZF2V0c0owPMCrK1+
         7TObgfC8RfD16nsHwVBECTzXqOhT9NH+yN1Gy9UvuqwKjdJup+WuQiPqf2Nd0ycBVjGw
         hfK3+7RmRv6GyQSvy9u3XUmudYvjYk/+IvjLXVzntBklXfSuS3iEczqG0Q8I++fBBaEq
         BvrwUcivAPMOQia/+dE2Bezk97hpbYapAsqeaOH0JxIFotL4n7w3vd6hU7DvylCtlAtI
         2AAD3jYbiOxJgzt9nXWtFzgpjJmHUeJJY0Lor6nDj1JHxdcPfAfoGywzyqEqgfV7LzMF
         Ee2A==
X-Gm-Message-State: AOJu0YxUwBG8FH7jJ6l5s1qRb88dEBjz6GF8xLBLtuP9UQF9oaos33Vp
	5qWa//tiaAQ+zFgbDGhDQvfX+V57+RkBBVO8idGHcR92F+3cSQTc8+4u+Q==
X-Google-Smtp-Source: AGHT+IFMzCoBx2mN8vTQXJjkXtYTXsrtv4x1hfDH0LeV56k9hcTslD18I+Z6ZhXt4MLgxOtE/roNBg==
X-Received: by 2002:a17:902:d2c4:b0:1fa:12b4:587c with SMTP id d9443c01a7336-1fbb6ef53a0mr76745295ad.56.1720717878013;
        Thu, 11 Jul 2024 10:11:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab8026sm53038075ad.179.2024.07.11.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 10:11:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 07:11:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH UPDATED 3/7] workqueue: Remove cpus_read_lock() from
 apply_wqattrs_lock()
Message-ID: <ZpASNBN0hpTVcjE-@slm.duckdns.org>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
 <20240711083547.3981-4-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711083547.3981-4-jiangshanlai@gmail.com>

From 49d94fbe1f8c275c793e298e8a38278e90029cf6 Mon Sep 17 00:00:00 2001
From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Date: Thu, 11 Jul 2024 16:35:43 +0800
Subject: [PATCH] workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()

1726a1713590 ("workqueue: Put PWQ allocation and WQ enlistment in the same
lock C.S.") led to the following possible deadlock:

  WARNING: possible recursive locking detected
  6.10.0-rc5-00004-g1d4c6111406c #1 Not tainted
   --------------------------------------------
   swapper/0/1 is trying to acquire lock:
   c27760f4 (cpu_hotplug_lock){++++}-{0:0}, at: alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730)

   but task is already holding lock:
   c27760f4 (cpu_hotplug_lock){++++}-{0:0}, at: padata_alloc (kernel/padata.c:1007)
   ...
   stack backtrace:
   ...
   cpus_read_lock (include/linux/percpu-rwsem.h:53 kernel/cpu.c:488)
   alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730)
   padata_alloc (kernel/padata.c:1007 (discriminator 1))
   pcrypt_init_padata (crypto/pcrypt.c:327 (discriminator 1))
   pcrypt_init (crypto/pcrypt.c:353)
   do_one_initcall (init/main.c:1267)
   do_initcalls (init/main.c:1328 (discriminator 1) init/main.c:1345 (discriminator 1))
   kernel_init_freeable (init/main.c:1364)
   kernel_init (init/main.c:1469)
   ret_from_fork (arch/x86/kernel/process.c:153)
   ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
   entry_INT80_32 (arch/x86/entry/entry_32.S:944)

This is caused by pcrypt allocating a workqueue while holding
cpus_read_lock(), so workqueue code can't do it again as that can lead to
deadlocks if down_write starts after the first down_read.

The pwq creations and installations have been reworked based on
wq_online_cpumask rather than cpu_online_mask making cpus_read_lock() is
unneeded during wqattrs changes. Fix the deadlock by removing
cpus_read_lock() from apply_wqattrs_lock().

tj: Updated changelog.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Fixes: 1726a1713590 ("workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.")
Link: http://lkml.kernel.org/r/202407081521.83b627c1-lkp@intel.com
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a345a72395e7..9b7c1fcd934b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5113,15 +5113,12 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
 
 static void apply_wqattrs_lock(void)
 {
-	/* CPUs should stay stable across pwq creations and installations */
-	cpus_read_lock();
 	mutex_lock(&wq_pool_mutex);
 }
 
 static void apply_wqattrs_unlock(void)
 {
 	mutex_unlock(&wq_pool_mutex);
-	cpus_read_unlock();
 }
 
 /**
-- 
2.45.2


