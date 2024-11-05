Return-Path: <linux-kernel+bounces-396618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E39BCF9D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430B61F233BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882A1D9697;
	Tue,  5 Nov 2024 14:43:06 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451411D90B1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817786; cv=none; b=EDnDty6CYq64d15NTo6CM5hjiIXgiNbY1Xt0avsATUEQTdfr+jEJUFy0qVyZ5SbuakqtAfqYuSwTellgx5Im0n5i5ojrUYiX5Z1s5IWIYF+s7IalsrjiyuRRDV30a/YEdlIRbUWb2XY32sWoHyWVpu3Gq4TVAepW/sRRNFwjMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817786; c=relaxed/simple;
	bh=110IyjSStVOb9YuhidGQIkWZlivIid1liiPs3nyU/x8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=en1HMomMra7GfbrocZWU+Xnf6fGqK+VTqiRuD8ClZRC96/vV2oOEXu5QzquNJW3l6bL6biJj4F6lgL1bTOQnyQUlnuuSeVcBFypbQ5ECEiyRpZrkRmbxmtmQh/wel/34S+jm8jV/QmXbJOk7ZDfxm9avzF7O2j30q/NZKOee7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb51f39394so46156201fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817781; x=1731422581;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vIy8/a9aiXFl3rcfyGsmdu83APhG1KQgWV74xlkHbk=;
        b=gIBJgRcGeOgaPRmfMZOAYfzdo5l4vjg91Aq+4Ti0UiRByHafXhKcsc7mOYtUK2lP9o
         9zTl4z+uhSWYdmybdtnaM53UEz2z/H/5P6+XtROTdkYuZNcfBd7+EmusjNktqB7QG3l9
         eVzx1f3YN7AiT8PYzPmSeFilMbbZsUVuydLWZDvLs2BY8+EE+QwW4qd5VWiQiujhXGnD
         PbbKu5gdNRuKQq9hpkeyhKx8+/H1GnBBBX9bBWiqZZMgjYUoFd6JO3/vihkvvY4uZRaF
         Q8wGvmfSqRE/MMDMA747Gcc/U5ZVMrNfxh8T4gvbCKGmtgFuNMfu6e7XXUNgaNf4P88a
         /IIg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZLEaR4tHh6IEeAV49WzkG5adWqTz2onCclRNXWWkf3CdTYV41nOswGmnmz26h0T0Qn+r5xsDLOaS2gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/DUO+k85CpaR6iQtF8kH1AtaKtYRW3mkEOd46dibb3dCMcH7T
	3xXF4mrTz2QjGV0QW1c3YRqc79r0133Npe1qvLiNE5zUgwYqck/aZuFkYQ==
X-Google-Smtp-Source: AGHT+IGJVfakpm67z/6merecDWZjEioE1MjlTp0I1x/17PR+xbhIKd4ub9edUmeg1BY49irbKjFprA==
X-Received: by 2002:a05:651c:154a:b0:2fb:7e65:cb27 with SMTP id 38308e7fff4ca-2fcbdf68bf5mr206616391fa.6.1730817780751;
        Tue, 05 Nov 2024 06:43:00 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6ac399bsm1366680a12.52.2024.11.05.06.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:43:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 05 Nov 2024 06:42:46 -0800
Subject: [PATCH] nvme/multipath: Fix RCU list traversal to use SRCU
 primitive
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
X-B4-Tracking: v=1; b=H4sIAOUuKmcC/x3MUQqEIBQF0K087neCOv6MW4kIs+f0oCy0YiDc+
 8CcBZwHlYtwhacHhW+psmd4Mh0hLiF/WMkMT7DaOmO0U/neeNyu9ZQjnMtY4qXe8xT0K0U3aYu
 OcBRO8v2n/dDaD8TjljtkAAAA
X-Change-ID: 20241104-nvme_multipath_rcu-9dba03fc4b02
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4084; i=leitao@debian.org;
 h=from:subject:message-id; bh=110IyjSStVOb9YuhidGQIkWZlivIid1liiPs3nyU/x8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnKi7z2MZCI4evEWx0fsjg+t99XgLdznFE4RxRu
 6YgWk4v+MOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyou8wAKCRA1o5Of/Hh3
 bf7AEACYitXkDX7P2OopVTZSjwNnDHp4Cdydu1OXuDBL1wNFZ5+isGb0wabJAcbChKGpktkj9EE
 xuCNBnQlP7xKuHfK5ixIjJk39ISq4HEbRpsMjtEyU+i6FCfOb8FQSSzOMNKd8jGqtW+k4QFrGZ3
 Ol6yfcXpjScHjhud9Tq9tOhVRqmmKDsJ4ZiNa5m/sLoROC1/l8+dnJIupvSOiPk1dVxH9u3Mj1m
 H9PWbx0HRlPY94emLbCDnd2U1xlh+ylee4lGRmCngl2Yc6KrRDofkrbeRYD895S/rUAdWRU7UvP
 egyz767RIeuO7/2teK6uiR9AXT84hd8ixhe/eglKaSCPb8M4FgCMJ7Y3U1cSsnDjK8RavTi8h02
 YcuIwViU/1d51N8WSvqb3M3ZaGP4TkFIb4DD4bqfVX0rAEKt8cOQakuV1WxxAQ5uTyySk7XWeO1
 l4QNCuabaPTWPy8z/fHKDQ40RPLop3mHKNeeLgTCCIeaTRhHN1yCZoK8Pd088NfRAAGMTEZT2xx
 yg5iMwz38jt/WPfO2tYC/Qxu0oiTpKhtbOCBGNxyoWVvW4emIDOoEslwTcUo3oObEcs90n9VHp6
 UHBNSudn5Cjc6QevLTorpTs86BABKQdJ+EYNK+nZyjsp1ThC1w/l92n4iwni4xM3R6C1iJUl+3z
 rhu+E9xf5Qekknw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The code currently uses list_for_each_entry_rcu() while holding an SRCU
lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
enabled:

	drivers/nvme/host/multipath.c:168 RCU-list traversed in non-reader section!!
	drivers/nvme/host/multipath.c:227 RCU-list traversed in non-reader section!!
	drivers/nvme/host/multipath.c:260 RCU-list traversed in non-reader section!!

While the list is properly protected by SRCU lock, the code uses the
wrong list traversal primitive. Replace list_for_each_entry_rcu() with
list_for_each_entry_srcu() to correctly indicate SRCU-based protection
and eliminate the false warning.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
---
 drivers/nvme/host/multipath.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6a15873055b9513f827709ad780bc7e18f75e439..f25582e4d88bb04c0f866ada11735ce562f227d4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -165,7 +165,8 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		if (!ns->head->disk)
 			continue;
 		kblockd_schedule_work(&ns->head->requeue_work);
@@ -209,7 +210,8 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		nvme_mpath_clear_current_path(ns);
 		kblockd_schedule_work(&ns->head->requeue_work);
 	}
@@ -224,7 +226,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		if (capacity != get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
 	}
@@ -257,7 +260,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
@@ -356,7 +360,8 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
 	unsigned int depth;
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
@@ -424,7 +429,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
 		return NULL;
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
 			continue;
 		switch (nvme_ctrl_state(ns->ctrl)) {
@@ -785,7 +791,8 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		return 0;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		unsigned nsid;
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);

---
base-commit: 822eca3e06d039ea9ebf46c6192af06661f50d58
change-id: 20241104-nvme_multipath_rcu-9dba03fc4b02

Best regards,
-- 
Breno Leitao <leitao@debian.org>


