Return-Path: <linux-kernel+bounces-281756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9894DAD4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560FD1C20F45
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 05:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC313C8EC;
	Sat, 10 Aug 2024 05:06:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B913958F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266365; cv=none; b=KJ0I7vqFzhC9XDskBqSYrK49ivdmCPH9JiPLhRUy4wa8SmVM7pLvLGQtk7dWmpr2uKvSgB8GgSeN7DYkf38D0Ytz2YRZni+suuk0EtupWwqkbgN7cMJcR5ewLuBrpQUFj+9kydvFv5JcIA+W8OfYWuAutBGewmjcZgdcI5DyjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266365; c=relaxed/simple;
	bh=/7uc8Z4Q3ZEr8R0keMJnUERoXNHLMZcACPIqGfwSqBk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tl4j292L9GClHVHgw6f3Gjt7dxlw3QReZSbCCGfMmPSzmAw8kGeO2vWDAYCrwGYulbKZwLnlXMeGBJB4y4sqYk0U3x0yJGutqHWnZd5yr5wSRgwBEsrwGxszDemqVCCumgGdAeH4RPgEq20iNAxQ2l/gUEi1oDAWLExND0wHcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f87561de0so311957239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 22:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723266362; x=1723871162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJzHHhFTs3eZa8zOnkLcr2VdeIWvesEC3cX2tGLvN9k=;
        b=r9WOmEbqNtgbeAUONAoFDwZS4ILbCfmN6qhUSuT5RyGBJPPchpBB4DNATMWHIfLgsy
         7DexY3GOXC3bncF3+1sLVg+xC8eEN7BKz6raLAPJ0VTbf7N5H8/oImAcCx5PmP+KTnRH
         1asMhvPK9nYFlFj+9L+frivg2omMault9Zt6+SMsKI/9MVh8X7Ztxfu2VEPbZUa4DEsK
         1hYvhlhfB5MtDxBaFA7azjdZlnrr4Dekt1rwiJw6EcXpxOtdMR1I8DJkak7RzvnEZumB
         nGOVc5MwkgtrmkpK34eUgfaovLeC1G7ZJH8LVKWKuSshb8M1YQUD7bSNhm0rBorLjcPU
         hpGw==
X-Forwarded-Encrypted: i=1; AJvYcCUr8SahqdEmZlycnscRK217pdWeQ1IHQNYEYsp3vsMFQbfTcN7H+cH/9xsqiOvTEBFa0zGty/gOQy/YRX3aGhYt5Xh9iiVAexoTYUmd
X-Gm-Message-State: AOJu0YyYrkwt3IFSGjCVaii51bTbMn04dhhGbhMgbvvIwAcJmIQUARNL
	h9R4THGLyRrx5fbHXJQfCXkG99KCRY1xnTBHhVaNes430HhexmJnJDr3kfHB1HkieQm9FRBHgo9
	csB6gg1rWgy36wwKXgZ8UC27O2soUjp1WbKkDOHJrDkhqXAxDl2Be0us=
X-Google-Smtp-Source: AGHT+IH2MO9xQPt5gqo5DiWjroh4Yv8s0fUSJXXjvooQDu07jNG5gyY7dIR0kgDL5KMwjhE+rFM8p1pOjV6HddUINuABtVUK9EST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8405:b0:4b9:ad20:51f7 with SMTP id
 8926c6da1cb9f-4ca6ecc9a63mr122066173.1.1723266362435; Fri, 09 Aug 2024
 22:06:02 -0700 (PDT)
Date: Fri, 09 Aug 2024 22:06:02 -0700
In-Reply-To: <tencent_A4D16DD09714EB42ECAACD247A966CA42C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062fb2b061f4d37c3@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/9p/vfs_file.c:409:38: error: 'filp' undeclared (first use in this function); did you mean 'file'?


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a9b97d980000


