Return-Path: <linux-kernel+bounces-412020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE989D0273
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F437B21D21
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6E2B9DD;
	Sun, 17 Nov 2024 08:14:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED32E403
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731831245; cv=none; b=tZ8vJNk/PmcX47VopSUkstlLDhpfKKR9nNHs1nseUvUb6RSjqyY9zemLHOlrAcJA93VakDvjApCPXHvVCYUSAyRZmW8JXlV6TR8glLDCyCQjxejBy8C4VqIUQSNUYf+mCQ2YccjDoBC6LH6IWyz+Ozs2zTKYXK7IbnxY7H0mmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731831245; c=relaxed/simple;
	bh=sITDq9pgxV0JGeUE+jutRHugAwm7EjJ+KKPhCIWr8/s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uCZugNq1c3m8Qr5trz+cXNC0mthaE+z+rRxVPNYwBzZmvDCVUwiwpfVzOIKMRGtKQRpyD0kIXvrkkzwxez2BEVWlPzIG5TUT+vh0tD4A5P9HlVLUTeyOnknp0+FfaiMFUtY0tBLHxxeax5e8F6ER5o4n4ck+OR/Sys/M6/dCP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b7974696so12642835ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731831243; x=1732436043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cAXStZgVrmvMzECPpPJcbsX24KNDbw/bMwbcFv7apo=;
        b=G7nrHO2r/stHiLRK9bZ1kkNvQ9YmPbWG8qh6pLfOggFIKp838UAQzYp2XjrRZEosUh
         QFG103/fJy1xKB7Cpb2rVbVYFo9OklCm2uglyBfzIYT0bF0uNMUqdx6R9MegCwBN+UJk
         X/JpHJYBFrPQGax52DoWpRY8Hxi8rC36Ai8RvKwkZ0yYvYxeLbQKaPaBVw0YEu5Y+3ZU
         ReoCh5PrPOZWDhdo7lVGvvaUlc82nL9BuCmjSQTxijYhB7vhZPdtsNCpfGMpwyGTcwKy
         kqjb7Vi/itJkmNp12j03bzGWGbIYGERJaaiSVWSv47KR1EaeUm1LPqoK5sOXSHiLFSsK
         73qg==
X-Forwarded-Encrypted: i=1; AJvYcCUUTyXVeEc/YzD+g2IJDbI8WD55kFYp5zTyca4KmhJNdeWMTkxbn8IQaQOSZlIt1KFOsysDRqspWEqD9pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bHbZ4PTZKSxgnDqToRhU4EgOk4igwwaciPSmSYs0teTjRteF
	aDOmNaq6Ak93oCAAmlhIWppQ/HWOkUfvIVkRxxUsShL2sz80TDP/9QPdoLunBbe0xgXxksfUdMa
	QUszLvORM5qEyneJHPeefuanaUOc1tUIoHd/zcFv3OfAeVPnzZ2XrvIg=
X-Google-Smtp-Source: AGHT+IFd1nbd3dh0Rhw8u+kcphrA3gBgDy9zioD/bdGdledmXplLVHrzifgX/GQ1F/B2kxhtseYyiN1YIX4ZI/wlZ3Q4qSUI0Xzz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:3a7:1891:c5f2 with SMTP id
 e9e14a558f8ab-3a7480031bemr85191805ab.1.1731831243214; Sun, 17 Nov 2024
 00:14:03 -0800 (PST)
Date: Sun, 17 Nov 2024 00:14:03 -0800
In-Reply-To: <672c2a44.050a0220.350062.0283.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739a5cb.050a0220.87769.0006.GAE@google.com>
Subject: Re: [syzbot] [block?] [usb?] WARNING: bad unlock balance in elevator_init_mq
From: syzbot <syzbot+a95fab8e491d4ac8cbe9@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13aa32c0580000
start commit:   c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=106a32c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17aa32c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=a95fab8e491d4ac8cbe9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1722ab40580000

Reported-by: syzbot+a95fab8e491d4ac8cbe9@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

