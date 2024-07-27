Return-Path: <linux-kernel+bounces-264107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263DF93DF08
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F39286BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546E413AA38;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pl+3Y21E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C174059
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078148; cv=none; b=dxxVHjCHytO6A3Rt68lpLiVf3NTSR2cUD0bsf3AQ+qUKCOyCUvqtXOftoFZqzC8C7NdrAy/qUMA8zVOF5G6k7MjhEVHsSvLBnevcpCq8ZZnzGkdnQO7YhpmQNns4uUpDAPozCZY0bj92ADxzdkBq+TXb8jvpN37QSyRPj1Q64gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078148; c=relaxed/simple;
	bh=vjHoXtu1Dr7ssLbAC37qswiXh7DpIvczSEIMZRk40yI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EMJeW7UCxqlrAR+VElno0J3P/MQnDN2bDGdzgDEELGkkFFI0qxvgY8scwhLnOzGQZXg5aSFJZ1Vzp3WdBvVRxo1FlpPfi28zfG1hhKLkMN1N6JkZnpzpZ/r0viFvevLFwSRhvmI9UxVwKcsTrzkO3yqaJpJ6UR8KA8y/LJPwsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pl+3Y21E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=AtyXK0mDyRpLR40IzL1aJmLNNAhRc7sK+9ltbHhK2LU=; b=Pl+3Y21Ej5c+sXuHRNBxTsoqM7
	FQz2D9AiI8yXct+F6d4ej5dwI6yzNEB66r/5nwc53doVsinvpMzcdz7LI0ZRjdjfGeWNoZ9wVFWDY
	AaPln+69YOIOkhWg6E68VapqWGyKhErFLqlyz6QRHLl4Zyeoc+ugZDpkpvcU/jRTB+GoIbAYmE70k
	zR+ML/6wlmUMmAXVZBPG2leIlen2SsZD4NCLiQz0fnd38zP1pvBQaKxA2rzqrlzhfuF8r8AKufBW/
	yJQZbht6CEDDWw4wSbt4flurGZ9/JMpmRhfX8YPPnP3msz4VUpG5Qy6vx/qZr6a1k5b5STzrnTMHG
	UPCcVlQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBf-0000000BGJM-2Yeg;
	Sat, 27 Jul 2024 11:02:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8FD7E3001AD; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105028.287790895@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 01/24] sched/eevdf: Add feature comments
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/features.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -5,7 +5,14 @@
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
 SCHED_FEAT(PLACE_LAG, true)
+/*
+ * Give new tasks half a slice to ease into the competition.
+ */
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+/*
+ * Inhibit (wakeup) preemption until the current task has either matched the
+ * 0-lag point or until is has exhausted it's slice.
+ */
 SCHED_FEAT(RUN_TO_PARITY, true)
 
 /*



