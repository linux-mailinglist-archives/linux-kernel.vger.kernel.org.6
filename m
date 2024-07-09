Return-Path: <linux-kernel+bounces-245560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3292292B461
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E271C219C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6771553A7;
	Tue,  9 Jul 2024 09:50:28 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB0152E03
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518628; cv=none; b=HPphATqvEreZ03RRrYa6fLKmcZu+xD525slFORyWtEGzCz/mZ0Fs5T8XTNQkkup0OGZBj3HQzMDbzwCL9gBYkWHhcnHek3KaJFbR0Q4B2n6FouGgwU7q2Vi/ksbOj4joqXc2li9U2k0SH3gqAnScvyFbUpcZIFWX8C1zxac+rPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518628; c=relaxed/simple;
	bh=bQWN4tLvi72L/lJcRZiohCEWS4mEqsepU1WqiTJFNhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WWz4jLRxjY9O9iPH5sL8Y2FMNz/EguNgvpvCqes/e1D96agHdFwbsUsVp9WKRHDEp9i74gmyE2NYKk0pTOSurpIcQUi0WsN2Nlm34y+IBhKlGLiORN4pfZlf/TU66mVo0JLpLI5Zc+xSbYL/IOee35FaySEfASyL1Snwhf6ei8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJGMJ3T7RzxVgV;
	Tue,  9 Jul 2024 17:45:48 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 8427D18007E;
	Tue,  9 Jul 2024 17:50:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 17:50:21 +0800
Message-ID: <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
Date: Tue, 9 Jul 2024 17:50:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel
 reservation
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <linux@armlinux.org.uk>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<arnd@arndb.de>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<rmk+kernel@armlinux.org.uk>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>, <deller@gmx.de>,
	<javierm@redhat.com>, <robh@kernel.org>, <thunder.leizhen@huawei.com>,
	<austindh.kim@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/9 17:29, Baoquan He wrote:
> On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
>> Currently, x86, arm64, riscv and loongarch has been switched to generic
>> crashkernel reservation. Also use generic interface to simplify crashkernel
>> reservation for arm32, and fix two bugs by the way.
> 
> I am not sure if this is a good idea. I added the generic reservation
> itnerfaces for ARCH which support crashkernel=,high|low and normal
> crashkernel reservation, with this, the code can be simplified a lot.
> However, arm32 doesn't support crashkernel=,high, I am not sure if it's
> worth taking the change, most importantly, if it will cause
> misunderstanding or misoperation.

Yes, arm32 doesn't support crashkernel=,high.

However, a little enhancement to the generic code (please see the first
patch), the generic reservation interfaces can also be applicable to
architectures that do not support "high" such as arm32, and it can also
simplify the code (please see the third patch).

> 
> Thanks
> Baoquan
> 
> 

