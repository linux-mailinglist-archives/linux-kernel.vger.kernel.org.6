Return-Path: <linux-kernel+bounces-213382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF990746F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149831C247BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55431145A02;
	Thu, 13 Jun 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fpwTG4bq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D32143C7E;
	Thu, 13 Jun 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286952; cv=none; b=NmBcAzHW5yM+vZJYz1T43r6Zo7nNfPoVP2q8UU8p9BsIs0lLDQ7GlW6VFhFG/vcSRR0t0nWzpZTftLkMf1JK0qgPeFBzcx9KY7Hi5Y7gyW1Rz/gpJEp4sXsg2aN7jrpeUqU4R56oNcwGojFvcbT2fgUv12tmQD6gb95j6RVbqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286952; c=relaxed/simple;
	bh=ruBhMiNrl6DWKM+LJobAh8HCSYRSg0kc1KeRJYgKkuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OibjCcJKA92p+UPyEdQRJWch6zbe5rswRKNEB/eKNlQ2VdFRvfouw/m7KYCbacUQgQYQ/v1B90w7PoZ5Sc6crZvo/JwBopE259kHjItW+zZRiP7njwAY8gceYHMfTbBOtI/f0K4a9PEOdYbNwfYxMaBnKM/2wGhYFI6OkuVeEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fpwTG4bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A3C32786;
	Thu, 13 Jun 2024 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718286952;
	bh=ruBhMiNrl6DWKM+LJobAh8HCSYRSg0kc1KeRJYgKkuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpwTG4bqx7o8i7zCV8Z519l65VnUMnC63A8fjcvNMdC9ev1OhZFvYQV7AFG5chf9s
	 i0uCDRith0rsmrgNttnoD6OUJioB80fqaxUTsFDyQT5ahajhvlJY3WznC2jzLJPsch
	 OxWZjXNU1XAcGNxDE3Y2Yv8X0FecobYFOHZkluJ0=
Date: Thu, 13 Jun 2024 15:55:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Baokun Li <libaokun@huaweicloud.com>,
	=?utf-8?B?5p2o5LqM5Z2k?= <yangerkun@huawei.com>
Subject: Re: CVE-2024-36966: erofs: reliably distinguish block based and
 fscache mode
Message-ID: <2024061323-ibuprofen-dreamy-ae0b@gregkh>
References: <2024060804-CVE-2024-36966-8bbb@gregkh>
 <686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com>
 <362b1e1b-dcdb-4801-a9fc-18d019e7c775@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <362b1e1b-dcdb-4801-a9fc-18d019e7c775@huawei.com>

On Thu, Jun 13, 2024 at 07:21:14PM +0800, Baokun Li wrote:
> On 2024/6/13 17:38, Gao Xiang wrote:
> > Hi,
> > 
> > (+Cc Baokun Li)
> > 
> > On 2024/6/8 20:53, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > erofs: reliably distinguish block based and fscache mode
> > > 
> > > When erofs_kill_sb() is called in block dev based mode, s_bdev may not
> > > have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
> > > it will be mistaken for fscache mode, and then attempt to free an
> > > anon_dev
> > > that has never been allocated, triggering the following warning:
> > > 
> > > ============================================
> > > ida_free called for id=0 which is not allocated.
> > > WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> > > Modules linked in:
> > > CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> > > RIP: 0010:ida_free+0x134/0x140
> > > Call Trace:
> > >   <TASK>
> > >   erofs_kill_sb+0x81/0x90
> > >   deactivate_locked_super+0x35/0x80
> > >   get_tree_bdev+0x136/0x1e0
> > >   vfs_get_tree+0x2c/0xf0
> > >   do_new_mount+0x190/0x2f0
> > >   [...]
> > > ============================================
> > > 
> > > Now when erofs_kill_sb() is called, erofs_sb_info must have been
> > > initialised, so use sbi->fsid to distinguish between the two modes.
> > > 
> > > The Linux kernel CVE team has assigned CVE-2024-36966 to this issue.
> > > 
> > > 
> > > Affected and fixed versions
> > > ===========================
> > > 
> > >     Fixed in 6.6.32 with commit f9b877a7ee31
> > >     Fixed in 6.8.11 with commit dcdd49701e42
> > >     Fixed in 6.9 with commit 7af2ae1b1531
> > 
> > For reference, this issue doesn't affect Linux kernel below 6.6.
> > 
> > This behavior ("s_bdev may not be initialized in erofs_kill_sb()")
> > is introduced due to commit aca740cecbe5 ("fs: open block device after
> > superblock creation").
> > 
> > In other words, previously .kill_sb() was called only after
> > fill_super failed and problematic erofs_kill_sb() called due to
> > setup_bdev_super() failure can only happen since Linux 6.6.
> > 
> > Thanks,
> > Gao Xiang
> 
> Exactly! I'm so sorry I forgot to add the Fixes tag.

No worries.  I've updated the CVE database with this information and the
json file and web site will show the new information soon when it gets
propagated.

thanks,

greg k-h

