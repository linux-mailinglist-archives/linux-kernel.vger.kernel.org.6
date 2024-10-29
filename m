Return-Path: <linux-kernel+bounces-386255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8F9B4107
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D56C1C216D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5AD1D5AC7;
	Tue, 29 Oct 2024 03:29:15 +0000 (UTC)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055731F7565
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172554; cv=none; b=HU2pvTo4ZQSQkMkJ3ATJY/4XJmvNGDJtMdN4eExzubDtnI75cMvqTa0N25RxtcCDZ1dmP1EgYjQA4lzCH17GAAanyVABQeTaHfn1LUtUIp7U8BPqJEfComq+x6r4C4mRBfpoaZU6BKpHM6zcfjnDFOA3JsZJIiv0bk4HQXgYEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172554; c=relaxed/simple;
	bh=sM7k7tyE5ZGUeKb13rGMVGJX/sCYfoTtPKtMljbS5f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DY2o6Y64VWsCkCbEOTrQBKfSmFStDJzbIw3pDQC9vcaMdDKnUFJrFj4Rzmx9RWrS3o2V3y4gLnR2yyxEyt8ktsgit9UwyMLKq8wUPqGuw6Tbmn7u2/vMZWJ4EqEvqHdT7Vrf5TKJwM9f2OAIQK3LVB+R9zA7sxTScWjWSB018Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A52F2265C747;
	Tue, 29 Oct 2024 12:29:10 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 49T3T90A183857
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 12:29:10 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 49T3T9iK1412666
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 12:29:09 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 49T3T9Rx1412665;
	Tue, 29 Oct 2024 12:29:09 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: linux-kernel@vger.kernel.org (open list),
        syzbot+0dd28f0c6293cc87d462@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix BUG: KCSAN: data-race in xas_find_marked /
 xas_init_marks
In-Reply-To: <20241028181922.406204-1-danielyangkang@gmail.com> (Daniel Yang's
	message of "Mon, 28 Oct 2024 11:19:22 -0700")
References: <20241028181922.406204-1-danielyangkang@gmail.com>
Date: Tue, 29 Oct 2024 12:29:09 +0900
Message-ID: <87wmhrziwq.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Yang <danielyangkang@gmail.com> writes:

> The cause of the bug is a call to truncate_setsize() while
> fat_file_fsync() is attempting to read. Although fat_setattr() acquires
> &MSDOS_I(inode)->truncate_lock before calling truncate, fat_file_fsync()
> doesn't acquire the read lock for truncate_lock. The function
> __generic_file_fsync() called in fat_file_fsync() only acquires lock to
> the inode itself, not the &MSDOS_I(inode) it is a member of. This leads
> to the data race where fat_file_fsync is reading during truncation.
>
> To fix: &MSDOS_I(inode)->truncate_lock is acquired for reading before
> calling __generic_file_fsync().

If writepages really races with truncate, why normal writeback path
doesn't need truncate_lock? And this introduces the ABBA locking bug.

Thanks.

> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+0dd28f0c6293cc87d462@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0dd28f0c6293cc87d462
> ---
>  fs/fat/file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index e887e9ab7..5578b771a 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -188,7 +188,9 @@ int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>  	struct inode *inode = filp->f_mapping->host;
>  	int err;
>  
> +	down_read(&MSDOS_I(inode)->truncate_lock);
>  	err = __generic_file_fsync(filp, start, end, datasync);
> +	up_read(&MSDOS_I(inode)->truncate_lock);
>  	if (err)
>  		return err;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

