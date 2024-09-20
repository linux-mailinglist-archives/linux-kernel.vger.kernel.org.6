Return-Path: <linux-kernel+bounces-334627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D789197D9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B28B1F23771
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DA183CB5;
	Fri, 20 Sep 2024 19:06:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18586291E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726859164; cv=none; b=uWXWemEab1g+ikTNxrhj7iss2OydwzQ5UN1pP1kiZVOkvsVjmHgn4SEdWW5Jl/sNb/NvTIg8eOT4+Yu7ZNHKH5ASzoIdhZpBMKCxS+yF+SVn4BRnDWKOUvOaeupDoblym0kRpEirx879JLlyYjOHpPPhxPit/A+LQPZia16xC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726859164; c=relaxed/simple;
	bh=ZClcruaHXzbCXilN5gpeBeg5BdJWSvqQCgujFKR2ov8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wiu0uJ7Gaegsn23Xu3e/JP1bOGTEfDOVaFNuEcNmjgTC+M2ne8/OD8pe8u0lA07CI4JslfZ9Ro1TvWMBM2JdZWhSqzrvIOOKpjVzG6wjbIWd/o+ZhGWCSdROzee76oOGldxdWAsnEytaP9tHrz5DPeNh6Et4Ta+ml9rnbjocPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cdb749571so254708339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726859162; x=1727463962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUf6CGjR4bWSGj2+PQOxtIYx6vWyI3WMtK3UwHwb85g=;
        b=M/d+nNM66LI15WReTZI5hD8fbMkjxctRAHpXgo5CEJvT4Gzr6lYzUnovceWFxvvkr7
         Yx3C3I9zyCZQzEgxCGBIyl6NED06lZmlDq+h08mwT5h2fqL/5tKtnUX5T6EuBzniewLk
         QI3Jqpu5nwxsB/dUZnxvLtF5nGsZGNHL+xtjrE5teu18jbspvuuLnYbb7DNcl1wEtkZP
         lnI8ifOVldyPwfQuLjmIBJvdOHCKOgW7AzW5j0ub72zQ4Je9T3LgodtqD2dIWkw/6Co8
         Y5MXdb+iGubnJwSy5aASIzQrniDduqRf/uozlHGhC0RlokFI7Pf6Y806rgc/DP8KJ3m3
         4VJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS3Z9ZCIuRdvqndhQdTs5rH+dep73XC9dXGccm12oITcTjj+v3pheGHTz3Aizx1JU5gwl0wKFZe94mczU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjoyqlY4HNssNsIusprmTBb15zdu9rlE+o8FN8mksNtRNvBtHl
	3dbukynWgfT55NW4lgMxG246ivRUgO3CXm3JTDIumYrUPv0vPJw8XUR6WQpDrR4xgN/kEEPRglJ
	rldoYA8kSYosAq2IPm7z2D3kKcOIcQCMcUoOWHaoCHnmtNjfYzT5fqqA=
X-Google-Smtp-Source: AGHT+IG1hoyGre/j6uvxWbFCcktiEEGo2p2sZKmOGbXrZKIDn00siJgnoZzKJXTwK/2nQSjEHlbmh6LVxOAHL5SyZEdUvibN8dR9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:3a0:98b2:8f2a with SMTP id
 e9e14a558f8ab-3a0c8c9a3eamr37091595ab.10.1726859162172; Fri, 20 Sep 2024
 12:06:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 12:06:02 -0700
In-Reply-To: <000000000000690606061ce1fe7e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edc79a.050a0220.3195df.000b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_stop_mmpd
From: syzbot <syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com, 
	harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 21175ca434c5d49509b73cf473618b01b0b85437
Author: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu Apr 1 17:21:29 2021 +0000

    ext4: make prefetch_block_bitmaps default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1427bf00580000
start commit:   4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1627bf00580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1227bf00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
dashboard link: https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbd177980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ea607980000

Reported-by: syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com
Fixes: 21175ca434c5 ("ext4: make prefetch_block_bitmaps default")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

