Return-Path: <linux-kernel+bounces-172950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12C8BF934
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E150D1F227C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ED37317D;
	Wed,  8 May 2024 09:03:31 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BC46453
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159010; cv=none; b=alIjHPp9kam684gZfNOA/CTQ9QFNyuPj9UYYDtgYImWcFyhilQK3DqdGHCyQooUOhaB6YlID0e0BdPJJcHnnrye8KRGMYEulcGTzlaZYS3+V5fZj+AJ/MonZ/pJOfOs81pWqb5XeLIDRFMqbZYco1fIR8ojjGPBvGVblGAE5RbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159010; c=relaxed/simple;
	bh=gnb1PejWkqIgziZzJ4WDDPo7wNIn+X1yP+icGFYy69s=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NxAp9pRPZsw7R0xtqjFpeIQxoDkqXtTc6G/50MJZE8V8+Ftfiu9gQaLaqfs/g3rmqLzaS8QOoPyBhrwKQ+w/HufjBCpQ89Hk2yMf8nWRSu5FdbLax/VknsgkRH5mRiArvnSGl3t6oNjxzIxACEWsvYEPWpUOR5K6hahchoDe6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VZ8GT622Czdg6D;
	Wed,  8 May 2024 16:59:29 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 7486614022F;
	Wed,  8 May 2024 17:03:20 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 17:03:20 +0800
Subject: Re: [PATCH 3/3] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-4-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2e51deff-24ca-32d5-dbd2-9077f860723c@huawei.com>
Date: Wed, 8 May 2024 17:03:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240501232458.3919593-4-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/2 7:24, Jane Chu wrote:
> When handle hwpoison in a GUP longterm pin'ed thp page,
> try_to_split_thp_page() will fail. And at this point, there is little else
> the kernel could do except sending a SIGBUS to the user process, thus
> give it a chance to recover.

It seems the user process will still receive SIGBUS via kill_accessing_process()
when (re-)access thp later. So they should have a chance to recover already.
Or am I miss something?

Thanks.
.


