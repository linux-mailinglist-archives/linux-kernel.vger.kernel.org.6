Return-Path: <linux-kernel+bounces-362464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8B99B553
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F472839B8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7F189B8F;
	Sat, 12 Oct 2024 14:11:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B601482F5
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742264; cv=none; b=NA4BP+d2VPGMMD85JOYOKUV3LTjiMiWPszVXj0N3X8PxwxA6yyBXOA4rHxQVPZWb0gzl7kgvdW0GqSvvDi6jmwyN6bgshMEpF4In1nh3DcZbDCw4zfonnOJpwsWWrNx0kQf1N2aZIVM1tg9jGWpgZ+8xjTzfrDTWRJXU1BEaUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742264; c=relaxed/simple;
	bh=HlaRvSdvuVu/meZUMxK6B1kzJNvjGz+w443XMMZJ9VM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TEG4Gt4BvnNaLoo7S5liGB3qF5okmIpQLTjkasRBqcwzhKmKTlI08L6NGVSmkkeHmOJUnvHXToB8vK9aVoo2rbiNLRbNupKN+W5S+wKTApcGg0QZ4jI3KCpFf225pEe1UXDD/8Ey1ouZPfD4ahB+IlwgXnuX+o31X36XxqvxjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so1271195ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728742262; x=1729347062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iX1rWbC+lSi9sg7wS50ujMJH6io9uB+vixPgCgPPD3Y=;
        b=dfln+MQqc7ttpG3/q8noiCzJivm2PYQoncntcqGkMvay9QxW1Fh7laQpYHpUH0MdWw
         mauHHndzHZMdwgbrVeNitz3312bYRcML1AIXNJdomnH4ZLki7GZNb8D44gYSDaedYw3q
         GaC/MUJgBOLX7RW3KzRc8K2Ye6Jj3lj2WOjsf8+mO0PqjgCQH4U1U1c1TRQRwHNLzNhR
         mFer5JF+d9waK1stf0Wy9dHVPp/ypzsLhh34S6ejlmDNtFyrJXUgqEoAOC80spKPwIXY
         HV4FLtuNuSibXkJPcBO52N+aJLdIKxr/2Na8zUXPPK5SvBmwZ3r368velqru3dmNDVSE
         JmvQ==
X-Gm-Message-State: AOJu0YwkhiufvWuR6wKZ4DMoSv0k5Kmsa9MQwZf9uausMUCC2qzgode1
	GxDWtRSDkEGsVglibmb/GkM+pA8/W2JqAwq8ExfwXCowNZKVuZ3fM9J0PAGLhBHfZ/DZW5A+HxT
	lpN/fd5QJB43dgtWfPWBo8S9sEmOs+O+AiJkSZV4ExqBQyRZ2/a7/vV8=
X-Google-Smtp-Source: AGHT+IFrjo3Q+d+z4SnmmOTW5iX3VKnENyXYG64PN1+JrrPajcyeH1mAeLPt7uw5uptdgLpkZttacQpKtMN/pJda2jQenTuY0n3M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:3a3:778e:45cd with SMTP id
 e9e14a558f8ab-3a3b5fbc20cmr53040895ab.21.1728742262101; Sat, 12 Oct 2024
 07:11:02 -0700 (PDT)
Date: Sat, 12 Oct 2024 07:11:02 -0700
In-Reply-To: <20241012133220.4121757-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670a8376.050a0220.3e960.0027.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING: ODEBUG bug in corrupted (3)
From: syzbot <syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com
Tested-by: syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com

Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1022e087980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=90f31ac02b7ae5e8b578
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1467dfd0580000

Note: testing is done by a robot and is best-effort only.

