Return-Path: <linux-kernel+bounces-278443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC994B04E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA77FB2746E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A4143722;
	Wed,  7 Aug 2024 19:11:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540D142E60
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057867; cv=none; b=AhDas6mty0Fm71eFbHgRj5V55P+DHNy6eVb+oTssJeA17Fii5TQtA8z+ACHOUTDcHbyvZg3jeqcp0EYnoMRoIg2D6gEOgdCHe2mrGC+8bferHjf01lflCavg3gaoZcCK+L74ZvAsIrIq5KbV0E1Isw3pIKugUyofqe5I/NMk79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057867; c=relaxed/simple;
	bh=edQZY+HEh7NSyqd6PRx48CtqoAKvZmJ9AZfS033ky2M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=unLz8LHhpM/zb+cgXFC22rA+RlYIx0MyhPBuIdTciDjcHcLyP87AVq/2VHSmNAc7ApyFXbAIZUByojFe8/HYqeG4wgnxxya1fJ1EBEkp9F39usSSFY/188jQSGeZ3iBuJgUDd/yFmF6aHBrETAYZHyw7FPXQlDpipcqCuGjgpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fa44764bbso14547439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057865; x=1723662665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQH4y4wr8mJmKYV1S0IBeKy+LI+j3z2nIoYo5HYB9PU=;
        b=QTx5RWzTzYU5yKEw/M1yYPQh/2fLW/NqS9o6tS49k5iSR3vEYFeT22oSnI7Kj2t0VC
         uH8I2cwPhsGzzGJdYH8DlEMhNqe+yRE64a/H3a9b0j0ZaBOXvs8Ic5c6jXlFoYYWk/jM
         eHqwTV0Rs6LBPxkw5G3ACMRgfsaEx0NgUxMwA8w/Lxe3oY6Eb1BbVVsOPITUmV2pvJLS
         elW1DZ8up9auZznU4Df4eMKaPUOXLhWRZICG94Hr4ghSR/u4z0Q/5Ox/BwsSI0iKErNk
         dNWs2lepOR+4jLhYZftXE0uhR1F5Imi8q4kHcl+2Gcdp8XoShaYiVQI7/MKq9wZuhb0v
         UsUw==
X-Forwarded-Encrypted: i=1; AJvYcCWwapeHlSVO3t5bsXJ861v3MXH65gQnm7QMQQSVpcGHDkOuv4uqHecp7MuoJc0c4H68F/5HFQ/FLLbnB/Hm2PGk4oLOiwwBbHTN0a+W
X-Gm-Message-State: AOJu0YzIGudndaNasbnoo5oj6y0mbH2YdmuHNqVwTGDVYcrKUfJjvsaC
	YFuXcdwyBtHZhzl3ilntyCwbBakoVNlUEnpSBTJkIH1xO0QtZq6UoHTPn0HMOOKl1k6+iavVe4Z
	YF1PF/QZsM8MmG7jWRaNe0Z5qJ/Ul9axyM/YWw1sdydlfWYjQJ/4kUOc=
X-Google-Smtp-Source: AGHT+IEfFm6JcCUR65IkobHJhRNcofCU56lDET385lYMoAw7DMu2C+Zo2AHZEw+5J4RDmbSL9SGc+bA0GjoI/1BvdXb71HfEtAqG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc9:b0:7fb:ff2b:5116 with SMTP id
 ca18e2360f4ac-81fd43edd24mr52266039f.4.1723057865411; Wed, 07 Aug 2024
 12:11:05 -0700 (PDT)
Date: Wed, 07 Aug 2024 12:11:05 -0700
In-Reply-To: <000000000000795a2506196e7cd5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fedffc061f1cabdf@google.com>
Subject: Re: [syzbot] [pm?] INFO: trying to register non-static key in netdev_unregister_kobject
From: syzbot <syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com>
To: chao@kernel.org, gregkh@linuxfoundation.org, jaegeuk@kernel.org, 
	len.brown@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	pavel@ucw.cz, rafael@kernel.org, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Sat Jun 29 04:38:17 2024 +0000

    f2fs: remove unreachable lazytime mount option parsing

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137e8613980000
start commit:   e67572cd2204 Linux 6.9-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=27c3c57b78da2a0995d8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152ab240980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13274a87180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: f2fs: remove unreachable lazytime mount option parsing

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

