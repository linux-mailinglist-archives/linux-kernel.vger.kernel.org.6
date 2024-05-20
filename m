Return-Path: <linux-kernel+bounces-183963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82488CA0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A661C2103F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9C137929;
	Mon, 20 May 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHBmFr/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74420EB;
	Mon, 20 May 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222198; cv=none; b=cGDiKdvu5frEjOjDfG+Zqc6FwglXS4Q0JhsNIgGHpypntOvOxIS/3+YXhxZm+HSncYO4dBvLIV33V0CMOkVlqWXhSe1KOT+3zeJxEIQLRbRlfOeJDPmd/x0Uqtu3GaaQkB29EG6BCgH2LT8rv36ciTXRsPE2HMlXtwvBpuD2+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222198; c=relaxed/simple;
	bh=6dHx4umvxa1ctj0jF5ZevsPoIkxPhkhSXCfqfYnVDV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJkr4eu2SLSC8jeRrOCctK9zpGkwbu7/RL06GyeFGty6bd0JVZKlTvKwD9A3fpyypZQzuZrhY+JGuqRlU0mDX4SwnRZw+Gi/4K9SGpa6DlmP7wnZuvGEsPYzDegDm5xXsFDzznNe5m1XkHGgWTFMw+paZWyQE979/M4x2Ionjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHBmFr/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1776C2BD10;
	Mon, 20 May 2024 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716222198;
	bh=6dHx4umvxa1ctj0jF5ZevsPoIkxPhkhSXCfqfYnVDV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHBmFr/9g8bHAE5luH9TrL76uGgHUparucsJYOnFIvQNjdqPpborLVihddYhfysT7
	 Pwa6xwusXxIE/CE/kKEsE+3kB5quBJo28KPRCMNtHdz5f/PLOr+oPV8WECUiuL3Hl+
	 wlj/FWXazBNyzhSZqmr2OeBK0ykUV9uYYJ9p77xRiG35+r7Vuu+ovCGZY5pRvF0yl5
	 zeOZAmEIVHg1+XC2s4py6bKgZRh7APZV5FYdxsFc6Z/Vxuifed6qd2yXotpkBaCkkj
	 dN7eC/X3EgapSDlfpleu7Zff2ek0YSAjkoVlAMq3egMbWWYEX0aHxN18Q0smB0Bni0
	 uV3jhmCXbhW0A==
Date: Mon, 20 May 2024 17:23:14 +0100
From: Filipe Manana <fdmanana@kernel.org>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-26904: btrfs: fix data race at btrfs_use_block_rsv()
 when accessing block reserve
Message-ID: <Zkt48ug3KKOTQk42@debian0.Home>
References: <2024041746-CVE-2024-26904-e3a8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041746-CVE-2024-26904-e3a8@gregkh>

On Wed, Apr 17, 2024 at 12:29:19PM +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve

May I ask why is this classified a CVE?

How can a malicious user exploit this to do something harmful?

The race was solved to silence KCSAN warnings, as from time to time we have
someone reporting it, but other than that, it should be harmless.

Thanks.

> 
> At btrfs_use_block_rsv() we read the size of a block reserve without
> locking its spinlock, which makes KCSAN complain because the size of a
> block reserve is always updated while holding its spinlock. The report
> from KCSAN is the following:
> 
>   [653.313148] BUG: KCSAN: data-race in btrfs_update_delayed_refs_rsv [btrfs] / btrfs_use_block_rsv [btrfs]
> 
>   [653.314755] read to 0x000000017f5871b8 of 8 bytes by task 7519 on cpu 0:
>   [653.314779]  btrfs_use_block_rsv+0xe4/0x2f8 [btrfs]
>   [653.315606]  btrfs_alloc_tree_block+0xdc/0x998 [btrfs]
>   [653.316421]  btrfs_force_cow_block+0x220/0xe38 [btrfs]
>   [653.317242]  btrfs_cow_block+0x1ac/0x568 [btrfs]
>   [653.318060]  btrfs_search_slot+0xda2/0x19b8 [btrfs]
>   [653.318879]  btrfs_del_csums+0x1dc/0x798 [btrfs]
>   [653.319702]  __btrfs_free_extent.isra.0+0xc24/0x2028 [btrfs]
>   [653.320538]  __btrfs_run_delayed_refs+0xd3c/0x2390 [btrfs]
>   [653.321340]  btrfs_run_delayed_refs+0xae/0x290 [btrfs]
>   [653.322140]  flush_space+0x5e4/0x718 [btrfs]
>   [653.322958]  btrfs_preempt_reclaim_metadata_space+0x102/0x2f8 [btrfs]
>   [653.323781]  process_one_work+0x3b6/0x838
>   [653.323800]  worker_thread+0x75e/0xb10
>   [653.323817]  kthread+0x21a/0x230
>   [653.323836]  __ret_from_fork+0x6c/0xb8
>   [653.323855]  ret_from_fork+0xa/0x30
> 
>   [653.323887] write to 0x000000017f5871b8 of 8 bytes by task 576 on cpu 3:
>   [653.323906]  btrfs_update_delayed_refs_rsv+0x1a4/0x250 [btrfs]
>   [653.324699]  btrfs_add_delayed_data_ref+0x468/0x6d8 [btrfs]
>   [653.325494]  btrfs_free_extent+0x76/0x120 [btrfs]
>   [653.326280]  __btrfs_mod_ref+0x6a8/0x6b8 [btrfs]
>   [653.327064]  btrfs_dec_ref+0x50/0x70 [btrfs]
>   [653.327849]  walk_up_proc+0x236/0xa50 [btrfs]
>   [653.328633]  walk_up_tree+0x21c/0x448 [btrfs]
>   [653.329418]  btrfs_drop_snapshot+0x802/0x1328 [btrfs]
>   [653.330205]  btrfs_clean_one_deleted_snapshot+0x184/0x238 [btrfs]
>   [653.330995]  cleaner_kthread+0x2b0/0x2f0 [btrfs]
>   [653.331781]  kthread+0x21a/0x230
>   [653.331800]  __ret_from_fork+0x6c/0xb8
>   [653.331818]  ret_from_fork+0xa/0x30
> 
> So add a helper to get the size of a block reserve while holding the lock.
> Reading the field while holding the lock instead of using the data_race()
> annotation is used in order to prevent load tearing.
> 
> The Linux kernel CVE team has assigned CVE-2024-26904 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 5.4.273 with commit 2daa2a8e895e
> 	Fixed in 6.1.83 with commit ab1be3f1aa77
> 	Fixed in 6.6.23 with commit f6d4d29a1265
> 	Fixed in 6.7.11 with commit 7e9422d35d57
> 	Fixed in 6.8 with commit c7bb26b847e5
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-26904
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	fs/btrfs/block-rsv.c
> 	fs/btrfs/block-rsv.h
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
> 	https://git.kernel.org/stable/c/2daa2a8e895e6dc2395f8628c011bcf1e019040d
> 	https://git.kernel.org/stable/c/ab1be3f1aa7799f99155488c28eacaef65eb68fb
> 	https://git.kernel.org/stable/c/f6d4d29a12655b42a13cec038c2902bb7efc50ed
> 	https://git.kernel.org/stable/c/7e9422d35d574b646269ca46010a835ca074b310
> 	https://git.kernel.org/stable/c/c7bb26b847e5b97814f522686068c5628e2b3646

