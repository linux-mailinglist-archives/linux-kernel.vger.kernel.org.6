Return-Path: <linux-kernel+bounces-214095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C520907F58
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4374C2831A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894A140E50;
	Thu, 13 Jun 2024 23:25:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8814A62B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321104; cv=none; b=EDBrA70HtvQvX+g1knMB5j1YCS06gb4rrBn+TRWDXneuk118CGgwDlslYtSPQsYCFiIupQbmjte56vNkzyHk0fV44HtzZ1XmGBN1mj/NU46tTpT9rF54T2LsyqJU2FnvxWRWsY7y4uvng7JqrnRvPc+30kCbQ0mx5w6Oavpjuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321104; c=relaxed/simple;
	bh=kRSIYh+IYVsXXlkBrcyb1CecN7b4j+1hi+u7PUdG9pU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Unjv+OVfIqd3Upd9gsYOD66/IyQZzCZrv6qAqQ473vwNHXu+NheBokDqZJB9tugP4VVEMiV62RicpyiWNMEoi/TTYh3EMsKogSmzj1k1bqCy2HkZ4urq/PNw/GYYWmqlPVT1+UAiPNXlBOEhsmE/d/aStZxGf0sPC2XCXrJ1f8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb7cf84c6cso162756239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321103; x=1718925903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qG6e0f6B6AAWAv+NDZols4qYfUhB6B8cdTbTKaoc4lY=;
        b=U6YLVp0VjeE1SJPQNMLs8hboQl60Muzf5yOyn9hZllYjImlhTr4N33zDjfM5lqTK8I
         DQCNzaGVuXX0+BvwSZUzz8g4Y66r+l+evi0QPN3JDCkmC5GeD2DJVX9Bja8XPRP7pruJ
         YgPSUV2/HYbtpmz4/PbPO1lSaItZuYoUvNzmSqKl0wWlxxVyGTZV+o6mQXP7JNmMXjGU
         4DVO/p5L1LbfiBi8nlAeSFfSzV1nnxt05pW510kdrV/i0/AHWdQPAr+b52nyS0vzOl+H
         +tTET1wveTiAnFaV7h11LRRYUpDJNgcm1ZKmUvXZxdRgkklxMkd2l3reeofG0QqwpYA9
         HCDw==
X-Forwarded-Encrypted: i=1; AJvYcCWPbscs8+ki1ODgM6C1bq5CLJ4TrkcxJYEJj+32Gh32AnrHWdbat1x7S4I1E3VqhxQi/6gyyfB1a5lcpaJpquLNMW/tR8usm516h3sT
X-Gm-Message-State: AOJu0YxQvDG4rBm8Ft6lOJqMUGibgYut86/CBwygeyhLiClmo34BMDx5
	bp8uwsQHW38KoiaEfUFLWH8VPCfuyqQ78K9NdvUkRVLjm6fMlNfEtAK1LUV0L9X9s6q67knaJ48
	hTiUmJcyWcsPHH9LkXJCuFZWiprRE0pw5BZfCNvH6bO8nu8klwbXUcrE=
X-Google-Smtp-Source: AGHT+IEhDJvAgrT7IU1f8Os5C1RPrBKRLzz2lQBbD8T5VpaHGB5z5lOjl4EfW2O2KasgHQP6Kj4s1zW3ckdJhh2SdkGJz5NJZnVa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14ca:b0:4b9:23bf:6fd5 with SMTP id
 8926c6da1cb9f-4b96420b2c4mr11353173.6.1718321102775; Thu, 13 Jun 2024
 16:25:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:25:02 -0700
In-Reply-To: <4e155544-60df-42d2-89ea-924ebc9f7057@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0fa5e061acdce6a@google.com>
Subject: Re: [syzbot] [bluetooth?] [usb?] BUG: soft lockup in hci_cmd_timeout
From: syzbot <syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com

Tested on:

commit:         8867bbd4 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1258bf6a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2abad17596ad03dcff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137d960e980000

Note: testing is done by a robot and is best-effort only.

