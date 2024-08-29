Return-Path: <linux-kernel+bounces-306045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CFC96386B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E65F281EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB142A96;
	Thu, 29 Aug 2024 02:50:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25B168DA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899806; cv=none; b=WGfOVbzw+V56oDpHurg28BmASDvPK5lVgnZ5Pze7GhsBNSG5brb/qRz28FE+d/Tv+ETqVR6Xypn218qfSFjlmuQA49sjcYsM80kHd1KhSCjJQS18vWnq6Usl/wp9nPZ+U9JPtcmY9UYoCL/2BiNlP5dhRNSCFqbVQgTG/WkzUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899806; c=relaxed/simple;
	bh=IOZ/UkVQI8pJvAYRAU33owt3WhjQ2vgwE29jgljS3uk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j4Nuva651Qe2weVx6eFv3X6QkltHhnDX706OQMhsXy/CROyrWq6ZTYk4cO2dZVztuHTRR0/uyoDZv6ofDuXqLVBff5nI9xtRXhLBy5vpwcWuyH9m/fJg71lmCrArTVL8Oj7U72zYysn34buEsgTZJ1bPWzkCR5EHLKuZ366ddZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d465cd6ccso1669865ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724899804; x=1725504604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IH3ZkbBcqzZYT3qjjT4CBwqJJ8dycHwRO7WjygVcZww=;
        b=BiBlXeZlG7fkrvhmzJmt3GbQuktpIHJIEfkyJYuQcgd4XBRq8+S3XhijZiaKHWopoW
         bDNow+2ngGae2OXx/5wNOPbvC0e9MzOS+OXDYfADkYsVGtrGg3xv1XblCZs1tPEZ+V3w
         1Gqjl2fvZX7EViPhCAnWNhK8OmYkwy2Y+SQPFIh2hRhOeRqv7eVMacOw2TB8X8BcDNtc
         DLC1obZ7OGhIJUK1RjP+w6I/Tc2wf7EJuCTKSJttYsFVBJ+59fA01KvpIf+jN5mxubpk
         bz96GpTE7ba8feuNz4w0KQ4XMjPN62INUSfiYtEcwzjR126ADNKDdHZ/9CYU7vlXC26T
         qc/w==
X-Gm-Message-State: AOJu0Yy/jFDHNNe6gIqv4GJwGktddKslTYg5dATbpTODvtXTK5ZQYry0
	Pu2RuKwFsFdG0YW2uC452dF40wFuhyoBeK4IpZFbvDqBpCy6B62eH2VGIsoOVr4c278unppc5B8
	BFu9U8DOSTlSfL+rS+09YLwsT9v858uXm44BaezMbzD7gs96p5qFApTc=
X-Google-Smtp-Source: AGHT+IGBA2tgGyytBlh4YdmRpaD5BIrLKIwdnTtYgX+RnpR6WJtx6eDiQkXmJS/MCdgZ30RSSDz+cIKvau7Evu0/R2bBdtktajMC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:39d:300f:e91c with SMTP id
 e9e14a558f8ab-39f378896b9mr1360635ab.5.1724899804254; Wed, 28 Aug 2024
 19:50:04 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:50:04 -0700
In-Reply-To: <20240829023517.2159902-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b2c950620c98809@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
From: syzbot <syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/btrfs/extent_map.c
Hunk #1 FAILED at 262.
Hunk #2 succeeded at 493 (offset 100 lines).
Hunk #3 succeeded at 747 (offset 100 lines).
1 out of 3 hunks FAILED
checking file fs/btrfs/inode.c
Hunk #1 succeeded at 6958 (offset -14 lines).



Tested on:

commit:         d5d547aa Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=ba3c0273042a898c230e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1448bceb980000


