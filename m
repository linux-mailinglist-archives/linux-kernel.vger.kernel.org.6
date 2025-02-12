Return-Path: <linux-kernel+bounces-512053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CEA33368
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5D31686C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF821324C;
	Wed, 12 Feb 2025 23:33:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041420B1FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403184; cv=none; b=Y5DdPf4QIgr6Tz+go2vk98xS/PTQLTZk80VzhmHo61ecrnJ/OunpLcJDOn7Hnuxj11o6BcZEY+kWf84VEtjDS0XH5w86MFmWpTzHWQVzbdntvEilR+hWF5jY7El5IN/U3/iMe2g9GmtsM419i1ESLYAseFMvEQID8pabFVOCy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403184; c=relaxed/simple;
	bh=HWgschc3bTmkKCGz39VAAuyvpwK4TLO5qHJRHRTW7R0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cTg6ISyCne5PiuAxq6LvKHJ8xba38oeTIzD7TJOY3uWrqc/nsOGyPkxQPUJu5AUi1zgsC7npF0NFviRCnc9Bq5fNqualV31rp/9D/Mb/kBewmf8qMvsHEq4D7j+CW4/JcukjGV8fGVAtdXyECuUg80KxksuTUX45XlogXigqeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d143a428bcso3761145ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403182; x=1740007982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHII4dhm1xzjJJUaIcvHyvUo+PI6bSWwhH0ZROmrUkw=;
        b=Vdc4HUkJcPzL0q0UfH63/GZQg0a4RxNVW3jtRv+5Nd2GxfbJVKFUeTGRIphX9waf5A
         u6SV+rtOumjaq0/9HuFl1UOagArz/dOT79QKNB+ohYqKp+c1DaVbEuPXrOa3anM8N3RP
         hkXsUvAbttAqxC5Qo5y1DQJxn6/MYFwGM5Ze3aefFHNWysJkM4goDD4OSdE70rLncV8f
         ojgF5QCxcurASg+uO+u76HdODJJInvBPfkBEPZZOa1UQB6dv6Y4S2utGzpXnoIGDFsDP
         oxFw2wfIxl+97FVLEgKETx63puonr8uUsSO8lHkfk2bo9bL5y0CU4NM+1o3RAhVdFyTu
         GfPA==
X-Gm-Message-State: AOJu0YyZXUTT8Ptj8DQWBk8M4CmKzl6W0IsMJlEH2hp0Xg4/driT8Wef
	3G3nybw1Y+dC6DuVxdI+pGYmNJDWmDKfF6CVsOfCMxCV0d8bT/6ol6R5IiV2VjSfR2gIQ6GfmfY
	qypTNyrvHhujJe/1jubNrSm09MAzeHj/sQ50CKtuxgP182aPvGWpffTg=
X-Google-Smtp-Source: AGHT+IF4PNWck9kNtEN0/aqJu4jquJ8UM6lqNRZ5ks849buTrjqHQkv7LfVj/RLgTABFIX9RLXgRDwMlX9yRDzymWppY4aI6hPok
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:450b:b0:3d1:8ab7:9569 with SMTP id
 e9e14a558f8ab-3d18ab79922mr13400565ab.0.1739403182269; Wed, 12 Feb 2025
 15:33:02 -0800 (PST)
Date: Wed, 12 Feb 2025 15:33:02 -0800
In-Reply-To: <Z60m75RgIMCZTldX@qasdev.system>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ad2fae.050a0220.110943.0056.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in ea_get (4)
From: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, qasdev00@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com
Tested-by: syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com

Tested on:

commit:         4dc1d1be Merge tag 'mfd-fixes-6.14' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bdb718580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2347dd6174fbe2
dashboard link: https://syzkaller.appspot.com/bug?extid=4e6e7e4279d046613bc5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d0e3f8580000

Note: testing is done by a robot and is best-effort only.

