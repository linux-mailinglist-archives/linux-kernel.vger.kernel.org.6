Return-Path: <linux-kernel+bounces-555242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61768A5A879
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7007A52B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EFA1F78F3;
	Mon, 10 Mar 2025 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DJt/dRkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466181F4CAC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646363; cv=none; b=e/uxH+yYJtX8bMDXIoCr/Q48D1D/pVkj/ZVfZfvhxbvkT3dD4hFL6QL1cGOQCS0jldXmWVpb9/Pwn4ECZgL1MWgmNSb281SsaRXmz6c0fupTy3MMyXVsMbMOIWncTvXpE4z2oUd9J6RoCRrL+CjyslURHXoDTTov+jei+XKk3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646363; c=relaxed/simple;
	bh=rJolrJAtyC/aBfw6fPsglUjT07JuUYVss89j8LWAWrQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sOt0AoKp8cJ1t3snJy93Vs9zijg2M5PpVos5W1fbi97dt5riJ38IFkaP5hW+hGcnZOq76YHEHWkIYe0Bp/uH5wKxvyfDkFv9uGpDPo+lV3KuxZi7oQp2j2jg+GNJfLOzTiguZXOVtv23NGcyE3DIjQijpwhGREWR3R3r0RGAMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DJt/dRkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BCFC4CEE5;
	Mon, 10 Mar 2025 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741646362;
	bh=rJolrJAtyC/aBfw6fPsglUjT07JuUYVss89j8LWAWrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DJt/dRkNnDsq8SZ9cU8Z9Elb9EYLKmG3gkECi9vpTGcKs9CtE/CUpni1aZ7iAwX0M
	 ykBAkGhLUzTFMPPUO4paC8wVJVwFKU8LdLWTLiRvsq+IaKQqB1mAdUnrYLoEGc2ySu
	 R2vK2oNjfoxD9wVEAuUfLkPbydWEXFx4SXWTDJUo=
Date: Mon, 10 Mar 2025 15:39:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shakeel
 Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/9] mm/madvise: batch tlb flushes for MADV_DONTNEED and
 MADV_FREE
Message-Id: <20250310153921.47d390c637105e3ad6fc49c0@linux-foundation.org>
In-Reply-To: <20250310172318.653630-1-sj@kernel.org>
References: <20250310172318.653630-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 10:23:09 -0700 SeongJae Park <sj@kernel.org> wrote:

>  It is unclear if such use case
> is common and the inefficiency is significant. 

Well, we could conduct a survey,

Can you add some logging to detect when userspace performs such an
madvise() call, then run that kernel on some "typical" machines which
are running "typical" workloads?  That should give us a feeling for how
often userspace does this, and hence will help us understand the usefulness
of this patchset.

