Return-Path: <linux-kernel+bounces-306297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E4963CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF142815C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF43E174EFA;
	Thu, 29 Aug 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AZKaNv4j"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844115B963
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916277; cv=none; b=nIDxhuFw6ip4KL1jTLr2uR7SXnLSeTr617tfv7EhKAUfpGd9HcXWCNSUNK0qsHy+7pIUX51JjBZamZb9/XheKnc7yHs0Wd2WKCBmyr0zfNI8N37Wm7zzoctDxaUTXdheK7ZHgpCZmQy59dhGzy0jRviDbgQ0a6YNPkL3HwB7J48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916277; c=relaxed/simple;
	bh=8hWT+KL+d28V5Jn4Cn0QgqmfOIGYIHqB8Dkyv/MxRGI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lJRrhaYIjXnpTMkHZcsJCfNlGVaGVseSyFqjAhw9NxOpywf+mkavFrL0PalUa3KnPQr8PEs+qH7D9umJryItfxdQHGqlwHtvw6JZBZCcLfz8uC3jrqyMaReMf+qW6XBH0bY4LDTDBEQyX8jbE80wKze0DU+J6yV5i2gjsJi8yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AZKaNv4j; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724916273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibRF3sJS///pheO9Cf0+PnOoPzFh6pbCWCOa8dk4b5Q=;
	b=AZKaNv4ju75SNUiZkk8cP05CS3tLWGtxkgBiXb0D25lMffZHabcgUima2EVYz1Mk2by9rC
	kOF3ogFkN+0Y0/yORAjtZP3nGBtY7KVuoWuDH0ZGkdWjUQFQbzTH7tvzDHvFAc8nPdYpsj
	9guwGqp5zfBuxOIrdfRqa4nOqqi+Ml0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 04/14] mm: filemap: filemap_fault_recheck_pte_none()
 use pte_offset_map_ro_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <d5d4744c87c759a53b5e115a0d59326232696f61.1724310149.git.zhengqi.arch@bytedance.com>
Date: Thu, 29 Aug 2024 15:23:32 +0800
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
Message-Id: <9FA797E4-D835-481C-81B3-7B40A9648FC4@linux.dev>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <d5d4744c87c759a53b5e115a0d59326232696f61.1724310149.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 22, 2024, at 15:13, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In filemap_fault_recheck_pte_none(), we just do pte_none() check, so
> convert it to using pte_offset_map_ro_nolock().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



