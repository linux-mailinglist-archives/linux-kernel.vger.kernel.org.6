Return-Path: <linux-kernel+bounces-252878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF193193A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EF42810E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371524655F;
	Mon, 15 Jul 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqF2HgsW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040974D8A7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064407; cv=none; b=TI/PaHkxRCsqL14KakS/VfoXlCR61QBd2mpjFMTGyGpx6c5f4c0iI3UF+2pXIHIakHy2TuDaU/A37UFAb41NZX54jq9AEcU2lsSKV6fsGHduE1peZPKfo3TuHboOQqA13PKv46w12ljZ5dJalViatSY01LvbnegH7XtGro4Tg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064407; c=relaxed/simple;
	bh=NKxhwcfKDV25J44ZjKN7Tw5TRTnUWcgDczWR7UFp7x0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TgAxMcsBU3HJGpHNgVglF/2NuZFgtIXUkaHQq9HLtJycIiAzn5yaxQuWNlihZdQvqMJemVGSBBbMCEd4VIigDvt4M+6Jq3vGcUZGWrwJPz+VENCIFDjvI4RrcZ1OfUfQI4Xt1X4tXoROljjNxyKcalTzG4xBliUqGX79LaItEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqF2HgsW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b04cb28acso3608683b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721064405; x=1721669205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V1EnqQQEEDfCVcyM5SF8HmtSrMGhEDyTnp8EsRJkHyA=;
        b=TqF2HgsW9Q9fFUe39KpxsHX0yUagqR4AGqELrmMftkl1uNuRc5nSTsKJ4LR7xoccJX
         UUnFUDW2Ue92QUavvaNw7OwQ16cYjhBdhp1eZLb2E94BSUIhp7uiBmviY1XqqnEYrGqn
         U7Tw/mO/bsvzCom2fE4ncE2hzAzfcYMS/uyNMJpuD+woGmvsMJTP52yvWV2QGcsJyRXi
         aQv8EBYdIOxAhCiuhX5Ocgou4BIW+qwglsHS8UfvqnSqMDrBHWZyX4/wiLgw7GcAWgg4
         dtX3IhV2qdkFprcBTt62ZoaOC3vVnBkAxh9Y9y+FoO/Fy2xjXB5u5oKdA5wjg+hf8Yu+
         nxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721064405; x=1721669205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1EnqQQEEDfCVcyM5SF8HmtSrMGhEDyTnp8EsRJkHyA=;
        b=slNQF1e87gMs8F71mK9KAMfB/cMNHr1tKMnm/SXrG2BMX846DXMycDd2vsUJMQctvw
         uTp7Jhi653Sm9xzl1QbF5GZXsqyyd4nw656xM+N0SSrhLkfLVQsSC49ioQDKazLejISA
         iYl8iHKzsuvCZrA+hrEuOUaH9r158GJRDfP15Cr7F0AZsgr2y1EMMsf2eSIz8Hs4KRIN
         2/4Pga3TwJLWxvuwfqlapYr5mAKde1z0vx5J9SWtJgZi7A+dsDCcSXr5xyXSIFXfCYt5
         0Wy2/VxivnIlqLen/6QyI/AJt1gdOEDfSMRbOGCR7ox8SodgGvJM75it6YwioVrTHtam
         csmQ==
X-Gm-Message-State: AOJu0YwuA1zBmWbCuGJBZe8G8lfmtcfRfcCmiUX1+FwJ5HiWjjf3l4+V
	k/rDT23giYBKLHeh1GprvSsDmuwrQyjcg23VXJ1ivzYk3DgGNTYm+83pWg==
X-Google-Smtp-Source: AGHT+IHCB9TJ+QUMrd1iZYojPPMgLhcDXl4AohOnA6YUFX4i9YhE7XQzXA17MREZ/k1DPYE3ODpmVw==
X-Received: by 2002:a05:6a00:6904:b0:70a:fa24:65ed with SMTP id d2e1a72fcca58-70b6c883445mr12973477b3a.4.1721064404707;
        Mon, 15 Jul 2024 10:26:44 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb6ad3sm4627002b3a.63.2024.07.15.10.26.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2024 10:26:44 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	kernel test robot <oliver.sang@intel.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Remove unneeded lockdep_assert_cpus_held()
