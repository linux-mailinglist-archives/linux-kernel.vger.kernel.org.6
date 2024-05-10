Return-Path: <linux-kernel+bounces-175604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3408C2265
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE181F218C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8F16C693;
	Fri, 10 May 2024 10:47:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C4168AFC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338027; cv=none; b=oU5VRZYuDevLCVjyambL7BPHtXmb/fH7qeoQaZ/WU+xdkcCSevFGg0ybkuVqIJ8uU8sbxboSLxFbjlX9xPopoSijGmr4iHeKhIgJkhoW5R7MEvUXbYDX0lbExXovqDpokbSHpstBDwO0RBPQFTbyiMrsY+OKSkYCRVzrszuNNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338027; c=relaxed/simple;
	bh=4IR71LSKHqdD2PrhC/35SukAjxHdT8JkA1/lUYr/lF4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LH79w+KDs/xXnMS4m7Qvf14nmjzAxtwoECNb8p3wjjNMTTxXSQ9Wr/yaMq6Xxq/QE4pRfOCUvydKbZQLBqZjgohv6amiWdRsmQrOqupHhKXV5KqDk1/fsOGRdWTJ9O/6fU7X9gCZs6sq0/s7YlBHvSybSxmNHyhyLFy0Iozrv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1ac2fbcb7so166059539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715338024; x=1715942824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FiAKESNENHUiEn6PKLEqu2bawiPoKG+5rdZhioF0VE=;
        b=Y9eLu3FENQLuxI4Tbo/qNfL11vO5lXqb3G9Vc0ELJ8ma2FRmoLaU5pZd6r8xeV6tf8
         dXlFO4m9yi/LfxCkZVpKM7FJ2WuBbHxdeBpmHNUcBgm9A5pzXVPp+3JFdM3I6csYBAR1
         VQgUTxHD/nxGT/jnD1LwkpABJh349Pc5Jrw7AMQVzQ6sLt/UGM15ISV/23VUfcm6emrS
         uYomU+yHR+2aC294L4JESvwK+1V0eGy8Au3a0caEHKBEi8X4E8Al9cKBeSy73ZRH9AE+
         k2FWbKqm35QMz+6Jun3MmNxZEA12E2OpWRjo3NlGicyiZiykbeKR0ahlosmbNu320++s
         XpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCViIE/Gbq64bColwdGa0pj0twl9xsJCTyjKsCLyYDmeFREgsAvNbJgcfuyztx+ja76fbbNONRYtjPEG9PTmsaDtovvJ8np1KGMrhL3q
X-Gm-Message-State: AOJu0YzLfOAl/XFtOK8qXn3rHIclm8pAgfdeXX96iKsbcKthkUODdXhQ
	Bfv4bsXBjhUDzfJiZ4zGR0tOUcbG1Ycs83Y/pRubDBOWtzSKRLdsv/8UQ97WDhJkVwWG+a5MHbR
	KEBarKTZlVQxJxqCcwtjDkhFrhFwSRuDngJUlg5DY9ntEPEiaay1ylVs=
X-Google-Smtp-Source: AGHT+IFeUb5Qzx9N0wYsz/Xj6vaadHHDkOjbS/et6yGxp1prheSgdBwwSqVqOIN/jmBBXdiOp7riWDmHbUvRlkZueM521cg45WPx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379a:b0:488:d489:3940 with SMTP id
 8926c6da1cb9f-48958c05a44mr125386173.3.1715338024009; Fri, 10 May 2024
 03:47:04 -0700 (PDT)
Date: Fri, 10 May 2024 03:47:04 -0700
In-Reply-To: <20240510102643.2517-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000975906061817416b@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
From: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com

Tested on:

commit:         dccb07f2 Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17eb2c00980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170c6a6c980000

Note: testing is done by a robot and is best-effort only.

