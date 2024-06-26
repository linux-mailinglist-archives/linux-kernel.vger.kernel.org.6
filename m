Return-Path: <linux-kernel+bounces-231081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56B89185DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0302D1C2098A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680F318C338;
	Wed, 26 Jun 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pv3rmoOC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93718C322
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415879; cv=none; b=GJRArkmnZJ1garbtN5Qx8GhIkDZJpuxpeTLgr2yphhvZi43Al4FXXitblx1kcP4pAGvG4spx7UnujUJAcVM1UOpofCAzhBXSj3XDxRsgkCklJ5oDMVwwFBjucx/I4z1BwxN7VSVUVZArrD9rxTMv9QGBfxZPsqn9wqAyISKEmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415879; c=relaxed/simple;
	bh=g2UyanIA1brZZ0AAppKl7b+Z3+5kebwYY6D2sODTWeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ripJNh+kHUaobmLx3ATXpJGLA9qg5qZToj1zAQKLH9P4W4IkiJtmosRuf12lpS/v33tAXsGzPlII66aydV1mR7sqBu9FKPoblyMkMUHVxDnX4+ulSra0xLdZWmhE3Bfxb3jlGHPa4diQoiNh8Q35H1GoPKXa3hHImQ7IIz4FBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pv3rmoOC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719415877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=03Wnrm5YRjbsE1n0WJWiQiBYlDzQZX4kOrh/KXilwy0=;
	b=Pv3rmoOC7bj+1GuRtYO44IYM060Mf2Q51lh4f02SukAB9AbggM32SYwc2Aj8w3k1ENeuBW
	wLsmNny5a1wTaFPicckocL42PxrY5CW63mvF6lg29fUZtilCKm8i2IzvCazmBwFCG4V6TD
	O/k6KM8XDesMc0K2rKbcN0qUnM9CcCE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-pjUci0qIPbeqbeLoxLVOkA-1; Wed,
 26 Jun 2024 11:31:11 -0400
X-MC-Unique: pjUci0qIPbeqbeLoxLVOkA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32B431956057;
	Wed, 26 Jun 2024 15:31:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.94])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 30FE81956087;
	Wed, 26 Jun 2024 15:31:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Jun 2024 17:29:35 +0200 (CEST)
Date: Wed, 26 Jun 2024 17:29:30 +0200
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
Subject: [PATCH 2/2] memcg: mm_update_next_owner: move for_each_thread() into
 try_to_set_owner()
Message-ID: <20240626152930.GA17936@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

mm_update_next_owner() checks the children / real_parent->children to
avoid the "everything else" loop in the likely case, but this won't work
if a child/sibling has a zombie leader with ->mm == NULL.

Move the for_each_thread() logic into try_to_set_owner(), if nothing else
this makes the children/siblings/everything searches more consistent.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/exit.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index a1ef5f23d5be..cc56edc1103e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -440,7 +440,7 @@ static void coredump_task_exit(struct task_struct *tsk)
 
 #ifdef CONFIG_MEMCG
 /* drops tasklist_lock if succeeds */
-static bool try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
+static bool __try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
 {
 	bool ret = false;
 
@@ -456,12 +456,28 @@ static bool try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
 	return ret;
 }
 
+static bool try_to_set_owner(struct task_struct *g, struct mm_struct *mm)
+{
+	struct task_struct *t;
+
+	for_each_thread(g, t) {
+		struct mm_struct *t_mm = READ_ONCE(t->mm);
+		if (t_mm == mm) {
+			if (__try_to_set_owner(t, mm))
+				return true;
+		} else if (t_mm)
+			break;
+	}
+
+	return false;
+}
+
 /*
  * A task is exiting.   If it owned this mm, find a new owner for the mm.
  */
 void mm_update_next_owner(struct mm_struct *mm)
 {
-	struct task_struct *c, *g, *p = current;
+	struct task_struct *g, *p = current;
 
 	/*
 	 * If the exiting or execing task is not the owner, it's
@@ -483,19 +499,17 @@ void mm_update_next_owner(struct mm_struct *mm)
 	/*
 	 * Search in the children
 	 */
-	list_for_each_entry(c, &p->children, sibling) {
-		if (c->mm == mm && try_to_set_owner(c, mm))
+	list_for_each_entry(g, &p->children, sibling) {
+		if (try_to_set_owner(g, mm))
 			goto ret;
 	}
-
 	/*
 	 * Search in the siblings
 	 */
-	list_for_each_entry(c, &p->real_parent->children, sibling) {
-		if (c->mm == mm && try_to_set_owner(c, mm))
+	list_for_each_entry(g, &p->real_parent->children, sibling) {
+		if (try_to_set_owner(g, mm))
 			goto ret;
 	}
-
 	/*
 	 * Search through everything else, we should not get here often.
 	 */
@@ -504,14 +518,8 @@ void mm_update_next_owner(struct mm_struct *mm)
 			break;
 		if (g->flags & PF_KTHREAD)
 			continue;
-		for_each_thread(g, c) {
-			struct mm_struct *c_mm = READ_ONCE(c->mm);
-			if (c_mm == mm) {
-				if (try_to_set_owner(c, mm))
-					goto ret;
-			} else if (c_mm)
-				break;
-		}
+		if (try_to_set_owner(g, mm))
+			goto ret;
 	}
 	read_unlock(&tasklist_lock);
 	/*
-- 
2.25.1.362.g51ebf55


