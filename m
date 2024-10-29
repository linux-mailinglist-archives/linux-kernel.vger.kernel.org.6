Return-Path: <linux-kernel+bounces-387673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489B9B546C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95735B219D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F8C207A2C;
	Tue, 29 Oct 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T4So5nMX"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD81192B63
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234828; cv=none; b=dFVP5C4U/+Jh/TfMGOltAk1JF06QDkCHl1QNQ3Rou4JWoHHDlhVgkXbqStI8lEpkw4Nx85AV1hRpgg5qu3J/bn71GcrTw3OnEfOKehiQ/QDr+PkDcSPz2F1ztVpWdhk5o5RF2dzQXWiihzRGqL+RaLI/A2sK6eq1+GkImI8JqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234828; c=relaxed/simple;
	bh=HIZKISJgrxkG2N88EO5pSJ+y2bVsJ22O5oKaSEAvL30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TesMxY95NpEyiB+fgIjovgDdSMAOZv/n0sIsMYzyUp6nO1AaRoV4dpGZdGhRkv4DLbc2MibSZzKOHa6YWfVzNq8gZankNOO4S31JDnmkRpjlwfEiGFlDB4Bbe8Z1l6h3B+MrxFfX+HBzL5UIR2EeGZ3Znpe7Gy31dBe/JqZuOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T4So5nMX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Oct 2024 20:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730234823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/2LPEt/GHvSW+prhbuDKrfCdaeE2xMrTD+7LuJoga4=;
	b=T4So5nMXk0y/J5dityKbFBMsLaxhJL2jPe1YQ97P16JSrC6sNevgm2glXkZDER2qZJEnY5
	bUMEeBD9Iqxxf11ZN2Zb74u1FLHz5zwz7nEkcMaDO29V9wRXIKzpYo8Mjzu4fOsnk7N5Yp
	P/UTN/Hk8jy9XuM92vL0MDqBPZwH1lk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Luca Boccassi <bluca@debian.org>,
	kvm@vger.kernel.org, cgroups@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: cgroup2 freezer and kvm_vm_worker_thread()
Message-ID: <ZyFJwtPzmKsx5EdI@google.com>
References: <ZyAnSAw34jwWicJl@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyAnSAw34jwWicJl@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 28, 2024 at 02:07:36PM -1000, Tejun Heo wrote:
11;rgb:fcc2/f732/e5d0> Hello,
> 
> Luca is reporting that cgroups which have kvm instances inside never
> complete freezing. This can be trivially reproduced:
> 
>   root@test ~# mkdir /sys/fs/cgroup/test
>   root@test ~# echo $fish_pid > /sys/fs/cgroup/test/cgroup.procs
>   root@test ~# qemu-system-x86_64 --nographic -enable-kvm
> 
> and in another terminal:
> 
>   root@test ~# echo 1 > /sys/fs/cgroup/test/cgroup.freeze
>   root@test ~# cat /sys/fs/cgroup/test/cgroup.events
>   populated 1
>   frozen 0
>   root@test ~# for i in (cat /sys/fs/cgroup/test/cgroup.threads); echo $i; cat /proc/$i/stack; end 
>   2070
>   [<0>] do_freezer_trap+0x42/0x70
>   [<0>] get_signal+0x4da/0x870
>   [<0>] arch_do_signal_or_restart+0x1a/0x1c0
>   [<0>] syscall_exit_to_user_mode+0x73/0x120
>   [<0>] do_syscall_64+0x87/0x140
>   [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   2159
>   [<0>] do_freezer_trap+0x42/0x70
>   [<0>] get_signal+0x4da/0x870
>   [<0>] arch_do_signal_or_restart+0x1a/0x1c0
>   [<0>] syscall_exit_to_user_mode+0x73/0x120
>   [<0>] do_syscall_64+0x87/0x140
>   [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   2160
>   [<0>] do_freezer_trap+0x42/0x70
>   [<0>] get_signal+0x4da/0x870
>   [<0>] arch_do_signal_or_restart+0x1a/0x1c0
>   [<0>] syscall_exit_to_user_mode+0x73/0x120
>   [<0>] do_syscall_64+0x87/0x140
>   [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   2161
>   [<0>] kvm_nx_huge_page_recovery_worker+0xea/0x680
>   [<0>] kvm_vm_worker_thread+0x8f/0x2b0
>   [<0>] kthread+0xe8/0x110
>   [<0>] ret_from_fork+0x33/0x40
>   [<0>] ret_from_fork_asm+0x1a/0x30
>   2164
>   [<0>] do_freezer_trap+0x42/0x70
>   [<0>] get_signal+0x4da/0x870
>   [<0>] arch_do_signal_or_restart+0x1a/0x1c0
>   [<0>] syscall_exit_to_user_mode+0x73/0x120
>   [<0>] do_syscall_64+0x87/0x140
>   [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The cgroup freezing happens in the signal delivery path but
> kvm_vm_worker_thread() thread never call into the signal delivery path while
> joining non-root cgroups, so they never get frozen. Because the cgroup
> freezer determines whether a given cgroup is frozen by comparing the number
> of frozen threads to the total number of threads in the cgroup, the cgroup
> never becomes frozen and users waiting for the state transition may hang
> indefinitely.
> 
> There are two paths that we can take:
> 
> 1. Make kvm_vm_worker_thread() call into signal delivery path.
>    io_wq_worker() is in a similar boat and handles signal delivery and can
>    be frozen and trapped like regular threads.
> 
> 2. Keep the count of threads which can't be frozen per cgroup so that cgroup
>    freezer can ignore these threads.
> 
> #1 is better in that the cgroup will actually be frozen when reported
> frozen. However, the rather ambiguous criterion we've been using for cgroup
> freezer is whether the cgroup can be safely snapshotted whil frozen and as
> long as the workers not being frozen doesn't break that, we can go for #2
> too.
> 
> What do you guys think?

The general assumption (which is broken here) is that kernel threads are
belonging to the root cgroup, but also they are not safe to freeze, so we're
fine unless a user moves them to another cgroup, which is generally not a good
idea for many reasons.

However in this case we have a kthread which we want to freeze and which belongs
to a non-root cgroup, so I think the option #1 is preferable. Option #2 brings
a notion of special non-freezable threads into a user facing API. Idk if we
really need this, so I'd avoid this.

Thanks!

