Return-Path: <linux-kernel+bounces-225950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D433913843
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB069B22051
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83464182DA;
	Sun, 23 Jun 2024 06:08:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5416419
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719122885; cv=none; b=imN5C5G5YV770YIXMN7j5mrHKROUxKYuyrOvA6HIlUdX1mz11rtXK2nmYEFbZEhi9bJb7LEvVXwCB8nLgdrJaLaT95tOvjzBZb1pU5u9ukbWjMjywreOHVXW/NMffrVJXJzxNNllna0MDm6jX4gfPmfpCsP9074hCRmPvndb3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719122885; c=relaxed/simple;
	bh=dH/sWqCfPEMdfLRXOSHl8z88ipnUMfzZ+7c2Q1neIIc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VxwrcjwjjhGdfxSUxak+7N75QT4ShQ21JaAfam5p+X2U5kpnbqcU0sy/q7cEJk+W0EFJyCAi2a6ht8ggr6/d+SfF15R7hoG7iEZl3GOfeAi97u7ZNQYm3MfyyfHJBH59qY5vx0akOeUSLjQJW3ZtqB5+CFfXsAtfW5TO3MjnYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb80de5e7dso409130439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 23:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719122882; x=1719727682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPICIzWFbCgurqVvK8aHUyyeVFnm6jx96B4k1izNwqU=;
        b=hlXAzdSGhsU3pbJWSBj+K1KCXlTx11Et2dzUBZTzCmKW/+vG2IY2uEfje3Li1c6iQ0
         ivwletXwnUQtT+I25EkanCmPJ4P+yrjAkQcvKhkDIZ+0EsXpOlhG4DNqgrKmfvdunsto
         QpGwTxf+GTyNCk/d8ohmaHPtLnxnUM8nrilMB5OPgTH0LJhw55x7vkGC+WAVzUeFMhDT
         cHo608pV9p+1tog92D14mXTLsu/lUTnN8TsJw9Fsk96l9aT+V3tk9oz3J5PryfcxtXCh
         ELJAVbR2+61D067MUSg6GZ0RbrURWyQu4+lJUvCXNLUZupwJ1qh/Ev7iY74w5nG5mVaZ
         OwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3OiVr51ofthwMWYK8rwkvPzbzYtuRsODm/PzS/PJtFfoNtqKXB8cCtqJ6spUl80AbGgCtv+XDB/TzKCBiju9CadmDKfnkE4r+n8q2
X-Gm-Message-State: AOJu0Yybi+KEsafEB7gGAKAIX3eN3ELKeyf1pnSFtoxqBW9BkCeetNB8
	weHvJ7qyochQuRUI+sjZP0E8tZ4R2iCnbeA/GZg/EhzBSu4qg0/bnDs1yxDX8pU0eNRc85iIyi7
	v78YsNnZVdfXUFBKT6ng7ntW7VNsGZ6Zz4mSkeKNIpl2lJQ+4Yx8fnns=
X-Google-Smtp-Source: AGHT+IFDMj4JEdUjX954xPF2bSMvVdLygkIJG5VYn6x6pvihs5Oa+FioX9xBxGej3va1rK3NotvVyE9LKH9NM08IoOt0KM/b/Y9D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8b13:b0:4b9:ad96:2ae1 with SMTP id
 8926c6da1cb9f-4b9ef9e9f25mr26228173.0.1719122882367; Sat, 22 Jun 2024
 23:08:02 -0700 (PDT)
Date: Sat, 22 Jun 2024 23:08:02 -0700
In-Reply-To: <20240623054314.1929-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baa654061b887cb2@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
From: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15810b46980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178fb071980000

Note: testing is done by a robot and is best-effort only.

