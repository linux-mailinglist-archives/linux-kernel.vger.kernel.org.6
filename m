Return-Path: <linux-kernel+bounces-524200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3B3A3E069
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AC6422F15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C237920C00C;
	Thu, 20 Feb 2025 16:20:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29F1FECD8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068404; cv=none; b=SgnhLUrIFtLwGV/l49oBSJCcI4IANnTPRwGwrRLDxvulOYPpfO6HGWnwHH1FI+L4PDvDbLR+YpWCO1IMEQbB04tnMiO8dgoSRMMUEeX7yz+q0JDpSwwUvqQAvoYaSXXPZZKH719xMRR7UakMjisTC50EuxnV00usxvmhwxexUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068404; c=relaxed/simple;
	bh=APzJKwyhb3OuH1pPBqJmkSn0GS/wNMS+wru7Yxj4RO8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ffj92GxdfFvbyDVW6JJYidJqjxWrJwCIhhOJ40WCMbtd3OuGduPNSy5YAS0rHCiTnowXtmo9dOCC+BHpZGYKooewvuBGtC2odTHeFijS8WXNXtXEdTACCKHW2x+qK+g+wIgVc5uIy8mqBykhER/snf7hMJEsf088MuD++mYJnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b6d933acso8375025ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068402; x=1740673202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7pYURb2UEyQVm3UDJSJZBqVAJmGORVXuCUKt2v1imU=;
        b=MuTjOSUSGgYBQ/Dj4VUwBy8dywIAynohRayv5l/GC0ahvZS7csY8h3VycSB69F2700
         /6fyJTpZ3UvrGnmUPbYVL9hKI/rtaviYdaO3z/CNG4ZrJjcAKT64l4tXgY/Iou0S6lub
         +zDpRHvLZmhjxjAbNVLnjA3ic+dcMaDGw7BPZhabMUoda/WiFXS55o1swPg63XHF4S9A
         EE8i2+cuUKr1697XwKT5nNKSwIbdVe/5MdOmlhuo7mbnCW5uoPHcd78/9TkvKUKqGqJB
         jnXylTKc+rJ83hylGDyKC2eI/a6wg9ZG9qhPm51A//P5H3bpviIe39qeII5IW9F81SXD
         v2jw==
X-Forwarded-Encrypted: i=1; AJvYcCVhsp/nF0vtGMAYhsUVkM6+FP4INKqX992y1JWl8gpT/KgKl+3GBH+It0nOeiB931OY8oLifgR8CuNSTI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89x7/PSSlHliJ2mIsvb60Vx1Awm8Zo5nqyLBIuupJvpHl/kJk
	j/wvF1/yWAjXED+YtbR4d9t1G5kHJW39ennZyzddOMa9Vc1rM4zLmLbFzMn+8rmM8oUliEBtb1K
	+dImA8f7mXGBfAFXRNkivKpRKZj7AyZyZAhTB5Ljb8AnrVPnOg16/HX8=
X-Google-Smtp-Source: AGHT+IGuEGXZgTpLDMgM/7S6GNTYnUn0UKrpL/T5rB0YUuM5iNtKYmjKbdIOL1xmpNOVQAHIaCIJ4uHlLv+tqDA4IfFw1W0JU8s5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:3d1:966c:fc8c with SMTP id
 e9e14a558f8ab-3d2809066demr217751225ab.17.1740068402061; Thu, 20 Feb 2025
 08:20:02 -0800 (PST)
Date: Thu, 20 Feb 2025 08:20:02 -0800
In-Reply-To: <000000000000d0021505f0522813@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b75632.050a0220.14d86d.02e4.GAE@google.com>
Subject: Re: [syzbot] [mm] [fs] possible deadlock in page_cache_ra_unbounded
From: syzbot <syzbot+47c7e14e1bd09234d0ad@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e867f8580000
start commit:   861deac3b092 Linux 6.7-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7
dashboard link: https://syzkaller.appspot.com/bug?extid=47c7e14e1bd09234d0ad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100b9595e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1415ff9ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

