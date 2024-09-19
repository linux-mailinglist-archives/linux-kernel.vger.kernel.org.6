Return-Path: <linux-kernel+bounces-333786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F097CE12
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0751F24C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1C20B35;
	Thu, 19 Sep 2024 19:13:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7F1DFE8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726773184; cv=none; b=EIX4pmzv/oF5pwp58nCKs0f0oDyZVs/0+1SbZj5DVhHpuDqQ4iAF/DsnnAZkNk48B7Cd4nMhB7SFZ/UxEqT592lWfc4AZA3XmKSg08JZSjYuDasakUAS3OUq13bI544OE6F5quJksn9J5+GCosUpCwtoi336D8Q3Zzg9qCsf9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726773184; c=relaxed/simple;
	bh=GwbEjkyBrVNZ2Br/HjxOVIWf02ZZoW4Rvt6XcRCsRyA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oNQiqsVZJdyQuy9cDCSP1MHp8GjJosXBwlVnjSpRWVmiCaRigdGh5Wg8WephG1Ja3TgtyxpA5+br3pBZEjKlaH9jL9TVhtlYpbAyJbzFuUn2Ufp9BbeSnqaE2DeY7QtEgAi4s3jd6FmZQtwi3J4n7/H05w5/vUO2PI47BPObi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0987c35f2so15156635ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726773182; x=1727377982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l18j8Sntp2AbqMqP1jMsD/Dhg3jEBS7mGbJK7hNqrq0=;
        b=mGzGEHMs+0OM/xCBtZ98oPEjoaA6u/XnQjBi404F/2ZOjGePkLlVBG46g8YF/9YVLW
         VS7zAh+iYbv8k+Wb+Sun9mCncz6Mupr4WYOuL7tZrHAu+HQ0O8JqKXxHT8w4Gscigz/O
         URY1/z8wSxFJYM7yY44LgCybanTBz34DWtBoeGghC7DdnJWHR7+8+Z5xhktudxnxd2ay
         R3Od3UcTdNyFc5dZnjn0vheXLFM4MBq05h0RYrLWPSbycd4I+fPmm4zwZGtr7LSrisrp
         yHdBT+fFjUGbq6j1YQEVsD5jtgfE/3aEgRgFPLHx5VvyAQ6sjAx6rL+vLeBVazQ7tpdb
         T6xg==
X-Forwarded-Encrypted: i=1; AJvYcCXkBzOXow02WIjLqyrTCBKcgdynXoZhq/ifrVQ4hfJRqLPcrclDHQweRN/mi6vwr1FRNnxDTJI5Y+7wbwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB2gPgKSJOXk0UT+vhZk93NWKuyfFNoY0qQSDIe/D4/K6RVat7
	N/pzyzzwUewBy0mox/B1pMv6PE0RN9FdabzfMpYNAlb7RWK61xFf5axWWJ8R6Ng1ZRndsqwsrCB
	3mobhv4lMf1EbyMt0wWyNySfNRtquVq79G4zkQv9YM5S2C8AJ6/1XMKQ=
X-Google-Smtp-Source: AGHT+IG84Uc1GoXR9vV/DWP3G0iOC2fu+draOh+8Owaz6w9jez8cxeOM43b0WNfCh5236AuQTTlAYknLBLKXfCuJdcMmR+0NM5jc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c261:0:b0:3a0:4d72:7f5e with SMTP id
 e9e14a558f8ab-3a0c8ca4694mr6390065ab.7.1726773182249; Thu, 19 Sep 2024
 12:13:02 -0700 (PDT)
Date: Thu, 19 Sep 2024 12:13:02 -0700
In-Reply-To: <8da7cb9d-5d28-4203-9a24-03a1201d8a2d@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec77be.050a0220.29194.0041.GAE@google.com>
Subject: Re: [syzbot] [udf?] KMSAN: uninit-value in udf_get_fileshortad
From: syzbot <syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Tested-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com

Tested on:

commit:         2004cef1 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133ab69f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea86c03799707382
dashboard link: https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104d3b00580000

Note: testing is done by a robot and is best-effort only.

