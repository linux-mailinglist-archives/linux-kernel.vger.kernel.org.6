Return-Path: <linux-kernel+bounces-188221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E48CDF54
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BE91F21ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AC219E4;
	Fri, 24 May 2024 01:56:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AF4A3C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716515765; cv=none; b=LNTqF7QwU7+bzsJR+SWDXrZ0IGiWAh35e0N0rbMTZLZ12FQdqtOJF+gYvPWgfcFyT5A4jOIHFBh2d2HqlCjWTRhTvqf7MBPssCa7Lf+dl9vcR0fQulvfLQPpL63WXZsmQdKxBCQX/cLmdwgIbTxh99RQXCTz7VZw9p1MSV8N0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716515765; c=relaxed/simple;
	bh=yeCZjY35YA4CjJKelxniszCVriItUDw1/H6xia/9cSA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lfktjED39i5Jt+pJ0xtKLP3xbzJqnck33zg/ZuAq+CvWPnnorqD75ecIv9oSO4763y/dgUChIqBQBQWsiVHtlQO1Ep65JuyBGhQFY24UjL1upZRndvkfL5HOqBbPhSo8FPEcPFrnMQ6IuGANogezjXrlVfXLLz2dxFvzSOYmPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3737d7d68d1so574345ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716515763; x=1717120563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0Y9UARb/XMrh5Ak9en7FCodvjHV6/rrjT89wZyHGxs=;
        b=dfXXup7kHT+Ptt2s3mlfgTmvqoUicfJZh+7Tr6xAXdnJ8HDbxrXpjlZK0bCXA3Xzzz
         XNtlLFAAQHFgF0S/1GYh32f/k7U7Ax2nrMbH9EJTWMiX+WL9Ckvhm3W6AotKdzkdbjqy
         nCUWar3Lm6IJV3u/PDkb2JPoelRTo7OrVxNOfI4WzsmponStybuNNSPKQzm84cMJ0mHB
         iKPqUp/XAf9ZVZ1ieG1qRnkwTlx7WwRbuT13H1ngNhU+g/1ZinNjXJLTRkYr/rIDwvPp
         8WGE2dhZ2wpiAjDRfe6V7QP5QC/8DkYMK4R1UARUxqWU5lM8Pbwz2ZTItX+sKYy/9qAy
         1rbA==
X-Gm-Message-State: AOJu0YwKyPxvkVA4FIZO2zHPmd+2twuwI9GhCupUcHK5DZGl48QlqYPV
	U6CJ421rmfPE4PGp3Axlm89PWqn1nceQ0PozeDvN4CSqRNJl2MlXBDV0htoyoTMsHTVy7i1FaZV
	XVFPZ3brvNl842R4cvFNVQZ9BxjepKm00le22ggW3vTijrNnvn//d5tA=
X-Google-Smtp-Source: AGHT+IF+MpgY9KucyHrheip8jIChunSLGZ91lDOB4tSHpqot5jRo6eM+poyaL/ClscMZnMuJHGJ+ZnQasEDeFlVzfg5vEJKwjt6D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2182:b0:36b:2464:bd2c with SMTP id
 e9e14a558f8ab-3737b2b9108mr595775ab.2.1716515763696; Thu, 23 May 2024
 18:56:03 -0700 (PDT)
Date: Thu, 23 May 2024 18:56:03 -0700
In-Reply-To: <20240523141707.25170-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058c52106192978c1@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: array-index-out-of-bounds in usbhid_parse
From: syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com

Tested on:

commit:         b4d88a60 Merge tag 'block-6.10-20240523' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=117100d8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34e05c35ec964e75
dashboard link: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1293b80c980000

Note: testing is done by a robot and is best-effort only.

