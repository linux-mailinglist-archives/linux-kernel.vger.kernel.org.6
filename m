Return-Path: <linux-kernel+bounces-225926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85AC913797
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15396B22594
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D66125D6;
	Sun, 23 Jun 2024 04:06:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010BDDDF
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719115566; cv=none; b=oaAOt0/oqHJDd6pQYaEuDvIz8cNSLI1pTmT6fLKIr5AfhxoSdQs3PGa11tDTXNIcWUSYEy7TVYfq8tk81Ml5WQxvNhoPrIdCQ802UKOR7+fUmibqa5XTxE8zrwTmWjlqaLHdh2TZb4Y/pw1uIna5ej6qal2OG1+WwOrzhd5DLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719115566; c=relaxed/simple;
	bh=e8d4fjn5aqZ1GBew+ZPtB5P0C6mGEO6r65Q5E4Pog4g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CvUKTWrBDvO3xUPWnQxgszgxRfy3i7H0RDFTOnXfB23Sl+xP0R9Jom/p4vnQiKV67j/o55sVWSSgE0hvoXtXErJQCPVG8kvP044w2n3WPJscd8gSW5LE/PK5i4jo3oWWzidIjfbZoa8cpZgQq0mQDANYjFES9ChcJjwI9yTLLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-375da994725so40298885ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 21:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719115563; x=1719720363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvUe17h2efKYK2GGiytoQnjGY4f2roRgaYl5pEae+E4=;
        b=Y8vLH5y3I4mg2zv1ebrdOjGFccnDqTO3C75PSaWv5MJeEsKmcMRrY7p/Piz0Oomlkh
         MSqYmtwtxJ+7OPJG+fcQ8GDlUmBnE/VN9m4ZURt87dajTrPeuFiiq1OQYk3BjelAlvCh
         hdPNhslq3XR+OpYpTvtcTbRhVIZ2dRC9JecKETO5FsG+T04YLB87I5h3oLHy1yfm8tfZ
         x74R2dae8vYvjV5I0G6U45SntxRrVyEjEdcMkqKxDlBvUxxjp1L4RFVTmHuj1n50dI6z
         nO7fyR8YzjYdWSWD2uK+2h6xgEUFpNaW5WTSJUUF2b5Z/3YbcVlXsTeSalRiH3+0Ufjy
         gmbw==
X-Forwarded-Encrypted: i=1; AJvYcCUqrrRBY3K25ZaDks/iPo48KZgWSq4rJeXxhkezcsQe3oxovzYf2aVGuFCjtAawfCavAc4qGZKNwfIiEjo/L52aXDJmDPAexdZWevTV
X-Gm-Message-State: AOJu0YxFkrD8VRNWaEJtQ0xyuWQcwwjVU38aYqJL1e+567O6wGBmc5TP
	ATnNRBuKLWdd3wue/BDUHWlvkxeiUewh5mQNxfRkyyGxUyn3ER+vVVvu/K+eJMvXN9HZMpDn64e
	lTB8bb8aEypt1VdhwlfV0SYOtlz1qggguUIihMfFh/HKtWNVJkjPFDPY=
X-Google-Smtp-Source: AGHT+IGTL8ll0ZVAo+i+2sW59xT7yvnZHhxBTIO3RMoH/dmzimKOr6x5yo72CYELk8Wv7G7jD1GjlrgVnQ51BpVBn00uRIU9h4r3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:374:a2db:d6b0 with SMTP id
 e9e14a558f8ab-3763f5f1db8mr1643945ab.2.1719115563474; Sat, 22 Jun 2024
 21:06:03 -0700 (PDT)
Date: Sat, 22 Jun 2024 21:06:03 -0700
In-Reply-To: <tencent_C4F16D10941CEB5AED86CD707A4E6F502F0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d33c5061b86c88c@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
From: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156b6346980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f4a161980000

Note: testing is done by a robot and is best-effort only.

