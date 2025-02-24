Return-Path: <linux-kernel+bounces-529520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D61A4274B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAE2188D585
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B5D24EF8E;
	Mon, 24 Feb 2025 16:01:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F8225791
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412864; cv=none; b=YRNLKS1poUCUB/6cVCT/effPV325YLDTqsULOah6ESFTaPutbUP3fYzzQuzdTZj3Skoz0/9TIXjpLmUOZYdCWlqc48A9IsOjdIE/FcxH19/zTlc4LwiKRLmiMkPZpZMa8po3wvRpgJ2hhq1MAjddfQvSPFl4bqsXnNO7OYDJA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412864; c=relaxed/simple;
	bh=fy5tVQmPbhL2LY9mlWT6KFg28mywCK2bhxmL6ddb+Jw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i+PxSbq/n6FYD7ptYe7iXGTUxWxcxDDRw6No0QmFNRiB771KSAemYlDe56GDmG591SlF35omie4ALohK7loiCe/X+HzCTtsqHi+EqWScvWz3gamqWK3RmyM1xnsuxNsPr493ilsfUiGWOTt/d6sDNHB+Eu2VeqQWrxgtCoV/2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso100936395ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412862; x=1741017662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7C5hi6Pumke7nqjLe3IXccpWOPKIjmSn5BY7ONyBLI=;
        b=bAlRAmwEygeVTFfIH1FtfWRwebgGN+x+jaLz5D13CI5Z0wcUwTe3K6XKawp7m2BRmD
         OZs5+tLEb/xLD/xSl39Ylr+YQsMqHlTluBmt2TnL4uS/r+1Cvsv/qo7+w81GYd2ptC6I
         /K/fKWpDkZvRxm76adkdxoqODJpmbRT2J6sz1nd8/+Wt6ys17YgCV6x5zGE3H1roUh+g
         txrrAAkgW43/d3X1WOfDoSWpNW9pvJvKD3aRxuaQiEONjJtZ4BRO/YJa8PbBpJDFCCi/
         tO6JVZRmjEVn5v5Kc1GJKAAONqT0Vd7g9nIqzUPsS+7PfSGd3TbVd1B0reNmwVKbDe9s
         RFUg==
X-Gm-Message-State: AOJu0Yx/Yi72oVAgymUPtse8RYkEhYpoK/7CsIhBKdJJXwu7Zi3sA77y
	4X2umg76q8l1aaZ9u5Q+r2tTiSJjZ5HAc4ASyMGz+Ko60Zz7e1FCzxFiKhdaG8adqSkfjWerKOp
	9aGjxNUeGizdNARkbwEDdf/6/CEWbqg4Le3+6lKDQDi0ZkgACG3JXOx4=
X-Google-Smtp-Source: AGHT+IGJb7ZIj41DZShWiiSTej6GVkYipWihEWP168s7r3V4NuQi90X1IGSrPuCVt5PEBB5ZufMGNzQhZbKh67HAMprQNia3bb0C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ca:b0:3d2:ae4f:fa12 with SMTP id
 e9e14a558f8ab-3d2caf01848mr110212425ab.15.1740412862397; Mon, 24 Feb 2025
 08:01:02 -0800 (PST)
Date: Mon, 24 Feb 2025 08:01:02 -0800
In-Reply-To: <20250224153035.1219984-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bc97be.050a0220.bbfd1.008c.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb (2)
From: syzbot <syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com
Tested-by: syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com

Tested on:

commit:         d082ecbc Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105cadb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef2f2584b422a21
dashboard link: https://syzkaller.appspot.com/bug?extid=d693c07c6f647e0388d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165b3fdf980000

Note: testing is done by a robot and is best-effort only.

