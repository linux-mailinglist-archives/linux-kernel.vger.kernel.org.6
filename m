Return-Path: <linux-kernel+bounces-188219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396008CDF4F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FEC1C20DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448A376F4;
	Fri, 24 May 2024 01:51:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D32E3E9
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716515464; cv=none; b=I5RjafKAZWUJrGAR2vJSsvZbOaWZfuExve6XEbwkxVQIMSLKPuApE8L4uyn2rRvqTKT/wiWoam/ZkN6PKSTef601GX1yVWw0SqpW/PxyVzkWG3wpYN3Udc8187Gz9tZBVxjTdvndfzl6GfyXOtn8parnvDQH5GkhVBS6i6ALfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716515464; c=relaxed/simple;
	bh=R3XCXcSsBOl2M298bAhwCCMRYqrzOyrxEWd1KqFoitQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t3Dl1zThfyr3LM04j5GmmE3o6W3f2ijY2iqqLHum1OSay8/R/uRzpRWmrnmQfFiPYRUTm0H2oV5oabrGUJHnQTlev7TT7RDaBl7LFGZlRc3ARCPszdZd2LiPyAOv7wbWlgI717lI/TEaVTF/DSyXbLBGKrmrCOHDncnvJvSVJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1ac2fbcb7so236189039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716515462; x=1717120262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opQdkjpIV5NXY+geIDrDv0tIxAlatzfbFMBcjfHzpeI=;
        b=MkSynrX5evIPl+to4LdPTcQqGwrtMnnRwhPFRChlxIrImRABRk/KdrwXKzcOzqo53J
         np2GpIFiNtEYx6TsK/Ecqv79dqM+doMmG351MwX9H2fJ1A9VJY2wsSEbXJJ97uZRZY1c
         0BPdc0ZQFJM8mNCT6ACAo+Z+hdDXRMopKNWDI6onmfhvFHi0PhR+RMtrGozywV+PqCPc
         ZoDEOKZRMQTgF7xwUZ8S++oGrufk+a/DcR29WtR8UyqHGmz5wUWT7zxM/iNhhDBg8Cua
         /luRqJCrFYjtx4xbNkicBHsqYsheGZFu1oP4hH1iYVfxTJuRDqNCM537pXBP6W3RnvJ+
         0ghQ==
X-Gm-Message-State: AOJu0YwUzWa3csWRRsjGLniuP5wMobaijMW9siaKyyhNRltjbqAkcNZM
	VyLO8D0xPV7BNAu0KEXJ2yKjkNVRzaW5HbbdW3OV168Z8qJavwoSpgX3AEWGWsEP4qOEdLP1pR8
	3tfREwUGnsVIem0tVS83Sxls1i0dsMxpidpBQS7Sj8kaVCO7IXeJAmFY=
X-Google-Smtp-Source: AGHT+IEEgeo1PfMLpeMlU5zRxPgU5naQibdkxucNdn9DTpxKtnp89xQuVA5hAKHaLojPPTr6Hw+5UYuP5mnPRj8I2Sdfflqii3oV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc1:b0:36d:92b9:8f30 with SMTP id
 e9e14a558f8ab-3737b295443mr694195ab.1.1716515462130; Thu, 23 May 2024
 18:51:02 -0700 (PDT)
Date: Thu, 23 May 2024 18:51:02 -0700
In-Reply-To: <20240524012956.3069071-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f3fa606192966f7@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17bad634980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17736ab2980000

Note: testing is done by a robot and is best-effort only.

