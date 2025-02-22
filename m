Return-Path: <linux-kernel+bounces-526939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1BA40564
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505FC705356
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90771FF60F;
	Sat, 22 Feb 2025 04:00:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB3200130
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740196806; cv=none; b=K+BGXUi+FY8LKMNGKgqeqdMut7VQo9jvY9qk5kxe8TFUiQg9PQDfhgFtp26+rPnJubz19tQNSpQYdbBtyv+aQLscncGKe/QbfY8/770A1i+dcsQQkxbDQrU/ImBpkIy/pMmw7MtxAZZZYMR6Ofbik+mRHyNvyxCJ5p2aXBnHjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740196806; c=relaxed/simple;
	bh=FYW5oiQoMXHgRSvfoVZoN+9ekRJexcKNeKEA/kqOKck=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nLpDFHlb+THffRQfUURsJ0cVroB7v8EUWJx0LsTQz8hzxWk3hO+TGU6yTjRmonG78IRJwp55bokTJZ60Rg0LqPFCsL8bMbbkbbe06lO5eGHz9GIsv+dN+itZD/vu03TPGiQgAfOYbA8XQXEVA054nex21pO0D+zWO89uC6JWhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z0CsB0Jllz1PGhX;
	Sat, 22 Feb 2025 11:58:22 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 219D714051A;
	Sat, 22 Feb 2025 11:59:55 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 11:59:54 +0800
Message-ID: <2c7dfa44-266a-4aa6-9401-7528368f171e@huawei.com>
Date: Sat, 22 Feb 2025 11:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<kasong@tencent.com>, <ryan.roberts@arm.com>, <chrisl@kernel.org>,
	<huang.ying.caritas@gmail.com>, <schatzberg.dan@gmail.com>,
	<baohua@kernel.org>, <hanchuanhua@oppo.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
To: <willy@infradead.org>
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <Z7lIYzLSACbWxlEM@casper.infradead.org>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <Z7lIYzLSACbWxlEM@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/2/22 11:45, Matthew Wilcox wrote:
> On Sat, Feb 22, 2025 at 10:46:17AM +0800, Wupeng Ma wrote:
>> Digging into the source, we found that the swap entry is invalid due to
>> unknown reason, and this lead to invalid swap_info_struct. Excessive log
>> printing can fill up the prioritized log space, leading to the purging of
>> originally valid logs and hindering problem troubleshooting. To make this
>> more robust, kill this task.
> 
> this seems like a very bad way to fix this problem

Sure, It's a bad way to fix this. Just a proper way to make it more robust?
Since it will produce lots of invalid and same log?

> 


