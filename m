Return-Path: <linux-kernel+bounces-233478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F991B796
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AA41F21E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960B13DDC9;
	Fri, 28 Jun 2024 07:05:56 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE7125AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558355; cv=none; b=PlH6ZmapGDUABmB1Nug8jJ7IlYXcglOEdT/usKhlG0gdOWL8KUjDB1ZKLFS6aCcZ0meY9pwBMJLyEt3zOdh2WuH4AEbrnAf1SgYe4pAwRDvL8niWq6mqRo30UxDXKwUSzrN49B+1N4MqgrP8PSEBlWu7M7p3PsCqe3T4OAVUmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558355; c=relaxed/simple;
	bh=RVH5S1DL+M8mlqJgSWz+EHL/iEGiu4IiQkT0FokguwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I7+fzlHOvwGRNeK+Mlt3+eEKow04kcRUU/F01Qa0Q0RvA+IiZMF/XgZj1R7WRyojwO59EwrgWpamKdTuJzHntfKAsoidmBD97N/JxP8gX1SmliT589Z+Dipk4WhY+Bu6G4Q4SjCtqe5gnqaFHfCrDrxK4roV72q6WsfVQmlNq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W9RDd2thNzZgfq;
	Fri, 28 Jun 2024 15:01:21 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D3A8180087;
	Fri, 28 Jun 2024 15:05:48 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 15:05:46 +0800
Message-ID: <3fed5533-47e7-d927-14e6-2f42eead47d8@huawei.com>
Date: Fri, 28 Jun 2024 15:05:45 +0800
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
Content-Transfer-Encoding: 8bit
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
> 
> I've really struggled to get MTE working with qemu, so likely real
> hardware would be needed for that... I'm hoping the ARM folks have
> access to something that would work well for this. :)

Hi, Kees

I run the following testcases which are mostly in
tools/testing/selftests/arm64/mte, the results is ok as below:

1、The simple mte test case in
Documentation/arch/arm64/memory-tagging-extension.rst, it pass:

# ./mte_test
a[0] = 1 a[1] = 2
0x200ffff9dfa3000
a[0] = 3 a[1] = 2
Expecting SIGSEGV...
Segmentation fault

2、

# cd tools/testing/selftests/arm64/mte/
# ./check_prctl pass:

TAP version 13
1..5
ok 1 check_basic_read
ok 2 NONE
ok 3 SYNC
ok 4 ASYNC
ok 5 SYNC+ASYNC
# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

3、./check_tags_inclusion pass:
1..4
ok 1 Check an included tag value with sync mode
ok 2 Check different included tags value with sync mode
ok 3 Check none included tags value with sync mode
ok 4 Check all included tags value with sync mode
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

