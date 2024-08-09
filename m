Return-Path: <linux-kernel+bounces-280286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E28694C82B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331331F22BCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7AC2FD;
	Fri,  9 Aug 2024 01:45:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3A8F6B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723167934; cv=none; b=FVDV7xBBWdIRW1FplGOJ61nQoTOToyVQrhrwmynOrLg3eTrj9ER1I2aLTsEIY3ImpG6gbOEk/7nH75BYXASkwZtjXyGjq9nP/gV5YSWzMg2FmWkcXAK/BpuuBzjveHFtO7MwedHvsFQgRnr5C7Ilw1FIaphweD6jw3UlELiEqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723167934; c=relaxed/simple;
	bh=+kCdjF6046mnqBE/XKWCSaPMPwRXBp5mC8eOD3eJaMk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LqygFMxNYcM7EqyakGnntf4QbCzflpCGbuXv4SU9c6895dfn+iMzgyzR8aczHotY0SW4F9C2w8njxsEef2uPl2jZEtfhvi6AEfpeE/ZVnPy8iSNmzjBopy/tYQQeJd9QkJIh6BDhH58kZfAA+C//9U8e1O6o9PGdRAwhCGhOYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wg6DL19mpz1T6q8;
	Fri,  9 Aug 2024 09:45:06 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id CA315180AE5;
	Fri,  9 Aug 2024 09:45:28 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Aug 2024 09:45:27 +0800
Subject: Re: [PATCH v3] mm/memory-failure: Use raw_spinlock_t in struct
 memory_failure_cpu
To: Waiman Long <longman@redhat.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@intel.com>, Len Brown <len.brown@intel.com>, Juri Lelli
	<juri.lelli@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>
References: <20240807181130.1122660-1-longman@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <af72159b-8142-ccab-5ccb-cca3ea3cdca9@huawei.com>
Date: Fri, 9 Aug 2024 09:45:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240807181130.1122660-1-longman@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/8/8 2:11, Waiman Long wrote:
> The memory_failure_cpu structure is a per-cpu structure. Access to its
> content requires the use of get_cpu_var() to lock in the current CPU
> and disable preemption. The use of a regular spinlock_t for locking
> purpose is fine for a non-RT kernel.
> 
> Since the integration of RT spinlock support into the v5.15 kernel,
> a spinlock_t in a RT kernel becomes a sleeping lock and taking a
> sleeping lock in a preemption disabled context is illegal resulting in
> the following kind of warning.
> 
>   [12135.732244] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>   [12135.732248] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 270076, name: kworker/0:0
>   [12135.732252] preempt_count: 1, expected: 0
>   [12135.732255] RCU nest depth: 2, expected: 2
>     :
>   [12135.732420] Hardware name: Dell Inc. PowerEdge R640/0HG0J8, BIOS 2.10.2 02/24/2021
>   [12135.732423] Workqueue: kacpi_notify acpi_os_execute_deferred
>   [12135.732433] Call Trace:
>   [12135.732436]  <TASK>
>   [12135.732450]  dump_stack_lvl+0x57/0x81
>   [12135.732461]  __might_resched.cold+0xf4/0x12f
>   [12135.732479]  rt_spin_lock+0x4c/0x100
>   [12135.732491]  memory_failure_queue+0x40/0xe0
>   [12135.732503]  ghes_do_memory_failure+0x53/0x390
>   [12135.732516]  ghes_do_proc.constprop.0+0x229/0x3e0
>   [12135.732575]  ghes_proc+0xf9/0x1a0
>   [12135.732591]  ghes_notify_hed+0x6a/0x150
>   [12135.732602]  notifier_call_chain+0x43/0xb0
>   [12135.732626]  blocking_notifier_call_chain+0x43/0x60
>   [12135.732637]  acpi_ev_notify_dispatch+0x47/0x70
>   [12135.732648]  acpi_os_execute_deferred+0x13/0x20
>   [12135.732654]  process_one_work+0x41f/0x500
>   [12135.732695]  worker_thread+0x192/0x360
>   [12135.732715]  kthread+0x111/0x140
>   [12135.732733]  ret_from_fork+0x29/0x50
>   [12135.732779]  </TASK>
> 
> Fix it by using a raw_spinlock_t for locking instead.
> 
> Also move the pr_err() out of the lock critical section and after
> put_cpu_ptr() to avoid indeterminate latency and the possibility of
> sleep with this call.
> 
> Fixes: 0f383b6dc96e ("locking/spinlock: Provide RT variant")
> Signed-off-by: Waiman Long <longman@redhat.com>

LGTM. Thanks.
Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.


