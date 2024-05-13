Return-Path: <linux-kernel+bounces-177501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888B8C3FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3916F1C210B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AEE14C59D;
	Mon, 13 May 2024 11:24:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C210146A8B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599444; cv=none; b=f+wG6rW1/ex90ZEb1hx8fmLa45XeohUfHhDUNZmWfbh4pXZI3fzN0skKTmubEM6n3X8+KLVXdwKJbI+Thf5kEjKeylkz8ylVWgu4ZeVyBi22Cg07Xpvt+AuUY06eHa3mMo/nxEYCJYv5cqjUU5dUvpvIwE3tisgiZ8z6WtO2fKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599444; c=relaxed/simple;
	bh=8XGzwB5/KmaCImU/CjQwAfbce1h6HoPd9hyQteAVZxc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KlxCn03vFUAiy+SeJvedB5EhRtXmU3WMRcq+ijwMBUJEgSBm6IYGEfFtAotJ9zd5xJAcRVJrsR5zJoBwH6ztVqzJFlkYfjteKv1t4pEeLqwKO+y/cI7uWQ0m7tyYyh1K4nBIsIflrFdUzWmty0I2umoYTRGUhGss4a8gzzSl350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1bdfff102so347288639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 04:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715599442; x=1716204242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoIkvFhqxbcz52fu41phthYKCR+A8owaIUQQo3Rz0LY=;
        b=cIY3lOj0VhghtUn8kBG+ChC99g4pmIqQvcTd2Sym+HO9OwvjUlM7ZiP2ZVKJNa/ErC
         Vq2KMkSvThXlcNFFUBfJadLz88jPIwNKejJE3E5qnO0+grm+hOADt5V8FnQWCOpwbjnM
         88cHN0xTW7Uchf9o7cI2sprZAxXkqFZ1C54X2sjs74HjTXcDmnLfXJvCLOZh96E6NKwM
         ZxkCx1CgEoGHSuckmXwclCw5n6WJqlofR8ReCk7vcfl/JBlGx5TC7zm5M56vU2XkT3tM
         ckB2k3KceV7vo3uufDPF1GOIG0kxoGDiXeUymfco4846eyqgdfMpsjGsk28lXVERklrH
         r1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCU8vvJ8a/hAco+wWDngOb5P9uoRIohW1FFRHiVZKd9YgaRU51oWwab9G3+9cMmkJlwG+QgsTECT63yQgWfPOuDFFCuEI26B+Lqql67v
X-Gm-Message-State: AOJu0YzOj4nD8WVX3zTAqE/SVsvadp3F0A1fJ+83t22ltH7I2HDfV2Tg
	hocyrabiRcmTICnCiD6sO+YgqWnRd2Q2ddK4DBbenWSI5hTp9NpN7r+PSRJxF49KkcHwRmNNvw3
	LLK4x8Q93GAXYjGM2P7c19o18RXVw0ykbfKUcA3wyPQuZg6RDSces8V4=
X-Google-Smtp-Source: AGHT+IFtoCSJpQtGZrGzZUO2bYTbfBdSy/uZ4PAvz9mepD5VOW1eqKiMhl56qKj/ZTSdBv//FygC9Wz2qTwZex/0neBu8XhJlSIw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8703:b0:488:c8a4:76f3 with SMTP id
 8926c6da1cb9f-4895a49d4afmr1129290173.6.1715599442377; Mon, 13 May 2024
 04:24:02 -0700 (PDT)
Date: Mon, 13 May 2024 04:24:02 -0700
In-Reply-To: <tencent_3966EDCECDA47B8A6C302F696D8C95DCE90A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000570e010618541f59@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in cpu_replicas_add_entry
From: syzbot <syzbot+73414091bd382684ee2b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+73414091bd382684ee2b@syzkaller.appspotmail.com

Tested on:

commit:         cf87f46f Merge tag 'drm-fixes-2024-05-11' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=152aa96c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=73414091bd382684ee2b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112bfdd4980000

Note: testing is done by a robot and is best-effort only.

