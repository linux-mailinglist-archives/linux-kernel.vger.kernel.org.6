Return-Path: <linux-kernel+bounces-574628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89967A6E7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A882B3A4388
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763E140E3C;
	Tue, 25 Mar 2025 00:49:56 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C0DDAB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863796; cv=none; b=gl1PhTkVxfSUSG50enXaoGI+xraMoEbE+pP2qb/LsTgo0FNOtpXuEFXYL57KVBnCXpa7wM9BUX0vuxFQMzYgpjy16CGQoBa7cX3a87nfCnbjyEvH4wqZDs/EvvY2VhuOGjwIld8MAl8MEb5mx4S6a332Z1WGbxFoPQ4ugxCYOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863796; c=relaxed/simple;
	bh=zjyZCpP6FD3D4UDdCSuIcGCE/BhNfZudCHVjmh+lwX0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=t/SRrwEfv4xWNontgMomU1NC1x3cFujT2KWHHjBNM702LQWRcWhPSK057wUYGWgy6zgKPiL8YhgtWs6TwsLhGodqDMRP/GfM+vSPhRishLIDOxydBQV1d7/Nzt/dQkleiZqUfpsFpgm5DxlxsOK5slr+ZXgCoeM87vw5uZGXN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b41b906b3so514645839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863794; x=1743468594;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GkhIMJowoyyfviJ6JxTMSVJb51C5djBgXOlF+6bKm8=;
        b=RMDp7olXCrx5292/p8D3xFImEzMhjZbUDSvdd7uYhoLBymNzFFGV5h+57fVaNV1mMJ
         ZLn/ckxL7vNIVPTn039gioJJvq/FAD3ApKVQ0JSgI8tEs6H19hYUaWcP3eDjs7272iB9
         w3TgUULDUdLu8jluux8clllDULrxT6UTj2Dw1yeMsFocjlUDzJky4WGVJkibXgsZXzh6
         8cd0DQIPVWN8A6EhtpFR8I8mxaPXbJGmP5oPUE/qoZmOK3vY1Aqdu5P70ju8GcrZmI0v
         NRkA8ZXSHVXxLyAf7wMJ5DrOyyzU4zv5kB5wRE0Juq1qDtgYwHbvnRIyUlroutr71bE2
         oadA==
X-Forwarded-Encrypted: i=1; AJvYcCUiT7RjKKGQHmuRKk7oQc7UGSypAMkURcBZOlbb6kiVxN9KqNXFlwSM94h4BmijA6ycFfN4ZJsXwpczCHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyyj6S8oNBl0B7Q35k6+h16EwyItxf7191ATJZzULGXOJQP3Yz
	WcSgyNy1Qpu1eOZso0cc5yagpIpzUXHPhHtOLpuSP4+/LHEnMrWDr9+3phgmZjwDW5/Uq9qeIYD
	lrJoX+rB5Q16niPNwoAfa0xqkAkoq5o7kg2rGh8hMf+GcwwmimBQ+FKs=
X-Google-Smtp-Source: AGHT+IENfIXI3RF3YxKg9fr5mwlxoaGH+Puj7dtjch/Tjpm6PTD5UKtRmF4k91W5GJGM/56nd+wjoHDW9JEUZwVGKbzMLNnxXWtp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c264:0:b0:3d4:6ff4:261e with SMTP id
 e9e14a558f8ab-3d59603c620mr126449515ab.0.1742863793958; Mon, 24 Mar 2025
 17:49:53 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:49:53 -0700
In-Reply-To: <Z-H9q5X8e6uYiaF0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e1fdb1.050a0220.a7ebc.0033.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Write in binder_add_device
From: syzbot <syzbot+810b8555076779a07399@syzkaller.appspotmail.com>
To: cmllamas@google.com
Cc: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

> On Sun, Mar 16, 2025 at 03:51:27PM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    b7f94fcf5546 Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=134f303f980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc24cb631dc9bc4
>> dashboard link: https://syzkaller.appspot.com/bug?extid=810b8555076779a07399
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 76052006bd87..bf79a0e339fe 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -79,6 +79,8 @@ static HLIST_HEAD(binder_deferred_list);
>  static DEFINE_MUTEX(binder_deferred_lock);
>  
>  static HLIST_HEAD(binder_devices);
> +static DEFINE_SPINLOCK(binder_devices_lock);
> +
>  static HLIST_HEAD(binder_procs);
>  static DEFINE_MUTEX(binder_procs_lock);
>  
> @@ -6929,7 +6931,16 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
>  
>  void binder_add_device(struct binder_device *device)
>  {
> +	spin_lock(&binder_devices_lock);
>  	hlist_add_head(&device->hlist, &binder_devices);
> +	spin_unlock(&binder_devices_lock);
> +}
> +
> +void binder_remove_device(struct binder_device *device)
> +{
> +	spin_lock(&binder_devices_lock);
> +	hlist_del_init(&device->hlist);
> +	spin_unlock(&binder_devices_lock);
>  }
>  
>  static int __init init_binder_device(const char *name)
> @@ -6956,7 +6967,7 @@ static int __init init_binder_device(const char *name)
>  		return ret;
>  	}
>  
> -	hlist_add_head(&binder_device->hlist, &binder_devices);
> +	binder_add_device(binder_device);
>  
>  	return ret;
>  }
> @@ -7018,7 +7029,7 @@ static int __init binder_init(void)
>  err_init_binder_device_failed:
>  	hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
>  		misc_deregister(&device->miscdev);
> -		hlist_del(&device->hlist);
> +		binder_remove_device(device);
>  		kfree(device);
>  	}
>  
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index e4eb8357989c..c5d68c1d3780 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -584,9 +584,13 @@ struct binder_object {
>  /**
>   * Add a binder device to binder_devices
>   * @device: the new binder device to add to the global list
> - *
> - * Not reentrant as the list is not protected by any locks
>   */
>  void binder_add_device(struct binder_device *device);
>  
> +/**
> + * Remove a binder device to binder_devices
> + * @device: the binder device to remove from the global list
> + */
> +void binder_remove_device(struct binder_device *device);
> +
>  #endif /* _LINUX_BINDER_INTERNAL_H */
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 94c6446604fc..44d430c4ebef 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -274,7 +274,7 @@ static void binderfs_evict_inode(struct inode *inode)
>  	mutex_unlock(&binderfs_minors_mutex);
>  
>  	if (refcount_dec_and_test(&device->ref)) {
> -		hlist_del_init(&device->hlist);
> +		binder_remove_device(device);
>  		kfree(device->context.name);
>  		kfree(device);
>  	}

