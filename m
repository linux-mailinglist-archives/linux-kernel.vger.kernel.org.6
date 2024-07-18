Return-Path: <linux-kernel+bounces-256302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E1934C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDDF281C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AC13210D;
	Thu, 18 Jul 2024 11:11:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061612D769
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301064; cv=none; b=j+waRyhdodtczPhcU3fumzLo8+aG6ISlU6yh2aP51bwIkgJzIyocbjCzQRLI+8X8OAPDksnEJhrg17R0jkFGuk5ND7iQM6Sxv8NjLnnatYpQPo9XOVXmxwcqgTRCQafGKICGcOD+p+cYyJ4T7vX7tDs6VXTJdZ/Hdblu/S5j+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301064; c=relaxed/simple;
	bh=52nbA85UwtH4/+oxsmPByhwO/jSNP6i7uHZYy9ZPZ5E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=psI1lfiWmzuGPzA7QoUFIgcDmiKJx9q8JZhadPSro6XNDxThTJSDG6ABw3N07XYr3ez2XvWmL+/658wtvSlEVs8f/tlS4w/ccUgTpja8dvRt5G/ZInDZtDh3FvWIRNxeQvcqvnR6wKBMwZcChtNCZpjsIDb8YHTBD1P4lRy5Pac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81258697716so116572739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 04:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721301062; x=1721905862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D1Sta4dDI/Fw09BEv1aQjubnmMW4+jrsrPWpx3+UY4=;
        b=o8Ud0i+lqggm9XDEqSHz1FskB/ovugqAHvcdM18PZQep6vN0qhJWrxawgjVbzWovVS
         pt4d+rRgrhKN1TWWmp9DFDHT4rBsrNwxg/nEN6T9cgdpelOSBfkNfrsMap5XnOUdVZ00
         g6I6GnbgMYvyah80svqH7W+9E0A6Mq07MwKPMOY808kR2IsGEz2JNno0fHPaxacieGU7
         8UUSsRnXJJbWUeLy2aeiwSBRgQmKMXHGbzHcZDhaMNk8NFfCWi7cEVY+ChFh6jfIO8Ld
         l239anrk4KOpURG318fpLSQWTYNNqoM6PbqMJk8Ms/832FFOkOYpmyuj/95E0rsFi6Mx
         c6oA==
X-Forwarded-Encrypted: i=1; AJvYcCV2asUfk/3ZPRKXHwu17FciYLPHIb1H3r71fbQwyZj8JCm/ob2qj6hXFlVkcco5yN//YoYlRdLL5HXWvIjEhZdb+/wRGnguUn9TN1fP
X-Gm-Message-State: AOJu0Yxo10qSWn9nfb+LVbTtKRcMwLAmu5FL7doCQAgjqPMhYX96Ss49
	dn+2CHZb788GW3TO+njtHm5PnYKrellg4OZKYaicdTmX32Qc38JDBHrC4DKKk+RGWD4ObX0FD7h
	ZdJBjcQJ4DGQpdn89A1Y73+7BrlIwmJ1yk14QblesCNWbnmeKTEvJS8A=
X-Google-Smtp-Source: AGHT+IEbSX4KvznEXOjVzgaFBn1l55eP1If566kZUzfb5aC6dmnMdvjBBOnxHHGmYTjllwI7hFO2CcFo8IulEoZsnaQ/jFCKILsd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:381:c5f0:20ef with SMTP id
 e9e14a558f8ab-395526d992emr3142525ab.0.1721301062279; Thu, 18 Jul 2024
 04:11:02 -0700 (PDT)
Date: Thu, 18 Jul 2024 04:11:02 -0700
In-Reply-To: <CAJwTMzpbq-bRitZBAqfqvjW_1zifEXbJ=+ZAcW5ndRO=yAraBw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e74e6061d83a286@google.com>
Subject: Re: [syzbot] [fs?] WARNING: lock held when returning to user space in ns_ioctl
From: syzbot <syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com
Tested-by: syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com

Tested on:

commit:         b1bc554e Merge tag 'media/v6.11-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1571e159980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81a1b524758b7eb5
dashboard link: https://syzkaller.appspot.com/bug?extid=dd73570cf9918519e789
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e12b2d980000

Note: testing is done by a robot and is best-effort only.

