Return-Path: <linux-kernel+bounces-544755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E33A4E4F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D696F422019
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759FF2BE7CD;
	Tue,  4 Mar 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ReG+dyPC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEE290BD0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102748; cv=none; b=eYhi2EHYrLBKkFNYK3BgH/2Evf0OzJ9Z8UBtQMO0aY9fpp1tnsm9LKLqD8Jxw9zTr0DuFnfdfMKgsfOoRsQefhAEPUCgwi+ws0YGTFUxjToijVaTdnYg6+h9ZX1SAUq8iWdQfgX/PQjcazBHJ7ozjg73Zs+GQDDeqEilTjcXTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102748; c=relaxed/simple;
	bh=LvkOijoEyLqDMsqQX+Kl7wQP+Lfreox2ddu/WO8YtBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSwyB3o3KaPn7lwl3yawtoK22HcfwIgzrq7qdjPkyKDqK1ivEcrFLKlBdz/vb/5ckxazZrkeD6PyFTt1qGvma50UZuQQxJa+Ilb8E3/OF8SoK1dVFeWXYwESGahqrbyYX0oBgoEW2T3afaUZHbJZ4SUwHd745/z7auaWHDWrRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ReG+dyPC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bd03ed604so2249675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102745; x=1741707545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkXOSC9ROskp3x3ku4mQvAAKFjUVG2MCmIDW0NJqpNc=;
        b=ReG+dyPCRDFzyYsj4zAYWz+OKEE+rGOqNz3/dsxcIS6XEcShSVkTOBrrbwHt7layU1
         q17uB35yxIqgEEh4Uaa/dDkymiADB3WLoC0pnAt6Iwr+pmCS/Bkcl7yiDnuPs9E1yjb5
         SXZdxDMirB3pe52gx2v8nfSuWl2Yq1T4XtaBXmHBZ2+TjCkwGbPn3wQe3nQYG6NrFT9I
         WdmTKAY058SuNpiA3IMy/wg3MYne/Pll5dQ2t4RclcRQHwHLhMI5NUnJOBtziqWaq2Nn
         2kdHJzoN/WidBmWxXxgReZFzcvWtWXErsTqmFYkdvUtxtyJ/Zkydf1TZ9KGLRlk7N35I
         omBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102745; x=1741707545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkXOSC9ROskp3x3ku4mQvAAKFjUVG2MCmIDW0NJqpNc=;
        b=u1LKYnChKlcrR4s/7BKzMkw1LQ1rlMtiyeZX8BtOmrTU2kmvYXmOZOJ8E6QPnNMW12
         WbcQOsUs9Ztnfu2cJuRqjM5VsY6QyK/BcztwhC1J/uKc0jynOxzVMTgmeWK2UrEvKNmS
         yES0XVaxo93VtLCu8xV49ebAJegU0Br5ken7yvMhq7KNRpQj5J48lzP7dT27IoILJlqu
         PpqfwiKVucJJNDuA4spc9g7JQjuwjP7+jlz1hvpi7WtzAkapGWSVBM1WBzq8tnHUD+vq
         c3FnXrcIRxTeRsz3md/11ahUcJosOFDYcSCn0onPNlGXFD8aSGykCLFqUdSZiRDCIrFi
         75Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUAiiVVDZh+g0HnP0pY+gDYH2uygEUGriQ4Pls47BAyYy5vWnntmT/YLHtJf3Ye7nb+q0EszEY1XNMxDxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPE2v1XhbDwHgJD2tJPvqtBWeUGP81Vb+c/8x7eKngC9gJBIv
	/09HGTmgFvkObe2HXUbOOXdPXYuhy8JWEGcKsIJncJfpWl4sjgvJAXLhiWFksg4=
