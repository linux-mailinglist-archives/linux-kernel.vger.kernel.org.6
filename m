Return-Path: <linux-kernel+bounces-566358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074CDA676D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F0D19A476A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281F120E6EE;
	Tue, 18 Mar 2025 14:49:54 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E420C47B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309393; cv=none; b=UyCdyn1sE1q2dHEYKRJHgHB0duU+wI6o7re9brgjroPVI4clPM0NGvAYvLT05Q+nKCXG/97VgM8uI/v1+1CtM9yep0mDH+JPzv6qRS1gxYj3S3fbqcHvuyyPf0P5N7wsnXV9AAdZVyMdJr8chb9zXHCHeJaXciXQrlG5vgxWrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309393; c=relaxed/simple;
	bh=4HtMV/Abc0l4P38k6TkSYoPMbclObapgbZrVii3uVPE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tl4uEFEG0wwPbSGBQtdW8N6flsOIllRJfGasKpqcMc5IJ70Ua5K0Q/DjN9P6sSsX924ujfkUx692vHETXM1/LfaqU4CBPPl1OaJRF4x8UhsH7PpJkgqrtDT23a79I8D4R3WqUkRZo4YcEuZqdEocW6R9ApXZ4quJXen7SSyA2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d4578fbaf4so113973665ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309391; x=1742914191;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8L6xlE9FVOcOjJswkbLW3hrSG76u5OhzMVCEfCA8yU=;
        b=rUxMDjeytae+HvrLdFbFZpXTURhUsGaHf9YCVaJTimKiBVCdUMrKHRaRlkMo0L39PP
         QrpeUM9Omi7xrHv7yIc91EUu00wCdQu8jl1mssCQIcP/OBOrxyRaSAwNSBKmWUkdYO7e
         43GlXxUwEpQlfT74j4WYrQd/9x7Tyb7x2xWfRkm0tTbDta6a71ssLjHbchEJbSsnRr2B
         GJNTet9HZWJIX2YGKjNOS5GK04j9ITpli6xWjVqW95No8A7dJcNjRKlp8DIj3jfGjLy6
         CKvtU91K3lSrjlH/lrA4X+vSjfaA5iu3Io8buuefAj5G8WCFXgPV21knW9/s+dNX7V3C
         L7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgrE23kGZdwvJeq9erFeZAXGy2y+mr3zIf9ho4Bc6ZWOJ4WQkdFwBFDWzqzPIA1wSNdGNHfIkxeXIW6g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqk8MhVuTEuNHDp+xsHVtQRKvDtWjcE3fBD3c25WifxuUXcCep
	ap0w+cCSH5k2wYF/nVMg8Lo7AQhnMpiIqRE65Ii3wPE3wwzNrzZRAbWIx1ypCDNPKU+V+kCaeml
	0tyVxVoHJhlHx/dw4sdc8jJtmhaXyAZw1HNDRyn45Wj44/zSZF+uq4LE=
X-Google-Smtp-Source: AGHT+IHq5u09TGzljtWLDoo4CLXQeO+jsV2L0c/HFLP4t10LhYfS7ZiHcjWO4IDf7rkgNJfjwMpwO4OcIr8QisP5HXG/thUZVYDr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156d:b0:3d1:7835:1031 with SMTP id
 e9e14a558f8ab-3d483a1825amr172905725ab.7.1742309376538; Tue, 18 Mar 2025
 07:49:36 -0700 (PDT)
Date: Tue, 18 Mar 2025 07:49:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d98800.050a0220.2ca2c6.018a.GAE@google.com>
Subject: [syzbot] Monthly ntfs3 report (Mar 2025)
From: syzbot <syzbot+list66953ed1adbd749afd25@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 3 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17765   Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<2>  11938   Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<3>  4927    Yes   possible deadlock in run_unpack_ex
                   https://syzkaller.appspot.com/bug?extid=731b27ee9413ba859499
<4>  4531    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  3813    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<6>  2519    Yes   possible deadlock in ntfs_file_mmap
                   https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
<7>  2205    Yes   possible deadlock in mark_as_free_ex (2)
                   https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
<8>  1870    Yes   possible deadlock in attr_data_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085
<9>  1850    Yes   possible deadlock in ntfs_look_for_free_space
                   https://syzkaller.appspot.com/bug?extid=d27edf9f96ae85939222
<10> 407     Yes   possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

