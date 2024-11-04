Return-Path: <linux-kernel+bounces-394175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379F9BAB7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D649281AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79FC18D63C;
	Mon,  4 Nov 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5pFk2hl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2E18787E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691047; cv=none; b=Uu3YkvCh91VvaF3ebDe1ixGWcNcOeGPwT87ML+NYrbE4CRmHZ9UNqjGvRyR5ea65p6eM87iRAijJj6gS+oWUFArk1er69xmm5n+iJF5X6vPky/7Oz/uJjXo9JPs58WTMJBWLXCTY/Hwsve1nLaFEvd8ZYHXgBRzpMAExxmV8bBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691047; c=relaxed/simple;
	bh=jIv4JxjklgBD9dTti9ihuX03zJArfivWHEKdJfA20h0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g+H+HWUj9vsLWM1tXF+/sUAZv+EOxOOeLpssr/lnxRPyHhDwKs5CZbgSc5Hve4LHdWNKPbTRwQOmifQoao1aJJ6fBW/UeWx8G1mub9A9ZjTkQl8mAj57j+ZNHF1kyANTl5Sr+gbVUZNRS4F9pduDSEfw0l7+HJi6iCj5YlALXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5pFk2hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABFFC4CED0;
	Mon,  4 Nov 2024 03:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730691046;
	bh=jIv4JxjklgBD9dTti9ihuX03zJArfivWHEKdJfA20h0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=H5pFk2hlwvQemuYVuUB80BxyYMIVaULXzeexi2mNHn7k7qYPoiJWDDqAlnqHNlXRO
	 I8TfH6p0mhDfLGTVSxlBNI4zaYs+r/ZW39YSS+fa0Iz/Xc74gpBHusAvL7Ro0vaS4b
	 iAmawUPoesQsATmm6kCO5PY42VVgNvQcd4q8MAyybgHDFrxbFKg+4NIQixL+D1lYkq
	 DBfbxBKmB2TDCDrWNghKT18XMNHEAWy18LOJpjnICqIBueec8HjmGwRP822vw5onJQ
	 b7N94Gm9smDRXYzMHqsS9fn7OsUyYeArsluWeg/v4l7rFqwZpi7SbhNQK1s/KrHSuc
	 MbWo1sRJwhd6g==
Message-ID: <81a55b36-0a69-42d6-b82a-94499c37a4fd@kernel.org>
Date: Mon, 4 Nov 2024 11:30:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 lonuxli.64@gmail.com
Subject: Re: [PATCH v2] f2fs: fix race in concurrent f2fs_stop_gc_thread
To: Long Li <leo.lilong@huawei.com>, jaegeuk@kernel.org
References: <20241104020542.2603607-1-leo.lilong@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241104020542.2603607-1-leo.lilong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/4 10:05, Long Li wrote:
> In my test case, concurrent calls to f2fs shutdown report the following
> stack trace:
> 
>   Oops: general protection fault, probably for non-canonical address 0xc6cfff63bb5513fc: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 UID: 0 PID: 678 Comm: f2fs_rep_shutdo Not tainted 6.12.0-rc5-next-20241029-g6fb2fa9805c5-dirty #85
>   Call Trace:
>    <TASK>
>    ? show_regs+0x8b/0xa0
>    ? __die_body+0x26/0xa0
>    ? die_addr+0x54/0x90
>    ? exc_general_protection+0x24b/0x5c0
>    ? asm_exc_general_protection+0x26/0x30
>    ? kthread_stop+0x46/0x390
>    f2fs_stop_gc_thread+0x6c/0x110
>    f2fs_do_shutdown+0x309/0x3a0
>    f2fs_ioc_shutdown+0x150/0x1c0
>    __f2fs_ioctl+0xffd/0x2ac0
>    f2fs_ioctl+0x76/0xe0
>    vfs_ioctl+0x23/0x60
>    __x64_sys_ioctl+0xce/0xf0
>    x64_sys_call+0x2b1b/0x4540
>    do_syscall_64+0xa7/0x240
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The root cause is a race condition in f2fs_stop_gc_thread() called from
> different f2fs shutdown paths:
> 
>    [CPU0]                       [CPU1]
>    ----------------------       -----------------------
>    f2fs_stop_gc_thread          f2fs_stop_gc_thread
>                                   gc_th = sbi->gc_thread
>      gc_th = sbi->gc_thread
>      kfree(gc_th)
>      sbi->gc_thread = NULL
>                                   < gc_th != NULL >
>                                   kthread_stop(gc_th->f2fs_gc_task) //UAF
> 
> The commit c7f114d864ac ("f2fs: fix to avoid use-after-free in
> f2fs_stop_gc_thread()") attempted to fix this issue by using a read
> semaphore to prevent races between shutdown and remount threads, but
> it fails to prevent all race conditions.
> 
> Fix it by converting to write lock of s_umount in f2fs_do_shutdown().
> 
> Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
> Signed-off-by: Long Li <leo.lilong@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

