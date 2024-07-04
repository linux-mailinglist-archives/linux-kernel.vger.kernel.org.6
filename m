Return-Path: <linux-kernel+bounces-240386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DE5926D1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CF71F22DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03188F5E;
	Thu,  4 Jul 2024 01:30:37 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A02581
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056637; cv=none; b=U9cm1Tx84U0vQbA+9K+jr0ymhJz93NLZ7dBtMBYbfK/DhPdMbgJBF4nmp440w89tblIlqVnF+GzJbWsguVwvQwOc+m14/g3jZ4JqVTF+K076VYTPkqIF0IXVimedt6gZy3LCOjyy87LrsG7UF4iXYkpU/mvyS1wJhUyzKyzg0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056637; c=relaxed/simple;
	bh=Uob0Op8Kgv6935Tz8eceu1Iz8D3r5RUBzTfNWiw166I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rCudEdko8QtHaYicx0ymX43pGPrxKPGCsI57T1E14VBG8r79FsdeDn2BNTa5Ar0ZaSDzZfZtwPw9MMToyqum23wtnsWCFyxZua0L3aPj7ebjuKb7AUx1rUMOt9dUI8NiP6gk3FXqi5l2alYwm/z7m5svR7FOQx6MgxJNntbNgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so21427239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 18:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720056635; x=1720661435;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPSjezEg9DKl9Y7DBZKU+ASLHhHOOh7mTJmPh7yn89A=;
        b=QJymtQKGUlUkTfin4EvJmjB5ZEuEwg0ZCHhN4JBQF+T9g0Eok56emQREi36EC6pYGa
         e7rjxGvO/tq/xjtJlNHxlSEyjj2mLTVb+HiDrPwvaGCfQDDMQ1FZQJy0koQjzUyTKwNh
         JzYh88dWytjNtJV2ky6OiKVPubVJ9mpFIBpXpgI2cry03UhaXpFuJYquYIuZ3jsXbNGE
         RGKxu6VIQKY2xVwxiLCJXD/QOM9zejKuLdj+T6xRbm9fE2uPLuL61mAhtxdPw2lbA80O
         +TCyKGs6GxvqRcMdJIy334kgB+McuL62+aiSIoLWZ9XMoYgQkZgP7TN/TcMVgjzjeSca
         g4Tw==
X-Gm-Message-State: AOJu0YyYkFVPDvmdHL6zlwVJJFz7crnUdScM8X/aKpNrLxwzJkRNfxNx
	KZwRxbP94D20pyTwoaHq/7DwHxhcZw4nxmeS/yO3hsqwj0xO3sF9EQOVzSfTgOu4lNfHxRhxqsM
	FntkD+WxFQ0M2GT0i39PQw+PeTGUYmoPI/sKrfhjbnEuzHxJehdfoXOw=
X-Google-Smtp-Source: AGHT+IHZ8ka9PdDPUkeurJw8ndzxHit5vyMuFiiZRxzmvdyxA+4c1NHQ1tCJRIn3B6k4U5AfqMo4N6lPPI2ElBdYDXAXyKSpKv1c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13cf:b0:4b9:3703:4adf with SMTP id
 8926c6da1cb9f-4bf610d223emr5613173.3.1720056635254; Wed, 03 Jul 2024 18:30:35
 -0700 (PDT)
Date: Wed, 03 Jul 2024 18:30:35 -0700
In-Reply-To: <00000000000047cef3061c5be92d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcfc2e061c61e464@google.com>
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
index bdc2a240c2aa..0f2cfe595686 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -954,8 +954,12 @@ static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
 	pte_t *ptep, pte;
 	spinlock_t *ptl;
 
-	if (follow_pte(vma, vma->vm_start, &ptep, &ptl))
+	mmap_read_lock(vma->mm);
+	if (follow_pte(vma, vma->vm_start, &ptep, &ptl)) {
+		mmap_read_unlock(current->mm);
 		return -EINVAL;
+	}
+	mmap_read_unlock(vma->mm);
 
 	pte = ptep_get(ptep);
 

