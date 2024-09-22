Return-Path: <linux-kernel+bounces-335023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9422597DFD9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 04:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224F5B211C8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 02:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047A1917F2;
	Sun, 22 Sep 2024 02:13:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9F1E529
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726971186; cv=none; b=WUUL0bVjW6a9E9y4MJNW9+CyoXDZc1/uUBzhiR34n5KFrhu0VuCoVFdZsC27grddFPxEVtcooeKt4xE0VsebtYlCrxeWjK8j9CBXyq9nfa8QhPJA6zjUPKennBMzjSj/HnjavwTJOZV10CPPAkE7wEpX20mwchzxSrF3EbG1IzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726971186; c=relaxed/simple;
	bh=tPythR43N46qifXmGl2Sou0mptrtOYSZCbJV5vs55EI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cg7Gxfo9d9OoM/w4kvGxWU8sVi9OaXFmwYQaA3TdGGQZ94HKoOcZzLHxglD7TqwiUc0ohkvEnypz5kwKFyESlmbysW+C1QzJzTfYJFGGmpgpe1IP3fDFFxfPN4HcVbRlOaRtxF6tPvSU12izbf/lbLVEgwzzYfCojK1FGzmD1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1957c7cf3so4767925ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 19:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726971183; x=1727575983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krDJ/VhAuktIN8TEcOdkBXdCHPqMNoTFdn0OaEq9HTw=;
        b=MYQK5yDhSmm8pN/VctK0V+cg87FUAB376aW6hvNrv/J2RV35LZRrrJ4ddHj53FQuQC
         pAak+lexJG8tkXFARTclpehNQOy96NZjvnRJpOs37LfGxO9aHYVLXM/FPqC9BGm1Du+X
         dPzr+7Qw17qMy3648eS3ivsI9fL1F7MXPCJgCf/PIYLBnsS5rQrfgBsPwlJB2J5EliQS
         AJPP8uIIjL8SiK+Ub1iNg6kEi6ZEFJ7PF6Is1SNBe+SARGu28aVd8bWasYnhO6NaGJru
         Jo/Rhk/Gbz2HAGIJanuNCS6dj0TMtNfGEpkVs2j/uy2GTP0c6Oxzf6Rf8ZiDiqUQP4bF
         9LHA==
X-Forwarded-Encrypted: i=1; AJvYcCWvXd/NJF7jk0k+VB8raM7dQ86wCziVXDH7ih57Hm/rwAKXL87qM2LJLZ7p0y8oFXb5dTtAhtlkXaEmU8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95yfRiKsGh0Wak9WWtoW3aWIPsU5XsZonLfaGngDJmMq/Tt5/
	CgbA8Zp+nCVB72KUIG0wbZdGXCvG+x4L0gPSazUpQfdDilj/PKxd36Q8suXGJQtdy/m6E2tJ9cX
	gPp3ZxL2g4R3hgSVqejTll0PSYD0eex9ZOZEHkjE5YTcd9Wx572OGZYc=
X-Google-Smtp-Source: AGHT+IF/5zVBwYYrjQdOTmoArFXbIqkP5L6QVj6+aZygIuvFLDj+sOdWC+si3TJD9ySzJZfZbFNSmZ+L2FWNu+0UNMXCeMWVR49s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a0c8d0b9e2mr73689335ab.17.1726971183622; Sat, 21 Sep 2024
 19:13:03 -0700 (PDT)
Date: Sat, 21 Sep 2024 19:13:03 -0700
In-Reply-To: <tencent_8006C812E1C657C99D2EF6EECB4C9E67CA06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ef7d2f.050a0220.3195df.0079.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in from_kuid (2)
From: syzbot <syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com>
To: eadavis@qq.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/file.c:1133:33: error: passing 'vfsuid_t' to parameter of incompatible type 'kuid_t'
fs/ocfs2/file.c:1134:33: error: passing 'vfsgid_t' to parameter of incompatible type 'kgid_t'


Tested on:

commit:         88264981 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea86c03799707382
dashboard link: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17113080580000


