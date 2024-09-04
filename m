Return-Path: <linux-kernel+bounces-314649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFA096B657
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6298F1C24732
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6AC1CC16B;
	Wed,  4 Sep 2024 09:19:54 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DB405C9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441594; cv=none; b=FH89dzwAGDPnuj+4JOluwCvrorK4YPLGWOI7WvpoN/hR1gj3vf2pn/6/Ufuub2mfZ/83tpA+RpKz299wt9wTVtFz3+wUfYCHaLK0ppG3+zhhNsERs5ZdCa6B+uqopGRkIKIc+alODvn6G4rf7qftuxOOSPgKvtiL4e8HNSjaufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441594; c=relaxed/simple;
	bh=USPPGjr96n8O2xL2B62X77NHhPpSSdjESlTCwhaL/oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XoLXxcMzEtXRspoVmpoLuTBSsI95b6kXnd15KVBePd3wcRhk9YP/U42e9rgTojpTyVnWlFaGFYPgTpqewqSqqNTEfA7VH+k+QMxQJzFkUByYQr3u8P3ATb/sWnGNEi2Ml10a5yIlAYPnA+SxTnqkCEWdC2lxyTtS8mZI6Jw/+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzH4c3GdMz1j7rs;
	Wed,  4 Sep 2024 17:19:28 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 83D7814011D;
	Wed,  4 Sep 2024 17:19:48 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 17:19:47 +0800
Message-ID: <ede19a0d-4070-568f-becb-13872a7191a5@huawei.com>
Date: Wed, 4 Sep 2024 17:19:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] static_call: Handle module init failure correctly in
 static_call_del_module()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com> <87zfon6b0s.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87zfon6b0s.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/4 17:09, Thomas Gleixner wrote:
> Module insertion invokes static_call_add_module() to initialize the static
> calls in a module. static_call_add_module() invokes __static_call_init(),
> which allocates a struct static_call_mod to either encapsulate the built-in
> static call sites of the associated key into it so further modules can be
> added or to append the module to the module chain.
> 
> If that allocation fails the function returns with an error code and the
> module core invokes static_call_del_module() to clean up eventually added
> static_call_mod entries.
> 
> This works correctly, when all keys used by the module were converted over
> to a module chain before the failure. If not then static_call_del_module()
> causes a #GP as it blindly assumes that key::mods points to a valid struct
> static_call_mod.
> 
> The problem is that key::mods is not a individual struct member of struct
> static_call_key, it's part of a union to save space:
> 
>         union {
>                 /* bit 0: 0 = mods, 1 = sites */
>                 unsigned long type;
>                 struct static_call_mod *mods;
>                 struct static_call_site *sites;
> 	};
> 
> key::sites is a pointer to the list of built-in usage sites of the static
> call. The type of the pointer is differentiated by bit 0. A mods pointer
> has the bit clear, the sites pointer has the bit set.
> 
> As static_call_del_module() blidly assumes that the pointer is a valid
> static_call_mod type, it fails to check for this failure case and
> dereferences the pointer to the list of built-in call sites, which is
> obviously bogus.
> 
> Cure it by checking whether the key has a sites or a mods pointer. 
> 
> If it's a sites pointer then the key is not to be touched. As the sites are
> walked in the same order as in __static_call_init() the site walk can be
> terminated because all subsequent sites have not been touched by the init
> code due to the error exit.
> 
> If it was converted before the allocation fail, then the inner loop which
> searches for a module match will find nothing.
> 
> A fail in the second allocation in __static_call_init() is harmless and
> does not require special treatment. The first allocation succeeded and
> converted the key to a module chain. That first entry has mod::mod == NULL
> and mod::next == NULL, so the inner loop of static_call_del_module() will
> neither find a module match nor a module chain. The next site in the walk
> was either already converted, but can't match the module, or it will exit
> the outer loop because it has a static_call_site pointer and not a
> static_call_mod pointer.
> 
> Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
> Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com
> ---
> V2: Use static_call_key_has_mods() instead
> ---
>  kernel/static_call_inline.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> --- a/kernel/static_call_inline.c
> +++ b/kernel/static_call_inline.c
> @@ -411,6 +411,17 @@ static void static_call_del_module(struc
>  
>  	for (site = start; site < stop; site++) {
>  		key = static_call_key(site);
> +
> +		/*
> +		 * If the key was not updated due to a memory allocation
> +		 * failure in __static_call_init() then treating key::sites
> +		 * as key::mods in the code below would cause random memory
> +		 * access and #GP. In that case all subsequent sites have
> +		 * not been touched either, so stop iterating.
> +		 */
> +		if (!static_call_key_has_mods(key))
> +			break;
> +

Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  		if (key == prev_key)
>  			continue;
>  

