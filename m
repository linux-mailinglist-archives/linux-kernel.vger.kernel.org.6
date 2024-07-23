Return-Path: <linux-kernel+bounces-260058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48393A258
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBE71C22B85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EFF153BE3;
	Tue, 23 Jul 2024 14:13:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173D153800
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743987; cv=none; b=rBXh2nL8UucFSk6VzvEwXs8TBURkLSMll7BbUy7o3cFROLhruFKAIb6eZ6cWpAE0Fz3wd0seGHYOxTangElAK2PhnobbjY34V9aw2PSCaZzRlOqjEtP+wrstdLOvxb0j4+TSp0D3mV1XigL5lgHQPT+mdQLMuJ9mSM+FFYOqPZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743987; c=relaxed/simple;
	bh=tAAQomRwAaMevkH+RJ7wcNKaxSTVnHyflQWlW2bqA6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rYl700tWZ9M7O7DVNCOB2ktrjntfRmoLH7ywGbb5wTbI5HKoimTOFfwM5WAqfKgueM9AwlhM8HAtNPLh9X2VJngosOl9r8rzWHSh/50yAdmVOk7osGNKv4z4YwyrkS40MXzxJEWcDeH6QvH1WSEnkGw5Cw1zHpintdWdhEOxYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39794551bfbso81832815ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721743984; x=1722348784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cISB2GK5OSA25zKofqCdqj+ZCNkXzh+b/9qF79GsBAY=;
        b=BkB+LNq+dg3iO/JO7ftrQZ1lodg/mWq3N4HY5k6+1TO1tkBNhx1z+2rnAzHlGqLqBl
         pvjXEfD/1FQGC305TUCTQF8HoaLzhBlX4c2MzMcc4TT0fQ7FKasio/fEtmvcUhzRIVdQ
         hP9q9fHchFsTgxwPBGKp27mAYw/5abkKmWKYBRaDs2gy7IWbx+3KmOGy7fyzgJhXJ2Vy
         jbcJfx1BNSWpQS8Ms2NYSKWbDPP0SnrGEay6qy930sgEevj6uPLqbMMTOqnbl3mFx4yg
         hTQsxVFdZlYmM9OUdi6xiDDmLha+zwE5rT9MVwc+DHH3HhtprGvJf4rDIv2+czdwcYVi
         wpKg==
X-Forwarded-Encrypted: i=1; AJvYcCUgjd1Pv4xRvQOFb0juEeoxZh6MSdlQ2zIAAgU2xDolN3huc/pKP7anTsmQXtk6kvN5+aBQlNhQ5VK18dmfIqFloc+Tje+OwjNnKOIj
X-Gm-Message-State: AOJu0Yye7TAXL4rlYZh/BMlWLQzCi+1UqCcLepmKNJCW+mo4pXLSNwpW
	2wWUuDh2T3ZLI9vELLkNKNUAN6nPtHxd0A4sPNF+xVc/lXv6mD2EtfjVRTr9UYNdetiU96G+aOR
	mdyKHps81UhKoaBZ8WbI02AccZYh1Kj2Y34l17cpj8IiAnrLms/6MYBU=
X-Google-Smtp-Source: AGHT+IHjRmxtTjrqYgE0pEXOkrdfPp1vTg7mmmqOIQa7uY2CEs16W4Rh++dtPR0fLR4AtQ4rmPLCzEzqf90n6fmNOGh225btZ4Cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d08:b0:397:35d4:3811 with SMTP id
 e9e14a558f8ab-398e69b1105mr9903165ab.3.1721743984237; Tue, 23 Jul 2024
 07:13:04 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:13:04 -0700
In-Reply-To: <tencent_A688921FDD9E5D95993ACFF58D87259B0D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000932e4e061deac28d@google.com>
Subject: Re: [syzbot] [rcu?] WARNING in rcu_note_context_switch (2)
From: syzbot <syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com
Tested-by: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com

Tested on:

commit:         51835949 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15eedb79980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28bac69fa31fbb3a
dashboard link: https://syzkaller.appspot.com/bug?extid=784d0a1246a539975f05
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120e5ead980000

Note: testing is done by a robot and is best-effort only.

