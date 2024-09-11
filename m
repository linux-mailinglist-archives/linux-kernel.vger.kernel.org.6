Return-Path: <linux-kernel+bounces-324532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FCA974DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF801C20F34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7515445B;
	Wed, 11 Sep 2024 09:04:32 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCC2AF1D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045472; cv=none; b=qPADuKcBmgJZXkDJlXaKlNK5A4a+LtqC/PlPd63+ipFCMMa+wjBfoMZeRp3rHDeXlcjeMnUmUdCFFZxMO/hLoZOoWm81/TVchXfKnAFVYVSNxhb5/JbyNJANxNxy8uOA0UV35MthQnn6EO2jrlEYmHwZJnIYlMVdt6Ve7iAYBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045472; c=relaxed/simple;
	bh=0Ri7KpbpHt/s4+9YNBrDYEI6UeBcm13CEOVnVl0nNSs=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lgo5NxzoXvyKuZi8ujhVS7H7t0gYY+uVA5AWxGuCDwlvio5Hf5ow8I3EYM9lMdw5YII78d85dA20BbkhkQA1rSgjXgjNyKgNuUA+xlbSRdZyRokgeLQKqEHNg7CN0+V3Z2WkunGWCxzZ41yi+jWHeBHNVBJZJt99TOBAE9lnMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X3ZNd72xvz1P9XN;
	Wed, 11 Sep 2024 17:03:13 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CA951800A0;
	Wed, 11 Sep 2024 17:04:20 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 17:04:19 +0800
Subject: Re: [PATCH v3 3/3] debugobjects: Reduce contention on pool lock in
 fill_pool()
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20240911083521.2257-1-thunder.leizhen@huawei.com>
 <20240911083521.2257-4-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <90546c16-52e3-b92c-d99b-724278647809@huawei.com>
Date: Wed, 11 Sep 2024 17:04:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240911083521.2257-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/11 16:35, Zhen Lei wrote:
> If the conditions for starting fill are met, it means that all cores that
> call fill() later are blocked until the first core completes the fill
> operation.
> 
> Since it is low cost to move a set of free nodes from list obj_to_free
> into obj_pool, once it is necessary to fill, trying to move regardless
> of whether the context is preemptible. To reduce contention on pool
> lock, use atomic operation to test state. Only the first comer is allowed
> to try. If the last comer finds that someone is already trying, it will
> give up.
> 
> Scenarios that use allocated node filling can also be applied lockless
> mechanisms, but slightly different. The global list obj_to_free can only
> be operated exclusively by one core, while kmem_cache_zalloc() can be
> invoked by multiple cores simultaneously. Use atomic counting to mark how
> many cores are filling, to reduce atomic write conflicts during check. In
> principle, only the first comer is allowed to fill, but there is a very
> low probability that multiple comers may fill at the time.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Hi, Thomas:
  I was going to mark "Signed-off-by" as you. Because except for the
following line of changes, you wrote everything. But you're maintainer.
It doesn't seem good if I post a patch with your Signed-off-by. Please
feel free to change it, but do not forget to add "Reported-by" or
"Tested-by" for me.

@@ -174,14 +198,14 @@ static void fill_pool(void)
 				last = new;
 		}
 		if (!cnt)
-			return;
+			break;

-- 
Regards,
  Zhen Lei

