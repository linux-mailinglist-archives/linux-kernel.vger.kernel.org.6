Return-Path: <linux-kernel+bounces-444175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03FF9F0274
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E0B2858E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4272B2CF;
	Fri, 13 Dec 2024 01:55:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAA8F6E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734054905; cv=none; b=r8qD4sLfvZPGKA0D4YHrHkB9xpm746i4J1uDF7Yzx6/GphIkVf1Jm3kelDYHD7+UUcmiu6uYUANR1zaq6Et5JU/IF3Ygi2QTxKOorqh6yF1NHiYbavf3JIk19kn/uyyhfpKtBpVkqqAz6a8zsT2eib360e2v53c3f+88cSCoIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734054905; c=relaxed/simple;
	bh=sMbG9riobuXOyJGLrpUFFnLjlATW+hceuLc0u3eKVR4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=idFOYGSYaIc0f/myy98Jrx74PvL5GdKT0/x1Ld4+xhIHbiNfG/qSx0KJPwf2GgLJqhRxh7kwi7WRAQYF5Ij0/QczqsDUPq3056gPlP4OYYeAhA8N9Q55N3tMP9fuLhy8AZ/QCPNsGVGb4e/TwOLi4Cg7HAufRb0fq0bDQqM/Vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso209795839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734054903; x=1734659703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iELJ9oDF+n+OkIdnPEcLQYaPaf9zNhUx3ZHVebowCaI=;
        b=rpWTrrHDXcN5YSDAi9IE1DV2vokMwSbOBqGRIeMLO3U3HN/WXo9cn5Z1hFFGu5M2LX
         EuSnuVtuu/BCEOKBdj4RSkGNNf6C+sPO3EAZd+DnHBHnA5mQBDKJ52ntefPgfPEemtGx
         trcLq3erfTg57iG+8Mb0unZXAx03LOVg9/c0lUrdGh7A1FsWq0iA6mFS/B5o3gbPTN0l
         IOjkdvVQui9t78aE3UnzYZl/1FzOlEHvNXJcO1b7LeJZ2aGDHrpgy6lKjUT5keivYkLd
         I/n46At7TwrsFxlyuN94IOhAf7HjJ1M+YMtTswGDdZUB6axnRCSKSPgwi5uXtCnadpKH
         jYXA==
X-Forwarded-Encrypted: i=1; AJvYcCUkGYUYdZHOEmlJWPlstvI+uX67e7ID+dByNqLLiMZw1kuvKJRHwJkuTLvjLRwlbQZGuCeXwJ10caFFzWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDgOrtjSd7rW2ppcF+lxaFQD0rgHkLqCMCQEem3QZEgDGpskP
	R6SAGTta5zPkXqJOxeog7G9aJvJzhZNmg9ORarerWqPymesf/6MBMpZ2gH6kBLzg8NOP4OiHeYu
	4qYP34srVHDaGLGm3zF7R960HdfcDGxLnX0RmoxnPNwHXNhOxys3KqeQ=
X-Google-Smtp-Source: AGHT+IGV6ZMjmQoUKHh83o8Pij6XBjDQOmua0bk1B8xERrkaiKZuVVaXG1ixA72Bq9jfxUI+rjovBHRu8vGrw8cwfO1UK6y/SCig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:3ab:502c:b523 with SMTP id
 e9e14a558f8ab-3ae62c90e23mr24286095ab.4.1734054903594; Thu, 12 Dec 2024
 17:55:03 -0800 (PST)
Date: Thu, 12 Dec 2024 17:55:03 -0800
In-Reply-To: <671fbcd6.050a0220.21b2f.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675b93f7.050a0220.599f4.00d6.GAE@google.com>
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_alloc_deferred_release (2)
From: syzbot <syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, arve@android.com, brauner@kernel.org, 
	cmllamas@google.com, gregkh@linuxfoundation.org, hdanton@sina.com, 
	jannh@google.com, joel@joelfernandes.org, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, maco@android.com, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, tkjos@android.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4080ef1579b2413435413988d14ac8c68e4d42c8
Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date:   Tue Oct 29 18:11:45 2024 +0000

    mm: unconditionally close VMAs on error

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1329cd44580000
start commit:   c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a34ca8ca33c0e535
dashboard link: https://syzkaller.appspot.com/bug?extid=dee8aa54cb2f5a150f9e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484165f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b2ebb980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: unconditionally close VMAs on error

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

