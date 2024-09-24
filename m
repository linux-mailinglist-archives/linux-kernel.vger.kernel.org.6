Return-Path: <linux-kernel+bounces-336695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C73983F66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755061F221CF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0814D456;
	Tue, 24 Sep 2024 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YPkedyFU"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9D1494AB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163612; cv=none; b=oACNLs5GIkiuKQxLSB2I14qc3GGm1EPHRQ/eglOz7mUrwcLbrUgLCPuiFBsxuuoXVQyoGnqAmLqAeeFxNyuj+vwJPMwNWnqNCE/hb4kpWe+dMWnxE6zxq/4d5VieVKOdsvepRZayFcKU72qOb7fZ4tFjcNdEGcK+A+DqK/Ne9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163612; c=relaxed/simple;
	bh=FXwR1zkmR65RnT65O9dxB/DKHOb3WjI0B8f09VidI5U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hPS1TyHRF3vl6Ift+LLVYFFwOgL0rLkORhf5Atj90v5DgYUdSpnndDlO8b1696nN2wc3qoQbTmNkIQ8okUjQFmFuvyxOvm47ZHEw/Nl7mopfXNLeldpSbCKtlJIQmXSGTPjXUjJMstM9cxOfnjIdtTdBCdebqnfD81s1oADMAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YPkedyFU; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727163606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feLnDK54jWgpehNv7jGj+iux9/EZ9Wgvx1Gm5rmvg6M=;
	b=YPkedyFU/qRPuoy/VtaBWlSgDWI8B2BI03Y7bNfEpngs/NFa8208jLRInhPul0eFFj+VSy
	+fFZzUeFSO22eScfZyubg4GNkcVW1clL3kJLI6JpuHZpWp5k7MqrHb79qaIv206sIuK4sf
	eo9VQMecooB/ppvUQTJvAMlpDNOb2J0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v4 09/13] mm: mremap: move_ptes() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <c7b3ba9e8e58efe7bba9d52ce30a8ff4f4298e2f.1727148662.git.zhengqi.arch@bytedance.com>
Date: Tue, 24 Sep 2024 15:39:21 +0800
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
Message-Id: <EF701BDB-5742-417C-AAC3-99EF12997DFB@linux.dev>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
 <c7b3ba9e8e58efe7bba9d52ce30a8ff4f4298e2f.1727148662.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 24, 2024, at 14:10, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In move_ptes(), we may modify the new_pte after acquiring the new_ptl, so
> convert it to using pte_offset_map_rw_nolock(). Now new_pte is none, so
> hpage_collapse_scan_file() path can not find this by traversing
> file->f_mapping, so there is no concurrency with retract_page_tables(). In
> addition, we already hold the exclusive mmap_lock, so this new_pte page is
> stable, so there is no need to get pmdval and do pmd_same() check.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



