Return-Path: <linux-kernel+bounces-318053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B196E7AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526DCB23690
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FDE22083;
	Fri,  6 Sep 2024 02:24:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762238DD2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589457; cv=none; b=RxQKkn+SqSTtGbm/QTf/c7Sz875WONfxtYIJTGHa3ELQXZT9/cC64wk8K96ufZOcb1eSKOfJBEugNAyyHuuI42g+BRiuoDCKoggRh/GFSTJFAeJR7xYcqY8x6+LaGtV0Lxk4KywBByzR7mHIO7YDeeJJY7oDaXdS1BHwDCEFgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589457; c=relaxed/simple;
	bh=yOjmIXa4emd5ltyBCbc6RJMJvvbRw+EgmqF8MEJr/1E=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vBfC7mVHzPS9X83Y9L7Bpd20Vbv1JIoVsfO91ft0OdBBvo2lHBn6JH3evaAVDZoDUvVyowLoQluZN/BKjZI0HLW7XL2oDwVnDtFBc1sM17eaNpULM+0NOOF0us6H7WICs+gzeqVn0RKcaePrYkcKZlvhqsaQB5O4UmtyQwhxAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X0KkK2RxczpVSm;
	Fri,  6 Sep 2024 10:22:17 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 790B81400DC;
	Fri,  6 Sep 2024 10:24:12 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 10:24:11 +0800
Subject: Re: [PATCH v2] mm: z3fold: deprecate CONFIG_Z3FOLD
To: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Vitaly Wool <vitaly.wool@konsulko.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Christoph Hellwig
	<hch@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Chris
 Down <chris@chrisdown.name>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240904233343.933462-1-yosryahmed@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1d3a5751-8af7-8ca9-8dff-4de2597f9751@huawei.com>
Date: Fri, 6 Sep 2024 10:24:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240904233343.933462-1-yosryahmed@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/9/5 7:33, Yosry Ahmed wrote:
> The z3fold compressed pages allocator is rarely used, most users use
> zsmalloc. The only disadvantage of zsmalloc in comparison is the
> dependency on MMU, and zbud is a more common option for !MMU as it was
> the default zswap allocator for a long time.
> 
> Historically, zsmalloc had worse latency than zbud and z3fold but
> offered better memory savings. This is no longer the case as shown by
> a simple recent analysis [1]. That analysis showed that z3fold does not
> have any advantage over zsmalloc or zbud considering both performance
> and memory usage. In a kernel build test on tmpfs in a limited cgroup,
> z3fold took 3% more time and used 1.8% more memory. The latency of
> zswap_load() was 7% higher, and that of zswap_store() was 10% higher.
> Zsmalloc is better in all metrics.
> 
> Moreover, z3fold apparently has latent bugs, which was made noticeable
> by a recent soft lockup bug report with z3fold [2]. Switching to
> zsmalloc not only fixed the problem, but also reduced the swap usage
> from 6~8G to 1~2G. Other users have also reported being bitten by
> mistakenly enabling z3fold.
> 
> Other than hurting users, z3fold is repeatedly causing wasted
> engineering effort. Apart from investigating the above bug, it came up
> in multiple development discussions (e.g. [3]) as something we need to
> handle, when there aren't any legit users (at least not intentionally).
> 
> The natural course of action is to deprecate z3fold, and remove in a few
> cycles if no objections are raised from active users. Next on the list
> should be zbud, as it offers marginal latency gains at the cost of huge
> memory waste when compared to zsmalloc. That one will need to wait until
> zsmalloc does not depend on MMU.
> 
> Rename the user-visible config option from CONFIG_Z3FOLD to
> CONFIG_Z3FOLD_DEPRECATED so that users with CONFIG_Z3FOLD=y get a new
> prompt with explanation during make oldconfig. Also, remove
> CONFIG_Z3FOLD=y from defconfigs.
> 
> [1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com/
> [2]https://lore.kernel.org/lkml/EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com/
> [3]https://lore.kernel.org/lkml/CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com/
> 
> Acked-by: Chris Down <chris@chrisdown.name>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM. Thanks for your patch.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

