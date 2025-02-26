Return-Path: <linux-kernel+bounces-533262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01DFA45781
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A7C1798EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0E2459D4;
	Wed, 26 Feb 2025 07:56:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCA2459CF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556565; cv=none; b=GHo+UmCMxhDVe8OL7MWzhC68mbpTyE7TxhodSy6ce50efBfXdMOqIt+CBnn+4c9cknWm9/FlS/K2rfN3PjOP32H7xnl9pqB5MD4x9qQrgwUi6mMiAkPbLBtq98GtHeE5+MOXsKmx+JXdm4EJlktAYHjrKqHkwLY6H287gNVCFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556565; c=relaxed/simple;
	bh=9sWtArTfsCXQ/0N87eed6VqmHB9iKc08+wN9MkB+0Hs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bu//suFmu4/BhADlYR9Rn3in3lokegGb0BOybzjqZnNdlQlo7BKWNvIDxQTet1HHS/jVQzRGbniMVfSrApPRt9m88xpBFIcekAxjGnf/qv8seWnczfu7ySzfkblrmyJFUpnnWe3/15Dp/KRzmwg1NgtGv/vgYJrHD7M5K55Pbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so54821815ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740556562; x=1741161362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRKRvXk5uImHEDe6ppaGeHU5yUgJwekaD02jpPZeV00=;
        b=RqHq4CZu9NpzcU/MYCahdphn+YbV+J+7kbVupOY1FAw7JJh3FdTuF25rDFozLUBbDV
         pjFI3rFfA45liBocuqNDVXnKB+87hg+8i2azE/ebC5xjXHdwTfcRqTVNnPmCBlBmFzW4
         rc9urcFKGUzvAU9F71zQ+8uKL8FuMPI4MJmPsWNrQ7tQ+ybcg6gw15n2OrDFnBpKqJlV
         k60LV76C7jLuI7uq7iUHuSLwlwa+gs+F9Pa7IEiiJ+II1bZ/+bXhXCoUS3KIh4LOlg3p
         FGzgKabPnalRmZwN6QFl56e1hEkQABAuDUlKLkbSQtcGjRqjMz4nbjFKECIJoHBmpg1f
         6ayw==
X-Gm-Message-State: AOJu0Yx0E6B/5SKT8CjnfUhpAvbTwxgAJa8rrpmwj7P/Wycv61uCfnpB
	2NR8tlUm2X6h7xrKJyNYjJohHpEMYLDMD0dpKO3xzejjYvgVCHeqVuIiQ17ekYlICprJtpKC+iU
	3tsCXGGo4nqqkT0oNKKMccwCy3jqcxmszIZOIQLmlfrsb4tMBUql2kqA=
X-Google-Smtp-Source: AGHT+IFTC8A+9hEt7RqENPGmESF4BArfjxZgImOootj4dlBZ6E9ooXerlBZs5ikrDIM7yCtjlrFLPbwmZ1sBogkQDbowaTqpaQLF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:3d2:5a0a:7227 with SMTP id
 e9e14a558f8ab-3d2cb48229dmr161464645ab.13.1740556562663; Tue, 25 Feb 2025
 23:56:02 -0800 (PST)
Date: Tue, 25 Feb 2025 23:56:02 -0800
In-Reply-To: <1D76F22E-39A3-4174-9ADE-E3FCA97182BA@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bec912.050a0220.38b081.0005.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in pcpu_alloc_noprof
From: syzbot <syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com
Tested-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com

Tested on:

commit:         42f41ed6 bcachefs: Fix deadlock
git tree:       https://github.com/alanskind/bcachefs
console output: https://syzkaller.appspot.com/x/log.txt?x=15e40ff8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9593a0a6d52aabe9
dashboard link: https://syzkaller.appspot.com/bug?extid=fe63f377148a6371a9db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

