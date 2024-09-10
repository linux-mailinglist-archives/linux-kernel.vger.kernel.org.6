Return-Path: <linux-kernel+bounces-323358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D73E973BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B241F28AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8706F19D8A4;
	Tue, 10 Sep 2024 15:29:22 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83D19412D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982162; cv=none; b=vD/0i9886nXJvM+XlOxe8pvlg+jiHeJhAmT/88ZEIbnB30F9KqND+NX/u9S6SUTwIe7Qn6PVF9lJtP6aBrptW0srSqG+Az4T0cen6GW0bBdcyYAmGNJhP9wR6YI3TqoeVwPGHUaZhMlBHrUc2owC3+4bXYAmsmLN82Cnxz0Icjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982162; c=relaxed/simple;
	bh=MYUTBmMyYNHQHSWqjwZgHrvFceggDl/wtPiQW2A8BwM=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AALaRmtVcibKlTGhfF9hkIlcRvsYsgNlKc4j6yxK+nC/gfPT08fJH+i+O2Py7amRq71sZ6v+8G18xmr0warw2iK0k/dperaYEBtqpgbU8n7g7W5Nu/RpHnpOgHfLZ+swtdvonfNGl+p3LnV1oh71nWps3w5xK+0e+UjHQFiG6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X36zF2Yksz1P9Mm;
	Tue, 10 Sep 2024 23:28:09 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id E15D2140132;
	Tue, 10 Sep 2024 23:29:14 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 23:29:14 +0800
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com> <87ed5tchc6.ffs@tglx>
 <87bk0xc9iy.ffs@tglx> <32bd93ec-747f-b5a1-917f-f885b87600a5@huawei.com>
Message-ID: <8bc3ebed-f092-6842-bd8b-a8b4b1b30cf1@huawei.com>
Date: Tue, 10 Sep 2024 23:29:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <32bd93ec-747f-b5a1-917f-f885b87600a5@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/9 21:51, Leizhen (ThunderTown) wrote:
> +static void fill_pool(void)
> +{
> +	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
> +	static atomic_t cpus_allocating;
>  
>  	if (unlikely(!obj_cache))
>  		return;
>  
> +	/*
> +	 * Avoid allocation and lock contention when
> +	 *
> +	 *   - the CPU local pool has at least 2 objects left
> +	 *   - another CPU is already in the allocation path
> +	 *   - the global pool has not reached the critical level yet
> +	 */
> +	if (this_cpu_read(percpu_obj_pool.obj_free) > 1 && atomic_read(&cpus_allocating) &&

I rethink that 'cpus_allocating' and 'percpu_obj_pool.obj_free > 1' should be
contradictory. We can only choose one of them. If 'cpus_allocating' can work,
there's no need for another. Since I had no way to prove that 'cpus_allocating'
would work, I removed it in V3.

> +	    READ_ONCE(obj_pool_free) > (debug_objects_pool_min_level / 2))
> +		return;
> +
> +	atomic_inc(&cpus_allocating);
>  	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
>  		struct debug_obj *new[ODEBUG_BATCH_SIZE];
>  		int cnt;

-- 
Regards,
  Zhen Lei

