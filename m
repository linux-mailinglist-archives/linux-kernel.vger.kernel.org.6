Return-Path: <linux-kernel+bounces-258302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949A938604
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 21:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C05DB20BC0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C33816A95B;
	Sun, 21 Jul 2024 19:53:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00D5380F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721591584; cv=none; b=LiDsQYHzIvVi/hNxWnEdrkteJP0NYzOiVuAZl48RzsmTwAVGsDFwKq/O9/bMFzR6AH3Ot6PKFQlvHK9jSTVjpdGo/7tUCEHYXgXYzi8OYF6XnbxO7lths2lr6webGxZoRA9dykdsTXT8Fnrtrf8P11wLiFBINW778LEsb975jHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721591584; c=relaxed/simple;
	bh=aPAPOzY4J9ByhRZsMSsqZoKoRdMJrHrS7sAkHf2Njq8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=frWzwRxbda/K8ALC5fCjxRiQltA0FZzHIF3K5IFvT70I3469Aq0+f+qyaKDd/OxUtdv64ROXrIqY97I9N2zhpSJ+x2+NYFq86P5U0eJZ2D2pu3JOQenBiETAuoC/RS9stSUd0VqmnqvaKm5NLwGa9ZElPBxtuyKa6VXxoLiNamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39941f4c5a1so25095065ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 12:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721591583; x=1722196383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zh3f+hDr67SQlbapdV9/v3W5TrdHJRKvM71OlERYXCw=;
        b=h/qXr/Z7uc4ytja1JQDmPelomJW2FtHcm5ybqFdQIeV5iT38uvHdkcYsLljS8ulZvP
         5xek/CmvetDFhkO02GLzivp0uCIN1IhUVokm85Lf/vK7TqCigx5n+G7cxUI4YTdC1OVu
         xhUGeEQdek3uqrRDY8nUWuxKxcR6961d375fxdtVrhvZgEXoDVKWy4TI0/fUc9hRXtJt
         HNzuIVpSoiEVt09jXWwF0ECy2/YPJrjtzFCMJOMYBhWMCYzVAuOdGJ59meP3ESfmcK/c
         NO7+GefEX487wvL6UptGjxKhIcDb/7LHPvBbWZFnZU5+akQ4PwhV6mYprmujBpvQWxS1
         kueQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhKa7Lq3UK1vGinFiMpm6EPU8b/G60kBE3873LKh/+U/1nZfl7OcOTp77BlTl4SjLS8tVROTgULSBTTb6uyL5dV3KFEMx3bAHqNayM
X-Gm-Message-State: AOJu0YwyaBzNNq2ZZHCYg0vBedHP7MJldgfdUpw9AtD0LjQ7Pw2wQp1Z
	88pf8lzBw0z5f6ZP7VGZatYSfRVOaURag3hTisKz+pNuiVvCzneG++5IoO3hjDLFw9QxHxIuU20
	QBGUnXC8tF8j8lv/QNJdPZyKjjBWbLAgxU1BbsETRTh3E0G6YlNQEoKc=
X-Google-Smtp-Source: AGHT+IGjU+wxQkJzfG0CB+DbHDX/Xj13FcJilODw3nAP+XkVtIG+gY4iUbRRJ2tyjx9zDiN522q25Y4laGNXZPxJQ5EejKvRTzVV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:376:4736:8ff5 with SMTP id
 e9e14a558f8ab-398e17ad093mr3727125ab.0.1721591582759; Sun, 21 Jul 2024
 12:53:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 12:53:02 -0700
In-Reply-To: <20240721190930.45876-2-dennis.lamerice@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd31ae061dc74669@google.com>
Subject: Re: [syzbot] [btrfs?] KMSAN: uninit-value in iov_iter_alignment_iovec
From: syzbot <syzbot+f2a9c06bfaa027217ebb@syzkaller.appspotmail.com>
To: dennis.lamerice@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f2a9c06bfaa027217ebb@syzkaller.appspotmail.com
Tested-by: syzbot+f2a9c06bfaa027217ebb@syzkaller.appspotmail.com

Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161cde0d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c58162962f280fa
dashboard link: https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1138b445980000

Note: testing is done by a robot and is best-effort only.

