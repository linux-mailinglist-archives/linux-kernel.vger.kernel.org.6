Return-Path: <linux-kernel+bounces-266265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A293FD51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D8A1C21D50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD855187337;
	Mon, 29 Jul 2024 18:27:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91D7406F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277627; cv=none; b=AobHV1eNa3M20fUcipktl4gpU9f0gFRsayIDlP1tQBwKezMNrL4qNObbyq4YYxqqHDjKxttcQxz70NQNGh7hA3Ba2Zvv8P3ND5COk0sWtz0k4jpf44cUC1dBnYzMf7OI6vrcPJrApfh53iTsz7l1i+lsdlNMNWEW12WM6RvhhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277627; c=relaxed/simple;
	bh=1YIV34HmKrX5BIQOSVq6EJF+N30eKUwZl6AVoK4crj0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RJqdojkQFwhuon6R+rQDi4TeIDvuxJipun+8khMb8MTF/Pfq9y3niumZPWxSA1/vJystAvdNRURtfyN2TAsXRXftFYZ/bs70Tyh6g/9WGwCVstl+MWB9REXJLYO7iIGRJMcq/b1VBA8uA+O/yCPL0WPzWOQmSvKTVdwdUS+k8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa12a11b7so283161339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277624; x=1722882424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGYvq/6bOR4jYv72OZJDcB+vk9Er4LnH4RkWNj6JRTU=;
        b=qLDMzNrzTTm1yQt0RfKUoyi8YBY8roZtf5IbY+XozAOwdDSzGMALNFK012MkaDT6Oc
         I/+trEL6YsMIU3i2KPJOheJX8Y8axd/huMw46I66dsW6t0Q2lGkOg5DmuGNrJ13Ql2Hb
         6ucNs9Xu9GZV6ksNpkzF5DgAA9x+GYg6E2nqV9cboo7hqiwuUbs6O2RHvedre6wgiCTf
         S2fclSxPLjdyiTNKjyYXlFUFo9QsAoltDUMhBvFmKhksNEh9kX9EBG6aLVLTeYVbyUtg
         Re8Len2ME2VsV9rdurD31Z9FyYI6jc/tSD2lsu/Tck8biX3svqvfbVFQ7nQ7tqxYM9y/
         /dCA==
X-Forwarded-Encrypted: i=1; AJvYcCVWySwMzIjCFAtrNOglC9I84GKc8LjX4BKudzwEg7bq3NV25zUrXz17KlYk7anzHX673iBlek4MCnGcDj/26mSg7oM8wGD68oYIXPnF
X-Gm-Message-State: AOJu0YwCDBtxpjnDDZuBDl6zx/RWT512811loi0vzMLIX+VhRXZstE0J
	EVW3b0Y75Y+e0vyD/Be4HI8GpWdL91z/MbcZTr/XuWY/9XEkXuFKAe3SB0MF9B6IGEfth0Oc78m
	17JUsJUVylPt8fPBWA9Aj7j/A6R+mKdjmYtNY0Reb4EHbMwtj28kDjaQ=
X-Google-Smtp-Source: AGHT+IGBjtP5F2pZX+5YOLnHshBnmxrtHZWHQDGKunRQS57HKJqDNqoDGeQ7cZZt66jtP40YPeogjt3sIF38iwhLMccA6SHG1WTY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39aec2abf78mr6623705ab.1.1722277623771; Mon, 29 Jul 2024
 11:27:03 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:27:03 -0700
In-Reply-To: <20240729180122.87990-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f847ce061e670195@google.com>
Subject: Re: [syzbot] [net?] general protection fault in reuseport_add_sock (3)
From: syzbot <syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, lucien.xin@gmail.com, 
	netdev@vger.kernel.org, nhorman@tuxdriver.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Tested-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com

Tested on:

commit:         1722389b Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1508ede3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=e6979a5d2f10ecb700e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c648d3980000

Note: testing is done by a robot and is best-effort only.

