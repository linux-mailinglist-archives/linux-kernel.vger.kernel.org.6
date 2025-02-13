Return-Path: <linux-kernel+bounces-513170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D362BA34351
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8794188AE00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458B28137F;
	Thu, 13 Feb 2025 14:43:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE774281379
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457784; cv=none; b=kbylh2qpuoVY+QKCF8Dqczbqkep1bFzqkHNHGoIhbydI9yI0ZS90aeL794GW0DUOcfOi9taGt8NqrIgffd4DEeeMEfgzS2Ady2arSDbpD56soixm2jzpLClz97xFowCHlbguQZYlXXZb+Lpc1Z/1w8WBBpr0W8v/EeFHQjYG/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457784; c=relaxed/simple;
	bh=hssgXRzN5sp8Z4bPh7uqwzDqDJardDNU7CXOhPBUY+g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LM+clLfRJ1NqXHLC/J78DS4HgI7pTpzGkeZk4NGE9jKK+TVqGsXv6ydhb/rsXC8Gs6NSqPTgl9RBHE0VPFUN3eqt3pPPFAFGAxHxSUeHva0pk4SDk7kuunfgOY17ILrL//1vzDFVaUehdFQTpeFyBfYdicnVobToZIP+fZKRsSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d14c647935so15247685ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739457782; x=1740062582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtYgjaawxqwrGlp+ZT7f3Yc8UlCEo2UrZOsFiidUnQw=;
        b=Jv+lwDN41mF0romX3IfJ5W+it4mqbPODN7zQDwIXGmfMaNswyN8G5dWV+rBMRLBJLc
         kkCTH5c5/HL3lyBxNM1X7b9WK68BQNpXlKNxouz3o417HH+QgIakPZPjnOuUujMJ07rg
         xw18ZdPrQKgq64FSMWg4AIGzi3pb0RAe5+bmLK31jRjy2V+eYBAMGnZaqdfwOV/dXGVZ
         IaY0RVStWyLV7uP5fR/i3ya0oP0J5GlvaaEKz96NVDg9vmJzYhi2vXvArq/OtWRWkoe1
         UX/kZ/KgRCWGa8tCezTU6O1sx+z0U+Ban6S/atdy+ufb6dUxzdNrdNNHP61+y1PId0XF
         SZBA==
X-Gm-Message-State: AOJu0YxsYEgPN+lK5/UY9qTmOLqlamCAjoSTBLVdCdtko2izcxNS01AJ
	1VADY3KDEIdQattvEOKg1l4SH+KJcbg3KNsuoZRN6hU4Lv2Jn0WGvTMvA9QRl9LgqgO+veTBS2X
	8wB4SpjuZT9eFcHUL7YcQeQ9br6zTDpbBfnFsBIoiYtP5Vm3wXhOQwAE=
X-Google-Smtp-Source: AGHT+IGTB4YG6Xzar0SL3FIPdDSNxJ3aQOUxtHZWEFfrJ5vhPQQx3IdGz/nx8s0Ow0uukoNp19oNNbWECwLB0Iz0K51b4dQ6Ncr6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32ca:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d17d07782dmr69116325ab.3.1739457782182; Thu, 13 Feb 2025
 06:43:02 -0800 (PST)
Date: Thu, 13 Feb 2025 06:43:02 -0800
In-Reply-To: <CAMp3bLWpY+4pZLx7XifYSBUC869T+S3QF293Hy4bMYvdCoj_rw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ae04f6.050a0220.3d72c.01d6.GAE@google.com>
Subject: Re: [syzbot] [modules?] KMSAN: uninit-value in __request_module (6)
From: syzbot <syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ld: lib/vsprintf.o:lib/vsprintf.c:625: multiple definition of `s'; mm/slub.o:mm/slub.c:4075: first defined here


Tested on:

commit:         4dc1d1be Merge tag 'mfd-fixes-6.14' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48f90cac5eea091a
dashboard link: https://syzkaller.appspot.com/bug?extid=1fcd957a82e3a1baa94d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122bc9b0580000


