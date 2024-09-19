Return-Path: <linux-kernel+bounces-333768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C597CDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5347F1F234E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C5322638;
	Thu, 19 Sep 2024 18:43:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB5200AF
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726771384; cv=none; b=RK0ekMhUYddS08VdUEhPUaojGdssWtJwReFSl/L7Ty9GKOFccxLMq4juGkfkTal16oKCChq6ODu4JDm1uRT3vY6+ZZkOAVcy/BngCYekG0JuX+2oPFAiwNmf3qGx20vMAmi73iUAx5OnLP7w8hRsGDfGMDFlRtjp5rWml1+nv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726771384; c=relaxed/simple;
	bh=17v9D7ewN9kAL3cNO0vf9+Ecs7x5/yWbSuqDJSadNTs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JpxwkKaisa8WCnkG8O1iTG3bbFrclQxQnSsRjmK02yO93sH9uCpUS2Her0CI2J+wX4Zt2YeeleTjLBb74wekUq4B7cokrzlkYwqCZmIvBCkgA2mZavs1pW5D6K0uFSbr1KwPVx2Eaa0br/FDdB8bNsEAxceE19nWr83W472HC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f5605c674so16492655ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726771382; x=1727376182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7lIsnCpfZQSVA6F2fRePR9yCTuruPmP5F+EBeyS/UE=;
        b=JVp7vPMD+V2PjPfN4ThdXoyX2pBI8qbLVKbZLtg7huf19oI5lMcQOB1oiAB7YnnDUv
         ebnMXKPiZZXIcj+P1St8p34yv7jxEExCxOU8reIlD+ig2OAz2yHAyOed+bn183D5prSv
         fID8L/KDboFyO4n1/q39OAVeJx8iodo4zHqpd0FzUR6EXsoG9KRjK+wItUNHooa2qwvk
         bM4L/O3BNOKAwkph0Mp1aa14O1zQss7Aw4S/wBfo3Uppg/WWvVzxc93cmL/zYzDkMDY9
         Vs8V1qoTez8XWm/di2ZrwperM35/SB+rDnfEAZZ6EgYjYjD2DbErDNueCNr2VqFKx8H9
         g8fA==
X-Forwarded-Encrypted: i=1; AJvYcCXwZUIV4pIJmdUg7YvB0kuLacZpN5Hh5zV26ibByLzTlGXtqOHitlQ1Z+nBIx57u4sN2MrBqDjIjzaubd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWUCV/nMTjhUbRl5CD1WNxRkHiI98XyKbyptn6qWkLccRUa5iJ
	Nwry43Zu+sKWF2OmXZ1Jo3oXoClt515yBzbctZ97EVjDRolPKfsUvur6O3HS0Mb9lAJ/g0iwaZX
	a2okVv5A5RycoQOqhkbi4Tvwsx77ayS2VAiyqfdVgU6ak2w8cVMtpN9s=
X-Google-Smtp-Source: AGHT+IENVGnXGP/szTaOFF3l8ixExEmfJzeszZrzEhNQFtrf0zBmFjgffCW64RLFf/aFcQsEEXsez6wa/Qx4m0ea8LQt6sj57l/5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180f:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a0c8ca77d2mr5551235ab.7.1726771382551; Thu, 19 Sep 2024
 11:43:02 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:43:02 -0700
In-Reply-To: <tencent_50B5A5988DAD922A5D9B5DC9190C4FB08D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec70b6.050a0220.29194.003f.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] BUG: unable to handle kernel paging request
 in bch2_opt_to_text
From: syzbot <syzbot+294f528e56138c357a48@syzkaller.appspotmail.com>
To: eadavis@qq.com, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+294f528e56138c357a48@syzkaller.appspotmail.com
Tested-by: syzbot+294f528e56138c357a48@syzkaller.appspotmail.com

Tested on:

commit:         5f567360 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17c8bb00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=294f528e56138c357a48
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11886607980000

Note: testing is done by a robot and is best-effort only.

