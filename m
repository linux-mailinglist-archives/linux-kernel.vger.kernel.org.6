Return-Path: <linux-kernel+bounces-262129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6EB93C126
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C91C21941
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841351990AD;
	Thu, 25 Jul 2024 11:53:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A13C3C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908384; cv=none; b=nT8Yz5AjutgpVyc0arEhYaPXnvbwJdmjgP+B8z9QTl+kBofasnih+LKHZQerdgdomcJp9TgoJg2+p5sGmv5awBmeCmDXPJuI6v/FRvvyIkcSCCXCQi/W7CyjDGv3ywA7cY74F/Msk2aqjDSUTKcZXWZMrggmuevYZpQEte2ptHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908384; c=relaxed/simple;
	bh=QdFnC2iwBIQqQbpHYdcjGm/iYUKjcIpjC1bcVo0Kx/g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ELOhLy4cnkEDBl5lAQ9FpMOMdlSPRlK45WdSNseLQQV1zJTRaQF/8mQ6djri2mUGWUfNzhBQy7N13rN4Zea8n1WAPalNQav2YBrBckUEt94/7Rfcw39rPhMv8guafuoM0oOQAURonN3Em1qrQtMiAPCETxbNrk1b7pACuMsEhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f81dcb634so6644439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721908382; x=1722513182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRib4xhnw/eb5Si2+frCMuYc8W47qciKltT6/dFDIa4=;
        b=HJupqkMlVVBVzGgFO0n77qrE5NKOpHNPu68nKzCOuBWXM8aqe98Ezp3wluVHRvkOU2
         qdidNSA6MbBG7EW5LmjIwYWsIk3MBNbPTHG47C1+Rx8sLQ3jxQCJUZ38t45oVjzTeBKs
         ut7w1lP5SDmgPV+6aKL1dZYUkvJPVmBaSZQK6v4fTqa0xaGoXaAmbxea8KJ48T0xtjwC
         2vdBXPfbZ8SE8MEtX038yFo9i1L3rUzXF/796ux8Z6RD3P1jHbAS/uKohkhm49HAoGVr
         Bm1NrCh7toq3SWOE4CriX8g9FH2PbeHT9QRmujoVcb0Psn+23dj4O+DAEcCkhMcsZb9H
         4gFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXci7JsU+1XN1vQ8DOLbPQFV3UfsQy7v7f7siG9y2UA0H0Vl+OW4OHcEW6JGbyjf4STfUpOHN481OAJveuvqlgvkVq7Q4vAWAhd7mxD
X-Gm-Message-State: AOJu0YyeojoF/Hmq/nPYQdswMpLcpfTSLvVIcW0XYlc5XtdOAzPfBsY4
	4ynyOf+lfKrrh1y4giufX4A4x/A8wyJmzu6ljIslG8zPpsMXKtrq3MaZm/HUzugQFfpAE2H9WU3
	AlQ3mqoSuf/cbEgoo5r2pGzndDqfkoeslW/tidGxIv794DVEM7FzMOM0=
X-Google-Smtp-Source: AGHT+IErjHHTFbi3qACa7cKcXFZX6IgyyqrYTKdu4+M9cdaIqUt1ZlIiNLR4BijdHBo3mXpA1anMAkw5CfRPrO/GUsJ8HlKTHAA+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1381:b0:381:24e:7a85 with SMTP id
 e9e14a558f8ab-39a217dc268mr2308875ab.1.1721908381971; Thu, 25 Jul 2024
 04:53:01 -0700 (PDT)
Date: Thu, 25 Jul 2024 04:53:01 -0700
In-Reply-To: <20240725112730.15279-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000718d12061e110950@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
Tested-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com

Tested on:

commit:         c33ffdb7 Merge tag 'phy-for-6.11' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c4d29d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=582add3de1ac8f6
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12337145980000

Note: testing is done by a robot and is best-effort only.

