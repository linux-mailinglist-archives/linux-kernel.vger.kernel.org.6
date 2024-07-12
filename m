Return-Path: <linux-kernel+bounces-250279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229192F601
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8EF1C22927
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2EB13DDD5;
	Fri, 12 Jul 2024 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc7jdzGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B44EAC7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720768336; cv=none; b=BXFV+Z0KbT8dgJhjmQZYZp2WEmC33+OUitd613Ic3LkExrlH6vd6gdTYZCSbpCvpyQK2Jlcxoj6z+HHy9tYBJrB0GQQV5AmYR/Pgj+uPrEnCiz/EJuEXIH6Mog69xYhoYbdbWe1crye/pEmNx+trdmWGADhKrhM+lWYuW84zQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720768336; c=relaxed/simple;
	bh=p7bZwNIwfqiebUvE8LelOzg//t5QYg1L+hxJ8UHPRVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcsoqKZT9bx1KXosMAa/1Hh/maDQrOqszfGJSOXyXEaOA115L7jJ8Jv6WRJhszkfVvHfc+WtlUpX4/eaEvnXS6JiiFg9rgUcpBpLSJ86BROH9vF3/ECEevux+n+fcrRzkeExhiLu0lmsM7vIHeyW/gHLv1drYD5fA0xR6EDb/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc7jdzGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8CEC3277B;
	Fri, 12 Jul 2024 07:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720768335;
	bh=p7bZwNIwfqiebUvE8LelOzg//t5QYg1L+hxJ8UHPRVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fc7jdzGbXkGIkBmfh8rfbzLmHt+A/Li6WuKA6UX7ZokTZQ0V2jyk5Bh1ZdXrCCovG
	 dKsS7uCijcWn6SXG6dueSz3JNyk04WDaqmcaqf/tAn/JoyHmveQWa6ZcLqpF8UlVmv
	 q6xkR66yHwM+RcEpn5WTCLBLnRKw9HH3alIX2fQL3W7fhdmDR3OhzTlwWQqPu1T6pj
	 dpS6FNJ3dFu3DEzAtHXHu8odvK0FPFnEcuGmwZH2qhVospArvdqKCXvL8KvfXLk8VA
	 SIw4kuPnX1c48+mFejaP7aHfJDupOHPGqv3/TrgxYB9uWrpAyhTUaWlR9kpnBkQ17a
	 DIsARlVSa9SkA==
Message-ID: <2b5ab848-1ce1-4f5d-bb7f-2286bf76e6cf@kernel.org>
Date: Fri, 12 Jul 2024 15:12:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Add inline tail support
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>
References: <cover.1720515215.git.bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <cover.1720515215.git.bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/10 9:33, Wu Bo wrote:
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
> To verify the benefits of inline tail, I have developed these preliminary codes.
> To make it simple, inline tail only on small files(<64k). And the layout of
> an inode block is following:
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
> I tested inline tail by copying the source code of Linux 6.9.7. The storage
> space was reduced by approximately 8%. Additionally, due to the reduced IO, the
> copy time also reduced by around 10%.

Wu Bo,

Thanks for the effort, but can you please change user-space tools as well?
since this patchset changes layout of inode.

Thanks,

> 
> Wu Bo (5):
>    f2fs: add inline tail mount option
>    f2fs: add inline tail disk layout definition
>    f2fs: implement inline tail write & truncate
>    f2fs: implement inline tail read & fiemap
>    f2fs: set inline tail flag when create inode
> 
>   fs/f2fs/data.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++-
>   fs/f2fs/f2fs.h   | 44 ++++++++++++++++++++++++++++++++-
>   fs/f2fs/file.c   | 10 ++++++++
>   fs/f2fs/inline.c | 64 ++++++++++++++++++++++++++++++++----------------
>   fs/f2fs/inode.c  |  6 +++++
>   fs/f2fs/namei.c  |  3 +++
>   fs/f2fs/node.c   |  6 ++++-
>   fs/f2fs/super.c  | 15 ++++++++++++
>   8 files changed, 185 insertions(+), 24 deletions(-)
> 

