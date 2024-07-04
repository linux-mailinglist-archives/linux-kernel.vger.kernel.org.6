Return-Path: <linux-kernel+bounces-240405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA62D926D47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2F71F21552
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F310A35;
	Thu,  4 Jul 2024 01:57:56 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B30101C4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720058276; cv=none; b=uyKQKZF2BPELYNZCUwyIpiAY/1Yjsn9GOmOmr93EzN83+L5UZVs0si4/k0lOx/JOlBUQxjtHCGB/LiRYCDZOk4bSx482C5fqEr/RP7tgIqvA+yfkEoJIwT8MNDVE88grymmueUVQ1LoxB7A+EYBZ4jvSkWfBFHjlQ3Or3c1dGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720058276; c=relaxed/simple;
	bh=J2fhp56jyLoNNn8tR+ek+4RUcwSOplpbrILC1834nsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jf4ORBIBHAt5hs/WA/PLO4s02aYi52LKeaoyre/HAob6CwU79yLvkaOw1Z2Dzjuim0ExBnObJxNVPGJaZkz81IO764VcBSDLnG+Yc0nLWUQnbGkO3n1FOaNbd+RJk92TomqFllkkvPziw8vkb/Y2t8ghNf37lnBDOMGowBvFfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f63eb9f141so100314839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 18:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720058274; x=1720663074;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3tHtIel9pncAl2PITb4/16Iy0jcNmaP0As6+p0J6Ow=;
        b=tK+UYTu3LLWetHj+y1+y/gP/GOXhOYPFxuZmZ2V1tg1+jGPpgb/iw1KtNnqTgLmycy
         26SXqJJGfnbzV/JAG7l2YTYGBqnXqX26G2nwKd4/FqTLTq1APRJmjglCtao/Mca4BbDf
         9TLEcOc4uDmAy4NKghkKFd5ArOHR3BQcaAs6KVpUL9sSupqPDLaPtwVa3qpS48JAvrKg
         5B+eLEMhuLpqbhfR1U8ZL0mxhmrEu6P4WO/rufB6poec7TFDohSpAw8sMWqQK1/dqfdR
         BB4vKZrIDjwRGA6V7DQnq6rd8y98Nb5li+wRHtXIk8lOYomdtH0qiP78EvfxeGOMJ/hc
         3B2w==
X-Gm-Message-State: AOJu0YyUacmXxC91FMI2KyFeEz1ovpAODCz7T3xbI4aTYoY7HbKNb6k4
	CsHF/TJBHMmVl1ULN26LoFgTayk+zKlfYizn+tNEgoseOUs8csiEw+LMwsBBcxQmjKGJQmdScWR
	t0CZn6TnLloJHnEXl1CiA0yrDt29IIjir8QuY7J1bPSPEGN3VN++OZkk=
X-Google-Smtp-Source: AGHT+IHAUCCra6hrAliN92R9ISb1JGqx5kOPZ8nIFV9OT1O4QgWkBkHSZn8O10VSe9ylgBGNnCtBz0/XjaKAusysS4gZb2w7mWvz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6012:b0:7f3:9d1d:7340 with SMTP id
 ca18e2360f4ac-7f66f6afe7cmr219639f.0.1720058272892; Wed, 03 Jul 2024 18:57:52
 -0700 (PDT)
Date: Wed, 03 Jul 2024 18:57:52 -0700
In-Reply-To: <00000000000047cef3061c5be92d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000595608061c62464a@google.com>
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

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index bdc2a240c2aa..0b215d1b89a7 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -954,8 +954,12 @@ static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
 	pte_t *ptep, pte;
 	spinlock_t *ptl;
 
-	if (follow_pte(vma, vma->vm_start, &ptep, &ptl))
+	mmap_read_lock(vma->vm_mm);
+	if (follow_pte(vma, vma->vm_start, &ptep, &ptl)) {
+		mmap_read_unlock(vma->vm_mm);
 		return -EINVAL;
+	}
+	mmap_read_unlock(vma->vm_mm);
 
 	pte = ptep_get(ptep);
 

