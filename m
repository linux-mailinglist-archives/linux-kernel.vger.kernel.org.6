Return-Path: <linux-kernel+bounces-223993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC5F911B99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7E21F248B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDB51339B1;
	Fri, 21 Jun 2024 06:24:01 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF012746B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951041; cv=none; b=Co8vZBbJzGvC4t5oTS2TpWFqoo/utYWHdgeFmKLokpqovK8qiG4SsDXXLU2s/UqoSbhRhc3eqY8KxiLNicWjVwbQvkw8ZoOb0F2H8/bKSD1bNmAqLd9FEe0edWj8MSAVKSNMiY2yEgWJZ/icpjae1n3gCMu9xllmb0z9EvgCtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951041; c=relaxed/simple;
	bh=wCMlso4lZECEUnJenKisKJStCVPLXZCJcJh31So+f2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eZxxw+q8w0g+96NZ58iyuRbxB/9W29UzXRURB2JZimAeroo3Jdtzf1sdiLfIIRgVol4NGcn9Ac9A+z/DoCTS9rAF/RxSvqA20bWKZizQH6qtw5ekVkRDB+0HLY0LtMp3Q5SCsri40LllwySKXw5EeozwGst67pY6TlJYfcMX3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W56fY0G3xzMp58;
	Fri, 21 Jun 2024 14:20:21 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id BD507180088;
	Fri, 21 Jun 2024 14:23:55 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 14:23:55 +0800
Message-ID: <39b2bce8-3bc1-b1d9-3e4a-8132a92059c6@huawei.com>
Date: Fri, 21 Jun 2024 14:23:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/5] arm64: irqchip/gic-v3: Select priorities at boot
 time
To: Mark Rutland <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <alexandru.elisei@arm.com>, <catalin.marinas@arm.com>,
	<linux-kernel@vger.kernel.org>, <maz@kernel.org>, <tglx@linutronix.de>,
	<will@kernel.org>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
 <20240617111841.2529370-6-mark.rutland@arm.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240617111841.2529370-6-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/6/17 19:18, Mark Rutland 写道:
>  	cpus_have_group0 = gic_has_group0();

> +#define __gicv3_prio_to_ns(p)	(0xff & ((p) << 1))
> +#define __gicv3_ns_to_prio(ns)	(0x80 | ((ns) >> 1))

What about refactoring the gic_has_group0() using the mapping macros
between PMR priority and GIC priority like this:

---------------%<-----------------
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -882,6 +882,7 @@ static bool gic_has_group0(void)
 {
        u32 val;
        u32 old_pmr;
+       u32 prio = BIT(8 - gic_get_pribits());

        old_pmr = gic_read_pmr();

@@ -896,12 +897,12 @@ static bool gic_has_group0(void)
         * becomes 0x80. Reading it back returns 0, indicating that
         * we're don't have access to Group0.
         */
-       gic_write_pmr(BIT(8 - gic_get_pribits()));
+       gic_write_pmr(prio);
        val = gic_read_pmr();

        gic_write_pmr(old_pmr);

-       return val != 0;
+       return val != (__gicv3_prio_to_ns(__gicv3_ns_to_prio(prio)));
 }
--------------->%-----------------


-- 
BR
Liao, Chang

