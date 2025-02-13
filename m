Return-Path: <linux-kernel+bounces-512930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF85A33F65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7992F1633FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1018221568;
	Thu, 13 Feb 2025 12:45:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A12227E91
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450705; cv=none; b=nzzHVS5/YuZtb8EKIUWrqyHr0ELixIxzdvk0FEZWvF4tmLJfPnuew8YoMZL0xIU63Bu/x40FNAErAM63XrHq6+9nmXQ/OLe4JJEV5MitBKkate8wltLag4L2SzcPS2Y4QdEBhTV+CnmRtstliUnu7ntEF18810eezneleoYR0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450705; c=relaxed/simple;
	bh=aiadqV5OXz7ZPf8k4d2xDgotBdLfSupe/8euZgfx4ew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k111ppjwKc9PrHVzjq8mO5s6G56S8nbOpN6e6zujfuqxHdinvuCCAOIZdUFNGvrZnLYlWx8t7XnkKPlnUntOIdnufN+x6NsfNm4bnuBunGMX0XaAzzrySJmncmKdliRKOO42j7BTyeVEJLVpQdTad57VlI+a+wuZERlvB4m6bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d16acfdddaso12779415ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450703; x=1740055503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LI/x3ZGBPy0s4byJ94RDIT6h2pDqBH26o+IuPkflehQ=;
        b=rXMWtbISZsVGzuSEe5cahfWMXJv/go5vXoPGQPb2q8yGsXmcdvH8SwN138shjV9vaA
         zqLeYsfSDzYmrYAzB6RqZvc1X4UuFHJwmI0r0YSQvEZM/KVXsGooDAdv9Dp6GGOJL+T+
         JvOrtj2ARkdRKNDBzb0eDsSDiZq1hLnLJ5jveBryaCb+CQQ5Q7ey9zO2hu944s9gpFol
         q410iv5UYWSLTiWbcU1JPmax26Q0TsC1PYAzkEgKgoeQUAmVNgjEPUNZrJiiCdCNfeuD
         jp/wynRgFLFEsckZypSOYLySs8zdf2cN3U9GJY5VLvl/OdOq+WPe1L8SWPXk4XpDbwUi
         HraA==
X-Forwarded-Encrypted: i=1; AJvYcCXkeWmtBq/ezmWhmHfk2Q9cLJJx2u+zkwTxLZIZbbZ+o19uhr4v6EgHMeLuBPFAlZ4qw+JItMdFzHBQ+NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxctP+u00gK9lSncXQSh6MfN6mPmnmzt/FOPRW8SvRD+h7JmEcT
	RWjr55A2wQthE9R8aSlCgQ2hgpghLOnatktgAGDVvEl5RgfkHi9PYWTBM5OAQaOihnHGhEvG88H
	udmh1twA8GGAVofZjAY2nuvIiu1TB4hgRJZxuaqWUk3A65LUu7R+h9rE=
X-Google-Smtp-Source: AGHT+IGjC4kAlffaX4GfaHYA96tZu2Kx/fqUuTl2QaXnE0hxbiorpmGhy/oRJqNO7vltj5kUWoUYYfc6lRX0EY29b1fsT9D/YYWu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3ce:78ab:dcd1 with SMTP id
 e9e14a558f8ab-3d17bff6a07mr69682595ab.19.1739450703005; Thu, 13 Feb 2025
 04:45:03 -0800 (PST)
Date: Thu, 13 Feb 2025 04:45:02 -0800
In-Reply-To: <66f02282.050a0220.1b7b75.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ade94e.050a0220.110943.005d.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_quota_check_limit
From: syzbot <syzbot+8364d1e040a88ed5657d@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104621a4580000
start commit:   4dc1d1bec898 Merge tag 'mfd-fixes-6.14' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=124621a4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=144621a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c516b1c112a81e77
dashboard link: https://syzkaller.appspot.com/bug?extid=8364d1e040a88ed5657d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f34aa4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134bbbdf980000

Reported-by: syzbot+8364d1e040a88ed5657d@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

