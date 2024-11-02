Return-Path: <linux-kernel+bounces-393592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA48B9BA2BF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 23:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916D31F2289C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DBF1AB6EA;
	Sat,  2 Nov 2024 22:28:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2143157A6B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730586486; cv=none; b=p4iq41nkIL9kE54ho2pAd0cJm8DMAV/lSiChdkpn67nUxhdOhgQAcYhYjJRUaF/c+zl283B+kMGQvzWboj3CerV9fv6PQGvwy8xCx2bImS70QJIxQYr7v/KeWw6xbdu9pZbtE/gKoC980xxz16jg/yync8M+1N3sPiB6XDul/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730586486; c=relaxed/simple;
	bh=b6+Uk0RT5F2OC1ogbQzHkP4xaxNKMUEWX1eas+qtN+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hAxtoeqzXTTKKCGtBPQwPhF2ibt2aXtdIv++laG3SyWO8cfTbssWqViafxbOSM3CFM4I6ngFzeZvSXakkDtUoZK4YgNvhRzVY/b6QqtPix5jx1mBWSxR9SN+fHaXXRDSukaKTp6UERksHfP/ypT6ejGBimOzfIghZKHm54mr9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so13476825ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 15:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730586484; x=1731191284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAuTYYZTBytbTIdj6PEtIn12ccxueCIME/4DbMBA/C0=;
        b=XNgW0+g4LYdNGTsmJxlNsqwpmN2W5jcwsgPCcUwob+mHT6vDk9+oEw0CwiVSQP+H5o
         rPUCQaxbD4Hx5cTNlS5Ys5A7Or4Eo6c56JyPonyFj11iQSvnRoeFXiSOsqr/3VrDfYJb
         hBtngvVE13kQ1pG4ot6ee3tVafz87HNXfRa7K5miRFncHqi9Pr9nzeXig6k/leIs+/iC
         k+fe22YZHPZrdrFs+Dg7ry+5Gdws2iRRmwZ1hChMGdD6zNlyOQr4qesZJQujW4SgGp7o
         5GxKY7LIKnfYiuWaXoCANmMD73HS5M3kdB28Vz7Lyh4rt5z/EuDDkh/3bn/RMidL9CJC
         4Vgg==
X-Forwarded-Encrypted: i=1; AJvYcCVUHklZnkvSheCEZ87N7agKcL2ldYatmC/u++5vX+B9d0vYLVzulWsWq2HsyYP9cuijzvQgGih7oW8dZG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaCFTSByNdXchyKZ3GIg6W7v1Aqemor8VsHcZ27dAvKCDf94q
	z7uQ23BtjqxllMes5ZKf9qmlvvydKK9c6UGn1YKSXHcaUiYcIMe1BXPG0EzoWWStUVuB4qTEfjz
	6XX5IaN7JknsgLQNHkGCf7PNR6yBP7P/uZMUpU6oPlGV5xHreEHmZAEg=
X-Google-Smtp-Source: AGHT+IFlOQD9E7Fhqe+i1ZDtA/esiFq4zrwGyicl1G5sKKwIg1LMIABTBfb9P6Hzb2cKPYiMkknuS16wcghtc5MWQxqnFiU+3oXB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3a6:c000:4443 with SMTP id
 e9e14a558f8ab-3a6c000470amr20023165ab.20.1730586483994; Sat, 02 Nov 2024
 15:28:03 -0700 (PDT)
Date: Sat, 02 Nov 2024 15:28:03 -0700
In-Reply-To: <ZyahFyrgAUtMODEq@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726a773.050a0220.3c8d68.09d4.GAE@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1009f55f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2bb21f91d75c65
dashboard link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f92b40580000

Note: testing is done by a robot and is best-effort only.

