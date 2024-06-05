Return-Path: <linux-kernel+bounces-202721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAAC8FD002
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741FD291AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0D419D09A;
	Wed,  5 Jun 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qjgi2YWg"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE651990D9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594600; cv=none; b=jUxkKzQjCmi1Od3Ye7gk2mdV8rIjFMs3Eu9PLwkNJNH+OlyN1ktXRnUvBucWc2BtY10HjdOzI/rKYks5bRoA8jqPvKDoinLT4IdIKZj7HKJxHGYIokmB845CR1rBTtIQ7yUJv+SnB7f72hrgZcY2fFY4u0c7SWKL+t/QWkG3F2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594600; c=relaxed/simple;
	bh=AMGDh5gB31KKjo78UTuKU/rfo74RxSemaf7ku6dSHpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m36c6TaUEbwPMWMJTTroKBfb7qeYTzerakrOuQYPjFah6OIJT7fh8Pft3QM7SRTtopQTegEl3arbr6mF4mQCGQ6dFtLThTvwXHybOyaHAvHQ2Lgnj1lwl0uXk/wJlaRCh/g+5Wvx6GmfI0LMU1Gs6h6gQw2MjaNCceaDfvmXlA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qjgi2YWg; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mingo@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717594597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdq+/qHHpUB/C0eIIEKLyIhJ7ATCqVUoFBhHCKfFrD8=;
	b=Qjgi2YWgWWvwB3tN5Zfie3XWfdYOtPRtM5tmuPYjcrpmW7gSpB+/Ue9JHWdAN3y9oL8r8g
	fYhxe7OA2jYm6Cse93teJEVhizn+SSvkBlD941EucPXlY49U39xoByKSjrunI9Ke2YfSSh
	okYZUYDEEbLao4nn09GKzsIY+5AbVAM=
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
Subject: [PATCH v2 2/2] sched/headers: Move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block
Date: Wed,  5 Jun 2024 21:35:57 +0800
Message-Id: <20240605133557.2984-3-yajun.deng@linux.dev>
In-Reply-To: <20240605133557.2984-1-yajun.deng@linux.dev>
References: <20240605133557.2984-1-yajun.deng@linux.dev>
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
index f2f907ef1389..79d3bdda9463 100644
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


