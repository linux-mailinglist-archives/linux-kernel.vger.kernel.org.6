Return-Path: <linux-kernel+bounces-248827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FD92E279
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736651F210C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18F157491;
	Thu, 11 Jul 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP8I9exP"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C47156F3A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686788; cv=none; b=jzfL5F0leatYdxbm2MUOVkqqhKOMt9B3y4kysqfvioU3hct587rN/OF6NUmhjVKqR9D67O5Zy49deLIwFlLEML9RmkfgbrvymnTg+bAK3fJ4xSXmNky+KZwPgaoZyw0htFsPKxJ1B+m2O6K7neTmQEa61BVLxDEK0wLeIXuW59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686788; c=relaxed/simple;
	bh=PPqAOgxiHf80yuq2V7rEIjlkSvnolbs5gz7XAwBVk/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWLzk8ASEeknYAXY7TKAxHRS5qwhBE9wCbIFtlik/Ij590z/vDGjLJQeVKPddeBfIrIrHdTdgm/gaRL3bTx5col0u9ej8auYszfYmjxT2ZWVbET0NfbLaT47nfgNstHHJrlRvaUEF9+m+cym7cybcY3SRKmunI3ildAB49oGDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP8I9exP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b42250526so529695b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686786; x=1721291586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiOeWmbTexBi55Q/t6q7ngGXESICd795YG/HDDiGhpg=;
        b=SP8I9exP3kCUTHkdKlAmWXDWQrvUh5Q4xEQnqhVacR2aXQTVpnsqqE1trgMhEr88z2
         vIR781gVOXpZy4jCk/ZAEBRPaMRHOJHovxI0OxzG6rsCnbaTQo/UFyIgmEW3sZfelEC2
         reJflIRXtF87q5W9VGjVfAwb3mtxO/LYToEhoGXgkbY7fDL609GG6r0l1/P0+FHUB6m4
         FzUP7zLKzMCgJPrUc+YROcfTUxY2z7wO5wbzS2rtfUkta4lGnibfZcWzGJmt8lkWAgQW
         m5YJRR2DrXsLJLRvxv4BhRBJctY11rFfqRYsBOBJlLYGeHbUtEf2VVwlsqIXrNA/4mhp
         sMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686786; x=1721291586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiOeWmbTexBi55Q/t6q7ngGXESICd795YG/HDDiGhpg=;
        b=CnassYfkWfHHsINo8gjLlgx+JnVjhNBsIjHg2i5phP0b7kehEtMnvoVkUSpO9NeoTQ
         pNKdmV7I9V4481muclCVu8Y8t+zzM3fsfSr7T/SDOQdDSDkjVEftZjZFH75bbBBRLC2O
         xdbthDqDmRvNs1E4QKQ4n6mmsJhEcqKgWkC6wyrGpLVPQUXWRplN0bSQgvwcblQ0co5g
         niQ1IH2NL3A1dzP0FyAchz6ImzlwzAsZNgz0V64nVUX8DArvEaeYjAIOAdJLF+p37Laz
         eakaVb/j8yaP9I8zauk95iCrEfGEqKZcJPLKWHza8VeZHf9BpqFO/kSFgGupZEYj7MAi
         1ZUA==
X-Gm-Message-State: AOJu0YwKpJ/hLqA5eg98I5XBzlBTc6a9c2D1Z/o5IFE5DcRi8sXsQ8bw
	r1qD47VNAokhnZFOqe7zrKylPCLdEtKOGbKr95J51/NAMBjeDEMEPthS4w==
X-Google-Smtp-Source: AGHT+IFJ5d72RsM7GIb9z5ohNAWlZT0KxHL4qtyQ/K4hKrraFzVIXRZb6XgwPoN9SqrMoL6cDL9xmw==
X-Received: by 2002:a05:6a00:2292:b0:70b:2ede:7142 with SMTP id d2e1a72fcca58-70b436171c6mr9202424b3a.34.1720686785984;
        Thu, 11 Jul 2024 01:33:05 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389c0ffsm5260635b3a.16.2024.07.11.01.33.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:33:05 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/7] workqueue: Simplify wq_calc_pod_cpumask() with wq_online_cpumask
Date: Thu, 11 Jul 2024 16:35:42 +0800
Message-Id: <20240711083547.3981-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240711083547.3981-1-jiangshanlai@gmail.com>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Avoid relying on cpu_online_mask for wqattrs changes so that
cpus_read_lock() can be removed from apply_wqattrs_lock().

And with wq_online_cpumask, attrs->__pod_cpumask doesn't need to be
reused as a temporary storage to calculate if the pod have any online
CPUs @attrs wants since @cpu_going_down is not in the wq_online_cpumask.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 985ab9230fe0..9f454a9c04c8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5156,20 +5156,14 @@ static void wq_calc_pod_cpumask(struct workqueue_attrs *attrs, int cpu,
 	const struct wq_pod_type *pt = wqattrs_pod_type(attrs);
 	int pod = pt->cpu_pod[cpu];
 
-	/* does @pod have any online CPUs @attrs wants? */
+	/* calculate possible CPUs in @pod that @attrs wants */
 	cpumask_and(attrs->__pod_cpumask, pt->pod_cpus[pod], attrs->cpumask);
-	cpumask_and(attrs->__pod_cpumask, attrs->__pod_cpumask, cpu_online_mask);
-	if (cpu_going_down >= 0)
-		cpumask_clear_cpu(cpu_going_down, attrs->__pod_cpumask);
-
-	if (cpumask_empty(attrs->__pod_cpumask)) {
+	/* does @pod have any online CPUs @attrs wants? */
+	if (!cpumask_intersects(attrs->__pod_cpumask, wq_online_cpumask)) {
 		cpumask_copy(attrs->__pod_cpumask, attrs->cpumask);
 		return;
 	}
 
-	/* yeap, return possible CPUs in @pod that @attrs wants */
-	cpumask_and(attrs->__pod_cpumask, attrs->cpumask, pt->pod_cpus[pod]);
-
 	if (cpumask_empty(attrs->__pod_cpumask))
 		pr_warn_once("WARNING: workqueue cpumask: online intersect > "
 				"possible intersect\n");
-- 
2.19.1.6.gb485710b


