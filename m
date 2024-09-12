Return-Path: <linux-kernel+bounces-326082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080E976255
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110501F24BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7018BC14;
	Thu, 12 Sep 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa+3LdMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5410FF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125268; cv=none; b=m1HibKoNuyfULoWIVZ+vW/KXdEEmO0oLcPNIuMqhTAwnbu0mUibxEbC1iet+egqJftyiOd+MYGCAxD1WdJa/mdBgYAnHhcC5ZR+2DFWV4Bn+PtLxcSytXWuAeuJujqx5aRcA91MmCl5ZYRoIyqNX30DXp/onVlcd8mBGG9GLQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125268; c=relaxed/simple;
	bh=ZA9BLxD+lQ9n6b28gDkrvcFthmnuikCEMekpEbh0DG8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jt4O68/fbGiiKJoBKdCzX0El01GbyoW92z4bDrFi7vQiKfWe6LPqTSkcKdSOxZxWbpZ/+dqr4u7djNViDrgAk2w8THFrM5W1G8K/sv/IkA4mt99bAS2maVytmrOooQQ8Qs530wG+G3oqglnseCFQKaNMyxmrzlNEgRPz51JV9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa+3LdMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E1AC4CEC3;
	Thu, 12 Sep 2024 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726125267;
	bh=ZA9BLxD+lQ9n6b28gDkrvcFthmnuikCEMekpEbh0DG8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Pa+3LdMJCowinybpA2znB7wcPMIXLIrrOvTLqsyo8CAXaDwGitwW2WGTHTFxIvDmS
	 38ikG4e/ucuwUbhydWUy2iqV2G5vgo52cA0ubLsKAsKTdfJxomzXwXTDMg6RQYbq7l
	 2h+CGZ9IBWw/BBU+NY0KhSMl/Fd+j71/+vM288l+lUthkAsu2rgHr03AA0pWnfnKlL
	 Ex8w+ICqAD7dvJGy0JOGfKLEUYTE9Gjy9bYKkrApJ2Y7DXneF8EPK9jMu/JthOQV/t
	 N0eFQiaF0aMR6/5rKRq6Esg7BlgqNeqjz5GSGO8TC1FNhx2wvyvzNH4u0+WGEoieMb
	 a30ABy3GiOtug==
Message-ID: <679c7dae-91c4-4ad0-a2cb-55dc92b47fd4@kernel.org>
Date: Thu, 12 Sep 2024 15:14:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Wu Bo <wubo.oduw@gmail.com>
Subject: Re: [PATCH v2 00/13] f2fs: introduce inline tail
To: Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org
References: <cover.1726024116.git.bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <cover.1726024116.git.bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/11 11:57, Wu Bo wrote:
> The inode in F2FS occupies an entire 4k block. For many small files, this means
> they consume much more space than their actual size. Therefore, there is
> significant potential to better utilize the inode block space.
> 
> Currently, F2FS has two features to make use of the inode block space: inline
> data and inline xattr.
> 
> Inline data stores file which size is smaller then 3.5k in inode block. However,
> for slightly larger small files, there still have much waste.
> For example, a 5k file requires 3 blocks, totaling 12k of space, which is
> more than twice the size of the file itself!
> 
> Additionally, the end of a file often does not occupy an entire block. If we can
> store the end of the file data within the inode block, we can save an entire
> block for the file. This is particularly important for small files.
> 
> In fact, the current inline data is a special case of inline tail, and
> inline tail is an extension of inline data.
> 
> To make it simple, inline tail only on small files(<64k). And for larger files,
> inline tails don't provide any significant benefits.
> 
> The layout of an inline tail inode block is following:
> 
> | inode block     | 4096 |     inline tail enable    |
> | --------------- | ---- | --------------------------|
> | inode info      | 360  |                           |
> | --------------- | ---- | --------------------------|
> |                 |      | extra info         | 0~36 |
> |                 |      | **compact_addr[16] | 64   |
> | addr table[923] | 3692 | reserved           | 4    |
> |                 |      | **tail data        |      |
> |                 |      | inline_xattr       | 200  |
> | --------------- | ---- | --------------------------|
> | nid table[5]    | 20   |
> | node footer     | 24   |
> 
> F2fs-tools to support inline tail:
> https://lore.kernel.org/linux-f2fs-devel/20240903075931.3339584-1-bo.wu@vivo.com
> 
> I tested inline tail by copying the source code of Linux 6.9.7. The storage
> space was reduced by approximately 8%. Additionally, due to the reduced IO, the
> copy time also reduced by around 10%.
> 
> This patch series has been tested with xfstests by running 'kvm-xfstests -c f2fs
> -g quick' both with and without the patch; no regressions were observed.
> The test result is:
> f2fs/default: 583 tests, 6 failures, 213 skipped, 650 seconds
>    Failures: generic/050 generic/064 generic/250 generic/252 generic/563
>        generic/735
>        Totals: 607 tests, 213 skipped, 30 failures, 0 errors, 579s

MKFS_OPTIONS  -- -O extra_attr,encrypt,inode_checksum,flexible_inline_xattr,inode_crtime,verity,compression -f /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr -o discard,inline_tail /dev/vdc /mnt/scratch_f2fs

Before:
Failures: generic/042 generic/050 generic/250 generic/252 generic/270 generic/389 generic/563 generic/700 generic/735
Failed 9 of 746 tests

After:
Failures: generic/042 generic/050 generic/125 generic/250 generic/252 generic/270 generic/389 generic/418 generic/551 generic/563 generic/700 generic/735
Failed 12 of 746 tests

Failures: f2fs/004

Can you please check failed testcases?

Thanks,

> 
> ---
> v2:
> - fix ARCH=arc build warning
> 
> ---
> Wu Bo (13):
>    f2fs: add inline tail mount option
>    f2fs: add inline tail disk layout definition
>    f2fs: implement inline tail write & truncate
>    f2fs: implement inline tail read & fiemap
>    f2fs: set inline tail flag when create inode
>    f2fs: fix address info has been truncated
>    f2fs: support seek for inline tail
>    f2fs: convert inline tail when inode expand
>    f2fs: fix data loss during inline tail writing
>    f2fs: avoid inlining quota files
>    f2fs: fix inline tail data lost
>    f2fs: convert inline tails to avoid potential issues
>    f2fs: implement inline tail forward recovery
> 
>   fs/f2fs/data.c     |  93 +++++++++++++++++++++++++-
>   fs/f2fs/f2fs.h     |  46 ++++++++++++-
>   fs/f2fs/file.c     |  85 +++++++++++++++++++++++-
>   fs/f2fs/inline.c   | 159 +++++++++++++++++++++++++++++++++++++++------
>   fs/f2fs/inode.c    |   6 ++
>   fs/f2fs/namei.c    |   3 +
>   fs/f2fs/node.c     |   6 +-
>   fs/f2fs/recovery.c |   9 ++-
>   fs/f2fs/super.c    |  25 +++++++
>   fs/f2fs/verity.c   |   4 ++
>   10 files changed, 409 insertions(+), 27 deletions(-)
> 
> 
> base-commit: 67784a74e258a467225f0e68335df77acd67b7ab


