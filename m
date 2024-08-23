Return-Path: <linux-kernel+bounces-299514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33B95D5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3240F1F23743
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137DC13A41A;
	Fri, 23 Aug 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CyZAz0WI"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F018BBA2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439651; cv=none; b=TPMN/iMgRXOztjGozaPvvZaQFciNPGMImx7vf/yDkufDwUX/+/756Dtyy/ADxlLBHKteUGlmzeeQ7fXU8D9rOfsVAqX1Gl+fyxMcf5qlKfeyvv232NjN7A3QDdAZw3lkWwVH4NbtC77L2t8iJIW4IqEmtFHM1hNST80+fhSvXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439651; c=relaxed/simple;
	bh=iKticH+hVtk0Jsn+Z4/9YfNt/Gnnukcx5t9hJyZ9KVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWCwE7gDP91vKdBX5CdIyitopt4MY/7MEyGkTUkJ2Ce1T4WmWcRDbSyqVtW88wStQ8Mzn0e8BlFHioiYE6TGEeLUQdtRWdKKhYmi+qGegicDwmzE6IavL2aDnL5znjrbn0CGQVH2FIfSJFXoePqXqfmzdbOVb98IIsjbuo431do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CyZAz0WI; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724439621;
	bh=iKticH+hVtk0Jsn+Z4/9YfNt/Gnnukcx5t9hJyZ9KVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyZAz0WIV5x2VKCuTn/N3QmZJ+nn4Ykk3Ks6/eOlBC1I91BwfI2OJmZKcCsQUtaEx
	 UWUiEUeyvmVYeYBRLEitBQP65nX8wxKmHlqYZdWEwLOFqNMV8wnjRiaq8FglxO994B
	 +rhIUpNbVX6WHnf90xMdvRN8Q22eHDv8goQy7bSyDM+hxVel3oWQscMj/YrQtCQsDE
	 OGuLldOmyuJTWECy6OfDbRRUpKL1hVFSp364rICykk0YTDqloUAaDszcELbJ3M4/JF
	 0nBUIxgpHJyfy5qQiqkXqQ/w1QpvgG4Hi02IfjqjTYQtgJ1t1Cg7Xl+loRpO7WHb6M
	 GP3Cu2qGeZ2+g==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:b243:804e:3bbd:91c9])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wr8XP5g0xz1J2p;
	Fri, 23 Aug 2024 15:00:21 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [RFC PATCH v1 1/6] lib: Clarify comment on top of find_next_andnot_bit
Date: Fri, 23 Aug 2024 14:59:41 -0400
Message-Id: <20240823185946.418340-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the comment on top of find_next_andnot_bit clearer by discussing in
terms of "cleared bits" rather than "excluding bits".

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/find.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5dfca4225fef..8a170aa55634 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -102,15 +102,14 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 
 #ifndef find_next_andnot_bit
 /**
- * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
- *                        in *addr2
+ * find_next_andnot_bit - find the next set bit in *addr1, cleared in *addr2
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
  * @size: The bitmap size in bits
  * @offset: The bitnumber to start searching at
  *
- * Returns the bit number for the next set bit
- * If no bits are set, returns @size.
+ * Returns the bit number for the next bit set in *addr1, cleared in *addr2.
+ * If no such bits are found, returns @size.
  */
 static inline
 unsigned long find_next_andnot_bit(const unsigned long *addr1,
-- 
2.39.2


