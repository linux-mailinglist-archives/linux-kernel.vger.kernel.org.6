Return-Path: <linux-kernel+bounces-293999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D58958776
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3269AB21508
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612C190046;
	Tue, 20 Aug 2024 12:57:29 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE71370
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158648; cv=none; b=BBdTj+X9QuClARbzJg17fgVtA8+RaVr6yvoXX4cBOdZDLQaWLy41eneSFuSkWyF7nGNnf2CUmNxmVIlOivfHES20omLY8wJswlVfnrsBn2slkIoHn9Pw57uTVP2oTjytl+PV69egmqceHmjnlL9Ywo5hfhns1JN1PTk0Es0Al7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158648; c=relaxed/simple;
	bh=eMHc/22iv7RIpxgJBbHPmB4EevDR5hFegtZuV2hJRsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qvvVuPfUrd2GUgms/ja6W3TeijpEwWmDyzdrOOHIdaZaNzY1LuxKqASLSASX+fRugSBEyqmcjzYTzrzcA/eoygoA8MPlOMu55/K7bfmVpNCDpN3YOG2YzWqbZqcwCAePEunNAQunbHr2heMZFw4zeHM2TV4Xh8w0ahi/+Vpxm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wp8Zm1n0Bz1xvTv;
	Tue, 20 Aug 2024 20:55:28 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 575C2140361;
	Tue, 20 Aug 2024 20:57:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Aug 2024 20:57:21 +0800
Message-ID: <dee1b427-4436-c040-091f-d5e6094297e1@huawei.com>
Date: Tue, 20 Aug 2024 20:57:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/3] arm64: Prepare to switch to generic entry
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <rostedt@goodmis.org>,
	<arnd@arndb.de>, <ardb@kernel.org>, <broonie@kernel.org>,
	<mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-3-ruanjinjie@huawei.com>
 <32a3bb02-59b2-432d-a75b-d7951971cda6@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <32a3bb02-59b2-432d-a75b-d7951971cda6@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/20 19:42, Kevin Brodsky wrote:
> On 29/06/2024 10:56, Jinjie Ruan wrote:
>> -#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1))
>> +static __always_inline bool on_thread_stack(void)
>> +{
>> +	return on_task_stack(current, current_stack_pointer, 1);
>> +}
> 
> This looks reasonable but I wonder why this change is required (as the
> commit message suggests)?

There seems to be a compilation problem, but rolling back this function
is ok now.

> 
> Kevin
> 

