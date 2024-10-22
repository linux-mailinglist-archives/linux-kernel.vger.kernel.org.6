Return-Path: <linux-kernel+bounces-376077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E59A9FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6675B21CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01B19993C;
	Tue, 22 Oct 2024 10:11:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363C1993B8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591865; cv=none; b=FrQ2PofCFhtoheQ4arN1eZCX4HfDUM3XXFPDB9pcWQTv90KshcqH2WlabeKPv9L447gYywONDxAu3Q397Niz2nPm3xwzSoDR1gBuoCarTwOizC7af1SqZhmgoVX1ErxbjYg1ksQ0k2353DQaM0D1Qc2KBrOAjYN4KT9Q+tnmaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591865; c=relaxed/simple;
	bh=L8Uyi649s2m40I0JLwCAzmHXr0Df5flHBX+NVq+nmVA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AKaUg3/OchvCm98gyvym0tNs/X9haH05fVi9mVQ9PgNJ03DGa9McfzaGk5ymzaoudj6/Wu6nIVvN6zKM/5/1+wO+qqiXxywo4GZt90ZNceNOnjQuH+GGpQEkwg3+uzMf2zXJD9JVLTF4aMQYinZNWIfBDD2CDjKuQhXujF973nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so48822725ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591863; x=1730196663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3o3zq1GU4yds7lbg+NbzU2tEJq57lSCyXfB510B+bA=;
        b=bhZDuvoGGvvuSN84PxreKD6zQWgCFuJQiviu7HAvbcidy2egwWYsBPqYpjbpT3Qu4m
         gKri8XPWza4cZWH0jxvepHrchb/LlsSNhHtKqqA4xLQerhvCsowr+NWdG/tFeTslBOVS
         9vNYrRTe+bcyt/J2DATQYnPgdQjiF7WvwOzTmfvK9Bb3YP64tGHyluv8nLLkvjvWttd0
         8RmmIH6N3K/u1pJnpzk7SKHacAcl12uMRf8fXpiYQPYjYNJNeMhEa8pWQnsCNbgNtf6F
         WNHTT4tBM3NhWyTnFR6FKI8bfsSbn5LZZ/V8hIW7xLoAhSDZaNFDHROXlovFv41mIkqx
         v+GA==
X-Forwarded-Encrypted: i=1; AJvYcCXw1IOh9WLZZAJ7HrXXIvLevTTSpt0FVvL0yzebgFIGNqcwEdduObvBUf5dIHFFNFeoL6YrFyBl6AMpPi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/I0Q8SCI4zelTlwUs/xdKch7drBY60clvIqFlQ/fIgYI/uALx
	r5Cob08fEDt72Yy7iVYwg6+JMQzg67pEKcQymYSgQj5449CglDNP49OlE9fGl3/uua+C4ru/vtP
	wyBhTItEFonx7G/pgUHe4jMLJlszN1VxRBzwGKarjUA4YO7FtZFYAtlg=
X-Google-Smtp-Source: AGHT+IF18dfHmvud1MzhNbZ/LjtNSGQIhn0kTO0Rx03lSMiSnRyNSbXOWomnvfZ4QkDs1XGPdLbQTaXb+gv+SRRhJchVuyK3+gej
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174c:b0:3a3:b209:650d with SMTP id
 e9e14a558f8ab-3a3f40cbd4dmr126799525ab.26.1729591863099; Tue, 22 Oct 2024
 03:11:03 -0700 (PDT)
Date: Tue, 22 Oct 2024 03:11:03 -0700
In-Reply-To: <ZxdzTL4UYZtgsIiK@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67177a37.050a0220.1e4b4d.0074.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in
 xfs_filestream_select_ag (2)
From: syzbot <syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com>
To: cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com
Tested-by: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com

Tested on:

commit:         0338c38c xfs: fix finding a last resort AG in xfs_file..
git tree:       git://git.infradead.org/users/hch/misc.git xfs-filesystems-pick-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=11150287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=4125a3c514e3436a02e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

