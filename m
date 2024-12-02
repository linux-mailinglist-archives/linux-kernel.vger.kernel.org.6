Return-Path: <linux-kernel+bounces-426876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8519DF99F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EF8162522
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52B1F7B4C;
	Mon,  2 Dec 2024 03:32:11 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0A1F76BB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110330; cv=none; b=Lj27iYqIXrR9rY6EMkmebyfErM3F8AyUq/X0u4tKX3Jr8higx8LGMChU4EpIrClVloPlo/6+sWKR/QClPCDS0Qxo7Wbjor6MZ122FGnqYWCm9u1OFsZC8jpn8ujyER8MOxC33xHoTQQsC0nuWkFWxzjKg8HjAQlSuMfRb9WYZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110330; c=relaxed/simple;
	bh=u/RDofc/JbizFrm0LZfjXpWcWU0525FWx/LuOjKYWuI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jMCikL5jcBnLgUdik7nrXszVLvLb89WzrwyXsD8Nl5ZyXkmXLYzCxvmBGLLrwYZ5vf0quK2xhGhll3VZZrJATY0dOmBq4etNpbBMZHmny5cInRNt6Sq+Rh4nycTw3LK/zyUYULAAQJMn4HYu4g7pr5BPcA7iyrrlA6PjVQlfDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y1q6r2nT4z21mH6;
	Mon,  2 Dec 2024 11:30:28 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D67D1401F1;
	Mon,  2 Dec 2024 11:32:03 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Dec 2024 11:32:02 +0800
Subject: Re: [PATCH] mm/memory-failure: fix VM_BUG_ON_PAGE(PagePoisoned(page))
 when unpoison memory
To: Andrew Morton <akpm@linux-foundation.org>
CC: David Hildenbrand <david@redhat.com>, <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240712064249.3882707-1-linmiaohe@huawei.com>
 <20240712140921.9aa90b18d22e67417d59dfc1@linux-foundation.org>
 <8fe349f9-d3d3-65ab-6045-da0bd19249ea@huawei.com>
 <00e18339-d911-4332-8732-e31bcecbf823@redhat.com>
 <5f8107e2-2b37-d899-f7f2-5a6093d8b089@huawei.com>
 <de73f251-08a0-4122-acfd-1d7fce7540ea@redhat.com>
 <ec6ed1aa-0b6e-df66-1442-93786eabd1ef@huawei.com>
 <dded1b96-8ff3-489a-a92e-b206829feb85@redhat.com>
 <f3aa7133-5754-73f4-9ee1-bff1a8637c07@huawei.com>
 <a4078c71-acf2-4652-92cb-fb9356703dc6@redhat.com>
 <0519bf4b-49aa-6b81-a041-362a171b2a5e@huawei.com>
 <20241130225953.dbb95dbf5f6c785e931f45f7@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c6074487-cf4b-2e33-6cb3-9c8d85b58361@huawei.com>
Date: Mon, 2 Dec 2024 11:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241130225953.dbb95dbf5f6c785e931f45f7@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/12/1 14:59, Andrew Morton wrote:
> On Mon, 5 Aug 2024 14:25:14 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>>>>>> Yup, this will be a good alternative. But will it be better to simply check PagePoisoned() instead?
>>>>>
>>>>> The memmap of offline memory sections shall not be touched, so .... don't touch it ;)
>>>>>
>>>>> Especially because that PagePoisoned() check is non-sensical without poisoining-during-memmap-init. You would still work with memory in offline sections.
>>>>>
>>>>> I think the code is even wrong in that regard: we allow for memory offlining to work with HWPoisoned pages, see __offline_isolated_pages(). Staring at unpoison_memory(), we might be putting these pages back to the buddy? Which is completely wrong.
>>>>
>>>> I agree with you. Thanks for detailed explanation. :)
>>>> Thanks David.
>>>
>>> So ... I assume there will be a new patch? :)
>>
>> I was just back from my two-weeks holidays. ;) I will try to send a new version when possible.
> 
> Maybe I missed the v2.  I'll drop this v1 patch.

Sorry about that but it slipped from my mind. Will send v2 when free.

Thanks.
.

