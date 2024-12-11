Return-Path: <linux-kernel+bounces-442036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3A9ED73A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0342816C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D620C030;
	Wed, 11 Dec 2024 20:28:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91056207A18
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948885; cv=none; b=mQGOUz5vKoYT90/BxCEjGyQwPo3RrmFdwzVrgR3SQ5KFSwoQXtMtVBPjazx7eC+RppubtJBTrgxVgROTHora8bS7ixp4hU1qvNYMlbi4Sw88PK6SKfTp1OdrSI6aPAbydHs+PHBLP12Gav55ms4Kf8KOQLNCo/0H6LmdYGeVdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948885; c=relaxed/simple;
	bh=BxTkdHAwDUKkT0yu7rQNK7RCeSpDgxVH7CyMEcU05oE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=txNoPz3Uq2a8gpE3qZhecCWMhM917VTfb/zytoA5tsEK9aZ9uEOu63WOeD8p6M6X0vFMntprTSGjTiEIHmskJ/ihgBF/AfZH6Dpzf6zDJKdM1l7j45Kqvr2pIuCXyge7JaGwMJ0NjicnbTV0v36lD22/jtd+uyqWkupsgUxI/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a817e4aa67so52636505ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733948883; x=1734553683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWvuUMY0G+wmikjDT3RK+2qc8QdMPprFL6z15qVZK/A=;
        b=sZRihlUywIejeMmAoYTN+KT/h8izEahTb5oVpWofCdeWeygIJaTgAXSLhuCcGKG/UX
         YoeE/MiWA+qTvivxxCKDXWHJD/iGJlJXyrNlWLlqC07VM0eWTKFlRexPU7+F4s0heKxK
         K1Uvlz+QwStOlk+Iyjhsdrrv0H4g5zRykDjeIhRvt8vCvm81aodl4bMrngBePBa2hAtJ
         MVi+QF1kNtERckM7x/P00Nm2iyvpAgCgwUJsMvXGUKiGGHj8dW3KIagSMUAOf44+yKUN
         vXBnFFjWyiIp2uTdq7GoFXlhHWXL8agSR42j0pVDdsJ5BIF3+jVdqI+sOoHj4XKmguPu
         lunA==
X-Forwarded-Encrypted: i=1; AJvYcCXI3CkuinWCmMCIyC4dovS8WpI4cKlwrYAiZ1mDkJYg1I7pHMsAUsbTQ4rduWD3PlEBMKBF3MTU9IbnqdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxvBdtK4II/G55ba2o7ywOc9f1/WMEAfK9mW+ajP+1ZBTPCfk
	TsR5TgvBWlCisO+AEkcQubbF3N0dItbxrmT0MbCklfs76uJvVqNkcvjSZ7udUefLfQVdRvQ1VeD
	FDw7EVABD628F6nwylmL8AvRa3dsulJPM2BeOAT04pW7Er19yf8DNvUI=
X-Google-Smtp-Source: AGHT+IFU4/JJhgeFmeUgOTOiFlptRuRRWPCJkZ0E7Hx/P2REuhArQvWWkxw4t8dMVmrVYchAgd8/ib9uHjlZQsLpg9MXrqKFdQ0W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1609:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3ac49fdfa0emr11002455ab.1.1733948882793; Wed, 11 Dec 2024
 12:28:02 -0800 (PST)
Date: Wed, 11 Dec 2024 12:28:02 -0800
In-Reply-To: <20241211200240.103853-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759f5d2.050a0220.17f54a.0045.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in __alloc_frozen_pages_noprof
From: syzbot <syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@gmail.com, ericvh@kernel.org, 
	leocstone@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	v9fs-developer@lists.sourceforge.net, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/gpu/drm/i915/gt/intel_rc6.c:139:19: error: static assertion expression is not an integral constant expression
drivers/gpu/drm/i915/gt/intel_rc6.c:140:12: error: static assertion expression is not an integral constant expression
fs/bcachefs/str_hash.c:164:2: error: expected expression
fs/bcachefs/str_hash.c:165:30: error: use of undeclared identifier 'inode'
fs/bcachefs/str_hash.c:169:55: error: use of undeclared identifier 'inode'
fs/bcachefs/str_hash.c:171:40: error: use of undeclared identifier 'inode'


Tested on:

commit:         91e71d60 Add linux-next specific files for 20241211
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12987544580000


