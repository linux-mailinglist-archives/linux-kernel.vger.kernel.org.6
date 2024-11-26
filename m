Return-Path: <linux-kernel+bounces-422560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF6F9D9B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22BAB289C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E072F1D86F6;
	Tue, 26 Nov 2024 16:18:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CC1D63EF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637886; cv=none; b=XVmbiHzHcE4GnVzalz6OQdzlb//5UTwmsZtjZrV2g8+NluRoT9nRjb1HqYezUGaOgEfhqJ8t7xtCwTnKUExsvs4unUnpoOUQTDToT6LcxTukiVvm31f7ItZSOBV17/jtkKfwbt3xEwEwVbO3fqKWEOu3sNFG9XG/bweDWzuZ1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637886; c=relaxed/simple;
	bh=Iw0pStb8CZ0fodCHaPZSSu7jsxSq4pCU5i/mh2nn67Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=awsx1f5xh9jGxF7+Jgo6GQBDO+QV1hoAVe+3pWYhw9jnBj5itpgHlG/UtgzYinnap95M6ymjQIDMUj6LKLMZAwoUJL9NC/t/DR6lQjEjM46vhiREEA7RFOzHo4ugvZfSDBJ0A7L7QeZrbyOwvhcbYHXfiQAZFT7ttTRQ0PU+Ujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8419f8859f7so197662939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732637884; x=1733242684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9DtD0qT+Ay2BiKx99/pByg5tz0NTNu2+EHpUxVhJXs=;
        b=q9A168ChFx+fZKitB0iOQ9UH6IgGlTPXaVwjn/Kx6YcTZPIFrnSoHJW9xyzFpDWXP7
         6DYiGgyXXEFVkbC5oqEKZMGY50RY8tj1S/mMh+Ox9mkq4tRV0Rgf7o2UUgLCU9DOQcOy
         IB4yCl2Gj0Iw/p0t8DQGZ3r9APkAavBCOs8nFrlQl0xURlyFXTMkm+5PmcJk8P2n2az/
         EKUVWZCTALV6MjP2H54AN6o6ps5gk5K5Akef9VZu6yyNI9SongcZ90IEQH8s+5Hz+xER
         HPFGvkKHtjvpCWYLP2awYJepdcQZkam1KJ+6Xg6B2yQmfSmD4DP/vIcGBUJt0ZNS2Gpe
         XCPw==
X-Forwarded-Encrypted: i=1; AJvYcCVqP38TT0mQjXo5r+fNHvJBbLmFhbd7HemNuDDkWSLxlQ0xu/QI87ucDJst5F9PtxbhcfnvFymjm/myn0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qiR5jgfqaWVV+tBt5HfkeEds9+LHfN9SgnJ6CVJKn+ZHDeru
	aytnZFhWM06KUcgrHr0RCzNRi951Q/1o7ClDelNbetRcSH1Fvmq1kqZGwtSVGUCtqbhffwCzP06
	jJ0T0bCQNohxUEKIFEIKILUE3BVMGItHsJ7kmdsWQZWVXLzzDMazolPM=
X-Google-Smtp-Source: AGHT+IHn3qG5Q2sQL2/n/zUWg0mqXswtHHhQeWx8CuAUi6O8y5a2DZRSJ1MCAhMb4y0ImekB+ahZKaGalSLMoepjPxuzUvcW+HkH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190a:b0:3a7:93af:ef55 with SMTP id
 e9e14a558f8ab-3a79ae9d90fmr201107455ab.12.1732637884357; Tue, 26 Nov 2024
 08:18:04 -0800 (PST)
Date: Tue, 26 Nov 2024 08:18:04 -0800
In-Reply-To: <67447b76.050a0220.1cc393.0087.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745f4bc.050a0220.21d33d.001c.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_journal_pin_set
From: syzbot <syzbot+3bd0834534ada7200422@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 86d46471d52bf33e8652b220741d3223338d1724
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed May 29 21:54:46 2024 +0000

    bcachefs: Don't block journal when finishing check_allocations()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17538f5f980000
start commit:   9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d38f5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d38f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=3bd0834534ada7200422
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162325c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112325c0580000

Reported-by: syzbot+3bd0834534ada7200422@syzkaller.appspotmail.com
Fixes: 86d46471d52b ("bcachefs: Don't block journal when finishing check_allocations()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

