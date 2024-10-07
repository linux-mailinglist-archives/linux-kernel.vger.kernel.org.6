Return-Path: <linux-kernel+bounces-353874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49069933E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D76D286019
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7D01DCB05;
	Mon,  7 Oct 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MThGZPqW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wq5Ym2T+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6C1DC1B8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319799; cv=none; b=RcupH9KmPRDmlNxcTAuHEtUawFIEObUpOfHlNFM8nSu30CkH2bahCDIp1k5AVH5B+vw3jyGhM2l1Ld4IzyP6++g2eiIobBiBjRkHvzV15VfhI8jhgrbjU2gg1n8UaDpcvCVB/k5fpzAn1GN7kSKb1QRQiL6SVLmbdj/kIE5twHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319799; c=relaxed/simple;
	bh=gNky2JPv/g//hDu0oNfoJPwDLycaraDu9NRDZgc4NCI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CG9FjvJhvkLfZzE9ynju4TlYcSj7nULSAfGadFPtqrVMso1m9OKJj4cusBZuPyavJg2Ih8mTediCBNVXs02xDLAS5GwB7BI9hl3ePbjdxSAafeXXC794zGc2NEfqyM0Q/NINMXEb/ExmS8uvFWxbQpd78kcV88BKs9T8XZ4SUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MThGZPqW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wq5Ym2T+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.200379308@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CDVx47swvYRM3WGljRSXbOAUqFkI8FfkKJLHbg/0eM8=;
	b=MThGZPqW8sXwCuitR9YA6mIUfJUpwCUi0hFPMyGXz8pM5TwQC7t6mBmed18MmNcomUY7cE
	65PnqtWyj0ej4+cdRFUccO0XchdTf2hd5HF7Nl7+A8m5al5LuxKUhujZKz+2dQ95n7+Kqs
	wYBQXGbZzEMyHWrlSAf5BMdIbDt9XVcdBpssmNifhwNWa3mubwegiZHKDLi9BT9kxFuPdS
	2g6w6ai5Mr4Y1UEqDC4rQZSANkptj+RmcM7cy1Ul5KFgD+g6JVnDKm7MajF/Dqhetx07pv
	MZUGYrYl0x3nMQIrF7GyNFeGJ1LnXskjnCvXQZJ/pMCNJHoxm7wgxJy7XNDLuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CDVx47swvYRM3WGljRSXbOAUqFkI8FfkKJLHbg/0eM8=;
	b=Wq5Ym2T+ky2cDXJV+n6ZYv1rD4yDiHeim2JKyj9Ka5ovrEvTe6QDWu1xgaptZ3k1/Wc8+A
	9u8ivtk8U9k+luCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 04/25] debugobjects: Remove pointless hlist initialization
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:49:56 +0200 (CEST)

It's BSS zero initialized.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1364,20 +1364,11 @@ static bool __init debug_objects_replace
 void __init debug_objects_mem_init(void)
 {
 	struct kmem_cache *cache;
-	int cpu, extras;
+	int extras;
 
 	if (!debug_objects_enabled)
 		return;
 
-	/*
-	 * Initialize the percpu object pools
-	 *
-	 * Initialization is not strictly necessary, but was done for
-	 * completeness.
-	 */
-	for_each_possible_cpu(cpu)
-		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
-
 	if (!debug_objects_selftest())
 		return;
 


