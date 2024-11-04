Return-Path: <linux-kernel+bounces-394993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B1E9BB6E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90F11F22F65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D87B1BD4FD;
	Mon,  4 Nov 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQTrUotZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793F1632F2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728616; cv=none; b=PAqovyN2L2YZCIVqheRt77bC7qT6Ap641z/P/hW+CtyL0v3PUkV6TJAtjhWKnL/bIu2QVF+ybmi8GHEDJNTpjaz6v40Ctp0wcO7o/y78kiZmhhNsOGJCXOkGe8g5TVK7L2kvGPq3h7gjzvn3tZaQPMvBcho0qMx6r+2aC/Nb0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728616; c=relaxed/simple;
	bh=meS3dWVg7zJ5txARDOEih0uMo0omEo4vQbjmRZfeWOQ=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bO/bdtbLMRzJVSad/OSl/l/RP9Un2AX+zvznpJy7DyaskzjYpsM+UiGj2pTlmfUU5Yh8eF/wG0eI0cKVhYqpdcDYGOgWbKIc7jesWKOsYK4Fy2tfgydFsTl8qxpSZBlJRvzqVw+T5/LWJhp5ARyMzvmKRINaTJiePugtxElBzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZQTrUotZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=iuKt4M6LpBu92at2xi6UNg7BT1MeEYtiYj08kpT8GsE=; b=ZQTrUotZ6fG+/FOOzNjX5RK068
	+IZpZbHQ5Q/nUeyjlRXZr84Gbm1w9KyzF/JZtIDttmn6ecOjp93x+TqYVSM3O0dhpK7i2g3pVNp+Z
	oGkNAdBR6by+RcdI6IY+b/RP6mWpaCogCxU76raHGxiDCSE0V6GiImBuDEkHK7Pk+2/NZkfUbLd/6
	LPwZKX/+40RdYp/R9bcdYVJFQbNWa1eVzmjGLyMrfBQ65N2psSeU5tqj4wkwGFAtL9nIzP3JHZGkF
	aiqhL6RcbB3xXIDvAVcYg011/aQSjDoL24l0xYPnDm6UfpV+Yo0eA2IGmNwCYYPeb20iEh2yrhqSJ
	/jTXPIww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-00000001EDy-3RbL;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8E0C9308CE1; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135519.248358497@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH 15/19] perf: Fix perf_mmap() failure path
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

When f_ops->mmap() returns failure, m_ops->close() is *not* called.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6830,7 +6830,7 @@ static int perf_mmap(struct file *file,
 	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &perf_mmap_vmops;
 
-	if (event->pmu->event_mapped)
+	if (!ret && event->pmu->event_mapped)
 		event->pmu->event_mapped(event, vma->vm_mm);
 
 	return ret;



