Return-Path: <linux-kernel+bounces-229483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD991700C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D871C23524
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BA17995A;
	Tue, 25 Jun 2024 18:20:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB53176AA9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339606; cv=none; b=jTPay+Q1QDzniAsou4y7qg+uph09yvj5nxF40nGLcruypjLSYWtlRnX4e+20XwuYNFM0zgxjPq5IcXlsKWoxLiOJdZ93ERjjBN4WpOubARnCpyJsvVyo9OgzyHvSqaQyVxXX1fdG+EHDBFcOPs8EyhbTghGmhX5Kqx62oD/8lkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339606; c=relaxed/simple;
	bh=Zy0SUc/FqK8HRRoHQFtRx6CgZfCUC+9vm9uCAbBWu/I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NoKcFs/RMkzpFbK+t9vWMXlqP9zSM7JGCRKa0Flu51i8lNTJgz8mt5WAvOO2mClOgQ6/egmT9HeyAXyF+AUbSvyXEPr1qONx1NpandFZOUZdXjLscHv3X1CCGqFWqxeFJkOsmlY3FsLMa7KqVNVdlmN4V14I6oLEgsYkJfAm0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375d2ddeffbso81728795ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339604; x=1719944404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kdH/6y25DZ/0V0/R1qzEPryoXtPS/0kyTCGhdVjZJU=;
        b=eLBi+J/L20kEwVjpDv7iS2IRFoM/nEUXKKixaO6ylYX2nF8QvFtoyrWxF1EFH1ET0T
         qbu7v7JbJLzhhJVHsMOvwbOs6hJCDPl/IqUE1E5/5qeYkkkRiPtlje2/iyF8oQXOTYSl
         MQxeaFZjtZ2/4RAKCEb5WVTDAenpBTLM1YAiYL45JAAv9TWdgrcqbUbXkQBgYpT9zFNu
         uCNJf2DpYCDW7QQFv4+FruaAGPb95PppiFY9hjVpLZ86hBf27jTdjWlq00Lo8HlDW1Q9
         bID3DU/YV/PNsJ7gDrAubWNOEul11Y5HtLdkbn9Qf3wT8vcvh2H4YvyaAktUKcnwcANE
         Y5oQ==
X-Gm-Message-State: AOJu0YzJP1LQShElGvXNtUqOWUA2XYXgLgkCd8BvSUdISb2ukVJAGNVz
	bkpLVXkytqp6y8PGHWCpK0JIMLjeKFKB3JJmgbYJUhem2H2VfyaJ04gWW1hoHKNaLvaIQCeumsA
	2FAdodUT8TiCUqmN/6dsr7Kc/KP60hVEUsTPh2F+tZzNv/aAK4f04dzo=
X-Google-Smtp-Source: AGHT+IHXkQDa+uoiKr+dUt5n73UBrqK2ae5yUrT7xIyNvDj3dksPa/S4mYlhLOlk7beUAE95i97zrmLlQAQzNiyeLuNjEX3G0E1p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2197:b0:376:417e:c2ab with SMTP id
 e9e14a558f8ab-376417ec6bcmr5299235ab.5.1719339604636; Tue, 25 Jun 2024
 11:20:04 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:20:04 -0700
In-Reply-To: <CAMc0M--YCvkcNwLx+2pFcB_0m55xh=YVz1REdO0j6EM8szv5Nw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000621855061bbaf202@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_blacklist_entries_gc
From: syzbot <syzbot+835d255ad6bc7f29ee12@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+835d255ad6bc7f29ee12@syzkaller.appspotmail.com

Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1191153e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b9ee98d841760c
dashboard link: https://syzkaller.appspot.com/bug?extid=835d255ad6bc7f29ee12
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ca4301980000

Note: testing is done by a robot and is best-effort only.

