Return-Path: <linux-kernel+bounces-259024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD1939022
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FAF1C212D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1E16D9C6;
	Mon, 22 Jul 2024 13:51:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B11D696
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656266; cv=none; b=rOhI9JCe1hGoSTjXAvnBI8glJ+/joPzYgmUVp+RQQe6QAPCAmuYGpVzYYFuhefPYs0P6pQ8L0HU+M+7HMUQpMeQzCqstvb9TYHCp5YdOw0M8Hc3+ruPaUhfuknFXmVAskQdy9mC9fmULB47GHCZFgPDm3998m6ecjZnOEDB6M1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656266; c=relaxed/simple;
	bh=jZ6x0KgzWTRvCD9iPhAkhMhg9MYpOAh/VG5dJXPN2ls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e7FJQcPSFrRI9Lux9KW2v4Ar+C6q0vNcVAt14r/1NxS19z8+KQ/mapjLjjLuawWJGJrAPrJQTiw6ipHXKbCPEVQHJ8yLY1KORZAOLrr+BJsOKHPFhVR6z7uL8nawWdWOfW33dEJBnW+HfNYVA+m8hgilhrU2omZ9WVdJMphxYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-80502b81995so705409539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721656264; x=1722261064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFr8EsjLqB7vxZ5AVFnoCXTIs6bQF/YczgGlZ2IHrOQ=;
        b=ZEHBdpRQsE1IMR1Qp5m6nFlwvM2V8rk3hDdakiLVs1BkbJuvww5pzqH2JRcPBsxSuH
         05vdrjaSGOa0FP2Hw1TlLggbOy9Sb4D1TtymeZT+YqMAtImLK4AilesNbHORa4zhjP3S
         gtQk37/s0otGSfMmBLlyzsZT7a36HoRrRGJCZnbIy6IjoTQ3kS/FCTE6kVVXjQ7LdbkS
         o2UYGqTZGM5W73Bf1pWUwaQKvmNidzFv7n8J9piexeZvtRj5Cp9y29tgNvvH6N8JVuSP
         /bfthk1y6KvgmTjZlqnL+8kP7j0LavOcHIQYbNUs33RkoFQiR7KKDpB0oHe/vCC5e81J
         nw7A==
X-Forwarded-Encrypted: i=1; AJvYcCW/e/oTMwyJaw4Fqq6yzg6trtPB4oWdrawBoAKYAPW0HDHa3lvG8RvrNMbeyFfqsdJaVvOk3hky3IAMp5GNzMQ5w4UUMzvUe0OCpfJg
X-Gm-Message-State: AOJu0YwkhDKuuXUrKT8VMRf0HPjxkQKaYAW+PtL488R/0uMl2MIywByW
	7MQmWgnWRgEGTxrWLsOMtbeKa2PWgy7dEUsYxr0CPxqUkPIEc++Z1HFpZv4sE57mik9OHyRw0BM
	ksK8YQ8J7Bc7qsoE3B4K7Za6GjNBTlj5qf6VQRSss6kg149XXktP2Dds=
X-Google-Smtp-Source: AGHT+IEZojsOGwbDTOZ6ivnsUuOa2lGZeY/lbsneuxVYDt1Mu3NjdQfo1nNC1XAfquK0Op7Nw7GHQ4CI4k9OocT979TtKu5k9drn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6c97:b0:4b9:b9a4:848b with SMTP id
 8926c6da1cb9f-4c23fe6c055mr482888173.3.1721656263895; Mon, 22 Jul 2024
 06:51:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 06:51:03 -0700
In-Reply-To: <20240722094345.4089-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008fb16061dd65695@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
Tested-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com

Tested on:

commit:         3b2aef99 net: ethernet: mediatek: Allow gaps in MAC al..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1668e595980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8defeae77515c9b1
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

