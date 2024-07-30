Return-Path: <linux-kernel+bounces-266732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D545940603
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9BEB21FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BF21494A9;
	Tue, 30 Jul 2024 03:40:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518D22315
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310807; cv=none; b=k1BtiMsbzkNEm10lbpNV7rciIo096x7rmf558zuF5Hh2KReTZU5z7Er79XdB5lQ8+qiC3rQqdUleYrEeOXrb9UK0QgaANWTGePbCZVSzVBGE7sbblp+twAyXN/Sd9LHziAq7W4aGuB4rF8T76np/0zSGof9ERDqBQLc2FOas/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310807; c=relaxed/simple;
	bh=7nNEom+tKFy1he5iLNLwo2GnAaSCHd/Fs0n8B2jFjLs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OPQkJW/0IjfwKTPbzueg8ih9IS+JLPFXJziDZnEmIXBQQHmCk1nPYcb9NGZyR710pDFaoFAEE9GoH3Yo1w7zPJ9HSQi7RW/ITON4va0UfoehnkX1TgORdtOtmPd2A5d20huW8fPtKDjeUn2SydtEg+iD0lHfYRrPILc/qEiArZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81d1b92b559so620248639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722310805; x=1722915605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkY2tHjimGZZhkUzaV0v8TP/RmubO42dTqzG6swAL30=;
        b=QddIP04aXQZQZUHDLSvZ5NWc53BmJ7cgfqqxsg55OrkQCe9EZdyoQviZO6bW3SkYCO
         cxBoaiaqHCDi6QiGSv/KM/3Ki6tckFFa01GhlXLe5s0+TCMd4tDY812dYCo2qjJ5fOBA
         LjeRLFVgdq1Athq33CTXUYPUBg79bwSVJv+PjMom+J7Pbv0dX9Ym/gnCuHle5em7YSF2
         Ai2OHIvxn1WZUai7D8mpAq3EX+iqmFtNFcC05DI59JRDXr7wrbmMDol3Fg/zw52pTMI9
         vYTnelwuU8sKkORyiCr4NuxFxKJLNDPz71HId0ToL0mGoUdlZSrKCLjPuNYrFOs4iusf
         UlHA==
X-Forwarded-Encrypted: i=1; AJvYcCW5nJLbm73dXMMbnaaXjrx8UguRdFchBUIQJZu5sIpg2IebxKg9JIjSb6SzHgruoOJ27PQVN6qUEWVqxCM0uXnBQAuefWLMooWOVAr8
X-Gm-Message-State: AOJu0YxffULPg3bnKVcTt5euNz43uAXDbjiAL3ZaE4lf9kBSHWmMTMUT
	VOXq+rR2hswhuCTemva6Z2m0cp7rWq+cMv58B03xgLBb4OCi6h82C29crz71P40RnV+DNngSLnp
	62F7KhkkD8aYxrW8vb7k8rmikCc3WZFeO9wtwo+HdN6tQ/JC6MONA5bg=
X-Google-Smtp-Source: AGHT+IE71GBqTZ/x6rw5cBJo0SqOCh5ad4Hu+P+E557ae7kkKJLMAjguNnQ83qTEfiWLJwr6BDpNV1eImc+LZFpqSaqV0z7Z8l9h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c5:b0:804:bfc0:382e with SMTP id
 ca18e2360f4ac-81f960dc663mr23355939f.4.1722310804715; Mon, 29 Jul 2024
 20:40:04 -0700 (PDT)
Date: Mon, 29 Jul 2024 20:40:04 -0700
In-Reply-To: <tencent_72A97943A1E444F76C577266D59361437C05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b548a3061e6ebb78@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in plfxlc_mac_release
From: syzbot <syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com
Tested-by: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com

Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13d5a94b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163cd19d980000

Note: testing is done by a robot and is best-effort only.

