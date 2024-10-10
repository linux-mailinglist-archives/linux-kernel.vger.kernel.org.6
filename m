Return-Path: <linux-kernel+bounces-360122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEDC9994BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AC2285CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD301E2841;
	Thu, 10 Oct 2024 21:54:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416C1E231B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597244; cv=none; b=tx+BssJgWaVHsdJXVF+uyLbLRgm6ZEcTH46HvFQNrnCHxzrEsSE9UrXIM40pChuH8QV/p2+BzQ9XuPkWgcALaXQrTlr2zWJ37MsAbUsxPagTJvK+yZyO9WN8Th92Ca4U6TebM8f7k7Lp744+52MkUyXFL6p1bSEtnk0zjG0qSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597244; c=relaxed/simple;
	bh=hoCqlhkVBJmRQ0KU3p89JHduTaBAZOGBal6DfXGeqf8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PObcc8SqM2Pc8AXq7+fU2CBkA58VnO299apfDd6rZbL0AsPFP9dQObThDdrkcdf7Q/JKuWZnkQtujmfbrNEmFBXZAv+4N4t9paH4r8nyBN0W5b6eid2Xm4fSx6yq4QDnGi6Q3V61XOEaDAyIKWuvESGkADTouTFotTVoBQS798M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so6673595ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728597242; x=1729202042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pWqZKYp/y2dXLz+05lbmPalE4rT1pDd54Wk7W+mtes=;
        b=KGc+sd12FZszWPujM5WMkwDFnh53Hp/OU2xF9TmrGkIvSX03Zwl6cYmsvTbfyOvp1e
         WOSuLQpUnj+r8k3iUsrZ7bh69UMuKDyOFpA+YcKjw6IseyuZRLqdHDF7EWhvxLAzONed
         xyqEAmJAcgfGNGUFeFTjRn8N4JNkG+M5arUPvmEjSIIfl7TlPW+UeyMF0vkgvdLvhrYd
         tGEomA5EpWVTgIzDdOK0Z7fRMPfNC1tgmA2NEw+Gx89uD6hCekPcg10hpi16zXZyxmDZ
         vHM9uhTAuvJr9veBX/UTxL8vRHa8RfAB1xA1lZqWH7VHXt2UutvxGvwnmPOdPDcvpayv
         OlWA==
X-Forwarded-Encrypted: i=1; AJvYcCVPcZsvyhXm5P768izm4o4wRyV1c1h0UOlxL2ry+Y1lXY001ySi3ZWFRpOoZQPMXTviV+KkR9BQxHV91+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZSOSDaKb2MvKeVJ9KSnJHV/Pg+eUa6Wz+OCR4PQj9mZf1IFN
	e7vm5yhBAckc6HObNeKK55ratInZbZHTjw1clFZ4CJ6jCaIYsTleeT6N5a4K3RcE9AyQY8Kdw8K
	oLW0ql8O0C9YxwtgPDgkbLmHzGdJcDSy6Bq1kcpo/TEfqpf7bMN0ZaCE=
X-Google-Smtp-Source: AGHT+IFxHTxzMrs0wFAOwmw/l8gedD26oPktIMOzBs9OwO9g2k0OKEHMPZErwiVlRX+RCMl34J/fI/Z38GGS3YFmyt2S7wxtWHVc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3a0:933d:d306 with SMTP id
 e9e14a558f8ab-3a3b5f51e48mr3790025ab.9.1728597242614; Thu, 10 Oct 2024
 14:54:02 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:54:02 -0700
In-Reply-To: <000000000000939d0a0621818f1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67084cfa.050a0220.3e960.0005.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in hugetlb_fault
From: syzbot <syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dvyukov@google.com, elver@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org, 
	mhiramat@kernel.org, mhocko@suse.com, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3db978d480e2843979a2b56f2f7da726f2b295b2
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Mon Jun 8 04:40:24 2020 +0000

    kernel/sysctl: support setting sysctl parameters from kernel command line

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1499efd0580000
start commit:   87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1699efd0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1299efd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
dashboard link: https://syzkaller.appspot.com/bug?extid=7bb5e48f6ead66c72906
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dd6327980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d24f9f980000

Reported-by: syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com
Fixes: 3db978d480e2 ("kernel/sysctl: support setting sysctl parameters from kernel command line")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

