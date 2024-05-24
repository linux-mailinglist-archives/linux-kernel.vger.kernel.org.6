Return-Path: <linux-kernel+bounces-188202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7205D8CDF1D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9CC1C21940
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D7FB662;
	Fri, 24 May 2024 01:15:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110053AC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716513306; cv=none; b=WNEMr5cPk/7ecVhe1GMkWByb2HU968eRa3ubbqAZxbgGOkaLj4ihQB4fC98cZrylOmAyhZw/M6PM0vwBqNly8nllngpwvx1XgbSIKskndH1FAdKxE96ST17NJO4NUJsVqRbNWkP4npkDG7ThLW7Sfz30KSqye9meHvTa7zTPktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716513306; c=relaxed/simple;
	bh=bwX6iJD6AQ6OPeWQnwz9ta/bbDVNLWJ3UEllJ04H7RI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sO1+gJd3jSj5oCFCV1M0rUz/hoRsu0atiw/KI0QitFwbPBZUMT8VDuF20sE2MF5mzfCzZ6GKGlSL743rMFeu6izEi6jPbJJRpvWdLFBhrz7YYbOE6Xp2bIJrLUuLzqiTUzwCwduWBIpuHWmcDFJDI1bTZLhdJ4yI3W+O6A7YD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1ea8608afso236253139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716513304; x=1717118104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1GRo7Zw3z2bdnpABa5h4u4gai61SwkRqBg80el+K2g=;
        b=dll0RORLXPHyBEEtoU7DzSUKLFzG8L8568/AXBTobSmZsH2fzqM3pA8qqLr/uzInIK
         WTZwnqsgc5AqEllGpGZ+FoCqNZNYtCE9y97+vlGLPJd3oF9kHYrjUsnDK6IaR7aHG7FN
         77KLCBAdbtqxrw3NIE0qLnsTPZDID9RbJcUC4MsQyE3MLMshda6XrokEBrxIJpJqP8i2
         Xn1vBHAqDJF6Q7zj5JruKqUdbEgmeRuprPuIH4pIv1KVh5rBYCG+xFt9VKZUGIG/zo6Z
         9aHTGPpoGEZNmYtygo3WN7oDthWIiV4RYhehEVjzH6mCAKgkplHXLLbsJ4CmYEjipO26
         gOBA==
X-Gm-Message-State: AOJu0Yy2h7KrLdUT+IICbTrA6fRehJ3RguAvwbOeoYYOqQjGGucn3bte
	whQ69sacbODAZlqoWKxf5OuCmeoWk4CAq2AgLT9YXv28dqCuBkGju98c3ECs8ry6MVLvJ3Hyb0S
	MMeBfpNTdi2AoV92Zf4NCsX0LYPmRFJN/MUbzVmTMP+LrnaEZZstQV6U=
X-Google-Smtp-Source: AGHT+IENwPUdXL/MUi8EwaA3jQWowBwFqOYQ3M3rvRSEME4YVrgM1eyTAEK6gsvjvo3wRJ6vp7IYphiY6tFxI2LC6Pc5f98ZE7t4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:36d:cccb:6842 with SMTP id
 e9e14a558f8ab-3737b1f362bmr381055ab.0.1716513303795; Thu, 23 May 2024
 18:15:03 -0700 (PDT)
Date: Thu, 23 May 2024 18:15:03 -0700
In-Reply-To: <20240524005225.2834298-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9a61c061928e544@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=135ad634980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117d5142980000

Note: testing is done by a robot and is best-effort only.

