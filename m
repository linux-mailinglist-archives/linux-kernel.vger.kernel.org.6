Return-Path: <linux-kernel+bounces-252025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5BB930D27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD30280F53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E0157A42;
	Mon, 15 Jul 2024 04:19:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BBF28FC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721017145; cv=none; b=o8WswsdUGfmDY9TkEmF4njHhtdri3bfHn+n2e6+CW9prxdW3DcmcmO4DFzgzbJ1vjAVee1yn2l3+OpDA+c+xWOCvQGHf6PC1sEkEGrczOfOZrZbDn3ukj01UdZiBQKibDG7xAZNFHb/cOmeJe9ug1ZeSJTBe2FEiuPXj54AT83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721017145; c=relaxed/simple;
	bh=qh12YNwtJC084T5blKlxpVcONYM1ZGSqnO6LO3G2XQU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EhOxbuPqNTXoLmOaInzcEomnckQCpzb3SW3kbUD1SlGzsIYmj/QQmxx664zciAWCmQpcUoMf8gK25r1Ys75ugxud8wbDW6XAqGyUgxuVT7MC22HdXjYCr0UF/+AjgymKPYm5enF61JRBA66qUi9KtgGHadZ6FRwIsqOXh12da3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-806199616d0so433099239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 21:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721017143; x=1721621943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeJvkD+W3Swp9uHKd/nDj71Blp77hPnw3Ii9HpZa0h8=;
        b=K1oWhP6VxQfc+a02KX/VMd7C6GqolEJvhQjw9U6+zCp4vPq+/lcP4HfJ8/HaPGxAx1
         6lG82qFqjI53iVRipASZGQ6DAbPQVZ8qmK76fy3HXQ6XcTaRp00BStKkAS5R4ohaKnea
         SKpQy9DBDh2OBNhVrme6l0Gj1HPy2coTwUYNdwvx6bYkhtsrZDOOXDWvKqosHhXzMmsd
         FwU63xh8bEp/wcnzDJ2kb94svcEOQgpFyAp8CqFJuug16ASOXSHLSiHvg1wyCNKVX6U8
         FWMLGDqn3kcvBdv8NL94KAGsGMAYH3fS0a+iHOG39lk25OFFAUTHtO95EP+r8EcqXIB7
         RROg==
X-Gm-Message-State: AOJu0YxGTxaf4IZvyD1WNUxWMbDISh9kaE23BOsYrL6btCvq9QKbDUwh
	xi+XBdEOZR6gyB7u/In3XrAB5FCe10wN2ILd/FVW1e6C/EVBUnDvhxf0LecQQY0CvVRf0UCjnSp
	QDbeBqi07e94fJcI7ux+NlnMOXb4ZiGr22QCW63gbDMMwTvNMIEfJ0o0=
X-Google-Smtp-Source: AGHT+IExGJrinM0/FKofTmijXr4lq+yUb1rfk/m7RGyU7WTsu9bvgLKttmmqrZ0vMPfyo3Dth/Uztr4kHEqIgRmTruNqStSwGFHL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2192:b0:4b9:b122:d07d with SMTP id
 8926c6da1cb9f-4c0b2b545d3mr1135075173.4.1721017143632; Sun, 14 Jul 2024
 21:19:03 -0700 (PDT)
Date: Sun, 14 Jul 2024 21:19:03 -0700
In-Reply-To: <CABtBSab86_An9zwJT4R+dCQT==bGgtsCoRiLskU=PW4_jg3XiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fb50b061d41871d@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: ODEBUG bug in ext4_fill_super (4)
From: syzbot <syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, shenxiaxi26@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com

Tested on:

commit:         0c383648 Linux 6.10
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1278cae9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b195d59be68c3b56
dashboard link: https://syzkaller.appspot.com/bug?extid=59e0101c430934bc9a36
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14977631980000

Note: testing is done by a robot and is best-effort only.

