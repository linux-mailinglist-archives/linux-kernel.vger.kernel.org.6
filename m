Return-Path: <linux-kernel+bounces-265776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057FE93F5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC381283478
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5F14E2E2;
	Mon, 29 Jul 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2MD6yGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD00148848;
	Mon, 29 Jul 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257201; cv=none; b=AhI7MzxFMGrpoGK+NOr3By8a3B7eUMrm4ucGt8Et3YiVzqVPYCqNuWvxbXvmRJoNI/j4TsJsZ9SiGU6+yyXg2+0vAU04vWZLMDPBTyMFRDWrb7CKomW+fLXrXHwAty8M631h5Q0Cw/DziafbnGY7DpL1y0orEjo0hC0BJKPZOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257201; c=relaxed/simple;
	bh=6kuIL0AeDzmBuC5cBa38lI0juIYq77BoPdCcXKxB0Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru1Z21UA/NCaHZOVI1lqFzwJtZ8iY40BcsFGjsoXF32lpTnq4Mk4YRC4vVsfOuRdOMzY2nD2ixHrQTmBZ2lPV5fklkgYQpn78CXId0uHdsAb6bUAJD86Ieb43aAAjQkfD9XtmnRBs91bP57Ufnx12wrlRpCBmv3O+daEBs4x+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2MD6yGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FD4C32786;
	Mon, 29 Jul 2024 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722257201;
	bh=6kuIL0AeDzmBuC5cBa38lI0juIYq77BoPdCcXKxB0Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2MD6yGoN6iYlqejpeL0zt2VeBiCbeGlIX5v3SvNGr59l/BdPYJU8+pYh4UwSpLRg
	 f2L+l+3mkY4vyjopBWDdYvEjP9wrsbUTgAt9bcit4XfUbAB71fcaNL5tewNBRJ/DVU
	 Wco++7Fliqz1Vn7V2rCWEuGaESPT0wfZWmJneAiIDWpo89LQYwVHcVA7MJugA4g31S
	 cTrRRapug8rkcz0QJCnn11wqP4hbomWiM2FP/3olg+JelviBAneO8bmBa0CxW67WRp
	 Fu58v9j8FSG7geQTXMUh1CNNmAwdG/+X/znQpc7BYIGdbhqtByZxjcSOch38YQCTeB
	 ZC3z7uD70nkDA==
Date: Mon, 29 Jul 2024 13:46:37 +0100
From: Filipe Manana <fdmanana@kernel.org>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-26905: btrfs: fix data races when accessing the
 reserved amount of block reserves
Message-ID: <ZqePLSiplMVebl39@debian0.Home>
References: <2024041746-CVE-2024-26905-69f0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041746-CVE-2024-26905-69f0@gregkh>

On Wed, Apr 17, 2024 at 12:29:20PM +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> btrfs: fix data races when accessing the reserved amount of block reserves
> 

Greg, can you clarify why is this being classified as a CVE?

This is another similar instance of what I reported here:

https://lore.kernel.org/lkml/Zkt48ug3KKOTQk42@debian0.Home/

It's a fix to silence KCSAN about a harmless race.
I see no way a malicious user could use this to do anything harmful.
It doesn't have functional issues either.

Thanks.

> At space_info.c we have several places where we access the ->reserved
> field of a block reserve without taking the block reserve's spinlock
> first, which makes KCSAN warn about a data race since that field is
> always updated while holding the spinlock.
> 
> The reports from KCSAN are like the following:
> 
>   [117.193526] BUG: KCSAN: data-race in btrfs_block_rsv_release [btrfs] / need_preemptive_reclaim [btrfs]
> 
>   [117.195148] read to 0x000000017f587190 of 8 bytes by task 6303 on cpu 3:
>   [117.195172]  need_preemptive_reclaim+0x222/0x2f0 [btrfs]
>   [117.195992]  __reserve_bytes+0xbb0/0xdc8 [btrfs]
>   [117.196807]  btrfs_reserve_metadata_bytes+0x4c/0x120 [btrfs]
>   [117.197620]  btrfs_block_rsv_add+0x78/0xa8 [btrfs]
>   [117.198434]  btrfs_delayed_update_inode+0x154/0x368 [btrfs]
>   [117.199300]  btrfs_update_inode+0x108/0x1c8 [btrfs]
>   [117.200122]  btrfs_dirty_inode+0xb4/0x140 [btrfs]
>   [117.200937]  btrfs_update_time+0x8c/0xb0 [btrfs]
>   [117.201754]  touch_atime+0x16c/0x1e0
>   [117.201789]  filemap_read+0x674/0x728
>   [117.201823]  btrfs_file_read_iter+0xf8/0x410 [btrfs]
>   [117.202653]  vfs_read+0x2b6/0x498
>   [117.203454]  ksys_read+0xa2/0x150
>   [117.203473]  __s390x_sys_read+0x68/0x88
>   [117.203495]  do_syscall+0x1c6/0x210
>   [117.203517]  __do_syscall+0xc8/0xf0
>   [117.203539]  system_call+0x70/0x98
> 
>   [117.203579] write to 0x000000017f587190 of 8 bytes by task 11 on cpu 0:
>   [117.203604]  btrfs_block_rsv_release+0x2e8/0x578 [btrfs]
>   [117.204432]  btrfs_delayed_inode_release_metadata+0x7c/0x1d0 [btrfs]
>   [117.205259]  __btrfs_update_delayed_inode+0x37c/0x5e0 [btrfs]
>   [117.206093]  btrfs_async_run_delayed_root+0x356/0x498 [btrfs]
>   [117.206917]  btrfs_work_helper+0x160/0x7a0 [btrfs]
>   [117.207738]  process_one_work+0x3b6/0x838
>   [117.207768]  worker_thread+0x75e/0xb10
>   [117.207797]  kthread+0x21a/0x230
>   [117.207830]  __ret_from_fork+0x6c/0xb8
>   [117.207861]  ret_from_fork+0xa/0x30
> 
> So add a helper to get the reserved amount of a block reserve while
> holding the lock. The value may be not be up to date anymore when used by
> need_preemptive_reclaim() and btrfs_preempt_reclaim_metadata_space(), but
> that's ok since the worst it can do is cause more reclaim work do be done
> sooner rather than later. Reading the field while holding the lock instead
> of using the data_race() annotation is used in order to prevent load
> tearing.
> 
> The Linux kernel CVE team has assigned CVE-2024-26905 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 6.1.83 with commit 995e91c9556c
> 	Fixed in 6.6.23 with commit 82220b1835ba
> 	Fixed in 6.7.11 with commit c44542093525
> 	Fixed in 6.8 with commit e06cc89475ed
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-26905
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	fs/btrfs/block-rsv.h
> 	fs/btrfs/space-info.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/995e91c9556c8fc6028b474145a36e947d1eb6b6
> 	https://git.kernel.org/stable/c/82220b1835baaebf4ae2e490f56353a341a09bd2
> 	https://git.kernel.org/stable/c/c44542093525699a30c307dae1ea5a1b03b3302f
> 	https://git.kernel.org/stable/c/e06cc89475eddc1f3a7a4d471524256152c68166

