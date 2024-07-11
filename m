Return-Path: <linux-kernel+bounces-249149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211F92E7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC3B28AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31615B977;
	Thu, 11 Jul 2024 11:53:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9A15B132
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698784; cv=none; b=lFxStEdTfLB3ESh40KN1XpwLouaJpOTp99UNAe/9pAiMt95SR40GbJLP32n9rfe1R/zGLHKO1Ay8xpqoSyFtwY5ubme8uFhL6KlL9+kV/DDBepUWf+YbFO46xp4XuNhf+9V4ts1dtysTvI3a7WzRFEhDNyvgBJdO4Tb8WfyfB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698784; c=relaxed/simple;
	bh=ZhSB3fDCRfT20LAUNt4SikztpqN/+mdviOp3zDpc284=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nu0N7PLv63edND8Qu9BuX6rkrWZ1po3MSJt1mEiSgwhR4ak2xFB/Xv4/MG81knMvayxGrp/8InYhyxemsG9FR9PMKBck111WzqpZu58tVOzbu7yjjmi2b7SBOhOgpdLakEkkf7wwFhztM8IZD4S+pFT3K++OcLYqDi4zWY58RsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-80627fd1a81so56581639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720698782; x=1721303582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHpumH/Ri4b+D9wN/g9oBWQnWy3YxCuNOCX+rzVTtQE=;
        b=EUvZ8zMAoDqqI5OeaVLw21gx5E/fmHoO3CfKNxMMFUkbcE7SgwJMvS/E9RubmZmgkY
         R8+h1pDpEQ5WFEuVfbmhbgB0nSPFnP8plIJEF2wgEC+/jSewc1E/6LugyBBoamELHKJV
         vbqgaNZnGHCit2hwfJjGm1xUdatwD1eOLQt/8H6nRjoHuaT9jQGvjj4EvR6CPGVumrET
         tVR8tEzCZ6VSt1MhFasRox/8/awx5vffmWpNXWl1Y0dhPc9lQ0Ucasmlq8GwqNJ41PvD
         /TL6JNaSK34qpk5OcDRR5+GxXnU1gBiyflcPxbtJU0TxtdWGfE3rQ/9F7ycT7l2yYpLs
         Qrlg==
X-Forwarded-Encrypted: i=1; AJvYcCXjCiu+R3lJZgn9SiiFrQiWSBFSkqcLocM1jzFkpn/fPuhFeJ3DIwcjFmnlrgp0QuYJ2KbZ2r+5YtDPRK0FmdIhPf5W04P835hHvX5Y
X-Gm-Message-State: AOJu0YyxEUPBQyOj7Pe2DXotFxGIfVsuVwjVyfHcQTdpkBvFK87xE6wI
	R4/5hbvrI9XLiDhGR0K7iyOffttHQlG3tbAfEpMbEptsGaFUlilwDbbKa7VvqTZL3xQMUP3eIHd
	Mcy98RENj2JB2c+GTq8xCX1JIwmefPhcdaddo9+lzYgo/FAt0SiNwdHk=
X-Google-Smtp-Source: AGHT+IGRMCqxCH8Ih9+BiwaPgU5mXmvfGMGe8aZB11DsWx0/UGS6n0BGAeBYrq/ZihNR/Sc/NgZ0yE3ER0OfRFRIT+6cqkMEHvmh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8519:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4c1bde95c1fmr174235173.1.1720698782032; Thu, 11 Jul 2024
 04:53:02 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:53:02 -0700
In-Reply-To: <20240711110945.1147-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab3812061cf76701@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: workqueue leaked atomic, lock or RCU: kworker/u9:NUM[NUM]
From: syzbot <syzbot+733a96463546d3026b60@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+733a96463546d3026b60@syzkaller.appspotmail.com

Tested on:

commit:         ef445d15 Merge remote-tracking branches 'origin/arm64-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac6a7e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79a49b0b9ffd6585
dashboard link: https://syzkaller.appspot.com/bug?extid=733a96463546d3026b60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158b4831980000

Note: testing is done by a robot and is best-effort only.

