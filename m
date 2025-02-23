Return-Path: <linux-kernel+bounces-527811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D5A40FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D8C3B8A72
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B384037;
	Sun, 23 Feb 2025 16:29:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EA70825
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328144; cv=none; b=q+k7bC+cBeVQ5UiezflAyeiesNKdNVPnBNoaGN2J+Clnzpr6Unhl0WXGIKfCjWhw69Cwc/hP/JivkjM04cTwbv8mWC66CSrtwnan8QzIZ6HTWN5RJLs85Oo6JARL7TpYrdBaTykRvt65PZlJFKRlmeT05ouuKk08ZrlFmdIqgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328144; c=relaxed/simple;
	bh=BJJMIAODFBZ2zV28pMTXGqIeFv9HDdzI5mGygrT99MQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LlxDBTAjtgZaovsKA1eZkMHGp/I5snisGS0893ZKy6+MhaNafAyhWQ+J8sCgJVOIsetQOUf++hhu3Qf/p0nTNWfshP/lYLGh45FZRnRnOM0MJFAW+GbygMtfCZAQFq30HsmNrT5cNowjHW0M39RcfT/C6HvQT5TaZ++3kfRn4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso82021385ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 08:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740328142; x=1740932942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qePKE6DKwAycNvqydZPkWZJjbpYUhcvm8VYZZd2e7n8=;
        b=QflPZ2N2jhug6RYngBdWGW++tiBn7JlDwJ0jvwjI9iywKPHwhYk+tvjXL57kqKFHfZ
         nTqU9PbIkxXiECp5I4NBiX7urZpCffA0rnzQotL9nOly2ZALKYG/q4rJZ7ypNyDgtvZS
         A3mjpjKtQDvPoJMi873UeGYdNPrRWoEKtS/L7pYcTTxS/EPj3IdiMaVmCOsLcUkiMDmm
         7nCEe9f5nDkQ8qZLhwk0jvUR9gqp3oj1mtRJTCGn1W+29ACisaTDtl+itk5ZxVkQillj
         Ttbg9y1r81ObegkOlulHw+iJFtSHGvVZIa9WK2kmLzo/XCBnWAXPZyn8n2mCZP6IwDBz
         /KAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpmxSzxuaF7mRP2kBkAYYwy/qFNJ3LsTPcDnlw3if4S4h9a1T+VGGFNuvczlOXXCZY6V2MGKaP14jKkJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPa318bEQesQ9KMcPEnto/8Hb/PeRc3gOuhbKiHKgDTki+a7x
	NdVsP1SE8zH7HDytLQEkFeJnKWrIL5o+yADeDibOSMckf40s9X8lKkx07ZERFmrVFgoeqBGOAqW
	+IpMBMSWK5/8PjbCRfKE7Cwt/XKJlDrsvb8z7dbwksE24wOe9SftC+ug=
X-Google-Smtp-Source: AGHT+IF6ncIokCXD/xSm4YeShFCIAC7B7m+EQVnJ7HuY8dQfDkKW8DFwMJjcCjPOGWK9RChupBmxaF8xlmmMNx5tXa4n6XlTSQkl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3092:b0:3d0:21aa:a756 with SMTP id
 e9e14a558f8ab-3d2cae4c215mr112255575ab.5.1740328142383; Sun, 23 Feb 2025
 08:29:02 -0800 (PST)
Date: Sun, 23 Feb 2025 08:29:02 -0800
In-Reply-To: <CAMj1kXE1WgFkP5RG-VhC_P-gMDtyipW7nvE+i+JBSWXW1bqbhg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb4cce.050a0220.bbfd1.0032.GAE@google.com>
Subject: Re: [syzbot] [efi?] [fs?] BUG: unable to handle kernel paging request
 in efivarfs_pm_notify
From: syzbot <syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com>
To: ardb@kernel.org, jk@ozlabs.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com
Tested-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com

Tested on:

commit:         ec7518a8 efivarfs: Defer PM notifier registration unti..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
console output: https://syzkaller.appspot.com/x/log.txt?x=15dfc7a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a97cba3fb7e034
dashboard link: https://syzkaller.appspot.com/bug?extid=00d13e505ef530a45100
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

