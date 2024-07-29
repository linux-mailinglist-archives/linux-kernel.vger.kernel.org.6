Return-Path: <linux-kernel+bounces-265050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C3293EBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958CA1C20A53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E880038;
	Mon, 29 Jul 2024 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L76P939m"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B21E864
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224478; cv=none; b=iJt++lQ9Dv/wgtqfRJExn0XQW1bnpBsB2+Gfy+NMSiuDAOsdQBHoeVcb9u1dOs6oWBCI475j+kAz1txdJeAcJsckhjSExfZk5uja4xDQsBPbeuFv8cxg1c/+sFkdIgeOZ7hHvpwI11mjHfyWMS2NZ2WvCyw8dO0fPhv2PsJTW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224478; c=relaxed/simple;
	bh=2mdPRkhDtHfUHLo9fDiyxRY0Wh+gSOP5OE1ljd34bSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=itm2b1871tnVcFxtghv4REg3SNPO6ek6EeUdj8c9/C40Ok30FLgEoIpJ05MXXITzrmj/xaDm9QMyDwVCrYeGJCYphD+6Kgr33hd4nYs8s0dk4XLo868t9mbaqspBjWCqgfXVbKB42rB/u3IjNHyuCP6bHlR9sIesiSuWXg8CGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L76P939m; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-381f24d6bc4so13511685ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722224476; x=1722829276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub4CUKjz+gpiM3eyXU58s8nx4MPUiFlHShXnnODGgaA=;
        b=L76P939mBbrOthJXDIaAvLTjyADcIdwxJSft5feiO97ePz49vwx19MBIwlceWqafLZ
         zSN1AG/zst7ohCjCip0YPUSS+W9V9EImTBk3c6hb7GZT2GGYDwa1KNKj6mzNWKE6NaG1
         kBz+r4bEmJq8WDWUEUrHN8xf7eGzMD6DgNwXnBySXE/UzpIWAlgz8krK4LdhQaicAP1O
         QSZWUtBmWAy53JaeN5EHty9WTqUgyeW9ucWvNX1hqMsFaRdcjMjoSTCQrTyd3b6EaM5L
         XLElAFzoH3JiKHSe0yd9WMvz8bOOb94z/2iOdDPBvf5Ee8mjJyOX9fekIL4EBy121mPm
         N0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722224476; x=1722829276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub4CUKjz+gpiM3eyXU58s8nx4MPUiFlHShXnnODGgaA=;
        b=eAfcw5ruojyAU31/8goNe8Y4nJLhs6ao3p4iF0bwkOTvm9V+I0/5p9tC5J/IKOZl8l
         tVXmoJXKohZ6xDR51Q3gFJamXveg0SVf9SU5O+Pc6IGpDYMeHfywLLWjhoN3dQfPrNfd
         R188nuqOW21k7H5wSwEK5CSno1gJdd1zq9cVUVutGwt7/OBf2DM4l/eyPg8XzLUNhDDy
         NAT6s99iyXBju443qeXzDWhZYLxyqYGN/zFxPz+5MyaIx1rS8OMgI7iKTKIjhlH9onLx
         AGEpczN5mYA3VsrWOrH40CqEq3In8xHBvaKHWRFwQoKD24Y4zCT5TLmtddZemmROnByJ
         lThA==
X-Forwarded-Encrypted: i=1; AJvYcCXPwbTOY2+nNW2Qe7ZwmUKZq0eCWvSWS0v2izHkl1TCANv0kWD8byGyURexb1ZrGHnWxSQVIYOug5rQPGUIt6uRDlkPIDh7tAnrnN8Q
X-Gm-Message-State: AOJu0YySHXxibPRE1Cl5Vpkxq7oX4qaj9XQW9CdUeLQd8wxRX2eYfm4Q
	2kF69CbUgfVMmOMd5pWQlhDB5cpEct7MiszIjSNfsEdJYvmi8FQY1aK12AO5hCI=
X-Google-Smtp-Source: AGHT+IHppPgV6adu9FhZKtUlC5oJjF+WiKgrLj5V4L4HovNpm+wFdw3vWmOMXwyGAZY92mV3qevQvQ==
X-Received: by 2002:a05:6e02:13af:b0:39a:eaca:24bf with SMTP id e9e14a558f8ab-39aec2e9dbbmr70414755ab.15.1722224475629;
        Sun, 28 Jul 2024 20:41:15 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7120easm5945591b3a.55.2024.07.28.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 20:41:15 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	surenb@google.com,
	peterz@infradead.org
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH] psi: Inherit parent cgroup psi enable state
Date: Mon, 29 Jul 2024 11:41:00 +0800
Message-Id: <20240729034100.1876510-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when a parent cgroup disables psi through cgroup.pressure, newly
created child cgroups do not inherit the psi state of the parent cgroup.

This patch tries to solve this issue. When a child cgroup is created, it
would inherit the psi enabled state of the parent in group_init().
Once the enable state is found to be false in the css_populate_dir(), the
{cpu, io, memory}.pressure files will be hidden using cgroup_file_show().

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/cgroup/cgroup.c | 21 +++++++++++++++++++--
 kernel/sched/psi.c     |  4 ++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a4..775fe528efcad 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1719,6 +1719,24 @@ static void css_clear_dir(struct cgroup_subsys_state *css)
 	}
 }
 
+static int populate_psi_files(struct cgroup_subsys_state *css)
+{
+	struct cgroup *cgrp = css->cgroup;
+	int ret, i;
+
+	ret = cgroup_addrm_files(css, cgrp, cgroup_psi_files, true);
+	if (ret < 0)
+		return ret;
+
+	if (cgrp->psi && !cgrp->psi->enabled) {
+		for (i = 0; i < NR_PSI_RESOURCES; i++)
+			cgroup_file_show(&cgrp->psi_files[i], 0);
+	}
+
+	return ret;
+}
+
+
 /**
  * css_populate_dir - create subsys files in a cgroup directory
  * @css: target css
@@ -1742,8 +1760,7 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 				return ret;
 
 			if (cgroup_psi_enabled()) {
-				ret = cgroup_addrm_files(css, cgrp,
-							 cgroup_psi_files, true);
+				ret = populate_psi_files(css);
 				if (ret < 0) {
 					cgroup_addrm_files(css, cgrp,
 							   cgroup_base_files, false);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e8..d0aa17b368819 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -180,7 +180,7 @@ static void group_init(struct psi_group *group)
 {
 	int cpu;
 
-	group->enabled = true;
+	group->enabled = group->parent ? group->parent->enabled : true;
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
@@ -1114,8 +1114,8 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 		kfree(cgroup->psi);
 		return -ENOMEM;
 	}
-	group_init(cgroup->psi);
 	cgroup->psi->parent = cgroup_psi(cgroup_parent(cgroup));
+	group_init(cgroup->psi);
 	return 0;
 }
 
-- 
2.20.1


