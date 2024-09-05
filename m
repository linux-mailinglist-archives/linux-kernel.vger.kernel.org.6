Return-Path: <linux-kernel+bounces-317030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885796D868
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071C628A695
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291219C56E;
	Thu,  5 Sep 2024 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qn2XqsEe"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6019AA73
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538880; cv=none; b=aFmTRjg5aTFPgYaplsCiV1oZzLZeU4UKuFtXoLZ4Y1OC0PCO267syK8pmx31HEIy7zG1MGV/oMU4rnC7qDYcmUSxJFBWxpdvF6Cc9TmFT3hdLkts0A+np10SjYyMjVJLXgmDYvO2yuDbqsX0EQfTIZXt4enjbrZITGH65/ait/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538880; c=relaxed/simple;
	bh=FuLyhTH9whofNEb0X5JnUc61jUc/MugF/mmAS0zNdr8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DZLh1G9zsON1BWcnxVwx2wxI3BfBxQn/F424j0kYcjQumLEOaFckZ1MBvkHoHLolMn7elXyJSeUgebzvw+TcPBhrEJY13xie3UTLcN7Na8rh+Vi+THEhUKQabWHxMEH5DMSoJ5YhfaNIQdz39WBJyXAi+HmwLZJuJ1eFVP8hmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qn2XqsEe; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725538876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RG+B9RQMt9wqZwEFGQtC9HihmbtSol0+CD88scwrr1g=;
	b=qn2XqsEevTtNsm0C0CHtnQmRNmZ+AVm0hM6Uy5e3u/BOaVmtKVjJpC/c0EPxHY7wdVSgju
	4dwEvwrBRPQycogduv5yry7QUbkmrGoUawtvZQ+t0uqSe0k35+sSKbVAwOxBxyj3bIsXqz
	qtdbnn5qyiTt19S2z5SyP1ZsF5TaLO4=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3 11/14] mm: userfaultfd: move_pages_pte() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240904084022.32728-12-zhengqi.arch@bytedance.com>
Date: Thu, 5 Sep 2024 20:20:30 +0800
Cc: David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 Vishal Moola <vishal.moola@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 christophe.leroy2@cs-soprasteria.com,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: 7bit
Message-Id: <7FEBE447-2635-4BA9-83F1-89A3F0CB3BD6@linux.dev>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-12-zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 4, 2024, at 16:40, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In move_pages_pte(), we may modify the dst_pte and src_pte after acquiring
> the ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
> already do the pte_same() check, there is no need to get pmdval to do
> pmd_same() check, just pass a dummy variable to it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


