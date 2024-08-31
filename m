Return-Path: <linux-kernel+bounces-309897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC8896719C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986E11F22B13
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B481802A8;
	Sat, 31 Aug 2024 12:50:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1317BB34
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725108606; cv=none; b=CzNaNo9J9YIkYFLs94WryehGuD/FqMSp+gxhtWDZUuKxRSvp778GkxIMtab1JP1Lx4GNZWuKYL5wYc63k2JqDWm8lbwO9sXKhKWYfA5FIpDzjKJBM41BxBveqVHbjePzhN9tM+khx/XfXJVyjsb7yEpeL5sQK4jcaMJ5335C7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725108606; c=relaxed/simple;
	bh=8osgygwu8S3WOYpKWkRYA57Fxuite9SuhO+yrtNb13Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AEU8yfa7PXW56RV4nNVW9g3QwuREeb1z/LbdbrR3N47+p2LHIITxJKu16/CxN9eYeazCfWNmx4a+IBVC3M+32QNVdIXu3Tj8gijtsXBgDzBmZCOb6Za5Ho/XC9MTPPDOIK5h8l8oYCWClxJh1u0ZxtWuvp9My2x0bunLSjkBRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a1c57f4a1so311905339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725108603; x=1725713403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOrhT54fFAg2yuW7VI3NN64WpOvK0qct+AXeVomy60w=;
        b=kFhQFBOqPQ6jnswcK38IaJbnqiefDfvuVvmnauUrnClDIuX5TSIk9HRgqWChHm7nAG
         ObxfZpj1LJ0HrmYjNOCxzcYbMWPGSs2FT2Vjli/1ceee5pExQWWpNVsiYTQo4c8NN4RF
         BJBdBdrF8wQ6fteKDXsXFL8bqy3OlZsvkAVojJgLL9nVJoi0WLN7eCSLx4ljYpBZ8Ul3
         xHmTlfeOi8HYW9ZyEAAIUFOAnH3dkky69SMrSdbYx9Lswas/uml9Tfo9hoH6mRGHIsRa
         xnbjdwpEd7SNArvT4KIiPKAq3NDrzwk3VKQSQZ/q88hlt1Ya1zCOHbmUq161IN4yq106
         RHNg==
X-Forwarded-Encrypted: i=1; AJvYcCXDzZrYr6zv0tWnrpXYciBbiNG9E3EJHy4ofVWc916GAbGvdiNu7DN4J2GCdKwBVEKViSRjI9/f5Iw2z0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUqVk0+zzmon2NSzJK8Dvze0arYmVhYStfZsrsLhdYBRcfv6S
	u5P+IQf49jxw51tcrt9w1HVgcCNCrqqSD6tS8PgehGiMtZO0z9ehDGGrtWA97t0wXYWcpB5ql31
	6wvj7aZJ9wScpYR3x9D0fZF2i8tZRUWmOw6RXMk3Xpa5TegSUeFWANXw=
X-Google-Smtp-Source: AGHT+IHbqnlQU0xRKdCvyLgDE1m1n6ES46zZnFhuBKy4wRTOO/AaTTQgYgpEXVkPryw2FPCOM/SuSC6XHlQ0t4FPG9fP1l0IwIy+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3494:b0:4c2:8a0c:3815 with SMTP id
 8926c6da1cb9f-4d017d9a32fmr193481173.2.1725108603592; Sat, 31 Aug 2024
 05:50:03 -0700 (PDT)
Date: Sat, 31 Aug 2024 05:50:03 -0700
In-Reply-To: <20240831122756.1426-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008434460620fa2585@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_nfs_sync_lock
From: syzbot <syzbot+fcb79916dcfe2a4ed10a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fcb79916dcfe2a4ed10a@syzkaller.appspotmail.com
Tested-by: syzbot+fcb79916dcfe2a4ed10a@syzkaller.appspotmail.com

Tested on:

commit:         a18093af Merge tag 'nfsd-6.11-2' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11d450fb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8605cd35ddc8ff3c
dashboard link: https://syzkaller.appspot.com/bug?extid=fcb79916dcfe2a4ed10a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e64529980000

Note: testing is done by a robot and is best-effort only.

