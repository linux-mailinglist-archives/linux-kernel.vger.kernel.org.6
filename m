Return-Path: <linux-kernel+bounces-430445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031609E30EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D410B2849A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66713179BF;
	Wed,  4 Dec 2024 01:51:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B521106
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277065; cv=none; b=mBACsW7Hlp4oo78aMH3nFfp1KPGDRihCOe/1aKmslRbVpekzjQbWw+1y+dmIUMTDLnThLBtNPPYihVMYc1zi5+kZxFmVs/btT50wxR/lvcXOWWLycbGCnTuLRfCIJdVw5NDoiE/d/6FBsKd+Th3ZuM44SpaPso55ZZLUL6jbw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277065; c=relaxed/simple;
	bh=rWtZF8Dus1RjbJZaZTLBXSr66OIKeFm9TueYUIt7Zoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kTQ6+qpk39IJ7NuIrHvJg1ZLYBMH5AprVMBtywekOBERulEjgp59xOYWXtpHA1o5iA5Ro4F59yCYycWcUP3psGU4w9saJtLV55Uxdf13GpMU7I47NWsdXU3T+GrPJMTLjh6l1HDfBhcjlesrbx12O6rS/t1baGf+qV66NLnYzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a763f42b35so71886465ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277062; x=1733881862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojyRDzOs4L5r1zvt5rLALFwRhgSLoRI+YAka9dryW2U=;
        b=mkNYriF4D7lhG0Aebh/L9uxdKYxPdYPUjyal4XqpRWdmKo1yD41SLMFICjlV6BhMvT
         088VHc95oE2O+eamwplaFXtDE2qdFf3BCTiPXMR8Q6tzgnqYWetC9TPiwR73jrCnSPQ4
         5o+XjLDTaZ9Bs35SXHUD/o8pqZeC/MF0nzg1M2Hl7kp93VKk8WFQTZ/ua90SvSrN9VX2
         toaSsnjp/9k6KNg4Jh6vzjXGOgyk2mPgAD/1ZasL7nkEplBeuKET9p+Qj2zIMzTUCg7l
         higwcUdSXisrJUMw7hfkLLMPMwQOTUKAB6CAh6Og8UF1YLWrXCOxECjHSF+oG8iHmVDX
         sroQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh+byu8NZifdWU+wS/hLbM7QzX+0GxysO+3V9uEYsfCGC9qQ/3CjjTxEg+hzZ/jA2hWiTFfq/4DnFwCX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUV/fQr5oLEteXuHN9TFp8j5VF3nzcyTrYd2PDeRbLjryAxKW6
	N4XpD3wcWmeUp7XiYa+nK+1DjA31JfMhzUftTmJIP42nrSwtaPYgbwMGqAN1FKBtbmeI4aa84Xh
	P56e26/oAZ19HWAvuxC4fgNJQ52tiFFOniM+krhZYKHjhgXwNSdTX9NA=
X-Google-Smtp-Source: AGHT+IGmDky9ubXMdmWEyJvsqWfLs/KF8vdb5UnF3UfBT6VPtkSCq7Mi1MPMv2mpAS+sZb0fM/xrpgyQuWJKEeTuR3Zk+AqaSlPn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:3a7:21ad:72a9 with SMTP id
 e9e14a558f8ab-3a7fed5f51amr26749215ab.17.1733277062597; Tue, 03 Dec 2024
 17:51:02 -0800 (PST)
Date: Tue, 03 Dec 2024 17:51:02 -0800
In-Reply-To: <589149.1733244622@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674fb586.050a0220.17bd51.0057.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_retry_reads (2)
From: syzbot <syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bharathsm@microsoft.com, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com, 
	rostedt@goodmis.org, samba-technical@lists.samba.org, sfrench@samba.org, 
	sprasad@microsoft.com, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com
Tested-by: syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com

Tested on:

commit:         12588c3f netfs: Fix hang in synchronous read due to fa..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-writeback
console output: https://syzkaller.appspot.com/x/log.txt?x=135e1fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=5621e2baf492be382fa9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

