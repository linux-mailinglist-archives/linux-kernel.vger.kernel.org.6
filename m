Return-Path: <linux-kernel+bounces-174126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9A8C0A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75051C21219
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C514831D;
	Thu,  9 May 2024 04:38:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1A146D71
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715229486; cv=none; b=mxPJJcugMrTJgFiBgpU/mvGTgugJy2UifPIDUpMvgEAX45691vciuJTqDRcRUOXYRjNZoKHzDOaqyjk/kz82PrVaVJoc4sJA/O5PMGLYJtEtNyYgC2tdIWeUMWZZSfdUykGLqe8eoYU7uz4yB7bTK49f87wROoVY26xsHd5qV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715229486; c=relaxed/simple;
	bh=pUNpzQmooa9t3EC5wo1pAudGDperB37uCycKfGZlJ6k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iH6BW42tLZCw4MavR1KeSBr3ZGseiDRKApT/6yVHUXSYe3abwdpYBBYzPmqyqMtYXtQLI9V0q+v05fs4/jraXiZN24BPdsM/XjH/qAfd9w782yv0DIyYqB9z5dDHKqaQ73Dg4I7Z+PWSna2mrxgoUBPIj1of1fmgZbkghxb72K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dee502fae6so43406139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 21:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715229483; x=1715834283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmSTCT7kz1F6whwxOWDEUaQntnt/cGoFodZC0HLVcFE=;
        b=aA0WjqAKQzY4DvqGIsy7HwiQqAj3cdoMFtVmnITzRLKmQ3atVg1UUf7rv1cknmLh4z
         PZrEg3DsjBTckkaPPw9zDuOEuPLLpU0AL2fZn8SklhZkRjUa4bsnk5BsXm4BU6y2nYVZ
         SDcK94zMROjungCrEd/IDGxma8L5e4zycl5I6Tq9nUpy1pN86lzGWUSVpQn95TSifNvX
         tIMhqtqKhbzWXlRYdS/tjENHDet4G9AVlqf5UwIPdQx3TM5lb/dKAea6bwpr3wUbKmhi
         Ap7DtGHd2a2pCMo270sIg5lamuog9KCr+W2a5JO+JbhrN35WHUno6r02afIRPDjgNWhN
         4oNQ==
X-Gm-Message-State: AOJu0YzyGhSYMdmNzpjFbW2r1X+DZeHIdo3LUlsGWBCbMp7I4UKsp2Px
	5yYfBssr/rQ49xs61XFDwheLh5IXIvl7lcs6t3WD57iFzHL1tKzmuI73zW1tqqiapbuv5c9z0U4
	jY8hphO7bLOLASAnegVr0xPKcsvl2d4hmzbtZBaFnvAHTNYuqhvV055Y=
X-Google-Smtp-Source: AGHT+IG+ATVwJrcOMTMD5oIUVZZQiO8qM0LsiwB4XtozrDZnsv/++4i5vAeznyGWIYRwGjR7P4ZbNy7R/ntMlng5FdljyRIIEbYY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8421:b0:488:59cc:eb5b with SMTP id
 8926c6da1cb9f-488fdad6a8amr263304173.3.1715229483518; Wed, 08 May 2024
 21:38:03 -0700 (PDT)
Date: Wed, 08 May 2024 21:38:03 -0700
In-Reply-To: <ZjxMF3ra7joqiJY2@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012dea30617fdfc72@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

Tested on:

commit:         4db783d6 ipv6: prevent NULL dereference in ip6_output()
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=13d96604980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7da3ffba7152e6
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ed934c980000

Note: testing is done by a robot and is best-effort only.

