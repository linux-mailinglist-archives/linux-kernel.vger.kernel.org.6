Return-Path: <linux-kernel+bounces-248645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D0492E01E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EBF283786
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8E484DE9;
	Thu, 11 Jul 2024 06:30:21 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1079CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679420; cv=none; b=GDv+RHSVTyJRcMeHj18O3rNKNRy5FKVAiSh9OXurON/CuY1rNTYo0FO0hjcNleSPDh2QExmPJhcqIi/C3zl4cEZNggDyxnaBMs1G0J2kqdOZ6pTyV9TrBqa2lwXivoUKtom3hST2BCBv2d6rl/orAs9aKtWbC+z2l3kgWtyw/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679420; c=relaxed/simple;
	bh=KAT9RnmPL0U58mleJPhdAUKbDaq4Gt6Eq4Q3xQ2t9KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cnjc5Q/1YweydEM1FsIixr+J/wE37s8GL4VIVMGVhY2onMbvNcFw/NfLn0OUWO2b84mA2DvB1FEAZNIjXrDEVA+ERqKzoyT2yXPBWDeY+QMGgcgkVBwI8O/jflNvJ+ymdLTu8gpQPcFtb77drzeL/K0U9h9XQ369AI66t20GHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WKPr91XfwzQl1c;
	Thu, 11 Jul 2024 14:26:17 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E3EE8140416;
	Thu, 11 Jul 2024 14:30:13 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 14:30:12 +0800
Message-ID: <eb647b6d-55cb-4fa2-6e2f-642d10afa719@huawei.com>
Date: Thu, 11 Jul 2024 14:30:11 +0800
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
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

It seems that x86_32 doesn't support crashkernel=,high and use the
generic interface，and also have the first patch bug. I’ll resend the
first patch and explain it.

> 
> Thanks
> Baoquan
> 
> 

