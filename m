Return-Path: <linux-kernel+bounces-346826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8698C96D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CC9B20B62
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978A1CEE90;
	Tue,  1 Oct 2024 23:25:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD7158218
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825104; cv=none; b=AD0Su3P9YK17AM50n0T7JbsPo7H9otcBUSxc/gRQqgiaJmfTBVGSlxPH5Z2tiX4lRYL/r4UorpWO34tMQHR2oMgqpUpY8Dw9H2MT4uir9O2hf+YdTYEQRmWD6p39qO6Uy295kWlNCwlRM5GLpjy0eGbzUgsYDTpF0xitoPx01UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825104; c=relaxed/simple;
	bh=iTTpMomo4biBJZukm34VUI3wvGO70rAc2cXZ+6Lg4OU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PulcPNxchTYmT59s4Bg9HL4S5/75BPZA64q8Q2Jiz8OM6SzQUtH5XeRU3QGV314ghMCMmY4g2EgCQv5UmzKmtviDjofj2OcAYfkkD6/WIcLP4KUg+TVc0sfdvFEbQK37PK0Ig9oJ5D2xqMrDhRpds00tzy+e3emS9wTUyNMsYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso3160445ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 16:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727825102; x=1728429902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsMQId/XwYhOxE9d7W62Z2F688TIyrJGVMr93l3gO0Y=;
        b=oLMXR5M0eUlG4VMdVj43HhUHfdqm5F+qt+Yj2NSMqGKfsuEavBMTXQwGWwk5+KDiJK
         BZ8JEO1c9ldd55+/FscZ54AxsubkA6mbPCWpsJ9OHq7YA4SDlViemQ4YLpSmJgThL91D
         0DRGzgzMsnlnSKdnRY6ih7jP2Nz6EEhrLZ4MeNPVxFmgcoO2BsjG4c9FLidbwew9P3oM
         VDubFuATc9rT1unJ8glbm4zbffEdXRIy+nJSGw8xXwijh8lgKv7p9aDJqvK8eOZGTSWH
         +MFru3VDAjMZJ7Qmj+bQIbVsJMwkKfnL9QBGR2wCvvziZ5bPFnbR8FAfGs/vFmW6St0R
         Deiw==
X-Forwarded-Encrypted: i=1; AJvYcCXj5vDDLFAXf3J8aXM4BqNPbxuStfIxv7G1m8PbdwVeOH9UCunK4GgfDTgqCcbQzyDs7A/MsM8gGJvUKOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+NsFFU8q3vivR7+Dyta20tz1X1K+TIfIY9bI5LEhJb5V0Fcu
	t31mfmrxh4xambGW8otTNPzoekJKhjWqxRbHW5fYe9vFf7CeSCMMlxQcv7Os2EP/syZ//x5aTKu
	wVk+D7gQfTF/hmW60507rSc1n11TAafCo9VbR6lC2ZXu7Xnv8I/78PhM=
X-Google-Smtp-Source: AGHT+IF9vRyi7062yAWYdDjb45E9WNZeDP9QACERv5jKJ9PqoQsqctwe/rnQ6dkNdqAT1LDfYnKZHffsTcBkFNnObdN3Dpslkl7v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:39f:4e36:4b93 with SMTP id
 e9e14a558f8ab-3a35eb0c614mr36026985ab.6.1727825102642; Tue, 01 Oct 2024
 16:25:02 -0700 (PDT)
Date: Tue, 01 Oct 2024 16:25:02 -0700
In-Reply-To: <66faaa4e.050a0220.aab67.0032.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc84ce.050a0220.f28ec.04db.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: out-of-bounds Read in copy_from_kernel_nofault
From: syzbot <syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andreyknvl@gmail.com, dvyukov@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, snovitoll@gmail.com, 
	syzkaller-bugs@googlegroups.com, vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 88ad9dc30bbf1b08bd1dddedf9ff39019f469b8f
Author: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date:   Fri Sep 27 15:14:38 2024 +0000

    mm, kasan: instrument copy_from/to_kernel_nofault

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15848307980000
start commit:   cea5425829f7 Add linux-next specific files for 20240930
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17848307980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13848307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41a28720ed564c6a
dashboard link: https://syzkaller.appspot.com/bug?extid=61123a5daeb9f7454599
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dbf127980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dbf127980000

Reported-by: syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com
Fixes: 88ad9dc30bbf ("mm, kasan: instrument copy_from/to_kernel_nofault")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

