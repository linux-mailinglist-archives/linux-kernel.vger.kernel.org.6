Return-Path: <linux-kernel+bounces-441295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0589ECC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B6028AC80
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C254A23FD30;
	Wed, 11 Dec 2024 12:43:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B3A23FD2E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920988; cv=none; b=SOHvg7RhZieqfgiiu7auT3NUsdQZYD1zjaWIFhsfiSVkI6P9D9GJ96KfmrOBw+qIUPEOLeQr1XmD8Yb28b7Rvq+MvgN7SEQnZe1G+63IxJnAg+QEz55ooZuID8TYbhKFuAw/QXl8450RF0Qt/bZbl7vz3I4NklE+yL0CLdEPLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920988; c=relaxed/simple;
	bh=sqtRPZsNWTWDlPIEGxrgjYqWFdMNBbprHYcE+zLlGdo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FbsdwWHGYk/bdawErr99ahCgEgDvEEGKXkyHBzknDD3UF6m3lda7rI25vMO3UAuSdM5+t81mhzoIIAMqQ5ljyK5FGogyIvFxJRyh/pgVLmgFGJ9CZzQYe8TEXloy3rnZtXbmFML8P+ZrHVsPzhx6h4t87hC5WwkT9/jxBYBUWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a817be161bso5703435ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733920985; x=1734525785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yS4brN7M5UJILtP3MfPsPHuCfolhJONCsCbiFPCvNDs=;
        b=VFHbKKfpUag7ZCQU1uvPvv1Z0QUcVflQj2tUAY7RSo4LFkx12s4REwjfJ7qpQQup3Q
         NMKmJqdXrDV+1R+7sw+RNoGC/fwvIcbDKy2iDmtjKr991nJGCxVPlIH17TD+uHm9FX/v
         YAIdvk0ojD/PqS7WnmTJUI4Uven7SBVHqtoJAcRhjh9Vmcx+AyCtZGv2oGlj0oeNRW1u
         N68pld5I8mj+YjD3lYlunm+6bqppLsjk8IG40EcxXwERhsU8T0yIG/5gwPyW5fcw/vqv
         i2evHt9nGKu/gJ56GnAod8XHwxPxg+NhS/m6C2XNtwGnu8xJHM1TNbABUPRvHHoOtEGu
         F+2g==
X-Forwarded-Encrypted: i=1; AJvYcCXDWTansVDI2dsBdjpNt2ULSOfvBzLao3Tlz5Cf3x5HtjjhuberUhHHTNnPrrtsEguEP2buKfpt7kX6vGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2c5U97v2rixIyC2PbMCV/lWdxxIZuXwx6Jcqt8r/DNCfHnjN
	6ImtuVyEnqBZGps62onWQ03ZWn4j+TXukrZnKR+s38w77W2lM1uLRVry3laF7oVCGC5m6LU1VTF
	SD39bW1yQrpJDxKXACHIBvBqJOxCytggIEpvlWmrYj2POiFDMBXS0Cg0=
X-Google-Smtp-Source: AGHT+IEnNiwI5Yer1www7xiZ1HWqZAEwixrGx2P4FCUjXi4s7SXW3L1xHrZ+Q5WTDiI767M+Aqry4hSNYUTnRzTWQIb9lKXg0yGI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d246:0:b0:3a9:d32c:d312 with SMTP id
 e9e14a558f8ab-3aa1cdfea9bmr21357475ab.9.1733920985456; Wed, 11 Dec 2024
 04:43:05 -0800 (PST)
Date: Wed, 11 Dec 2024 04:43:05 -0800
In-Reply-To: <20241211.203019.1906828475608694378.konishi.ryusuke@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675988d9.050a0220.1ac542.000c.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_btree_propagate (2)
From: syzbot <syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com
Tested-by: syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com

Tested on:

commit:         f92f4749 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135db3e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a0b1b189561bf60
dashboard link: https://syzkaller.appspot.com/bug?extid=b2b14916b77acf8626d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a5c20f980000

Note: testing is done by a robot and is best-effort only.