Date: Tue, 16 Jul 2024 01:29:31 +0800
Message-Id: <20240715172931.2260-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The commit 19af45757383 ("workqueue: Remove cpus_read_lock() from
apply_wqattrs_lock()") removes the unneed cpus_read_lock() after the pwq
creations and installations have been reworked based on wq_online_cpumask
rather than cpu_online_mask making cpus_read_lock() is unneeded during
wqattrs changes.

But it desn't remove the lockdep_assert_cpus_held() checks during wqattrs
changes, which leads to complaints from lockdep reported by kernel test
robot:

[   15.726567][  T131] ------------[ cut here ]------------
[ 15.728117][ T131] WARNING: CPU: 1 PID: 131 at kernel/cpu.c:525 lockdep_assert_cpus_held (kernel/cpu.c:525)
[   15.731191][  T131] Modules linked in: floppy(+) parport_pc(+) parport qemu_fw_cfg rtc_cmos
[   15.733423][  T131] CPU: 1 PID: 131 Comm: systemd-udevd Tainted: G                T  6.10.0-rc2-00254-g19af45757383 #1 df6f039f42e8818bf9a534449362ebad1aad32e2
[   15.737011][  T131] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 15.739760][ T131] EIP: lockdep_assert_cpus_held (kernel/cpu.c:525)
[ 15.741326][ T131] Code: 97 c2 03 72 20 83 3d f4 73 97 c2 00 74 17 55 89 e5 b8 fc bd 4d c2 ba ff ff ff ff e8 e4 57 d1 00 85 c0 74 06 5d 31 c0 31 d2 c3 <0f> 0b eb f6 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5 b8

Fix it by removing the unneeded lockdep_assert_cpus_held().
Also remove the unneed cpus_read_lock() from wq_affn_dfl_set().

Cc: kernel test robot <oliver.sang@intel.com>
Fixes: 19af45757383("workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407141846.665c0446-lkp@intel.com
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cd6f2950ef6c..177b09ba61e2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5332,8 +5332,6 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
  *
  * Performs GFP_KERNEL allocations.
  *
- * Assumes caller has CPU hotplug read exclusion, i.e. cpus_read_lock().
- *
  * Return: 0 on success and -errno on failure.
  */
 int apply_workqueue_attrs(struct workqueue_struct *wq,
@@ -5341,8 +5339,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 {
 	int ret;
 
-	lockdep_assert_cpus_held();
-
 	mutex_lock(&wq_pool_mutex);
 	ret = apply_workqueue_attrs_locked(wq, attrs);
 	mutex_unlock(&wq_pool_mutex);
@@ -5424,7 +5420,6 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	bool highpri = wq->flags & WQ_HIGHPRI;
 	int cpu, ret;
 
-	lockdep_assert_cpus_held();
 	lockdep_assert_held(&wq_pool_mutex);
 
 	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
@@ -5681,8 +5676,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/*
 	 * wq_pool_mutex protects the workqueues list, allocations of PWQs,
-	 * and the global freeze state.  alloc_and_link_pwqs() also requires
-	 * cpus_read_lock() for PWQs' affinities.
+	 * and the global freeze state.
 	 */
 	apply_wqattrs_lock();
 
@@ -6850,8 +6844,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
  * @exclude_cpumask: the cpumask to be excluded from wq_unbound_cpumask
  *
  * This function can be called from cpuset code to provide a set of isolated
- * CPUs that should be excluded from wq_unbound_cpumask. The caller must hold
- * either cpus_read_lock or cpus_write_lock.
+ * CPUs that should be excluded from wq_unbound_cpumask.
  */
 int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
 {
@@ -6861,7 +6854,6 @@ int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
 	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
-	lockdep_assert_cpus_held();
 	mutex_lock(&wq_pool_mutex);
 
 	/*
@@ -6906,7 +6898,6 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
 	if (affn == WQ_AFFN_DFL)
 		return -EINVAL;
 
-	cpus_read_lock();
 	mutex_lock(&wq_pool_mutex);
 
 	wq_affn_dfl = affn;
@@ -6917,7 +6908,6 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
 	}
 
 	mutex_unlock(&wq_pool_mutex);
-	cpus_read_unlock();
 
 	return 0;
 }
-- 
2.19.1.6.gb485710b


