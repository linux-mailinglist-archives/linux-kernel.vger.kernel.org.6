Return-Path: <linux-kernel+bounces-253187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FDB931DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CA4282AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E3380;
	Tue, 16 Jul 2024 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKTVPfwE"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40B136A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088730; cv=none; b=daB1TJu52huhvAOxRE4B2CT73uJBtEydb/Z6eVICp1D6qGChUZ2YZYdw/AGkZjlXf7+F+jK4iq5hntoZUapdZMxFxbPbAapFWZ6Ohjt5JhO0TYzqGeDhVvw7I20eniaYpDH83k4uQm//R29B91N/tIQMV2JOjCerDuLSnC4YxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088730; c=relaxed/simple;
	bh=B2ryOlzjx/9gFMyLNNuW3i9GqBVtqSqvTcCVm1mCkAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cALjR6oo/8JarIS/TGeL/JoIxo2UuCle5w5RlYKjET3A1umCQjQiaCYVI3bXFCvjw3NBu4mRAyT7zEa3bhEHxNd1pH9UTZuxoW3ysfr54FsH4BvKhtB2GWJj/wP9CNYkENLV4u+UtpSAUyQnUfLPSmxmWm0LkpL5ERkAy+7fzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKTVPfwE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b0bc1ef81so3152220b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721088728; x=1721693528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3DTkF60xr21ZQP8ZiR1CX555iGLsD+R63LTSk9Iw8w=;
        b=SKTVPfwEdZfZFK5/EIoBAE5lYHa75BZgVy6RQh8EhwVSEBfyMSnBeRuCGYC7A28out
         PtdZR42rLmDWAYga00MGtpH1CtNfLzsvEJJs9VwiY3C4wVZgGWGI8/wAYsrns6QlFbPS
         CKqELovkuz4Ms2OnYdH3TIgqLfbBgzdMk6BUYLUjHIJm2/q8mrZX+6RxwtWiyNynGRxz
         H2xsJZAkLkLie5UKUtxzY0bSkMZArdMT7VZVwZYG0/wfcoQWPtGI5ZwmMvuXhscR8Ir2
         T7R3wj+N+KIseg8P8qT2jGFb/TWS6z5aAPV36t6vrgZMiJ4QtXcAi6NyoAuY8Gw42uNO
         J21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721088728; x=1721693528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3DTkF60xr21ZQP8ZiR1CX555iGLsD+R63LTSk9Iw8w=;
        b=P3jTQ0WFoGj7KJUFYP4+DziN5i4gi1K18Qixol90JaQqXgjdcybkqgbEywGch5PYeG
         OUfUBCTtnGJaMg6hkoFie73sJGi0GyVPY+qZpf5VaDzFCu+jwIHFzHFcNIrHBY8HZTQ5
         oEmn2Ov8Z+KmoAHDkspeHCl3OscEvRus2/CxI2mY6GuZcXlt2zDNzbpgM0NZVCEa8tg9
         lINzglF6SHQ20X69KydR39PDT9LrVFv3UtdbnhiZVtOROKl/Tv9Szv+XvzVWeaYsiERf
         60pJv9JKIUVsav18FyWOmwHS6thwwgEOO+UxJsrXcwsfmgy8mTHTmxgh7q2rBX/ahRhj
         aEAQ==
X-Gm-Message-State: AOJu0YyckR7IvYR4BALs4wgha3Ln35LtPoYJ7vYd6K9pLqDBQdDavU0I
	mrgo7vKO/IFck2PGMulSCyMe60FsPFhK2vDsScwapHzUUiNW9KtKqbMIlQ==
X-Google-Smtp-Source: AGHT+IGga3D2tJFtJySRGLXmOHUAjSrOsSiB1mTVTXxvc1C+ZgFRmPoGEWyTi8mRkxYGrQFD5DLpCg==
X-Received: by 2002:a05:6a00:2443:b0:70b:30ce:dfdb with SMTP id d2e1a72fcca58-70c2e988180mr836355b3a.24.1721088727933;
        Mon, 15 Jul 2024 17:12:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c916sm4979007b3a.42.2024.07.15.17.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 17:12:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 15 Jul 2024 14:12:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] workqueue: Remove unneeded lockdep_assert_cpus_held()
Message-ID: <ZpW61giPoe_k8mIv@slm.duckdns.org>
References: <20240715172931.2260-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715172931.2260-1-jiangshanlai@gmail.com>

Lai, I dropped the cpus_read_lock/unlock() from wq_affn_dfl_set() and
applied the following patch to fasttrack it as Linus already pulled
for-6.11. Let's do the removal as a separate patch.

Thanks.

From aa8684755a283536bd8ad93141052f47a4faa5a3 Mon Sep 17 00:00:00 2001
From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Date: Tue, 16 Jul 2024 01:29:31 +0800
Subject: [PATCH] workqueue: Remove unneeded lockdep_assert_cpus_held()

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

tj: Dropped the removal of cpus_read_lock/unlock() in wq_affn_dfl_set() to
    keep this patch fix only.

Cc: kernel test robot <oliver.sang@intel.com>
Fixes: 19af45757383("workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407141846.665c0446-lkp@intel.com
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index dfd42c28e404..1745ca788ede 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5342,8 +5342,6 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
  *
  * Performs GFP_KERNEL allocations.
  *
- * Assumes caller has CPU hotplug read exclusion, i.e. cpus_read_lock().
- *
  * Return: 0 on success and -errno on failure.
  */
 int apply_workqueue_attrs(struct workqueue_struct *wq,
@@ -5351,8 +5349,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 {
 	int ret;
 
-	lockdep_assert_cpus_held();
-
 	mutex_lock(&wq_pool_mutex);
 	ret = apply_workqueue_attrs_locked(wq, attrs);
 	mutex_unlock(&wq_pool_mutex);
@@ -5434,7 +5430,6 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	bool highpri = wq->flags & WQ_HIGHPRI;
 	int cpu, ret;
 
-	lockdep_assert_cpus_held();
 	lockdep_assert_held(&wq_pool_mutex);
 
 	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
@@ -5695,8 +5690,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/*
 	 * wq_pool_mutex protects the workqueues list, allocations of PWQs,
-	 * and the global freeze state.  alloc_and_link_pwqs() also requires
-	 * cpus_read_lock() for PWQs' affinities.
+	 * and the global freeze state.
 	 */
 	apply_wqattrs_lock();
 
@@ -6862,8 +6856,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
  * @exclude_cpumask: the cpumask to be excluded from wq_unbound_cpumask
  *
  * This function can be called from cpuset code to provide a set of isolated
- * CPUs that should be excluded from wq_unbound_cpumask. The caller must hold
- * either cpus_read_lock or cpus_write_lock.
+ * CPUs that should be excluded from wq_unbound_cpumask.
  */
 int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
 {
@@ -6873,7 +6866,6 @@ int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
 	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
-	lockdep_assert_cpus_held();
 	mutex_lock(&wq_pool_mutex);
 
 	/*
-- 
2.45.2


