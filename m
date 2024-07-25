Return-Path: <linux-kernel+bounces-262267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19193C343
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EC41F228A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A1198A1D;
	Thu, 25 Jul 2024 13:47:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381391DA4D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915225; cv=none; b=eOYvY3FdzCnNMYg6sBp0Kpsddrz2Z84KFdW/ka/KhqsaUz5gYHV35QXoIjzSiNq9t4R9v9prY7YhUC1dkOQSKpH9GHRrfeA4/GQT6igX0rtZWEuNPPazvrG0Y0UOIhasA2ImjBWheM4CT7q+uNgXP21XRAxT5sZLeJomWKlXU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915225; c=relaxed/simple;
	bh=6lhdpxEv1dbuBcxLgSuZikoYhDXPrBvzkFTP5pxuDGY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nhxGwubhyZgoWbsj8jLm4ppQPkqU66A5fGEbaTY6fah2baEbwo4gYFdTEgQuHy86mM0byds848SRtZ4kqT116Jodbqi1hGU4WJNw2Ag7/4ugxNpklyjRE7bY1PcaZFuBL6MYEsjbExeFk+VdkP9oWijWzFzfobq/r+DSAiK/yK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a16e61586so8416995ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915223; x=1722520023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRB44E2FRoRsJg3xXm/Ek83inkpMoY+QcSWe8Z4/FyM=;
        b=GXpRlbLTIMHvFkHgKantdzAmzHQv/QMnbFheCljC2uXfdrkajYd0uT2NDtJCDgB3UD
         /SfnJQp6gJXaD/2/1rhTEyhnDuoJ5ipxFvivwMRVsnPWxrfk4Z0Dq+yyGZaAyySru8tJ
         /f0n2/+X7oSmOMq2bubcT+6hvuJxwONiinC/lzg9m/RHv5POJ9nkbApbNdCeJNTIQL7o
         Stzof/RWbB2e4cGHG/6RhTgAyM+Li3iyKoTqgP8eFpon6CsPDkWomDfJ77GMs6HE19lK
         s8BNpz0Snk55ZalwY5Z6F1NWCsC8C5em9oyF1jtA1bg9aM5EXVS2hEe0SeGV68A7e8jq
         Pubw==
X-Gm-Message-State: AOJu0YxlcPHm3ujA+Me3heHslh2rlAiEMKLylqDomra3LrbkqlrRftPL
	JvxJb8SdjeGei+leV2NJ4C8MDKy9yeBl6J7oYhDX635tg2ijKueJuEagALCB/jrzmR3LK8JDGvw
	XDesEBmZmeXd2pXsbKbovJdQrZ20b6wDrn8k7fOs+LBRpHtg7pF3QA6A=
X-Google-Smtp-Source: AGHT+IGGF4HCh9W7h4GtLdhUIYh9Okoa+3xH9w5BUTmatluNWJYMOSOiOkHc+zN9gPD5oyT+D2um4AnuVxLkcCx9jEzT4ls0szWY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3015:b0:4c0:9a3e:c259 with SMTP id
 8926c6da1cb9f-4c29c211258mr89928173.5.1721915223349; Thu, 25 Jul 2024
 06:47:03 -0700 (PDT)
Date: Thu, 25 Jul 2024 06:47:03 -0700
In-Reply-To: <20240725131923.3802594-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038afd8061e12a12c@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Tested-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com

Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d0409d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a90075980000

Note: testing is done by a robot and is best-effort only.

