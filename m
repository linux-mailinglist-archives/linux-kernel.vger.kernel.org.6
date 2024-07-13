Return-Path: <linux-kernel+bounces-251427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8DD9304C0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD431F210A4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587FB47A64;
	Sat, 13 Jul 2024 09:35:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F02837A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720863305; cv=none; b=Qlx1wryNz6hITMPKl7DAbLm3IZ56ZCYEKLXppIsPLDBQFythS5tkoKmuKhUOHiojPnvfHj4U+pOBEmzIHDH61Yej2ML0NO33f0hoAE3iNa5u1H7n+yymFAAdZSx0RqDzNcQTcXnA4wsprs9hoiBXEE110QNbiPrldmSYwMOkJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720863305; c=relaxed/simple;
	bh=m1Vh3ztrcEdrx8d2o1UzYBUusC8plggpcssCJLkQrFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XC7JN94cHsAHm8guWlgscTCmK4EkZImx7qMv+VxGC4liBcno+3IiXtIbXJKsymh/cXfNbhWJQqeMiMbQzurvVPqApfD7s5ZcA+9xfjcSOY9tvtm+AVcGbKuutsC1davCsjZopDQJhjlgmhVTjvBBGWrrUOvFwOhNqVRDD4Lny38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7fc9fc043eeso276869339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 02:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720863303; x=1721468103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jjTrHeo6DlRLTmTF0bgdz/kWAjD6vvY23vZwqBjY/s=;
        b=TaOvRJHEvkkFzTyJcBJLZSsh+aGlqhHsytj3QIYEjMlNyKKg5eqFZorOvC49cpVx6R
         /bGiShiaAZM0dBPnPzEGPwAoXsNML52Sk36A3Nw16yyMfHpUNHZngNZ6UyLS2ETLa3K9
         tWSMVD+0BGLGDBUmwU5xa5Rlq9ArwrcpsclBxIGXEM2xUEMAIRtMYLivQQx3pwqPTz6C
         q+z3jEqpYnQ30vFi6HuNtwr8Lup2aA0iEGWewYRE+KFcfsobOFUZD8RnrSuc32vYNYjE
         qb1SkwsY1sqWbk5QyTng4nact2MdjtAE6jXKqWhENceJ8DtD5TwXpTX8vjXRL2P6vX6v
         vLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaWIvxF+3sbJCGhD2213hMrlMBXY8jAupv8ukWF0apWFi0yy98SlJuM7i/2kamRhk1vT9ONjomC5EEuCk3PvMAvOW5wgiKha49cLWl
X-Gm-Message-State: AOJu0YyMqYtU5I6eyvyX+lB7p67g9OwDDwGZFOJH6tBpPUG/Vdo7aNk6
	x7OesTn0Jz8fK6CXgrBbocvrTfnQORToIz2Lc4/TFUAS3l1ypzR7kcuZjfy/QZFfXoy3I00QZTf
	lr/EuCzynVaaIC+OEYcgWTnUW9sA8bvef663vkcTexGBC7cozKoBHSCU=
X-Google-Smtp-Source: AGHT+IE2H3tSYrbXyCg4fE+xJAQ8Kdhn4V7GS8SfHJtiamWP2P4xTmiO71m09/MNPo9/7tpQqK7kJCFkw57Tu0g2tqsgcT2Db7kc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1315:b0:4c0:9a3e:c24d with SMTP id
 8926c6da1cb9f-4c0b24f309fmr922920173.0.1720863303595; Sat, 13 Jul 2024
 02:35:03 -0700 (PDT)
Date: Sat, 13 Jul 2024 02:35:03 -0700
In-Reply-To: <20240713090518.866-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb1758061d1db5aa@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
From: syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com

Tested on:

commit:         43db1e03 Merge tag 'for-6.10/dm-fixes-2' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1691e4f6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b022e9980000

Note: testing is done by a robot and is best-effort only.

