Return-Path: <linux-kernel+bounces-525269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E0A3ED5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7900C166D77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7C91FF1C3;
	Fri, 21 Feb 2025 07:35:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27651D89E4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123306; cv=none; b=bXQX0e9ubVXztStYFHh/KVDaBsqnmS1ER1b76MY1JZQgQpptKYvaOttkLucYP9k96G4ykHbAdRfkGD8AhVvNM30GOxSJJsFmbtwS21WCZsEG93ygpFkNZ2tZfjJ0n07w8FmOwrHmBIybNr0TROCyiJom6rGwmrrHfyAW15E6TQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123306; c=relaxed/simple;
	bh=peLrDcldK+g+S+9NNIER4V16mGRIhRlylovUJitm8tY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R7DaQPW818P9r0Ouh3Qr0YytWJIpoO5s5suyk2nGNZZCAGmgtc3+ymY/nj+hUim2mvW1ATTrthkDawCDTZSQvlzT9RM28ws7gdAWOqWqpsC13Xpy/Fhj7B9rhX1+zXrlsVirQsSYDr5KbWnIkFNYi3X8O+pkIeUsXmYifIjHmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d289bf6c39so21717455ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740123304; x=1740728104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wO7Tys3wAQpSEY9OUnS2SGDXJLNVPcAyT82FAwUBps=;
        b=iStx7IoTsfxJFLU86qNoKOFAhPUwR6NLGnWZG96UWRmHnPi7JPkeKfewdoCIoHB5gd
         2Hbo2Yv2/8Bdy2ha2xYRaYj0f35vKlf6Sulsa/77VpAQJCx8svrxykN4wjmNSNwUuWPP
         8I432g62D+n5nq7hwignfOCgZRTAqzwtKZMaVKXVeZY8xRzJ/jSIBpXuOsTf0SPa0a+F
         2rtnBoZ6vdnTH2wBXqhmf/RwvCBIdfUQpvr1L2p/68C39+eaSQMuHG6/0vhpxIrShZsV
         xTFAJKNoJF7aoxcdb4x8hRTZMuDclNXtsbhzv6A8ZxpO+Ikt9sJ/Muee85Getc2D/Crs
         W6kA==
X-Gm-Message-State: AOJu0Yx/fnSoUlnH5yhyqB6zEs/0HKbY/HiyfoK/10r4MSVMYJU9nMKy
	7nm3tpAk0smlufqL2jZMbdELnJC/YzdSOa3XIN+q9moWCS5UGEVNYNrjCVCuUW5VgGEZOYPL4+k
	sCGhTJ0msl3eSCsiuu+2qxcPdDP4vFsvzy4ULXLo8NcAGhZsBXJiErRI=
X-Google-Smtp-Source: AGHT+IHAO1OUlanWs93544Puzl3lr6ASaQEN2ZXpvwYN1qlARprQpekoU9Qsra701uXQNXe0tx9QcTkXd+cE6Yt+Mcp0moMJFj7D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1066:b0:3d1:54ce:a8f9 with SMTP id
 e9e14a558f8ab-3d2c027290emr60604425ab.10.1740123303790; Thu, 20 Feb 2025
 23:35:03 -0800 (PST)
Date: Thu, 20 Feb 2025 23:35:03 -0800
In-Reply-To: <20250221062718.2353693-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b82ca7.050a0220.14d86d.030d.GAE@google.com>
Subject: Re: [syzbot] [pm?] possible deadlock in lock_system_sleep
From: syzbot <syzbot+ace60642828c074eb913@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ace60642828c074eb913@syzkaller.appspotmail.com
Tested-by: syzbot+ace60642828c074eb913@syzkaller.appspotmail.com

Tested on:

commit:         33442609 Merge tag 'for-v6.14-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126303b8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61cbf5ac8a063ad4
dashboard link: https://syzkaller.appspot.com/bug?extid=ace60642828c074eb913
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b0e7f8580000

Note: testing is done by a robot and is best-effort only.

