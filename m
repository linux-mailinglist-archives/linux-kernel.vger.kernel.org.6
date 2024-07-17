Return-Path: <linux-kernel+bounces-254827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D638293383B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14ADE1C22608
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5991CF8A;
	Wed, 17 Jul 2024 07:49:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBBD1CD00
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202541; cv=none; b=DlfGROycMKHX3H9Zp7egA7GEUfDQx8Fv2TRwP9eMJ2vXIDem1jYXs79RoM5LYtoT2c1W2YkHXiKCs7/JpJB21udAdGjedPmXabxMg+2f5gmrqI6hXYRmsMDbB2grj9CqpmksTkXN6WqXshZTBefTQImYraJceos0f1HfKpvEjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202541; c=relaxed/simple;
	bh=fQKinLOgVYXUaqhb1jsK2F5qZ/2mY2/bYYXibk9U4MA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qTErLpAA65BV+bIP12ObFjcMcnjBW5ExNwTYkHvfDfpM3qaYb2vf2gHGdzXuBTilmdzPP9R6rO4tvI5m9zTsB3ejhWWauz4CRzIfMbUMGufre6sk6xOwTL5rvGUhkUvQV/YFa1EffG9rblm9zqAJyg7HxpEaqAHIBsLKXtzjtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WP7Lk3rZmzdj7G;
	Wed, 17 Jul 2024 15:47:10 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A4A114037B;
	Wed, 17 Jul 2024 15:48:54 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jul 2024 15:48:53 +0800
Subject: Re: [PATCH v2] mm/hwpoison: reset hwpoison filter parameters in
 pfn_inject_exit()
To: Michal Hocko <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240716033516.606582-1-linmiaohe@huawei.com>
 <ZpYxkH1EFB65tEzt@tiehlicka>
 <c81031da-2722-dea4-0118-9f4911035cae@huawei.com>
 <ZpdiOAjdSJfkpbr7@tiehlicka>
 <d04b9e4f-fc43-f93b-c1a2-2ed9479ffc71@huawei.com>
 <Zpdx-smohyWI2nYV@tiehlicka>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <04f8db38-9a53-a81a-82ac-21653f795e08@huawei.com>
Date: Wed, 17 Jul 2024 15:48:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zpdx-smohyWI2nYV@tiehlicka>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/17 15:25, Michal Hocko wrote:
> On Wed 17-07-24 14:59:40, Miaohe Lin wrote:
>> On 2024/7/17 14:18, Michal Hocko wrote:
> [...]
>>> Why does this need to be done through different modules? Why it cannot
>>> be part of the memory-filure.c?
>>
>> This is a bold idea for me. :) I think it can be part of the memory-filure.c.
>> So CONFIG_HWPOISON_INJECT should be removed from the world and then make
>> hwpoison-inject default on when MEMORY_FAILURE is configured?
> 
> I would start by moving code into mm/hwpoison-inject.c. Whether this
> should also remove CONFIG_HWPOISON_INJECT is a different question. I
> am not really sure a debugfs interface warrants a config option. Anyway
> two things for two separate patches
> 

Thanks for your suggestion. :) Will try to do it when I am free.
Thanks.
.

