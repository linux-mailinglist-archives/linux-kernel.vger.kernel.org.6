Return-Path: <linux-kernel+bounces-246693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499F92C53C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219C4B21E35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E84F187861;
	Tue,  9 Jul 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmzIxRlM"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D03185633
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560106; cv=none; b=Lx71ot5NX4BdkTGtGap9Gz8mb3QxkmzOA+nkZ9pq+akclUOvQapTrgv6QMLXTDvQnu99fsDMP10t78UsbXgn+YKQ/QdQDRrDboLDo/aipdOsgm7YEg4kDtq3cIEfN0z4xxEkbx+K6i6pCJHpXwZoLr+LjG5vC5H32pmfUx4cJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560106; c=relaxed/simple;
	bh=UjAS7xhj1kJlR2pC8MCrIipRDWswcycXLVCXW8j4a9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMcQs08StyBgCcuQnjyJ3OQc404qLtZVjv44sul3xaQoJXHS+xGQx8f0uW3oVsoHOpd900RjXEEn9Z27dhrxUaQSaib2ME9FoTKPAvttetbkotlWUqFJ9/AZSzMsML868YOhBMFRIVIMdMBMp6mhEIBlRWZsEvD6f07ySgPNa2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmzIxRlM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-75fe9e62048so3055058a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560104; x=1721164904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHZt8zYirHGzB6KZVQgqYt3EBA1b2bsAuxlpnVayEx4=;
        b=GmzIxRlMe+xUIMc2nszZjiSDn2WbVW/u8Qv+kBeGkEpm9dKVKlBUiW1GDCRgcN3C8M
         eUKLvUU3f/i/s50OaG9BGrHVxsYcZ41q1RpgqGeeYTs8r6O1HQFVRCBKmef5SrvLH1+H
         w0nsBWTJvL8em6x+N1IO78Eu6QTuPlnpbvTIcOzV0o0uBXOOj3KD7rZnmFIKN0nV8Ifb
         HiENKxiyFmItIzZnWKXDInTUkJ4uPm36xRm4ceeKdjrDun/r6Ii6Ir72dzQfEfMOzYv+
         ENkXfTzI6DXv/OmjpknSAZC9eBJnptfYoGfIy/eXYIck7s2GjfbK7XccDuqrQV77uvJB
         7bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560104; x=1721164904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHZt8zYirHGzB6KZVQgqYt3EBA1b2bsAuxlpnVayEx4=;
        b=jS4691nOURfSnYahivdGq5fY7CV/m7/2lP6H8gZ0t1rKWlXdBZq5kwQOph/NghNJQD
         iDWZCyCFvNIsQc5iM+DmlWc2fQgPBPdUSrQiCQrHUDK7oiz4YVUNT0aU/VFoxSVrnEG7
         rELdixvfxe6rX9H1U9EioU0YMnoYVO8V/gPUTzO2pDJYIDCBYquyxQPrtfh/XZ3H62rW
         ynCwutSyl4GMRjPttHOj67aB9SGdRMFNwq82RM+aWH/PPQaBZBjFL5qn6pc5EVenCHSx
         aXzt92kZD3rl/lNsgje6GhL7Vhep82A8AMfjYV8dmNsGtwmxxmUWR8+B9NordvHw5Lre
         FakQ==
X-Gm-Message-State: AOJu0YxRrvHPzROnyB7Ycu5rmaMNsMnsk+m8svD5FRfvvJ/+7cR7au2J
	12LCzyqfaXdJtHnrwHZpOWbJQwglMbuadY9btCK37PacAz/mH4oQ
X-Google-Smtp-Source: AGHT+IEYvv130Yw62y+e4aZLEIST69k5sYUpXo5do/ZWvPb4jNsdqLrUepzgthgoBdctn+DcmrFiFg==
X-Received: by 2002:a05:6a20:8402:b0:1bd:25a6:842f with SMTP id adf61e73a8af0-1c2984c8784mr4246981637.41.1720560104394;
        Tue, 09 Jul 2024 14:21:44 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac0fdcsm20483595ad.206.2024.07.09.14.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:21:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] sched_ext: Open-code task_linked_on_dsq()
Date: Tue,  9 Jul 2024 11:21:08 -1000
Message-ID: <20240709212137.1199269-3-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709212137.1199269-1-tj@kernel.org>
References: <20240709212137.1199269-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_linked_on_dsq() exists as a helper becauase it used to test both the
rbtree and list nodes. It now only tests the list node and the list node
will soon be used for something else too. The helper doesn't improve
anything materially and the naming will become confusing. Open-code the list
node testing and remove task_linked_on_dsq()

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f16d72d72635..52340ac8038f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1572,18 +1572,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	list_del_init(&p->scx.dsq_list.node);
 }
 
-static bool task_linked_on_dsq(struct task_struct *p)
-{
-	return !list_empty(&p->scx.dsq_list.node);
-}
-
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
 	bool is_local = dsq == &rq->scx.local_dsq;
 
 	if (!dsq) {
-		WARN_ON_ONCE(task_linked_on_dsq(p));
+		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
 		/*
 		 * When dispatching directly from the BPF scheduler to a local
 		 * DSQ, the task isn't associated with any DSQ but
@@ -1604,7 +1599,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
-		WARN_ON_ONCE(!task_linked_on_dsq(p));
+		WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
 		task_unlink_from_dsq(p, dsq);
 		dsq_mod_nr(dsq, -1);
 	} else {
@@ -1614,7 +1609,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
 		 * the race.
 		 */
-		WARN_ON_ONCE(task_linked_on_dsq(p));
+		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
 		p->scx.holding_cpu = -1;
 	}
 	p->scx.dsq = NULL;
-- 
2.45.2


