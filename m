Return-Path: <linux-kernel+bounces-239866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18D4926637
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102481C22919
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2671822CA;
	Wed,  3 Jul 2024 16:35:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE62282E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024505; cv=none; b=jmhtF46IVelGtJWQKnxf2JH62hWnemnyyQMEzE+fCf/ZseCzNLfuq5OOghfmeV9BkOa3foLoZwFCdUrRFuBlgucVqoerZMLQFg77esvPxcccTaoy6NMqyY50DzZcwfjZndQnAlsU5iaBGmj27UkF5zF1MB6P+i8e0+34+DV6ip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024505; c=relaxed/simple;
	bh=RI9DYKu0WW1C1pqK0a4fBEw4ONiX24bqZwgmNzFG4bc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IPICtM8vFkdiCfzeiYeM28MrWwDWcvNDqTzyr6Va41avR7EwTGl7mWtaVOTjFNLohtkUY376JNF5CMftPuC2rPOiudje9TlyXwJQDJ007bhTppOzOYL9P/3RpJxDLLShPzLDYR2+j4MxP7fxOXQN1oFwZxtEulBTtUE9auqlAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37623e47362so59436435ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024503; x=1720629303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTLj3Ze9F+5U+jABUgXbcdjSflxf/7EknWUvcqcZGzY=;
        b=UZTQm55Y6HKGsnv1F+oR6y8YOcKAM6SKr2NPbK6vtOAhsXiNHjOaUMTSQY4zgLEsdZ
         XzgGtm7IQGcDi8oMqwH7+IXVjTrdwmEixF4p3QSVtVD2bdGbydsbJvEB/NBAcW+EW4EJ
         Nxm2b4JCafLayxhYFdFTY2NIdI+1bm/DmIyctIRnB7XrocMaDkDDMvCCTURBuGgdY744
         Y/Oigxu7TCWZiFWiEWfo7VA0mUkT0rEpcjKG+EI0v/7+68n+rGa1/9KY1dIlUIvvEksg
         90+D8X14dP5Bn0/48FilP4oszy4H5bW+6V08GgNXImJdduaUc/NMLkyrdKKDBmcHl379
         uSdw==
X-Forwarded-Encrypted: i=1; AJvYcCXoz25KtWrydKI5gviXBkb5LfIZgf3VbS+vpcYY3rEl8lkV2ZJeDKDUG/u8arHFo2Ee4AbPyn2ib73l4wQj+7GrmgCMuqmkO2kVPR+k
X-Gm-Message-State: AOJu0YxWd2jT1gCvkrOIaJGqI3KYkhKwC/ue+kkyd2mxcXyB1lDXeh12
	ZYbaSMh9vGzgBI53qhIWpsmRiusX8B5dDh19N6V+cDyhURBsIM074p1cYKGsIWW2X/xEUKbdvWH
	KQeDwugsQY92dyBvTS/mBk1H/p8IzTrhIG+X/622RD8Sv63qdu13X8TE=
X-Google-Smtp-Source: AGHT+IGHAOihxU5uOBrIMA8bcHwiGoaXfReNWmiiEwiKoWuwTkFQwcnPLUAUplJcY+nHewgGCLw1RaRDI/UjkztL1tbOEkeK/BrW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:37a:653b:3ba6 with SMTP id
 e9e14a558f8ab-37cd358d008mr10827885ab.5.1720024502892; Wed, 03 Jul 2024
 09:35:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 09:35:02 -0700
In-Reply-To: <20240703155153.83500-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000800cd1061c5a6914@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
From: syzbot <syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com

Tested on:

commit:         e9d22f7a Merge tag 'linux_kselftest-fixes-6.10-rc7' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14125485980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1489b399980000

Note: testing is done by a robot and is best-effort only.

