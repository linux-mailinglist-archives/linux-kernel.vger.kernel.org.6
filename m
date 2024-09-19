Return-Path: <linux-kernel+bounces-333084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E297C33B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5AF1C2154B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476931400A;
	Thu, 19 Sep 2024 03:59:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFD12E48
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726718344; cv=none; b=KUYhP25orCLCD0+PsIXIYJ6WK67dBwctYy7ga9ou3gPoQTQM+yKT3Co6po0fsyesdmgzweKuMSWvWiT+gtCRhmmrc8msC7KtRepaRVTJQ6Mkcv41ywBkOCZY7pc91EgRKgUgUXnlBF+9iEK1vTVkKSZGolFnsVO5oUKueXwRAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726718344; c=relaxed/simple;
	bh=cAy17ihLnqDhRPgJXosbuYCiePYr9hBiFKwbTc9rgOo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j1JdTquxIqrTgBnG+f96bodbzA7mG0fymLBgwbxPSPvpKGR28ant4pxrwJlOfSQeN/5Ol+GkL4cKtXvXnTK0Ld/HcGwO0dbqVQ8Up1gtZlCjpKNAIvUbgGrn6xZJaHwhTDZQJB6RuMo0ScdYAdsNORgRgmjcrfr1XiOaIDS4i/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a08f88aeceso5071335ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726718342; x=1727323142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euisIDUcF54hp+c5nFNy9pUd3gKB5qWOJ972HET21mI=;
        b=Bz1BV1ugAJBXcPA+9LQ/3UQ78wtbSrXCFGE7oC8+wJ/FDnM8WuSSgC7hzAu420zuBg
         MGrfQ8OzLFNR5U0Krihq9Zo6sNZqNghVgnYf7GHYPabqEHKOKAGqsN5ulCcZAAgRl4D8
         7T/4hZ5lNFo7ncwXLXkXahldVUTYSMMiixExh0DEmaF/r9Qfwwuf/U4C9SlRpk4n4WrH
         DPiV/Vj+WWw/SrPbUjwz1XnHilNh/ZQW1IV3Zt5MHdEKVmqAVTxZEWLMb8dt06MDewc9
         LRM/c2Wjxliw/XynRAbYqIofgDxcC+5M6C0YW576wp8agaUxxJz8a1Et5XQj8ocSrIiI
         5kng==
X-Forwarded-Encrypted: i=1; AJvYcCVzq3YVC+A9mDKN0hN+Oy4dn+YwhlK6dJ9/2l9J86E/+R6i8EQmBsGRmB4Of8TQ59EJZPhwkWg6koWs/A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7eI6qdjaM1Yy2+XPDt6RamYl3ACA/vl4sD4Ce3mUAGbLKVnX
	RTHqrauZBQuHM/VwRyd/kIXcrI+S+HCuGRafDS2M8gu2rGsm+IrR3aLvtHh45f/bdVhTw6GrLqF
	nJw6GrmogGFzpeMczOivb2mJgEL0obqYt8FnyEe0n02htllFYoVFS9IU=
X-Google-Smtp-Source: AGHT+IFG2Q7HEA/T1wuqC0gOpGjrSIRF2mDNmv59lD6c/FbOSovcv8lX4j/8eKMvp1GUufR6IQHzdkcY8KVYmahtb2XoZ15DRf6S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:3a0:ab86:928f with SMTP id
 e9e14a558f8ab-3a0ab86a5b8mr101175865ab.26.1726718342635; Wed, 18 Sep 2024
 20:59:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:59:02 -0700
In-Reply-To: <CA+6bSasCDcOTbThYegvLh+5kn14R7Mab0QMw8mmHeam2CvMhJg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eba186.050a0220.92ef1.000f.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING: suspicious RCU usage in bch2_snapshot_tree_oldest_subvol
From: syzbot <syzbot+f7c41a878676b72c16a6@syzkaller.appspotmail.com>
To: bottaawesome633@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f7c41a878676b72c16a6@syzkaller.appspotmail.com
Tested-by: syzbot+f7c41a878676b72c16a6@syzkaller.appspotmail.com

Tested on:

commit:         4a39ac5b Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13172607980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b74c2037cf7ab6b0
dashboard link: https://syzkaller.appspot.com/bug?extid=f7c41a878676b72c16a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fadb00580000

Note: testing is done by a robot and is best-effort only.

