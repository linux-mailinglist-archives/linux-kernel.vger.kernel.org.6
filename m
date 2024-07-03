Return-Path: <linux-kernel+bounces-239337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F29925B12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56E61C20F45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5AF181CEC;
	Wed,  3 Jul 2024 10:54:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FE181BA6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004044; cv=none; b=OfguTypSZF1Q+9MxawuXmKA2DUbYV80QpyzTNgBlM5ziRgl3FeGPvuFFSY5t77vmcTB97LYqMFAbVuMfMwgvs6LYtMuNSaAs4Y7Fo/AFYPez0J4RIWG+QTvSuUMWoVB55HKP8PbjwlryiTXz1LxEIEH9Li5+4SPgfq5eED3uUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004044; c=relaxed/simple;
	bh=Naj/cUPG2ndqgbzqQJDsmcxziMwyUESt4XQZCadAC3o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PIpYhfbM2L1zsjHI/2udknqbPigmZNZ2YDhKRhiCWtHdE9GYbI6FworlV5p+BnPbwxapIZxQxjZU0oCBwAnOeiFVVJaqiUrT5zsrgml/PaxkjyvWQCmayDXsmNvg0rBNut+YZ4ANmJst3ryeLDpc50eO0671WG0yaP453iVgyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb01189491so581101139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004042; x=1720608842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYRFe9dL2+ykql17/2JEEiE0CmhFS1oOV4+xDTgvMZ8=;
        b=VAPSrK17JpT17kuKJPNDmrIDFXKUNLOyUBFI+iqqyPGsrYx129Bo3PhX+xC1WEGezw
         CvjsGF1CLn0ifj0YyCw0mz109/Lzs9iFbQpjZ0LueFgAMQp9g2HWVcLxep22NF/b+2YB
         26VVuvd7pYxX9+sXCeNEPLwRNkvwlPpKwZiAtwTMCbArml5nATCtBKICxZWK+w+DNesg
         bJjfyGKFfRFpIUt1wt+T9vaONIOKYiVtNA/mIohwX0+F4uazK34dHaXlrgf/KE70SxCg
         hWelUAslG7hfrKwHI4lsQbnYF1UWCWA/mIvB4Ua85UkgQjHDDQHN+AXKWenNlqDx6StT
         xgYg==
X-Forwarded-Encrypted: i=1; AJvYcCUm6oJEG4u3xqvg3s24EkZK7gThvb8ce9QTrOcxviE05ZVCkveeA5oKV2O3Rji59DQLxm2UPCLtsez4iQiMGBpKi6h2oz7QdpFXpXIO
X-Gm-Message-State: AOJu0Yx4TMwXpUEhDVckOUUrMw27nux08OLQxSOGvLy4thMtn6dXySBc
	SXgFe8EHpvJeLIvJHwvqbrL/1uxf3ZAW5T1CjCY/FUp2uRrdtdYSaHuasilJmQKLcPCK+ErKLvF
	s6W6ANEN9ydq/DeXRV9Gv+2K+IizBz4EzLvu2+M9ignx8zqVAo3A9k4A=
X-Google-Smtp-Source: AGHT+IFgzYR9oFHrJXjGsCo1/UWzNkDEs+GEYbtl7qRFlUFWsYq0YC4ATMAhDvcJpJOSBMXZ+eG66NYB7nqrKEPw7LaaBhDrA0bk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9806:b0:4b9:6637:4913 with SMTP id
 8926c6da1cb9f-4bbb6e52facmr698222173.3.1720004042361; Wed, 03 Jul 2024
 03:54:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 03:54:02 -0700
In-Reply-To: <20240703102633.2821-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f51ec8061c55a5d5@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in touch_wq_lockdep_map
From: syzbot <syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com

Tested on:

commit:         73461051 Merge tag 'erofs-for-6.10-rc7-fixes' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1627f269980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de2d4dc103148cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=91dbdfecdd3287734d8e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1323109e980000

Note: testing is done by a robot and is best-effort only.

