Return-Path: <linux-kernel+bounces-248479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587D92DDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7641F21C11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441D179B2;
	Thu, 11 Jul 2024 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYoqHWyJ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDCE572
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660482; cv=none; b=Eh386K25PAFAPUp+Q/o2OxS0P93R/JqJTMue4nyFG7QV2slYvM1chRqXC4HqI0kXMs/3bc015KFz4xdF3He9Xs4hvOAxNKunsBr76H0iHVeccSTKQfTqQ0We3/9IldMkYOpLjHWxlin4Rh/H4zsRjksNGXTdH3rTR1PyPUMGIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660482; c=relaxed/simple;
	bh=1aXNXvJjMQiXhUkZjaUr11rPZrOQpf8tLMrqL1f89SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra4WFfCZKf0Tg9oBetfLtsHhVObqK7Yw4WHGgMvNc9ozH6sMKUANDaHfDqPOX+jjnxvKY+ISe7wRwlXyE8Qiis1MqqiecypQvyNKGmP+vKU1xM3qWADeWhJ+xaTSnCJX4piiTupenrFmBy5Hp6JnD4h6tT0KCcNoKyKuHyvr+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYoqHWyJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b12572bd8so351980b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720660480; x=1721265280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn/fXyFQV3mV8M7gdgHKa+/HuqVak7NY1Nqfj+w7qOc=;
        b=QYoqHWyJaF6D4hqj/dF3GIzmTZuRL2+6naCpfqNC7to7RXYgP//pOEzcWn6DclpULS
         FNc2ZN5lMNLSBLV+qHwIEE3JtV0cnxrjIZ5yOzTq7kcJa/QYQNMk1LyUFWsKkceW4rJZ
         sG8lUWQ0xSDDJzlO8v4/Mj3u1scrMLoZDXLCpICSQ1x16MD0P3qPFma5WiNcVe/REoBi
         ACth7hF54n1ymqJZ8hjLCdSwABSciqZV3PVFOP3fyWxqHWdSKKEDx7hc9r6G1JyolFph
         D1SKSipDGhOgCKPtrc10MYMGMk0lJlPNPlxfpKjjo82GOZLR+Ymc8EB+br4Cy/QMQez8
         h4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720660480; x=1721265280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cn/fXyFQV3mV8M7gdgHKa+/HuqVak7NY1Nqfj+w7qOc=;
        b=vqW/JfmxtQCuB86Uk1R/gb4AiP35JaCXCsxeH81Z2OZr9HRahmCwWHiwshZFwLwq3X
         hnatH6MkkigkiIQysmxmdcq4KBLy+/9OSVyhD573iHHMg7mq3QG6XTSgUF9LHs21/ss5
         JCYXNTAzoGFXIqAm97JZ8QzXGUYoKRLdw45gSt1VClC4tbvPLF/pmLMiWsnZ/Vsb2rnX
         ym/8Yfjtbmn2x/0hqg0EjnbWYemidFbBqzVVRSxeqmEQGJV2dRrByIOTj+Xk87Kuqsxg
         O/CXSDCCqs06mfi1PlZtCarhIQfCLW++Wm+foZXso41q78On2VoB8o3fBBbrgQtHZTyJ
         ToZg==
X-Gm-Message-State: AOJu0YxKRHVXsiwfglyNZGEHIaj5QY7H0i/p74IYSJhzqgVEAy+aATDw
	b596Tbc71zOxj0i82XQByqGavvMTQ9EIF+551a2Fen37K6rqsuOL4OmsOQ==
X-Google-Smtp-Source: AGHT+IFoAxs5GxfEMP0/fn8hbAqvmVIBNb3Gg/Cfg0bJm16yH6ff0183cH+WfObetMDj6PdveWknxA==
X-Received: by 2002:a05:6a20:258d:b0:1c0:f2a5:c8f1 with SMTP id adf61e73a8af0-1c2982163b2mr8655363637.11.1720660479979;
        Wed, 10 Jul 2024 18:14:39 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa621e7sm12551827a91.41.2024.07.10.18.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 18:14:39 -0700 (PDT)
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
Date: Wed, 10 Jul 2024 15:13:59 -1000
Message-ID: <20240711011434.1421572-3-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711011434.1421572-1-tj@kernel.org>
References: <20240711011434.1421572-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_linked_on_dsq() exists as a helper because it used to test both the
rbtree and list nodes. It now only tests the list node and the list node
will soon be used for something else too. The helper doesn't improve
anything materially and the naming will become confusing. Open-code the list
node testing and remove task_linked_on_dsq()

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f4a7abcec793..62574d980409 100644
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


