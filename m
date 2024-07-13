Return-Path: <linux-kernel+bounces-251281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018329302F5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB801F2261E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C61095B;
	Sat, 13 Jul 2024 01:14:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39B101C4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833245; cv=none; b=QZFjzDAFUBO6/ptk4Enq6nDEoiEizi+1CjAHqAhiEbnsuhSHYQlnRKvBQtNED2QFAF/FNouMylN33EBydK+pwBWDRSeAJfca7P6Cy8EfpJsngiDwoi26leH7hYR5QEI3n1a921BgvQ9SFAEvL2UqA4vKatiReHcLjG1X7gxcj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833245; c=relaxed/simple;
	bh=yLiGAQK6Mk7tGxmkVKJyPaPXikggUr9XMOUFb0JR8w8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eB7z7MVCRfCcSxiLx9LDJ4WKZ4xutRieNk+aE98/FmPN1RhpT47UiH3bjNohBlSqlvH4TX8NJNrJctXfk6dc526XAkHy0AZp9KgDUfU7g26R6CiICv3KW8K7jicEpmu5jBXHAqbx06Tklb/VGLESHGj6QCUGxEpOMKuYDzG4CgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-804825a316bso269517939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720833242; x=1721438042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMt0bLfjQZs0pG0t6pt3o4s1wzf1I7qMKCmPeA1/C1g=;
        b=ht0/2XqP7gGbysqNVlqPQFv68Tjuzl3SeApKqZWrYdeuCmB7ffjcScB+TpkHu36BZo
         CBq5L3aDZbPTjT8vrSLNf1veDPl7WdIelA0Xy/4gXzQ4AqdfSEzStjB8XM1HZHw8pKUf
         0S9vsLIUE6qZ2xefq+hybw+qFoFXSlebQoti1Er/r3b42BmpB/YEPBbqaVOVd6guF0an
         9VCjl6+TqgNdpxXMg/66GU6TIUQlnKPtGHEXk02RDvXI7Yo7veR7i6z8kej1Zfajb7+B
         xjVZ6vYYKSUfBYR45o8MvkipZcjiuGIL/SLxmjys8ZS075XNUxfBgcjrZxlF41GVlyGo
         XgXw==
X-Forwarded-Encrypted: i=1; AJvYcCVcPhXUqJzIxcC3QRhCHwGBL02zzzGh9Z4IKg7UZflTc+xqsZM2lE2Y6bZh4373F1a40fOMQMBaNK0oKw7wk28FHSni/LtiC/haVDrA
X-Gm-Message-State: AOJu0Yxnd+NbcRqKhduWRZYyLCyjy0AcB0Isqb7dsRhrJUigwOu3Wme+
	Jgeu+pt7a543IeGHXco1sWhNeHFiLGe8dl8iHUFlXO+0CVMRMcipLQVFWHffY83jVRPVS0qOKcx
	UZZaaEVFjhPOaT3mdEI2G5Yu6kcN7V5s2B+SRESBvOCMrMkdmTPuGUpg=
X-Google-Smtp-Source: AGHT+IEJ85sds476jL+rADZpYVHxVK9jM9usxvC/oiB7tlQSNRKkkuf12MtoVE8gxEQ0zXMwgKLp0AQspvwYoG1QLAHijypNfFUg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6403:b0:7f8:c159:fec2 with SMTP id
 ca18e2360f4ac-800050cc601mr82548439f.4.1720833242330; Fri, 12 Jul 2024
 18:14:02 -0700 (PDT)
Date: Fri, 12 Jul 2024 18:14:02 -0700
In-Reply-To: <0000000000006d415806048a9aee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000208785061d16b6f0@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
From: syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, tangyouling@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 86d81ec5f5f05846c7c6e48ffb964b24cba2e669
Author: Youling Tang <tangyouling@kylinos.cn>
Date:   Wed Jul 3 07:09:55 2024 +0000

    bcachefs: Mark bch_inode_info as SLAB_ACCOUNT

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113f4bed980000
start commit:   43db1e03c086 Merge tag 'for-6.10/dm-fixes-2' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=133f4bed980000
console output: https://syzkaller.appspot.com/x/log.txt?x=153f4bed980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141c864e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b1da7e980000

Reported-by: syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com
Fixes: 86d81ec5f5f0 ("bcachefs: Mark bch_inode_info as SLAB_ACCOUNT")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

