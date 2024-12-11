Return-Path: <linux-kernel+bounces-441603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B49ED098
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D91662E8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19F1D798E;
	Wed, 11 Dec 2024 15:59:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF198246353
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932745; cv=none; b=Pb0ITB35tymwpFITNdD8J00CmuwXE7Rrk5Pjmu5mHhfj7c5aWPcEND7vYbTN1WspNK4KAEkyksEd5LH77eV/zA6VCjCiSZQnc4Eb8Zvcb10EE/bMZmLiMJHdfENo4dLHQUYhgEGzkwgaYp/Jwf71MgotcwW+iz7Nf+Z/MQ1YSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932745; c=relaxed/simple;
	bh=0/Vw5d5yOtudfwTIu9urOUrFiXLWivKI9DLs+LdBcPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=diJAZ/OJK3sSxJ3FJvhnN5aS5fvFDfYKCI2GpsVEmLH4SgK2C+BQxVT0kyEyjXt7YTdMgIZKnYLmLuxkO6eotwxBezOt4AIpfkJSZuaMT/9Xm2j9C0K8EEVcZCUxAVb42svdZXeOwEKWPlL0Y3Rcb8VPld+KLc0kPtYjzB9nhxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so75724875ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932743; x=1734537543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj6T53eA5aQ2odejJoDohrPW2sAzNQlf1f+jwWd2Ack=;
        b=f5QSlcmdRupkSnKHkwrT0Sffvwgl6ZPOaP8nVieE7SA9Eky915BVypd88QVyciJyZ1
         PWPaT6azLSFVGwh7VXePcMjdCVCalrbGC2Sq1N9MPqi7H968DLuc5Z2JA3DCwl6hNXn7
         pktsLfLKXfLM9OAZyKH3kpjUryXNIguEXQ7ERzFZaEwvkAaa3HVL6xNcnSAuZ9Ej44sO
         pDwi4qFEZI7JEmXITkAqeDK0vYqzph/FAm0fHftc/CRBNWjfYkCN8omKeobATr5iblfM
         JYbB3dhlrOd5eKuy3s+1qZSeZVklVM8HOGCQAYLQ1Rp/+mEwF4rN62lfEbH/4gN2SVsJ
         h+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLx4hks2cvMxSzBmb7AUg8jH6AeKXZCz1+uRcRZfLNQuoApQtcDJ3EgOH3ttQNjSV/PHi/YwipP1osgkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPSt7dhiBihyBurdaKE81d8w1Bc2sxGxU7Ky/ZqnCqGAWwRvV
	ClXdwEjUM4bAlRbGVvfNbNxMpK0pPcoKDRz7mVCb2ekDffLcXcE4fFEE6m+qYBK5usB+76D9w2/
	smlQqzX2GdcOpQi4DvAueyfuSQSmEtS6NjHmgawLJVAeYYoEdw2MpP24=
X-Google-Smtp-Source: AGHT+IEEdlHtCcs6pgaXG9IhBvQUaCMmLQBHZ2UcOp4P4DbnRkRT5JDDXDstbwp2NkhgqGweFj2OIyOScjAfsUjoi5I3aY+/Z59X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c46:b0:3a7:4e3e:d03a with SMTP id
 e9e14a558f8ab-3aa0ab3889fmr28024725ab.22.1733932743110; Wed, 11 Dec 2024
 07:59:03 -0800 (PST)
Date: Wed, 11 Dec 2024 07:59:03 -0800
In-Reply-To: <67230d7e.050a0220.529b6.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759b6c7.050a0220.17f54a.003f.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
From: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, broonie@kernel.org, hdanton@sina.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-usb@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	pasha.tatashin@soleen.com, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5de195060b2e251a835f622759550e6202167641
Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date:   Tue Oct 29 18:11:48 2024 +0000

    mm: resolve faulty mmap_region() error path behaviour

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1507b8f8580000
start commit:   850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=ccc0e1cfdb72b664f0d8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158ab65f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120e6a87980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: resolve faulty mmap_region() error path behaviour

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

