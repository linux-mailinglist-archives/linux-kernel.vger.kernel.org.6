Return-Path: <linux-kernel+bounces-215966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92159909967
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2E11C20E26
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68C60DFA;
	Sat, 15 Jun 2024 17:49:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB34AED4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473763; cv=none; b=hf4l0YwBcDj3yQe1iNi8EObtVfSjSn0YN/ISuJP0kMUyAPtE67Kqfhp45k27yZlyH3zLIKPS4LN/bruy2DLgUoU9vNwbqkkwCZTm5zXjKHKNM2SXxptFVqmXzJnO6EPT8gy5iN+Xwi2dRwP1PzsOQ2s3aIw2M9G6WXuq0BWxqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473763; c=relaxed/simple;
	bh=JAvPLIE0mBCy1QuraFv0uKzn8nd6k6UjHzY6HY5vRzA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uqv6MdCU+mqkXtVYV7LkRP7avYTtHiAqrLIbYB/SvCocaL7VWBSKnwleKXy58AdAjrFhDAULJeL+Low4p/iMNXio0qAsGSVxmi9/rIrRvTIPeXQBYbZo8K+1m3+9GUE9/c2IxqijSTpxhbQ3Qq1lP9RxztNBWAVL+EA3x9XLZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso370321339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718473761; x=1719078561;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UInGsyery+/dP0q9yMFA7Nq7Q+CDL/LaAcHq5GQtjU4=;
        b=xMmEZlzuycY97Zls9AoCi/A874f37kk42yqbAUGTZbjgVYQNuJ3KG8OrcRkHNIltrz
         QSCR4O3k+BZk+Sj7CLyZsFgeKuz1RX1ACt92d/yLfQ1SLKdG96HBH81hPPVrmMu+Zayk
         HplgmXH4rOQ1kfBjktmxUnegsQ45lv54sMy+Ol1y964MQfHn7b7o0z14bM6sgFu65atr
         ZiUUTZEw/pJsEMnE415VORMszOfIYuxBb9RGlrKM6yu8WBEHbG7UErXSLmQFjRByQ1L4
         wdJfOBuOQLL+syb4CB3oGbXuLG38F5L+yedpe3/X7f4ucWIV66HX+IuEl0NqHT4IYlBv
         4KbA==
X-Forwarded-Encrypted: i=1; AJvYcCU/SkGaj2bUg+ckyZXLVMHjmhAuS0UuEoiaKQ9xk2gOBN3YbJhA/FqvWw3g6RLA2we91Z9SAbAsnal4WSniLagwX224yqi3csZkytsH
X-Gm-Message-State: AOJu0YwUrIzfhuPGqcyC69STGzpcYU1ocU889oqUFTK3D2qNRszqiPn2
	jBB8mbm8CBWCO2Ur1/Ef4TmokCEqZTMLgODVGxZK+meY8OIXEKq4MBviPYH6OHSn9/2K8u76wNw
	0QIBTmDxSfk0Vkp2Pu2fCG2anDqM7l3ogfR1RzCeJPvwGsTzo/gzhfsA=
X-Google-Smtp-Source: AGHT+IFqxUfcmYInGmBzA4BKvSlQY9nGlZNQipjeTL/7E4poE7A1Z8rdSrvuUjGW1EZK/MHpIjEwzaczsMeiWFOfi6TgZBUc7iJb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8722:b0:4b9:5d51:ff99 with SMTP id
 8926c6da1cb9f-4b96422b723mr145389173.5.1718473761211; Sat, 15 Jun 2024
 10:49:21 -0700 (PDT)
Date: Sat, 15 Jun 2024 10:49:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017d581061af15a1b@google.com>
Subject: [syzbot] Monthly udf report (Jun 2024)
From: syzbot <syzbot+list313edfb1446ff3b691e9@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3749    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 877     Yes   KMSAN: uninit-value in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
<3> 242     Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<4> 71      Yes   kernel BUG in submit_bh_wbc (2)
                  https://syzkaller.appspot.com/bug?extid=5f682cd029581f9edfd1
<5> 28      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

