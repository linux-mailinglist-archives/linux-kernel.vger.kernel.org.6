Return-Path: <linux-kernel+bounces-377027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892B59AB8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489B22846BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FF21CDFB9;
	Tue, 22 Oct 2024 21:41:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B981CCB5E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633265; cv=none; b=jXIAO0G4fqK3vL7WPJBqfXQEs9imH5koCvXbvaDVBSG/HHtuYSBw38H4XLpMN/pm8SO764NPV6YYt82cRDR/NJgsv1PbqbBBsOb41moQvl7VB7vs/9oxhPzMR8QxzXVF4DGKsILwcGDciGourIGEu/Ugltkv4uAfH+JhLD6Owr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633265; c=relaxed/simple;
	bh=VHmxvXoRQ7ulOiHS0SjpfrwBYQqTraReyUlvYSYLn3I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bpwT2w1d9JLSxbm77la2N7XGiCFswp/+cM5jqLmI9YPi2wg6S7sEUYEU6D4HN44MIyUXEK9P9gA+ZpnYQLtvlwK8dCtL1ngsrEpzjYpReBwQnjW7Ip/Wfemwc2XKahyOuSV7EixjpqTZ3fjrHqJP0G0eBFWLcZL1mYpGKwqIu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so2560575ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729633263; x=1730238063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uk3mWRLHNiiFydc74DzrCKIV1CzL1sWKjW6rYtwx+A8=;
        b=QAo4FYdRT20epqQDV9GpofqSZyiQ1xJ2v3LYEHsFeNNNkeJ0LnsuhPYBGxIr03Sz0w
         WjnI5DuP/BPGpM+xSNLWKviPO4LRn1C4mRroQl0Rb1StlbCeInmm5BeGe57CKqxkwh16
         EOVCsNQa85Vxx6LooMDI+MyM8nRuwPotAXFPXzzXIdcwpg++NleNPL4MYQRjAs7N0flL
         qep0/VmVIMTz40xW3GKWTEiGHCGuRrf7u5hCdbtfP0PNbvl7/nhOQUo98PvihvqRuJi5
         6HSwKYzwQStirGOi9MME3LZfARWjPPiMEzyi3d6c4MZBHMqLx0SiLv+KK3UfiW7jA6bc
         gyVw==
X-Gm-Message-State: AOJu0YxiE4Vgt4+fJxOE52R9SmmA0r0uF3N53tpWw3g/kQNwapAoxcMk
	Qqrx+sCZu7/dWWIb1DLRXm0tMe+FFO9mTTw3TRW1qB6ftAS7hU80WKoHW96cDCwn2vX/Ds69oF9
	HsfJer+CSRsSzL82t5gK3ExEWv5VlGP1Kv3lbKdfz59UqT0FyU//Z4Jk=
X-Google-Smtp-Source: AGHT+IHob9EmcY8Oy+rjWwhZfisIquAOk1oWunwvwztDlsjD4+QEZ4LqDbfkOCVdcIcN5ZOnh4SkG0mOCZ/WD4e9Tos32fbmVtn6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:3a0:b0dc:1910 with SMTP id
 e9e14a558f8ab-3a4d59d152fmr3793935ab.13.1729633263455; Tue, 22 Oct 2024
 14:41:03 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:41:03 -0700
In-Reply-To: <Cxjx92g-RDXPwPhRPOczrlF7XC9EQd2TNFcHJN2cZryuWJnFbMnXlmaB5oZYD3Fm5ZLsvazKTGebBdxdOWGztBE91Nz67neXQ91bd-Ro-1A=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67181bef.050a0220.1e4b4d.007a.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in btree_node_iter_and_journal_peek
From: syzbot <syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com
Tested-by: syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1228d0a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=005ef9aa519f30d97657
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d0d0a7980000

Note: testing is done by a robot and is best-effort only.