X-Gm-Gg: ASbGncu4XwT20yXyD3/1/x1SUPrDMWCsOlq2Vkz00LjVDk/xP/wGj5JRhRatxUTc0rl
	jPxBaeVAKDtwLmaYZO2NkI2bfuAgFSQVa29krRRZ1oGlfea9hN5ARA4UAweOgvmYh5VS49uqYTx
	Tt79VE3WZZt3Ais1MIreR6QPmdXnIBheXL5D+PUUvBBa5AfgaSsGzaWKIqM8hqjiab3RS19eHvb
	+fmzixGhIIvow6rMXXkSBkADsyFdJFJRPou8zFVFjlgFltKM22loovBZ1fRubhtbyY9/UwK2Re5
	xMY4J98QcgrcQBFdVQlaJcZaPhfx1ATINX9GoT/u1C+/YpY=
X-Google-Smtp-Source: AGHT+IFd0Y1kfVUDwA+rIlXltUNEpd+BRYNRN/rGxGNdGzkzrMQ0wTVhTLyq8Q5ZNmhBP5e9sRDWeQ==
X-Received: by 2002:a05:600c:44d6:b0:43b:c0fa:f9c9 with SMTP id 5b1f17b1804b1-43bc0fb002cmr75491345e9.7.1741102745403;
        Tue, 04 Mar 2025 07:39:05 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:39:05 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 9/9] blk-cgroup: Simplify policy files registration
Date: Tue,  4 Mar 2025 16:38:01 +0100
Message-ID: <20250304153801.597907-10-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use one set of files when there is no difference between default and
legacy files, similar to regular subsys files registration. No
functional change.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-cgroup.c     |  7 +++++--
 block/blk-ioprio.c     | 23 +++++++----------------
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c |  2 +-
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b77219dd8b061..db6adc8a7ff41 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1771,12 +1771,15 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	mutex_unlock(&blkcg_pol_mutex);
 
 	/* everything is in place, add intf files for the new policy */
-	if (pol->dfl_cftypes)
+	if (pol->dfl_cftypes == pol->legacy_cftypes) {
+		WARN_ON(cgroup_add_cftypes(&io_cgrp_subsys,
+					   pol->dfl_cftypes));
+	} else {
 		WARN_ON(cgroup_add_dfl_cftypes(&io_cgrp_subsys,
 					       pol->dfl_cftypes));
-	if (pol->legacy_cftypes)
 		WARN_ON(cgroup_add_legacy_cftypes(&io_cgrp_subsys,
 						  pol->legacy_cftypes));
+	}
 	mutex_unlock(&blkcg_pol_register_mutex);
 	return 0;
 
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8fff7ccc0ac73..13659dc15c3ff 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -113,27 +113,18 @@ static void ioprio_free_cpd(struct blkcg_policy_data *cpd)
 	kfree(blkcg);
 }
 
-#define IOPRIO_ATTRS						\
-	{							\
-		.name		= "prio.class",			\
-		.seq_show	= ioprio_show_prio_policy,	\
-		.write		= ioprio_set_prio_policy,	\
-	},							\
-	{ } /* sentinel */
-
-/* cgroup v2 attributes */
 static struct cftype ioprio_files[] = {
-	IOPRIO_ATTRS
-};
-
-/* cgroup v1 attributes */
-static struct cftype ioprio_legacy_files[] = {
-	IOPRIO_ATTRS
+	{
+		.name		= "prio.class",
+		.seq_show	= ioprio_show_prio_policy,
+		.write		= ioprio_set_prio_policy,
+	},
+	{ } /* sentinel */
 };
 
 static struct blkcg_policy ioprio_policy = {
 	.dfl_cftypes	= ioprio_files,
-	.legacy_cftypes = ioprio_legacy_files,
+	.legacy_cftypes = ioprio_files,
 
 	.cpd_alloc_fn	= ioprio_alloc_cpd,
 	.cpd_free_fn	= ioprio_free_cpd,
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634d..8e7415c64ed1d 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -113,6 +113,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
 
 int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
+int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
 void cgroup_file_notify(struct cgroup_file *cfile);
 void cgroup_file_show(struct cgroup_file *cfile, bool show);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3a5af0fc544a6..e93b0563a8964 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4447,7 +4447,7 @@ int cgroup_rm_cftypes(struct cftype *cfts)
  * function currently returns 0 as long as @cfts registration is successful
  * even if some file creation attempts on existing cgroups fail.
  */
-static int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
+int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 {
 	int ret;
 
-- 
2.48.1


