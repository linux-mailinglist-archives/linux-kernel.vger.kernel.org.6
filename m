Return-Path: <linux-kernel+bounces-539654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C170AA4A6EE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409E63B95DA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BCD14F6C;
	Sat,  1 Mar 2025 00:22:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18591F9CB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788524; cv=none; b=leQo/H5RwvmxJJ5ZuELvIV2rL72CaY3EMlzuayIZNFvHOzSzcys7JWt2nALKhcPFUKtEXLPVj0qV7nr+aseLxd0zE3JSo3z+Ob5dFuYKpQ8UcfWVs5q3J61ZJf/quh8cJiCpVH1Y3OSqWpMCZpk873G9du0kazz/r6xMYC7hpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788524; c=relaxed/simple;
	bh=d23CwhsVnNOdGWq6rbWCMbTUmxYX49JZJarGho1lNME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k8GX8222cALbb5IcDBGpX5kOSQ6yWyoGfS2i/YnMLpc/AO9jk9xyJcabfEp8p7dJg2Grx4vJN3qSafJeu6bT7msLt8JOtSjvcCXqsXv95aA54KBqipsXZ/hk95FaDqHU4iZi8OrWRuT1aZEnI2c4THcmiN6ZmlRQ4xrxe6Xb5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-851a991cf8bso294356439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788522; x=1741393322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnjErBV+M0/5ybVsx6d7eAIoc/JglLB98P2e5faRA7E=;
        b=gHgJ6SgH+wncJ7NxvSYhUp8tT6AChATZ+huWCeS0Jw+7RUIVWeTdjffjsZZec7JLi6
         EUDprS9Qe85jsD6YhA43KmNh3aFW+8F2zn4KhEhmDHbY3PcmYFoRtYQL9bO7bZDNRpV3
         TVaHBh9XurDIqG4dKoKhXdfIoyVM9CUOzU/HcqzlRrrSEon8PpNDx0GqqNl/DGsbvN0P
         +v2amHKS62hEo8DdEXj4GJanng1rAMXv695EEtG4Y/JgKuYLDWqKtuC7LJZJ9BJpkCmd
         N5PMRsAudCUey+hpyUpEHkooLfK3lZCTZu/b4GFSF21kZ1Dh2nUa3A7Wrut7dVKWfEIS
         PXzw==
X-Forwarded-Encrypted: i=1; AJvYcCV4e5Tsf/0y++yH4tnLrp632RtRHPgJlyrJCOpb+6G79GEdXnoAQY6VxyGfv60pzbHsrwIB6tcYA9aIQ7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1X0S6+Ha0kmXXPc3p72ARuIKVHpR7+SA4ooIIC2zS03nzGUE
	9MHRosXY7UcHcBdJ2wS4oOuGqzXaodsws6VZneeE7Ii78+gTpg7w86ERVB/rN4zBSbWJ3cux4Wy
	g5K3RQyNVUXS6rLDc3ATam5DoJnI7U/mM5l8lF2n6zfQLO9jootpFiiY=
X-Google-Smtp-Source: AGHT+IFK/+Voer3eS9nJJ3bYQfdwYAE5ugYuJdGLAyLLQCY/ACDcPRlCyhOrxJ0CnyTRZ+tpJBVu0AIj8ZAgaveZ2D5+L68bWSvD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194b:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d3e6bc6b2emr43948505ab.8.1740788522212; Fri, 28 Feb 2025
 16:22:02 -0800 (PST)
Date: Fri, 28 Feb 2025 16:22:02 -0800
In-Reply-To: <67c16ce2.050a0220.1baf.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c2532a.050a0220.dc10f.0154.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in invalidate_inode_pages2_range
 (3)
From: syzbot <syzbot+de1434c5355cc909b734@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1d16c605cc55ef26f0c65b362665a6c99080ccbc
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Nov 9 19:22:46 2023 +0000

    bcachefs: Disk space accounting rewrite

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116557b8580000
start commit:   1e15510b71c9 Merge tag 'net-6.14-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136557b8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=156557b8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de9cc84d5960254
dashboard link: https://syzkaller.appspot.com/bug?extid=de1434c5355cc909b734
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d297b8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119af064580000

Reported-by: syzbot+de1434c5355cc909b734@syzkaller.appspotmail.com
Fixes: 1d16c605cc55 ("bcachefs: Disk space accounting rewrite")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

