Return-Path: <linux-kernel+bounces-231080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB559185DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A3128C3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48A18A94A;
	Wed, 26 Jun 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vtb3gQ+D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC9177998
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415876; cv=none; b=klvfYkOC9/ddB+Rkl/tSOjQB4ues3a5oHOrB74sW5QdPTyRjJGj3Buv6L/2v8Yi84hsPAZ5C3uHot15R2F9jkgX1azEp0eLdzUWaF1FZAPCvGYmfKRpkFDGSWjOzFOHfsNgNuvTbiRThQi4HJq5UPqbMDjFF49mTU03tbDDUwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415876; c=relaxed/simple;
	bh=A44+haS0ogOcovAsrTvZz6KwI9aZDCle6FMP44S65f0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RIO622CPDtw5TG4UCMOQcX/j148mRTJfz+ZTpvh9GHz6hlvSOiMK4AQKQgqExc1svJQAzHNYUDaXLr2ajwI6mwOAFcLGQtjdcQ+1sbeiM2DMPyPfutUU0mzM7KbZyfubRJSLgxXd3WlYhSeZPVY9N/32hFPPCbL2trCbHUXlaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vtb3gQ+D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719415873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=xG79oUfDfsEVibBMciuKOQEduN1A78RdRi7KI1lmE6w=;
	b=Vtb3gQ+DwKu87noID/udrwkfvG+XJupLpAUNsWR2nWAO+8GyLPW2cZwQd5uaVIPisgWTjd
	bOtzeAcY2OSVle2X0c3ckksfNiVjlfLPuvTdoK+COioDPezuRJAZ3SrnBFWzMcFGxQeK8e
	gKjxcTSJeX9b/S1oF2jYqwN25wIgdLI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-bDtvoUNXNr60LU_1d4RpxA-1; Wed,
 26 Jun 2024 11:31:06 -0400
X-MC-Unique: bDtvoUNXNr60LU_1d4RpxA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 117A1195606C;
	Wed, 26 Jun 2024 15:31:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 756DC300021A;
	Wed, 26 Jun 2024 15:30:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Jun 2024 17:29:29 +0200 (CEST)
Date: Wed, 26 Jun 2024 17:29:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] memcg: mm_update_next_owner: kill the "retry" logic
Message-ID: <20240626152924.GA17933@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626152835.GA17910@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add the new helper, try_to_set_owner(), which tries to update mm->owner
once we see c->mm == mm. This way mm_update_next_owner() doesn't need to
restart the list_for_each_entry/for_each_process loops from the very
beginning if it races with exit/exec, it can just continue.

Unlike the current code, try_to_set_owner() re-checks tsk->mm == mm
before it drops tasklist_lock, so it doesn't need get/put_task_struct().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/exit.c | 57 ++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 45210443e68d..a1ef5f23d5be 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -439,6 +439,23 @@ static void coredump_task_exit(struct task_struct *tsk)
 }
 
 #ifdef CONFIG_MEMCG
+/* drops tasklist_lock if succeeds */
+static bool try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
+{
+	bool ret = false;
+
+	task_lock(tsk);
+	if (likely(tsk->mm == mm)) {
+		/* tsk can't pass exit_mm/exec_mmap and exit */
+		read_unlock(&tasklist_lock);
+		WRITE_ONCE(mm->owner, tsk);
+		lru_gen_migrate_mm(mm);
+		ret = true;
+	}
+	task_unlock(tsk);
+	return ret;
+}
+
 /*
  * A task is exiting.   If it owned this mm, find a new owner for the mm.
  */
@@ -446,7 +463,6 @@ void mm_update_next_owner(struct mm_struct *mm)
 {
 	struct task_struct *c, *g, *p = current;
 
-retry:
 	/*
 	 * If the exiting or execing task is not the owner, it's
 	 * someone else's problem.
@@ -468,16 +484,16 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 * Search in the children
 	 */
 	list_for_each_entry(c, &p->children, sibling) {
-		if (c->mm == mm)
-			goto assign_new_owner;
+		if (c->mm == mm && try_to_set_owner(c, mm))
+			goto ret;
 	}
 
 	/*
 	 * Search in the siblings
 	 */
 	list_for_each_entry(c, &p->real_parent->children, sibling) {
-		if (c->mm == mm)
-			goto assign_new_owner;
+		if (c->mm == mm && try_to_set_owner(c, mm))
+			goto ret;
 	}
 
 	/*
@@ -489,9 +505,11 @@ void mm_update_next_owner(struct mm_struct *mm)
 		if (g->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(g, c) {
-			if (c->mm == mm)
-				goto assign_new_owner;
-			if (c->mm)
+			struct mm_struct *c_mm = READ_ONCE(c->mm);
+			if (c_mm == mm) {
+				if (try_to_set_owner(c, mm))
+					goto ret;
+			} else if (c_mm)
 				break;
 		}
 	}
@@ -502,30 +520,9 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 * ptrace or page migration (get_task_mm()).  Mark owner as NULL.
 	 */
 	WRITE_ONCE(mm->owner, NULL);
+ ret:
 	return;
 
-assign_new_owner:
-	BUG_ON(c == p);
-	get_task_struct(c);
-	/*
-	 * The task_lock protects c->mm from changing.
-	 * We always want mm->owner->mm == mm
-	 */
-	task_lock(c);
-	/*
-	 * Delay read_unlock() till we have the task_lock()
-	 * to ensure that c does not slip away underneath us
-	 */
-	read_unlock(&tasklist_lock);
-	if (c->mm != mm) {
-		task_unlock(c);
-		put_task_struct(c);
-		goto retry;
-	}
-	WRITE_ONCE(mm->owner, c);
-	lru_gen_migrate_mm(mm);
-	task_unlock(c);
-	put_task_struct(c);
 }
 #endif /* CONFIG_MEMCG */
 
-- 
2.25.1.362.g51ebf55


