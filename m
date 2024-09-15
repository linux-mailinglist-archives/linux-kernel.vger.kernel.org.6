Return-Path: <linux-kernel+bounces-329760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F59795C4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344861C21560
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0F193429;
	Sun, 15 Sep 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="Obm0IzdT"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54428370
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726389055; cv=none; b=moG1uf1uTNkCElVLmPwezZtoSsZW+SThAEp7WpsV8A0ShC3cqaIY1w4faoZKeyw+E4t+26RUxJsNqR8IPfQraFo6xKSTOSKv0BsqTXLaKrvNcySO4tHdFXrN8lgWghDkZ0CwUJgsAqjOYgqhRQIlw0cOpoZzRZh5T6wzSfBRm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726389055; c=relaxed/simple;
	bh=sKkJvxdT6GVgzj7+WdE05T4Y8qJCY4kC/QWf7CadQlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grjkdzdbqr4dcBAtLmJmGj4Eu4DF3pFPbkXsLnWaiivgYE/nTyOPfLtEoG8r2yGS1BrSsVAD8cg3qe06FXi17LadGvqEskfiUUUnpB4oFyzxMd7KfNZGREMyhhzIWefufrvJhZejhfvkJFlqUn9cfLr5ZdDsZ7J8FKPKiXzGCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=Obm0IzdT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20536dcc6e9so16301225ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1726389052; x=1726993852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ETeHez5VPu3IViLKsMjOiE3ZpAidPqgqJgS9mbnjOg=;
        b=Obm0IzdT78HwWbJtaHu1SMo05vGmvEO+uKQtI9ysfKR84xedYScAq1VyYLzRLpVYr0
         x+ogxvXiiD/YksOdSRqqLNzPfZZSfRr6D/UYf9f6rpKrY/SrmofzMyJnQlAmBjQJ2Ls5
         FYRGhaWl/BUhFr8EFY1Zsg27y+PUQBZu0n9cjau9KkSj3Ix35ARuaQPkglyUwHMMzTpK
         mYMxY5cRYuNq2edyZfmHbFDVON82qUsB0fN05v83zOGNISzGOYa/toO52Rgffvf6g/lG
         VG4sJW09e53r+DsNwLEaqOpil4NVb1zJGS8NA46FBKL56rM6EKa1sbeCEC3FHJd6Yc7n
         x12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726389052; x=1726993852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ETeHez5VPu3IViLKsMjOiE3ZpAidPqgqJgS9mbnjOg=;
        b=eYPeenbTUyYYl6KX4/QgfhoxhBE9dx5sT9GGcCag6g+jqzCoic+jqvguPH1Y8BEFBc
         EGVeq4vEy1jtP8xSeWQ7Gb/KMfaAfKA3Tqw7PzCuq6CeZB42yTW6WL8ic8gSjzaGmRv0
         gz8MBnsmR8/5VAqOxKygi86BFl8EPwecESYF2rYYEOlaYDHm2lzKlXSEata5Y22r113b
         JdRcrPpmhHxKAhy9oJw1mlmHz7rMD5hO14Js6kc7DYwxUvPH+ED+tDbJ8c4SV0oMwVdm
         4GqN4ZtYqeXvmkopC96y5GfmZNwm/OMVKYZwRlccvfhF0dKRqi7jCsPo4UW62LU+qQwu
         jo9w==
X-Forwarded-Encrypted: i=1; AJvYcCUqPNbVvHqZiOaC7PhE4JYrFZr+TWiAOllHX9tRaPgRSqZga8ifMKaYloI5Lijmko4j7tL0uBYq0zOLHv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxhqa8ztJwuR0BTSkNy91aNjLK1dvQSj4bVmGP1XDE+8GIKPTa
	ofgiodxHh7qJjtTNmllFQ7pc7YpJKJur4gHXqes5v7wH4jAef8Qd1bK3lzxDiHU=
X-Google-Smtp-Source: AGHT+IFw+YlAdTPoj4PC7x4Yn7jJp04kBAoC4jL0NToCDL+8bQZTMVVeHViRL9ISMyKCI3BeuEj/hw==
X-Received: by 2002:a17:903:2302:b0:205:8cde:34c3 with SMTP id d9443c01a7336-20782c078c9mr125820795ad.54.1726389051554;
        Sun, 15 Sep 2024 01:30:51 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.28])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207946f721dsm18308685ad.188.2024.09.15.01.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:30:51 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: everestkc <everestkc@everestkc.com.np>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix spelling errors in file kernel/cgroup/cpuset.c
Date: Sun, 15 Sep 2024 02:29:21 -0600
Message-ID: <20240915082935.9731-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: everestkc <everestkc@everestkc.com.np>

Corrected the spelling errors repoted by codespell as follows:
	temparary ==> temporary
        Proprogate ==> Propagate
        constrainted ==> constrained

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 kernel/cgroup/cpuset.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 40ec4abaf440..205aabcd95f6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1654,7 +1654,7 @@ static inline bool is_local_partition(struct cpuset *cs)
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
  * @new_prs: new partition_root_state
- * @tmp: temparary masks
+ * @tmp: temporary masks
  * Return: 1 if successful, 0 if error
  *
  * Enable the current cpuset to become a remote partition root taking CPUs
@@ -1698,7 +1698,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
-	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
 	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
@@ -1708,7 +1708,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 /*
  * remote_partition_disable - Remove current cpuset from remote partition list
  * @cs: the cpuset to update
- * @tmp: temparary masks
+ * @tmp: temporary masks
  *
  * The effective_cpus is also updated.
  *
@@ -1734,7 +1734,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
-	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
 	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
@@ -1744,7 +1744,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
  * remote_cpus_update - cpus_exclusive change of remote partition
  * @cs: the cpuset to be updated
  * @newmask: the new effective_xcpus mask
- * @tmp: temparary masks
+ * @tmp: temporary masks
  *
  * top_cpuset and subpartitions_cpus will be updated or partition can be
  * invalidated.
@@ -1786,7 +1786,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/*
-	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
+	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
 	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
@@ -1801,7 +1801,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
  * @cs: the cpuset to be updated
  * @newmask: the new effective_xcpus mask
  * @delmask: temporary mask for deletion (not in tmp)
- * @tmp: temparary masks
+ * @tmp: temporary masks
  *
  * This should be called before the given cs has updated its cpus_allowed
  * and/or effective_xcpus.
@@ -2534,7 +2534,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			return -EINVAL;
 
 		/*
-		 * When exclusive_cpus isn't explicitly set, it is constrainted
+		 * When exclusive_cpus isn't explicitly set, it is constrained
 		 * by cpus_allowed and parent's effective_xcpus. Otherwise,
 		 * trialcs->effective_xcpus is used as a temporary cpumask
 		 * for checking validity of the partition root.
-- 
2.43.0


