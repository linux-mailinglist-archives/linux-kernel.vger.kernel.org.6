Return-Path: <linux-kernel+bounces-239092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289BD92561A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB482834BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BCE13C677;
	Wed,  3 Jul 2024 09:06:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030F12FB2D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997565; cv=none; b=EevGVYqzsv435oOHGaFlH5GJl68XKZAED8CiKYeahruUGMfQ1ahip5Q4N6dfCYHV+Jf3RVrjS82Whgp8gbM06pwWDfDZbyQXkYqUHC6v59pEv7prUgnHo8shAr1A/FWXmTJkCqRTNzNOq+8UJqv5WxFgvyym6k4c1S97zHyAoL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997565; c=relaxed/simple;
	bh=Vr1l2U3eBTnqzsxDCqcTAZ5cvIklFERK98tJC9Rufz4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PhdFYuTWxrn5UXwYbjAoI3qQQ12QCCW54uSURUXNPgp/OSFiwX6qf6rqMWNCiLQRmNMxtGuluNT9tPQvo1XFWmQvOQnbuoNqcSHdUAa5Ba2b3hmjq9jszFv9e7mZmRVBjqsV6oYIvNZDS2QPO3SoaVDpkXn0ZgaGojNWuv4vSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f634e2d110so398401539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719997563; x=1720602363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcaP41gKHoKZ7Snwl/SclASTuBqrh+sczsT+8KG2Ojk=;
        b=qOc+49cV89Nv5ifsGkoqgH+Ph1JjAe97YmC5PYB8DQJS6DhFAiwOd/m2n+6VgvfT4K
         MRsds1ctro9JDyKe2hzigU36eUXkJLgSHcopwgxkxIGvkK23gIK2h4n4NfmtPDDdS6Y9
         V8aSikrI/0W/I/hk7GbmPbgEMrFny3Bgl3KbAThM8yMdfsyytoNNzyNrqjJNmUu6JGe+
         HeacqEXRVWGrcPyLR7/flPTXPjqcyqKkq6GnVjTxi1eTyuYDa+Mtc2tt559a3yyNoTO4
         GnRpH1TxHDe06G+Fxmi8EiZ6V2fad260TJtDKpc5bpKqMLtSxO3pxDRgrytU6otYkGRI
         FdOQ==
X-Gm-Message-State: AOJu0YxyILr1vasYhdtatKL97jEh1xzSycrlNrUGjWR6rHQp4upve6Lg
	qzJjBg7KPEwSz9e5SQV0faLLWC+3JaBgdsW6sBBzOVC48u4NILk+lrGypuQVAth2c4py+2SbnYj
	sIxWUhnKhz559o5Oh/LxQ7sXGAC5X0pwBoHyR4zcGog+08r87BXAwQkE=
X-Google-Smtp-Source: AGHT+IFWyk9Rqpi5vp2yhVXKEARlz0zNbzsxkZTJtujw3Zimwz+3SJtyWbrldy6yA3L6vNMqstedVpgF3syXqvb0zWX4nx+tBrDB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9806:b0:4b9:6637:4913 with SMTP id
 8926c6da1cb9f-4bbb6e52facmr674421173.3.1719997563325; Wed, 03 Jul 2024
 02:06:03 -0700 (PDT)
Date: Wed, 03 Jul 2024 02:06:03 -0700
In-Reply-To: <20240703082413.649294-1-radoslaw.zielonek@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6e3bc061c5423a1@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in validate_mm (3)
From: syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, radoslaw.zielonek@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed

2024/07/03 09:04:43 parsed 1 programs
2024/07/03 09:04:43 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
write(/proc/sys/fs/binfmt_misc/register) failed: 17
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed
 (errno 17: File exists)


Tested on:

commit:         e9d22f7a Merge tag 'linux_kselftest-fixes-6.10-rc7' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b30915980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1fd2e724dc620327
dashboard link: https://syzkaller.appspot.com/bug?extid=a941018a091f1a1f9546
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ca38e1980000


