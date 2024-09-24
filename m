Return-Path: <linux-kernel+bounces-336680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19D983F38
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8FE1C2098D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC630147C91;
	Tue, 24 Sep 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TeIzHIRw"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CCE17993
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163383; cv=none; b=UxYNfRQ6bcFMwnT4m+e74b343wmm9PYOPaqOw7RBT6DLf7omAd1RRifbd5JOzISm5un8V/OCENcrvWgVpC8jPCmIj46DmAxv8QVxvA+YbNzYh1n/cx0nHE4JiXF+uvIJozGCmRoTxrspRcUs0i5OGqScrXIrFtiuuAVuuzyfE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163383; c=relaxed/simple;
	bh=QN9TsjcxdqboO4yiGVzdAJfPHZR6JZo6rqWog2ONr48=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lNp6TfCmawB+B+Tcw6jJ2dhzZspFOz9G2y9k+HdAiFwL+zlEFdqwTmNA9KLmOP4gmtH3qadV2MMn0zmjGbRil8IA096NR/zFnCaTjiLnbSXAwmV894TZXSd/zSuXTSsSxSLB5jk/yPz+tBqO5ozLzLjekCW549n6jPQzd4DWCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TeIzHIRw; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727163378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DoLXxu3sHCyM5uOz8aZIUvfdOpT8jMclqRj2gZrUUOM=;
	b=TeIzHIRwa9J+AAi/w/MnUrNvnJp4eggEJopgtjtdGBDKCoMm28m+up3f3+siiMNxstukd/
	sRci7QOJMrJjuYp1XIEk17HMgvkqe9hLfpxdl0GvCaoKIW4HaxGHx1o9ZOHh2/3Wtf1x4o
	qUwgrE28b9B2kx+PKH4ccRCtzch7RJA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v4 08/13] mm: copy_pte_range() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <b70b7cb91e000d540773a0e892789da64ab6c108.1727148662.git.zhengqi.arch@bytedance.com>
Date: Tue, 24 Sep 2024 15:35:37 +0800
Cc: david@redhat.com,
 hughd@google.com,
 willy@infradead.org,
 vbabka@kernel.org,
 akpm@linux-foundation.org,
 rppt@kernel.org,
 vishal.moola@gmail.com,
 peterx@redhat.com,
 ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: 7bit
Message-Id: <65E61995-5C32-48D4-ACB4-761EEAE7A585@linux.dev>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
 <b70b7cb91e000d540773a0e892789da64ab6c108.1727148662.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 24, 2024, at 14:10, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In copy_pte_range(), we may modify the src_pte entry after holding the
> src_ptl, so convert it to using pte_offset_map_rw_nolock(). Since we
> already hold the exclusive mmap_lock, and the copy_pte_range() and
> retract_page_tables() are using vma->anon_vma to be exclusive, so the PTE
> page is stable, there is no need to get pmdval and do pmd_same() check.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



