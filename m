Return-Path: <linux-kernel+bounces-416508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C639D4609
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C58281B90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0E14659A;
	Thu, 21 Nov 2024 03:06:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AE7082D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732158365; cv=none; b=OLZAs4aKweKg7+uxwc24md5A1+RTNXaA54xoZnyxcd5VroR3hvKQcqsRVgzEkU+hlQeklzBxmhXwhyAf9bQxSpclU/TXd7Afv2Ye42iT7mgfUwc+gBoswbMN+DVv1pE6X/UbzrLeOHxyxT3yqwbGKVeyR8ZTcmrjM0/8JZRo5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732158365; c=relaxed/simple;
	bh=19lMze4FBt9ZcAS9KWRp6i8uOH9mPAA59vjy+SmM7MU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XF14xVKTeDZ08AMDDoL6m0kBlVQFeXmEsoWxBQYhvECmGiLCnwS+J3oxAM2Dl3uo4JWFpHPswf6EL2fEPX1qBv8NtYi7g6wJu4bAgfGGW7ZoErSoEZB//iVfZcxK7l5+Oz1Sq11HCueecD5pkZot9x6rbB8mx3WxfXW58FrNbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ab1b39ab1so63266439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732158362; x=1732763162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iT+tkk0XtBVTI1mvaBLoNdXL417sN5a09utqyP6Jzj8=;
        b=dzeMqMtl6g2O87UY5RiYPnkTPVfPVX3Klvwd8Os9E4q98xBYSQKAE/A6JNui3k3yAI
         017fKvfbR+Xo0dL/MJE4U0R/g/rcL5zozrCFNCL6l9mUgsx375EPCt27IgmyY2scQf2x
         q0R3W3ZupC/ZQ/K0pa/PnkATtCOHQg18EBy2tmDVdU8t5OL7B3r0KAgfqb/cEZ1+SPG6
         pLrx0gU6nZIbHmMBDk5ca5qwkBMpzs0bIayhIgePT8BfUjY31yeluBCh64wQR/42njgt
         qhjU6UURq6QjSXxh8m8ySmRCC1ylbEzskQ7mdi5VbRFel4oDZaScr6bk14PAX8f1vUxW
         QQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCV8p7ydHHRVYP3qQD4iqppOyBxSGfQnQJbj8L5x0q930u4K687kw7N00ZSamsoFTow3igK9cJvQmntlexM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQVj9K0/tb5fF8KvnospxDAAA+jZ4+LHqJ6RwdnhqqlbyhBBJ
	OV1f1vhEjlXZXlmpgpjqmn14dUBiU81dUxWdQQWTGK92xDVzT/e0F5R1ndOKzTLYEYgBsMR/Reh
	2/MsdyMVbMGVGPs/91JJQnDZGQ51lh6tG10NlMtYo2byZc2V9uQg5z2A=
X-Google-Smtp-Source: AGHT+IFECs3xXLfzjty274CbuoSdxurVt/fnTybIl9OmWuhos3xSfe2yEatqrch5aDBMJHYLJNfKVj2in1cYGsxmcp6oDAg9FTWC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b87:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3a787f2b18fmr50885135ab.5.1732158362777; Wed, 20 Nov 2024
 19:06:02 -0800 (PST)
Date: Wed, 20 Nov 2024 19:06:02 -0800
In-Reply-To: <673de7f9.050a0220.363a1b.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ea39a.050a0220.363a1b.0083.GAE@google.com>
Subject: Re: [syzbot] [media?] [usb?] WARNING in iguanair_get_features/usb_submit_urb
From: syzbot <syzbot+e3ae1e7f4b88f3e696f5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org, mchehab@kernel.org, 
	oneukum@suse.com, sean@mess.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b3e40fc85735b787ce65909619fcd173107113c2
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu May 2 11:51:40 2024 +0000

    USB: usb_parse_endpoint: ignore reserved bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13907ae8580000
start commit:   f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10507ae8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17907ae8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=e3ae1e7f4b88f3e696f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10edf1a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d892c0580000

Reported-by: syzbot+e3ae1e7f4b88f3e696f5@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

