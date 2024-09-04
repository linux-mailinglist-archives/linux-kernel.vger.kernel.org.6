Return-Path: <linux-kernel+bounces-315149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A61A96BE90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15042284FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA8B1D932E;
	Wed,  4 Sep 2024 13:33:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE021433BB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456785; cv=none; b=GEAXT6O3vDPNdLjoyKRZLLhnkdXswBy4UL4viliVoXzoMHyb7Xv+LhnetoWmYrTW7c1fGZEsRSMIqrhlCFrzUi8z/ZcG+jIsgg8Hph+ZZ7HASjnuw7qvY1Tfy0LaFVl2mBNz23EA2JAbRZZdLHakTRJc/V6GBspdLAFCp/DESIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456785; c=relaxed/simple;
	bh=8XyjIeJP/69tfec6n0CteUTXKrXNFubvghLCQzIFmD4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oU6ExDhpAI7qgnVjQoTQmi6IWLYO50bH3MvDm1geNvyfOvB1fXbJdvvH/qYllNyC7b+hhtM9d2eFlx9TRmsa3uUjmWSbD/LUObT4GTToJoA5M+jXEbD2JfcBSgohqIh1FulLZxiQdFDac9W+kVn7fKBRpNWFbuufEh+kV02VbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso7813605ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456783; x=1726061583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZWNK+6ZKtX6J3rcFlU9bLRhlaWqG3Owor6zKqfdnyw=;
        b=eE06mhD+gp8SiLr8M/rsGwp5EMsgsUaT2z+nlnB5iN2Gyzkq30ClIhex6k0Kq455hy
         Li0HpsKRgodLhpSpSCTucf/whuOWhUBK6QAktRckRwNYJiQPxVJ26ILs5/tOicf76l/f
         H3yrP27HNazFIxyEcU97s1htbNkwXWoSrZpL7Qu2inHTSRUnCRHVMX5NOtF4p5aq0X50
         lUlfRagXFti7ooCUp517ecX+urVN5+Vp/4vNX2Mx1pnkeaHICgDjkGoRx6KQdxCpgpgx
         aJtWnS9BeD/HkSX3QBCdAG0pmmwFV6KSfL+5cP/706uuogglLbXn3TBtgJsx7A0nEYXE
         dSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEtFKLyWm6UnRH8cvQ3rV8dVcobJkr3z6O5pf9hvjQI13bezXGNe+29xYChuPjxxDY6Tol9ZtRnl+2QJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZS+/J29FBRiShLfIc/ww1ViWohfBh59BccUQU2zWCzoZdyUAw
	f3nfoOKjljL5l5/HUhu/xIC73xfOepi85LJG/nSI9inZtY/66+QyR/lA405HrEWFjuzWWARGOZd
	QgXFtaYnMYu/RUQlsdlZKhk17YnVF6INAikzYaV0SFQaimlK7gi0FL3c=
X-Google-Smtp-Source: AGHT+IGTxJC7cQDHpUUK/M/7oI/mIu/+T2a+XqRRL1jD58V6Bk3wphzd8zRzTXzULvMkUFy6e+6ky3bDYfM5eYHTGsYcJP3K/n9D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13ce:b0:829:eeca:d4b8 with SMTP id
 ca18e2360f4ac-82a262ff6f1mr59727839f.4.1725456782846; Wed, 04 Sep 2024
 06:33:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 06:33:02 -0700
In-Reply-To: <tencent_CE76CFE28DD5A5A20DF7121F5DDBDDB71907@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e05ab06214b36a9@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com

Tested on:

commit:         88fac175 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ac62ab980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bf7f2f980000

Note: testing is done by a robot and is best-effort only.

