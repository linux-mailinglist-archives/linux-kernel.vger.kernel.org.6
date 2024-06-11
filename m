Return-Path: <linux-kernel+bounces-210395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27A904318
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211B92838CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9AE6F2F0;
	Tue, 11 Jun 2024 18:03:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AD6D1D7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128985; cv=none; b=o3W+UrejiwZRYXmqHjjN/iekHfb7/KPFwqOwGcvBUgU03AmYF+NcpQUZJxtl6H7i9NUKwAjIgYaa7g6N9LX+hBLmsdXlcD2RUk52ffRcKSkVunRAPhJZUy9HxW2Jr7rS3GFxOLdEvqVdpncPY6TJX6yFuu8MZksULUH1TMQxZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128985; c=relaxed/simple;
	bh=dNdmIkkI9RJSzq+/E1Y2oapLGA6weBkGCeORZhJsUZM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uyQSxCTHEJazO9L2+3IhRxHx5iBOcCf+QlRJh7dWZhdg2hycaZ7bJ4bEc6Si4kqxwUf+558dJxChgnRDgZ1McmewsWsh0CwHdoHJkEv16Q7TvPD+Q5JY/owzwqwwDLn0fCDcC55ccdQnzLBwmQUVoFKJA52jETVpTs7UJIdJD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb4c4378c0so647731739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718128983; x=1718733783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zX155y/HdqtyC4tuFKhQWdjrJtIDKJg0z4WGiTQWmV4=;
        b=wUnW9KaZsNWXsSCug5A6FbWtPab1NeZvapVIM12rWbn7hEG34/kJRMbSxq/UC8j6Yt
         kgS1duJqMuOFVlSR2MM+fLr5nTCDb657v961KP66fR8TPlfJY162mtzvVCglJ7x3krqh
         lct2p6UZD1RkF72UFBem3uaZBmcMJ+f4Cl3sq7angvUgc2+Rd0vEX+m/vsulOkcUTRty
         vj1BD/BnQ6ByDWIdZhhSDMQInbsaImuTQoOonw2MFXF9qygWASk84Z5TUT5Y4whgclMx
         KROvmu2brPHrnnYoMmeVmCHJ7PQmlO7+wOovmDFXyRMPIdOMu2aFMtFOnCvTrCmhVE5L
         4gcg==
X-Forwarded-Encrypted: i=1; AJvYcCXEIo23aUaSN/9YzRi/VvUMjqPx7x7uPgOueyouuFW4mGx2t/U79sfAGJG9dNf7quugGq6dyqCh6ySAekSNjS8GxhOWyq35p6FtAX2w
X-Gm-Message-State: AOJu0Yx6bzrkZrCJV6JV5OmWFk0t8cujr4QWv6aRuK8bPLMSnS0y0lKF
	hwB5qXFKwYE/9b9eGk5JYhtQd53lGHVmTupBgp5ggYt8NgcPp9qZrtMphsY4R6vFabDwtoIqVfU
	HSCj4F3msiwlFtLYD9dYR8RZXqbmXv+XnqRqiVzbSH+YF60/mywf30qg=
X-Google-Smtp-Source: AGHT+IH/74GbLRAS4ZvUsmf9E4CH9xx/k7+z+jcYz5BlbUMG3ENMrNkJ/qk9BBW6QUURr33sMxX+v9GbSqovKcbe9nz8vGLeIrkN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:374:5d81:9135 with SMTP id
 e9e14a558f8ab-375802382b2mr9602735ab.0.1718128983320; Tue, 11 Jun 2024
 11:03:03 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:03:03 -0700
In-Reply-To: <684687e4-8be4-42ee-a125-8ef9acc3fec9@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000babbf8061aa113df@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
From: syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com

Tested on:

commit:         8867bbd4 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14e092de980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137c697e980000

Note: testing is done by a robot and is best-effort only.

