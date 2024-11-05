Return-Path: <linux-kernel+bounces-396014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B59BC6B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC71C221C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DF1FDFAF;
	Tue,  5 Nov 2024 07:15:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF3183CD6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790906; cv=none; b=KyB8OG/UUV6XpaYPMNgNaj1NmfATHmWS0xnYoR0PJ78f2iuo7gbh7ZoO8klgFTuHbz3CMkxpAVBVMDuskES/dzp/XzGDzc8D0GidPq6LG7okiTI3gU2NnIVEdiU6lJDnM0qfdePq9vG5dSaUNHq+50gJ2zmAdreCy4K7x2gGWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790906; c=relaxed/simple;
	bh=AX0wnbzOVWBFJ0z+wYiz1cnR1V/qBBfEQHs42pi4lsI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O0p8vGoDuDD//wePs3tbC7uJVG/q9o5Lkn6XtjnPCFQRx88PTU/u3sgTTq/ankF+usig2RB66qtYErcMcU0L1vfjb/AsJl3GsCX4/mnFeLsNYLTe4wUbwz0LWpDj2HzWv6DF1Sa9P07tHyW27bkRr1+rfrNDDW9GEHfmcBP6+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6add3a52eso35278715ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 23:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730790904; x=1731395704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udJxfntUylZegD12LXtHmkhlsFp21Pyjgi/GZHXO0Q0=;
        b=fgtY6UU8ZGwec81pctjvhpRXvI1fL1ZZ6Zo3lrfKziJBEfqV6EfMxnlDqy3tI0HF3m
         1LKyDdjJNFQiEdsvAtNOyllmlZgiIoLqjRCprp67Nx0/zzTRRbd+d++FNK9iycgFalG1
         bmGFVYH9OxvpTJYgw+7Ru5zy2oY4KThlTBqmVBH0/5BWasNC/JYOwVoGDUjRcYEWdWs3
         IrKQeYN7xxk42bvT88Cyfcl3tNYaKuA6KnOqeHyLpEpdfovMXnRhE2JY9bKY/9xnLaXf
         PXRaeKJAQt/vAupySvRu3xRjt5XXftG+kM/IBkVc0+fixAR5Ij+2k8eP9BOOQ/Jt6maM
         EJKg==
X-Forwarded-Encrypted: i=1; AJvYcCVtlqbenUEGOMaRASZ2MzWsMc5Gyki7w/jgAWh31zNCFIgZ9UxOofrCUINTScPwRNVazBsP/v6d850qbMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNWHVVAwM6oLZutm5QUIyRThdru3goa4b668vI0wU63BP9qMK
	BPDpN1oXHPAUMgg+woBl3siG/1JWgRhihXlZbZgh9Dk2GIVMSMxfmOLaqpvXWU3HeeeyI3Wctpl
	kp8dqVzriDb5TCNL2u9YXrAShxQ5JBkBy4+FhIN3fOMtHUnQVhEEyWVs=
X-Google-Smtp-Source: AGHT+IFENoTKKV4sJFxJHInjEOnTWgVx2bbjvJL+998wFc4aiBPfOT49lkWevLcZGh8gALCc97t8JyVFflWcXBzoaOwhSWirGlcN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1387:b0:3a0:c8b8:1b0f with SMTP id
 e9e14a558f8ab-3a6afeb07f8mr149769545ab.2.1730790904212; Mon, 04 Nov 2024
 23:15:04 -0800 (PST)
Date: Mon, 04 Nov 2024 23:15:04 -0800
In-Reply-To: <Zym_h_EYRVX18dSw@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729c5f8.050a0220.2edce.1503.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in blk_trace_ioctl
From: syzbot <syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, ming.lei@redhat.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com
Tested-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com

Tested on:

commit:         72697401 block: don't verify IO lock for freeze/unfree..
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e8ed5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c16289c8c99b02cac1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

