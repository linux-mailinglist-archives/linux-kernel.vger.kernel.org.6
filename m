Return-Path: <linux-kernel+bounces-529015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEFFA41ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0858188C789
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94224EF6F;
	Mon, 24 Feb 2025 12:19:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64DC21930E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399544; cv=none; b=l2K13JrVn0/p0dezVdY8CZhUiWCA4fysMY71Rc5BF91lo1m9lnwg/S1goUE0Ear8T3cYrEYTJAjND030VMyzgwkEITytSrH1u/H34sTzWdB2Aw/3xvcevUzRS4ksteDg9gtPpYobSuduosd2XBJWIPnGg/LHkbgnUn0r9gBZ9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399544; c=relaxed/simple;
	bh=bA1YliEC7JWt29IiGwF9kVTTKGiLJATqU7DWsNHZPiw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nL6M0JQRCatwon6IxuNujvv/3D+y38cUAAFORBmMoIe54aYJTAqW/StYw4rJeS+3HzgcWc1HCGBZAgLaas4chKQ3KTnBUXYyCEd2mQYnmrX1z/dM/LymYk2X0YblXmtzznmxXpjzso4GmHy+E6L80cNfITXnyQfaDHA0/JAC3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b3882ff5so36048395ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399542; x=1741004342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4r6WmBx5yWSeSppN3kUnNSChy5sPeXVXjlXGrKQQPA=;
        b=kei34SHsw5Au+OdSTUl6kIqcQ7ZWUmk7pioT13CSATbY2iophqqtoMjlezZ26jpLbW
         PZ2lpOnXX9JfWH8oneBWvPWXnaSTEJY7OhZ3R9Rd6T+9JsCyJfz9IQeVH9Ym0XxIyprY
         ZUH1hrZEX4CiAMnNbiqZGsCCmX7Tl1cpXzX857QOhjWhX28DL/Acw70lMaVs9zyvuIk1
         sr6CQD3IX75OKIo08xj4kIvfWgM59IF34gzYzT89hn9MWmhOxaJxjgHfdEehW3BZ29aV
         ZiygDAsk/NaXSwryFH80s5YH++6m3RB64DhQsdlSejMYFKSvr9z8WuVhJK1lIXNUT+uP
         RANg==
X-Forwarded-Encrypted: i=1; AJvYcCUz44Ftg1vZz8riJIcm2oQiOrm6ZrJRyrsDCvabbypVecOnvokq8bicSYhQQrZtAB3LpgjgA6zTsCRvgG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLneuCTM+J9QOy3uoXlgWNB75nHrTIZLBQhiG42rfLWnAX44N
	ungYvb/57WKOi2pAylp5dDWFp8gP7G+eBx/tjoK5+muZMpYJnFEI7/0S3LXfKkhE5iQi17jU1bC
	Hz+uzbQog6d7Cbg/OQ3P3hguCnYNoaassUNNP9v0+lQ26ZIUU01pD1BI=
X-Google-Smtp-Source: AGHT+IE+MKwpftySpthmW3y4fbGBKGh/uy2r0pX1I/6v9QERjn1rmlYx7LkBE/iKLfDFH+YZN8Z/uTU9npaW+lEiM6GJgyUE0e3S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2c:b0:3d2:b154:49dc with SMTP id
 e9e14a558f8ab-3d2cae4d217mr111790235ab.5.1740399542090; Mon, 24 Feb 2025
 04:19:02 -0800 (PST)
Date: Mon, 24 Feb 2025 04:19:02 -0800
In-Reply-To: <tencent_B22DF56DC89700E9F2EF4ECDEC797E6F9C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bc63b6.050a0220.bbfd1.0085.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
From: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/hid/hid-steam.c:1143:17: error: 'return' with no value, in function returning non-void [-Werror=return-type]


Tested on:

commit:         c749f058 USB: core: Add eUSB2 descriptor and parsing i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=f429368eda610a89
dashboard link: https://syzkaller.appspot.com/bug?extid=0154da2d403396b2bd59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f137f8580000


