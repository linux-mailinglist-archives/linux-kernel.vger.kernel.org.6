Return-Path: <linux-kernel+bounces-312059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE9969175
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB744283F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336A19F130;
	Tue,  3 Sep 2024 02:34:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EA27448
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330847; cv=none; b=USSJQZkkuMfzY7DS+1zkMN+Pkzj8jm+uQW+BbthVjJFW3/WSOE6ZNN+ob95Td0M3Dodpxuqth8u4oHvocOdiZMBT00Aqe5cyWFilq1jnOqKIZpiYwg4PGmKlcE9f2f+/ByfDaC1oIUxfrVUb68jIqk+keey1Y7MOlMQtxCHdJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330847; c=relaxed/simple;
	bh=UOHCw+cF8tvj2KpTUAWgY9p9yXNgf8o6wkUC9wx1Xk4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k6HiEaF5SsNkNhyALDepzh8JNBeRnu+Pqiv7IVSYuzcNWNTVJO6nYfuQS/zhx4bxhdDUht1k6E3IUs9D+idpw65WN3fPCjbpK/9rDkaDNu8ViSwwJNrDNW3aJYxWW4fUZrs+iBEcs49ctHErc4arBTMu9GYtdA6dxiwb1uutfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a330ab764so328872739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 19:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725330845; x=1725935645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4drJsG4cIDr3I5NkQbnYT/k0mpZe+PZ2n49CNlnX0w=;
        b=Jc1JD4JqFc4g0wqX55YGhTJkr1t0EvSw0Yum+btmEaQ/68EGzGHCpIqRXpvRABoT46
         +xryxJ04ZEe+IQpk5cb4UobMXahcTdcO9M2aVwgOBsIGwxmYMpvfFGrIEZdwEo3c0TSt
         8KTrodkJ95xFR2G2zQwYrcPk23j64cBY5Ake2LVXgMvMdCJBg/oFpIKetY9D7NGh/PYc
         qJOqvb1qKVyCah+lO6GEzvIUx1gJHUkKC+G9p++LjIYASSifZRwzpNfv/hpkolWR1Lm5
         VJXzEb3lSDQ5HBxFy5fqqx2tArDjMk1Z+Pr7/qHpqsTt2b8sv5lvZHYTr8Ur7Chlu7I6
         4uPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVREaOgesPl/NffRIqgBdH8m7aw5qWQD7oO1lX9fuz0/eMmKP7N7lMKKsg4AQb2st2VHW6gy6BXMX5ApCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsDRC+fwR/1FOIUgLmulmED3ioY06l1Uop021e9GBS1MELzeI
	TZFZQWn3BO4w68lT/o5VBW3MGC1Amo1i1WoIPNiv0LUHnSy7nZxoXZyxTLDV87wrTnehsQgIOlK
	vPJVJhMvP19shzuCefIZz5Arx+Z4bU/jsIaYrCi1mHOOA64zgcwEu5FE=
X-Google-Smtp-Source: AGHT+IF6HRzmy3uAMKL6AxsBzVXEuNxaW8HWHTEdIl0EaLq704Fu+i3tq1TMG6e307FJmdpipFE/HFCiLkBYLYV5Y5unhue/5r53
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4be8:b0:4d0:51aa:f250 with SMTP id
 8926c6da1cb9f-4d051ab4928mr14181173.3.1725330844993; Mon, 02 Sep 2024
 19:34:04 -0700 (PDT)
Date: Mon, 02 Sep 2024 19:34:04 -0700
In-Reply-To: <tencent_6ECC3C5D37B696EC36DE4A4C759B770B6709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022db4706212de4ac@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in member_to_text
From: syzbot <syzbot+064ce437a1ad63d3f6ef@syzkaller.appspotmail.com>
To: eadavis@qq.com, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+064ce437a1ad63d3f6ef@syzkaller.appspotmail.com
Tested-by: syzbot+064ce437a1ad63d3f6ef@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135f0f33980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=064ce437a1ad63d3f6ef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140dcb1f980000

Note: testing is done by a robot and is best-effort only.

