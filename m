Return-Path: <linux-kernel+bounces-306376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA0963E25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625591C23D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E618A6D2;
	Thu, 29 Aug 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZhnUD3O"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C118A6A4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919268; cv=none; b=t63auJW1EAiXBCZ12KVBYT7Mw2W8jPF9Ll3jBBEa+TtNHLOoOHALkTIKawdMpvC7zklfRjQZc2GOLXOKI59CaMay/iA5JpNCjg5nnejbOKm8EiXcASlwDAdvpwezK7kbSbEtt3SHBRhhbu9Zfu/sE6hjsej261DYUyH/dSFvfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919268; c=relaxed/simple;
	bh=rLb7nJKRiiwkIM2P2dqFe24rzIk3hUeTf6g1WB8OF7o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s0YNnPVBwaBZEyZsXZ6LbVrfL3Iyaep2Hi9NgqAIO+6GsyWrzaVEvwJYehi7rNq2jNj3037Pfry0K95bSqD3eJV0BjKmjnnpAbp3WZaxNamoL+j3nlLPNPBTDEAVp/hq4PK3mAnIEe2d1dAB73WJTiwTIrnIdPAFjwkEf7iLH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZhnUD3O; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724919265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1JpaO0p578z0JlRYTDlBV8oEu2LaEMO2fmkIIoTjZ8=;
	b=MZhnUD3OA6hfnpuCvhcT9WanxHGrxto7GxoZAz+ucJTqn5NEbWKTeExpkW7Z10o7NMM+uw
	JQ6hiuDtDCC3rIREnHZ1BAwCYMqdyDNy0YQu3Fd5b3vrMXbiqLFyZpJ570SDylBHjZqA/6
	JdhGRC8uQe4IxXbqdH48Oj+NaVM+1So=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 08/14] mm: copy_pte_range() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <71100c3867c4cf6f5f429ce9f2db8432066d0e99.1724310149.git.zhengqi.arch@bytedance.com>
Date: Thu, 29 Aug 2024 16:13:44 +0800
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
Message-Id: <A619C874-E6B9-4D07-82B9-ABBCDB39DFC2@linux.dev>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <71100c3867c4cf6f5f429ce9f2db8432066d0e99.1724310149.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 22, 2024, at 15:13, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In copy_pte_range(), we may modify the src_pte entry after holding the
> src_ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
> already hold the write lock of mmap_lock, there is no need to get pmdval
> to do pmd_same() check, just pass a dummy variable to it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



