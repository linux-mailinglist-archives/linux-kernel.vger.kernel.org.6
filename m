Return-Path: <linux-kernel+bounces-191874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391708D1568
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84C6283615
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C073447;
	Tue, 28 May 2024 07:37:32 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 17D271DA22
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881851; cv=none; b=ecuEOyAO5w7/o6CnpqrQnafC++fQPw2Hh1B6u3c+f7Wyh+ZEhqo16i5R4jtEO/RuZDScGey0XldNogidN6qptFQqLVSf0WBSm9XUTH4RFlfNTH4kn1KQC0PpJdcLjAV3OuZGExavYn8PzYsIvQJTUCoFl0XaupYkWVL3FEv/Ojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881851; c=relaxed/simple;
	bh=reydI0Zzb5ykD65028vaNZb7IJixOUn5HdRpqepKeYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ox9jDKHY/NoD0kMzti74C5ADrpWWbFMM3HSHjuesu12MHpUQ/4ttKG2JM4diCt0JTowLFJq4DBEfFqSDxAoD6YXPjhUEdZBeSjIMrG06tcTMnzHu3KG3TeSxCpD3RfPYjKvir/icvhBI1HpH0Pvbot49oPTgvXAUTtPYeHHeEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 313A06372B503;
	Tue, 28 May 2024 15:37:24 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?sched:=20core:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date: Tue, 28 May 2024 15:36:46 +0800
Message-Id: <20240528073647.71929-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 346159a24705..140e6373fce2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10808,7 +10808,7 @@ static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 				u64 burst)
 {
-	int i, ret = 0, runtime_enabled, runtime_was_enabled;
+	int i, ret, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
 
 	if (tg == &root_task_group)
-- 
2.18.2


