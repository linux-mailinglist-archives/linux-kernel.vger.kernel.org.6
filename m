Return-Path: <linux-kernel+bounces-310589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F4B967EC6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E71B28228B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672315351B;
	Mon,  2 Sep 2024 05:28:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7014BF9B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254884; cv=none; b=WIdKAeHLt8aKaSGWELTf+BmkgpLAhgwbdeRLNx1M0Q0KlMppZbODaAjKDVbJbQ+Nmj6dZpts6Ei8ts2nzUBhu4BuO3APh4aZIJqzL4tYHVZEWAVSTdcyUmc6+N6wIEhyj+iTp2xuCvg32Hw6qpHw67XmLQEQHFS3kkN0K1wCJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254884; c=relaxed/simple;
	bh=PIWg1kV2O8zg6jx9p3Pbr33e5KlEZhEQxtJASrgjHpk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HpDb3fAUUOgoW2QKkx86lnYGB6aE3BZiWomW+sCPAz7A/kITgDjCB1pgrOAI6INAJsUBGsyoSNHn16Z2QQZSwoSHx6YgpTr1Z635bcs1QHojGbHKvjYkvlZuJohtRUfrfA2ezh3g8LHf2RYv8bWqmGnf23a0tiKfm8by/UB55Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a217cec1fso419837839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 22:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725254882; x=1725859682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6/R7U0VqDiPHR7JhVGpk+mBdbkz6KtFGSnvxfDuXFI=;
        b=cZLAP5O/psoN+8bk0BnlS/sLUv5x30/5BDD8eQV/Yu6fZgbgQT0//q//4pNDYi6nJ9
         CtVAQGKzHzMS2qmdl3mOi+knTyTIXOMBUwPagTvZHEkwvl9Ypw+cgYTfb7D+AAucgTQI
         MYvpDW192MSBK89OuP4rAcP24HABL9EnicqVMv/mI/xQCDTLddXAlowd5JmiCHf8Yr21
         p4W4VICVdwBEwZA6Oqj4dUDbHF2QR75qsPQr+f67DM2Z2gfR3kKS1/tsmaGcfmZPlwiw
         uJjl9vsSkWXieWtuQzN744ms76z6r21+bkh/wiulwPXoCN5iN5ZFtmjRj5j3Ngcu7DgQ
         ibKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3h75j7aclX9XP5WBmZhLziBmlX+vS82HOXbJ0kfZljBJX2xfPt+tMTLWvM+FI/5aihKc/pqs6k87xzsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcmFWGSDtgsTb1DJIpYAQjDmbknDtg7yNED0kRX2h83Bgi8Bs
	zHQdtrN85GHNSM7+6QBBliSLckAI7VSCskJYv3jcGBX7yTeG8WX2UI08bBj+tHdv6E4XIO0tnE0
	UuYJQ4fCrb0pMtK43YTBlkz3cqTfpsJubDsnoqGt2TAu+kce38D8F7c8=
X-Google-Smtp-Source: AGHT+IEGJzdjUqwdJUazymn+LrA+gjDAEdrAgDe9ts5jMjlBpRNDON9BwywuQpAbcrk21B2MMgOldPJZdwVKYwxr8wfyfW8BymTa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c3:b0:4c2:9573:49af with SMTP id
 8926c6da1cb9f-4d017f12e62mr647003173.6.1725254881854; Sun, 01 Sep 2024
 22:28:01 -0700 (PDT)
Date: Sun, 01 Sep 2024 22:28:01 -0700
In-Reply-To: <20240902050455.474396-1-sunjunchao2870@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006156d606211c3444@google.com>
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
From: syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>
To: brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, sunjunchao2870@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com

Tested on:

commit:         ee9a43b7 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1710c453980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f2e529980000

Note: testing is done by a robot and is best-effort only.

