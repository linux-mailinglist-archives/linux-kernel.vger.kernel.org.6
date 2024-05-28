Return-Path: <linux-kernel+bounces-192764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432A8D21C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF731F25987
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869C4173326;
	Tue, 28 May 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKuiVYVr"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8A172BC9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914282; cv=none; b=NGa+JFVgclmZS0CrWE8G4KxiyJLlahpqsWITbIs2jNkQ1LzmV8P7ZxdoIxRo0rjqYtFLIsY6ZOO4JFR/c9kgXUHK2XYBiTnfM7ZnQDeThm4PBrMmJWFGob0zhTdA+tuEHFC6zwRYtgkYhEDxr4CQmKJilpXZcJgTnLA9/kwR2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914282; c=relaxed/simple;
	bh=3ZOe/NyEL4NYG0CoFbAifgplo20ZW+hFcf9C3d6vBio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WakyODy5SnjU09AoqEHOuzQKKd7AAOLZdMHoFzdPs01ZAtpunNVvdF4c0BmBdbGskwg2gKkOXGXBUaU8llKwygh54xs20Dclb5AE6FjqqaHuaxmqpccW1CtYvg8te/jAmjuh8lAm3U2kQfrY2LRIoLNuy2k/59dttoSB2E82ffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKuiVYVr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e7734a29so14522417b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716914280; x=1717519080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jW03SLzQXCK5cXKTLHnT3g1oG6ovCyP3JejlVIXEzpI=;
        b=QKuiVYVr9MSZ/Vm886MEqCP61q2G/8bmKDNSUbLD3G7eZeslCE1n1cX0dNvzfqGqei
         09wBmWP6f+FtBOc99abH1tmAcbifZqTaYEvuRy5JUQn9kE58TEdqOwtujJxAoWaZ0VG9
         AvVdf9xEfyiIvszMKwILUmL0WlRo5xquWizFBtv7qVQGKWS4EgJL9nUDnq8B9pLaJl4H
         4ur5WMCahwHW7j/tH0iKISQc5bxKF5qrYXBB+0UFL7XPVMSaxqN4LVm74BGyflHy8/y4
         b2O6ZDDYMIdTugnnG0PSbSZtfPrjSiEJ97OL0gexZQ8p6n87VuhhqD8f0yB538LzANGH
         G5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914280; x=1717519080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW03SLzQXCK5cXKTLHnT3g1oG6ovCyP3JejlVIXEzpI=;
        b=IBfhL3gyFOoO4t+BfiGiUPnMaLdAEPYVNdA68kBz3qGA4f5i29Dgp6l6jmPwFUNDd/
         nv4hOf8tzinOp7hAN3Z4uWemvv5b5uYUZ32Ko/4orRckUvPMADELobZKe3XQdMtuemT0
         /Vv3XATzazEu/9VE3hfWfyFpePEKZvayEuFnidm6yi31nzG2+lOT7vaAEIJKQ9lEJlYQ
         6j+WyiTesspv9HfT6jU8RpLdRTjQO9+vfv0FFvpfQHuotpVV5WWn1y4VwidyKxeCzL0m
         ycMtCqbGmYCm2kCv/wW/YqLZA1xjZ0tZWw/nBs5Mvu1/1JSFDo0GCuL/Wrse26jtGuEq
         nicQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPDLOrFBM4lXxmmTxSfIA18tS2OyQFjTlpGseuH+UeyB4WMD2h71BfMyoFRH7ObgKiQ+pXSshAtR1r+RDb+8GLBcteim8pAfvVZ+Qk
X-Gm-Message-State: AOJu0YxWDoloOJn1q2XKF912uxKnj1RprMt7dxDPdr1EQai7foJDdFPS
	9017uAdn4QyAGw0rrJsbg3GNLEvdoeqcD0gpBgxZ6tdAJj8LFO18cMKeKtikg+VoYpIW8LlANzj
	KsWOulrbjQIgNpQ==
X-Google-Smtp-Source: AGHT+IEeHAL3ZeW6codhun7v67I8gtG3pX20wbsoxTrzUXIW9NcEB+1vJuC4aPjpz7QlEuuQPDo0ihUnHqeFZv8=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:690c:6a06:b0:627:e167:f95c with SMTP
 id 00721157ae682-62a08dcccb2mr35974547b3.4.1716914280240; Tue, 28 May 2024
 09:38:00 -0700 (PDT)
Date: Tue, 28 May 2024 16:37:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528163750.2025330-1-tjmercier@google.com>
Subject: [PATCH 2/2] cgroup: Remove nr_cgrps
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, mkoutny@suse.com, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: shakeel.butt@linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

