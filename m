Return-Path: <linux-kernel+bounces-291506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA095636A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24ECB2178E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA114BF8F;
	Mon, 19 Aug 2024 05:59:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD25171CD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724047144; cv=none; b=ksk2xbxoQbp9O/tmks2eaALWBgIXF//ugtCDHYn3twEASLtUZ6cAhiYV1DNgQSqDEPhCQuayOimEn88XxtQubG5J/vuY7JzsGXEmwL/ndbuq+50Xb5hgEzNYyVfTRk9ECDbnXZWxxSDIHcJWAxriHtAgXlcKkUscr4iEWwrD0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724047144; c=relaxed/simple;
	bh=CZUeEEOT33maLDJlnJDGGVAN1gTvvr0kIxtO/VI/OpM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qPYqFRfgWO2/Yhnm1wMjh+J7xyalDYQNNnYrAm/+zHoiBfv7+aCFpE/fEZaqxsvVPWOOcSRwqRA2q5J1COMyiSOMC4/eZ87ZBJV6SYjyEl+zsSxip5pTw+DFkjvkTEhVDqwYUDmLX9OFfnkdTgkGIL3LKfXQCbjJ9AAVJ5oPLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d5101012eso2966145ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 22:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724047142; x=1724651942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfrjSS3tqL9BUzjb5MzW8xQNQsebzmaRdWr/ibRthdw=;
        b=MmohTzcmH2PpNXxpvvD+9jcHhWFRW7maR4Kbfs3VfKAIaSs4exTc5TRtp16EZy3qHi
         z2o0q0M4bQ32uRSQ/H5FxlA9cjLT03oJ1/G7EGWLY7oXSaW/5gXz2K2GsJt0pyugWggu
         6YqYawwyZKEJMQ3MAs/MX4VV8q/5LU/0FQRgb0kRYfKvmfHg+rFssz/xFeEbj7kQ6RWp
         DlbpeTj5fJoXQRsKMIOow6P+MT2HQsThp+V7efb8OeebTlnJDuZlZCHCHRl657CjqXwU
         D8wzdKgA8eCHgCzN9lepI5AmvkvWoaLXlnCIysm0sYHh2ZkZpvxwQLHfPcNdZ3/yg8AW
         Sibg==
X-Gm-Message-State: AOJu0YzAEKIGQWAEF47kCqWGS60nl8Hy+NfassezNwrrG/BB3YX9qmU9
	3KtBeCyzTdBm6mjJy/7dCSE7/gKQA5/LfFSpM95mg1sTRA/8fYBWffT9MiaMO9S6AfaCytieGoZ
	7+lAnbypd8jNNZ8os2bhg8FLY5GxrfJOSbTW0QCY+zSS1Wt0Iv5pgEtA=
X-Google-Smtp-Source: AGHT+IGWPwJSsqnS2XJbGF+Y7mUZQmCONQxO+/FF+8IDHTaJT6YD0IqUaTDHxNXmjhckfktsNy5LW/WABs5+XPs314vXao94eKup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:398:8d01:9c4c with SMTP id
 e9e14a558f8ab-39d26d95803mr4705725ab.6.1724047142093; Sun, 18 Aug 2024
 22:59:02 -0700 (PDT)
Date: Sun, 18 Aug 2024 22:59:02 -0700
In-Reply-To: <20240819053738.3694059-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b1530062003017f@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Write in bch2_dev_journal_init
From: syzbot <syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com
Tested-by: syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com

Tested on:

commit:         c3f2d783 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=139eeafd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=47ecc948aadfb2ab3efc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1786ffd9980000

Note: testing is done by a robot and is best-effort only.

