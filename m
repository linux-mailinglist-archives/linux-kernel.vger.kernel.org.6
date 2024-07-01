Return-Path: <linux-kernel+bounces-236147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D649A91DE07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133B21C22602
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA81509AE;
	Mon,  1 Jul 2024 11:32:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBA14D42C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833524; cv=none; b=SASGvwyt54xbYrB6Nr+mZ4pVonyYOTOiQvt42Wp7xfVuIEqpGevTw9qtUMHt8ShiCG8N3rTUekU+3dJPNCnu8e1zofeBTZNHaE9gZjbbxEhTnoIWY5m/xmgxYIueQbryEk3JhaoKkmz3q+8VolHEURP4Va77RqgtkrpLre3LwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833524; c=relaxed/simple;
	bh=+S7F0KZ0Wq/eDa0rHjGbmzuO2KuuH+UScD9CW/785Dc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IQXtb6bnWNve7+WGwugsPFHfnkFFhjlAe1iaJrIQvcjXjsqQL5kavYppABOkNNZuWa1NUJfq4PJlkZrOrCQR905O2EOW2m/lmNhMZ/vYtF9PeqxVXL75TNHdHhzGQY/lTeerHtQZVUHnJq68EFTyq59s1OCWUYGfX31o/DvyU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so332786639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719833522; x=1720438322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/W2Ty4KpLA5gWruZimLVXnnlIx51r2TRwp+ni89jRmc=;
        b=qVg5wv4TggRMylVJfbTLa4pP6N4z3SG7kI8o7qvHM/VRNINbIEOpjsiNKnPokn5DgI
         2wRBhIfrN+lBzCQAA8YHSLMUT0PaK0Z6Pd3GCvXK16zsiAmFHUGIbS/HM8Riew2ojs2K
         GsEcl3fHYRZqamWoqgsvFT9T37iebbZQtjj1F5VGt0Cl3v+AcaZtu7S+e6snaiOuaKbg
         yHIXBSGrE6P+PJsPckzmZvr7p3t3GmqaaNwA296oPReQT8FiSJQ0QjPl940lDM7ioEYI
         0LU0m9fPds3pesl6sTouXINPJxwMSNg6Fh59JsHGnae/ZkKMy66+zqRmFAU35WBGR1RY
         isIw==
X-Gm-Message-State: AOJu0YwvfeVkd0bLJtD1nbv5OdF7WvQ9jp8dA8H2DEE7aEAFUu9l0juS
	o0VLu/50AYhMxT8VXz9fPGWu4Gk1vRUbcTAUSKjKdkIve5+ATrte9LL4qYbZlLZrx6996wCTAB3
	hijIPuygCZQDMRDLKW5i6Ft5XRPVGhISr6DTGC+DvsSxBVjYDqzcUqY0=
X-Google-Smtp-Source: AGHT+IEK8eu0f8XVEknI129kDLzvSOHdnfEnBPiGtazDvNkh8ppVn42pFm/f43Tw9M8aYeRi164I1D4R9yuSK3Lv71SshwNXDU1o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12c4:b0:488:9082:8dd0 with SMTP id
 8926c6da1cb9f-4bbb6892d94mr594959173.0.1719833522260; Mon, 01 Jul 2024
 04:32:02 -0700 (PDT)
Date: Mon, 01 Jul 2024 04:32:02 -0700
In-Reply-To: <20240701084553.24215-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ad6e4061c2df2a4@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in __block_commit_write
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com

Tested on:

commit:         22a40d14 Linux 6.10-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1508f869980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f85e95b525c28b48
dashboard link: https://syzkaller.appspot.com/bug?extid=18df508cf00a0598d9a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110d6885980000

Note: testing is done by a robot and is best-effort only.

