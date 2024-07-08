Return-Path: <linux-kernel+bounces-244090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55083929F09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862F41C22BF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2C06F315;
	Mon,  8 Jul 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tdxe3ytV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E915466B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430962; cv=none; b=r/OvdcLptoEOqP2lDs3/IiFGFU5lQBhgiejhIDTwEkTodXMFYDDdFAHwphIWy5SFEAEHo2LPspKJZDTHoaxLj63f70ap8cvpKNLnGXqM2JBufCrtdvyC/akJBO9nykKGt4fziCX1nulnPZWMpJ1RkpIwlN+c0Dl4Pgn8hWIlUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430962; c=relaxed/simple;
	bh=aHcz8je/K6D8qyRMNtQ30mbLo3y2E4SL+2Pr8zv5Wis=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lSlOmkdJRQ58MLpdU6Jb4gwk7PO4riU1CwoFcuXX0h/fsVd16c9hfLEAmcReZSGJ9SoFqOJrDzQKRfWYqSuEdXtZ2FIWMwtib0J38A30k3Rg7rJorYhYR4XtWSzn3pMWd6sVRQBG71njpIxp+z37ukM9g+eZjogbRMM8aSalvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tdxe3ytV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=1bUUAiw4/p70dXaUe2S6wv8W5kuKSZvbGkuAwwX7C3c=; b=Tdxe3ytV0Sjef2aMwTMoaLQiKQ
	e381tmG00zuVrgDf5WXQmRZ3V3x+/DqTJ4igCE7xkO2IPbdSOth1nqLDMbjm4OwuCWLiiFfEOX258
	KInKvbzWm0jRluM0IRq0ucF9HdJStnORzS2kghescouo9/36bXDdVre/EyOVhJl+C0cBf58jdr1UV
	q5c0vNiny/ko2gl4NrG0FDBZAttT8v9AdUXpbZLI+4LdT+BEPoLBx/HsmPKcCglj69dhFr4HuVU0I
	I4AY0f9mvGB0TMcbzi2KmbETWb+BYFcseEt91TD4v/58U4cxvueY0rwD0XjiI1QUlJp4LGcEKE1TU
	157M2K0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgN-00000006hOY-0lNP;
	Mon, 08 Jul 2024 09:29:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0923B300AA5; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092415.351458388@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 oleg@redhat.com,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH 02/10] perf/uprobe: Remove spurious whitespace
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -67,7 +67,7 @@ struct uprobe {
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
 	 *
-	 * 	insn -	copy_insn() saves the original instruction here for
+	 *	insn -	copy_insn() saves the original instruction here for
 	 *		arch_uprobe_analyze_insn().
 	 *
 	 *	ixol -	potentially modified instruction to execute out of
@@ -95,18 +95,18 @@ static LIST_HEAD(delayed_uprobe_list);
  * allocated.
  */
 struct xol_area {
-	wait_queue_head_t 		wq;		/* if all slots are busy */
-	atomic_t 			slot_count;	/* number of in-use slots */
-	unsigned long 			*bitmap;	/* 0 = free slot */
+	wait_queue_head_t		wq;		/* if all slots are busy */
+	atomic_t			slot_count;	/* number of in-use slots */
+	unsigned long			*bitmap;	/* 0 = free slot */
 
 	struct vm_special_mapping	xol_mapping;
-	struct page 			*pages[2];
+	struct page			*pages[2];
 	/*
 	 * We keep the vma's vm_start rather than a pointer to the vma
 	 * itself.  The probed process or a naughty kernel module could make
 	 * the vma go away, and we must handle that reasonably gracefully.
 	 */
-	unsigned long 			vaddr;		/* Page(s) of instruction slots */
+	unsigned long			vaddr;		/* Page(s) of instruction slots */
 };
 
 /*



