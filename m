Return-Path: <linux-kernel+bounces-552668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8CA57C98
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775221891C82
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35A1E8337;
	Sat,  8 Mar 2025 18:05:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48061662EF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457104; cv=none; b=jpzgxNa/KjzmSbTf18dB9xLGCZ6flJr4Km6Tzxt4I5tG0n+8SWm1k3eclWMe42liBYSHIQLpcm0VymveN+A80+zE1Y0efPbAcSlWIS4f75NP7VBFbpJspXLr7FJ9gx8MNYCacDMX0iz5+Gmu8stc4IEvkNpNpbkIBRtec0QnCrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457104; c=relaxed/simple;
	bh=BFERkLF5tvINM5AMTT7npfSqAfHAEvcSqvUAM7QVZ3I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KgaUjAgTYNN/0yOD+N6N21BQMDQBTbizjo0vHwIBn5v9iKOeX6ViYUFrr9Se2g1m8VFN28HHi+1jTPy3cgWPww6+m8o8QzPgGvq8YGa98Q+ZZ4ngRpa3AP1uvsbL2FeMmiDTSfGDB8YhKrpFW3YYrRbZSgqZaLmtVYj30wMB2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b072e48ddso613356539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 10:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741457102; x=1742061902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiC+HbgW7R0gX7hV59VQWjAiqUZG5JTOlemCDNoKGj8=;
        b=TseerPfPnqixqh8n01jBa78KSfdpgwPqyDTUcfZKC1FXJBnl7xkBzhZOcPFOm/aBTy
         28zs7lig4yQlYLUhZ5yiLbymWw5A23/k6oTRw9zl8YDDUNLh6MNmMv82X9GbDhL+wO7+
         QWiMGCugse5uF7hUBStldR5UxZHQB0AAVdarmbDYgbSBXmoeDSDS/8UR3n9bArZYVOqw
         V3Nxvrz9opJ7eS6fnxord1DrnYdV3McEKmLi2Zrt2ax7jTVWHSVWXlaDdxHSA1xpbTUR
         8OeXrtnzZwOOe5j5n9CYWiul9kAD8kvTkWE4XUe7aJ0K4ChjMXYX98TPQV+inlkbTn7x
         SFGA==
X-Forwarded-Encrypted: i=1; AJvYcCWkhzK3GWlSnBsALaEtF95tnPou/XSE9Yx0SnWLpYObZPPrEIOGGnQHxItYSFQdnxt51rofSVcFfxppUrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWPr0dFGcPyIOpxNcHKMVFgOTQcxYzrSvSREOOx0sfqr2iayE
	keCTMF+ih/+E0nSzTOLxa4O4UshiGF+aL8yLButez0pehRm7xnMfQfnBDvJsL8/RNuxZdpuKAsA
	1x3Rzzc02UI1gfegL81hNu/oxKMRcL1wEdEF5NmkVLgt+XWHTvGPzROQ=
X-Google-Smtp-Source: AGHT+IHNb06mTcXNBo2l2kG6CG6ZgzR/xmoJHMjCzX6KgJmQOHH+vrlcKgCoFFOUfoQHb7qgCic7gpJhxxqxAoJlleYqBBCxzlUq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11:b0:3d4:3c21:ba71 with SMTP id
 e9e14a558f8ab-3d4419ff144mr116769525ab.18.1741457101875; Sat, 08 Mar 2025
 10:05:01 -0800 (PST)
Date: Sat, 08 Mar 2025 10:05:01 -0800
In-Reply-To: <67a310c5.050a0220.50516.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cc86cd.050a0220.14db68.0037.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in inode_permission (3)
From: syzbot <syzbot+1facc65919790d188467@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10305878580000
start commit:   69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12305878580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14305878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
dashboard link: https://syzkaller.appspot.com/bug?extid=1facc65919790d188467
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d95f8580000

Reported-by: syzbot+1facc65919790d188467@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

