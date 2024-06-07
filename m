Return-Path: <linux-kernel+bounces-206213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB059005D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D851F25B28
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39363195F38;
	Fri,  7 Jun 2024 14:03:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A7194A54
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768983; cv=none; b=uMmtZMgeM7DOull6vRJ5mAg0dMuZZy9nLFdpJcoW14AT3UJRwG7v9/Sem1jC+UDtQF1J/ua840y5eZfqmoMDl8UHPUfkfzqAheDs4dNdYpTYQiKJLlz5g8MPnVF0XCuKZLaOHI5RnihmRu8onK/NG7N/ZrhTsq4vAgKz+UT9WU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768983; c=relaxed/simple;
	bh=CKgfhw6/ZDdh9Blfmp4KBhEsk4kfyKIKVpJC2foBoYY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bCCeZph39NF6F0VsJaMJoGwJmJ38ieXMnmaTWjAqUhc4tpZo2g51GmgFNNc3yNi610fJGCiaJj0qT7OhA4EHeehKnh872vxFrEbDCo5v2i16Ukpp7QJn3DFHVq1t1ImFeZCWpzpr3JHkvbF/kooB1pGriuEL16yqW4Kz7SwqVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3745fb76682so20472765ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 07:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717768981; x=1718373781;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbtXZuGOkAcxtxulfmJ5MU//nTfP0FkKxWMYN+3H4OE=;
        b=pPVsm6xvmO3aMZZuewkFyZYNF4vROa9tJfa9RD/bSCLJxdJb3swskMwRPqjrGEuMOQ
         cbiIxnx565LD7CU4DxBgT1ZoEgw9dgDHm40uYOu/vkBBVTRlxHREVW0Ni6W9idctXOXX
         3S3tPgLxbz2CdrWz4MPh/5tC2nYO8wrigHC1s5RAnqTBptEWED8gqYKp6NnsdI+URKjK
         AZtcdFs81d+ZCZiSvrmVGQh/GKxiLqoqd6r49mJCvx8m/+tMhOuPzhVixN7jNChdaS3I
         SHCeTtoq2Yw/V5QJvS2YPXG7sYoJ9Jgpb7qjpCxbcf9z4cdUqEz3spJyVtecL1k7HV9Z
         qMJw==
X-Forwarded-Encrypted: i=1; AJvYcCVRY/X9W3pyf9ZBrB5UssYBq/+vzM9JeC9UlIhNtHbtDPXKP+4AnYGVm90pLoL9XKA0qeLqlpGK7OHNlijFhjDY+4f1Zjb5W6SpHRO1
X-Gm-Message-State: AOJu0Ywr/3iXr7F2g0R5xJ+Qpxq3INMq/0Q9GkrEz6+ghuTBlvjvITpi
	Tp/KFaSr0VJE5fpS+R/sRmIJsX74xTy1UOqCPlEyxGWHTKtKl10W9yfVjoHNI/HUsrK9de+eIgM
	G36bwb5NMD9Z+4KpBr/TjyPDBylYMS7jgnNQsPiyiPV30T4logJMEh2s=
X-Google-Smtp-Source: AGHT+IGPtkfHB2j08ccIIGTls6mKFZGDEUhUOGubAHeTHT5GL0sQHydt3JOQAJ0BpSab1m7DBzRN7TBaozD6R7z5V0dedkX+P3O/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:374:b6d5:aecf with SMTP id
 e9e14a558f8ab-375803a79a5mr2138935ab.3.1717768981640; Fri, 07 Jun 2024
 07:03:01 -0700 (PDT)
Date: Fri, 07 Jun 2024 07:03:01 -0700
In-Reply-To: <1047e6db-0a9e-4e9e-a39b-e1bb55984f4e@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f50aaa061a4d41a6@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_truncate
From: syzbot <syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com

Tested on:

commit:         9012da7c hfsplus: fix to avoid false alarm of circular..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git misc
console output: https://syzkaller.appspot.com/x/log.txt?x=17244a6a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

