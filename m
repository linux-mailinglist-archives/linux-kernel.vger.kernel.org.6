Return-Path: <linux-kernel+bounces-340010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16DE986D44
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F21281035
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C759188CB0;
	Thu, 26 Sep 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FzQRxgPk"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B71178CE2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334586; cv=none; b=r0AmbQelA3VX5Mh+Gw4Nr3dwbKn1nfuYjGjsexqZXuZuAg1JAjMIMu9Y7C+daMLvum394scU4cJ5Dci4yMZ3pvo9Bw9IQl1LVAoCa1YkMmOjr0T643dgneVbAn7HGE0j5kPbrnnwxOQqpCD1U3b1x+avswFe7dP7Uxv8/y50JXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334586; c=relaxed/simple;
	bh=ASruXeihzW+A18HDmKOWu1I6lxj2mk4Oe1GijWR2w9M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=moxI1F/cjet4h5amlyCgS7eWS1oVpGBj2ad264Hi1eLaDm12ei0hqWXWAuHx2OqxNY4bIEmXZuW0Sn5QmHrYeQpOqBF7ZIkhBFDx6LcU5hNTG6BjPR4YnIx6C1aEpXlr6o71GoNPL6QixN9H5uQ9GKNKzwTg9FP5utKmBP0BY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FzQRxgPk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727334582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wu2H9oCzBNDNFygmuv4LIUDixIi3SoCczsdVGINmQ6s=;
	b=FzQRxgPkVajfTnEaxLqPfGqDVOfaRFQk/aaj96WnwiNRuSD6XzWL6p+fBCgWivm8eRCkW+
	p5VdhJ9DuZIiQ6LAYVdc5Eil/kT1FnKsE46cPPHRIyLEslkFmE/OSJN4y44g6o3jboFkj8
	nWiW64JSBFfY1euJ7276ockRhHozJQg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v5 10/13] mm: page_vma_mapped_walk: map_pte() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2620a48f34c9f19864ab0169cdbf253d31a8fcaa.1727332572.git.zhengqi.arch@bytedance.com>
Date: Thu, 26 Sep 2024 15:08:38 +0800
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
Message-Id: <2C926DC1-AE51-42CD-8351-62A130D0BC4A@linux.dev>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
 <2620a48f34c9f19864ab0169cdbf253d31a8fcaa.1727332572.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 26, 2024, at 14:46, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In the caller of map_pte(), we may modify the pvmw->pte after acquiring
> the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
> this time, the pte_same() check is not performed after the pvmw->ptl held,
> so we should get pmdval and do pmd_same() check to ensure the stability of
> pvmw->pmd.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


