Return-Path: <linux-kernel+bounces-200970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420888FB798
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7329F1C21C12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27418144D10;
	Tue,  4 Jun 2024 15:40:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226513D501
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515606; cv=none; b=WhlYCmO8N1H0d3UTTfizh8upgmdmkyu7qTq5VWMtKXVjpdT9MNg6MH7tLBIVNvqKqY/Z9YH7FitoGLYIhGv0Qh4b/ApiUh2W7PL4rTe6N656g7dDxzk0IUFZr0GNmnvpfrNJmH1RysKW+gUzuD4J+Nv5uTEE2HeMapjcxMBnEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515606; c=relaxed/simple;
	bh=IYrpEI9ESUXgfrd6PmmnBS91BTgpJHWgWPbCxOv4sfg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j0KWmyVNnbVFDjGMUKqB03xrCvIkOPdxwuA7nqTK/9vr9Mw7LJHEn55tI27UWMMMbk/9/pcxENBhS2d/KuiQFgBWuz0qcacahWigDw2tK+rCEEn4hgzij0iXy+lea4syhDqnYXRiwWpa2BgeML+xF+OaH4m1Z3hYTA90hgkVrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3737ee417baso47460435ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515604; x=1718120404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUyz+L4QW1yPiCkGSSsrehPuI4CGB6TTCD6NGaUJQcs=;
        b=XuCAjuA3YG0BMWRyc+CjFmhbkR7gx0IG9j2868SwKHg7fiNArtlh6OR6PC17Q0rJ7M
         exLjF2mE+NkCDuBrIta4ucvuvEl2z9Dh4GhjTsAVJaW2nqt2LpvV2yXRslj3Uaipt9M0
         1Cl3oQaJStFVX55HJLCrLNwfNk5dyiH55KCM9Ku0D11ehgec7geq3VFiY+r17ywdXGPH
         WWcy9z8Je1Jud/yCBkd5GR2CWItGmJfCvTqBrzBKxPfTSFXn1Bb3UlsbCznudrlrq1QU
         6dGE/dGV4OZ4y2IsLwwhq8960vXPE1QClgQzxjavisuUniBPpQtKMLNUKbC+m3iQLr/K
         mucA==
X-Forwarded-Encrypted: i=1; AJvYcCWFnOHn9P653KCiwNQM1zYMPBu9QUfSTJHyAHURNpn7+0HnHTSYnAdNRurA5bGx4NKnitvK1LL6AYbGPUjRimOGDVL4++uDANAMhLWi
X-Gm-Message-State: AOJu0YwkykenNCnoPEBE/6VHIt+PdB8Ew1xJPZlQTqF7uyyIR3jBFyIT
	EGP5TJD4k/k+FgqaX+/hHcKZWWJp7Kon04Kg71eGsSa4lawHKp6RUPlFuAuU2Ek/nJJ6A+9u9XQ
	yxolCCaOCc7nRjEidSji7cwSQHoIwqsRM1UQSmH7z1+cfnVJ4Or/kNbk=
X-Google-Smtp-Source: AGHT+IFGhGxQk2d4VPpAMbOpbT3fHBYBgC5cRPRwhnU2rdKJrsLua3NcjPW+ofZYIToEnVAlPsVSGeQJSptZd9DrNQqZdq1fO/Ps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:374:9305:62be with SMTP id
 e9e14a558f8ab-374a850a1fcmr1743585ab.2.1717515604014; Tue, 04 Jun 2024
 08:40:04 -0700 (PDT)
Date: Tue, 04 Jun 2024 08:40:04 -0700
In-Reply-To: <08cf0523-b70f-422b-8125-884ddc21d1ea@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079499e061a12436f@google.com>
Subject: Re: [syzbot] [f2fs?] INFO: task hung in f2fs_balance_fs
From: syzbot <syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com

Tested on:

commit:         4d419837 f2fs: fix to don't dirty inode for readonly f..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=117f66f6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db568e553e0f3797
dashboard link: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

