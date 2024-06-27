Return-Path: <linux-kernel+bounces-233116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CA491B266
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE111F25FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249C1A2C1C;
	Thu, 27 Jun 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ml7sVsFv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834891A2C1F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528442; cv=none; b=KSl4D95kyGK+F1QNPPuM038ooc5NPuzO3q0nLNCuSaNxBywX0b4/MNls3En5idWWvv6a1yahYL9Wn8EvFBalRx3BMfQ9Z+QGEUbciFSP9xbHUrdYY/PpBk6qXJGb9ziCAEYxr3/W/nTwM7W2QDOCAF1xC39l5OGnYLNgRc0OnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528442; c=relaxed/simple;
	bh=XhR9dRhGH2Fpol0L63NLsuvdHiR3HGZLERYxyMMGTuA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LXZ9GEMGGK7rmZofO1bbyYMGJhXl7mJcxYU1x4edpgRg1QZKb/C+9Y87a6gx7e75M1q0TfGpYarKFo+iTuKKgu4ACrG1DMvffMP2DbBMgJl7J05/ijy+5EWO9yKUw5rLlUFdX/Q3yI1EjLHQ8zNckBvW/g6nqPoPhK2fWSYXEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ml7sVsFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B7AC2BBFC;
	Thu, 27 Jun 2024 22:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719528442;
	bh=XhR9dRhGH2Fpol0L63NLsuvdHiR3HGZLERYxyMMGTuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ml7sVsFvH8C2/He23axIm4syYXKh5a/OzCai1M7xaJDMfjRsGJma1zvgny7+cXyt+
	 D9vEF1mTXwBVbFeoYvJSp2wPZNKXFN8vP2eENw1TSZUE3vrEJC/YW58QRApGk/Pzxn
	 7YRZ71d5GMfPYgyZWIXCM9nqPgij5Iy49kQk76KE=
Date: Thu, 27 Jun 2024 15:47:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, David Hildenbrand
 <david@redhat.com>, Frank van der Linden <fvdl@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu
 <peterx@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: fix race with
 speculative PFN walkers
Message-Id: <20240627154721.69aea29609984bd5422afc97@linux-foundation.org>
In-Reply-To: <20240627222705.2974207-1-yuzhao@google.com>
References: <20240627222705.2974207-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 16:27:05 -0600 Yu Zhao <yuzhao@google.com> wrote:

> While investigating HVO for THPs [1], it turns out that speculative
> PFN walkers like compaction can race with vmemmap modifications, e.g.,
> 
>   CPU 1 (vmemmap modifier)         CPU 2 (speculative PFN walker)
>   -------------------------------  ------------------------------
>   Allocates an LRU folio page1
>                                    Sees page1
>   Frees page1
> 
>   Allocates a hugeTLB folio page2
>   (page1 being a tail of page2)
> 
>   Updates vmemmap mapping page1
>                                    get_page_unless_zero(page1)
> 
> Even though page1->_refcount is zero after HVO, get_page_unless_zero()
> can still try to modify this read-only field, resulting in a crash.

Ah.  So we should backport this into earlier kernels, yes?

Are we able to identify a Fixes: for this?  Looks difficult.

This seems quite hard to trigger.  Do any particular userspace actions
invoke the race?



