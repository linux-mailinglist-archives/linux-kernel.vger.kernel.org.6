Return-Path: <linux-kernel+bounces-174175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E848C0B41
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBE2810D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459E1494BE;
	Thu,  9 May 2024 05:56:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1821494B8
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715234165; cv=none; b=egemKkPzpYA5KeSCkkWF/L6PFPnZQHE+Qn9W61CbNOCgfMMFujs3XonSWaHvv/v4nK/F5+MDrgZGURxUu9Arwz+fm0R/dYz9Y5b3IknyX5OOtbuB3JRroiGAYK55nkhbYAyPWmhOewuCQlKvAnePN1DD1+tCbFpHs2XeMtWpKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715234165; c=relaxed/simple;
	bh=hIp0OUIdn/v96/BNOSugh62KUNvO8YpO0nalQQ/N9Hk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TMi/oamrHH06rYgY4QWUoJkDVKDb+76TpITFSI/QXkos9VSnbc28v+v1CVeVbUrvIG/YYPVpkWZqKz9YMgo16n7xPB5OwXJfSf/Cz7TmlI/F3DXgd6v+ypNwQ9EQLaPfwuM61sRpDqK7QLRwizeYzOW1zZ0cqbKs/ho5CF+192g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1849aee8cso51316139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 22:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715234163; x=1715838963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6MzpD5BAkFkjjELwZpfBHcsnVlgoW7vb4/RFKhRdX0=;
        b=LRbqXL0B5cU9yyfwP1XNrSzCu7JKfm+YQMLDBGQQkk/Wr9JPoNxydL29MljypX05tV
         9LF4ln52gkkpediVNC/aYgfiIT6La5TMpqnwecxTmF8SXm4DLDQnEiVjxTaugmFmjBBA
         LD5XeoXbX7PILSS7iDbGbranRvk79u1TS525cm1sHS8KRAsKCmR/k0iikOjzhN6BYtYQ
         SJA85ILHgTM3zl7AG4U4wYh+ktgP0JNMnlFiZZL9snhHGhaTf0TjLiKs6MwtPu12FTIk
         QSiebo7kdNmmhmSlB1WFJIgw2mef2AEtjfq1tS1VCyr6FRvxikF4nE9ZiHIDcVtO7Ees
         qLyg==
X-Forwarded-Encrypted: i=1; AJvYcCXQeJ4sE9+gZkvQzQn+OxVpflM8SfGRgAMK1BsXkBxt3LC9XVFCuxPTdjUyfB1eP4GyC9qbXCJR2G4iaGdohEGN+Zz5lWFg0/LCbqiz
X-Gm-Message-State: AOJu0YwuO1B1hfSJ7GYgZcH5fxIpkXQE/KPhCL7xRwy9eopnSQjYhlC6
	2djqkuwICnFAEsgb3UrfkDo6Q8QXGiSewUEOtaDGdL4wWU8AzlIGIxfC2+1/UAmmvfP9mEtQuwX
	Ih2E9uEPo07bBYhxG16Z9vZGxKar9klUc0PKyolizqV19tt4Zs1bCohk=
X-Google-Smtp-Source: AGHT+IEuag55jluE3Nyxn908+rqIGSp9xlMPkmudCdRG21+uY7hlGCLO4KeVtzBuZKO7r9XfIPWqHjoEUiSrETtCHx0WbAPTuNH4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218d:b0:488:7838:5aa9 with SMTP id
 8926c6da1cb9f-488fdd5cfaamr401915173.4.1715234163588; Wed, 08 May 2024
 22:56:03 -0700 (PDT)
Date: Wed, 08 May 2024 22:56:03 -0700
In-Reply-To: <0000000000000e6b300617b93f6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000070ce30617ff13c9@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in __pte_offset_map_lock
From: syzbot <syzbot+f96e045d95fe10c0e800@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1d65b771bc08cd054cf6d3766a72e113dc46d62f
Author: Hugh Dickins <hughd@google.com>
Date:   Wed Jul 12 04:41:04 2023 +0000

    mm/khugepaged: retract_page_tables() without mmap or vma lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1336bfdf180000
start commit:   f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b6bfdf180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1736bfdf180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=f96e045d95fe10c0e800
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1457b450980000

Reported-by: syzbot+f96e045d95fe10c0e800@syzkaller.appspotmail.com
Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

