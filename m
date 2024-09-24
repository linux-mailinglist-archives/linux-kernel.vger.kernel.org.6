Return-Path: <linux-kernel+bounces-336643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99092983D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84701C22896
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F8823C3;
	Tue, 24 Sep 2024 06:55:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32281745
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160906; cv=none; b=rTjWSCP9Tp+e+8bYKO2DFovXVz4l6ejjzn/JgoxnpaWl5rQB9f87lQiWdQKWY14J97qJmldclwmrxleQ7DXAQAV5waU61e54xSSbMlHUbv5XXFS5uqX+Ku+wpz1Q76hSGVNHQR47FJkRpHj4wU8owRW18gpim2G4YVsO3E/IB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160906; c=relaxed/simple;
	bh=DXGpbj1ToJvfSYNwXGeIB9UHOP0jaudES3ZJSVFcrqY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qjyXyojGmf1NPleNqfV3732S5W9jLwdUpVxE9Mo1ozc99gZSCAqJv3MrnCMJG1uMkc9ie4Kan+jcMnvAKTqzl8gGLIsfu9mKl31aoapqqvo8Ivdt1OocXJr+heGS/IDFUdl48E7Q6fSNBfJpuziiRES/0Wjbgg4UO4aOrmMyOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1925177fdso34229295ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727160904; x=1727765704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKvHsFQknHqx+vatCkVKyyBXSb1uz2e39SOBMypDJQo=;
        b=HTfwl6f7brDXpr987ZnAyJu8VlTs4Pob02qGHqY8UTV7W8IbyJVfnjPE0F3w9MSSlJ
         oF0fdTh93zPBmPglGA6dbMU+Zr+JMeW6g2kiI66SR2LExv8tdZdPkZxlXhfLuNXBrK2A
         WOL7/2am+qF84N3/iti+GgT3zXZFwHcaKFK6RMNWoKjwfzcidmyHswNOkymZx4tH6t+V
         uUebSRyuDSU/v28qCPb8x11JgMRzXI3n24WdoflD/ya8xCR4eVFbkRoQtmzoKOeU6PTY
         D5uSsjvaakckpEQmnNJdsuFkN7/1kCQdTSdt27zw1zCCI5o9IC0hN7WoKHJ/Xd9sYlBI
         8V1g==
X-Forwarded-Encrypted: i=1; AJvYcCXhRTAkZn7PiOmyCileKrJt6JHkvUuaY+Zpj2CBAYkGj4+xWice5/Tgeohrk/+3XVCLzBMGambm/sJvrbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0qGePhWdQAy8MEUGwhFWIWEWXpOMWWPby+i+wZmYYiiK6m7v
	iHPHP8mRWfW1SsACFryJ47+KY2gbvhizH4ylQxlxrj+HDKhy1x0mNOkup939evGogJOZ8OS+eYA
	RNxOREup5EApldER2H+biaY/RO1i27cWVfBtP6JN+q1G78A4//1lrj5E=
X-Google-Smtp-Source: AGHT+IGKtjpCciSdXE5HJt/EM4Vx6pkc1TT0sO5zDA/SxUcwY0Mx8bEGvzebSjafPTkkgJm4T6WIAGn6ayk1y+dfullL8XESC5iI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170e:b0:3a0:926a:8d31 with SMTP id
 e9e14a558f8ab-3a0c8d091aemr105206855ab.16.1727160904099; Mon, 23 Sep 2024
 23:55:04 -0700 (PDT)
Date: Mon, 23 Sep 2024 23:55:04 -0700
In-Reply-To: <66eea5a2.050a0220.3195df.004b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f26248.050a0220.3eed3.0023.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in __copy_super
From: syzbot <syzbot+18a5c5e8a9c856944876@syzkaller.appspotmail.com>
To: bfoster@redhat.com, djahchankoike@gmail.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1057d107980000
start commit:   f8eb5bd9a818 mm: fix build on 32-bit targets without MAX_P..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1257d107980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1457d107980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74ffdb3b3fad1a43
dashboard link: https://syzkaller.appspot.com/bug?extid=18a5c5e8a9c856944876
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174cca27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a3619f980000

Reported-by: syzbot+18a5c5e8a9c856944876@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

