Return-Path: <linux-kernel+bounces-181645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2278F8C7F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDE21F22667
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9773F399;
	Fri, 17 May 2024 00:18:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8833384
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905084; cv=none; b=Ly+VhP1vd/EZ+Orswb9OKRiXpPqNEhBxhXcczL9Yw9MLiiDagG/HfoiLOMJ/NN6iMYWvZ27pzf3sbNwbw/W384M5p0Ny66COpiq5Jzw1dtxcladWIZQOl7RS3w+ZydQuyRTwGeWSxEoK9Gbi0zrfZzmPv+vebT8xbQBpWVc0mTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905084; c=relaxed/simple;
	bh=KKP8yGRXcamxZHEo7pttKhPz4bYwMt8RQXE9juRc8F4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BOJWU4Ge4Sgc+t44ecgOF73/AFng9dMTlt4hALKsOZ6sR9VXYFyg3VCk/vsHgPcNF37Mh4iVgmTyYdIggF777Ev8i5uuENmyQ2z/qRPHP7iMLkZtTLVoGjthP4EWFBYRzuPZ3d86rxqUQJ70uEYbt5uDCA6SmK9Pp13VjfXEg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so912966439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715905082; x=1716509882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yu8Elopc26ST7yEMxJYCS0S/OqJUx7Vw9/DLK4lkKho=;
        b=PX5+AtGlg7x4W/TN8XNM7poSpaLLvi2CCwXH5bHIskVU/5cZTmHwlddNTegmOlfPZF
         N5k8uCAkc5w/yzO20FrZINraOXSgO0pSOSeTFuKh4pjbIuEBDqQv9FQAOy2+u/0EhYKN
         7+NmMo8ea6sFtcGSsfi+JEVo7a/fXFmt/+i0+043/P5LqXL6Gdq7dLP7zwYe7EsPrPsH
         6a58CD5QhJ7i7TADBWNAa9mxD4Ryh05UC3hoEcDyb1H04v2CWeIwucHy3iQKSTS7jOki
         n+TKCBNfGWxBUnIpQFPvif3TgDGiQQvMsJyHEC2MSnSEKt6mPrtkJaJPBodSr1kwmli7
         ncUA==
X-Forwarded-Encrypted: i=1; AJvYcCW1nRIH+ErImg6gKox4r3+Fk0O0mnzcZa34XWROyAlxV7cm2v2liZa0auX1sv5E7dr+jNRsrN7fVzQyFAksKOoydYsM8SF2qoIfdhCc
X-Gm-Message-State: AOJu0YxMoPX/M1Vrf13O0hdt57MPmk5xsZKygmgOETkz9YeFd7QIC+Db
	Yj/BCXiGYb9O8fQ1qeKI+8LpPp9xE8KBoVRdcQvo7p6OIZlawdMWrr7rEsaR6FEZumG1ipmCWVb
	y43H+MuJmFVigCyfNREKyCE5bOEtTfNYOiL3mz1TiboQCGfr94fw32AQ=
X-Google-Smtp-Source: AGHT+IG+R7Kp7LyNXKH/0lrYKI+RH9W0jzQ2FYUoPChaxkaM0D7v3dDNBPmNceU6ie0kDjlV5sj/CDQrcW+y/bvAHqzptAAEZCn9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3782:b0:488:59cc:eb44 with SMTP id
 8926c6da1cb9f-48958c020f0mr1666969173.3.1715905082049; Thu, 16 May 2024
 17:18:02 -0700 (PDT)
Date: Thu, 16 May 2024 17:18:02 -0700
In-Reply-To: <20240516222843.1500-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e257e606189b484f@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
From: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com

Tested on:

commit:         75fa778d Add linux-next specific files for 20240510
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157911d0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccdd3ebd6715749a
dashboard link: https://syzkaller.appspot.com/bug?extid=c793a7eca38803212c61
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14688fb8980000

Note: testing is done by a robot and is best-effort only.

