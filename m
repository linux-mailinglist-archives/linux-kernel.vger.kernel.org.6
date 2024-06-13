Return-Path: <linux-kernel+bounces-214092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44AC907F40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542C5B21D53
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D083C14D6F7;
	Thu, 13 Jun 2024 23:12:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452A13BACC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320326; cv=none; b=JaUZnwfKXRJbul7OxmXGW3EYkONMysb9aBDDKGbIIleygGhBD8DD7WTyzCIg8R7VZ8bTyYEbM4/azj8CNXHBfrjcSHhd11vuaBMkK6HOdQBVAMOE59M5wU/3EZcX091wnjg7jiLbUbc1zBOWjrvVrBe7+noRmdZF0u+c7fh9Smg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320326; c=relaxed/simple;
	bh=QNqURixh8Fje53lXdV7hN6YbYkm/MydFUXNWK8WxYl0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UYM2v+J8i8Iaqn1fZTFlOQEac69bgiePxsvfhslri4TJPGbYGafKc3dcjjGCL9H9r/c0cS8G9vkJ/rOXXlxMEuv30N9F1aWvmah+5+bGYmgz+uSMBXsi7UgtkCPFpksxlYfD5kSdctkR7eLupdb6QcQWq/hVd2EPYhBIUefFjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ebe8016637so71370639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718320324; x=1718925124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7fFtA25CoEtAaX+U1cx0JmWVM1XypkM3sTcwXensIQ=;
        b=B6XiEao0vGz9b/koGhkqbCkGrm7pVYsZdwlzfd0jdPWXf/TcQPffeWz8LsFDvEDu8U
         iZYJ28eJQSSch56YyKWX2SHhE/eS9EdAtceHTySrg8hnRC2UV9VbASU4VLsbg6K4vHBV
         Qp6YPGdpE6pk50yl6zCv9l8bzZyE9PRUVJlNi7QfBNTiRJx8ebmYXKQ4iNOFAj3ZYkCw
         URL9kwYjel9Qec9Uurbglo/WHkIeLSYLwEUhEKhfjU8EXb8hm1VeY1mGuuAhoevhoJNl
         CvdI0sPPgUHBrnDFbR/smKEJSJeOzPiGM0Khcy+suBgb/M0geCYevmhFsyEndF6CXtyw
         qNKA==
X-Gm-Message-State: AOJu0YwiUyfS0QZrUrbflt9fYflIJcyeIp1IMra35uk9GPCSSVL2QlSM
	w00GuS/tGtJj/PXP617gZCvsf91ie9I/S2bHe2vR85LIIUTriLmIZFObQjb4UjZiFEwww5cyGF1
	0wtSbDNwmz76x+1v27id9JMTr8YlzaeS9wI9FQgW1vNoX+oiRJHiZ/MU=
X-Google-Smtp-Source: AGHT+IHSHoX2/TaaxJxIVA1iM1SBnCxTybppMGGJsUe/HitmXpA/si7dc50mU4E+HejBFzdiO1iyz/3+mo+UjNspZHYn/l7R0Eca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca4:b0:374:a840:e5be with SMTP id
 e9e14a558f8ab-375e0c4c928mr387245ab.0.1718320324384; Thu, 13 Jun 2024
 16:12:04 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:12:04 -0700
In-Reply-To: <PN2PR01MB48918635B48EF9B5FEE3D248FCC12@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ba3bf061acda0db@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com

Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=1403c99c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ad6a8768920dd4b
dashboard link: https://syzkaller.appspot.com/bug?extid=1971e47e5210c718db3c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c6e77a980000

Note: testing is done by a robot and is best-effort only.

