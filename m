Return-Path: <linux-kernel+bounces-220871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BA290E86A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11D91C22439
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4912D758;
	Wed, 19 Jun 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR5JMDnP"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB28627D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793416; cv=none; b=aK/7oAcR+UVuPjzckieSaWn5JwG4jXEYThiTtiluPSO65Ndgy3sdcMmjv3woiFtrEwDZB3Mt/K60PQHdbJX5sf1VHby/U+R4oxKQXN+mEYkRQGSPSjmUGmI22Mo1gLMhJPsVSUFvyQjhOsQUulO1mgzfQYIj5EXAhD/mR8THo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793416; c=relaxed/simple;
	bh=V+zkefgG2yB/b4EnpDYiGPTNbaPWxrXT6lHEYgMVupg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S5WsKnQ5bjYUuAHI+hlZbCD8hWTyJhXXg7RlJrr7OxsgKFy5gKpNuYf6Z3IiwExss9DJKnqUHt8eU6DQx6NeBEpqOQVgH3JL/iigmya2e5ZyoKObYKgTTWFZa9FerRFjePreUXzGxEvtNIqWh0BsCUXrlIOVCOHSXpV5Mdlh8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR5JMDnP; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-250c0555a63so3132703fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718793413; x=1719398213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hurYq2hqrfaP8z7IMDpEb001Nq0f8ICX75CeBzd/9Fc=;
        b=HR5JMDnPi7m82EF4c4ZaNL/gy1ER209UsTqa95VQ6cX2TXKBca1maAwKm9e4vuK/cy
         PcXRVumtdDslawvlJyiCstlsYXccKJMOec9FlYg24TJwqo6lRV4QvIrbe8obMnPhEM72
         hpcevxWnF14LuBY0qV56QALMRlBYeOLWRjBtkEihmaqAVBO3GchRLxaIZayYytvvvhDc
         q0mwquLWI67mcVOCkcnVOmryL+dXPU7zflN8tHMrxdz7+SdK8HBkMUMMT2Ao3KaSPGXm
         t6zP8p8GQtnx98/bd9J9m8mULksXwNcxuhx324UQG1ZjqgQTnT+A4qxwqADTqIZhk3zd
         ihog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718793413; x=1719398213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hurYq2hqrfaP8z7IMDpEb001Nq0f8ICX75CeBzd/9Fc=;
        b=TCb/9oyRHzuOLDVfobsmrnhYtw8UJmzAFHKzL9o/1aeatMbHeMpxWXmSRacI5HODo2
         YsRD1Clr9isMZkmzqUXEC3iQSlSIYa3/zCja5uMN2uzCWvtzOxr3DewoAx0GQNGOqRA3
         7YtpI3HLyXgapZOZ5ZdOJ49F6B3QWUhILyGUYaU1XaUPD2q+Pe70gLLqt54s6BUEBwsM
         4GI6SVhCXgoLJScTmeATVBniZZyoDjANOj5ooXiwsWCKzU02pO3TKoXvknHh/OBT96g/
         auIrkD8je1Oh5DndrxyUyBRVmUUPBs58eHTS7nfTCSm6tjTthEp69deqvm42imJD26Nc
         zdyw==
X-Gm-Message-State: AOJu0YxOjCXg74an2lkMB0Ho26QMr9oQkF+Y2GzTdnhNnvGUOItPsGOQ
	JJGiPYoN/Gmc40W4bzOmOEZTSP7On/9x14rlwqN2y30TDuC4UIrHHXuAaw==
X-Google-Smtp-Source: AGHT+IFiF5ZX/hZdd1S7dWVoxbV2R7P9VtDX+sdiklBpNbkJCa7s/4Ib+p8BbrWfXHuoHdoDstr/iA==
X-Received: by 2002:a05:6870:b69e:b0:254:b0b0:9328 with SMTP id 586e51a60fabf-25c948eda87mr2399117fac.4.1718793412798;
        Wed, 19 Jun 2024 03:36:52 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96aee8sm10357692b3a.73.2024.06.19.03.36.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:36:52 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Avoid nr_active manipulation in grabbing inactive items
Date: Wed, 19 Jun 2024 18:39:34 +0800
Message-Id: <20240619103934.2701-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Current try_to_grab_pending() activates the inactive item and
subsequently treats it as though it were a standard activated item.

This approach prevents duplicating handling logic for both active and
inactive items, yet the premature activation of an inactive item
triggers trace_workqueue_activate_work(), yielding an unintended user
space visible side effect.

And the unnecessary increment of the nr_active, which is not a simple
counter now, followed by a counteracted decrement, is inefficient and
complicates the code.

Just remove the nr_active manipulation code in grabbing inactive items.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 003474c9a77d..25a7d9a1a7ae 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1683,33 +1683,6 @@ static void __pwq_activate_work(struct pool_workqueue *pwq,
 	__clear_bit(WORK_STRUCT_INACTIVE_BIT, wdb);
 }
 
-/**
- * pwq_activate_work - Activate a work item if inactive
- * @pwq: pool_workqueue @work belongs to
- * @work: work item to activate
- *
- * Returns %true if activated. %false if already active.
- */
-static bool pwq_activate_work(struct pool_workqueue *pwq,
-			      struct work_struct *work)
-{
-	struct worker_pool *pool = pwq->pool;
-	struct wq_node_nr_active *nna;
-
-	lockdep_assert_held(&pool->lock);
-
-	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
-		return false;
-
-	nna = wq_node_nr_active(pwq->wq, pool->node);
-	if (nna)
-		atomic_inc(&nna->nr);
-
-	pwq->nr_active++;
-	__pwq_activate_work(pwq, work);
-	return true;
-}
-
 static bool tryinc_node_nr_active(struct wq_node_nr_active *nna)
 {
 	int max = READ_ONCE(nna->max);
@@ -2116,7 +2089,7 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 	 */
 	pwq = get_work_pwq(work);
 	if (pwq && pwq->pool == pool) {
-		unsigned long work_data;
+		unsigned long work_data = *work_data_bits(work);
 
 		debug_work_deactivate(work);
 
@@ -2125,13 +2098,17 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 		 * pwq->inactive_works since a queued barrier can't be
 		 * canceled (see the comments in insert_wq_barrier()).
 		 *
-		 * An inactive work item cannot be grabbed directly because
+		 * An inactive work item cannot be deleted directly because
 		 * it might have linked barrier work items which, if left
 		 * on the inactive_works list, will confuse pwq->nr_active
-		 * management later on and cause stall.  Make sure the work
-		 * item is activated before grabbing.
+		 * management later on and cause stall.  Move the linked
+		 * barrier work items to the worklist when deleting the grabbed
+		 * item. Also keep WORK_STRUCT_INACTIVE in work_data, so that
+		 * it doesn't participate in nr_active management in later
+		 * pwq_dec_nr_in_flight().
 		 */
-		pwq_activate_work(pwq, work);
+		if (work_data & WORK_STRUCT_INACTIVE)
+			move_linked_works(work, &pwq->pool->worklist, NULL);
 
 		list_del_init(&work->entry);
 
@@ -2139,7 +2116,6 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 		 * work->data points to pwq iff queued. Let's point to pool. As
 		 * this destroys work->data needed by the next step, stash it.
 		 */
-		work_data = *work_data_bits(work);
 		set_work_pool_and_keep_pending(work, pool->id,
 					       pool_offq_flags(pool));
 
-- 
2.19.1.6.gb485710b


