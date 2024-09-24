Return-Path: <linux-kernel+bounces-336617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21749983D19
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F1D2827DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242A73451;
	Tue, 24 Sep 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vTZjTUVf"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F81CFBC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159115; cv=none; b=nwp9glmPxJox6qu1h4jXo0d0KbJihY0s06HGtLFhnqVscLfC/JGB/MC++yC7vNGl8sluykiiG4g+maXGGMLy/rgdaHxTZ//5CYlaYUbpB2HT/+dp278yCxSgbrhEcg3O6CEhqmT5HzEPaIN47aS3/cRuJxYk+EcUOSpo6+U6cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159115; c=relaxed/simple;
	bh=v9elQ+Ne6MaWGB970rivP6cwRA/1fbl1IE4zdUsiSqY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZoAIWyw7T/3Ixc1idTy9lttIP1vSuk9gxpVdrZzDQyZzYWNWXpENhRcZ9s8M/gWxB/SvTOReFbimYhbzqhy5qihO6zzQQo3jjfAtQZaB3PDZGwwup+SiiaSrw1Zs0N43SmWGSoJn1mS/taGoXZCfDHPAsHJ9m+f6BDL3dGsFqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vTZjTUVf; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727159110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aYhado5OwzZFYPAS8E74g3IrdHqPgkubeEg7xLGfQY=;
	b=vTZjTUVfu5HZHc+3wl9pLaAy6KGDor9B0L2oxER/ntkzITpVy7bWliohhRheobOThq/tnF
	HL4sONWWsPMW0ncQWMe9LLqRPKyHktICgGU+zUczbRyzISml4fMsH0chtX9RyvIJ4B26wX
	MZMt2nLfnJDnEtbaottDuuXxiTsw1nk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v4 01/13] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1a4fea06f8cada72553a8d8992a92e9c09f2c9d4.1727148662.git.zhengqi.arch@bytedance.com>
Date: Tue, 24 Sep 2024 14:24:27 +0800
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
Message-Id: <4D6AAB88-6BA9-4F7E-9EEA-829640D1BDDF@linux.dev>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
 <1a4fea06f8cada72553a8d8992a92e9c09f2c9d4.1727148662.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 24, 2024, at 14:09, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> Currently, the usage of pte_offset_map_nolock() can be divided into the
> following two cases:
> 
> 1) After acquiring PTL, only read-only operations are performed on the PTE
>   page. In this case, the RCU lock in pte_offset_map_nolock() will ensure
>   that the PTE page will not be freed, and there is no need to worry
>   about whether the pmd entry is modified.
> 
> 2) After acquiring PTL, the pte or pmd entries may be modified. At this
>   time, we need to ensure that the pmd entry has not been modified
>   concurrently.
> 
> To more clearing distinguish between these two cases, this commit
> introduces two new helper functions to replace pte_offset_map_nolock().
> For 1), just rename it to pte_offset_map_ro_nolock(). For 2), in addition
> to changing the name to pte_offset_map_rw_nolock(), it also outputs the
> pmdval when successful. It is applicable for may-write cases where any
> modification operations to the page table may happen after the
> corresponding spinlock is held afterwards. But the users should make sure
> the page table is stable like checking pte_same() or checking pmd_same()
> by using the output pmdval before performing the write operations.
> 
> Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
> will be read-only/read-write protected.
> 
> Subsequent commits will convert pte_offset_map_nolock() into the above
> two functions one by one, and finally completely delete it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



