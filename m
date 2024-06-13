Return-Path: <linux-kernel+bounces-212968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AAC90690A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F2C1C241FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04C13FD64;
	Thu, 13 Jun 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z893yhDz"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9013F442;
	Thu, 13 Jun 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271537; cv=none; b=NW6QGzRSQgEEnQXtTJU8wQLKiOk/vcVv9fJbPh4TV4wnKCTYc8a3iiYcP7bEhfvWuljBzwxuGQFOODPL3xY1ImBi+RvTL43ST6RI7GrUe3LM8NMZ8AxZGMnhPV5dTFTAuel3P6QWcxZdQ+GdfLaJALaZhvdtCrCrEHZ/Q7OWSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271537; c=relaxed/simple;
	bh=YGu8bBnmANbHbQypeKRN17u2Ckw8r3J7Sj2z+3Ba2+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPi5cR0axxhRgL4i3VN9S+OoVW0n5RLJL40JY8AyJMARq3IOlZij9gCfu0SLN58f+peCm/reU8Bax26XlzLVH7xc9fPBzcF9N3F4tYGyRDqG3jeaQZ+qqBn/jfkPHbZZ7Gdx7VZvurMMOu1fa8YLnufZHnfz5sejPeUzPLgQt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z893yhDz; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718271525; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3OyUiU1qhEOkeC1VGKOjBbPI11ik8RduVscYWN4ZITQ=;
	b=Z893yhDztSsM1Xe2jSqgE46AeUlROzKcChsQQe/VB+tpbTy6PI+QM637IJhwdHBxDbUmY/8f7jnPrKQYFmxyWWld8PZp1z9zx14WU7SgOwU10tIju4n7xCTpCA5yqaoE7gHi2T5BWg2WzVyLjiy7KfhEebSf0HGhOOL0ZGWqcTw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8NgIpH_1718271523;
Received: from 30.221.130.52(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8NgIpH_1718271523)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 17:38:44 +0800
Message-ID: <686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com>
Date: Thu, 13 Jun 2024 17:38:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-36966: erofs: reliably distinguish block based and
 fscache mode
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Baokun Li <libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <2024060804-CVE-2024-36966-8bbb@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024060804-CVE-2024-36966-8bbb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

(+Cc Baokun Li)

On 2024/6/8 20:53, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> erofs: reliably distinguish block based and fscache mode
> 
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
> it will be mistaken for fscache mode, and then attempt to free an anon_dev
> that has never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>   <TASK>
>   erofs_kill_sb+0x81/0x90
>   deactivate_locked_super+0x35/0x80
>   get_tree_bdev+0x136/0x1e0
>   vfs_get_tree+0x2c/0xf0
>   do_new_mount+0x190/0x2f0
>   [...]
> ============================================
> 
> Now when erofs_kill_sb() is called, erofs_sb_info must have been
> initialised, so use sbi->fsid to distinguish between the two modes.
> 
> The Linux kernel CVE team has assigned CVE-2024-36966 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 6.6.32 with commit f9b877a7ee31
> 	Fixed in 6.8.11 with commit dcdd49701e42
> 	Fixed in 6.9 with commit 7af2ae1b1531

For reference, this issue doesn't affect Linux kernel below 6.6.

This behavior ("s_bdev may not be initialized in erofs_kill_sb()")
is introduced due to commit aca740cecbe5 ("fs: open block device after
superblock creation").

In other words, previously .kill_sb() was called only after
fill_super failed and problematic erofs_kill_sb() called due to
setup_bdev_super() failure can only happen since Linux 6.6.

Thanks,
Gao Xiang

> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-36966
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	fs/erofs/super.c
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
> 	https://git.kernel.org/stable/c/f9b877a7ee312ec8ce17598a7ef85cb820d7c371
> 	https://git.kernel.org/stable/c/dcdd49701e429c55b3644fd70fc58d85745f8cfe
> 	https://git.kernel.org/stable/c/7af2ae1b1531feab5d38ec9c8f472dc6cceb4606
> 

