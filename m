Return-Path: <linux-kernel+bounces-230240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6E917A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E176286477
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27E15ECF7;
	Wed, 26 Jun 2024 07:55:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599115F3E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388506; cv=none; b=g8VySs3l4mB0eYBmN/meDH2x+NubBWBzoR/OJdfIqH769ZNmX8EajVHolAzfyL4jSxIN45uPhNK5nKEywVQxiYoIEeWf/tw40R7ZX5B1qAwWLTDILT0kzKguaE/geUcCr3qT0xI6w2JAckaDC9Q5OSToOiU85n0WhtDGYF/3uLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388506; c=relaxed/simple;
	bh=Vpt4Gye2b79EipFlbPUq00vRYctifvkkWdeZO6Gas8o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iy5OQhdh5LcQ07N4zOgljtHONELUUCDYs+2JoCrh4lnR6jpQ+MlLSIc421j0GsyIl18oc0CZLbRW7oMoXQ2V6z/oiHFcaGTyoRFOtkUvGW00zKV8DatXQoQaeg1cj5L/5bq+YwxGnTxO0o4Q7ddawVGBI+3CdHpptE8oZJNOhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3737b3ee909so92471895ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388504; x=1719993304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzDaof2xJ74gCZ5IJDnQJMnrknLYLyty2S5JQ7HI+IM=;
        b=CLUtS3tuoEtS6WhjzjBN7rrzPlm+vh/x0u/0LlgkMYj/l2t64sopXKH4l+e0nXTFs9
         FIcjHyRjHUrWE3Og9mXBgHzzWrdJ3dFSJTkUrHucff6fPMXcazpAdqGCMovf5USzdpMd
         LAsKK/PMLyuHTLJW1L8kwGAWhn7mSQJl6K5FlFf8CxWWLq2Lp8wGQvGt1iALhf9PPQEb
         M26Ucx6nadxr9YvRW0fZpIChIrhFhtDWeIUD/seHpYtuXa0qV5Y5XSqjHSVE4XUHcQoT
         e9FdZko/BzzLdRxIrQJn7aHLG8PC84oLiOeWEMwyGj9yZ5gkxPvAJNnUlmnAK+I+6y7r
         OyXg==
X-Gm-Message-State: AOJu0YzYHgDewjKSRN2g/El9L2ED4Y2gN/2iprn8GrZxivb0tOho6MCj
	lZdnxK5Ia7XnMmfuq4mK4BxNcuN1HOxvSzIQZNs6oc3RgSJR/LgWdqvXxUmIOVOjRb5rZrHLHof
	7jtvT1r43fExsx90ttXXlAbdhhdCzGrc6j5UckMVp8nVOwX5MCvhus8o=
X-Google-Smtp-Source: AGHT+IHFbrYoCMxpIwQa9iv3WaCUEk+2IKcO/OW35HNSxbp9ei8R3L1Mpz70U0IVCVfOTLEiJhohYjKZ/cD9iEYeZeU8t2D18TO8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180e:b0:375:88ec:810d with SMTP id
 e9e14a558f8ab-3763b3695demr8702465ab.5.1719388502909; Wed, 26 Jun 2024
 00:55:02 -0700 (PDT)
Date: Wed, 26 Jun 2024 00:55:02 -0700
In-Reply-To: <20240626074013.30611-1-norbert.kaminski@3mdeb.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f274f6061bc65464@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in
 __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norbert.kaminski@infogain.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/26 07:54:36 ignoring optional flag "sandboxArg"="0"
2024/06/26 07:54:37 parsed 1 programs
2024/06/26 07:54:37 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1000b3b6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bff6f9b539bef0c
dashboard link: https://syzkaller.appspot.com/bug?extid=11af34d3c0711f233fd4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

