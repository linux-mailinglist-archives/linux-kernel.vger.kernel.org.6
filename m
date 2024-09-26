Return-Path: <linux-kernel+bounces-340008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB0A986D41
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015B91F228F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36AA188907;
	Thu, 26 Sep 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wSW+aXCy"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314581E86E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334492; cv=none; b=UCdNERqrYnEHruu7+a0Xt6baIqIKop4eUdjAFlffN2zJ0IMarSrZR1OR9/znjggBBcYCLkB2wrhOGFHgu1hATdjfuyQozSuddYXgMVpwM9UhsZsGTLGh7OiK3xtwGmq7knM4OnrYeSWhziNbK/xY0ZTSKueQ7fluXm7BYvrzjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334492; c=relaxed/simple;
	bh=ctzv744xxU/0ffRxuVRoCwBgLFKyB3+4PNqS1rYFzLw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=C1nxw/tSr0MK5Pl4+RKRbUkTYiHqUqjQS/a9r73cOLViuVxHgBxW/vuNrHSV5iT7oZGpXPTfrDHJZeNQz1d8x45arocB4F0nnCfskEBcXB3AT5Q7QQ//PftKtufadnkt74pVVz4lbZfZvsh+iQIp2AR4e4nGwjl9mVdpEo367b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wSW+aXCy; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727334482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WclAnEXrzF/Gh4XbPxe2UDc6ATX/PcOlqBxVSmpUuVc=;
	b=wSW+aXCyPsY6o4Dgbx65oTZJus+k13XJPDe/aM8cYxqcxGDREgn/+D7RD88j2kVPBa6cEI
	TykwwfZRqNlzTSPcaPt32nBl94JX6Zb7m3ubsqol8cO5a4MjKGHfaFvFbdW3CN2OMt1qMh
	MYXHGvqROg2c9qWaxO2wmgI48lcLwog=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v5 07/13] mm: khugepaged: collapse_pte_mapped_thp() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <055e42db68da00ac8ecab94bd2633c7cd965eb1c.1727332572.git.zhengqi.arch@bytedance.com>
Date: Thu, 26 Sep 2024 15:07:12 +0800
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
Message-Id: <3418680E-14B2-4098-8730-6F569ABF51DD@linux.dev>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
 <055e42db68da00ac8ecab94bd2633c7cd965eb1c.1727332572.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 26, 2024, at 14:46, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
> this time, the pte_same() check is not performed after the PTL held. So we
> should get pgt_pmd and do pmd_same() check after the ptl held.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


