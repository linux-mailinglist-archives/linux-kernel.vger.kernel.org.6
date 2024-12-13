Return-Path: <linux-kernel+bounces-445715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC679F1A39
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70907A0563
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B82B1E0E0D;
	Fri, 13 Dec 2024 23:37:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7881B85C9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734133026; cv=none; b=e64C3q7y8LpXYi9bytweRg42NO4gsilT/5uEwyAozj9yKTG0AA2QoS1EsVR6WNn/b+6ukUizOF25JEz1mVzRlRUw6G95GgYJ5miqgOGkzIDpmSgBE7jjUVJk3ICEDbOg+EnSM7pU/CiFboXBzv/yDxbjev70nlVj2CaXUriyBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734133026; c=relaxed/simple;
	bh=tMo9z0KMvVLPZIk8gJBJFYqrwSB+a0gupKMzd0Lb4sY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YSLR4xZoAZjEdwftp+CYSE4Jmwreh89VEfrg2IpAAvQJk4fDh8RYTmewGm9RGHWQE0BB+RqqffajQyHqs2SxQ+jERPWuVBrnlyQjjh57r53iCplXdt6Z2TzaJZ7vX2JQtIHilz6Q3DFJHaUEJDtl7DNNjaEK1eJSo8n29yRF3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ab68717b73so22072555ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734133023; x=1734737823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yun2ZwFdy6SoRPdNnMAcn2qkYLCbCofrCyTIGF8v5g=;
        b=tx/olb5f0jwynwsJ2dcPjE2CoJz9JeKr9M4e3OpPqi2NeORbFLl9f+cGGI0hOY2CaI
         LtJjyKTUOq+8svw25Qchxr5mpd6M0dLdlNnao4kJM1Q1tw1kkJ09uZ7IQDpK17cCNEi1
         K/Q7Xm4eInUzxkKH5VgZX0NLoSKzjTJqj3h+bic8GgeiOgJpHs7pdZ9ziScL+0HGwFqW
         yPdplFixA7g7BYKZNvXI8eiSRSzEUWvYkD+SgFw9zmvNwdnM9Ye0DhRm6FTSL8MWQ2qD
         wL7jNJGTg8uBL1Spp+7XJZnAJoxGMOeTN8IqRWs86RPTR76kUl+0P51Iuq2EQpeoV1MX
         9TWg==
X-Forwarded-Encrypted: i=1; AJvYcCWhmmNOH81nAnDOhmVEvWlf8ILwsDloHsOfteVguI+ysiCfI7QrtDdOvKbqc9blUSQm4H1lHMUCCbY3pH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1M+8y5KNa24oSIIY0qyKZZhRShYE7uYxxwn2mTKq+M7daHV9G
	FpfeT4eLxrvlxgcQ+Em5kvocwLiXzW2NSbKq6hvNu/TF4YgFy9+YP2wG9RHXapJ2hwUZGpzKM0F
	elc9M6hCN5XbIXU5FWVJ+2KENM/TkAlmhJDcpML6t0kANoXzndhvDy7o=
X-Google-Smtp-Source: AGHT+IG+W6ImB9SjfMRf7eoERjHcXQJViE8cx5y5WtFAXU3eHvoGO5IPYzYQIPGTjtM8onQDXB7p+BGkR7j9vKs331EekEgNvBLS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2169:b0:3a7:e86a:e80f with SMTP id
 e9e14a558f8ab-3aff4616efdmr64163395ab.3.1734133023743; Fri, 13 Dec 2024
 15:37:03 -0800 (PST)
Date: Fri, 13 Dec 2024 15:37:03 -0800
In-Reply-To: <20241213230820.1957-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675cc51f.050a0220.37aaf.00b9.GAE@google.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
From: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
Tested-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com

Tested on:

commit:         2c27c766 Merge branch 'devmem-tcp-fixes'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=121ac730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=4f66250f6663c0c1d67e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1042a4f8580000

Note: testing is done by a robot and is best-effort only.

