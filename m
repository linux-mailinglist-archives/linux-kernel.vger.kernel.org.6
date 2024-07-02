Return-Path: <linux-kernel+bounces-237141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B91391EC2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420491C21943
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE42D8F68;
	Tue,  2 Jul 2024 01:01:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC582883D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882108; cv=none; b=VleaiqalIB6RPjCBTRVNy4F05ZZtxmEkqrWODBWMravuQaacpyjCJJ8jnMWFnjmbtG9Km/mcwKsngWhdT7WfsqNsvF551uyEQuO+yKG+LQ1lBBg9d6gmDx91u4PH+W/lAIMqEQQE0z8meCvIPscREx1EkTAHXcLzS1faL6j5a4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882108; c=relaxed/simple;
	bh=FhFF7v+G1PbhGAFlA4JjY/XqNIyyK0JW9bUepNe31UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UZaght0khMHmhei4L+8XhT6O7muzQSk0eVcH6x7azk2g8i5bOnjMWZrZZkGI0YY1LTEMI/GPhN0zSIDfvUGuGfMpaOuzvH7/V1xiZfNhHMpiDqMTc/C6jxhx1It1eUqyY6rEijnbPETs2Ph9cDCaBIF/u9+6PCcYwW+PCNIx3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCl3Y1HKpznYQH;
	Tue,  2 Jul 2024 09:01:29 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DCA051400CD;
	Tue,  2 Jul 2024 09:01:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 09:01:42 +0800
Message-ID: <ab934094-ec54-b580-512e-199017ca99fc@huawei.com>
Date: Tue, 2 Jul 2024 09:01:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<wad@chromium.org>, <rostedt@goodmis.org>, <arnd@arndb.de>,
	<ardb@kernel.org>, <broonie@kernel.org>, <mark.rutland@arm.com>,
	<rick.p.edgecombe@intel.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <202407010839.125126F@keescook>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <202407010839.125126F@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/1 23:40, Kees Cook wrote:
> On Sat, Jun 29, 2024 at 04:55:58PM +0800, Jinjie Ruan wrote:
>> Changes in v3:
>> - Test the MTE test cases.
>> - Handle forget_syscall() in arch_post_report_syscall_entry()
>> - Make the arch funcs not use __weak as Thomas suggested, so move
>>   the arch funcs to entry-common.h, and make arch_forget_syscall() folded
>>   in arch_post_report_syscall_entry() as suggested.
>> - Move report_single_step() to thread_info.h for arm64
>> - Change __always_inline() to inline, add inline for the other arch funcs.
>> - Remove unused signal.h for entry-common.h.
>> - Add Suggested-by.
>> - Update the commit message.
> 
> I didn't see the mentioned feedback from tglx in any of the threads. Is
> lore busted or is there discussion on this series happening somewhere
> else?

It Seems Thomas only sent it to me without a public email.

> 

