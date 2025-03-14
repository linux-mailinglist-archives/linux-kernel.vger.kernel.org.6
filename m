Return-Path: <linux-kernel+bounces-561981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1200A619C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D543ABE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A51204C39;
	Fri, 14 Mar 2025 18:47:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E73204C18
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978027; cv=none; b=Qm3sIZvC81EN92CdNQuTqSnyCtviM6oX8ImqXvMtbKJ2Vyca6LQ5u3FNc5oONOYBxSiLDgsqA+ybU4i0mXzmv8DORi3OkA5qODwMkcvFxFdOhwnInB5JdfgHEFDdSBj1OP55oMKJIby5N3QhSoCRvEMYO/SdgAhyUt3SqSpj+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978027; c=relaxed/simple;
	bh=lP+WWwLeJcNl+xjynrFw4AUeIaxg2oLzPxAdObxBxnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gGIjtaAGRV+Ai11jYTRISHcabLHrmGJG5USh5uIz5bq+plmcXLCWHr3mjIId6BhBrMgqJ6FJmph1BRlc9cftsE0Unw2UW1cljAmWNWXCwWbgR79EqbBAB2yFw8MJDXLUryPxwrDQcPDoqp+G10UFximw5rD22wijuHl/gx7sesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d443811ed2so48127515ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741978024; x=1742582824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxkXkYDWiW2oVyldkemU8ucECoqqgSoeCvPEsiTtUu0=;
        b=eZF0UBegrCv2CO7GDdq4OfPpc3WvKt+5OAVyGUxsOtK7rFS4m8HaMCVHQ/koH5E+tC
         j1tA81EmMMkdlNT/+IjxsCJ0gBXtM8yKnjeQJP64MEInMZVvZwCmV4L5cClE178nME14
         A4i08TDhLcYSOWUbx3fsaWegoizQNigu2nnNSH75SvlkBR440JMwpwCSQJ6lkMERdnzA
         BvbqO2Lf0C2Ke9aMQZKs5hCD8L96aABwlRY9UEQr9QnKGicxwje80K3BBYhRVCN2GAal
         FuVcJPRza5mNoDYAVY4JcKB7KPMr7CpJiNdNB/dH5kVp8SN0A78wq9HHS1TBZz/OmLxD
         fAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXGYIuqG1MYFfSxpVYgFlzFC2hf/gC0MJuaV9kPyAHXl4tJlonUJk4BnKngwjofHJTiahQi2yy6rZ1IrEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0lcU3N6jKbC8bVjB/RQqeCXS8XPOluJIxm9eR3gZGf4F9k1F
	aHxptdO1BmBSuIBvuCFJfJXTcZnIAXqikwUqI4ZnQFuPZUt+ktbH04ABMnia6cDUcINjM5cugJt
	w5yHT1YSrorIGh9HWhuLhqVj28+TVrD8rU8Ci2SNhQFurcMqK/QY06BI=
X-Google-Smtp-Source: AGHT+IF2NJDjExuIXbMXWH2xKdFFik4mQ2Cbteg2XeWs+t07tMq6LOwOI/VHD7UEdRzJmzYoxxADQlr9bGDqb7kO3gZfuHYRjCMG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b88:b0:3d4:337f:121b with SMTP id
 e9e14a558f8ab-3d483a0afbbmr35023375ab.8.1741978024613; Fri, 14 Mar 2025
 11:47:04 -0700 (PDT)
Date: Fri, 14 Mar 2025 11:47:04 -0700
In-Reply-To: <20250314181925.69459-1-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d479a8.050a0220.1939a6.004e.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com

Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126c419b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ecb874580000

Note: testing is done by a robot and is best-effort only.

