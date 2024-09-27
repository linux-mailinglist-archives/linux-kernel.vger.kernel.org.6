Return-Path: <linux-kernel+bounces-341402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD76987F89
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE522B21D96
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F117C9E8;
	Fri, 27 Sep 2024 07:37:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3549165EE3
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422625; cv=none; b=UwY6DFNUuyz6Jr7kHPfW7JnK0MQ0/IaPwKSD6tusAisx4O6sXSshQXG52gv1UbvsvReeU1mdRqCw1aBjwwqN/4e5wEPFKClVEBKwTbkBokiuM4j60Cithq2Pm0VFMBgX0Fltu/T7/virEr6KRwVCWbSR753NXs8A4NCHDl5JgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422625; c=relaxed/simple;
	bh=pZ1uB/XJBjEl6D21v2+KHYZz/RwbUjAFWAp4RP1NzPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tyrP9oqcyKy7fA+fntk2evZ367Yfnaueuy5WrxbavMAGkhwKvWQif6DVfOA+ijkmEyaKwpQ5Gvj91dJMCJvLuVSILRvOqvSPN4TBj79X0XbdUyMqZX01uwO7NW09ySlm1GX5WW9cUNWhOj+vQzzBBgl6bfmxJC39KMZbLK+8q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3496b480dso500275ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727422623; x=1728027423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lehVuHc/G3YmOIICMpiPm5yqzC+B6vqDGq6lwJPGaz0=;
        b=a1c0wfsDCX6V1ZStdvnh5WdSsmfR/WE3Yk5eMquNVx34Na7FgWnv0Uhyv3IsLd5mG6
         nw9J5D/YUJyN4GEg1ZygUkWBtow+Y7PBKvDJk9My2Uq6ijT8haCYTzwbZTiZOI6P+sj5
         Em+Zpn9ILMHJZp3/bM6+1tk9EX2uFssS7ssjlxlrvPdIUm0jiuLFEsU8NN6E4OPIWe6J
         UoZ+jnlSufOFp0Y1+p5Y6YkmY2UvVW6iZRLVUV8puAYyVuJod6dsrx4WhjRXF1LksxaN
         IoFtM2dlUZaxYvW6YUtrfPoFKyp+GAYQ6fCkGW4gCptdI4q0S52TeAW2QcIZNojoZXDe
         nwjA==
X-Forwarded-Encrypted: i=1; AJvYcCXRheErOtWmZkYG7GaDtJU8/JXvyaJPWyn2GODZGiHfvXeuD/VtK8fJ2qxqwJyqqisCMsP17nW6i3v0O/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YymUCQkiKk61IHTdP1HsrCnbC1YlDgY5T3c+bW1buL/gSWJWXXr
	prHXxjXSrzodxDywo+pB9oKtMUXIMHpHrenkujkKxgUtOukVE7IiIl6t6MYYX4le1aqVdFYV9fO
	DIA5qQ5yMAaRYVsTaKRRTyfa5VLeN/qfksXgmW5ygQZR0GNR85cMSJ1Y=
X-Google-Smtp-Source: AGHT+IEpzlW7cze/+T+3UwIjnirvFs6E+EOntv3U7QiaD3/RHrulutVP/mU/HPA8uLNjjTnE+Ii/kMFgk68Gzr/2APctgN7uisyO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3a0:ab71:ed38 with SMTP id
 e9e14a558f8ab-3a345179e33mr20985775ab.14.1727422623043; Fri, 27 Sep 2024
 00:37:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 00:37:03 -0700
In-Reply-To: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6609f.050a0220.46d20.0011.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_llseek
From: syzbot <syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com>
To: amir73il@gmail.com, anupnewsmail@gmail.com, leocstone@gmail.com, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com
Tested-by: syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com

Tested on:

commit:         075dbe9f Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ce159f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=d9efec94dcbfa0de1c07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112c6aa9980000

Note: testing is done by a robot and is best-effort only.

