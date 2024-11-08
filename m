Return-Path: <linux-kernel+bounces-400932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23509C1421
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828B31F23B9D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664FC45023;
	Fri,  8 Nov 2024 02:36:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE5224EA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033365; cv=none; b=R7puy8PAXJ9UuFMBlVbeMOVqJa5MtajJ21K/oB641STccS5YA/ihV0wcstNe89q94RU7NtfIlJtRAc1ngF2cPNEhxNZEgOX5wjHgVpwqH47t6ga/oPKMR+2nH3P7GscW8rE2bnUOjvicNE8eVuBPcNW+yHaL/b6ku+8xxVkxlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033365; c=relaxed/simple;
	bh=0+TOCaRch+Vfh2oTU1KUZMgVxuUbpqVNOQo6XZU8Of8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QsTWlPSMVsgvxI1IsiBf7KstJu1CPRvmN8DMlmxKI2uucjvI0+hdYG3n2zsWSJKz1duTvfamf7TKFDbmI2Qs3+TjVRl/GZ7XQH29YvVKrGepY74oUsBBlHbGmucmfUlBX1t/7uYR3eAxRAJJ4x3e4UGzb7YUzrYP5mRXXHzTEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abb164a4fso174390139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 18:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033363; x=1731638163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crst2tNqLVEVvxQbiBDGFkG1jZ/8TxlmsKPddcu3qv8=;
        b=lvUgAKEX8G1TMmwhFIwq5K0a8w36Mt9uEQEjcdahVZSviRG3VFi6HJGeYCmspA7j3G
         vupXGI+rmTF6hNqAp6+8ffdppXRVdMcX8ei+QnWMecX55H9ItY5VHSOQW5K3HAJGLNBh
         VNU4jzJR+ZwZJEl6Y1pOb//98KFySJasIaqmSNYR/C/pu+Q47v7xngPCp31cv7+WQWWo
         CkDyRwDns/SU6Q0K5rLprDBNZHDc1Wvm+Hkd9rfz1iLXibDGOrXgqWSQXO5/SBjndRPY
         8y3myndUYQUwD75AtUtdfMkR1UUtD6PVg3O+hF+ywxsfm+fIws9OaS6BRieCRfAIRK9e
         2PWg==
X-Gm-Message-State: AOJu0YxE+SDAhRVT71d2GoN89wV/w9T7vJMHo1ypcCoRKckSuLTyLi5c
	tX+LNk7JM9TcDN+qWBFE2GF0aVdnJHiyL7AsqALVa8N2CiULb79JJoad6rYS44W3L5kVunEL+26
	R1ppkg4RD8TnupisLL7X1a8UF09f9UavbjuUuvarwxZZLlW5EhHoqsXM=
X-Google-Smtp-Source: AGHT+IGjkM9NnGBGiwFH9V6+P8yYwASJSexSpn8C+oOxy/Xmq8bxzuQLtMJhkN07EoU782ER3m/DlKT+961LXNGXdGF5tP9Nl8Ju
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d19:b0:3a6:ac4e:2659 with SMTP id
 e9e14a558f8ab-3a6f19c2ac8mr16463975ab.6.1731033362845; Thu, 07 Nov 2024
 18:36:02 -0800 (PST)
Date: Thu, 07 Nov 2024 18:36:02 -0800
In-Reply-To: <20241108021849.2997512-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d7912.050a0220.0db4.01b9.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com
Tested-by: syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com

Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162d6e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20d60fe605153ebe
dashboard link: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108bfd5f980000

Note: testing is done by a robot and is best-effort only.

