Return-Path: <linux-kernel+bounces-321576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D1971C34
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB211C22039
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033551BA276;
	Mon,  9 Sep 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yYLecxUL"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4F178CDE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891288; cv=none; b=vD7HdwJjbKF8vMXIVNSo6xCblYrTMAXR0vBvVgLwsxbTon4cGkdVy3ytONGtXjOgbsR+YLaB8PRxPKJutJ93JNTR+rlSUyZixYMqUzADoxskTphyDcksPMK1MWh9zVuzcJEIQb8PV599xUpmJkz8ZSi9nwkRN4EAqpAtPuTnkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891288; c=relaxed/simple;
	bh=nsGUaF8yctoj9y0KlK25V6z47D7vnz/Dad/9KWitY48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9ozaiD4ysJbdgSy3dfV7eVbRC3lOU3ScsWPsi55qhtpSs43/Vhjkkn1FRXPymwS0wWW9B5a3tSFG6ho+djCzXCa02rtT2FmrsyzwFlvsAT2ad4yGdZKlT2yTNxpEWld4LniR5OsDz6tC+q2I3E9Lvyjsc8gKvCOjHj0LxCvbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yYLecxUL; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725891275; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IAcwvzoMydeLjuaop0xgeZzWUw7A+pNuIS0p1YukCJw=;
	b=yYLecxULzmdY9LR+gX+M1Aav1QPEBnsrwP39WWlzR3w0EgEl45rgQkbxEPj8xS3S+Ur+nuNuuRqwawop7Uea2ckFTD0veBPnsHtA7kRBqx1cR0V8LRF8LlVGMNbgzPY9a64uBnd5b+1T7gZ2sVd6ZVmmMhGUCDSmE3BqLzQBCOA=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEfKqoU_1725891274)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 22:14:35 +0800
Message-ID: <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
Date: Mon, 9 Sep 2024 22:14:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/9 21:58, Colin Walters wrote:
> 
> 
> On Mon, Sep 9, 2024, at 9:21 AM, Gao Xiang wrote:
>>
>> It can be bigger.
>>
>> Like ext4, EROFS supports PAGE_SIZE symlink via page_get_link()
>> (non-fastsymlink cases), but mostly consider this as 4KiB though
>> regardless of on-disk block sizes.

Let me rephrase it more clearer...

For each EROFS logical block read (e.g 4KiB), EROFS will
only generate one filesystem physical block read instead
of two or more physical block read.

Symlink files just like regular files, so it doesn't allow
the inline tail crosses physical block boundary (which
means an 8KiB I/O is needed), see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/data.c?h=v6.10#n103

In that case,
EROFS_INODE_FLAT_INLINE (2) shouldn't be used and
EROFS_INODE_FLAT_PLAIN(0) need to be used instead in order
to contain full data.

But the fast symlink handling has an issue: it should
fall back to non-fastsymlink path instead of erroring out
directly.


> 
> But symlink targets can't be bigger than PATH_MAX which has always been 4KiB right? (Does Linux support systems with sub-4KiB pages?)

Yes, I think 4KiB is the minimum page size of Linux, so
in practice the maximum size of generic Linux is
PATH_MAX(4KiB).

> 
> I guess let me ask it a different way: Since we're removing a sanity check here I just want to be sure that the constraints are still handled.

It seems page_get_link() doesn't check this, but it
will add trailing `\0` to the end buffer (PAGE_SIZE - 1),
so at least it won't crash the kernel.

> 
> Hmm, skimming through the vfs code from vfs_readlink() I'm not seeing anything constraining the userspace buffer length which seems surprising.
> 
> Ah interesting, XFS has
> #define XFS_SYMLINK_MAXLEN	1024
> and always constrains even its kmalloc invocation to that.


Not quite sure about hard limitation in EROFS
runtime, we could define

#define EROFS_SYMLINK_MAXLEN	4096

But since symlink i_size > 4096 only due to crafted
images (and not generated by mkfs) and not crash, so
either way (to check or not check in kernel) is okay
to me.

Thanks,
Gao Xiang

> 


