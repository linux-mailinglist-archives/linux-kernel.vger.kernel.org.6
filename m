Return-Path: <linux-kernel+bounces-170542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97E8BD8E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2EC285A11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53F1C2D;
	Tue,  7 May 2024 01:22:42 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E06015D1
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715044961; cv=none; b=O3ljUWm2OUUsm2F/TrjI5c/lovEx+GauEml6O3lRDPBVnmk0KOeIzgCY0GxAABT9aV8GqeFOid2BXukoN5X13fYahD+swmhpwO0z1sJgFK94y9KpaLpFddMa/WQEC051TOm/R4NfTxf31U3dJpXkNJnU3DJQfwvAiaIzmVlnsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715044961; c=relaxed/simple;
	bh=msMXKZ8d4w9YCR4MZDFG1QzZzGho5rw0uxxE32K+YXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bd7XRx87QW7FofifHAtfk3sIMh4tuQiWoxx376n42qRqRbWsZjdXl8637rW6qXhfVLjif+7vHe6ygsEr6flDUsNAJFY97A3vEqmaYtnIood3OM63hS6/pTXKovwxAqFFm6CXqp0ODxJyiuTRyedvJQA5Xffo0Vi4GknvS+6KUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VYL5y3HnVz1RCNY
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:19:18 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C0721403D1
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:22:36 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 09:22:36 +0800
Message-ID: <887d424c-c6b5-e5c7-21d3-9b920272fbc3@huawei.com>
Date: Tue, 7 May 2024 09:22:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] genirq/irqdomain: Clean code for __irq_domain_create()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20240430093353.1919862-1-ruanjinjie@huawei.com>
 <87pltyrf9l.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87pltyrf9l.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/5/7 2:01, Thomas Gleixner wrote:
> On Tue, Apr 30 2024 at 17:33, Jinjie Ruan wrote:
>> Introduce irq_domain_alloc_name() function to handle name allocation for
>> the irq domain, add "out_free_domain" label to free the irq domain, and
>> when "is_fwnode_irqchip(fwnode)" is true, "domain->fwnode = fwnode" is
>> the common action, so do it outside the switch, which can make the code
>> more clearer.
> 
> First of all changelogs should describe the reason for the change and
> not enumerate a list of things which the patch does. The latter can be
> seen from the patch itself.

Thanks for the good advice，subsequent patches will learn from the
experience.

> 
>> +static int irq_domain_alloc_name(struct fwnode_handle *fwnode,
>> +				 struct irq_domain *domain,
>> +				 int unknown_domains, char *in_name)
>> +{
>> +	char *name;
>> +
>> +	if (fwnode == NULL) {
>> +		if (unknown_domains)
>> +			domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
>> +						 unknown_domains);
>> +		else
>> +			domain->name = kstrdup(in_name, GFP_KERNEL);
>> +		if (!domain->name)
>> +			return -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * fwnode paths contain '/', which debugfs is legitimately
>> +	 * unhappy about. Replace them with ':', which does
>> +	 * the trick and is not as offensive as '\'...
>> +	 */
>> +	name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	domain->name = strreplace(name, '/', ':');
>> +
>> +out:
>> +	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
>> +	return 0;
> 
> This function is horrible. The only shared thing here is the
> domain->flags manipulation. I'm not seeing how this is an improvement.

Yes, the IRQ_DOMAIN_NAME_ALLOCATED flag is shared, the purpose of this
change is to make the code that allocates the domain name in the
__irq_domain_create() function look like it doesn't take up too much
space, so it looks cleaner.

> 
> Thanks,
> 
>         tglx

