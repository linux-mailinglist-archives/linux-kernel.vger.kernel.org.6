Return-Path: <linux-kernel+bounces-335038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511797E031
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 07:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A821F214B1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 05:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B94717622D;
	Sun, 22 Sep 2024 05:17:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF20130E58
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726982224; cv=none; b=XKBqgLkrTtE400ZrqDvoalrTaw1K+l8HQcYbswjuL6fgcflbFrgI2NhwwG4yi0DZDvEBVsphpBS+gQRMVRWQkVBK77rZKTPu14bcGjXdJXB1kQBfBa9ECgP1Og5W7rUY8j16vk8ikrZijaxNGtVPnWC7wkF2EPbrQji3T/BwWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726982224; c=relaxed/simple;
	bh=u3aJKD0qxvXUofIHR8tXKRPSZiPzraTfdjsDnxXVHPA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kjA/9qSMFtrRbzcTWtcGxKt5YIobD6sed9afAWgDN/glAw0ZBZvA2m2UhFhO9Oapf/sfhyUZsuPerc8LNbX3fQNunj26DPpKkk/8QBmfviZELUtftipSdE5JXD2tMTW85gEgBO9WI2ReVxaI1MZYblTnzwTX8EoOEcWS6Z04FQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cbb9da2aso19082675ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726982221; x=1727587021;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Psx6VuxbYKYb4G/dbN6AYCxrxa30dk6LCa9p2hkRmLE=;
        b=EQnb6SvNiZzXhQxtaP8rZn8RETr2gpCYt1n9trWbpiPtXOZMqIKB5D/PHp0W6gTM8o
         bCucYMAz7V7cW4+Dbf57f7zrPgYmx8YjdHGy5GidI1d8hKCRe4OuYPJyAjuEXlxr0Vk7
         mXcIF3RcxzN61qT1yDq2bLSzIQpruN/2D3ZanQIt/7a2PfN8hR6uThlifvK1LaKWwAt7
         0nT4zdFpSf/M+iFuFhAMjr9p7A9Kh6H91hBiF/w2KT5qZJlZg2pcs0vZ5NB1gqPnzYzY
         s+JHz8S4FkL6hBeiSpOA/3l98ewOg6h1Zpt0YpqoD9AVr4TPAXFhEC5RpLLWkV1YoGjS
         8+nw==
X-Forwarded-Encrypted: i=1; AJvYcCXWTp7Jzu3WPpofEw7gvIq/OnkhnBUYLMZL3fMzwwKDjQVzCh9zrDOCATkfxzurFqVv+Q3gCOEAr7j5okg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3kUKCJk17NV+J4uZMNJlJ9LZK0hhSpCBEUKbLxfFXTDI/ZPUU
	DDf0UGbO6UiqoZMLaShf8TWzSmZlRxy8eP7UJR9YXQrcBfsg926YbPDaz8F9R0PM6Oa4LCW7+l9
	q4/Y1GxQ2GxWsvIHPUCAQzl8DAyO3gN7wMy1vvsz5k/gl2s1VCMh5yfI=
X-Google-Smtp-Source: AGHT+IEcNp/Wi7vHC498qRWn+623Ya2w/cPYvNUpbgczvsf+u2zTYovVM7w887Sq+VBQjIdmrK19zJ5YboChFFY/Xdb2E4efwq00
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b42:b0:3a0:933a:2a0a with SMTP id
 e9e14a558f8ab-3a0c8c7cc0bmr56340085ab.7.1726982221591; Sat, 21 Sep 2024
 22:17:01 -0700 (PDT)
Date: Sat, 21 Sep 2024 22:17:01 -0700
In-Reply-To: <tencent_8F67C9C6DBD2F6867309802EEE2ED84C8406@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66efa84d.050a0220.3195df.0086.GAE@google.com>
Subject: Re: [syzbot] [udf?] general protection fault in udf_read_folio
From: syzbot <syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com>
To: eadavis@qq.com, jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com
Tested-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com

Tested on:

commit:         88264981 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133b6c27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b5c53071a819d59
dashboard link: https://syzkaller.appspot.com/bug?extid=ddf8715339c89280b6fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146b5e9f980000

Note: testing is done by a robot and is best-effort only.

