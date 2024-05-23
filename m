Return-Path: <linux-kernel+bounces-186902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1CC8CCA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04306282587
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41034C7E;
	Thu, 23 May 2024 02:12:39 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850C4690
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716430359; cv=none; b=adkeJGlurdNd2hgLb5410dzb9l0SR5KBj8VfVkWdY1PCOJRXOabegQ49L4yI6nouQqfUMh+0bMsWY8HSvIodhapXv4EZDwPg1d4K+587WH43P4ZNXNUFvdb3gYveQdDxzBwgLi8gyyOiOXZnpfAR19SBawLTk6Uy+2/mbcbN5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716430359; c=relaxed/simple;
	bh=95FrxY0on97XhfBNOOoiOqvSNWba/sx2apqOtIcLBbM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fLLeI8P57pHA2ZKuBBUkmJ7qSrL2I7yzeO4QljSu0rQjIv6WH60gwdM20B5ehalMQmGif2sH4SvulrkzwL13prvUHvwR69OP/PM4YTGV/HnMAj/DOFyS1n49gqUJZzGpi+mxiJ7A7LmOZWe53fH7p6k7vMRFzKJz7RnHb8O+ulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VlB3d4Js1z1S5dX;
	Thu, 23 May 2024 09:51:25 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 79A9C1A0188;
	Thu, 23 May 2024 09:54:55 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 09:54:55 +0800
Subject: Re: [PATCH v3 2/5] mm/madvise: Add MF_ACTION_REQUIRED to
 madvise(MADV_HWPOISON)
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <osalvador@suse.de>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-3-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9a0d8716-a33b-8b11-9de6-9791aef6fb7b@huawei.com>
Date: Thu, 23 May 2024 09:54:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240521235429.2368017-3-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/22 7:54, Jane Chu wrote:
> The soft hwpoison injector via madvise(MADV_HWPOISON) operates in
> a synchrous way in a sense, the injector is also a process under
> test, and should it have the poisoned page mapped in its address
> space, it should get killed as much as in a real UE situation.
> Doing so align with what the madvise(2) man page says: "
> "This operation may result in the calling process receiving a SIGBUS
> and the page being unmapped."
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Oscar Salvador <oalvador@suse.de>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

