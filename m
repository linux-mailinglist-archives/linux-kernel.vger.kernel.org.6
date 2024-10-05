Return-Path: <linux-kernel+bounces-351964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D44991864
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB031F229D3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1F156968;
	Sat,  5 Oct 2024 16:46:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D88F70
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146765; cv=none; b=AvdS1WpxnFcRZUqZiaCC74PeFjBgZ0CYziIxkr+WnbJ3GVC1XYKxifO+BaAuc5CrEcQlhzPkkw1HomeRbr/ef4XYWEo7RFD2z8sQSo46RMmQiYAxXY07T/TNVFmJZGBBinyQQNDmZN30x9LBjrM5Rcr/087P/hyVvHCuYlva39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146765; c=relaxed/simple;
	bh=N4+9eDhAiNy2e5iD9XNdnPLXGDPzbKIYlzPHPZvnZqI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sW1VW1yJgPKYDmLFvIi6tE4vrtmKXZDMBoBY7Km3xoyFrbMLMkkocVnW6az8g2YrQuNQZvUUGej0w0o1Hscd7MEbOUA7cl99W5KYWosshjtPJvNKFpFMmjT04iA28NNDX2k/7rQ5oWwlkCM94Tf4bdQm5HFlUnA0oOaj1ANY1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a348ebb940so33456405ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 09:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728146763; x=1728751563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68ZwIv7g30+vGS9vxVKNzk46cmBH3f5PDAU+ZhypUrc=;
        b=SvegRRG0lHK2PoKqsh/fbAZbXyS3tRF75YcHz7C1JQYScTnoWKpZ0HT6wjJjdXaNZ8
         77W3MVS0sMdS61eEndINka3bcgpPVLZIjZdd1Eck1N8Zz75r35Q5O9xNbXcNTDY+HGUL
         EmaQ/fkGDjoICRkFtqkmbDpRQcaoRaCBSyTuDGu0I4kpBjosmYuObaj6oXE4gKPPprn+
         DAnm3kmt3h3I5jMeulM4SnO3B3SmnnwlYGb4eZy3AuuEk4XmI+74/lwwfVu+ETjmtgp6
         oZuVEhTPB8x3t8pRsU5vU2uDY24JSTMF6bUTiTs01kwKv+z21fjxNkIu5QeLw4PA15m/
         Sdsw==
X-Forwarded-Encrypted: i=1; AJvYcCXu5omS0DPdK2m9izQx2xtsZ0FdRLTGmcoDOp3yq8KK0aZk8qUTcG70cqqNBUvD83d1WzhMavbO6DFIpHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYAYL9XflmaPsYUDeFLJMPAuB/rPaJWdw5DluP6mu6ePfEAfD
	KpqjtfoRUc1S1/UW2Ptk164S+bZy0qsygU0DEYte5IUFb3PxZsVYDGZ7xfCf00QGSrDAntdJ51M
	N4O03dfJHtyK1GoGd0JlbAWTowi0Ei0TQgSzBWL3VaTM/Fwn57Zv2z60=
X-Google-Smtp-Source: AGHT+IENKnJpo75wS3EtRYAKZr3l1ybivi7xEmOdy+pzZ1onge5giIFWnIRqyKkGXzVCDZXVpuSaCFf6fS3LtxHNYNnqMNp7w0j8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b752:0:b0:3a3:778e:45cd with SMTP id
 e9e14a558f8ab-3a3778e472bmr38289125ab.21.1728146763281; Sat, 05 Oct 2024
 09:46:03 -0700 (PDT)
Date: Sat, 05 Oct 2024 09:46:03 -0700
In-Reply-To: <ZwFmiv0lqP02xPtq@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67016d4b.050a0220.49194.04c3.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump (5)
From: syzbot <syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com
Tested-by: syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com

Tested on:

commit:         27cc6fdf Merge tag 'linux_kselftest-fixes-6.12-rc2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11923307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cf7bb3f15c72e66
dashboard link: https://syzkaller.appspot.com/bug?extid=aa0730b0a42646eb1359
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bc7bd0580000

Note: testing is done by a robot and is best-effort only.

