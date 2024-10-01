Return-Path: <linux-kernel+bounces-345242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB6C98B38E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50614B24099
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5191B652C;
	Tue,  1 Oct 2024 05:20:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F1653
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760007; cv=none; b=RXPHH2U9Yf4KZQzzkzDlFBUicih2EUWfVlMZbGRPvefUyP8yk7MMzVneuYtIXNtmMVUwU8iiREAf8U3uE7UsvhlkpeMt8wdmo9WJ0Rg2Q0gM1yfSKd0I11ZWJUyb61zpXfU9soHSRDZZLs6Qz1GwgQA7VW2kZzfkIXQbuRWvyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760007; c=relaxed/simple;
	bh=gD8BupR4O3NofKvQaLtwgEuwRowrybyCGi9IwRaDLb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B2kEDWXrNrl0SZLx23DXFv9yspgTRtufLRXlmRnkPjAU7EKPyzyccJoE2pisR14Qc/wtZKGOUCsAENAC9i6lbmS7kPYVLHBerNOFz5KR4wNGE+5BD825mM9eUu5ZVKwvhzY7p64+SKR7iTbxH1m/H+GbPZZxu4j3yclVxy9Fr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so684427339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760005; x=1728364805;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGNFjBY93EgWg62WC1qCmRKRdaCG2V7EXmiP9N31CHU=;
        b=rY/CjCaOPp7Tsm5HT/C76bJ7j0MtybHo3nYiPX3sbmBn7pO4acU0reVD8K9UnH74Gb
         +OeO54dDqf+/SPG47dEWXqm7BvoIa3KfJHXJ6NYVC3mOcXsJQ15wXSUHctucv8QT5Wfi
         mGga5fHaMvIDsazbM4A1VtwPthv58Gy5rU+qrrgb7db6KbOhYR5i2kvFXuLslXvXtX65
         0CfO2rATZ3GtBTWcD5zyNuy5u3BxcEn5NMMjf7u6C+np6Rn4asS78TJhk3R/QbmPcKfz
         crqYc+qtJUncIMsqE9dt57YkdxbjMSy/Y/5PTxXoBpi2gEwn6XMbTXs3Gw+Es8f0VIxN
         SB0w==
X-Forwarded-Encrypted: i=1; AJvYcCWax+01ukJQ9OlBMNQwahrZEfYxqEwmHr3DhceRHRdjqyLVTLN+SLMDdiYiqxEwRpGFN9QStj7IaLrgh1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxt9pfRWpGUnL88aUD7QBkputl9Sl166T4+AEuXVmtOW9YFG0v
	IPaXNfyPKstr/WKnShDBY4WZAfHVO358vxVPBNduQOv66XjyNRmq/LY3xv73AR0uFtgc7gnFGhG
	jGA485E7ggervvovXUSc5GczDkb/HbcixhlS472RMeVTZbUXB29W3cZ0=
X-Google-Smtp-Source: AGHT+IE2E3ldzIxPJCXvG6CA1Z6OWYyhx7C2KYtl8rzB4D39zgWpdU7m0LEJsSVCyvPAWxWkt7ApEKe3iU3vMA7VEtdFm/95qjz0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:3a0:8d60:8ba4 with SMTP id
 e9e14a558f8ab-3a3451b690fmr130923125ab.16.1727760005229; Mon, 30 Sep 2024
 22:20:05 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:20:05 -0700
In-Reply-To: <CAG-Bmoev_1nJTr0hVwCf16ebHekbaXo0Mnt9V7JsZeYxWtxxRw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb8685.050a0220.6bad9.004d.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in jfs_readdir
From: syzbot <syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
Tested-by: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com

Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1414fd07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fde3d29a3913237
dashboard link: https://syzkaller.appspot.com/bug?extid=0315f8fe99120601ba88
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d8fd07980000

Note: testing is done by a robot and is best-effort only.

