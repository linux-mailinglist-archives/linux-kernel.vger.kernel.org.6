Return-Path: <linux-kernel+bounces-427529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB89E0269
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE218165F20
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D71FECBB;
	Mon,  2 Dec 2024 12:47:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACEA95C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143653; cv=none; b=lekxZTrh6P+lOadCaItadUjWepUYdNm/bteAMQrGIH+iQTolBJR5jmz9u2zN+CuvgRAI9mudFpFVaPYDIvt5ozlOhAeQNC5xi2njgHLVSApJItF7UakZ3tWOQW7QXcH4yO4JyuBErQ2JA7mcNixAMPbiM3pdFkmEfFsYjaMZQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143653; c=relaxed/simple;
	bh=9P0r0zNtzk16/yn3eCLGd/0ueemYp1923g9x8YNPPMM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DE4j+W2nonIvloBp7/VZg2AG8Xke0kpPn9D6YihF+eGhlXOtjA4/h7GrdZN0BXDV/nyziLHeg5yHRqg/RN/q8/fgHXubYl9D1bTrCNcjKDzN3wg3fF9Nfi/90irgVkZk08P7gS0ki7dpOiLLm4BUVuo70fQ0ldo9hUW3u8zhsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8418612c3b5so348063539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733143651; x=1733748451;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M09ZTevdyJ7SCNEPvgTNBuDdXmgGLWhWSZRFEBkOlCs=;
        b=imvPSwhwox1nMXHMkO4oFtmy5C0yFG5aN6lmh+iiooz/k2+lI2GUgywhJdT86YMW1J
         QGGUlSb7W9Idte6A8V2VagqaxpU7AQZugBlGzLhtQaawf61VLNYJ+3RzK3pE+mrxTXqt
         Vb/SNPC5avtE6hobwBpWI45tXQWxMI+2NjSNJWK/I+MHTKS4Qz1PBsUIYJPSTjMHLdK/
         MFb38jsNjCTezPH5tzQS925P/gKzmC9vs+GydFEJjyoVTzaF3bufF3yTBqBjkwk5c05O
         KXr2Xcu9YA+yCGAb/tlGOWAYuJrD1sHLpK1KRa7H/6NyGrRSmgDSpSyGkb+R7o3x6G3D
         R0GA==
X-Forwarded-Encrypted: i=1; AJvYcCUYcl9HHWpgHchKCQag9+i0mjyeaCEitV0EgpnWJwxq6e5fI640yZa4sjdTJvoPvrM3pA10X9mcSi5egkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVufO+IdLtEB/vHdhEbbKQaf101XiNBjewskEGEa9awBpnu3T
	aHzCpXF9idgCr4AviU8cpvYjwQcinK8fGjyfwUVpbRq0+/I341l2L4KXgvwwCrSyzVKkWR7OAP+
	b4KdqXluUIivzU/xCtIX35yu9dtdP2xcDe/sKOqWiUGCLPYwGFscj/G8=
X-Google-Smtp-Source: AGHT+IEkKK2rk/vQaS4je5HYiSTlE7kNsErcMTVM+tErhOOyoKgeF2aOrCv//Y7CGBZOK6vkfjyUO6ygj6W6TQx9HlnFBu+UpDqM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1806:b0:3a7:8720:9e9e with SMTP id
 e9e14a558f8ab-3a7c552531bmr245731245ab.2.1733143651553; Mon, 02 Dec 2024
 04:47:31 -0800 (PST)
Date: Mon, 02 Dec 2024 04:47:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674dac63.050a0220.ad585.0050.GAE@google.com>
Subject: [syzbot] Monthly fbdev report (Dec 2024)
From: syzbot <syzbot+list22da73323ba5f509dc01@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fbdev maintainers/developers,

This is a 31-day syzbot report for the fbdev subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fbdev

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 276     Yes   KASAN: vmalloc-out-of-bounds Write in imageblit (4)
                  https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
<2> 7       No    KASAN: global-out-of-bounds Read in bit_putcs (3)
                  https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
<3> 2       No    KASAN: slab-out-of-bounds Read in fb_pad_unaligned_buffer (2)
                  https://syzkaller.appspot.com/bug?extid=6649e4a17d8ebca21a28

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

