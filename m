Return-Path: <linux-kernel+bounces-401552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B49C1C2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F448B228E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09741E47CE;
	Fri,  8 Nov 2024 11:30:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389E1E411C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065406; cv=none; b=VFqFhkal+txfG1ixH6wJOzeSFl8NtlvsaRWpKiHNqxxEUfZ1E3eZ7w3RqwuneRrLb9xx/YyT6i4AvzMVAWkpTurXgB7ISDFTluvKG7pupfbLLIi0vmRuSLJyI0zqDmzFXC2J39DIRxKQyFp8duFP8Ujvgv0fMgBMmKD99ofDKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065406; c=relaxed/simple;
	bh=9cUQtsMu2qXQLX0UYmLKp2Hcg4Lu4cElCkUuCBgeaTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gWOUFtaFuDR04r4pRf9Sxii7m9dXBFXMKPHYsx2nThkukCupP6JFFi+8HjQdjpbqPCXLjg9mtu0zsTdIT+xDosViXZisN76e8wWhb3VshS0rcRitnFmo89t8B4UB83at6bSbLz4+rbmhfPoceKkEaUj3JIwMlOVQuGJDP4Tk+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so25413975ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065404; x=1731670204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TCXCYWg1WbvXzrBqVd+I1nsEDlQ+QEtCse50dmW3+w=;
        b=hnC0RsBPfUYufUO9VrYiFT/iCHg3qb+zoZbxYFo1xT469AAuZbpB3AbC5PLOzreC7L
         Id4U5pUN/YxMi5hE54+Gf29uTFE94VmKCMiN/yMKf8R2NcmIktDOcDGyBanpD3U928wd
         Bk8+Z6omPvPox/ewGdwih/L3AquTVn6b/1l6vIJsNP+PBXEJa7omYLwKxBoEXJMyf9GD
         IxA07GMxkUxZ5gaG1BPF4xLcmblm+991bO9WLkPOX2OnCkadQoHz/4R7x4d8sKUBU/K2
         pc89EOZLtYUIL0YVoGnqLmIpTHqVql1nfTp5E0cFAmLnq9xqJMO+g0TmJUwGJsjK4LvH
         dm3g==
X-Forwarded-Encrypted: i=1; AJvYcCUP9Epbdk+vGSaiZiRcFtKe9JVhz5ffkjWNDWXbW974f8IoVS0W/7t2TWNi2rK/KVQ5C4d7bf3r/blyo8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKyfL3HBeIYkDsdY+Dj8qktQEApLJzXfh6aaO3Tb+9veaF9R4
	gHuGY1e0FiZfMkHMvv56q111JsUeSV1f6g4/uENhYSb2I5mc98UKYtgJ8p0puqhXpbX28DckjY4
	EtQ15+2GuWLW589KK9cMlFx9AQwjAbnzPotkGagAaN3SflNB2XQiTY84=
X-Google-Smtp-Source: AGHT+IE+HNz7/U6bFX8ibYDuM9m/pWUohJKAzkG8ZkjZkacZp8PVJ2i9vHPUwHmT8Ty6iFjcWurNZlPFxgowyatFw+s7Ed3498CR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:3a6:b0d0:ee2d with SMTP id
 e9e14a558f8ab-3a6f19c6039mr30320055ab.9.1731065404099; Fri, 08 Nov 2024
 03:30:04 -0800 (PST)
Date: Fri, 08 Nov 2024 03:30:04 -0800
In-Reply-To: <20241108111029.3505-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672df63c.050a0220.69fce.0012.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
From: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed

2024/11/08 11:28:47 parsed 1 programs
2024/11/08 11:28:47 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
write(/proc/sys/fs/binfmt_misc/register) failed: 17
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed
 (errno 17: File exists)


Tested on:

commit:         dccb07f2 Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1490835f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a3dd87980000


