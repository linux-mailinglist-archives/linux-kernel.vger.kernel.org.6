Return-Path: <linux-kernel+bounces-343435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44775989AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46572825A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D25A7AA;
	Mon, 30 Sep 2024 06:51:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115823BE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679066; cv=none; b=bCjdGiGWdXv3Snj8KkNyGmr3TX56EJekuTkNEQU+2YY0U4JGe/XfT8ooCDV/SriXXSA7nr537eY2XvxJbbP/OVnJWBgZLRjm0/oAXgWVjKWABHAMmuBfr+HRcOmw3FUQ8YiJBF8I+x2keKiSz/E9qv59NIM54iA/7Yat8+DHvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679066; c=relaxed/simple;
	bh=WWSicubhq59J5tTVWrnAlr5hjkZ3VRbsIVu0pj5Nx4M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jgUCArXNuXXovwPf9L6qKWpcufzjgyz4zWKQ6n1iHnnyxJALwSugANh6SWMelHhD4rJfDxoK1RFo5kXiYR25TUHpXIpHUwFEbYv5yWBBWsXz2jbQwc+8mQKd40nL1EVrj2+UW7UPWgSw98HeaK1oqYUqGQWi4x8NFBKstmMBMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34ebe595bso23640435ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 23:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727679064; x=1728283864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eraBn+3Xq+YaW53FLSqwCSv/wmhSIruDo5DsfDHttQE=;
        b=XqjsXUhM3MkFMJNT0DzA2zUXC5SOR/leRu7qAWLLG9xKHPHdRvsw/fn+oPy5KgGXcw
         xdw+zz+E3GEREtUgHIwry4T+SRA4fSlGzu8bNQHhKom+E34SxUlnkdBoGnQhOHUQ3euD
         ZZp4Rk4q6QfWBKaBTUl0YYKjh5Qja/bg8vxO0OXqVNBxF5+OLulr2OQHXdt3RjZ+GqWn
         3M+ed+v4yURuhYFGEYJ1Zp6S3SCxYjLrYGRvqD1OSpSoRFgVFz6q2tbOfaQ3a0CF/RuB
         6Npt4ldljhBq0ET2gsYl3vbqmmxZh7qPFhEB/uoq5DyKf3gstARwFK0AfsW2mo4xVTHj
         5ojA==
X-Forwarded-Encrypted: i=1; AJvYcCVHcLb4lExRptliv3PCB9Miln24jqZ7I+Z6V54O8UBENvF3JEjxV/hr9mNisLNfa4+Vimgkwz42wYeCIzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwebT+BTDQx3ilXjrrn8Np0C52z9tOAKIrkQ2/LB3o6Ma1sglvk
	5u1aOgc1tdKlXQ196hDOcNkUtZgCKlpAUtNM+F86qet7SZUI2ySSS7ZhDOEy+0iXMdspQ2swcur
	EkYNxRALT9tepP023ueYDip/01fw9609Ko1Q/UDEWYRI+SIBhe3OyFxE=
X-Google-Smtp-Source: AGHT+IGTgsMuDN1vlJp4WZwhDPImMyyh5hNgOWFoAUodwMaWWns/uPUSoWWWi5hkbMAQCe+HcHxwgtmCVJ83VfZ9gSI/wES8LOmO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd87:0:b0:3a1:a57a:40a4 with SMTP id
 e9e14a558f8ab-3a34517ac41mr77312035ab.14.1727679063993; Sun, 29 Sep 2024
 23:51:03 -0700 (PDT)
Date: Sun, 29 Sep 2024 23:51:03 -0700
In-Reply-To: <66f7b3a0.050a0220.46d20.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa4a57.050a0220.aab67.0027.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in shmem_file_write_iter
From: syzbot <syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, ebpqwerty472123@gmail.com, hughd@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2
Author: Shu Han <ebpqwerty472123@gmail.com>
Date:   Tue Sep 17 09:41:04 2024 +0000

    mm: call the security_mmap_file() LSM hook in remap_file_pages()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110d4ea9980000
start commit:   3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130d4ea9980000
console output: https://syzkaller.appspot.com/x/log.txt?x=150d4ea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=288aa6838b3263f52e7e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17af2980580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11607d9f980000

Reported-by: syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com
Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

