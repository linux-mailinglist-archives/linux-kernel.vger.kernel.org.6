Return-Path: <linux-kernel+bounces-353895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153F1993409
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB3E1C23A70
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AB1DE892;
	Mon,  7 Oct 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pg/EqtzB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQKdwfKM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B81DE4E0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319822; cv=none; b=s8g0vxL2M/V0oVWQbbXjFBZhCxsVrboZ1h7/V0L7crh6CAPisZrAaO3hF1vwuxWwT8Zopd2BsSyigpZGtqVO6Zi1Bcd9TOUN+lGryD0ibKmfwT4dnu67q2whzziaQZJ9e0fKvYT8rHYnj3g6mNSS2nQoTK2C26JTyXkDYPmIF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319822; c=relaxed/simple;
	bh=ZexrWVUerzcxTJsbqug7YTAVb8B0maQyfX0COGGQBxM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JVjgWLtPHBEv17tHjWN7tzSlJGQvyWwEp87EpPB6AYEh1ZlQ6DdJorHtb40xRDLTXB/neiGvslTMsIwJYS+fb2Nc2a2n29MJ9zMU4NLk0VliF138Q7fI/cQNhJomoI7uV17ETHjPr9/d7s9hmLOQZ8m1z8843nc2UICMCkKsqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pg/EqtzB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQKdwfKM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.378676302@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=f6OqY96nNmXu7osNi/AN7bUMqCbv9Be5svEmpKd6MDE=;
	b=pg/EqtzB3GeUmPs6WR+LzHzhzh+MFY3VSWtjxKH80nqUaBdCtPicvtMCNAxDdKuoFfL1OX
	bPpyhj1ElgVa2XAJq39VNuJk9hGd1me5cznafXVCY7X752shxcNv9tYMUGyXJpVaazN2pP
	UvZgJAXdnLyLoSKbMfegvYX4+FTuOE6k3hysKL6Ylouq3xM9PJvh0H+5kDVWQ64Ly6EMsD
	E2kTy9t855WdzRbpcCvxGryNquSVMuSsXo46n4rUErLKCYoqJkfgynOiYufm/RMpZT/B2x
	sA2daFpHXA/jB8kWHiyT1eZIY3OWIQRX42XyTs/+AgoRXe0iZrxrDvTye4sZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=f6OqY96nNmXu7osNi/AN7bUMqCbv9Be5svEmpKd6MDE=;
	b=fQKdwfKMets9HP8XKYrMlQx3ZuaiJwXBjjFglZ4PsG1q69LGPwa6HkGo7un4OciwpqH3hC
	Yr7aWd/0h6aeUCCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 23/25] debugobjects: Double the per CPU slots
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:19 +0200 (CEST)

In situations where objects are rapidly allocated from the pool and handed
back, the size of the per CPU pool turns out to be too small.

Double the size of the per CPU pool.

This reduces the kmem cache allocation and free operations during a kernel compile:

     	     alloc    	    free
Baseline:    380k           330k
Double size: 295k	    245k

Especially the reduction of allocations is important because that happens
in the hot path when objects are initialized.

The maximum increase in per CPU pool memory consumption is about 2.5K per
online CPU, which is acceptable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -28,7 +28,7 @@
 #define ODEBUG_POOL_SIZE	(64 * ODEBUG_BATCH_SIZE)
 #define ODEBUG_POOL_MIN_LEVEL	(ODEBUG_POOL_SIZE / 4)
 
-#define ODEBUG_POOL_PERCPU_SIZE	(4 * ODEBUG_BATCH_SIZE)
+#define ODEBUG_POOL_PERCPU_SIZE	(8 * ODEBUG_BATCH_SIZE)
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)


