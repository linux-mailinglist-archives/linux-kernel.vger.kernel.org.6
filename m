Return-Path: <linux-kernel+bounces-199134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7128D82CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AEE1F228AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6C12C522;
	Mon,  3 Jun 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IGilUei6"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133784A50
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419051; cv=none; b=i1dolOWs6jO6/8AZhblaDG6+D/sDr/5z1+i6yagrfiJaeddYpIcgUPpoJVkZGcJHRD7597wW4+mSIn6Yf0fy9LuhvecKX04wqFlr8vOtvFBEd8knVvrQKbkIgcn7XT3hFoIE4TpyE1olpAv8Pwnp2sCXYnBCDDIP8yCJlT+A9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419051; c=relaxed/simple;
	bh=3BYPVC4YThFdXa5JfdudgN18OixigWcVZ3no0Fj6kP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWVmlfKFJ0NJ94kE7U6Y5cLAr4frSy7AfjhQqMrk2HIpjRlPNu2AVevtbn9QTpSSalrR7hvz8KQ+r957+CBKqJyUkrQdK0fNTRyvxMwfoEKfyHaN28hXcTxwYoeBDlYqtSbolviO8er7MqWX/daEJslrBV2fi49mv6ivoJA4ipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IGilUei6; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mingo@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717419047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPvKdZkt6zfC2DIFe80EwNgQmao8ZMFweg+CO3/w42k=;
	b=IGilUei6dnciBL8aKrEXf3lD4001GHR7cGTjfOBvr35bn77m3YpRWQ3NR+h5eIM7bi3N1E
	TfzShZ5iOnBUH0r6Lx65XOk+gsWp6iRs/a+CgIrpVgoYHbihHoiB0GmLb7eHcoFc2J6YCE
	zgWAMfW78uhGeyyBbT4DXKqhZY42jVU=
X-Envelope-To: peterz@infradead.org
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: bristot@redhat.com
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
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
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 2/2] sched/headers: Move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block
Date: Mon,  3 Jun 2024 20:50:02 +0800
Message-Id: <20240603125002.3086-3-yajun.deng@linux.dev>
In-Reply-To: <20240603125002.3086-1-yajun.deng@linux.dev>
References: <20240603125002.3086-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We already remove the call to the 'back' member when CONFIG_RT_GROUP_SCHED
is disabled.

It's safe to move sched_rt_entity::back to under the
CONFIG_RT_GROUP_SCHED block, it would save a few bytes.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..3af89a67fb61 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -582,8 +582,8 @@ struct sched_rt_entity {
 	unsigned short			on_rq;
 	unsigned short			on_list;
 
-	struct sched_rt_entity		*back;
 #ifdef CONFIG_RT_GROUP_SCHED
+	struct sched_rt_entity		*back;
 	struct sched_rt_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct rt_rq			*rt_rq;
-- 
2.25.1


