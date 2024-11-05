Return-Path: <linux-kernel+bounces-396603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B210D9BCF56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38321C22D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55791D6DB5;
	Tue,  5 Nov 2024 14:31:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849E33080
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817065; cv=none; b=TvsyZ/gWJAvI2zC84ApPwW8bT6Bolzg4gmnh3kJFik1xU7/4NC6BCvbrXJdtARhSqs8ZPLFADhBhiu1tyuniFkDtDTQ/iCUuRBOoYN16YvKQrZpkrvwUylcAqExvtBhQe0wJJLD70kPlu7hHKGwENZ02nPSfjMKM/oHTTZP5rOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817065; c=relaxed/simple;
	bh=epAYOPBzR8saLBlScXcJx0RqjdNLkIRQmj0sbjRdrpQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NODusQ0m2LJXxHwX6wrCtPEUWvvwd1igY9nXCzfAZ7ZJQcLDeeQUQPGxVhgbwcBgrQprzibGzhRwLJF4fbD84W9PskEhBDtDy7/cZrakL3VpePoYaERt5q3+RSKul1574uTdGzA/oI7qG/7BrPDpaWthRAkWQ68bNa1ri0JhGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so59290575ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817063; x=1731421863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRNYqJ9Tj60lia+Y12ocwgU9mCJp7/CnVEPdSQtPqTc=;
        b=oq0TfmMXj6OQuMIyFk+9BcZU7y2Wm3GYTbtunMbDc4Uo7Aia/rVX+ACW0lo0aE6zQa
         EM9KtPY53KlnYUyQ0rWYRZaVZAQPl6SlEtW6G6IhOQe78U+n2307yTEbMxbiBXCRPvPS
         VmC48f8ASqB+a+5dsk+MBeuib6O9SKFeeLWXrelkL1N9bbzjOC0nr2c/eBqYid7DEhzn
         Dv/NK+mtA6Kt5hLZ4H6A+ry0dyCgdBDgWkkRlmNs9Q0Qy4Mqbf+ifQIA35BwrQjITTCP
         q0Y10cLEMWbHNy9DAlMKxVOnKI0qz9QF/0YV+qEXWaPatfziq1pNYhZoaEpbRqW2WJF8
         IWRA==
X-Forwarded-Encrypted: i=1; AJvYcCWLf+wWrypjhaWQZcwPK3dnGp41dbv+EZTV0XW1PI52e292fnoN7b5tZ0tLus4e9x76e8JmknNLuOE9oMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPC3qxTvj1uadRNoGv5m4p5CUSrI4AohGJdAgSUGdfXmyoEUr
	f+yk9YaNNdQnPEzYDo/tNcpjrpbYDaYsujoEORh2YIAuWGwqfPjNveTskMcGD2PkBXImlRDNPbE
	ElMJFYL/gJdai6HhcEG1JJy+zzgquz9/ZUkciefw3VE5NZKZv7cSh+EY=
X-Google-Smtp-Source: AGHT+IFQOcwrBi2phNGZeXXp5QpcylKz9CnwXhP9eqltD4ntEP/SUJZgMOwX5Hrhlt4DHsoB1Ta6uHSSXSDktzBiKMGa8w+NjVni
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180f:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a5e262e863mr252163285ab.21.1730817063064; Tue, 05 Nov 2024
 06:31:03 -0800 (PST)
Date: Tue, 05 Nov 2024 06:31:03 -0800
In-Reply-To: <20241105141124.KeDxG%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a2c27.050a0220.2a847.1131.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: shift-out-of-bounds in ocfs2_fill_super (2)
From: syzbot <syzbot+56f7cd1abe4b8e475180@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+56f7cd1abe4b8e475180@syzkaller.appspotmail.com
Tested-by: syzbot+56f7cd1abe4b8e475180@syzkaller.appspotmail.com

Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10301d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31194b6116728121
dashboard link: https://syzkaller.appspot.com/bug?extid=56f7cd1abe4b8e475180
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c456a7980000

Note: testing is done by a robot and is best-effort only.

