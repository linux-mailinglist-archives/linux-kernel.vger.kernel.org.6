Return-Path: <linux-kernel+bounces-183372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF0A8C9824
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 05:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE841F222A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71409F9C9;
	Mon, 20 May 2024 03:09:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8741E542
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716174545; cv=none; b=F2zxH1OG90emLezlaCHir1bMkMrsHbosqkcqDsNd9RW8Ruaabl02N00um3zkzivtAVF2OQ1zvBuIi1d2yEuBCWpMglFSL0EwSpCAHWrWnHUBKjeuBpZhZ2HvTby8MhKYMftrwaEJVKfsk80VmntNT/4+WW3MzDz7rs6EXBouho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716174545; c=relaxed/simple;
	bh=ZHVC/eyi/yUlJklUxNF6NQ29p9nM6UBKDBd4KHg3cQA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cwch8MrjX1U1IB4Zv45Cq6I43XSXgjZSx2mZIrRdYoxSgsSUQsUjm1b+eOR9aHAxdE+zbyo6bd+s1X7DFlSsUDzVcR8KUJ79QICbGgatUlvZ3ROBVIW+HEqzDvYxgbtIlj+KJVSH3rtqq8l1UfIkZCksO18DYtlgzxjnZlS45TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da42114485so1292821239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 20:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716174543; x=1716779343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMsdZQCNJyGeCEZLaOVNh2MMF7219gpnRuungey/28Y=;
        b=WvcMzrJ2PMMfudmuE8s0+IY/sNp6Jhs4IdOIvRFAVnXRIa+NSUJK67jBhTA8DGNPZA
         3cFpwecw1wrHM4swoWdT/2Pw2QFbmUa5xeQJpTXD1M6UJuEMf5Q+GQG8CU0SlibPIH2z
         uJhjv1HfLX9Zti4XO5VNT5JCZ379qWR3rUnxj+SSv1jeUTLU8/DHToaHkrHuz4hRoDvQ
         n+4HZTe+/OhVzjpwfZgCLZ0zr5eS+PARYn5n27nk3LXA5DuDA0XyanSa8rvLymENy/9s
         wgQ8mtHYma4aMR4L530Q8DO18B6SGETacVOVWh1aCgKjiJ/Mf6lXHXS45qm4rVu9e11c
         HPyA==
X-Forwarded-Encrypted: i=1; AJvYcCXs4n4PHDO6gU8RI8w+1xBG4twnDiSF4Hx/S3VoNM8o5Ara/rc7eNTuKYSC63xt8zfzu/A2R1EhHBavcLoHZzbUImhGDkUOwnfAVHqY
X-Gm-Message-State: AOJu0YzKToKcw77fw05/mhui6nmjy6NtbPFBI8vWf0ne/LV0tr5Z31Xz
	C9+iiNukvI5hpf2V7Z232XX19fKqSHXTnp+eamdN0Qx+gokyVBAWGXeueJyj1KN+i1h1PPagZ2/
	mV67hbAbRVXYFacAW22ifs7foTB86qbqEG/6XufQ1oHu9eriIbERhC4A=
X-Google-Smtp-Source: AGHT+IF7/yfykxcvOCDWvZmAzpX+X1Cn9FJ6FCpMoOA3k5i6hbUqDasyHio+xzb4A7NnLnU9owkLhBHHU2apsLT+s1DIUlKsGpMu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a9:b0:488:5daf:b3fe with SMTP id
 8926c6da1cb9f-48a04b7874bmr1559199173.2.1716174542422; Sun, 19 May 2024
 20:09:02 -0700 (PDT)
Date: Sun, 19 May 2024 20:09:02 -0700
In-Reply-To: <20240520023224.686137-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f95dc80618da05b3@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fs_journal_stop
From: syzbot <syzbot+10b936c5eaee2819b49b@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+10b936c5eaee2819b49b@syzkaller.appspotmail.com

Tested on:

commit:         c7596217 Add linux-next specific files for 20240517
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10a2eedc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fba88766130220e8
dashboard link: https://syzkaller.appspot.com/bug?extid=10b936c5eaee2819b49b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110469e0980000

Note: testing is done by a robot and is best-effort only.

