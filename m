Return-Path: <linux-kernel+bounces-280443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A694CAB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B909A1C21CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1C16D31B;
	Fri,  9 Aug 2024 06:41:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85233CD1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185689; cv=none; b=UUv2xXOtps8k/qPlnEaRnSibAs3EVpKzgeBaMvxp9rjCLnxinLwhuWvsf9EM2gO2NyU8j6B3pCevS/Xsx4YG0WL5PCpttLzhZhfJnOzJKW6JhoV7RHdpLyKtal8LjhhkrKesEiuNvr5E37MvQZzggmEGAeDJtVBAqx17USG/Ado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185689; c=relaxed/simple;
	bh=kJA3plQSQr9uH4N6WlKoRr4QidKoAQuXrh/2pk5Q81s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZBX9VlhFsHsAicXPlEKrEypW/1I4XP/gUJo6obyWtPngkvE4kJLsswGo6CryZ6CnpLzXHmEZMJ5GCdkev3e5OECqNScBcShL59F9Tt1Kard7SUmDLTXfJS7WusfhAhsCSLYJZfBme4sNBfAPTKURdwkLmp6XRNGrhN1xscrpUzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f890b6fa6so217736739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 23:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723185687; x=1723790487;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dD1FlwzCIFwLWJH1tvjbgVnancO5qNwycMKyLDRvic=;
        b=TyKwdzde7Co7IlJksAGCAPJ34Z8zRWKmkYl8v5IefjebtgxSzKuOuxjRfzM6zvngqG
         KWKDiqaZ0s2tqRBUyIjxHdTJTmS3+cC31T8SCd2jig5cINoHG0MdOEpDh/VS4XwGgqi0
         KhU2Sn40JHlojBpvpwjYE5IX0aLLzPZ1cdwR/3LjdccRF4x62rdIg+dBmmUkXYFVQMeD
         gBKdlR0PhGU5EQk9QjKwkZqTiiixY/DgXtsR268O6jHKykhC+orDz8unfbMm5zPZkbFo
         WPyU+jnJrbzy6Aoz5Jy7uG4uFScJPlMXjHEwf7X2K3RTVeMrFHlDZl3aEbLa4rZyWycS
         6orQ==
X-Gm-Message-State: AOJu0Yx3BT3ow/24diJGQ+6TZaeR55xMX5nweg95ExVjOWgsm8hBduc3
	cpdUpnS9/4xtYtlwO1Ejis2CGaFty9nHefzpYDQ3fHsPlm0LBQnuq7wovcI5TthDALB1lBTyDkg
	ihnbtA9WFkpf6TPYeHT9vAK3mbRKV6fEguPikAkik4pfPlfXf1qV8Yrw=
X-Google-Smtp-Source: AGHT+IFs7eTIF2E/yAZz7up4djnw9Is7/7tNODMjIHifv1oOnOXONOGdcbaH6fDJu7Uru0sUiXoKJuOarXp5E+rSSnNH2phHNy5F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3712:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4ca6edadbcdmr14388173.4.1723185686825; Thu, 08 Aug 2024
 23:41:26 -0700 (PDT)
Date: Thu, 08 Aug 2024 23:41:26 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bee0a2061f3a6ec9@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

wait for writeback done before release inode

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..ca7ea0d619aa 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -219,6 +219,14 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 			retval = filemap_fdatawrite(inode->i_mapping);
 
 		spin_lock(&inode->i_lock);
+		if (test_bit(I_DIRTY, &inode->i_state)) {
+			spin_unlock(&inode->i_lock);
+			if (wait_on_bit_timeout(&inode->i_state, I_DIRTY,
+						TASK_UNINTERRUPTIBLE, HZ))
+				return -EBUSY;
+			printk("del, ind: %p, ino: %lx, ino is dirty: %d, %s\n", inode, inode->i_ino, inode->i_state & I_DIRTY,  __func__);
+			spin_lock(&inode->i_lock);
+		}
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);

