Return-Path: <linux-kernel+bounces-522737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65223A3CDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B0D189A025
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9811264608;
	Wed, 19 Feb 2025 23:58:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0493261366
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009484; cv=none; b=kR1gQmeUOqN6fc+vFvtgurC2m+izVv2GIdWhDOmXhAeTvExTDkQ5/sY5tyv0ivqxtjwrxJ7tLfWxCXJYoeo+AtEPYRAm/1TqoL0suafKK+H0xkXLU4TfZ/pD9DJ0ETOvdAurShhY5NfF3QWTst5aN0q5ecMJ2WYhX1HxVBk5Gs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009484; c=relaxed/simple;
	bh=VpxJ709Ll1ZV9KuqFVvujLMvKLXdc2GpDcoVirmZh1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RRaiON9KGvhUIXxW+232iIP5ImaOB3GlKX8d/qX0PebD/CMKajGF+6FnJkasQhu2TX8cQ+Qq57ebDm6LJHHOGUCWWJJeWnOQkzKL1ARyigZxXBkWXal9nY+GRcT7LAA1Q8dLTWsbkMgpCQv/gCXkSSsOFJX9e5jCzL/4HvIFoEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so8636995ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740009482; x=1740614282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPFt5Mz4ybfRPNq71ksWFUJThgKeei9LolPAm05pXAU=;
        b=sTvgG5xF2mCf504AxeprXw4O7PkkSOJXqh6f/R20i0orn6SvyEsFcMRibTlL6n+osX
         OvYYLxj9Ktl4tJMecKfhr4lLLEoMX72eNea+m09JzCIwfhzK2lHrEHdsBheS4EpFJnN1
         KeIV2UY6B10zVivuWaCwirHxLBpjeLDhgWBt+37c5pcMsFX9TQ+Kl0D7kHrEyRYVNH9m
         KiXN7hyTspqgyqqLPh5i5i96ZU4vTagnMSl6JrKaj4ncbVlrtjZxrAt4U6nUom1BoyxV
         qB+0J/XLN5jPOz4XrWabgOWT9V9DR7s/mgF4090fDhXC3nfcWIMWmWwYN7jNZ98yKjse
         zAKw==
X-Forwarded-Encrypted: i=1; AJvYcCURcPw8qzhmqCio+XHV12CPpWSZ9TsA7arLJLroi0YF2hk9+9pFDJHUNdUYUOAkx9pDVQfl/GXEni1CaX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYHmnXab49dgEzj4yimxameUimAYwgYqCSSRHK4kM4m5S4Yv6
	eoq/in2m8XtXRiqTyk8UEolfze+DKUvQTEyQAg736f/DszfQWLcXAd+pBom5hM2Vyp8XZET+Muh
	doAiHNQ5TKMlPcpEQDsAu2PRDmcyCp9zLAtusPA7qvVsYw9CdC+bqfec=
X-Google-Smtp-Source: AGHT+IGUFHkp/DNPLl0d92qmqWsmWuZ6eCRJRZCW06SgHOh4RyYkxlH2wY72Cp39/eMghkStc9jmsHx9Bto5Z53YbFzZyeb4V0an
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1446:b0:3d1:9cee:3d2f with SMTP id
 e9e14a558f8ab-3d28098a133mr217124485ab.18.1740009482124; Wed, 19 Feb 2025
 15:58:02 -0800 (PST)
Date: Wed, 19 Feb 2025 15:58:02 -0800
In-Reply-To: <tencent_14375A4BEC7483764966023C0136D4968209@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b6700a.050a0220.14d86d.0153.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KMSAN: uninit-value in diFree
From: syzbot <syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com
Tested-by: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com

Tested on:

commit:         6537cfb3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ddb5b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf1217edc1cc7da
dashboard link: https://syzkaller.appspot.com/bug?extid=df6cdcb35904203d2b6d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169b27f8580000

Note: testing is done by a robot and is best-effort only.

