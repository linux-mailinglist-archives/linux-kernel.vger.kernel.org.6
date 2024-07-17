Return-Path: <linux-kernel+bounces-254608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9907933566
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53511F2204F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B964C99;
	Wed, 17 Jul 2024 02:23:14 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55B28EA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721182993; cv=none; b=uzt2P+PXWY6Lrdo/L62vg9ZJz0yDScrmC17fFDOz/SMaG8Tze29p6y5OJ/G6A0zIlEJ/f3rcx+CgmSLlz9mYYPjLyrXTUyFX9HkPiv3379bFW2TBEVcLcuDfq+9oZf5R+i4GCLCWkr6pKJs+HCA8nmqTK9EKeP+7AHVy4wMUISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721182993; c=relaxed/simple;
	bh=KVxVDa2sLtsQZ1BUHM4panynfvlVr/pW1Z0Zwxh9ofI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rVrk2LQu+7h+TpcC6dcBKqT5uqO9xNN/MsKVukFIzAArxsLa05WT4q5dXD8O5eauC1nQjMQlV0v1Q/J2deMCWpopZgvI0cqUORfAJ84+UxpjuRr+1B3LKJ1DFKuswdCw00PeRS+QLsHgcI7VCj1vRkR8FpiaGNviwZvcTSeoNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WP05t4b8Yz1HFLL;
	Wed, 17 Jul 2024 10:20:34 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id B4E7918002B;
	Wed, 17 Jul 2024 10:23:07 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jul 2024 10:23:07 +0800
Subject: Re: [PATCH v2] mm/hwpoison: reset hwpoison filter parameters in
 pfn_inject_exit()
To: Michal Hocko <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240716033516.606582-1-linmiaohe@huawei.com>
 <ZpYxkH1EFB65tEzt@tiehlicka>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c81031da-2722-dea4-0118-9f4911035cae@huawei.com>
Date: Wed, 17 Jul 2024 10:23:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZpYxkH1EFB65tEzt@tiehlicka>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/16 16:38, Michal Hocko wrote:
> On Tue 16-07-24 11:35:16, Miaohe Lin wrote:
>> When hwpoison_inject module is removed, hwpoison_filter_* parameters
>> should be reset. Otherwise these parameters will have non-default values
>> at next insmod time.
> 
> There is a clear layering broken here. We have mm/memory-failure.c using
> values and mm/hwpoison-inject.c defining the values. Both with a
> potentially different life time. Shouldn't that be fix instead?

In fact, we have mm/memory-failure.c defining and using these values while they can
only be modified through mm/hwpoison-inject.c from userspace. The common usecase should be:

1. User set hwpoison filter parameters first through mm/hwpoison-inject.c.
2. Then doing memory hwpoison test through mm/hwpoison-inject.c.

hwpoison_filter_* parameters are only used for test from userspace. From this perspective,
this potentially different life time doesn't break anything. Or am I miss something?

Thanks.
.



