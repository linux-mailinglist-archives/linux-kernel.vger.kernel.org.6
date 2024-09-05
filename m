Return-Path: <linux-kernel+bounces-317878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2FA96E4FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35991F238CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C381A4E6F;
	Thu,  5 Sep 2024 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yu75ecSn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B158C9443;
	Thu,  5 Sep 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571341; cv=none; b=qgvBYLGvQPqgC4QXhv5Yn5Lz44L53c9lN8doIqPXayDMgBwZWjSHAUmN8VBqWsGgSWvcPSi6XXdFTdzILCPILy6zb3nOuzUVUG1+LYiatgeUQaHCDuBohC1pCWCNNQjJnLc+4nM+N3/vYa9tMbLp0gRMhmnAMp4M5Lj5RhmqSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571341; c=relaxed/simple;
	bh=35+rbCTS0v4jRIIZob1qp95Mxqaaa5dUxQDMzEaSLO4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YF4SpDJxaV05ddzkkGb+py+g6YIlwCcJOAVniubVPGs+HkyNy8kkmsEzuIuMTdhzJwUnIQhN1DLafH+ejLTOxrlrlP6zhr+KQX23VamowbfDwdsS3QrrsKwGJ9M3qBp9nKCm45sSbZtF3t1Hi/UPjaJ/tUHMmU1TUwfCNL4l970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yu75ecSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5D6C4CEC3;
	Thu,  5 Sep 2024 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725571341;
	bh=35+rbCTS0v4jRIIZob1qp95Mxqaaa5dUxQDMzEaSLO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yu75ecSn8OPOSeRomyMimNPAqqR2n92JVElp0CvhV5p7QsEJT+t2CHpcJFWFsfsFR
	 yLY+AzhiKv6UD83cp7bo68IFNV8MEQEVBY/ECOgNpfj3d+fC+7cMtyx/HdGzpp9a9X
	 PIOlZYJRqUpNROZCg/p/Npk5/+oOOyUZb1GqGnN4=
Date: Thu, 5 Sep 2024 14:22:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] mm/page_alloc: Mark has_unaccepted_memory() with
 __maybe_unused
Message-Id: <20240905142220.49d93337a0abce5690e515d9@linux-foundation.org>
In-Reply-To: <20240905171553.275054-1-andriy.shevchenko@linux.intel.com>
References: <20240905171553.275054-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 20:15:53 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> When has_unaccepted_memory() is unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
> mm/page_alloc.c:7036:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]
>  7036 | static inline bool has_unaccepted_memory(void)
>       |                    ^~~~~~~~~~~~~~~~~~~~~
> 
> Fix this by marking it with __maybe_unused (all cases for the sake of
> symmetry).
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").
> 

has_unaccepted_memory() has no callers if CONFIG_UNACCEPTED_MEMORY=n. 
Can't we do this better thing?


--- a/mm/page_alloc.c~a
+++ a/mm/page_alloc.c
@@ -288,7 +288,6 @@ EXPORT_SYMBOL(nr_online_nodes);
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
 static bool cond_accept_memory(struct zone *zone, unsigned int order);
-static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
 int page_group_by_mobility_disabled __read_mostly;
@@ -6963,6 +6962,11 @@ static bool try_to_accept_memory_one(str
 	return true;
 }
 
+static inline bool has_unaccepted_memory(void)
+{
+	return static_branch_unlikely(&zones_with_unaccepted_pages);
+}
+
 static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	long to_accept;
@@ -6990,11 +6994,6 @@ static bool cond_accept_memory(struct zo
 	return ret;
 }
 
-static inline bool has_unaccepted_memory(void)
-{
-	return static_branch_unlikely(&zones_with_unaccepted_pages);
-}
-
 static bool __free_unaccepted(struct page *page)
 {
 	struct zone *zone = page_zone(page);
@@ -7032,11 +7031,6 @@ static bool cond_accept_memory(struct zo
 {
 	return false;
 }
-
-static inline bool has_unaccepted_memory(void)
-{
-	return false;
-}
 
 static bool __free_unaccepted(struct page *page)
 {
_


