Return-Path: <linux-kernel+bounces-529921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E99A42C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8301894F76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65E1DDA18;
	Mon, 24 Feb 2025 19:17:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186E1519BD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424624; cv=none; b=Frydlfpcrq1anxczQq3zoI/OzF1uc3MJcx8DnGrSxa1NL1H/r4nQQzkApb3qMxZaSmi174lthytGYSXap6gZCc7qMAR4vX8ToElpdZyhnJbVgopKHoMloouOQco04RqQ/mGAYE0xOsVONEarw6/i+1UG/NOAEMQ+BcVAr/rDhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424624; c=relaxed/simple;
	bh=KPj1wF92A/o8Wgld2N0GchV/dCTd0ao9dHGI9f31huc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mtQxr0FnFxYweniWrLk2rzCRs6W0+2iYehtB33snOq14oK1KJi6RUfzGRxvHdgFXgbhQIHU2gEW9lGvILg3Po9gjSP+rsJHqTgqcrToMrBmgEYB/p0njFM0MenoKocfHEcJITRUnlQfPLDgeTcYBKAQ+7Rlk8CUc1+4Ns1+lXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so44766365ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424621; x=1741029421;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lxz/RqCKXREOM81gm1Wu9v6BaFMeOeyBcB2VOErZh4I=;
        b=sQvrRffYDJc6gplaUdZleVrIADMrbL1Le6znYM5d0pSv6VND8wGhjz5aIXa0/ao5Hl
         13p5PrhwRrSNhCbZ3Pg6DBJNwYfKcdDxfX7os8qdWEK/jC5ta7Fvi0uwpVOmujYmRa33
         iRHIssEji0YJTxVBuEQyn0DEybQy9nsuGYtnrW7T+BqOnOvGuUkalljpAAE56rILTMNu
         mh5aZPqNeFIyu7J4Km5o/uvBMbv0ORyVAE+4RTlGfepC+R5Lfz4/uJA4OLjmIwamFdI+
         L1tzemqTgGZB13i0+OndSeRqRcqVi8Rk0vCLB0CHPEz05lvWIyAAvzkIe2iezl6imc+f
         V9mA==
X-Forwarded-Encrypted: i=1; AJvYcCWTGnhBQxUB6+4ICNrhA5EdCDjmiDxprW/h+cbCeT9iNAqgRlpGcQ/tX7lMhz72GKcRFQLXE6h1U5ikPk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMgapCz/rh72DGaqO1uc6InUyRwLg9RAzPjyhkKKvcKPUWXG0O
	ZbCILUw/u5hdCaGm5i3Baw79V6KMUs0D5/C8IDQl7rzaQf4BPtRmMd5Kpp9YqvlpNhpqsocH4y3
	5YT+s1qSYwmR0EaPMy3mTMZScBzqgGwVZMLRwl5v0AJj3GQygl9VvO1E=
X-Google-Smtp-Source: AGHT+IH6YWr/CFsk1ozX/qp6s1Q8dCtVU8hee5T/9f05hS3RBatu6s1sYFJ0uEk8t0aynb/tUcogsde1qPaJxNxtqi5CBcaar4Dg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:3d0:4700:db0f with SMTP id
 e9e14a558f8ab-3d2cae875cemr166784145ab.12.1740424621697; Mon, 24 Feb 2025
 11:17:01 -0800 (PST)
Date: Mon, 24 Feb 2025 11:17:01 -0800
In-Reply-To: <4659682E-734B-439A-9C3B-02257858B8F1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bcc5ad.050a0220.bbfd1.0092.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in pcpu_alloc_noprof
From: syzbot <syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com
Tested-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com

Tested on:

commit:         d082ecbc Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133946e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcce427a3afb99b
dashboard link: https://syzkaller.appspot.com/bug?extid=fe63f377148a6371a9db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1576adb0580000

Note: testing is done by a robot and is best-effort only.

