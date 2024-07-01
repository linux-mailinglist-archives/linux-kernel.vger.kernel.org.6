Return-Path: <linux-kernel+bounces-236428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EACF91E230
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1A51F24E72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FDA167290;
	Mon,  1 Jul 2024 14:18:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B915D5B4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843484; cv=none; b=Lpe1I+ilNIu4iLteIX0pTnxC+2TzT3wbWkaBQoA15fiiRxTZvLrjaYnrF8EvLLr9ekGH8Uwoo0DtNE+vqwDLY30clPaW/Qmiu1QvFGvX1l8yJyXngGXt0lPSNlbPhnvAAbDa9ZfzGEQRF7BW2MKv0lNngWxRggjMI+hrm20fgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843484; c=relaxed/simple;
	bh=Hqauc34JIR21GByKeefatrTTgjDYWO0CZ0el9+9ox08=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nChObqS7TfDwkuw9imBFWUe+wJQOJl9WXLM1yy3dEWicR6Vn/40g6TAbacB7HjojhOcvBgPC2TadXJqS7uE0yjavBNLiXjCmmxJrz5lbWO4yVn5eEYY3GkXjEV+vuDlyycXhX2DcfoIzSB5YbG0hvRW4tLuXHyahYCZHzgU71oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3761cec5b39so33879625ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843482; x=1720448282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGESIlx4u7wAXAlH51/mWo3q/1xE15equ6TWpZIqiCI=;
        b=F2Svjlydl4BX5O4wJPwJDzaYneJL5OM5PWyYwC2NwN56rnZQw27ax3HMI58TPJchGP
         l+zsr7u8vuWbEQMekhHzyhy5D/tw9UUZATroVfvPQE/J2lUdn++UaIUl32KQLoH6+RJz
         Hd+fZJgxej7fCy+ieTRuyPtCjNdwXlOePrI8HkDD3LO9k1BmI9Z8K9S+BSoe9UZIMEhi
         k+cccX7nBx944KZTbNenQy8s2/ouHi9mCG7UTpe81+MZ/AfpTDkJQelqYxWKRdBlNBa2
         fQuPbEfkSa+fUvNX9a7zfMqrYMbZ/EL/HyLuLIc6/MzfNxX/wC9S+v7GrcuxORfmrUSg
         mv0w==
X-Gm-Message-State: AOJu0YxjUlL+8Lf0HOBbCJbT5gfhu7KHb5olV6gCJZ5oWmenkyWcKy1K
	TQbdiY53jkrTtuChOrQCjUy4FL7/7coPy9lZQ1w0UjX7RTKm5higwdYvWCFjHRgqZkMnPxzNgh+
	aFSN6HPSNPyKpMzRR22an+G3q3QqNtuywOQiKKE2f0/3i0HDRSz6N4Oo=
X-Google-Smtp-Source: AGHT+IGG+COI6wqlcdEZgNfvEzhqwob9ieVA/91cAO4Jit5QILunPAapiqj17lkfCKHqizBBzzTSndnhrWxpVI+HUgFvWLP52ro7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:37a:653b:3ba6 with SMTP id
 e9e14a558f8ab-37cd358d008mr5735495ab.5.1719843482458; Mon, 01 Jul 2024
 07:18:02 -0700 (PDT)
Date: Mon, 01 Jul 2024 07:18:02 -0700
In-Reply-To: <20240701084541.1731210-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d77129061c30432a@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_fs_read_only_work
From: syzbot <syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com

Tested on:

commit:         f06ce441 Merge tag 'loongarch-fixes-6.10-1' of git://g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1183738e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1306a869980000

Note: testing is done by a robot and is best-effort only.

