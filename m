Return-Path: <linux-kernel+bounces-398978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401CE9BF8CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E85D1C21C32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F2205AB4;
	Wed,  6 Nov 2024 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kHW6ciBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DE1D0E23
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930532; cv=none; b=oKIqlH7vHTiJ7Qyt0qBmEgWcDAuRu7KXg1ImPXA11k7oeSd+t//SJYnNmT3+glaoYKfi3nEdv+bhPABCy1cITjCd1dGDpYztVRFJgriZh2nx1yRQk7dZA14n+toDNrd0+y+Jg6QVH0PxuqZJy8DLwjJ5nxzImgVAEGx4vdvGmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930532; c=relaxed/simple;
	bh=qQomBuQN4Q81ObHmsV989becOTbHMcs1fG5+uVha8/s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EmUeEaxZUXuoDeq1ExoedCn17oS+oEWI/fq2j7kW+xwekC4fmJVYqPPlA8X0+6hI+vgOWLXjiKgHgAGi/yjQOUzTknW5L3buL+nkid//SgiH7XGOgikvRcnJ6aWAcszLMydyT/NsvKDhPxWGn9POHnPSN6r+GL1MmAGpKQyNmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kHW6ciBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9456AC4CEC6;
	Wed,  6 Nov 2024 22:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730930532;
	bh=qQomBuQN4Q81ObHmsV989becOTbHMcs1fG5+uVha8/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHW6ciBRy1vtLDHEZh8B8siDDtOV9Uwhq6QqqFCpUDHK1lO2G2L0MDuje4PXoU1rE
	 xy9DUV5UvujjGYKBvNgc7ghd7OE4yL/JrIhquwsg7IjRMg22vXxlJ4wUIacpeoWbJu
	 lPrJ4Rl5+p2ftgh8ljEIEoI51eRIesaepqkVmbkc=
Date: Wed, 6 Nov 2024 14:02:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Johannes Weiner
 <hannes@cmpxchg.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Nhat Pham <nphamcs@gmail.com>, Usama
 Arif <usamaarif642@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Hailong Liu <hailong.liu@oppo.com>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v3] mm: count zeromap read and set for swapout and
 swapin
Message-Id: <20241106140211.a1272fe0e23d99d7c37b7751@linux-foundation.org>
In-Reply-To: <CAGsJ_4zLv=HpPL3g085vUaMo8tZZnPZBGT_SfLVCV-10zn+D3Q@mail.gmail.com>
References: <20241105211934.5083-1-21cnbao@gmail.com>
	<20241106150631.GA1172372@cmpxchg.org>
	<CAGsJ_4zYiRzG6mBnW-2wh7YCo_PJQc7u1syd05DNdic7MaE7Zw@mail.gmail.com>
	<20241106124225.632b42c3680cae0b940d2871@linux-foundation.org>
	<CAGsJ_4xoHbg+6CtGhC7dPePPC44OMH8azQsOWMEJnXpCQs=bDQ@mail.gmail.com>
	<20241106134446.aaadc57a2a88c9efe899c838@linux-foundation.org>
	<CAGsJ_4zLv=HpPL3g085vUaMo8tZZnPZBGT_SfLVCV-10zn+D3Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 7 Nov 2024 10:53:11 +1300 Barry Song <21cnbao@gmail.com> wrote:

> 
> Kanchana's commit 'mm: change count_objcg_event() to count_objcg_events()'
> changes count_objcg_event() to count_objcg_events() and supports
> nr_pages more than 1. This is what we need for the minimal patch of
> fixing zeromap
> as zeromap could be nr_pages > 1 for large folios.
> 
> So my question is that, do I combine Kanchana's change into my patch
> and send a single patch, or do I send a patch series with 2 patches:
> 
> 1: Kanchana's mm: change count_objcg_event() to count_objcg_events()
> 2: mm: count zeromap read and set for swapout and swapin

A single self-contained backportable patch is preferable, please.

> If we combine them into a single patch, I'll need to incorporate the changes
> from 1 into 2. I'm also unsure how to acknowledge Kanchana's contribution
> —perhaps mark it as co-developed?

Sure.


