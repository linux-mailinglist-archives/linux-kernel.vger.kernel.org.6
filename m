Return-Path: <linux-kernel+bounces-200927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B18FB6A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D1282314
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7401442E8;
	Tue,  4 Jun 2024 15:10:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6961420C9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513804; cv=none; b=GbTe1wQ5bNQfFoN7dhH+MnQIllpNW6yAxld5Q+YJPi/OlVcHa9XLRkWg9A7tlzTJQ4/3yHABqLeso7pR2OQIWggT1SZv87cbnLMktq05VR8DFLutW7qNqpjQ4TrhTd3NToHpGokEKIQEE8CUBo+XPrnGIFBu0hLg3Zv42MaQ330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513804; c=relaxed/simple;
	bh=4TVIQNR/6Z1YPfoSmoDWBbA3PwRL01qZEuT1YwNgKmA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kRD/T5mXpeY34ey/330AVjt/F7eRcO11fLmwMya2RtEE+LzWFFWi9L/PqVNCynRZVaMztGHwCKklUUKd0dTi3vJFK5qJCYiubF4Z+5z5xP0cTIwACLUt7XE29+M5O1npWfrtWVamOeJSjnGWtUPjNFmeUfZysUHu/xOU7yrh27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-374a23b72c9so17104555ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513802; x=1718118602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkSWCLUC3Z5zZI+v8VL/vR1g1iAlgwx4yL/ydA03F9s=;
        b=RoqT8Jsol5Hw7vkEjQH17tY4XqbqRRZUSt7Jf6vQ55ANlAlBDbMWh3XIEgg84KX8M4
         4M3l5eTvjX4so1Vdq8kZ3OJvDZcnzR8QZ7lxP/zKKbFD3ZKjAX8LbRj9cLVIgSeFCmCl
         Y6wdha9f0nuQIJ2UNhl/5pGLZo7nJ4oKHGupDdeD3QKWfGf0LhDzlSEy11NSi/W/zIaR
         jm4VkyTWjtQjrFNf3zNCZ80kxCbSo8hcxc2AuJ45Hn/z7Nnd/8vmvLhoZ2AZaVrAmjqW
         iQIwv9ijfuCGmvD3qovPgUGq5QL0yNVJkfQSy0nO0WDuyF6VDnWo5w40Ak+00PiCluIV
         ofQg==
X-Forwarded-Encrypted: i=1; AJvYcCUio4k+Mgz2vsGq5Wk2f4aRG8nQMp1MCStWvD6H0Gy9pCXgokPzA303Jwky4oOYKQexcBWHaRK6SZ8Jlx9xOiwzVAvY7wHyv8z7UkFP
X-Gm-Message-State: AOJu0Ywno1xWxn8rdyY3P0DUz+pSYS3kPPP4QYgeLgTmg/atmMxbrgEX
	5hsdmvVyqoBbbu+mlsP1w0+jNo4goDGta6e2Q2xHHKFL9at50hVFTz4Q/7zkQk2Mt9EiFK2BG6d
	nn3kgImhcXjXUZ817NRWgS1F2ywfnPmddrJX0iXyseVTWQ/esorqGD4c=
X-Google-Smtp-Source: AGHT+IE76CJ+LLRsvygb6B1IMZFAirzuRPp9Osu7vnH6Gg/0Ka8ZM9cU532pf4uWHpLGjHKlut+XzzpYCOiZVmQk5K76Vnz92ZG5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:36d:d06c:5c10 with SMTP id
 e9e14a558f8ab-3748b9e5b86mr9243325ab.4.1717513802615; Tue, 04 Jun 2024
 08:10:02 -0700 (PDT)
Date: Tue, 04 Jun 2024 08:10:02 -0700
In-Reply-To: <a67e82fc-4658-4784-8d5b-e8a048e749e2@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a2419061a11d885@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (2)
From: syzbot <syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com

Tested on:

commit:         4d419837 f2fs: fix to don't dirty inode for readonly f..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=17a597d6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eab577c7808ea52b
dashboard link: https://syzkaller.appspot.com/bug?extid=31e4659a3fe953aec2f4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

