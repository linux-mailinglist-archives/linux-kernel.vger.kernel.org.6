Return-Path: <linux-kernel+bounces-405741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5869C5672
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0B11F24346
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963E2144D5;
	Tue, 12 Nov 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wpwk+iqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21B2144CF;
	Tue, 12 Nov 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410006; cv=none; b=jYpsg2olbdhaXG0+D8Z5Zp7SHU5/zs+47jGE8Ruy1+yxWUr1ZK9i4j6YzR0jGRqARzUtd5liCSKDeedIvjzGDIAVPYPCKc++/N2G1MUlLfesyvJy2SfV2Q2KszSKzlE565nvKgL2CV6bGVonPzfN5ijP+JzmG+YACl4FJzAlXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410006; c=relaxed/simple;
	bh=0Iat0lTwpP+/G7Ddg3nrQ+Peg7j8NA0ItxrWTgviLEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDyGxzTGmCHr+p04skOHz18zaLKAVyd/w6PGmeoYBwsVlK3vsJp4iBVv+5It83TH9nE4w++j6JVEupBvN/EQKom0Bbdp+kUgBNKF14Pm8Bv9xOlmeIqxfmQJCdrbgmH45k3IioTVfVU/M9ArN7AFjEo66ivZHPZX3dSZJGm7tBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wpwk+iqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E22FC4CECD;
	Tue, 12 Nov 2024 11:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731410006;
	bh=0Iat0lTwpP+/G7Ddg3nrQ+Peg7j8NA0ItxrWTgviLEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wpwk+iqEUT3ij7WVcF0M/B/BPj1MvbOl4yo753HpKUyoSGIvyteOT2eAxnZSoLeSo
	 ykF9EFCMtpvlgM1TdFJrVfzkCI6g2UR3/qZD8CLXizP2dckxaMk7TE0mS0JCyW1qI6
	 VsEtIcjBOyO722LE3NDiN8AIj3nlgmy9C/DDSPBY=
Date: Tue, 12 Nov 2024 12:13:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	oneukum@suse.com,
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v3] usb/cdc-wdm: fix memory info leak in wdm_read
Message-ID: <2024111232-relative-bottom-4995@gregkh>
References: <CACzwLxjD0PceaD27Ya6fFxKnSQZajtG2sEArqX6toS8SjNcinw@mail.gmail.com>
 <20241111120139.3483366-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111120139.3483366-1-snovitoll@gmail.com>

On Mon, Nov 11, 2024 at 05:01:39PM +0500, Sabyrzhan Tasbolatov wrote:
> syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is no
> reproducer and the only report for this issue.
> 
> The check:
> 
> 	if (cntr > count)
> 		cntr = count;
> 
> only limits `cntr` to `count` (the number of bytes requested by
> userspace), but it doesn't verify that `desc->ubuf` actually has `count`
> bytes. This oversight can lead to situations where `copy_to_user` reads
> uninitialized data from `desc->ubuf`.
> 
> This patch makes sure `cntr` respects` both the `desc->length` and the
> `count` requested by userspace, preventing any uninitialized memory from
> leaking into userspace.
> 
> syzbot report
> =============
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:180 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  _inline_copy_to_user include/linux/uaccess.h:180 [inline]
>  _copy_to_user+0xbc/0x110 lib/usercopy.c:26
>  copy_to_user include/linux/uaccess.h:209 [inline]
>  wdm_read+0x227/0x1270 drivers/usb/class/cdc-wdm.c:603
>  vfs_read+0x2a1/0xf60 fs/read_write.c:474
>  ksys_read+0x20f/0x4c0 fs/read_write.c:619
>  __do_sys_read fs/read_write.c:629 [inline]
>  __se_sys_read fs/read_write.c:627 [inline]
>  __x64_sys_read+0x93/0xe0 fs/read_write.c:627
>  x64_sys_call+0x3055/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:1
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Reported-by: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9760fbbd535cee131f81
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes v2 -> v3:
> - reverted kzalloc back to kmalloc as the fix is cntr related (Oliver).
> - added constraint to select the min length from count and desc->length.
> - refactored git commit description as the memory info leak is confirmed.
> 
> Changes v1 -> v2:
> - added explanation comment above kzalloc (Greg).
> - renamed patch title from memory leak to memory info leak (Greg).
> ---
>  drivers/usb/class/cdc-wdm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> index 86ee39db013f..dd7349f8a97a 100644
> --- a/drivers/usb/class/cdc-wdm.c
> +++ b/drivers/usb/class/cdc-wdm.c
> @@ -598,8 +598,9 @@ static ssize_t wdm_read
>  		spin_unlock_irq(&desc->iuspin);
>  	}
>  
> -	if (cntr > count)
> -		cntr = count;
> +	/* Ensure cntr does not exceed available data in ubuf. */
> +	cntr = min(count, (size_t) desc->length);

You should never cast in a call to min(), please use min_t() instead as
that is what it is there for.

thanks,

greg k-h

