Return-Path: <linux-kernel+bounces-329272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3F978F6B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB4A28533A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C561CE719;
	Sat, 14 Sep 2024 09:21:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D891CEAA0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305665; cv=none; b=Fh3+QjAL0HKj/dTS/A61Du2ZbQZaFPoI+1Go1JfGs8S7PduTO4fZsEJ9YqB3v0DJYJ1aevjXiBuSooUDKjc67fTbWPUOZ9SM3iWdmRYQbz0F9RuGFJFOSAYpIS+l4s+wzyqCfTs0n7rSOv1Roun1Nnh/LiaRgEyR9qi20S9UT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305665; c=relaxed/simple;
	bh=z5d/ggt3yfI97olGsHHbSMLccyXsRNVuW1KdhKDpsKA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=prwaV8uRgYrGF46vz5FLhzNOE/mpQHI217Rt14elK1aEgqlzI7oZFb7edNG0A1SfcF3BWqdmu06cxLNsgFvZTAoBQgJR1eMHtRrWXBg8PQXLYUvkveZedUoerEklrt/TOy3R9xBSILPheGNevRu39XD5blGbiWv0l0cGwrx7mtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04a91237dso58745665ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726305663; x=1726910463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nh+vMYDR40T13jEK9ffJJB+1B7wdqMgWUrcaG7M5Ko=;
        b=GN0E/OUxjD5tk01NMcKmypGbdMwfWMcgXnAAEfQprdsNRrWBQ8R04POB2cFFJDQztW
         XP7rVwrIFnzhJZfRLQzTIKlko3Z74/8SAibtnE8WFF6HiJdWGVEZenqLeYeA4znNNwz8
         EGkobOrp62yEqWhv3ZFFwOt+fymjRw7MGush+d9HCA49L+5iaTu5lstBbh9toIpmwReS
         irgnAs7tU02ejoeaSo0ejAMp3tBoUPPM7BwEqjBoA4woHQcFf1Sh1cBNvxYeIgsxNaz3
         OM3EqEo54jrtPG4SrhhxXJRdEi8v3roXNMbVkVnnB234EDTngs38eD2KKqDrtnJeJtuk
         JTLA==
X-Forwarded-Encrypted: i=1; AJvYcCVw0fXtitbgWERmQFJWyOTIVSUXp7M71iarS4Ly5yrZ2tMCl4ADhwSkuVqqV2o7SVQOmZR5cHbTmPWYtv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3i0RndeZwzkNM3BE9ipnjZDG6QZ8uHmV0IHl1YNSaAWL4i06f
	679r9sF67tlLZ1zcv9MuRy0QbCSZ1EPThQMAv4FXLsX7KF2G+pofRQAhRcIw6OF462pouZiEnEx
	CxFWrSOXt+I0NgkpsE+Eke6hPyDP8fY8hc1VhUn5YSUxOU3XuKygfo78=
X-Google-Smtp-Source: AGHT+IG9ui8jSh2Q9ot9S7bbxQ8NxRjmtemD8CF5RAJWqw5koDRdZ3z3kZV5tG9mDmbYI8QDCQ/AY/S/OOsj0S+29u7s9ohJ0WcZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8d:b0:39f:797a:65f8 with SMTP id
 e9e14a558f8ab-3a084929ebdmr80280635ab.19.1726305663320; Sat, 14 Sep 2024
 02:21:03 -0700 (PDT)
Date: Sat, 14 Sep 2024 02:21:03 -0700
In-Reply-To: <20240914090051.636332-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e5557f.050a0220.175489.0004.GAE@google.com>
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_can_free_eofblocks (2)
From: syzbot <syzbot+53d541c7b07d55a392ca@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+53d541c7b07d55a392ca@syzkaller.appspotmail.com
Tested-by: syzbot+53d541c7b07d55a392ca@syzkaller.appspotmail.com

Tested on:

commit:         b7718454 Merge tag 'pci-v6.11-fixes-4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e18407980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=709406cf7915cc0e
dashboard link: https://syzkaller.appspot.com/bug?extid=53d541c7b07d55a392ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134350a9980000

Note: testing is done by a robot and is best-effort only.

