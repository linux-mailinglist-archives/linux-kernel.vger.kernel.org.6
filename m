Return-Path: <linux-kernel+bounces-343631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FAE989D86
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9332EB241D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F4186E4A;
	Mon, 30 Sep 2024 09:01:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFB7DA68
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686865; cv=none; b=E90o3HRsaLsShcdurLSeccI8U+r+ikZNXtExB51WX662DDmvM5hCymVpUkC5Vsmh3gFwznXsUcTYMr77c79TUTwPizAZ89rR5/a+dObZnLvwnhKfQYIbYEluvTsuxmhIs2TXBgsWuZYkBXo8PcnpGqCIvCmsvk3xIVJZAr1Haow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686865; c=relaxed/simple;
	bh=5Ak0nl1oh1TVATFd3rbp+OB6ZSkwyGA4360acYDknt4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YsB9LCgepzz7UwdxFxtxYhtO4b9a6g7YPvvyR7ZSGcxpR7NlnIZ0rC6Zv39Y+AkTrDroCcPxyVVD9+4y/H6+GBcbfbtUC4A/nXS0ZPxfpI5PKxYQCo3GWD1ybFBxoi29Bm5tYgfiRMK1xsuLU7AgYfa0qSJymgEdhiRYMMdyKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ad9fca5fcso378518239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686863; x=1728291663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgcA2yLZcM4QLraGvCK4shGLtxy0kO6PZj5funVyOR0=;
        b=QODFNSUDk3VozmaJD9fSJ1SBUZGl7eqARbQAh8ekA43xkbcmV+S4yd3wfu59ach81O
         chMd6OXhWL/SlNO95NrieMikc0wypXbhdPvN67jZSWHIF9c4/Jqmjrb2MM21QJkUOmJ2
         jyGaG/L4TnS2J67+CTmC+1OcJuZzSIqkc8CRyCTRSyZKnLWZ9JRrKl7N7q/K+kuINWlo
         bYblVEULhPrXhloZpUrHEoKr/Ctwh+BbXWCXRnxNw9lKFVJoOjpsxW/XTCIjHXJJeScf
         8oOuXqG5YICPZ5uScXZbFhUqZv/q1QUPoO2Ks/yHU+T4xFGkJZJ/6swwZ/D2ZKOAZgUK
         AvFg==
X-Gm-Message-State: AOJu0YyDgb5BvCPp4K3ZeQGzjr5jxRJ45+VLJyqsuZyZD+X7DDIbA853
	hbtqEgqmHs5fk+bPyOZW45ESYmtqYawsbw83nT8jicNpgrO725STdIQo+ZcoUx8JqqrbAALQgfk
	2w9sTuqLTTljhlvCugnCXBSlGROuIQDpNmU5vzRzrn5h0JgCAH8f7WjY=
X-Google-Smtp-Source: AGHT+IHZ+biGjIAG6C6BY56/iTKYJLqTWat+LR2OKgPQP/PPkO6z5MDLoeT0uAFu2kIV+8qaW+craq89QadKHRazWp8iev6GGQG0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e09:b0:3a1:a163:ba58 with SMTP id
 e9e14a558f8ab-3a3452d502amr75487135ab.26.1727686863000; Mon, 30 Sep 2024
 02:01:03 -0700 (PDT)
Date: Mon, 30 Sep 2024 02:01:02 -0700
In-Reply-To: <a41b0dee-23b9-4687-a0cf-7409e030774c@studenti.polito.it>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa68ce.050a0220.6bad9.0035.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, s323713@studenti.polito.it, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Tested-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com

Tested on:

commit:         9852d85e Linux 6.12-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13636980580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=daa10535be443909
dashboard link: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15674ea9980000

Note: testing is done by a robot and is best-effort only.

