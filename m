Return-Path: <linux-kernel+bounces-233319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310DA91B567
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F376B21D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FB1C6A4;
	Fri, 28 Jun 2024 03:20:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF714277
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544840; cv=none; b=GKthmpiHEZuHJCfGb6a5yyOcGGlpSIMFWd96LP/yn2Fo1xLn3I28IgZ7xTF2GQFgKysC7gV8WhP5yUDkVrpSRWHX4xI+Uj4B56M4925Aq4kZNOn4MAFtweuM8wN0IZsiSE2MMBH7GvxelPdOBg6Eam1l1r738f5bbvUtw89MreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544840; c=relaxed/simple;
	bh=/eP7/bVQeQtpKR+nnPfVGySCd0NgwMCwgkefuS1wikI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vEIEtobLUWArgEuiHWA/ckHfiuOyujFtswtc+rJnnRuL5bjKtM3uA4Is3MDW3n/E5JAhqd1O/7ruzTbB+phNlHT6S67Dh6yIthTRhH3mrtLpQWRdo77uk8ToJzrP5hO/nwCl0XaC7SIiPdGRhrMe7HKdwIwG8qHb8xdLuTFKV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W9LFD1xBjz2CkYM;
	Fri, 28 Jun 2024 11:16:32 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BFC9C14011F;
	Fri, 28 Jun 2024 11:20:33 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 11:20:32 +0800
Message-ID: <725c5a1c-a497-f886-4786-61d1a4b550cb@huawei.com>
Date: Fri, 28 Jun 2024 11:20:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/3] arm64: entry: Convert to generic entry
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<wad@chromium.org>, <rostedt@goodmis.org>, <arnd@arndb.de>,
	<ardb@kernel.org>, <broonie@kernel.org>, <mark.rutland@arm.com>,
	<rick.p.edgecombe@intel.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240627081209.3511918-1-ruanjinjie@huawei.com>
 <20240627081209.3511918-4-ruanjinjie@huawei.com>
 <202406270958.D73912B@keescook>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <202406270958.D73912B@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/6/28 1:01, Kees Cook wrote:
> On Thu, Jun 27, 2024 at 04:12:09PM +0800, Jinjie Ruan wrote:
>> Tested ok with following test cases on Qemu cortex-a53 and HiSilicon
>> Kunpeng-920:
>>  - Run `perf top` command
>>  - Switch between different `dynamic preempt` mode
>>  - Use `pseudo nmi`
>>  - stress-ng CPU stress test.
> 
> I think two other things to test would be the MTE functionality
> (especially async mode), and kasan in general.

You are right, I'll test the MTE and kasan later, thank you!

> 
> I've really struggled to get MTE working with qemu, so likely real
> hardware would be needed for that... I'm hoping the ARM folks have
> access to something that would work well for this. :)
> 
> -Kees
> 

