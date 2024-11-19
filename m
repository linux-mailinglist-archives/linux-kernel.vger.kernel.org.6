Return-Path: <linux-kernel+bounces-413898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF89D2066
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CF4B21BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC014EC62;
	Tue, 19 Nov 2024 06:44:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D5211C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998644; cv=none; b=gOjFMVfVr1QWU8X//qf9MJLEMvT5ioukeqRNQk0+OqYtklIAJ6IPwbIT1YbuYb9mcz9jigWc6Ytu58Ul8s2J3MrQ4dEczM71rae9SxLe3IDqbG0L6HD9oZhm3OJaz6gNMcRYOfAuTniagclkDQQmhufAKpLu4EAXuok+I5J3uRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998644; c=relaxed/simple;
	bh=aAuv9/IeGR/LfrgVFfr+pRzqu7S52MQUtQ7SejkZabg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IOS1/1WOSm3yCy6rumC1i2EjIPvAcBdJj9yvmVOpO4QsraV0L/VibxT88o2NRQNxNB9pv+N2qjUNIRPWR6FTUutsHkkE5iEGNXCr5YcCy1McxbpLGv+TbtQGa+11zSsvwh/B0AT2jcmlJ9eHoOhxGxNXxbXEAiepxLBnH8oPbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e07db6451so269408539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731998642; x=1732603442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oG9V4YvJUiC8pbmaHtB/iX38Axa4HyEd1TjiGbjzM7E=;
        b=EDVxz+So2KRJc+DE/P2N+Y45h+vbAWk2GKPan14FwkD/9mIjzagU5WXECUoVjGmWD2
         4qHukoysvEjxIjUx36Y6izIpUEblweYQi4pfPOlk7pIVKU5hcWCkZpKSL8HYs/4GZzpx
         vsxsTetGDseMo+pxHSKtG8GLOBQRyAj23kjNzZtYYUCtcVqh9cf7VDk8qe9RNTl+YYQt
         +a/b5Pga5myFJ3O/hN2bRtHgFaFnsHJ9mEoMLo/DQfI5mMtsPeMD2GbTtsvwNdOOKEZh
         1Or0s/jwICwo4euk+nTwNAOPb2Lqh+sTOIEWXSiQFKXoZbkBSIF1r/MnqoBk4qASjU9a
         l9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPKI64LEiV8/Dy0ylhkjY1Ldh8AWshvpE2QUHMMtsXBb23yp1mZsklaBN702vpDfhvocAVPsmitlFfpuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tD5PcNEkQMDTa7orOl3hC33+xTGRSQhpXd5p0lhdpoPER8Yu
	l4GbVg/uRnLugMe4356mRD3aLUXb2XZDjSsmBXQbliP7exBb7IWccjLUyYE17cC/XGMZj74M6aR
	Kx5L+hd18F3huGvwLtUY0QcJEVs0qMJZnLc8NGTdH/kf0jO+lnf+aZXY=
X-Google-Smtp-Source: AGHT+IE61VJbgWGj3oe7ZHu2F3UBW8e7w/YpDea6q8WOfV1opIRIBTpcZgIw48BMGeJy7Cv0j3zUc1pYjj8RhqHbaLDC0CnJ7cr8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3083:b0:3a5:d2a:10e0 with SMTP id
 e9e14a558f8ab-3a748002e1bmr167305335ab.5.1731998642515; Mon, 18 Nov 2024
 22:44:02 -0800 (PST)
Date: Mon, 18 Nov 2024 22:44:02 -0800
In-Reply-To: <20241119062434.w0Hxp%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673c33b2.050a0220.87769.0069.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in jfs_error (2)
From: syzbot <syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com
Tested-by: syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com

Tested on:

commit:         158f238a Merge tag 'for-linus-6.13-rc1-tag' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14f02930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e547da255e4eefa
dashboard link: https://syzkaller.appspot.com/bug?extid=5f0d7af0e45fae10edd1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1087f2e8580000

Note: testing is done by a robot and is best-effort only.

