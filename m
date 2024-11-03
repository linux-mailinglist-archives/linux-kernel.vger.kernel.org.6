Return-Path: <linux-kernel+bounces-393930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F09BA790
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B221C20B11
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5E18787D;
	Sun,  3 Nov 2024 19:05:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B17BC2FB
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660705; cv=none; b=kXmneEGpvWjYX4DOJDdbMe5sLa3W3xXmiT7BBZ7z/w7K2VdjF/mhz8isvOzkqQ456X0BHX7furHMyuaWAJI9OUraXE6mZJNfn21rNgSqf9ou6D1x0Hm4LR8Q175+imH2rD+9tIT6ZZVBdQjfHcNIabXlocI09dAMmU8c1OhPXWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660705; c=relaxed/simple;
	bh=1riMHXC2VfhDIrOzqIMjIpQYfNygUpj8RV9UfTdW6Vw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qWWukcZ+37Gbt9weheKntf6+/lxz9wub8BE1VlecAZ/jAtmHn/jeTmz52L4ecFxWkspifUPz4uieD8Ydbaywl0cPdeOjmy8gbbktKV9FffmgGEAa7vKspHKqV8eZWqBVKtz+TZqtLcrextw73TipaQ2RnyAvauuusaNqMUVbVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so33141345ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 11:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730660703; x=1731265503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLkLY9ZMkCUeagTF9sMaoo35+h9VeV8BSPyn62JQ6nM=;
        b=LW1DxwrpWGsoZ0HXx0IjYGEwbvGQ2OgDzZKy3wAp+/fRIvFJRfIU2qlaSMYYObdRAD
         n6Af+qPS/ehNfaq4dy2eCZzfHbvq//nxFPYfkWPymjDt8J/K9HeUtvwyxvJODVKYrp7p
         4u9kx0V6bj2bTkvTNpH00tMfY1+orrsugJTRcfgt9DIdwBDs7nMnTX4gm/9t8/8izGiR
         iejOa0ixLWz5raKXhbc3aat5UC99sipNBhI9oBHtuWTLUXVD041zB6J7zznO6f/Hurg5
         /eJahZjM4ylFHyjm1jHEhSZRFeMp5LDzpv0LtDDnPQ+Wp7O8EPgLhQg/+Yh/8gQ9+Mqh
         Iviw==
X-Forwarded-Encrypted: i=1; AJvYcCUdDfJa2QNaqYw270Fx6TlGdGNMUfSyaMq74KhaCynivnJLBuFPifXBTa7dhl9da2tVXOX3BErGdlXv760=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDIq1Nxyc6ZqlPLevdJ+9b9Cc81w6hqC+15LP151l5e35IPpY
	Bpuw0RXi3JMtK/w9XJX1Pm1u4X6Wg1pcLUIXP+mi9T/GFFCXiACf/no9v32MNb72JFrsVupqnjI
	qL8sKrK5jLRMu/Yo4YokeJO32DyI6eTK7cjDv+b4UiRWc6hgakrvCiBk=
X-Google-Smtp-Source: AGHT+IFTXVAS6QG0WIWR1LGjW/6RibDVLyfPCgwhkMbF0RZhGc/E716zj4QwJFeelUPkFJuFh8gBSXMdQ1eMSrKsallnQX3iZGwZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e09:b0:3a4:eccc:aa5c with SMTP id
 e9e14a558f8ab-3a609a2afbfmr136611715ab.5.1730660703482; Sun, 03 Nov 2024
 11:05:03 -0800 (PST)
Date: Sun, 03 Nov 2024 11:05:03 -0800
In-Reply-To: <6727c20d.170a0220.292362.d5e3@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727c95f.050a0220.35b515.01a1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_xa_block_wipe_namevalue
From: syzbot <syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com>
To: andrew.kanner@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Tested-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com

Tested on:

commit:         a33ab3f9 Merge tag 'kbuild-fixes-v6.12-2' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104a8740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35698c25466f388c
dashboard link: https://syzkaller.appspot.com/bug?extid=386ce9e60fa1b18aac5b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a64d5f980000

Note: testing is done by a robot and is best-effort only.

