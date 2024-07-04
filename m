Return-Path: <linux-kernel+bounces-240436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B211C926D96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672352829B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BE017991;
	Thu,  4 Jul 2024 02:48:38 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860317543
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061318; cv=none; b=eO7dLL2UYCwUBMZLgtyxw51lw1iMEJrFXkkifNqkye9BO7/n5IxlKEL6Im40uK9WnmBfsJDupPn8dkbrBbXOcB6uf9y27rwgEBJIx1kcEcPV9B6o3Wux6u1JW4iU5uWDzh5r2zpi2cT8kjJsNiBFYK0wAGitH4SJmf2asRRN3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061318; c=relaxed/simple;
	bh=7VzgBXLG/qymrHo7gjB3CpNb75voyhGkXAAnKOXj1sA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=saaPd3oC/hyUh6GUISWS8U0qzixpZnPlQlJ75mum4qOVOh0t+qU8/uDodvHGRvnzTNEtXjCuKiiVVMwvRQYNtlLS6AFhzezgDuQHw1Hk43nNt19qtx0T6QJX3L8lHzFs9b3cBY1AYeCdn3Btmk54kkwqsM9YEkJaeFvia2Q7klE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3737b3ae019so2259555ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 19:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720061316; x=1720666116;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xt3s/S9YE6diJMIOv5CEteRczbHApy6ZGmofocIkilM=;
        b=oB99OMEm+AgdV3DzLoOWWcWnZe7bECsYcc41qY6LM+pJASt5h4xd/hVKLuSFaNXm7G
         ECUWl7cWlcqYhLqSz9/SOgiSGcsZqRdszhoRGUAvNRQnFoVViqXeixlw2nfs7insF09k
         xt5Eln9XnxNT4UGCSLqpkmi1rz2YPhA1O7AIwk9CEYun4b94OpRw7XrDNHym3AePtLI6
         pQ8xSHjzc/M4Gs7kIm9ISToc5WJbfXQSi9s1itH61EkeL6+8HLHIydiUw3ZYZzJ+H7GS
         Ky9oQJkdUyIT1cNNJkwp3mLLGOH4nT/ljnSPVvObQhbNaCJwG+u3GcUDCUCAdsyIE9a0
         rdHg==
X-Gm-Message-State: AOJu0Yx6XY6BbNnP4NUDtT8o7MJIjFxIU3604sL6kqVsqjS6fj+Ropy7
	nRRtU61/kYTFfOsno7Dqp/+AlKI5mGmajS4rq7KufbR0LuHoYDMlEuK+Nv1IqXVQH4neAEAJJu6
	03ukHw8ik52C+B+z0bYWrDkOKFa1Kr7ofjlCVxHAQQvs2dTA30ZjwWGY=
X-Google-Smtp-Source: AGHT+IFAxV7+Kvn3YnzxE9UODZk9kBNs96OyRljs1hLXiRXKkryALjAhduOJNcFzoMVojRGZDOLW1N5PMAkqk3ASiG3eUBo7aPEp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1085:b0:380:9233:96e6 with SMTP id
 e9e14a558f8ab-3839bb41aa4mr130125ab.4.1720061316327; Wed, 03 Jul 2024
 19:48:36 -0700 (PDT)
Date: Wed, 03 Jul 2024 19:48:36 -0700
In-Reply-To: <00000000000047cef3061c5be92d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c07cf2061c62fbbd@google.com>
Subject: Re: [syzbot] Re: [syzbot] [kernel?] WARNING in follow_pte
From: syzbot <syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [kernel?] WARNING in follow_pte
Author: lizhi.xu@windriver.com

Fixes: c5541ba378e3 ("mm: follow_pte() improvements")
It introduced mmap_assert_locked(mm) in follow_pte.
This case content does not hold mm lock.

#syz test: upstream 734610514cb0


diff --git a/mm/memory.c b/mm/memory.c
index 25a77c4fe4a0..18bc74dd0b72 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1909,6 +1909,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address, end);
+	mmap_read_lock(vma->vm_mm);
 	hugetlb_zap_begin(vma, &range.start, &range.end);
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
@@ -1921,6 +1922,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 	hugetlb_zap_end(vma, details);
+	mmap_read_unlock(vma->vm_mm);
 }
 
 /**

