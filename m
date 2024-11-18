Return-Path: <linux-kernel+bounces-412513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F849D09F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7AD8B213B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415714D29D;
	Mon, 18 Nov 2024 06:58:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B214AD02
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913085; cv=none; b=QU4k9bOLDHOG9x2TZ6CNe3szS1Ckjz+1FNr5YzKH+n81/MQfczbSRLbYY6y0l46X8bfxSVBtL0cEwoyxQSahacVMxqlhJNJLxwy3y9YsqUv9+Fu5CjTBlbsPTE0HceRCPUacIJURhrMbyNk0/U76WdFy7SXPAOzhyAAFTxLeOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913085; c=relaxed/simple;
	bh=xphumfc+8v+hZxlhemmR0uazoP3uH9uQvMf4ECWjmcU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YK3TY8WMuOTARkzIaRZSX1KqpsdxauyF2U44y4clwj2ZsjGOcIwwUrlBY3ClmfiC9b/mh9h51wKTWexohxKO00b2+QUzAiaCogI12Ob5iWn3KDVz6cFWOhsiVVpnh+vFiMxirr+M/7XpFB88ftpKAsumwqWjLEB9XCirVibhBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83dff8bc954so387591539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 22:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731913083; x=1732517883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTxLF36+Z28UFe0muHYp/+Q2EWoocHPS7WBe2Dr+vRg=;
        b=dpetodxXfKGyJFJ2o2dTNGOQ586Fxfqe3XtU7d4mlFtGY8TuFQeE8NzD21a0SDvjFK
         I5uT7W6V948PXqxZcbLKnTi1kWY4fM1e+vNMi8jzR5XwRAAE1rvn/E9xe4NZPKkGgnCu
         6ZUKOtkKwm6TtT5DjXHmtI6py6zeCdgCNwyAKSmzn2cOEaHV6DGa9dwBfkBgTLLpt/1y
         JzC+xStxvVZ6XEED03AXM1LabM/H1ps8zcKmOSoKfCsbxfdvzYJ63rh4S3fKODram9ke
         s+52k7dFEwPFluwt/clTUCatIB8m0PX3turBcEhAK7tK712H0izuyipGCvrjaI0JsjrB
         KZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFS519yi/mUtVSThkF6Ur8JJjNbom6XnJlqJfND24+WDJ8s3Ycu6piyG2K7U1tvNmeJb/AXQmwD/PSYb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6sBivKU3PO9wgx0oJdEFvx2onTORmWw0OXTBwlAuEKmvKP4G
	zqi9NXHwsa6sDk+yHO0hszH+VHdu2M0Jx+5+yHSG/jU4RrbwDlA5eWNqw7oWpmQh1nB4kZsOA4S
	KLnSHhZd5JfmJ8zO/9Jcww58UGzDnsxKPldRA/iS0TpymGIxdPk0vn/U=
X-Google-Smtp-Source: AGHT+IHykOYzKiqHu0/8fmHWY2+qsP6dgdXZ51ll9DidWZFeQmHKuBeoMcXUuokaEkqdT/NY2QQr+X8bO8wpwKvRARIGH55UQqAg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:3a7:66e0:a96b with SMTP id
 e9e14a558f8ab-3a766e0ad62mr22425045ab.7.1731913082968; Sun, 17 Nov 2024
 22:58:02 -0800 (PST)
Date: Sun, 17 Nov 2024 22:58:02 -0800
In-Reply-To: <0000000000000fc50405eb48a1be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ae57a.050a0220.87769.0025.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ni_fiemap
From: syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120c0ac0580000
start commit:   d537ae43f8a1 Merge tag 'gpio-fixes-for-v6.6-rc7' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
dashboard link: https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1056076d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17093269680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

