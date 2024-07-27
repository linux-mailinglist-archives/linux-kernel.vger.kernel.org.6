Return-Path: <linux-kernel+bounces-263945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED41193DCFD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335861C233A4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9C1FC4;
	Sat, 27 Jul 2024 01:53:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491510FA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722045184; cv=none; b=SjgNDqEAEt+2wIgdli6+MhufggaJUk/Zg8zUGQqwg5RYvN9S7KyvTdmTijlGqgu2thHpRik+vGqTr34uvrrC/vM33f78T+4JxFSkXpw33rovkOe2xRojfGwsulqBzA6Bv+etTOvVzd+I8rCAsvxJ4yTRvipmpOa4Y2EP9P1ayEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722045184; c=relaxed/simple;
	bh=g1X9NuD5YfdppjtdDRBipdoDtE2rl7UOBbpttqYJV+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fTaBPBymHk/NTtzWfmXk1obMkYao7l26ONuo48SRxn68eeCkEionzPLFvIoM1sZ/ljxyzVi2UYljk+cIMeO3Lit9YYztAMTpnC75MRINl5TZwcA2vHSlMfYlhf/dp5ZRRm8MqwGAtR/Dq3riRjKQSKimcEx4Qg37sbKk0WyGd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f86fc9fdaso259464239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722045182; x=1722649982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E797tWMRErOfnI7k/AeJPqLUGBRe5XXNS3CVj57mB6I=;
        b=t0+crMBKBBPYpWBlC9dJz/k9eJHqqFNbRYtb+Vto3tcmwYR8ODTk2jYpZhn0fCnszX
         4AKwJGeXtedYYv0hgCpfFixlbKPaM1LVi1uwSGN3wzgsIerMHe+JJ8gOgzvEOL76e3nC
         CqPDSjhW5D7Kjskuh3sYWovd6avuBQbR60QqXGk4XXSD1hAGO/U1Ohvbftb2chV30ajS
         ENH9sqhZ1NgcsuuglMIKXr/NvCYL7AiP7n4pElc5V2v7g08rpa9z1JxWMY9tkkIzgCYx
         CEn7lSIwFXchiudTkkAkM9ttC1SpzGvsHs2PfsCs+LL0LO1389OjaiFEDKanWVYy7+dy
         FRbA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+7RHLF6uhAhGtVDGqszDd1Fg+m7tmu0iuVHLXGTb4Lnz4Ng4PK165n2U68hCEwtW4te7oneUy/v1RuXzDeK5cAKOeK93byCp6tsb
X-Gm-Message-State: AOJu0YwcdDEj5gUpts1s0hREQToZP57G5Ti7HzHTrsJ/DR91JpKhJ9l5
	4o5bYWptm829P2sIbLaV5iPJvJ5Qbx+7lK3jyz1hFd/R/erlF7+CBxwsldQ15J5wAFcPDkNDBPP
	m3y29ZP1FCe2cjToPiKuMcoueYJW2NLE0838kngWjmoD4cUjPGkmcvgM=
X-Google-Smtp-Source: AGHT+IHI+hXmYfRaZeXqNxynhA/QSetk/BaUC29K24NEpjfjPjiljOOo3fowz7KE5bs3tooL4nCoFLoMhCTGUAONJ6rJeabs0gdV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:618b:b0:7f9:3fd9:ccf with SMTP id
 ca18e2360f4ac-81f95c0c509mr3355239f.2.1722045182351; Fri, 26 Jul 2024
 18:53:02 -0700 (PDT)
Date: Fri, 26 Jul 2024 18:53:02 -0700
In-Reply-To: <20240727011616.2144-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061a872061e30e33b@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
From: syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
Tested-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com

Tested on:

commit:         1722389b Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13c0ee03980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137dd2f9980000

Note: testing is done by a robot and is best-effort only.

