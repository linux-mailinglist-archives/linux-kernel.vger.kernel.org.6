Return-Path: <linux-kernel+bounces-435109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341919E6FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82F0188272F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938A20ADCA;
	Fri,  6 Dec 2024 14:03:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A42066DC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493785; cv=none; b=SAsBuVW5/lSzh1UZ3pmXsUnw8DapPUGzE24d9rfq7OffZ3YsphxjkXq2UasTUkBjIaIA1eMdxT+yFdqsbv9IIxvh1bTx3lkTb9crS4YPs5GM70yoOzWzCKporg0WcMO6+xJnUPZR1GkoYBxEYxsRR+OxxPnwBqkHZsIequUR7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493785; c=relaxed/simple;
	bh=6+6Y0OqPjh05gQKta8TJOUEKbsv5T1RD38jiuCnEUOs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lb+JpjlMy408dRO3txziNvbPVu1e1SvGdvhQipr77armAs3kJG0xhsVGX4dpDi1a3f3ibn/3wHFWK7QVrLu0P3U6n1FoLEq+VPIE1hpuiql7lraomGunSTkLdVZWOpedQAypm4HzukBK4o+JPsO3hWovxoxvK7cL5h6Y4s9rMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843e5314cb8so184091739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 06:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733493783; x=1734098583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8XRj9YSdQtdr330AmGTn7DJ03L9ZcrLYg9DzCdnjMM=;
        b=iggQPsWC5JJCo4dTeRw+HpwL7qbTbwtSnCBSBp5evWr/5Iz41CysiZuxO1T7yic8YV
         pTkGnIiD/Ka0PBSqwzGCT6AbQzn+0wBphanU0y6nhI7XoeGzww3+LvI+n/p3zx/GuqEU
         2BTiPO1gTt1f1iVBz4FOdicTEsut/I9G/4hd7myRSmg10gZyjss5iCo08WezHSopkQJy
         J6eAxSG0NeOdc6Tq+KFEGtQRE5xKvYe2WWKr8DEoEl5Bb/Bf4IGQJVB54v2+JPGvMWLc
         +CW2hTXMR3lr9qPRbhw+iEcfpXLwl4CyTcDvcf1Xpstip+r8HrPAchBGxS4k6hgBsGPF
         Trlg==
X-Forwarded-Encrypted: i=1; AJvYcCWiu+WcWc3la9OJg404puk+gJMvl+ZP29wljI/07oV0rmTOQuZDA3lo/FmAabWkkNYIWv0MowN6bsbwDUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVGVqIHOERRbjD2d0dhBOCbKQLUXCJxs+uFSvasGSgCZDF3JU
	lbjBAblF1raFTUAvuQF+jHeAe2BgkhDIGpJXC+RoSAQmJGracz2E7V1q4uUPW2aDke6hgyZYB9R
	8JctkXO/hluODur3CjOOjW+g9QUTa7uZJfHUT1LzuDbv+jXb8rmgrrL4=
X-Google-Smtp-Source: AGHT+IGVHN6Zo+umS1xhBdeJZTO0HWldJUeFVUzM0N8lJkVb3gqmyR4y3mZTYd3UFE9SblLCMVkkJXr0bGzmfD6/YcBGuUhQAB/Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3a811d776fbmr39008055ab.1.1733493783149; Fri, 06 Dec 2024
 06:03:03 -0800 (PST)
Date: Fri, 06 Dec 2024 06:03:03 -0800
In-Reply-To: <66ec3506.050a0220.29194.002b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67530417.050a0220.a30f1.013e.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_recover_relocation
From: syzbot <syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3c36a72c1d27de6618c1c480c793d9924640f5bb
Author: Qu Wenruo <wqu@suse.com>
Date:   Thu Sep 19 10:48:11 2024 +0000

    btrfs: reject ro->rw reconfiguration if there are hard ro requirements

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c9d0f8580000
start commit:   d42f7708e27c Merge tag 'for-linus-6.11' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=4be543bf197a0325c7d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125748a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14440c9f980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: reject ro->rw reconfiguration if there are hard ro requirements

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

