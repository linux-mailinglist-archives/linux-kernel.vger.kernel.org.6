Return-Path: <linux-kernel+bounces-293203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1112A957BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41E3283EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13839AD6;
	Tue, 20 Aug 2024 03:46:01 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF672F2A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125561; cv=none; b=IUurGm7tg6DppQDmdQ5ckkhAZJbpph3Hkyl1yIPGieQaBhVIEZY3CATXx6UUWtLurJxxcxpItNRYRsTQrnQlM1qlyz+f38ODwHJKoUmsJhPQ8y9NVNTbmnDMd8UcQqACGGwKG+EHA0GkBtJLOPPkwXiSb+/J01xvh0JXe//nTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125561; c=relaxed/simple;
	bh=UlxGhSn46ff6+hU2dEmluyEWnh1+72+xDVfiYcpQETA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ml7PP8ZU2RBE/5vYzt0rPGiu+E3UK3OoE5akFDeriXTJpZA+iM2P9wtf/VyXQbVLlWxtyWdW4JUV3hFRTaH3xjRqHorkpqM4ObJTi+9HiqcWlGLbWRTCbL9ZJn9zW+kecvX3ET3SE0m94nEiaPNd+PHl+y7qTlWt1cPUkBs833o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WnwGt5vK8z1S8KR;
	Tue, 20 Aug 2024 11:40:54 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B09814035E;
	Tue, 20 Aug 2024 11:45:54 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 11:45:52 +0800
Message-ID: <9e27aeee-0e2d-7034-5afc-42f2f14eb02b@huawei.com>
Date: Tue, 20 Aug 2024 11:45:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v12 6/6] arm64: send SIGBUS to user process for SEA
 exception
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, Robin Murphy
	<robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
	<glider@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Aneesh
 Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
References: <20240528085915.1955987-1-tongtiangen@huawei.com>
 <20240528085915.1955987-7-tongtiangen@huawei.com>
 <20240819130809.0000731c@Huawei.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240819130809.0000731c@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/8/19 20:08, Jonathan Cameron 写道:
> On Tue, 28 May 2024 16:59:15 +0800
> Tong Tiangen <tongtiangen@huawei.com> wrote:
> 
>> For SEA exception, kernel require take some action to recover from memory
>> error, such as isolate poison page adn kill failure thread, which are done
>> in memory_failure().
>>
>> During our test, the failure thread cannot be killed due to this issue[1],
>> Here, I temporarily workaround this issue by sending signals to user
>> processes in do_sea(). After [1] is merged, this patch can be rolled back
>> or the SIGBUS will be sent repeated.
>>
>> [1]https://lore.kernel.org/lkml/20240204080144.7977-1-xueshuai@linux.alibaba.com/
> What's the status of that one?  Seems better to help get that in than
> carry this.
> 
> Jonathan
> .

That patch set has not been incorporated yet. The latest one is still
v11.

The consideration here was to ensure the functional integrity of
this feature. Considering that this may cause confusion, it is not
appropriate to make this temporary modification here. Otherwise, this
patch will not be included.  Related impacts are described in patch 0.

Thanks,
Tong.



