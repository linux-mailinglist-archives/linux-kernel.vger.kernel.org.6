Return-Path: <linux-kernel+bounces-394757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D953F9BB38A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE4285BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D661B4F02;
	Mon,  4 Nov 2024 11:34:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A01AF0B9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720076; cv=none; b=sZyRA2S27OSf/zYd2X/WPQZCQGGjz44v36lNMi/pnYX6unknwziStQn+q6W1Yd16PojcTEFn0NQrTDNnOXSYtqh6HUB1Xep4LfNm1G4cZL7CZ9wuMOCHW/zuQvPAYrmEJ1fb5fykanEW18opWK0MWuOWvYYOER6OAlp/QF6ihwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720076; c=relaxed/simple;
	bh=EGU6oYO/2MmO/vCVTzmBe/Wo/0jXPik4drz2LC5Ewuw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nu2GJcQ/IaFLuUGjPyRILQx1yFzbn9IK1w+juaYWLL8ejgMQFnAAUoBBtx3z77FkMvvzaJxRs0xVQlJ2HoBUpCfwP2Nx0GopTFx6zttJzlAxY/+4Sw4Du2zG5T8m+KAvDC39/9TSruB6+SmKkv6DI/r65XHcsmSijwLhonDI678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3fa97f09cso42604965ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720074; x=1731324874;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPMayGsCyf+eRwQewCQCBYCKs3I3CQrUaFGcmxlTBgY=;
        b=NR+sqveIl+YvLU8X0v0ifut+prrv6xC3ewt1JLjI0bKanLgkfkIlSOF+LzCeJyNj82
         ldg5m9+uo//tUTF2lesd5mIDZ1IVk9BRisR7BexeOeYJsZkD3M6dmjEgHUQUAI2UwdcI
         afm6MImFNV3LU6PNIduVjU8ctHSA0ahxGDuJkFW0qABiSxOl+2RNb4xPdPicmQq0fgc7
         2zJuFyMSU8XzJat3+iUHiwfGG3c3Gw4ZE9mcUyZ7+ZM+eg4a0zeC/LGomsU/lL5fozxJ
         h3C+yg/X+VVRTYv04ONdZ9Dp5r4wWDAooPJZ6/7S9/bGHgnYnfT+cvZ+qA1AqWEyg0X/
         ZlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqHpQYGuuNO0QEDhEdew4abPfF1LzfNPLoTHd6AgUiw8xUOUeybiE5Oth1vDMN/PM43swhrOFaOUa05fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7+kmUJLC9/2vTM3HU/Cz58rFWiElYY30v/ZR7cVFgGF/i/xc
	iZwC38QHgvtgDnUG2JsnhAIS6GkPH3EdHbbBlGHrgofVC5MsjsX7DMoH8vY8FrWfGNk1QP+JoIx
	4BuYE2Oh60O0sJOiai96A/1wRf3687Mi+QYYsPmqmjHPzn0wC6xJbp0A=
X-Google-Smtp-Source: AGHT+IG3QHI08aeIy0UQp8XNMIQcc2v76d5c5JJUyXYBUuVJXqYeDTOCSdupquyz88UOZfPfhek+zOLah11f05A1tJ8LhInomzn6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c544:0:b0:3a3:b5ba:bfba with SMTP id
 e9e14a558f8ab-3a6b02f1afbmr115274145ab.15.1730720073918; Mon, 04 Nov 2024
 03:34:33 -0800 (PST)
Date: Mon, 04 Nov 2024 03:34:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6728b149.050a0220.3c8d68.0b1d.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Nov 2024)
From: syzbot <syzbot+lista60d58e68ff9564f78a2@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 33 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 567559  Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 1323    Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 317     Yes   kernel BUG in gfs2_withdraw
                  https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<4> 275     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                  https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<5> 118     Yes   INFO: task hung in __gfs2_lookup
                  https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<6> 26      Yes   WARNING in gfs2_ri_update (2)
                  https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<7> 17      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<8> 4       Yes   kernel BUG in gfs2_assert_warn_i
                  https://syzkaller.appspot.com/bug?extid=ffe01cefd437cbde362b
<9> 3       Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                  https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