nr_cgrps now largely overlaps with nr_css. Use nr_css instead of
nr_cgrps for v1 so that nr_cgrps can be removed.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 include/linux/cgroup-defs.h |  3 ---
 kernel/cgroup/cgroup-v1.c   |  8 ++------
 kernel/cgroup/cgroup.c      | 31 +++++++++++++++++++++++++------
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index bc1dbf7652c4..dcd47a717eac 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -576,9 +576,6 @@ struct cgroup_root {
 	/* must follow cgrp for cgrp->ancestors[0], see above */
 	struct cgroup *cgrp_ancestor_storage;
 
-	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
-	atomic_t nr_cgrps;
-
 	/*
 	 * Number of cgroups using each controller. Includes online and zombies.
 	 * Used only for /proc/cgroups.
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 9bad59486c46..d52dc62803c3 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -675,15 +675,11 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 * cgroup_mutex contention.
 	 */
 
-	for_each_subsys(ss, i) {
-		int count = cgroup_on_dfl(&ss->root->cgrp) ?
-			atomic_read(&ss->root->nr_css[i]) : atomic_read(&ss->root->nr_cgrps);
-
+	for_each_subsys(ss, i)
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
-			   count,
+			   atomic_read(&ss->root->nr_css[i]),
 			   cgroup_ssid_enabled(i));
-	}
 
 	return 0;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1bacd7cf7551..fb4510a28ea3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1322,12 +1322,15 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 {
 	struct cgroup *cgrp = &root->cgrp;
 	struct cgrp_cset_link *link, *tmp_link;
+	struct cgroup_subsys *ss;
+	int ssid;
 
 	trace_cgroup_destroy_root(root);
 
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
-	BUG_ON(atomic_read(&root->nr_cgrps));
+	for_each_subsys(ss, ssid)
+		BUG_ON(atomic_read(&root->nr_css[ssid]));
 	BUG_ON(!list_empty(&cgrp->self.children));
 
 	/* Rebind all subsystems back to the default hierarchy */
@@ -1874,6 +1877,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		} else {
 			dcgrp->subtree_control |= 1 << ssid;
 			static_branch_disable(cgroup_subsys_on_dfl_key[ssid]);
+			atomic_set(&ss->root->nr_css[ssid], 1);
 		}
 
 		ret = cgroup_apply_control(dcgrp);
@@ -2046,7 +2050,6 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup *cgrp = &root->cgrp;
 
 	INIT_LIST_HEAD_RCU(&root->root_list);
-	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
 
@@ -2065,6 +2068,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	LIST_HEAD(tmp_links);
 	struct cgroup *root_cgrp = &root->cgrp;
 	struct kernfs_syscall_ops *kf_sops;
+	struct cgroup_subsys *ss;
 	struct css_set *cset;
 	int i, ret;
 
@@ -2144,7 +2148,9 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	spin_unlock_irq(&css_set_lock);
 
 	BUG_ON(!list_empty(&root_cgrp->self.children));
-	BUG_ON(atomic_read(&root->nr_cgrps) != 1);
+	do_each_subsys_mask(ss, i, ss_mask) {
+		BUG_ON(atomic_read(&root->nr_css[i]) != 1);
+	} while_each_subsys_mask();
 
 	ret = 0;
 	goto out;
@@ -5368,7 +5374,6 @@ static void css_free_rwork_fn(struct work_struct *work)
 			css_put(parent);
 	} else {
 		/* cgroup free path */
-		atomic_dec(&cgrp->root->nr_cgrps);
 		if (!cgroup_on_dfl(cgrp))
 			cgroup1_pidlist_destroy_all(cgrp);
 		cancel_work_sync(&cgrp->release_agent_work);
@@ -5387,12 +5392,27 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_rstat_exit(cgrp);
 			kfree(cgrp);
 		} else {
+			struct cgroup_root *root = cgrp->root;
 			/*
 			 * This is root cgroup's refcnt reaching zero,
 			 * which indicates that the root should be
 			 * released.
 			 */
-			cgroup_destroy_root(cgrp->root);
+
+			/*
+			 * v1 root css are first onlined as v2, then rebound
+			 * to v1 (without re-onlining) where their count is
+			 * initialized to 1. Drop the root counters to 0
+			 * before destroying v1 roots.
+			 */
+			if (root != &cgrp_dfl_root) {
+				int ssid;
+
+				do_each_subsys_mask(ss, ssid, root->subsys_mask) {
+					atomic_dec(&root->nr_css[ssid]);
+				} while_each_subsys_mask();
+			}
+			cgroup_destroy_root(root);
 		}
 	}
 }
@@ -5678,7 +5698,6 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	/* allocation complete, commit to creation */
 	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
-	atomic_inc(&root->nr_cgrps);
 	cgroup_get_live(parent);
 
 	/*
-- 
2.45.1.288.g0e0cd299f1-goog


