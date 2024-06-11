Return-Path: <linux-kernel+bounces-209826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594BD903B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5641C20FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0817B43A;
	Tue, 11 Jun 2024 12:05:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666C17623D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107506; cv=none; b=g0jFEDVYErgeSEJ3WrQxmahS9fwF2bGgISrkaI2ao+nzPfKiKDlckTgTEStCAwLq7q9/Tlum/XbwvQZFb/KkqoQdZmsP9A7OCVTQVJqYpiBNkCCcS1AxKpoEi6vMpqMdAzGgnBMRpTxYHQG8hMGJeehwzSlFt6GPzhLxopADe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107506; c=relaxed/simple;
	bh=vJtIQxrOjPK/seQBXP1MximNtpkbqymdaRoKMc6WPOw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UtKYoDBVXSFq9EMmr8vKHpkgiFcLPxyOSi6l2oHyIILTag0r4HsgghHNqcafAS4C+YSyXTy80tab4j1dPSFlzmw8d5JYxNUJ6ihGFihoagZXQ8NDfPMvOvXKtMCsLdeB2Zs10kv9Q5Zj1HnqABXRHrnKH+18U6l4B2ws37YMLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb9bf4d07aso155619639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107504; x=1718712304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3Aj3QIi88q6O1dyQgyG4l3bsXb4vPIG6BuRMI8mhrk=;
        b=JU7oyGMBKngHuV2W1eA9ezpU9lw8y7/p6YUDVzyWAHMxfEkGb9Ohc+S8ZYDIquixii
         IoQbFL4KG78Eg2KVN+GtT6g6N758iSLGkrYaOsL+qVJDJB0P9eCej7+lDbXl5S/2J/wb
         w4/xFkni9aDenJ8WsQIWTM1zXmAu5CHIx540+zMBQ5Xry0JmpkRcN8Qol1DWhQ4F7s2t
         KZ4+Ji/j89HH6LdoqAiiCtfqH3Imfsl0gLdsAYFXG1LEic+GpKMUK8UijbKDtgtvxrd7
         GguZZPLNQaHUk9mvy/nYTrMk+zwXH7AsfJxLZ4whHJwrg13FYCK3+lKYGhs7cxhMUXV7
         ofXw==
X-Forwarded-Encrypted: i=1; AJvYcCVxhuPBuqnnoo7z0hU3I9wz0dG/FQvI1WISgCXqnoWDX0iaAZb4HZc3Y5ZyuHBirqb5dH5yDbCz1k6k0rSw5Ko2vpP4Xsyj65iG+KXU
X-Gm-Message-State: AOJu0Yy0e7Rq5oyE9Uc2QpkBfqBINwYR9xl2ScZ3hzKsaZTWv1dkI+lo
	XiPO0fXurloA2zlgGOvpKG3f1wWxmwaZgmzLhD1WwXkpyL1BLAkPljoTFRs7TyMtc4SNoOAn7mo
	5sj5cLG6HOMLEBWiKw7n2IUGmxQSeev3xxLzNWQ7DeK2k2Zf9/83W0bI=
X-Google-Smtp-Source: AGHT+IGSorHGH1T/rtTz4mbVCoJOziZDWwzUYlkzDMySqv1fc3bxny7Hrue3JJ7i9U2dIZtKC6WAWs6oBTp08DmiP9jBS8hjXxwT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c26:b0:375:ae47:ba62 with SMTP id
 e9e14a558f8ab-375ae47bd99mr2171375ab.1.1718107504566; Tue, 11 Jun 2024
 05:05:04 -0700 (PDT)
Date: Tue, 11 Jun 2024 05:05:04 -0700
In-Reply-To: <tencent_554425A5BAF0BB7633499ED51B7D4BEF1B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ef5a1061a9c13a6@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com

Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17f536e2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ddd8da980000

Note: testing is done by a robot and is best-effort only.

