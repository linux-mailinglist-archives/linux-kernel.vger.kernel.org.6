Return-Path: <linux-kernel+bounces-263817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECA93DAE0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE8A1C22662
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5287150981;
	Fri, 26 Jul 2024 22:57:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443514A0AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034626; cv=none; b=qWSG+3sUQacLuokV1Z3Guct6JApVkQrZZi5xtLjtwjwXoZSQvM7c5+O4UcgvH4oIFzSYSHgAZjT+oNazDLWDa21yJs32R2QlMF3jqBNDv38A7ecmjg7Irl3Cc8NdZxQUcLsW6Zzj5Qv1YYJrWv0XS0Cxfe3pqHyXqDTyg830TDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034626; c=relaxed/simple;
	bh=UhWI7TcLxejpJoI+IfqhEmkIioV4bu09QRF+kzi+Euk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bq0jeNdm+sRGQyqRnhv+A+HwdjgYcod+SzEJYXv3GXKK2QAl5yQy7lqTeI56nTWz5Ix6glPKMxV+SgxKu7e4mkxyFYmlLuJplV7yo/Ez81GaZgaXwtKCjnva2icVpRN8bkY+Uaf0QOviQeJmanpDuqqeppp0EXZCHA9Qnudf0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39915b8e08dso38098975ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722034624; x=1722639424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfHEsQdhoJOdt0CYCZsm++AlvwlAzWoJHsIj6s9Xdbc=;
        b=shmw6/kP6hw3MiFiimaSE7FS7aLiXw/Zjsvrhn4XTAMyBpDNH5yQuyeKD2IEWeMKtP
         tfQmNeBsPVy3UgCrpNL9MR+gqJ+i8iNDv72uIKYihRSly9CXlRNuu1qeXhig+ZK/tao5
         3TLV/EElXkEC1urAo76O+pbb7RM+YA11vpoWG7Zpda0FT9WoFB1BlOpHdpSqc2ZgTluF
         wrJfqocnoqZHPJZ7f7movXgfRQ6TY7MgN2yNpileKQJFS0fi9HiGbT6nddgmEIMB24AZ
         sX7CoKYQpz+69D5ZuSOTxL5v1+DN7UFmXsSF1E891rSI/sMvSDA/JZ9TI56Xjk5fd6RG
         geVg==
X-Forwarded-Encrypted: i=1; AJvYcCX4hxghvJwZa08SgFeBBwFpDe6O0+Zy4hngvPA+0GfrqXGn4mxgsOcmo5ph7GR55lsLj5i9GqTJzAerpznnjah8mWe2ogj5TMcWUqBg
X-Gm-Message-State: AOJu0YxtY+So5BpdLqu4Jf3FVvR3BlADYSL0mGTSAE/qwDdgUFWC6Npp
	YNHK83QrKRPWAjDoQDUKRQLDy8wh/IdzXxSu97AF5npUw4Ac6UQVlIQsSQHlFeeh3YC759/7wle
	EEp0RlKBI5fUkaSxIhMdStiB8c0ZBJ51EcbDaONs8BFHpCwzWl8ClulY=
X-Google-Smtp-Source: AGHT+IH1IGReWJjnZICMOV9b++BLUObuYL6w4gT4mDFAVD0lxxD2JZLW2qTvQ0IOykja3TBds2LleQamC0YuWT65jexcIA8WcgEY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39aec448e1cmr647105ab.6.1722034623729; Fri, 26 Jul 2024
 15:57:03 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:57:03 -0700
In-Reply-To: <0000000000002b27c60592b00f38@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009e19c061e2e6e93@google.com>
Subject: Re: [syzbot] [input?] [usb?] WARNING in implement
From: syzbot <syzbot+38e7237add3712479d65@syzkaller.appspotmail.com>
To: andreyknvl@google.com, benjamin.tissoires@redhat.com, bentiss@kernel.org, 
	jikos@kernel.org, jkosina@suse.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	n.zhandarovich@fintech.ru, rientjes@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4aa2dcfbad538adf7becd0034a3754e1bd01b2b5
Author: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Date:   Fri May 17 14:19:14 2024 +0000

    HID: core: remove unnecessary WARN_ON() in implement()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a010d3980000
start commit:   b9ddbb0cde2a Merge tag 'parisc-for-6.6-rc5' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b89b61abf7449972
dashboard link: https://syzkaller.appspot.com/bug?extid=38e7237add3712479d65
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eebef1680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1375f9ce680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: HID: core: remove unnecessary WARN_ON() in implement()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

