Return-Path: <linux-kernel+bounces-225932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448689137A6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BEA2832B6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3661773D;
	Sun, 23 Jun 2024 04:40:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDFE15AE0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719117604; cv=none; b=LMowU1hRLzE4ZvGsobHs6Y8NcM47uNiaN8tKGEJcnjEU5F/QNlSqCgc7I0OJYr1fTz1PD1jduTGJr6Pi25GSauxvSh+Ya5BOK9Z5FU2cD9qT+94tgv/Gdrt0shmkRVDzaiFjF/7yfiAFraeMQI77iSP9TDsd2FaJLTIFgLoToHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719117604; c=relaxed/simple;
	bh=YmuFgM/yYZW/83m/v6K9lpXLhnGk6RtCsPrqEGF+mk8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BUsPAIQB6gQDeUbzLj/jLakrtuar6F6y1mtTgpzrrbneVIxjoZ+eSm0brE78ksBoTOTlVEoN5Tu0wBfmIN8F4GLFpIrH+A6DMSsNH0/5ON7znjhlzd+IGMx6ryOhy5NKiqCgXIqcskJa2lgAc34QD7wQCZzdKqXAvKTkeeZWDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37642e69d7eso1987865ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 21:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719117601; x=1719722401;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWqUR3qMYlJXnl/VDa1dxDgrKGZ9UYuvg5D96v0JaHY=;
        b=uTAOj/OypZN1Msr3rAP9YhfA8yOqj3gElgg9mQ2P7LUPHZO0n3j1TgCZ8FvsrTE9ni
         OfFuPT+TiwYyTyoO8UBr1P8WLHv4qSv8FKsE0u0uc/7fF0TuR+7BFtFf06eo4S8IPlH4
         q6kpe/8SMORE2wZUjIgvHawraQxVMv4VNBFGZdY9ZJ7KllPUJViuSjFwpAHhHiKr/1vv
         VlWhRIpyJdZ0ifIwEgkN4fKuBebKGrddVVLN1J+nesDmz+oGwK+RlUxwn087meHgAuc/
         84lGItr/6W4QkmxwMFvoaaoNLrrV0otWPJUxu2goOQAkn4A6wYFb79eDm89whH8GrzUQ
         FayA==
X-Forwarded-Encrypted: i=1; AJvYcCUxUZgtlpgpQVDmJO+k1aT7i9DCP4kndg0oaGmzZ0ZK6uI8+hvxjjSGb51WlNjDPVUi0Pm9KR7RnNzfU0qmObguh+JEyzSZZrZseLdx
X-Gm-Message-State: AOJu0YyhQ3D/I75RNB2r0n+9nvh1zXUSAcp/3/uHnGV7d0YUye5yT0Cg
	g0hBuprmGAkWu2IvbHfD0CCS/dnblOyq5YMciegtRpTE+hiBR+Uv94/pEPUl1IywNV+vuoLa6qT
	y7r6GCBk78LCoUD+1MxrAfm7Rbxw0376vgnHnqEHdv2vGROmzvEmQBfk=
X-Google-Smtp-Source: AGHT+IFI1UYgwnKdq8J8j+uSsM3yj2F8J613tN807F2ytILYZff1bPIlMLDWEsMDSZHKA/ZKjLKeS4i1NAf51hCv/yU/yLiqyl6l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9b:b0:375:d682:bfe3 with SMTP id
 e9e14a558f8ab-3763e2980b1mr1897145ab.6.1719117601781; Sat, 22 Jun 2024
 21:40:01 -0700 (PDT)
Date: Sat, 22 Jun 2024 21:40:01 -0700
In-Reply-To: <tencent_F9D62EDA8CB367C4C6FF92DB065589966E06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb4aba061b8741c2@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17dabd46980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1126b551980000

Note: testing is done by a robot and is best-effort only.

