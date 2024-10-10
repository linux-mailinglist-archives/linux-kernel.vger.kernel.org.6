Return-Path: <linux-kernel+bounces-359124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E59987C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E6DB26C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B51C9DE6;
	Thu, 10 Oct 2024 13:31:37 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD621C8FDB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567097; cv=none; b=gdHP1Vvrq4s3euHiuIeRd2Bv2EsdPVzmLz6BLJN4Qqfm0CIMOLxkWHpyyMargwUhjPTaZXgiAVcr25LF9bkATSz3cld08UPWakzEH8LhauSH3b+b+h3FWPyXyqrip3EKZWiBHZL+CUOkcZER33chH1AXsa1HfQJIk3gKfitU9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567097; c=relaxed/simple;
	bh=LK1DbN9Zu/sLwW9BFnXvtZoEWgMRUT+bYS/0nZk9lcY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l+BBsBwWvWMbSVR5rQpTmBURpcJJzy1HikTJ3/j1Qpx/Okhcr7i76fNXfS1i/Eh94/5iIw2H2PonHEDc90Rqct56NsRvm5Ly5cVApBl7RFtmAJSGPHbdxOm1/SFmKy2TT4BnExQgk1+MrTpu8rbDyOC+Z3kwri1417qO/am1nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPVxL37W4zySh5;
	Thu, 10 Oct 2024 21:30:14 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id EDED9180AB7;
	Thu, 10 Oct 2024 21:31:31 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 21:31:31 +0800
Subject: Re: [patch 03/25] debugobjects: Dont destroy kmem cache in init()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.137021337@linutronix.de>
 <c118dad2-4e39-78f2-c09b-0fe771feb86a@huawei.com> <878quwi3jb.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <02904743-8c39-5a44-78cd-a41715bf2f0b@huawei.com>
Date: Thu, 10 Oct 2024 21:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878quwi3jb.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/10 19:46, Thomas Gleixner wrote:
> On Thu, Oct 10 2024 at 10:14, Leizhen wrote:
>> On 2024/10/8 0:49, Thomas Gleixner wrote:
>>> -	if (!obj_cache || debug_objects_replace_static_objects()) {
>>> +	if (!cache || !debug_objects_replace_static_objects(cache)) {
>>>  		debug_objects_enabled = 0;
>>> -		kmem_cache_destroy(obj_cache);
>>
>> kmem_cache_destroy(cache) should be kept, or move it into debug_objects_replace_static_objects()
>> and place it above 'return false'.
> 
> At that point it can't be destroyed. See the backtrace.
> 
> So we just give the objects back and leak the kmem_cache.

Oh, sorry, I didn't figure it out before, but now I do.
But shouldn't we add kmemleak_ignore(cache) ?

> 
> Thanks,
> 
>         tglx
> 
> .
> 

-- 
Regards,
  Zhen Lei

