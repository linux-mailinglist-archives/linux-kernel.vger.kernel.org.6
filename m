Return-Path: <linux-kernel+bounces-343226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA3F98985A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD9C1C21145
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412BE17C22F;
	Sun, 29 Sep 2024 22:59:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653874204B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727650744; cv=none; b=phZqY5gyIqQEOW8KkxJnMZZ9nVtvDiuiE6VDBhcHbNhHrnC8sfZmaX/+YGzHT0Rjxb8hAMKFHMIXHD5fESNjx5n26xj5v2SrtV9XhvQZxwpl+R6czqTkbWCI6PNLuIp4Z+be1DRQlduaZ1kHSw32zA8/qrcW8kQrluhLSfkjpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727650744; c=relaxed/simple;
	bh=h4oDpSQGSnJ4A29Rta5c3hm1zfzAvi7yb1gpTjkvm0Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tNZ9aYaY4fOImpfyVnlH6v5HBIym2zsFFquFmUdE3/Z328hQgA4KMtIDfKsDxSKLSU9DrXFGhCtM7oT4etEir0PFYYnxs6zoetitf9N/h0pwO02/GAJHJBMCWpP580wCOInh8swpTAcbr7+c9qvvBqNTmzIGfzkZVni00YEWKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso41124415ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727650742; x=1728255542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgDZBWRrTi5Xu2giUOd1pJc3GyeIttUJWGJD2ZdfcOo=;
        b=e84NEjgJRfqCCz/KaiwR2ADPIp3kuYu2TzsyCZJGAYfOK9sDwjwBp1Q3w84bLzNuC4
         BoX5lF5JCVhSfIXdsRrWjW1ONOxtYn2U4ZP461wavnfg/fdfM4G/vB0rXbvmjomiXEq1
         zIGTy6I5DAwdPzc6KOVlghOwuTqS61clyvq85EP6TfW5kUyBuduAqvLg3FxOapk5vuDS
         HHthb0aFiIY7JXwTpASHSq6ZH7j3q87zrn5LQWez32BRTlO2xtmPmMmxctQ1TDseiCnm
         t9r5A5/wHhvtoSf0gCErJldsl5hINPNzW+sQZmoQD5qBQhYky0YHJDFqSQotC7MqCcu0
         opLA==
X-Forwarded-Encrypted: i=1; AJvYcCUmau8XnarkELPnRhQqJMGMdLDyhEyec9dFDWvQ+U2VRK7tXSyLOUR61N5O++EMkMy6TQ+dDIxGGRPTG/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwvgoewL22UkoOOSyWxtRgChkaCJcPKmEYTJ0PfKczjz1oJHn
	xs1eAoyW0RtaOrI6NHP20fv0QLisWLcXMeHCVGqAdYrgyPRWy7bgDotFL5uydrkCUy15gvbLB+s
	B/nyVSHl+hRscwf+QfKp5bhyYzRPDd0sKCTjFIIvcbAgZ/J86p8vHALI=
X-Google-Smtp-Source: AGHT+IE6T7rdQBojycR+PTvpV0cPqJGLT7PeVcYdiXV4w+50QowT8LM7aQOnH8gajWgxH7Lf+We8AYUcacRVDckKIqc4lejXiICv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:3a0:abd0:122 with SMTP id
 e9e14a558f8ab-3a27689e571mr88258755ab.8.1727650742491; Sun, 29 Sep 2024
 15:59:02 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:59:02 -0700
In-Reply-To: <8f9374ff-e660-4127-b192-ec9791068174@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f9dbb6.050a0220.aab67.0022.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Tested-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com

Tested on:

commit:         9852d85e Linux 6.12-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bbf507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=daa10535be443909
dashboard link: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d58ea9980000

Note: testing is done by a robot and is best-effort only.

