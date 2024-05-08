Return-Path: <linux-kernel+bounces-172866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8E8BF7D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FA1285F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6B3B1AA;
	Wed,  8 May 2024 07:58:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453D2C6B2
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155090; cv=none; b=jbCEEg9Np13cy6VTHx0RrosIinJ8GyvcuDYTkYsGMoNzWgmgnDOuvtWXARaKNrWmRQ/r8c4sXGTgSzzigldDw7FFDwgzHRlyl4hDhydrs8Kb6kwaiH+ZESa4P4SD1cORID5jM23/w9rt+gR0lJHLVBTycJqoQrnmdU4ue2JSNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155090; c=relaxed/simple;
	bh=uWM00LTb29R7wXe11vLiSA1AF/FT232XqVRFnb/7+uQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kqqQF+5uYFGzppAmeA/w7TXkkmN9yldgOX2GzF3trk6Zhbhp1j8zKzox0dcpoW7e8u9gOUrtrCIVU+EtxgVelaRo5ZCicbIAFEVzDy6UFqJn1W9GpOF+zAKHft18xGTqFcCZO1WpI0oJyCfXQrzEAmYiZdP0y4x/c17RmscHX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VZ6qf53pwztT2C;
	Wed,  8 May 2024 15:54:38 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id A72751800B8;
	Wed,  8 May 2024 15:58:04 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 15:58:04 +0800
Subject: Re: [PATCH 2/3] mm/madvise: Add MF_ACTION_REQUIRED to
 madvise(MADV_HWPOISON)
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-3-jane.chu@oracle.com>
 <0c7dbf7d-dcb6-f9f2-4a2a-9700ea465a47@huawei.com>
 <c37e5aac-3bc7-4013-b58a-e29c6bfbfd1f@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0268cba2-807c-d7c8-952f-a81f52d45d15@huawei.com>
Date: Wed, 8 May 2024 15:58:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c37e5aac-3bc7-4013-b58a-e29c6bfbfd1f@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/7 3:54, Jane Chu wrote:
> On 5/5/2024 12:02 AM, Miaohe Lin wrote:
> 
>> On 2024/5/2 7:24, Jane Chu wrote:
>>> The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
>>> a synchrous way in a sense, the injector is also a process under
>>> test, and should it have the poisoned page mapped in its address
>>> space, it should legitimately get killed as much as in a real UE
>>> situation.
>> Will it be better to add a method to set MF_ACTION_REQUIRED explicitly when inject soft hwpoison?
>> Thanks.
> 
> So the first question is: Is there a need to preserve the existing behavior of  madvise(MADV_HWPOISON)?
> 
> The madvise(2) man page says -
> 
>        *MADV_HWPOISON *(since Linux 2.6.32)
>               Poison the pages in the range specified by/addr/  and/length/
>               and handle subsequent references to those pages like a
>               hardware memory corruption.  This operation is available
>               only for privileged (*CAP_SYS_ADMIN*) processes.  This
>               operation may result in the calling process receiving a
>               *SIGBUS *and the page being unmapped.
> 
>               This feature is intended for testing of memory error-
>               handling code; it is available only if the kernel was
>               configured with*CONFIG_MEMORY_FAILURE*.
> 
> And the impression from my reading is that: there doesn't seem to be a need.
> 
> A couple observations -
> - The man page states that the calling process may receive a SIGBUS and the page being unmapped.
> But the existing behavior is no SIGBUS unless MCE early kill is elected, so it doesn't quite match
> the man page.
> - There is 'hwpoison-inject' which behaves similar to the existing madvise(MADV_HWPOISON), that is,
> soft inject without MF_ACTION_REQUIRED flag.
> 

I tend to agree with you. It might be a good idea to add MF_ACTION_REQUIRED to madvise(MADV_HWPOISON).
Thanks.
.

