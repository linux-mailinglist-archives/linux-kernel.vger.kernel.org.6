Return-Path: <linux-kernel+bounces-526821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D3A403D2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A957AB24D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FB254B1E;
	Fri, 21 Feb 2025 23:58:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CA288CC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740182286; cv=none; b=Vt37H0D793G9BB/9mFhgdy84EK3ecaCeg2UBIMq8dgi/Jy8OcTmIRHL2M3H5qQx3ckmGW+pOKSPgzPp2wr0elGQy2j1l97lR1UJ7eCF7B/vATi/hY0yOo0eaEhM7qcOy784h6TcpMVdTxgN/UirFypmBP9a0YK2QdFC9okpS3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740182286; c=relaxed/simple;
	bh=0cMls4nD0wJWwZXk6uLf7tEepX+u/JmyxbXFqym6RBM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U+aDT9QZb3qLGFL72lNmFyWrt0AncQM5D3vmnQlC/ZmyrGXYC1POW//IfLLrmbFxDvwurBHWeFale75O2pPrLaGI2UOVHZ0HteuYGMqSw/UBSd/HKIlxKAswUnQ4yIWQFZtGBT7JU5YFCrhkTIaIi07B/Qrmr6OA0A5ov5khTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b3882febso16509845ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740182283; x=1740787083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ+wlPVroLeJHnFjlGWCqOVFr5VwYQT9DQOZkkLiXaY=;
        b=n2jFil6Txun4LSpoQsq6wXy0RsDQjkycthpyFbWKsiZ+xPiGRsJcrSOcPlss7aaTb5
         dY/BlHpxaYVWJikNVGQQTaxkrLPcceJwF8ZGbc8rfrVnD5FhJcJPzDZZZAq4BV+REBmG
         OdNcWvH3BgkOFwb3gCACSLgrZICigjxMrwYiNDSPXuVKOCbISzWzgPG2aJg1dJU3opTv
         wNmL5XwSAvY3HhAAtGMzGjwR8niesfgu4J9DLFlOGZ2roNy+gh2igYWbvhdrPx3ZcMR/
         6lwsMYft7N5JIq0kvqG8Y/6g4Ky8TS6dNJS/0IAmZKDOAUgh3SraN3VY5dVmqC9ewBek
         cg4g==
X-Forwarded-Encrypted: i=1; AJvYcCUqzeWbkgwzUG6DiuuTibCkgtG1md1c9h4nfSl7nsJS4BnDh/gIHsG5bH2vQruGTIHkkvETg6grrpTZ8Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDXdOw8SGXy0JOMk9C9IHb+s52renL7Nw+WHPAmMtj0a5lTvh
	dwbFYEy136YMLZm7xcAgSkK7g2x3HcEvwHRKbYHCsvQOcSO5xxLv0fi3WysyjiMEbHoovNP1zef
	MAS42QFrrvvkX3V6hoWMSnSoH+FCgEFiS0V6MK5koClZSpP+YmtVbVR4=
X-Google-Smtp-Source: AGHT+IH3O42RZ1pzh2lzNJLxan30uO4WMh/yOceyEp15D84JP2xZvkz1yH/+lxJiSyLp8FR9XJy8+AEiMDGgc4TLdZiGf+ramC+p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:3d0:443d:a5ad with SMTP id
 e9e14a558f8ab-3d2cae499d0mr53580665ab.2.1740182283105; Fri, 21 Feb 2025
 15:58:03 -0800 (PST)
Date: Fri, 21 Feb 2025 15:58:03 -0800
In-Reply-To: <20250221233542.2507-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b9130b.050a0220.14d86d.0599.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
From: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
Tested-by: syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com

Tested on:

commit:         ff202c50 Merge tag 'soc-fixes-6.14' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b30db0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=635cd601ddc51632
dashboard link: https://syzkaller.appspot.com/bug?extid=c0dc46208750f063d0e0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ec3498580000

Note: testing is done by a robot and is best-effort only.

