Return-Path: <linux-kernel+bounces-369330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D69A1BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C5FB2286D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3EE1D0BAE;
	Thu, 17 Oct 2024 07:41:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3CD1CBE9E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150887; cv=none; b=myQzmkigxw7AGZxkDQROS5lzAc7ttTP4epy2ggi/YAdYgtW/7nzfHf/6LmJJgClcZFcOlA0F/NPd0VXg3bslzfo1zoPUW867lhGDFHk1jCDRTAxgobJFp19KXG2hwdSDC2n5W0kwJDnzZi2JfNE/nyej3mSxUB8Wo+oU7TwNgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150887; c=relaxed/simple;
	bh=t/LObwEGGdOawRU7e/TWUCOOmg4hEpvwcFLIRCNOrhM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fAgknuwtO9ENNUwiX9L/hePuKhx0dSTYJoRdx4dHnTYJQvhH3yW8apm9MIt4QuN57kx0v7u6ez2U54xFZTsWjb+GRMzTHNGLt3d64t2WbwF6ergy2zijKQIfLyYfjT9xvJIOOZMciFExy0W37XP0lr2zFh8paVykxS8ppZ8l+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so5506415ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729150883; x=1729755683;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAc6OXfa43s8LANRMFVyT8AgLMgezMwrdRIDvl6hS8U=;
        b=rKIiP8cbVR5K76h4UAOeYOVkInE5rzs4LR6XjOjIJuf07H94qsZzNLoSHkIlgVEtbj
         jQa3xJvIMHgJpnKyteMxlsyZBthdz1AMvnIHCM0h0VLv7QxH5m7suieby0yh2WHiNBxa
         /iv/+wL56pJWhnbwNBFBzGnDEjRP0XtqRtT6k6HUTNwxGUHl57u2ETevirqTTfNOlbMQ
         b/iIdqNSLH9wnQlD8TtNHWB3V7tJ4OP1bK30tWu2I2X5PGGvPlRMHWaAInj1kpmvl4KU
         s6nVakF9s6TS14lBp+z2VefpzjSRRqYsaYXFFKGpQ+gNB90Yc6e0wxDjwXDaD7YsX4m1
         e+DA==
X-Forwarded-Encrypted: i=1; AJvYcCX3F6HIXoSa96c+Ufht0H1RUa57YNVZ0t2yftNvL9v983fYf3D315NMXwtOQRIZDKSrPSD0+mU0mLXbh6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFCo6dlyLTgeb1jYv3FfilXoCvqT8Gox2GziKFell9f5fks+K
	3oIcpXtAJmUHNhzTY/EsvGin8znxvwI6LwI9g0PZI00lrcM8aPU2WmmZPCTkl+ZJH/EihOAmgiI
	nmXDFEB9aS5pp8uXwAbrGP6s6y6k0k/lMHg+P9y6F3SG97FqMs/JG2Fc=
X-Google-Smtp-Source: AGHT+IGho+0gi0UyfYas1VcQgfKsay/yzTz8tSUavcdQWkEdoXfukn6gxkv1JuE4wwmr8Ya/TYGRbzV17+MS58k0DdbLncpBtx9F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:3a0:ce43:fb62 with SMTP id
 e9e14a558f8ab-3a3e531953amr16849985ab.11.1729150883673; Thu, 17 Oct 2024
 00:41:23 -0700 (PDT)
Date: Thu, 17 Oct 2024 00:41:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710bfa3.050a0220.d9b66.0186.GAE@google.com>
Subject: [syzbot] Monthly udf report (Oct 2024)
From: syzbot <syzbot+list50b99149d60b13b90468@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 2 were fixed.
In total, 6 issues are still open and 32 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5340    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 3462    Yes   WARNING in drop_nlink (2)
                  https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<3> 459     Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<4> 7       Yes   KASAN: use-after-free Read in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e
<5> 2       Yes   general protection fault in udf_read_folio
                  https://syzkaller.appspot.com/bug?extid=ddf8715339c89280b6fc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

