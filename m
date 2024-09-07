Return-Path: <linux-kernel+bounces-319875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4790597034E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30821F2249E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1633161914;
	Sat,  7 Sep 2024 17:16:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC840BE5
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725729364; cv=none; b=UiPXckmF4rsMXbqkty0TILrsVxxoiMvc3bKG3ZvWP60NOyYSjupUitBSOMsUNSPyJeX+aY7ifScIIOVygdCU+uKEWEQDBjht3vbEhP2ZNtTLpRXIijz97iatMonb19hzmHvN3Y2wisRt0qoy+OR8cBBad/IShx3aJtr9FTC0MY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725729364; c=relaxed/simple;
	bh=ndywN073E0k6sTkM/ZVfC9q4Vcrw/JRDe+9SUhWR3o0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GXL6EDSnQ0HEY0ajO/QHcir64gmwREjnnbW/Fd86pf8pkU0/RyPXqLIHVmQgng9rvUHXGJReq8RF8Eq5YsoMkHpahAB+soLUrbOWN9Ez4d3hsInJf4zkpJBV3k12OkGSwQXrtE1C5eCOpv80qtxVVH4bBJmCw2jQQJokB5nDGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a045bf5779so51048045ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 10:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725729362; x=1726334162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D65iIYDSawVBByvUh+jS9qZI3QDC5eYj5oMaDJiYY0=;
        b=C9OrdwCI971lwfiR/FfwvLyvHv+UrSX+V9QQ0XIgDLWGFZTrLcJJreru10r0HfKHzi
         9PU5EpPmZ4UV2m+n7QfSkd6XXbxeTJntL5gZQyJildyYEgEPXKINIrVmFdm0D58tXC1l
         cIzmT08qYVugDDXWfad3Xw4Vehxhqx1WRwUY2d6KWV7so15PJWBVA1NYolqrfKqgSdjI
         95VQlttIaDR4iwlL/mbhIBd3MvQu6J5Kh8pEpfvuonNL0FAsgFji4UNBzm9TqWdgQjet
         Ncs/3lL7b5h4GcsAonxWnBPM+VUov3UiqQq/5JOjpnUQUAUPqSsQPdvw+q+jOB8VN1ph
         8o1w==
X-Forwarded-Encrypted: i=1; AJvYcCXTZ03bjvQkXcAl1SNZ4j6kz8hl+COP1W7+Xp3sgdg5jBOLv6KF9V12vSQOMq583B+31nptSMtp43H5RWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSh7ebzQVVqcneE9t4URxnC1IAaZl9+vPUUYAFeffprw/3v0jC
	TnYqQRW8VYZl9cONoLJvSgi1rcYxryiVa/Z/f0RpllJ5t99V9DOcl12hKWlmoPi3uYZZLT+2dVg
	cx97Vrbyii4iZWPo6dbH4LziHPRU1efOGKWPgnLGsChEltm/8dQ6xVbM=
X-Google-Smtp-Source: AGHT+IHny+ovz8OZCs5BdIhiyFQoXV6XCV4S0GtKSePQEZTOlCIaNQ6MzmB6yYxYTu/HOPIaFwdGizv9ck7ARvRYNkhkFY39DUUo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:3a0:45c5:a358 with SMTP id
 e9e14a558f8ab-3a04f07aa03mr1149985ab.2.1725729362453; Sat, 07 Sep 2024
 10:16:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 10:16:02 -0700
In-Reply-To: <CAG-BmocVhraJ7Jp3Y6b05hW78-tDEnAXKh--1DOtJHkhLb7jQQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0c6ca06218aad61@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in jfs_unlink
From: syzbot <syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com
Tested-by: syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com

Tested on:

commit:         b31c4492 Merge tag 'linux_kselftest-kunit-fixes-6.11-r..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162e189f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc7fa3453562e8b
dashboard link: https://syzkaller.appspot.com/bug?extid=41b43444de86db4c5ed1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1116189f980000

Note: testing is done by a robot and is best-effort only.

