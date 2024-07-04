Return-Path: <linux-kernel+bounces-240399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D761926D37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288C1282705
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A17F17591;
	Thu,  4 Jul 2024 01:49:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE767168DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057745; cv=none; b=Ivuy772WTEpKuLhdroIX9EPxm+oR+jWbLGv/ORtNGSXSAXF2G6cMulX3lja5oKrrjgXsTdvKIwYHC1Grzm/i7/Pp99adQlGIyYnGEfojOs9tVvMd9vKsbRLgJlrpg3copeK1VISL4osPPVOakF45xuY//F+T1+TpSt5aRNuGTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057745; c=relaxed/simple;
	bh=P85Fsn54URz1BW30+zBEdBEALosAIwR12LEsi759PhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZXLsle+T4cZjviKcCSl5AXwQfHY8r+pvGl46HjfMcKvtuJx89TOuJaEaALcDitMsCYRNDdYRIK2g793Hm8SRcdz4YJvxkFKJtt3FuC7zMjRvfBzjA5f03MuEGPs39kdV3B4/bmYAzwd8pq7OcwNFnI47ExYgBiYEyroU1GVdUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f6486e0fabso20464539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 18:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720057743; x=1720662543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIb7/VSpVEKxjgrbang4njEEWdG+CdQPQUSBYkBxNiw=;
        b=Nur3AUKSHTxIkzkF1cUTa4LGMH7KGJZOphkw1bCq2ivU82kBzS00rWcLQytsDz/8z8
         NPuou/nnAixPkRWKUrhOcmRQH+vb/MxVsc0mmfB4FRxyLggjCmKP7z5oOKOcMsL8d8CF
         6Ca6nVVeNEAsH2RDCQJbobzjXdpskuspA1x7BuIcUDus03oOl6NtrMOnNMM3z4KY1ltP
         vzpY3KN7oY/Vug0g6fRVYMkR0BCqGodVdEoRQscSD6WQUvMk2gO/stPgmTSq0J4qxITg
         g7oCeGRbcUfpWU9MpSFMWYDFvrE8fNwcGE58IAYqe+JSztEt5I/m6/992pbJXR0XgYLf
         7v/A==
X-Gm-Message-State: AOJu0Yyh6bmGd4tUeKsgWCkMSa6jcSbHw29v2A/FsSp+rrk2yoj/ZMFj
	Vsavppibbp6Pf5db1g5nOojy8/SHWVABeD2vUAIow3m45A5p4PawMF/F9IWvWBLEpXoYg4+m9eL
	d2oGeSbVdh+RHDfIXJbq61un78FGF4ogjREqEkuifY4v55/C3VfnOXbo=
X-Google-Smtp-Source: AGHT+IHGQLevyabFoVR0aPFs3IK2r8BRocT/Hf40j1K3mFi0yUoaanvixznb4kkiCSHnHJQ9Q9yC7W/mBmlLeQgkCzDCJz7ZcKmk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8419:b0:4b9:b9a4:848b with SMTP id
 8926c6da1cb9f-4bf62e92aeemr2218173.3.1720057742920; Wed, 03 Jul 2024 18:49:02
 -0700 (PDT)
Date: Wed, 03 Jul 2024 18:49:02 -0700
In-Reply-To: <20240704013031.977091-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c29a51061c6226ec@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in follow_pte
From: syzbot <syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

arch/x86/mm/pat/memtype.c:957:27: error: 'struct vm_area_struct' has no member named 'mm'
arch/x86/mm/pat/memtype.c:962:29: error: 'struct vm_area_struct' has no member named 'mm'


Tested on:

commit:         73461051 Merge tag 'erofs-for-6.10-rc7-fixes' of git:/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=de2d4dc103148cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152339d1980000


