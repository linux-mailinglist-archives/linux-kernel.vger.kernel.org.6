Return-Path: <linux-kernel+bounces-397623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FC19BDE29
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F63A284E21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6F1917D2;
	Wed,  6 Nov 2024 05:08:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E22F50
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730869684; cv=none; b=J+4IeyOida4VL1kep4qay0mIHummgXAGXqumqd/pGX4LL6rliOXJzaaYKZVvsu/+0mjihDmsDJY3ycRY1uvAxVo6bfFvGahdrNGXTfkGkx3DCsCEDethTA1PAR4Dazsm1bLovHopNwdctmjm2saDgPsbU0QQCRzxmeotnNOrc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730869684; c=relaxed/simple;
	bh=a1d9rFYmiox8Cvtw9o+GMM5ZvGuCn8t66Hz/uZIPOVU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ogi2PeDgybysimG5Tbk40AN/ndsfePfjkmJw6t2JFurNcy3XgANIVksgwLe9hQZzQq94FB7PZspLKYTOJRY7tfFxHNGVxjyPY6SeU3DVLzFYlhMJdIX9nkKWrx0yO39kKPe4KlZl3WDbmcNDpyIPGVozTpIwFJRij9vgtaWk6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so64861755ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 21:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730869682; x=1731474482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZCpyZnda5DlHXgbs9S3nxrto8V8O+1AIPUGm5d2KMU=;
        b=jiFT0BxY0y/W/W6RoXHlKz+10Q3JIIzx4BYIxaOxOspJsY5gIYaeQ2UItuB9sSJ9jw
         PufsSkD8HqORtG3KQiaF2pzo/PdVtsdBo4tGf+quSpseoQeiJymAGLNDJ0WA7omT95iE
         ltvr6DbQs2KGGvNalnZcp2S2vtyAVBHdZycgWJ9xoQ2Kvh8owdLQfp20DupGMnmRmqK+
         ygS3sp+4bGk6fcCtRKhrqNl+gb7fUp6zRvwVHtHx+NQzXvMPZHY+js3p2d+0Ee2Y1KbZ
         8IFpg3ZNraEuAKJhsXSI8PJjGF57T6BZLteou5ZfbMmau809tPfUVaG6pbEqLokHa82z
         qZ6Q==
X-Gm-Message-State: AOJu0YxFznV68gJ3ZUrXXZfm1QAXVh684EN9cfcsGGr5kT9x1rLvoUhA
	3e5b6h0izNy5SgTZKojsUjsOGgmGkaJE9KwaDX4+HsQy2YM6mkiCsdIvL80AUX8FljjkW/BdECA
	4BeKrs0PTkfiICtU31ip9H8AWq3a32TTE6naevljMOzZe4bhOPMPqO/8=
X-Google-Smtp-Source: AGHT+IEbaZMaak1hOR+JlAZzixE2T090fs8rKeKGEUM59TJWcInbswUrml2siCNIq69pOOmYlWTFxm+M7ofQwO7D98wedpFh6WoI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1948:b0:3a6:c7a8:a1cc with SMTP id
 e9e14a558f8ab-3a6c7a8a3ccmr130602465ab.20.1730869682494; Tue, 05 Nov 2024
 21:08:02 -0800 (PST)
Date: Tue, 05 Nov 2024 21:08:02 -0800
In-Reply-To: <Zyr0DaD6yG6WDHXz@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672af9b2.050a0220.2a847.1b5e.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: invalid-free in dev_free
From: syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, marcus.yu.56@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Tested-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com

Tested on:

commit:         6ff78df5 usb: Use (of|device)_property_present() for n..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=108d4e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f0eaad4c825e2e9
dashboard link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17154e30580000

Note: testing is done by a robot and is best-effort only.

