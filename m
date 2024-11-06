Return-Path: <linux-kernel+bounces-398976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C99BF8C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72C91C219E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56981DFE13;
	Wed,  6 Nov 2024 22:00:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B920C48B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930404; cv=none; b=kJ1JieWNJBpZAk/rvex4F6Lu2tjSXvcKcio0LUMVV+uBfSCDu/bJ1tvdoyoT9QSDqEZHjy9N3M+xY90L/XH70bXS1ro4wuLUd3nbdn8Owb/CrtIi6oqUfCoVxT3FbvtGBXuM+zUHupSYrrxX3U1igvN0CbT4SFjSYIPMSk9+nGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930404; c=relaxed/simple;
	bh=nyCMCcUDfgZmYD3CT2Wfym7vQE4yvZlUvhVPdrMPbMw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FrR7fL4AXVYPj28HixR7YW3O31R7gT3tuVEmF3JrdZ+3JNb1ULOQ1C0OhybJRFgs13l14Trn8Izs8VqC+d1xWa2V7SYQUKVCPDih0y2uy6DFbDgwlPQSBJwnUlrD736tQgBz5ZMH+f6QR2p9tNsBmlUW9YqPNPonjOnY7/XPG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so3556475ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 14:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730930402; x=1731535202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ll395Y08osr8sXkNlWx7LdYdV3WVeC1GARy3OzH9sWY=;
        b=f9wWqwCdAIHiYCM7dhyNJJjSvHAJQFHWWpabPHmF0xtbCXS873rAfO0JByfmuaUQkJ
         Bp6J735tZ+DKIvAM1BRjwSTHMFSJ8VBEoRANgmfbDaewf9tbQhHxKrsY5OGQo+4EXZf9
         uwhyCOsQ4d9PLGUnQHLW9xsCcsZ76sjqjopPogfcCJnB256mlEbJOJPYv4YyPCPWxdlQ
         jJQlbMyxdFQBSwTSG0xk8qa5FikiafDhOufOXxzUtbdwlNEOCS7VWnHnAcn0HgINc9ix
         BPHomVoPS/zNzGf99Ww90Rp1s7gbbyAAv75VZi4uyLvutiLgEemLdnlJGGryU5lk8AYu
         +S1A==
X-Gm-Message-State: AOJu0YwENsw6vHHfZjLbQ2CTn6u6YxsABT+h3xXRfhJNEgbqFmlHEuI5
	OA51Rt6OCWlNDbYFjNoTWVxGv/r2jvQHNxvxk7CZH90dxQSOqfTyIA6xt4/12mKcPEZsN67X0Kp
	1bfiLb58jDhKfE6KIYOVxKIdPgkyJRIG2MsXMwKA+Pd79QxeggxRWZLA=
X-Google-Smtp-Source: AGHT+IEN1jG9cma8xviMDkM43taxeYrGXd8skPVxQUECKiqlObbGmOScVJ2FwnnfnybyT5zShZwEJ4yi0qJUa1tDv2xrhm2pgGch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3287:b0:3a6:c43d:1325 with SMTP id
 e9e14a558f8ab-3a6c43d1556mr162662535ab.8.1730930402236; Wed, 06 Nov 2024
 14:00:02 -0800 (PST)
Date: Wed, 06 Nov 2024 14:00:02 -0800
In-Reply-To: <CAN=OONwCrvagLau5FdcOWX=AkKkX4wz-xPGU05Jt-cYveA=g-w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672be6e2.050a0220.350062.027c.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_mark_sta_auth
From: syzbot <syzbot+542f74e8fc8361630178@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sarvesh20123@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+542f74e8fc8361630178@syzkaller.appspotmail.com
Tested-by: syzbot+542f74e8fc8361630178@syzkaller.appspotmail.com

Tested on:

commit:         26a2bebd Merge branch '100GbE' of git://git.kernel.org..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13a43d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae3eadd4ac1a645
dashboard link: https://syzkaller.appspot.com/bug?extid=542f74e8fc8361630178
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ff0d87980000

Note: testing is done by a robot and is best-effort only.

