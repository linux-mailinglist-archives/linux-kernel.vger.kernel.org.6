Return-Path: <linux-kernel+bounces-260482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DA93AA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A304F1F230A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D38149C7D;
	Tue, 23 Jul 2024 23:58:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D34F615
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779085; cv=none; b=bzVSdYm9q3CnvurTUK8p3IiXmidoZVuTlv8kROGnrOliv9eJM9HuXqk/K//RQQrZZT0GveyvYKDcja/JZBMIzmaG45R0Te/JmOjsmPu4ZQjcwg8VJgZsSA4GDF2QO9swYpm0EWHy2I7mxBGHqe+uLsuhYJJGSfEvRXcR1Ne1In0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779085; c=relaxed/simple;
	bh=hjOYStjjoYX2np0BHeHR/g/Tp+auHJmuVRMt2T6GoEc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qq79yR6jvQsIa5jixPjbDa1FrroOGOh02Ji0LJK8Ty7pRGgmoQJK0f9aF3Eva4BEzd+ByVgpN1jg8VY78e4P8xQByIuupysL7GBrD4/NUYjhuxnWnBTHHuDUi7uzskDqhZobC6W2EKrFRRWjNzu82PozmIY6yuksoAbKinQ4hQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f682fb3b16so1072631939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721779083; x=1722383883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgOyZUlzEMZOpU/YW1FXvWk4x0U9V9/l/E3qzG/wK8Q=;
        b=mdde/uwezSBzGmbbJhzg4DzTcBIVo4r6orYZQ3Dct/0Ux6cu47NKHCH7gf+/UR/SHK
         PfDM6ShrndOhbvJ7sdiUTOKJcxIN2sjRYggVDmfgAT1vy8T+e0HKXVeZv+/49uVgG8Zu
         Um5YkYqf+wGRqQ5BRyVDxQngCCHZ1SV3/XNq1Kp9Ebf9kHzByHCJvVAQjkKqawq4jEVd
         XVqHpPLgRW4AZhB0EoIe0XmNIc44JiXwuyZ+JaMPoZzt2yf+Mnnv2RwxMzzCwwabKbCW
         /BFR9rI1JYEt+1TobxIFH+IhFyrkHmynSRzEdHvLFpH05XATrdPixF/PRBZBrOApHvub
         jtCg==
X-Forwarded-Encrypted: i=1; AJvYcCV3W9lXlBjk1je7tVhTzciDBaOyO+EPDtkSf7MgmOQFsjlf/KTQZ8M9rx9v2UjpxZoRYKu6lRpC8ES8m1gQir/kIPn8gTCS972X+PDI
X-Gm-Message-State: AOJu0YzTJzq9jjPAMmymeAK5ZzkYguultDewa/g0XkvMymHeJi1ky2sV
	TGfSiir4oDNrbFd3JFX61EHEqcXcgYDc5nisNNyr/FqZmBCqWWzfFFaJsk3t3pT7TYdr4LBMmwt
	sKyIMckGd7cTbuNVFgM3F7JCINj+Y5fPUsfm8Az5vY42xxr0fqcTtiVc=
X-Google-Smtp-Source: AGHT+IEzZornDDZMpWDzFdkE+q/FriUsjqZ+4sHmZEu/bJAB9hWGgnKawl2seZVupWtON8ikupSSpqqlgz3tPuyYT3PdwKwJZ6Lc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c6:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-398e7de7b70mr8748705ab.5.1721779083711; Tue, 23 Jul 2024
 16:58:03 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:58:03 -0700
In-Reply-To: <0000000000007cfb2405febf9023@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aaa8dc061df2eef7@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in attr_data_read_resident
From: syzbot <syzbot+33a67f9990381cc8951c@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d4adc3980000
start commit:   b57b17e88bf5 Merge tag 'parisc-for-6.7-rc1-2' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=33a67f9990381cc8951c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12493e98e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1334b4a8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

