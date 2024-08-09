Return-Path: <linux-kernel+bounces-280850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A77C94CFF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC7A1C21EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66652193092;
	Fri,  9 Aug 2024 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pvQ/3Xoz"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18923398E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205889; cv=none; b=VMOe4w6VKQX4scOXqmqxbBS2LFkNxi9ORSquiHvZ3DAZ1L8OyzFh2pHQnCObho+/00fsvdh1UVdOVb4Fjk8hO6qUBPuPIzXCallo6lxtmIJgJzYLllGopN9beJN5V01x0hfLtIkSzfhuIIW++FQ3FYSKXZsSoG7E/yJxpJydNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205889; c=relaxed/simple;
	bh=L7fQbHbSDGKh0yOy/EitpWQiO2+lbxI3Mx2vf7boh+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwjXQu0SBM/HIqhJ2frpy2k4oGVYAr7MESRU147gWOuzB6215afFXjgX3/pu8nivWYAfHcCxQZAIsjbTdk6pRZ5W85W/qaTZnBY/gbCeTcQ3fIcfiZaHEV3IMkICPvVLVplRLdKD8woO2CvCCoAwdgId1u8J+TCckBmffLik/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pvQ/3Xoz; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Nozoc
	i1Hu1xoGNOmsSkOI9Bg3RioEzG+cS3k0LlyetQ=; b=pvQ/3Xozqf52ThnUD5CeJ
	kEI0EEfV8p7MGI1XIxQJiCp2SFiqzEyiUDE9Dzt5BP7vxtSph22UDPorfz22iNDI
	b9HV9YUPWHAPDlWdY8GwA2F0mjrwb9kjgY2gyQkMLf86YEz8eEHgki05x5E0XNaq
	OekTLoMBfL3i5963RL7gcU=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDXf9jeCLZmQRwMBA--.8532S2;
	Fri, 09 Aug 2024 20:17:34 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	j.granados@samsung.com,
	linux@weissschuh.net,
	mcgrof@kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH v1] Namespace: Optimize the namespace code
Date: Fri,  9 Aug 2024 20:17:32 +0800
Message-Id: <20240809121732.545807-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf9jeCLZmQRwMBA--.8532S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW5tFyxAFWkXrW3Ar1xuFg_yoW5ZFWrpF
	4SywnrAws7Jrs0grnrJw4kZrWagw409r43Gas7Ww4Syw1agr1rK3W0yr1F9r43tr97J395
	XFW0gw4FyF4Yq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piH7KxUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiwh82EGWXwJkFiQAAsc

Modify variable names in the function clone_time_ns to enhance
readability, and optimize the memory release operation by placing
it outside of the spin lock in alloc_ucounts.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 kernel/time/namespace.c | 30 +++++++++++++++---------------
 kernel/ucount.c         |  9 +++++----
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 0775b9ec952a..4c0836fb845b 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -78,7 +78,7 @@ static void dec_time_namespaces(struct ucounts *ucounts)
 static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 					  struct time_namespace *old_ns)
 {
-	struct time_namespace *ns;
+	struct time_namespace *time_ns;
 	struct ucounts *ucounts;
 	int err;
 
@@ -88,31 +88,31 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = kmalloc(sizeof(*ns), GFP_KERNEL_ACCOUNT);
-	if (!ns)
+	time_ns = kmalloc(sizeof(*time_ns), GFP_KERNEL_ACCOUNT);
+	if (!time_ns)
 		goto fail_dec;
 
-	refcount_set(&ns->ns.count, 1);
+	refcount_set(&time_ns->ns.count, 1);
 
-	ns->vvar_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!ns->vvar_page)
+	time_ns->vvar_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!time_ns->vvar_page)
 		goto fail_free;
 
-	err = ns_alloc_inum(&ns->ns);
+	err = ns_alloc_inum(&time_ns->ns);
 	if (err)
 		goto fail_free_page;
 
-	ns->ucounts = ucounts;
-	ns->ns.ops = &timens_operations;
-	ns->user_ns = get_user_ns(user_ns);
-	ns->offsets = old_ns->offsets;
-	ns->frozen_offsets = false;
-	return ns;
+	time_ns->ucounts = ucounts;
+	time_ns->ns.ops = &timens_operations;
+	time_ns->user_ns = get_user_ns(user_ns);
+	time_ns->offsets = old_ns->offsets;
+	time_ns->frozen_offsets = false;
+	return time_ns;
 
 fail_free_page:
-	__free_page(ns->vvar_page);
+	__free_page(time_ns->vvar_page);
 fail_free:
-	kfree(ns);
+	kfree(time_ns);
 fail_dec:
 	dec_time_namespaces(ucounts);
 fail:
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 8c07714ff27d..87a773e6ff15 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -164,7 +164,7 @@ struct ucounts *get_ucounts(struct ucounts *ucounts)
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
 	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
-	struct ucounts *ucounts, *new;
+	struct ucounts *ucounts, *new = NULL;
 	bool wrapped;
 
 	spin_lock_irq(&ucounts_lock);
@@ -182,9 +182,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 
 		spin_lock_irq(&ucounts_lock);
 		ucounts = find_ucounts(ns, uid, hashent);
-		if (ucounts) {
-			kfree(new);
-		} else {
+		if (!ucounts) {
 			hlist_add_head(&new->node, hashent);
 			get_user_ns(new->ns);
 			spin_unlock_irq(&ucounts_lock);
@@ -193,6 +191,9 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 	}
 	wrapped = !get_ucounts_or_wrap(ucounts);
 	spin_unlock_irq(&ucounts_lock);
+	if (new)
+		kfree(new);
+
 	if (wrapped) {
 		put_ucounts(ucounts);
 		return NULL;
-- 
2.45.2


