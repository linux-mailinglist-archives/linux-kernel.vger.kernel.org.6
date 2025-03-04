Return-Path: <linux-kernel+bounces-543083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C302A4D144
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91DE173D59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC814F9FB;
	Tue,  4 Mar 2025 01:54:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF014A4CC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053245; cv=none; b=V3BiuPHko1Q9n6tJkxhfrqlUSr/uzkRsCZjCH5E+2jqbOeTK30RyJtLxMcrjrURh3v+KIPwfmv1O03YHdYUox/4j+Ren2SrXOLLl4UOZ3dsCY/Yx1tsDkDLsJ3zl44USwTEQhUcCw/tg5Jn5njAy1Ihk+dXlhyID/Ux3erSb3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053245; c=relaxed/simple;
	bh=kV1cacJ/04Pidk6SZCQeZGQlO/O2wd/WL38ytI+8AZM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rnKsUf1k15UBvgoj+Ix71NepMLLY89rEqltXDNPFzkWKCv/sk7T5nJrBLHBDyEO7l2ShUkgvj6cRvAyrg3nSfQ7ZG8U5zr/QKMn+zfob1RO1Wt9n3XjC4rLnQobom65DyzXF+cU/82ah/NeQXD3w/iQeG7MYOGPP2UKiBMR6wC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d060cfe752so48100375ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 17:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741053243; x=1741658043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh6PrnckUXLUt2A85hFKQ3Y+zMDgWWBV7xrhf+AEGLM=;
        b=Jm7A4K+mqcn5n48LJkODDAAivOEbfXV4bwAICRnN9dw/kTKrrD+8VzcUza9CtJ92PB
         /oSPP4NaM/kFklBKv46fI1nXLzv+B/GGVuO4qcNeF3/2OVcUeJUzMURW0hr8PGGCd/Y5
         d6uW5/NwrIl0hKTz+QBkUJO3SJymKpQw3pzs4OLKjrnKTDrRoicWh61/pbVcp1qY7ILS
         ZTBEJTv8d/tqvXSqeBCk+idc5cgJLUGib6gtyYV4OqYUNHaGnj7UhJ1PllmO1qkjT3uj
         DghFsVSdkmbOPNBu+97jrKYpnVwl6HeYqITacxD00Adb88EY56sfVo4dX/7GeW4xD3L4
         Q8aA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ATDVe82xC0s9qt/RlblKDROspLgo487l+YR7fjytZw6c8vz4wx9kQjPYigzQ3ynFf/xqYPNhkN4+65o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQoB4LoiZ1hW2xiJ9QaCgY/f5fkQnJkk+/S1r4N1ADz9sNt5K9
	AIzh5bJMfuAoOi+krRG31QjZAmkTXrXlZFfwpz5iqSbb9rjzN5tpTZlROF96G8MrX9q00PGYklA
	a1jh2VRFlywWuJ6rDeOuz/HDYgzyJ1Sih3CiTOE5H7UteFmgAoB0ctDE=
X-Google-Smtp-Source: AGHT+IHnoEPOJfLSBF0enm96ymBNohGQ2AAPNkrarDEHNpJnhdB8iAM7p9BmkXM1iDtaXU2FDdwTJ/r42xGDw9pUvTfoX/oQ2sYg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd88:0:b0:3d3:f30c:a104 with SMTP id
 e9e14a558f8ab-3d3f30ca1e4mr132397505ab.8.1741053242793; Mon, 03 Mar 2025
 17:54:02 -0800 (PST)
Date: Mon, 03 Mar 2025 17:54:02 -0800
In-Reply-To: <tencent_2CD78CA727DD06C992F4C65189BE6ED72E06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c65d3a.050a0220.1dee4d.01cf.GAE@google.com>
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
From: syzbot <syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/gup.c:2001:9: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Werror,-Wimplicit-int]


Tested on:

commit:         e056da87 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=8f9f411152c9539f4e59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f8e464580000


