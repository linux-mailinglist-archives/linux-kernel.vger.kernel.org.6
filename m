Return-Path: <linux-kernel+bounces-358129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A203D997A83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D2C1C203B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98F4594C;
	Thu, 10 Oct 2024 02:19:56 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046D1773D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526796; cv=none; b=RcOV1oxK4HbKAdsYNJPM4T0jhZMb3RVQn6+SUW3ujj170409FUo1QHcdH/qGQtf9bvhW1viCWMNrQkcFLlvPlmq8GR/00h3MdEo4QlCfw3fbCUTPHJ0K4mZKLTLLXhVpYXdArl1S+meYMKvS+wktON1B5KJ9V5TG9ipgqk4lepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526796; c=relaxed/simple;
	bh=TUXpeUxfX/b1sXOvHxKTJwpfVheVBhQrJjMEcjRvi50=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=saxoQSe94BAK/QPjqCB2PG0rkC8VpSCpVmT9y5Oj9qtR+vvyrKQM189hSk0Tnd7Hjxd3salw6uW3KxChFoQcdc/ov3Llw6J5Fwlqf4Ry+AP1UM8QFG06HTZntXPbWkTStopgUmJcDFukM1GBcc92TZGVtJ3eq46qRwu4Kic4OJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPD2Y4GLxz1j9Wn;
	Thu, 10 Oct 2024 10:18:45 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 810091A016C;
	Thu, 10 Oct 2024 10:19:51 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 10:19:51 +0800
Subject: Re: [patch 04/25] debugobjects: Remove pointless hlist initialization
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.200379308@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a4c8cba5-ca20-7440-c0c6-4a30e9aa677f@huawei.com>
Date: Thu, 10 Oct 2024 10:19:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.200379308@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:49, Thomas Gleixner wrote:
> It's BSS zero initialized.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -1364,20 +1364,11 @@ static bool __init debug_objects_replace
>  void __init debug_objects_mem_init(void)
>  {
>  	struct kmem_cache *cache;
> -	int cpu, extras;
> +	int extras;
>  
>  	if (!debug_objects_enabled)
>  		return;
>  
> -	/*
> -	 * Initialize the percpu object pools
> -	 *
> -	 * Initialization is not strictly necessary, but was done for
> -	 * completeness.
> -	 */
> -	for_each_possible_cpu(cpu)
> -		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
> -
>  	if (!debug_objects_selftest())
>  		return;
>  
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei

