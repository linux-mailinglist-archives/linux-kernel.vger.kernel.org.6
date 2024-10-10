Return-Path: <linux-kernel+bounces-358198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D75997B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAC61F23F70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7E18E764;
	Thu, 10 Oct 2024 03:33:47 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506F3D966
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531227; cv=none; b=qF0cio9qOOPrGTz175IpugMgPMVw92lVyW2BouqQHcd5HfnOiziG9LsLJrBRvyfg0kEbsltZabPgZ/0Eh4gP4rmwMJzzHZLjVwPoudLOELA367DYgmxdn1PmzPw6mmf4TzB9k5h26uagsxBtmfo7Hu29wF3X9KPOoNkPU/iMUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531227; c=relaxed/simple;
	bh=ziVNJrr0OClw/9DDY84zgKDHthWhdqTRKaeTJOQ1BXU=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o2uLnxbqpJ0fl2VkZw7hel5N9SaG3aSCpAsYq7/EjptYTv8Lzrb7IkMqpBV/x629aMGn4lDTohJn84a9x5bROS+Uzon6CZK6lnSIrsTmFTGonkDNVJCj5RyAkgqqr7B5X+DFtfJVftZsubGcSaD3W560nHyXe3fiV+mQT9W3amE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPFg15vS6z10N3T;
	Thu, 10 Oct 2024 11:31:57 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B0D71402CC;
	Thu, 10 Oct 2024 11:33:42 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 11:33:41 +0800
Subject: Re: [PATCH v3 3/3] debugobjects: Reduce contention on pool lock in
 fill_pool()
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240911083521.2257-1-thunder.leizhen@huawei.com>
 <20240911083521.2257-4-thunder.leizhen@huawei.com> <87r08st3ey.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0f108181-13dc-c992-6596-bcafd2b3e000@huawei.com>
Date: Thu, 10 Oct 2024 11:33:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87r08st3ey.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/7 22:04, Thomas Gleixner wrote:
> On Wed, Sep 11 2024 at 16:35, Zhen Lei wrote:
>> +	/*
>> +	 * Avoid allocation and lock contention when another CPU is already
>> +	 * in the allocation path.
>> +	 */
>> +	if (atomic_read(&cpus_allocating))
>> +		return;
> 
> Hmm. I really don't want to rely on a single CPU doing allocations in
> case that the pool level reached a critical state. That CPU might be
> scheduled out and all others are consuming objects up to the point where
> the pool becomes empty.

That makes sense, you're thoughtful.

> 
> Let me integrate this into the series I'm going to post soon.
> 
> Thanks,
> 
>         tglx
> .
> 

-- 
Regards,
  Zhen Lei

