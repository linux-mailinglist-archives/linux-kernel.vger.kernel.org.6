Return-Path: <linux-kernel+bounces-358665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE13998226
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35E11C25134
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE11A072A;
	Thu, 10 Oct 2024 09:28:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404A188CCA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552527; cv=none; b=eKVO/xSmnyoPhRh+d/7o8MhXiE4xcEzutdHxotHevDdvMZxMuvIdRtDLRMwP3E1Uy9T5Zs/yRt2MmpQSQfICELM3LrW/khOYeER5YL8ZOEKPV8isJcwmO9IxGokQDiyE6MrckboYo2i1Sovyn9Ee94LdPAhyF7CHdxQluhLmuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552527; c=relaxed/simple;
	bh=iuk0D7djrN/zLtY4X5B0QpW3KBGIsr+Y1aDe1pcQ5x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qUXgFJO6ln23qvlc5t411x5zlnjbLNuCiEszyoed8CR45AHQH2P9uhVFzi8jOJhW8+MdFehCBaVmN3j9bI6OX8U1WBMnxxbDg162dwmEfUWwA+dM9ZmgkmepEm7l+RI2UGyJQHS98aj2W/r7nhHYNb0bAA9SqSuqE98iEY4ow5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPPY93NyXzySxY;
	Thu, 10 Oct 2024 17:27:25 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id C24831400D4;
	Thu, 10 Oct 2024 17:28:42 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 10 Oct
 2024 17:28:42 +0800
Message-ID: <27bf46af-3d99-423c-9b49-b6d412e6e0fa@huawei.com>
Date: Thu, 10 Oct 2024 17:28:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/vmscan: stop the loop if enough pages have been
 page_out
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Ridong
	<chenridong@huaweicloud.com>, <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao
	<yuzhao@google.com>, David Hildenbrand <david@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, Barry Song
	<baohua@kernel.org>
References: <20241010081802.290893-1-chenridong@huaweicloud.com>
 <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/10/10 16:59, Kefeng Wang wrote:
> Hi Ridong,
> 
> This should be the first version for upstream, and the issue only
> occurred when large folio is spited.
> 
> Adding more CCs to see if there's more feedback.
> 

Thank you very much, Kefeng, this is the first version.

Best regards,
Ridong