4、./check_user_mem pass:
1..64
ok 1 test type: read, MTE_SYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 0
ok 2 test type: read, MTE_SYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 16
ok 3 test type: read, MTE_SYNC_ERR, MAP_SHARED, tag len: 16, tag offset: 0
ok 4 test type: read, MTE_SYNC_ERR, MAP_SHARED, tag len: 16, tag offset: 16
ok 5 test type: read, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 0, tag offset: 0
ok 6 test type: read, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 0, tag offset: 16
ok 7 test type: read, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 16, tag offset: 0
ok 8 test type: read, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 16, tag offset: 16
ok 9 test type: read, MTE_ASYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 0
ok 10 test type: read, MTE_ASYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 16
ok 11 test type: read, MTE_ASYNC_ERR, MAP_SHARED, tag len: 16, tag offset: 0
ok 12 test type: read, MTE_ASYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 16
ok 13 test type: read, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 0, tag offset: 0
ok 14 test type: read, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 16
ok 15 test type: read, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 0
ok 16 test type: read, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 16
ok 17 test type: write, MTE_SYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 0
ok 18 test type: write, MTE_SYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 16
ok 19 test type: write, MTE_SYNC_ERR, MAP_SHARED, tag len: 16, tag offset: 0
ok 20 test type: write, MTE_SYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 16
ok 21 test type: write, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 0, tag offset: 0
ok 22 test type: write, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 16
ok 23 test type: write, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 0
ok 24 test type: write, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 16
ok 25 test type: write, MTE_ASYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 0
ok 26 test type: write, MTE_ASYNC_ERR, MAP_SHARED, tag len: 0, tag
offset: 16
ok 27 test type: write, MTE_ASYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 0
ok 28 test type: write, MTE_ASYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 16
ok 29 test type: write, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 0
ok 30 test type: write, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 16
ok 31 test type: write, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 0
ok 32 test type: write, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 16
ok 33 test type: readv, MTE_SYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 0
ok 34 test type: readv, MTE_SYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 16
ok 35 test type: readv, MTE_SYNC_ERR, MAP_SHARED, tag len: 16, tag offset: 0
ok 36 test type: readv, MTE_SYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 16
ok 37 test type: readv, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 0, tag offset: 0
ok 38 test type: readv, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 16
ok 39 test type: readv, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 0
ok 40 test type: readv, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 16
ok 41 test type: readv, MTE_ASYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 0
ok 42 test type: readv, MTE_ASYNC_ERR, MAP_SHARED, tag len: 0, tag
offset: 16
ok 43 test type: readv, MTE_ASYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 0
ok 44 test type: readv, MTE_ASYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 16
ok 45 test type: readv, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 0
ok 46 test type: readv, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 16
ok 47 test type: readv, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 0
ok 48 test type: readv, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 16
ok 49 test type: writev, MTE_SYNC_ERR, MAP_SHARED, tag len: 0, tag offset: 0
ok 50 test type: writev, MTE_SYNC_ERR, MAP_SHARED, tag len: 0, tag
offset: 16
ok 51 test type: writev, MTE_SYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 0
ok 52 test type: writev, MTE_SYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 16
ok 53 test type: writev, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 0
ok 54 test type: writev, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 16
ok 55 test type: writev, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 0
ok 56 test type: writev, MTE_SYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 16
ok 57 test type: writev, MTE_ASYNC_ERR, MAP_SHARED, tag len: 0, tag
offset: 0
ok 58 test type: writev, MTE_ASYNC_ERR, MAP_SHARED, tag len: 0, tag
offset: 16
ok 59 test type: writev, MTE_ASYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 0
ok 60 test type: writev, MTE_ASYNC_ERR, MAP_SHARED, tag len: 16, tag
offset: 16
ok 61 test type: writev, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 0
ok 62 test type: writev, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 0, tag
offset: 16
ok 63 test type: writev, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 0
ok 64 test type: writev, MTE_ASYNC_ERR, MAP_PRIVATE, tag len: 16, tag
offset: 16
# Totals: pass:64 fail:0 xfail:0 xpass:0 skip:0 error:0

5、./check_mmap_options pass
1..22
ok 1 Check anonymous memory with private mapping, sync error mode, mmap
memory and tag check off
ok 2 Check file memory with private mapping, sync error mode,
mmap/mprotect memory and tag check off
ok 3 Check anonymous memory with private mapping, no error mode, mmap
memory and tag check off
ok 4 Check file memory with private mapping, no error mode,
mmap/mprotect memory and tag check off
ok 5 Check anonymous memory with private mapping, sync error mode, mmap
memory and tag check on
ok 6 Check anonymous memory with private mapping, sync error mode,
mmap/mprotect memory and tag check on
ok 7 Check anonymous memory with shared mapping, sync error mode, mmap
memory and tag check on
ok 8 Check anonymous memory with shared mapping, sync error mode,
mmap/mprotect memory and tag check on
ok 9 Check anonymous memory with private mapping, async error mode, mmap
memory and tag check on
ok 10 Check anonymous memory with private mapping, async error mode,
mmap/mprotect memory and tag check on
ok 11 Check anonymous memory with shared mapping, async error mode, mmap
memory and tag check on
ok 12 Check anonymous memory with shared mapping, async error mode,
mmap/mprotect memory and tag check on
ok 13 Check file memory with private mapping, sync error mode, mmap
memory and tag check on
ok 14 Check file memory with private mapping, sync error mode,
mmap/mprotect memory and tag check on
ok 15 Check file memory with shared mapping, sync error mode, mmap
memory and tag check on
ok 16 Check file memory with shared mapping, sync error mode,
mmap/mprotect memory and tag check on
ok 17 Check file memory with private mapping, async error mode, mmap
memory and tag check on
ok 18 Check file memory with private mapping, async error mode,
mmap/mprotect memory and tag check on
ok 19 Check file memory with shared mapping, async error mode, mmap
memory and tag check on
ok 20 Check file memory with shared mapping, async error mode,
mmap/mprotect memory and tag check on
ok 21 Check clear PROT_MTE flags with private mapping, sync error mode
and mmap memory
ok 22 Check clear PROT_MTE flags with private mapping and sync error
mode and mmap/mprotect memory
# Totals: pass:22 fail:0 xfail:0 xpass:0 skip:0 error:0

