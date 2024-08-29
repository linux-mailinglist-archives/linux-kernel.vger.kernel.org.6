Return-Path: <linux-kernel+bounces-306300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47F963CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775691F2486E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9E1547E3;
	Thu, 29 Aug 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XnC+ifnJ"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5817799F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916365; cv=none; b=mE6HEOD4TBxGtMvks7hacT0wET9tFmkwRdn82P4lMQ40IRRgIUs1v1nFd4THrPXrjMiVMigl5IWP2w1k84DQNTgQ4rd5MbmqDGMI6xzwCeyJGjpevAYAHfG/rus3JBPGVMhmRkRXV0fHn6YjCe7S+S1VsOCqsHpG+p3wXIH5uBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916365; c=relaxed/simple;
	bh=xk97YPMsUSOOgvPb7d9bLQJw0lh6Q6fxG59ax1Tvwh4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TG6inzeHGDXf7hu/oNt6k6eyKjdiWoRbOX0gitiy0Oirl0vbJkTA/xWxgea3RMJ6OccJD2RYES/vy7zAKhsAHF8y0AQhRQXOUKIBEHbCbbNgrDawU02RoNoUqlo1gRnbHzqOsetaDJzc1XIzMLu2yCxZ8DMKZNqd+DOfQnYTtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XnC+ifnJ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724916359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5ri7U3ICw+kQAJ41Z0llXmXtxn3eNpISSEiLweTrSg=;
	b=XnC+ifnJTUWJgifpFgmnQKUN1iA51s8smDtrDWc9xoYV0r2DvZRun/a80GBJIS/z8i5FQF
	+wZ5qMlmMJ+IFqorb4b4mjYQms1OtQTVe4PV36YN4amK8vx3MnqdJIgVq6RFI7WVKKQhOs
	08q3auveABGgxrlfI4bi/MoSiViz4lQ=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 05/14] mm: khugepaged: __collapse_huge_page_swapin()
 use pte_offset_map_ro_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2b7dceaa12da273c6decf92e3bf2ebc4f4e85ec5.1724310149.git.zhengqi.arch@bytedance.com>
Date: Thu, 29 Aug 2024 15:25:19 +0800
Cc: David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 vishal.moola@gmail.com,
 peterx@redhat.com,
 ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: 7bit
Message-Id: <3BAB5012-B8A5-4DFF-9CAB-31D44AEEB4F4@linux.dev>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <2b7dceaa12da273c6decf92e3bf2ebc4f4e85ec5.1724310149.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 22, 2024, at 15:13, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In __collapse_huge_page_swapin(), we just use the ptl for pte_same() check
> in do_swap_page(). In other places, we directly use pte_offset_map_lock(),
> so convert it to using pte_offset_map_ro_nolock().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



