Return-Path: <linux-kernel+bounces-280578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B43094CC5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7F1C2348D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0821018F2C4;
	Fri,  9 Aug 2024 08:36:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776D18E749
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192564; cv=none; b=F9gL2GodRI1ns6mtwCy13qWbreFat53SWBBN+KeA4jhctey5qBmB3qWD/KBWE5EicnY2ZSv+8YMEkuLv+LG05KRA3adjB4NEL5SuvZ8OqFqoq/B3Hjqq6UMTh8XlgNhSN6zyoMT0sJ/Ne13hiu6UfAgjxfdOO2C3k8UQZAno13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192564; c=relaxed/simple;
	bh=pRNNk+WOb6WNn5sFGjh4p5bAdX6Wnjl2k4cuXBjYHG0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gr3y4wDIdpYCGp5vWTt+oA/M+DT24QmjDFijOSWkcMJMpliq1YlB1CR2FLnji9WlSX6/nttWj/2Gsp2xOihlsmiPKAMGO4r2pUg4VriZDI20L5E4qFfUwAit2MzvWUoBC+8BAkNLCDRQ6/wTTxRa6wOM9MdiRV+C9EpW3Eg7ie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39915b8e08dso25343895ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192562; x=1723797362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCBuhkuLRjU/WQT4F1kiA4COLKOBMg3ilAhl6/UpteU=;
        b=FKtSnlVNXc2UF6d0545eCfkdJoXjQXpg4yCWUPGLx8mYsviyyKB0cPoX7PMZyRyQPT
         hP5QRfMtBVaomEVIPAkatrMR43R/dULBLh81alXCS41d8v2vkQ02mzyH/B/yAi+FkMoH
         OCSxoTkXsc6+RDkGG6jc+LB5XI4LUG/wK3KoKpanq7hr7JU9B0noCWvaJH6K9HaSJUlI
         0zsySALqKv37GZ0PXAD4Uf8hjbvceA35L/eaGTUQ+1NIk/3CRmh3w9Yp6nDhMqQ//SaC
         aIGS6Lh7/SMZaBX2/d7hsIEJhmNqT5cpLF6Ls07uR7Lro0j8jE7behNLQf/FBg+lVmqj
         6NBg==
X-Gm-Message-State: AOJu0Yx3YVnMA0b3R0D5wLTHoR/863Yv7H4CQiB7krv/aTXFOYwrJ5or
	E9GfOOvFfyDFYKcoN/JnDgdMhVKwjW4yDcWZHnxuA0yGSKXRJE1TR6yy1PvZmy4/iSuryjqEoUn
	BYX1X6cTFucH/M56UutW+fHqZ7F6KBiPBxJ88v6rA/CF41XAgniYGmUg=
X-Google-Smtp-Source: AGHT+IHfN7/xts9gtF2LIK63r2ANcv1uUxysbtEQjJZeDvJC6fybJXRYJszolbg05ncz6tGwQ/fvA+ziU4uscB1VBoWIj1+eNSKY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc8:b0:39b:17a9:e374 with SMTP id
 e9e14a558f8ab-39b81325b85mr734785ab.5.1723192562233; Fri, 09 Aug 2024
 01:36:02 -0700 (PDT)
Date: Fri, 09 Aug 2024 01:36:02 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d43b1061f3c08c7@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

add file refconut when add fid to list

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..b7016e148f48 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
+#include <linux/file.h>
 
 #include "v9fs.h"
 #include "v9fs_vfs.h"
@@ -95,6 +96,7 @@ void v9fs_open_fid_add(struct inode *inode, struct p9_fid **pfid)
 	struct p9_fid *fid = *pfid;
 
 	spin_lock(&inode->i_lock);
+	fget(fid->fid);
 	hlist_add_head(&fid->ilist, (struct hlist_head *)&inode->i_private);
 	spin_unlock(&inode->i_lock);
 