6、./check_ksm_options pass
1..4
ok 1 Check KSM mte page merge for private mapping, sync mode and mmap memory
ok 2 Check KSM mte page merge for private mapping, async mode and mmap
memory
ok 3 Check KSM mte page merge for shared mapping, sync mode and mmap memory
ok 4 Check KSM mte page merge for shared mapping, async mode and mmap memory
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

7、./check_gcr_el1_cswitch pass
1..1
ok 1 Verify that GCR_EL1 is set correctly on context switch
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

8、# ./check_buffer_fill pass
1..20
ok 1 Check buffer correctness by byte with sync err mode and mmap memory
ok 2 Check buffer correctness by byte with async err mode and mmap memory
ok 3 Check buffer correctness by byte with sync err mode and
mmap/mprotect memory
ok 4 Check buffer correctness by byte with async err mode and
mmap/mprotect memory
ok 5 Check buffer write underflow by byte with sync mode and mmap memory
ok 6 Check buffer write underflow by byte with async mode and mmap memory
ok 7 Check buffer write underflow by byte with tag check fault ignore
and mmap memory
ok 8 Check buffer write underflow by byte with sync mode and mmap memory
ok 9 Check buffer write underflow by byte with async mode and mmap memory
ok 10 Check buffer write underflow by byte with tag check fault ignore
and mmap memory
ok 11 Check buffer write overflow by byte with sync mode and mmap memory
ok 12 Check buffer write overflow by byte with async mode and mmap memory
ok 13 Check buffer write overflow by byte with tag fault ignore mode and
mmap memory
ok 14 Check buffer write correctness by block with sync mode and mmap memory
ok 15 Check buffer write correctness by block with async mode and mmap
memory
ok 16 Check buffer write correctness by block with tag fault ignore and
mmap memory
ok 17 Check initial tags with private mapping, sync error mode and mmap
memory
ok 18 Check initial tags with private mapping, sync error mode and
mmap/mprotect memory
ok 19 Check initial tags with shared mapping, sync error mode and mmap
memory
ok 20 Check initial tags with shared mapping, sync error mode and
mmap/mprotect memory
# Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0

9、 ./check_child_memory pass
1..12
ok 1 Check child anonymous memory with private mapping, precise mode and
mmap memory
ok 2 Check child anonymous memory with shared mapping, precise mode and
mmap memory
ok 3 Check child anonymous memory with private mapping, imprecise mode
and mmap memory
ok 4 Check child anonymous memory with shared mapping, imprecise mode
and mmap memory
ok 5 Check child anonymous memory with private mapping, precise mode and
mmap/mprotect memory
ok 6 Check child anonymous memory with shared mapping, precise mode and
mmap/mprotect memory
ok 7 Check child file memory with private mapping, precise mode and mmap
memory
ok 8 Check child file memory with shared mapping, precise mode and mmap
memory
ok 9 Check child file memory with private mapping, imprecise mode and
mmap memory
ok 10 Check child file memory with shared mapping, imprecise mode and
mmap memory
ok 11 Check child file memory with private mapping, precise mode and
mmap/mprotect memory
ok 12 Check child file memory with shared mapping, precise mode and
mmap/mprotect memory
# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

> 
> -Kees
> 

