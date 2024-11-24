Return-Path: <linux-kernel+bounces-419318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD89D6C6A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 02:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A63EB2148B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 01:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB08114A82;
	Sun, 24 Nov 2024 01:37:15 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59B2F26
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732412235; cv=none; b=WwOyc4XIGb8GGT4OzhIui+1vXYwWvMqoLW/kldkl70Fv5LvSWHvRFDBNQCSaJzmw1AkUjf3AldkWI7oPXiPUOLF3wX29ZvBK06N2TJCOxKOAGHBu+D9Xdv84CWtiXofSD7L/wpFdu72vNhCdyPhB3bJONCgNX6Ja/Vef8UnNJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732412235; c=relaxed/simple;
	bh=DYPv4Cwqyoodl98auioqnEAOQyLJt+6xLE3/8cYhzvU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F558SsX3Hgd2j+ZQvEMGUgM/86ZA3Vqvt6UboC9bGoecynCMqX1/yEF6vt8I8ZJ9Pcsh35rg1JRF0oOwHUaAbUaPF1I7RxcamZ77rp+LC0uTq6VDmvwPAUY6lHmfVGaJeDhYTHpVx01Yy4s4Af9jkAshDSP7+HLFAw/NPduOs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7932544c4so30099145ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 17:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732412233; x=1733017033;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yS/IrxH46OcEqwY50qT390modqzLZ/q88tT9O4PWKEY=;
        b=rGQP+0ewUuiO259dLIe2ID5R3sTOIW6GmYUefs7+luG48tzGkLiMmD55ZwvJYU+Zeg
         FY0gqhucSLw6ijaHRT0vvwhBV7W7GTdlE7fFogPYzpmRwozPa5SxAwGOdRc9/ziwuJ0a
         i+EjpOMoXzHwIYzlB5y23wJY1FBv6L/nE+90kNgZkw1sP6mu/XHW2PefAHzAYNX8Qnsm
         xkJz7KlD16splxSwVwyrlIWkfidWvBBk0iKM7urSWYD6Omy+A+XRgpxIgVf1aQ1B64WL
         AGK40xMP4a0Lb1ijils48hdxFpdkpt/NR8oEF+qbTNIavielX7E7JOjxicihi7ob6Eaa
         nDsg==
X-Gm-Message-State: AOJu0YwF3Dz/XBdWIvdH87e/xgifyR3XZudf7Y83t81GtF8V2Ep4gIVq
	0LEyjpTNdH0Ho4ZK3TM+JacteQhcxIV8lb8o4UO7NmoOuc2EfG+Ibe44YqUHq/vAgPS1S8tj4HT
	4pFJS8ZXgIFOpRrYjUYCLcpn/3H5b9fLDeg7bF1ya3XbDGW0WgXD0i3o=
X-Google-Smtp-Source: AGHT+IGYxgRkKyaskYV3vHW3Evqv4AlImzAMQHHVEIBSzE/Ii2RsJ9sZaKDpMt0cKE4fet9Ae/ruBaHca5u5ts0Dp0cxzV+gUpPS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a79aff56a7mr90848265ab.24.1732412232937; Sat, 23 Nov 2024
 17:37:12 -0800 (PST)
Date: Sat, 23 Nov 2024 17:37:12 -0800
In-Reply-To: <6740a00c.050a0220.363a1b.0144.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67428348.050a0220.1cc393.0027.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [f2fs?] WARNING in f2fs_delete_entry
From: syzbot <syzbot+35a21b6aade7af3c7b3a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_delete_entry
Author: leocstone@gmail.com

#syz test

---
 fs/f2fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1ed86df343a5..65f1dc32f173 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -372,6 +372,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (inode->i_nlink == 0) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.43.0


