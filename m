Return-Path: <linux-kernel+bounces-290457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E8495540D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4875B284020
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52C645;
	Sat, 17 Aug 2024 00:08:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2D391
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853287; cv=none; b=dzzvqK3Li7kRCDhGLvIkATVkkAYy1DuyCt7G+uacFT9MrqUDZpLvtqD5Y+wXqB/l1MD49fG1lL2A3v2bUXDHgAouSQ8ywxFVjIJlslcV/7Q8wQpo33eOvSxi+g4AGLAgrJ5ZxRmQuXbBlD2/lUzDqzP0U5MJFF3TozbJYtflcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853287; c=relaxed/simple;
	bh=8cqZKJkH404Adiz24foqLGVKFP5OXxPIMKKRlsAWz/0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ip3EoaRHCn1w5VXQqkVLEUgXsVQi5B/qFYy+PvZ9ncm865q9dKGv6YQKDjYr4j4WL5r6uJ6QnF00wQ3JbFl8FcEPRhPOo8L9EhW0KasqidhyEjx/TdoZ4M2l/M+R8wlSjFPD21GuXicq80nKoGgKIwJtUN+Gj65lfTQHlKymMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d244820edso20568745ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853285; x=1724458085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8+h+UYhIgx6SA9dj67GwMpfszzUP7FwDAYj8kWtHvE=;
        b=Rn542mIysPLJZTjCeMaSZdh/cHF8/wKMbyvg9+MziaDafHe/q1I4Ypiw/janKLGnS4
         PmN6lRRGg2j43DoeSXrZVMb8ZLTwmPXiFLQpOuntbuAXyYyLvqPHGleVcbs4H8ak3GiH
         AlxFpAmQ1lUTsmJS/cKVMbF0PZe8p33HKRgphEaelzRB3qxf5e26gGZH0XLUPentXMT7
         LHqgrCp5YvAvqUpqEJlGOpxVeSBvv4Pqjc3NWm4bsHBkU4WwV2mtTbzFY1wVG+XtrqgT
         eX5uM7Q8BsdXaObLAk08KDTB8TLKNllwQ/bFzeqY+Px3EfFYo4NvOC6nWW+O0WevcQEL
         hSnA==
X-Forwarded-Encrypted: i=1; AJvYcCX0kh9oUdyUTBfJnR12ca6Mh6Qw07kUc28rTashbYhaLCrDhN331KnI2nuqQj43ec5nWbHz8qtYvWxBqCrMPAaDMCjwOHC9Ek17+tfA
X-Gm-Message-State: AOJu0Yzoxr7IyQVpNVHfb0EhiclkVArGjIpiUmA1KjNU6bp7r2/AeRlI
	Mk7MrOPq6xduznwUm4hQrj8LX3zZDT5nmwChfz9x0PzptqOTM1B/uk0ajSY8ehFVg01fhTTjeXb
	enD64VjHmSJvwsyCbmqYpZ976svOsJwck75BK8B4ZCTBJhE8liAu+XIA=
X-Google-Smtp-Source: AGHT+IE4e/l8ryHrMJHbK42ym5lVt+Ue8iZ5+aOCXbtbdZsNfLBaLvJ+NnXDWMXIWC5jTOID/up/26bmXmsuhbcipqOIFdkBmzIc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1989:b0:39b:2133:8ee5 with SMTP id
 e9e14a558f8ab-39d26ce2d21mr3786475ab.1.1723853284994; Fri, 16 Aug 2024
 17:08:04 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:08:04 -0700
In-Reply-To: <00000000000012a63d061fccab65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b28361061fd5de24@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in dbFreeBits
From: syzbot <syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, eadavis@qq.com, 
	jfs-discussion@lists.sourceforge.net, kristian@klausen.dk, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
Author: Kristian Klausen <kristian@klausen.dk>
Date:   Fri Jun 18 11:51:57 2021 +0000

    loop: Fix missing discard support when using LOOP_CONFIGURE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f44605980000
start commit:   d7a5aa4b3c00 Merge tag 'perf-tools-fixes-for-v6.11-2024-08..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f44605980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f44605980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=3c010e21296f33a5dc16
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139469f5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100f7713980000

Reported-by: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

