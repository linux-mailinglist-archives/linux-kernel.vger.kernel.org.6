Return-Path: <linux-kernel+bounces-278440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DFB94B048
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B731C20A00
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E71420B8;
	Wed,  7 Aug 2024 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fK8c/s9X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011A140360
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057653; cv=none; b=Klco3tTvvkuBNWa1zaqIymXrat5lHwwzeD7Bm/1MrFvPIn4Nzk4IASDE2VII80VLZPfTzICMV3yfHKlDiuhXqlCD3ydBZJQ/Wypn8Q9yMGU8R1kNTHxbuiH/QEjxmnnkcwaHEQP6gCYOc+Fj24m5gN3Mgn8hlLjf84DVtFTt3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057653; c=relaxed/simple;
	bh=tvVf19CtVLGwBRLRVv62HE31mIxLHdXK0sX7eA0KFpY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fXVY/FhDFZE2zzB8r28lY5UdMRKYe071ErT8JfLLw3kT8VNqUg7PK4bo8YS+KnO1WqVA5JDnz/6sxPwZ4HFbd5uVgA4ltRdKyGTjWrjO3In2slu8pRI4W4veLCqGO3whZvTxuMTsaqbkMEJ/Twww0h3B/HZWbAWgNGvvIAU+GR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fK8c/s9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1077C32781;
	Wed,  7 Aug 2024 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723057652;
	bh=tvVf19CtVLGwBRLRVv62HE31mIxLHdXK0sX7eA0KFpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fK8c/s9X2gdeRQyA5ELPK7cbZ58isltdPyXPNl/NMQ5kfdvtQf7sajQOrp4tp85Lk
	 637vfeofAiWus31+ft0/UwQxtPEIO/SzfOZJh9l3qxEudvCOu8Ee4LBg6NV+tKO126
	 INQ6eJKyjAOd3UYg4gDqNeTEnGita4XQ42ZvzR1g=
Date: Wed, 7 Aug 2024 12:07:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov
 <andreyknvl@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/stackdepot: Double DEPOT_POOLS_CAP if KASAN is
 enabled
Message-Id: <20240807120731.f0405f893dfc333ae475cc85@linux-foundation.org>
In-Reply-To: <20240807165228.1116831-1-longman@redhat.com>
References: <20240807165228.1116831-1-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 12:52:28 -0400 Waiman Long <longman@redhat.com> wrote:

> When a wide variety of workloads are run on a debug kernel with KASAN
> enabled, the following warning may sometimes be printed.
> 
>  [ 6818.650674] Stack depot reached limit capacity
>  [ 6818.650730] WARNING: CPU: 1 PID: 272741 at lib/stackdepot.c:252 depot_alloc_stack+0x39e/0x3d0
>    :
>  [ 6818.650907] Call Trace:
>  [ 6818.650909]  [<00047dd453d84b92>] depot_alloc_stack+0x3a2/0x3d0
>  [ 6818.650916]  [<00047dd453d85254>] stack_depot_save_flags+0x4f4/0x5c0
>  [ 6818.650920]  [<00047dd4535872c6>] kasan_save_stack+0x56/0x70
>  [ 6818.650924]  [<00047dd453587328>] kasan_save_track+0x28/0x40
>  [ 6818.650927]  [<00047dd45358a27a>] kasan_save_free_info+0x4a/0x70
>  [ 6818.650930]  [<00047dd45358766a>] __kasan_slab_free+0x12a/0x1d0
>  [ 6818.650933]  [<00047dd45350deb4>] kmem_cache_free+0x1b4/0x580
>  [ 6818.650938]  [<00047dd452c520da>] __put_task_struct+0x24a/0x320
>  [ 6818.650945]  [<00047dd452c6aee4>] delayed_put_task_struct+0x294/0x350
>  [ 6818.650949]  [<00047dd452e9066a>] rcu_do_batch+0x6ea/0x2090
>  [ 6818.650953]  [<00047dd452ea60f4>] rcu_core+0x474/0xa90
>  [ 6818.650956]  [<00047dd452c780c0>] handle_softirqs+0x3c0/0xf90
>  [ 6818.650960]  [<00047dd452c76fbe>] __irq_exit_rcu+0x35e/0x460
>  [ 6818.650963]  [<00047dd452c79992>] irq_exit_rcu+0x22/0xb0
>  [ 6818.650966]  [<00047dd454bd8128>] do_ext_irq+0xd8/0x120
>  [ 6818.650972]  [<00047dd454c0ddd0>] ext_int_handler+0xb8/0xe8
>  [ 6818.650979]  [<00047dd453589cf6>] kasan_check_range+0x236/0x2f0
>  [ 6818.650982]  [<00047dd453378cf0>] filemap_get_pages+0x190/0xaa0
>  [ 6818.650986]  [<00047dd453379940>] filemap_read+0x340/0xa70
>  [ 6818.650989]  [<00047dd3d325d226>] xfs_file_buffered_read+0x2c6/0x400 [xfs]
>  [ 6818.651431]  [<00047dd3d325dfe2>] xfs_file_read_iter+0x2c2/0x550 [xfs]
>  [ 6818.651663]  [<00047dd45364710c>] vfs_read+0x64c/0x8c0
>  [ 6818.651669]  [<00047dd453648ed8>] ksys_read+0x118/0x200
>  [ 6818.651672]  [<00047dd452b6cf5a>] do_syscall+0x27a/0x380
>  [ 6818.651676]  [<00047dd454bd7e74>] __do_syscall+0xf4/0x1a0
>  [ 6818.651680]  [<00047dd454c0db58>] system_call+0x70/0x98
> 
> As KASAN is a big user of stackdepot, the current DEPOT_POOLS_CAP of
> 8192 may not be enough. Double DEPOT_POOLS_CAP if KASAN is enabled to
> avoid hitting this problem.
> 
> Also use the MIN() macro for defining DEPOT_MAX_POOLS to clarify the
> intention.

We don't want earlier kernels doing this so I think

Fixes: 02754e0a484a ("lib/stackdepot.c: bump stackdepot capacity from 16MB to 128MB")
Cc: stable

Interestingly, 02754e0a484a bumped this from 1024 to 8192.

02754e0a484a may be wrong - perhaps the interaction with KASAN didn't
ewxist at that time.  Please take a look?


