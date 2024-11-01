Return-Path: <linux-kernel+bounces-391740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DA9B8B22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF91F2146D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9814D70F;
	Fri,  1 Nov 2024 06:17:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93913146D45
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441826; cv=none; b=XGm1zF7xPqWj2F6oDFqNsnRIfiaOT16uMDTCTGhBmdD5n0oHa9kMKyMDN1DvO+VEZizX9gr5EFmWLEQv9UiyHOyG4dRSpqBLIgZl7GvrdxvBPpmPDGiKrOwzqFcC5C6Ro6icKEO0DTisIWkyqzJonSG6KNYKG2c5vZPCSsC8YNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441826; c=relaxed/simple;
	bh=kct3lv/Ay66viC5s5w/Uf4vRn/IFoc64dUXrdFALStc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kh/jFNArI3MxyBwZ+BRAkHFdvzsW9YWxyqF51oE2NOfTxfoQO8iSxKnPw+8vWYnbJS2T+tJv+L1F47Cs6rGNpAk6sQ6Gacqhjlm+X4eVGid299p+obkvXNGK9YmZgBECHyJO04VHZ9YOZ7yZfZThtrIlMDB7Yrj700SQPcLBZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso16202725ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441824; x=1731046624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q78wViwnoupvjRhtDfaJkpo7Mm+cH/30Ybplcy1BKGE=;
        b=uv6xqXif57YoQj90rkt27p/HFilGl6ruEWqmV4RKXrc2QYMF4YqTXrhfdo1bZWlsOn
         s0TAb3v4RNsQ22oMMDZ/paakN0JxPmVUPMrCIp6ehu2YI4vhEzLYiEFTxjPRrvPy9xfy
         Le7hx9j66v5XEh5RNc81q8ZhaUvmBIERt70MR8KVW+veffyOMGu1TuW2X8DOCtjis3e4
         W1/p1927eF2yn01nJCjg1EeVLgR5gqOy2I/w+0SXUtYPT4p0Ahfq5ZpWCWMxG8Dg4EYT
         O/utpA/Jv/wxsSpPKh0DdsoArjhjELBOxLb4wIeu6LZf0I4XfozoYXdHKXVzrPUMoR2k
         LwSA==
X-Forwarded-Encrypted: i=1; AJvYcCXmpGFGmnqSBGiACGiquGzWwy+46dbUdD9Jah3Yxq2PRPEuOvkOD7i92rxClXWPgdHU+q66XMCC6qf7i68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKUcU4XqNQSLrUoZmKf5tS1CSFE821QTdilWd9KhQf7yFjyZX
	owv9aQuve9G+Q3U50bD1SMNBzBZV/lh0GSUlXShjDn2dm0+FGmom0k/a/c5jz7D2W5fGWJKwHog
	6SuTpG58l8X/cT1eVPKHjmu8qhNXk5payStwZqXjd22fz/ZhO5kiN22E=
X-Google-Smtp-Source: AGHT+IG212HZVPaMiStH8AnQ233n3eXJbHVZ97Gl2j8FzrS6/zbgsV6pV/cA9qcBnahktj5Ec3I8r9A/nMFThb2mBcV66LBh63dA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c5a5:0:b0:3a6:ab82:db5e with SMTP id
 e9e14a558f8ab-3a6ab82e083mr36818545ab.22.1730441823732; Thu, 31 Oct 2024
 23:17:03 -0700 (PDT)
Date: Thu, 31 Oct 2024 23:17:03 -0700
In-Reply-To: <CAHB1NajxyF5mBEqcuhRh6FdizNizoFsdUgBOGu=StFwUoByYAQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724725f.050a0220.3c8d68.0869.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in close_ctree
From: syzbot <syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com
Tested-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com

Tested on:

commit:         6c52d4da Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f5155f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5a84880eccc01
dashboard link: https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

