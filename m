Return-Path: <linux-kernel+bounces-570365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E33A6AF69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F7D188F671
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08E229B28;
	Thu, 20 Mar 2025 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b="RZtq2Feb"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014B1C68B6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504036; cv=none; b=L6jQI/74/A+2PXXhFkNivlKnvRptbSFLlByil2JsVgLyThn6bFAssYLoFIb53RynH8qyuzdCrMDNfgFpR2iKt+erHd/VLWemmmqNs5Mtmt38/byoxu+aqtPwT0+cE77p2F4ZpJGqYX2PLSb8fy66Yf06QbU/WltPdAr+U//tVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504036; c=relaxed/simple;
	bh=OYwOGCVxHfD3Facncy2Z5BmWqZzNmxM1NlJCuYfgUS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mV4YAuBy1JkHcGSIWrTTgGD4tHdMnCc/adixN/ufUGpaUvsTkmV5bQCw8wezJLdky/AEftYXjGN7AJiOO1AmSo70CnK+MVujba5WoZDQsdFfTHHBiQjqk4Ju1XaF/9UzQFsR2IDfVs4TPKKzjraznZm/2a1R1BgfUXSOY/NTe6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io; spf=pass smtp.mailfrom=patcody.io; dkim=pass (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b=RZtq2Feb; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=patcody.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=patcody.io;
	s=protonmail; t=1742504016; x=1742763216;
	bh=bu/GkZMAgTrYSPXIW3+XiGbJpc6DMcnwFJCuLanXnYk=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=RZtq2FebTYalPAad6AIoa0jBdQjIUWZL96CtmGfHlhTatx1xUFH1O6tFGkffD+48u
	 tZcFSPMe8IaAw0Ad35GL/aIu3GnqnyOVvnddrxkAAJghTjoxnbTh+Lp8Jsh7JzkSqT
	 Bo3DsM/50i5QAzb8gMuZUsJJQzwOwOIlzFb0T6txtlTPiB7Cy+/BmxvvBPH/Tijq2c
	 +IwekDK1J5Ja5L114RgzM7J3/8pNHOKYoI2aSumEqR2w23xe9urhnRB3WYD9LZBsVE
	 s53AWeD/nUWmvPYU+gq6PJLS7ANI3ovhuMwt0i+QKEF2k0NGltm/QAlfAsaT/sRsvk
	 7fGZ8Hk/YL+7w==
X-Pm-Submission-Id: 4ZJd8b4zZDz4wxB8
From: Pat Cody <pat@patcody.io>
To: mingo@redhat.com
Cc: peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	riel@surriel.com,
	patcody@meta.com,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Date: Thu, 20 Mar 2025 13:53:10 -0700
Message-ID: <20250320205310.779888-1-pat@patcody.io>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pick_eevdf() can return null, resulting in a null pointer dereference
crash in pick_next_entity()

The other call site of pick_eevdf() can already handle a null pointer,
and pick_next_entity() can already return null as well. Add an extra
check to handle the null return here.

Cc: stable@vger.kernel.org
Fixes: f12e148892ed ("sched/fair: Prepare pick_next_task() for delayed dequeue")
Signed-off-by: Pat Cody <pat@patcody.io>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a553181dc764..f2157298cbce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5560,6 +5560,8 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	}
 
 	struct sched_entity *se = pick_eevdf(cfs_rq);
+	if (!se)
+		return NULL;
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
-- 
2.47.1


