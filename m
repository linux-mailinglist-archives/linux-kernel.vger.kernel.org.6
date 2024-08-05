Return-Path: <linux-kernel+bounces-274060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE79472F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E298B1F210E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9313C81C;
	Mon,  5 Aug 2024 01:23:57 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DD17C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821037; cv=none; b=BKz1X9OFydNpBIbXdk2MrOvYZJ9bXlCv1bMg6LxfdaWpWm1H3G/vZDBFufl7IIrTO5abrqXxRRkorYjlcZUzKQwrUOHb7XCfx06cIP3gnBE0rbsc51Y7fQgsuXHhOuekvMnNGwGDGOdFOymRQl/3TYslQ6Wc2AE7iG5mm+1MLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821037; c=relaxed/simple;
	bh=CRTLw6JnGWJ12BXI3GDrt1wEsDE/p2so/Qqx9kOS958=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tGBNX1Y6PRj7okx4xA5lFnVSDTAqTxW4gjmeSetyerZx0KHhQxo0x9CDcacvDpUp1+9sBUdJUDo3/Qua5D3BA+nexUqCtEXL3TdSSmKEEOqE1GFQTiVGtF+3NGJv3iFd1UrvoYmYemzQN8f6nADMcTwQvpi5Z3m077diukyFjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WcdvW1FYKzfZ7b;
	Mon,  5 Aug 2024 09:21:59 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DB4E518009B;
	Mon,  5 Aug 2024 09:23:51 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 09:23:51 +0800
Message-ID: <6c0a45c3-08a2-f889-9e66-ab8aff66ae8c@huawei.com>
Date: Mon, 5 Aug 2024 09:23:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <bhe@redhat.com>, <akpm@linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/2 19:01, Russell King (Oracle) wrote:
> On Fri, Aug 02, 2024 at 05:25:10PM +0800, Jinjie Ruan wrote:
>> As ARM LPAE feature support accessing memory beyond the 4G limit, define
>> HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to support reserving crash
>> memory above 4G for ARM32 LPAE.
>>
>> No test because there is no LPAE ARM32 hardware.
> 
> Why are you submitting patches for features you can't test?
> 
> I'm not going to apply this without it being properly tested, because I
> don't believe that this will work in the generic case.
> 
> If the crash kernel is located in memory outside of the lower 4GiB of
> address space, and there is no alias within physical address space
> for that memory, then there is *no* *way* for such a kernel to boot.

I'm sorry that I released this patch without testing it. I actually
intended to bring up this issue for discussion. If anyone has the
environment to test it, that would be great. In the meantime, we could
have a discussion on the significance and relevance of this approach.

> 
> So, right now I believe this patch to be *fundamentally* wrong.
> 

