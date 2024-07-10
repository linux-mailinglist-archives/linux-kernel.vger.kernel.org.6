Return-Path: <linux-kernel+bounces-246920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8F92C8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CBD1C21F01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9055B282F1;
	Wed, 10 Jul 2024 03:07:32 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032963B9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580852; cv=none; b=QOFY2n9PEkAGWfBzRW11nzZVAwVGTK0ncECeEGPu6ARbN+C9CB9peVXCgl42Yp30Kbr1QId38mmQHPO2CaWND8ZTnmiQCoDcvDMjjRcM3OWfZ7ibS0UnY9yGUKS18OcDEjFxaFN4+Azt9T+aRo9Xt2zxoffw7yNSqpAQZ+gbalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580852; c=relaxed/simple;
	bh=TqHaV06uBSmqfUUYRzeSvZk9pAKeN/Cp757rAqAOh98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POTkRpYNdbUrdxzaK9yOpAKLyIQhYkziKA+/Rt7aT5UC8Y2mE/Uiw4AlxJ65gcPMjGT7PLMOYP0K9BaO0SNDuWlSCrV0x6vU4otTM1k+DQwo9P0FAg9aeyiLEeQrjCQ+2K0oAWci63QelO7U52tVU21XIlwrGGJ15iNfJRzUn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 46A36U51032649;
	Wed, 10 Jul 2024 11:06:30 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 4EEB222F4AEE;
	Wed, 10 Jul 2024 11:10:45 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Wed, 10 Jul 2024 11:06:31 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <jiaoxupo@h3c.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.chuna@h3c.com>,
        <zhang.zhansheng@h3c.com>, <zhang.zhengming@h3c.com>
Subject: [PATCH] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock?= =?UTF-8?q?=20V2.?=
Date: Wed, 10 Jul 2024 11:07:51 +0800
Message-ID: <1720580871-27946-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Zo0laCcWwAoL0bFu@casper.infradead.org>
References: <Zo0laCcWwAoL0bFu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 46A36U51032649

>> +++ b/mm/highmem.c
>> @@ -220,8 +220,11 @@ static void flush_all_zero_pkmaps(void)
>>  		set_page_address(page, NULL);
>>  		need_flush = 1;
>>  	}
>> -	if (need_flush)
>> +	if (need_flush) {
>> +		spin_unlock(&kmap_lock);

>should this be a raw spin_unlock(), or should it be unlock_kmap()?
>ie when ARCH_NEEDS_KMAP_HIGH_GET is set, do we also need to re-enable interrupts here?

Thanks! Using lock_map/unlock_kmap is better.
Patch V2 will be sent.
 
1.8.3.1


