Return-Path: <linux-kernel+bounces-288705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF62953DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668E728AE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA8155742;
	Thu, 15 Aug 2024 23:05:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500C1547C4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763105; cv=none; b=UZzUDk6DwGi5m2Q9oCGqal2RVw56/jlVX5XaqaL7WGe0/WjfW56R/qhImFfpOe36FxJ1G//eukMaBCLdptCEj2qTGwLZTeZa1UInyzl/sCqAAzsCE3O4I70iJymCgPYsc5veFiIZuhoo3DXl2yLuuU3cWVUdqPX+8OMQnnXaty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763105; c=relaxed/simple;
	bh=YJy4lc1bj1TYf7510AE8IFXj1VVTCYd0vazW6/WlNzM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=odjNWRIrVpITh2kdHmmL8hvkDWIiRF3+YZzYjn3S1JKcKgs+yIPCA2my8ALbIqdDZy7wbunWzH66Qcwp6sMg3JoPzMWgsKqxMvSbJT4ul35UR/Ny/y2zoRGXv/6E/tcuDmDYOBb0+LnnDaX9WkUfYG/CEkAR4z4+moImc00crRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b64fd27c8so15304565ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723763103; x=1724367903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+8ExRki/2mPUy45OfRjcI1ar0bT71rPNzcqjBT6Qbk=;
        b=exoMRVo4YBOlX5OWY1Ftvfc3kks+ntTza+StDLc/AY+8gOKqZaf69ayVtoGU8n0pIO
         Uy3y0pR+9dvjuSiAWYFK70xM7KxGw40To3EWRrfmGbiZ3tEMFyzPFjpjl+/nlPfyjbfS
         /8phZjLSrBaHEF+83ZKJH/XgIRXl4TEuxx5tu7QtW7NicnToeWshNYG5fQg1vhXF9JcT
         iFO9GsPl5LaYudcOmKh1l/wjFqKiyi96qzuKFkQHx7GK53GWpxLzgfqBK6olc4VKplU2
         uPf2ps7MxCxVYcoCBkYX34lv0N9umReRaDbRqAQOFxMEv8jOc8RWcu3Fk4l/O8mMsaY9
         tdLw==
X-Forwarded-Encrypted: i=1; AJvYcCVrijdfTr5RyecdiQq4t0myGnQwzRUumacbpqbroCSGE9YyhnoG3LZikeXm+AP+sRpdEsXuI+qnKTA3BzSa1gHzQWm4d2qUNvBg+sa1
X-Gm-Message-State: AOJu0YzI3umv6pw9n4ZDJNE9SGepdJw/PxXAhrdIJucBXlUIzwLJ1nJL
	2XmOO52yhvMs7FB1HwehCxgEtgWQzHVlKgT6HkpbY4kLb344wQs3cbcyju+MKqYu3b31Po84gM2
	b3qB4X+2NhelXu8a1qZTflQvTMxV4sbTo9aUcworVZZb4zKHwRiA8+rM=
X-Google-Smtp-Source: AGHT+IHCqUKgyfh4Glqj+SXRyQpWyEExNQX1Czm9+5oSoupX7wou9+kboOgmqpPSXFZKftq0jlheM9d8RbO0QawuUZesZUlWmtk/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:39d:1236:a9cb with SMTP id
 e9e14a558f8ab-39d26cfe4e8mr1100085ab.2.1723763103022; Thu, 15 Aug 2024
 16:05:03 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:05:03 -0700
In-Reply-To: <Zr5+SvVwqIWeO75m@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ed636061fc0df15@google.com>
Subject: Re: [syzbot] [ext4?] divide error in ext4_mb_regular_allocator
From: syzbot <syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojaswin@linux.ibm.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com

Tested on:

commit:         e724918b Merge tag 'hardening-v6.11-rc4' of git://git...
git tree:       https://github.com/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=123767d9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=1ad8bac5af24d01e2cbd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c916d5980000

Note: testing is done by a robot and is best-effort only.

