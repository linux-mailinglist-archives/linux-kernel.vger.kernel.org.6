Return-Path: <linux-kernel+bounces-321996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B697228D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1291B22470
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E4189F3E;
	Mon,  9 Sep 2024 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LlCkyin9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB5189F35
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909959; cv=none; b=VKZPcztsRSaZa7XO6tQ2n2aNLJAu2Vm7Y1EMjSltTUTvv7RBFPqYNHNJdkEmN7WG30XTxbuvP4qjtTRMQeyNmg6AQpicmNwyM+yclsCtACnVdvzglcZyWg+C9AvUL8BM3NopbY/LS1AUWaXlcNJ+jNrycwFUOAs+2MF3BNh7RuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909959; c=relaxed/simple;
	bh=6cFRJ7QTI060/l0RiIArue/oZNh9iSuzlPNI3agtK8I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BCmKKDUDyFBxVceBGh1QpILYuK0ZqiKpoI3Gzi1KeuX8N+tJ3sCi5gf+KReQ8/1dzw51CnPjebvnG01QIPXa107qodFo0G0EZtI8wWnxg0Fy4Q6YzmCZRk+9Jl3kKD3JjoYg7blVtRseaBgG7VAr0+v3kEnhjqCYUOeOdqtf29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LlCkyin9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15FC4CEC5;
	Mon,  9 Sep 2024 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725909959;
	bh=6cFRJ7QTI060/l0RiIArue/oZNh9iSuzlPNI3agtK8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LlCkyin9vMc8xX57B9Zd1YcvgW2JL9aXetMjuqwNUl42LCW6rfw340z2V8z3kmd9v
	 1OjkWjwjM3Ny4TxaH2H/EgqXHaaIvqwPCtsOb8rXHt++nDkICnf7wDAMoo4qxEZ0/J
	 o7wTylyb81oK22MOsgpl6/AIa/gH2b1rQ+2VvRrQ=
Date: Mon, 9 Sep 2024 12:25:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand
 <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/page: Drop has_unaccepted_memory() helper
Message-Id: <20240909122558.aa726d312d8b166a515dd751@linux-foundation.org>
In-Reply-To: <20240909081930.748708-1-kirill.shutemov@linux.intel.com>
References: <20240909081930.748708-1-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 11:19:30 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> has_unaccepted_memory() has the only caller -- cond_accept_memory().
> 
> Remove the helper and check zones_with_unaccepted_pages directly in
> cond_accept_memory().
> 
> It also fixes warning with clang 18 when kernel is compiled without
> unaccepted memory support:
> 
>  mm/page_alloc.c:7043:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]
> 

Thanks, mm-unstable has a similar fix:

--- a/mm/page_alloc.c~mm-page_alloc-fix-build-with-config_unaccepted_memory=n
+++ a/mm/page_alloc.c
@@ -287,7 +287,6 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static bool cond_accept_memory(struct zone *zone, unsigned int order);
-static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
 int page_group_by_mobility_disabled __read_mostly;
@@ -7068,6 +7067,11 @@ static bool try_to_accept_memory_one(str
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
@@ -7095,11 +7099,6 @@ static bool cond_accept_memory(struct zo
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
@@ -7134,11 +7133,6 @@ static bool cond_accept_memory(struct zo
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


