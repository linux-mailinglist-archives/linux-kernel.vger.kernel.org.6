Return-Path: <linux-kernel+bounces-432807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACB9E508A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DC0286E43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B421D54FE;
	Thu,  5 Dec 2024 09:04:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05C1D278A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389469; cv=none; b=mxl9y/38F6O2DeAbRbck2XKgpQuWW9cqrHShqAjxbzzzZCecFqjv0snZdesQvCjnNJuCJqoPDeFLh0wKhT3YY87iixIBE1j3C/QZl/LaPtjPD3/A8i/B5+ckN4zxjkiAM6egqSwIEN/tRASEd1FegmhPj5ZSE8qqJ9NcZuv1Ky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389469; c=relaxed/simple;
	bh=1hKwuxkYUzFDqc1eDLpV1wb+dEp345FedBVLtNPpDVU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BRvGu03GxH+/1w09r6git+ivamwMMuGy4vpU2FKcOtlODqzqwWkO1X1pDx2HWPaA2tU0cFqNcSwK8V+YV7HagqwoFdpEpF0RBt8wkaV8W4ihr0T22iZiM3LnhESOpT8uSw9szgtOq8vqqnTUyvX3YwcCrfXg9BYPOrHhptik96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so17016655ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389467; x=1733994267;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/WHwduA8oC3NQwCJxz3w64EoTKDHI7JDHnMcW3LyPI=;
        b=ejJdwZquJ/OVlc4daUAZr/Av1fxPp+jCVIjP9f2aBrh1jsm4OowEjTsZ6PBQnZHupz
         c/g49wZetb80XTrARq3jLNw2Qa5VW+KQXNGrH62qxHSYPUs5ZUOO0MbJ91BSnNkKeyD/
         H8frRhIF0cht79MtYPy8+GOJHUfGckdgXHACaN3FPAkEwsHTe1N+P+5EGc+yIRX0XUZA
         o4VbwKVUTKLa8I2zPa7nlsfLFJHpWEiM5hRg6u0JLoYx733FFhzU7HK+v1TnnGFBS22c
         JP+4bd4liK8o440EU7KFqpW6NE97ooJbYOZjsVFW8sBBioOeF3dwNlO+mSGPI0CNin12
         IGlw==
X-Gm-Message-State: AOJu0YzKf8hza4fsF0Qo8hxisCspcFTsshQ74E7HdPVw6wEoR/UkSRlj
	MrB1s4OzGDxAtjr0EoBqIeDf5+Y0ksb6MJ/+1L1JtnIpL6XL96hu6+5YYBSUN72w3cVJ4J0wcGN
	SBswKg4aCpUNC2OqZyRJH73ESJCn5dmz6WpfYmXLh6SBOka445LrFd1Q=
X-Google-Smtp-Source: AGHT+IExdrlotoz4FplKy3trOuegwD1LemXx5ScJpLrL9SiXjGXnfvmIXKCh2ZFkL9LTWV+e+dULJiIQSBG8mKW++hwBDw3r9bCj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a7:ccb2:e438 with SMTP id
 e9e14a558f8ab-3a8075e209emr20048015ab.11.1733389466845; Thu, 05 Dec 2024
 01:04:26 -0800 (PST)
Date: Thu, 05 Dec 2024 01:04:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516c9a.050a0220.17bd51.008f.GAE@google.com>
Subject: [syzbot] Monthly mm report (Dec 2024)
From: syzbot <syzbot+list9fd5881378a22f43fde5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 14 new issues were detected and 2 were fixed.
In total, 112 issues are still open and 270 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10378   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7385    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  3609    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<4>  2019    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<5>  1313    Yes   WARNING: locking bug in __set_page_owner
                   https://syzkaller.appspot.com/bug?extid=56dc65adbd1d2ae1f844
<6>  1069    No    WARNING: locking bug in __schedule
                   https://syzkaller.appspot.com/bug?extid=46b40e354b532433eeef
<7>  1062    Yes   possible deadlock in gup_fast_fallback
                   https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
<8>  620     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<9>  509     Yes   INFO: task hung in _vm_unmap_aliases (3)
                   https://syzkaller.appspot.com/bug?extid=fe8f8efd070d727de971
<10> 363     Yes   WARNING in get_taint (2)
                   https://syzkaller.appspot.com/bug?extid=aa5a1e52e2ac09339fca

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

