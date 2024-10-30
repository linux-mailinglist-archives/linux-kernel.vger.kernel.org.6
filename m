Return-Path: <linux-kernel+bounces-388212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968489B5C16
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D46B22982
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAFA1DA617;
	Wed, 30 Oct 2024 06:56:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9011D12E1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271365; cv=none; b=la9jlCm4V+jIPtirDk2vERYuWWWaU5ALFdAY1Wy3MFNI3SfB+SvXku/aE1+S6RMe0mCphRpv/1axT73ZdVzSC7XDpSaDjnb3ZAu065kxZMrWnwk+BlzZ7vnWo2hc3NGj3fYpZbjyd1MicyQHrQ2/ZOwLuwtrh8aK5yyylw672m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271365; c=relaxed/simple;
	bh=QYiVchEbFSndvTo1xaMQfUmAV/dLWDYZ6vAla5kLcYA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O/jGK6qgqmghUs9zmIO8agubOT1+H07TfWgSAmGsgJoU8nDfXIS92GaB98FdBr3vy/LXrJxoCjQqBsQeEiwN2aQy44izt1XOQg0k3MOUNWsTFYa3QIxt5mRFWb/LkA8Kb5CMVTG27Nc5LCy7wYI5XoeoSvvkxOz0F/89RULkBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4eb49864dso42289225ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271362; x=1730876162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjVEHCDDgZ+Rmd/w/y/N+RiQAwXyNItPbp/MN8LCa9k=;
        b=D85dhoosLeiEU48yOyR4f7CFl7qvNUHuul+//ZN0YUCa3vnEj1UBAI3ZMujxGPAUgI
         mQI+9DrEwGGe4qGTWcDOydJIrLCLONMCcW3R5s+tBfFik7TFhLVBFwZ7EMP3NEMde1ce
         3UmwPkXrCByc3vqTwyLYY6V0oCtuy6O6+mZzWhq8+sU60UPHRaIdCZj8edkSZ4MWmuWU
         mec2GxUf3OLuXGsC8O6WeXbdMuA6R0kGw1iPuqF0K5VG8/LfX8xRxi2pxROkcDocyR5r
         nNU1A7we8Ocsfu6gey897mTw1oH2LdUAzOfxNWbHub1TfPn6550cTLX5sM7D7ru7KTSg
         TroA==
X-Forwarded-Encrypted: i=1; AJvYcCVYHi0RgX3Wt6jhGfVpHM4bPCFD46zO+zchnCYbXApweD7Mh0dXw5CPlR6KIt60SgcEQAkykJ0vjFbLWIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIlpImoE+7nodw1c43uveJME3COqDt441wT7PLOBU971yQ98C
	iCdn744+FLDJ0Szto8fgpvBDcBRRPqUSr8A9IW1FgQCLZpB9BvcgBoJRrxTTUVx09jR4JLl3GdK
	o5Kpsv2umc3sEXL/A66UCtBuNnj/R7Wn2R6KmW/T+3QjF5f0bYqQb2Jw=
X-Google-Smtp-Source: AGHT+IHgZVAM6el8QSFrDEm4FaXJRgZfWuJ8lfeSVbLZlqcXmaD4TYlYvIRkc/1NzBabbloUUEYCQOp+e/H9W6JHGrE3aqrfMe2V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219b:b0:3a0:9b27:7d52 with SMTP id
 e9e14a558f8ab-3a4ed33de2emr138689595ab.20.1730271362553; Tue, 29 Oct 2024
 23:56:02 -0700 (PDT)
Date: Tue, 29 Oct 2024 23:56:02 -0700
In-Reply-To: <ZyHUlDvkl0Umhs-y@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6721d882.050a0220.3c8d68.00af.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: invalid-free in dev_free
From: syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
To: linux-kernel.vger.kernel.org@gmail.com, linux-kernel@vger.kernel.org, 
	marcus.yu.56@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Tested-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com

Tested on:

commit:         c67e9601 usb: core: use sysfs_emit() instead of sprint..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1758e2a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2bb21f91d75c65
dashboard link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11056540580000

Note: testing is done by a robot and is best-effort only.

