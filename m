Return-Path: <linux-kernel+bounces-176856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90908C3627
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623472817AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEBA208D4;
	Sun, 12 May 2024 11:05:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13181CAB2
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715511905; cv=none; b=MJnt+7jpld+BBbYhIWgxPoF2EZJDcdJ+bGyYG6AmLCEjJFHz9PY2oKuUgRBlPLoSQo5ohCofYcc1wr9a7zRa3+0CtxI3NOmrLpuix+m55PJsMSe9Uvlxtj21faei5d+wEnrZbAD2FpCnHrmBlK6tTStMrVgr4+HmUFMEfba47e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715511905; c=relaxed/simple;
	bh=jYig5DgAOcqBHrE0/9+1Mu2F6/2OlimOLVdZNsXTNhY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pW+uoA3KRcyZ3LzVcymzNbXKxFk3SJskFdFwzYvlLtmXilLzidOzAQCkB3G10WCGiLHNrjJPrF7LbOMpZitgmBaONSJtQ0AJUmF55+hisjw41H6/Q9YJ27YIYGHKs9BcCsEQaVnU84gwlskW/LGxVw1PAHozL4zU1E1w7xpqoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c5171eb6bso44901455ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 04:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715511903; x=1716116703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AzMq+CA5JeAen4yA3wRsZUlx1QJVPYX6wCmrtep2Os=;
        b=cGrSg2o4v5BlANzyYR7kTRDWMqjdFF/HgcH6TBFEZz+surjEonP5JZZlO6Bvozv3W/
         bU2UI5uvfim1bXOgYGyR1FfebQDi88mAyHlZ6XXHeX7KIULUT0WWHCSkGUnX9cO5QVy7
         jHvTLj8rOSCcZ6eqkZOzaAD6V2CSy6sfCIcBdd3+gZ48eQOVt4N75W3t6k5JGq0EqRvd
         an3qP5Iwghmr2vKP56UIvI++nkra4c9sQc/zKhZKhGHoEuBmWaG8fWI7eyA9iTIh4ikU
         UzHJkZqD0ZZlMFcizIAzT/VTkDDIwfZSsvOJbN/bfWry2IV3ANtRuNj1LKuM/n0i4o0Y
         sC5g==
X-Forwarded-Encrypted: i=1; AJvYcCVhPM314feMmjurCCZbOFk6NSgWkJRNGwphWxrCcsOvwCAQ3K0MT5ebPZqn0FQlU50qruCDMcw4MDs75c8ORbLbTbfilOmwS2+W317g
X-Gm-Message-State: AOJu0YxxM/CFOnXMJT2FkS5xMMwBan9fzzM6M4sjbzT5Wl4EveTB5nqp
	Yv4v/WMeX+fUBYuIq1kE0yXNMc7sZDEo2EfBwZZmbobCc2vHBWTAEARKkSOpwyivwNaXw/seLH5
	Mc97jATMAMekgmQLfTkFGLTxphOV+Gx6hx6rQbRhnopyAhgu/L2Lsn9I=
X-Google-Smtp-Source: AGHT+IGNjREMwQGltAFiKnu2rdMUsKA/x7WehSP+HZJj5UV4BdfJukZuMBf6IpPhE0j3eAVYtBhejK+D6fNrUTJJVVE3zNpl+ZoP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d152:0:b0:36c:4457:ca5d with SMTP id
 e9e14a558f8ab-36cc14f785bmr944215ab.5.1715511903210; Sun, 12 May 2024
 04:05:03 -0700 (PDT)
Date: Sun, 12 May 2024 04:05:03 -0700
In-Reply-To: <0000000000008de5720617f64aae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009966ab06183fbd83@google.com>
Subject: Re: [syzbot] [block?] [usb?] INFO: rcu detected stall in aoecmd_cfg (2)
From: syzbot <syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com>
To: axboe@kernel.dk, gregkh@linuxfoundation.org, hdanton@sina.com, 
	justin@coraid.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, loberman@redhat.com, marcello.bauer@9elements.com, 
	rafael@kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a7f3813e589fd8e2834720829a47b5eb914a9afe
Author: Marcello Sylvester Bauer <sylv@sylv.io>
Date:   Thu Apr 11 14:51:28 2024 +0000

    usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12415cd0980000
start commit:   9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11415cd0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16415cd0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=1e6e0b916b211bee1bd6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15661898980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a5d1f180000

Reported-by: syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

