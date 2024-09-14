Return-Path: <linux-kernel+bounces-329338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00EE97902B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9680F1F23B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2D1CEEB3;
	Sat, 14 Sep 2024 10:58:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5031CF281
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311508; cv=none; b=t0RgwMFqXUWrtezDibO5wanloEvW9GDMW3pset9nFeNw6e+B7zxE6K4/yL1W5ac0AkDhCgSYh4+tO+A3R9o997ZxYi7U8E5qqN0O0w8dfNcd3I0QUz2hlGC+ghgRVBR/BaOjzSjWbFZ1YefnoPnBd6iHSM43qwZvdJNrXunNiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311508; c=relaxed/simple;
	bh=S3EHlT4pj65GnBkMEsNwf341ydw7Jg8R5ZcGRxNIdak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aHHptiiHX/dNHCHMRSYL2Tdbq4JwaSYNtWEz7Li9Y1fHF/px3Q6EqMNsJhjy/7i1EUrZIzsrfECfdTXx3pXULXG4GBMNkOhWaSQh/0h6dinbfiwMn4K3mcfSeP9m1pgV1IK17rBX6LsFQh6DGluOLBvWxaZriPVnMqRbGuE5VKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a09aecb414so6123015ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726311506; x=1726916306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNsanaAnUqKnJPrB9ujnMWafkXbSugNGS//lVxE3QOI=;
        b=i7mcJl7PdkSSQPbxIlKeBBFHMjQ4j6oxR57zuEsz8ZZESPgFkwdFtuFAFqLU9PAMDD
         6keUQxDTaGSXEJjjAXdaXR7NLwd68NVd90PSJVlpUdrOhohaFHek4fES9fbkO/8WRtRM
         L7SqhmoPohEJlRQ19AfBULp2woyPo/mPPDBsunFtCDjXWOgqCxBkBFk5+pMh3ozitspf
         jedXnD+S4wm76wV2zTL0tEQjSRCS/2u5qWyOygVjYkgwMcoQdPlRWppvIEJKzecgkhaN
         5R3om+u7D++DemA0A4h/KrQEYX+haUU5Pss88WZOZ1G/wzL/hJ2aeYQKS3MrMonjAq7c
         2MZg==
X-Forwarded-Encrypted: i=1; AJvYcCXg5uB+V/O9+sjAQ6GuloZYyN9UjLNlOIA0qZltiL8cvm0elPHX38f588E6RLr5cu3AulJr6y5YEuIjlNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNyomUt33c6m7YnKo/pEjmJ3Pt/Dt6+x5VZ2Vq63oyp/1JnbDp
	U9YM36YEZNrytgvfNSdnVZqlfQjfeRppxTWxmIFG6irNbE44EU177jWIH0xJuLxuJ4TRq9vqCNI
	DZOlZnFsjWzrSkF6/W4YcZmDxPbzQxwb+Ig7cHkwCNWLxHkFcXY1G/8s=
X-Google-Smtp-Source: AGHT+IE7cyEMFXq0PLoldynD4nLYkoTuyeUjye9q3jPn/FRYgLjwv8eiyTn2khxvdRdMQWeUBbBXmR1qe8E0+JvcgOMLwFwciUPH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:39f:500e:2ffc with SMTP id
 e9e14a558f8ab-3a084941b35mr98911775ab.17.1726311505991; Sat, 14 Sep 2024
 03:58:25 -0700 (PDT)
Date: Sat, 14 Sep 2024 03:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e56c51.050a0220.3a9b1.0030.GAE@google.com>
Subject: [syzbot] Monthly serial report (Sep 2024)
From: syzbot <syzbot+list1e0c4845fea51e9130ce@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 393     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 152     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 15      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 12      No    KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5> 8       No    general protection fault in n_tty_receive_buf_common (2)
                  https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02
<6> 5       No    KMSAN: uninit-value in gsmld_receive_buf
                  https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<7> 3       No    KMSAN: kernel-infoleak in tty_read
                  https://syzkaller.appspot.com/bug?extid=aa7ddf2352c316bb08d0
<8> 1       No    possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

