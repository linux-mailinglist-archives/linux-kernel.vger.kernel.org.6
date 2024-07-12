Return-Path: <linux-kernel+bounces-250986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2692FF34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8BF3B25644
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E49178CF1;
	Fri, 12 Jul 2024 17:10:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04C1EA85
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804205; cv=none; b=Svx9lQ11buDs5skXvXooJV1w+sYINEarS97hUubNi9GLYR5jvPgMIkXOxrJjDMOACReOGDAxZinSM/wXBiKpOsHd8LkVi/8wKL5wJ82Sjkx5CjzGNW7bS9JptO1sV2aWt3v1BEb4y7ulPk2qZZARK8OhhGtTFgA0c0AidX5YQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804205; c=relaxed/simple;
	bh=16jfph0RZCWtvIyndElAe3dvIat1XCr05PdV7AU7tV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sg0mF0FxPq+Nk3e4iCrGeyzxfhtWo5oa9KKl+lq+I7DpHn25AWmK1wK3eNtg09G33Lmkwb2bi0DkM/2gjWhO+e1sZW4hs+zD5ZWgBWJ2xaCTJVN6p0B/VZXDapTu9HwWddXyECo+wgD6jZQwhRlGrg36r8dBf35rroaMF1FF4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-804888d4610so233138939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804203; x=1721409003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMTg6foxnmww8UGT4+LezD+QiVNDfhqGjXbeHbYDlWQ=;
        b=WDOLdqUBm+pZIIi5ycBD6ap8vgZjVwbjkXOiJybsS/BQUOcdW2EJM8/kSwTFepnhIg
         uzdboK8CCMfC+qU4aWVTbsYlR5F7BoJpMMgWaaYuj+CB2u0TJ1DD4+xaQIuR9t7Brj3p
         skiXsoxj/xLzhlg93QN/Zs7GZbps0LPacXMk4XXdlvQBgI4Kds6YM4ocs/To1MXskWPx
         5I3m6xGz+XLnXL7ewxXRK8iB0YRO7TT5rJL0UX/rmgiiTfpigTV54pcmCEku4AOOQWyE
         yOb0nkvRNLvMqLiTA/DFYedQDJpRCC+ts9G7aughMg+Bed6Kkd3OIAHJBwB2p8/3ty5W
         v9qw==
X-Forwarded-Encrypted: i=1; AJvYcCVOV/V8WW72+//wyJ2oF/OvjQ8Eh5OUHWNgUm5D8ZFWXJrqvmB59JvpBYw2sosOTyJ8NSbHpsqxGK6OV+FmC43ow1qm+1PdxISsXbbG
X-Gm-Message-State: AOJu0YzCQbDQjKmcbxirH8r6xXZ0mEvOlYrf3cxe15phPu4i1iB/BE/b
	DydvQIm26Ku5o98qD7s5o7Xq0V6HR4AbNEfu0otnIdBT5GrsaG8aXFuoHiK1fisziZxLDjehy2A
	A0LFN0xH+Zh+dbqKEJ3V3zFlEUqf7ZsVE1+Isp7aDnj5pXn4Gp1MtZ8A=
X-Google-Smtp-Source: AGHT+IEJZjuf2gYy+pY3NG98U4qzYz9im6X+ZVcZFK4JUGIwyXYeq3SI6ARl39NV5HXFsilDRS+qHnJ5t/xjG8gxi5VZZXF3EzeB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:b0:38b:462b:8dd with SMTP id
 e9e14a558f8ab-38e62268c4bmr2588145ab.3.1720804202911; Fri, 12 Jul 2024
 10:10:02 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:10:02 -0700
In-Reply-To: <0000000000001e3b8505e9f95e3d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e26e7061d0ff386@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_read_folio
From: syzbot <syzbot+8ef76b0b1f86c382ad37@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	brauner@kernel.org, david@fromorbit.com, linkinjeon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7ffa8f3d30236e0ab897c30bdb01224ff1fe1c89
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Jan 15 07:20:25 2024 +0000

    fs: Remove NTFS classic

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bc0ea5980000
start commit:   2a6526c4f389 Merge tag 'linux_kselftest-kunit-fixes-6.8-rc..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0b9993d7d6d1990
dashboard link: https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117f19fde80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ceb0cbe80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Remove NTFS classic

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

