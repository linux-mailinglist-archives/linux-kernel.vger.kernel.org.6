Return-Path: <linux-kernel+bounces-552863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508BEA58005
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 01:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B05216B4F6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 00:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343EDC125;
	Sun,  9 Mar 2025 00:32:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBD33F9
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741480324; cv=none; b=dvVoS7aqIIJ8+f1I53mtIdMvK9p6EphlWqTJZyQI3kRIlx5tKvIAXfsRkm/ldGjDjWuO+9/dZ35pMdgWdf92xrw1GH5GqoX6aK8dd1D9rfUvnjGD4Jb2TtUC/y0UkBn3Z6uyWMkVQUAtmE8DSgQCDWOV10ckLx5UXFmh/wZceFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741480324; c=relaxed/simple;
	bh=5+w+DpFN07cFMMxG3KtxyUJcBT+QtYSPglebHcuHpoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UiavjuCgCQfhJLZRw3M6Cajy6Ncaz+OVvrRHE3NF6vRlaxWR7qc54Ek8KoHGCrVqOWU3zD5cmn0P2Qq4CPqV+hR4nJJFp9/x9sNO/1+9G9gcEqFUjXzVYkWUkCr3YrN1cGhHuKF6/I5WCkLeCl0nRyKRkWlTFNjS803r+IPHeqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d43b460962so59106215ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 16:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741480322; x=1742085122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfB4DWMuL2dRUjaSj/0Ry9KkaKQ0CpScfoI5b0dPR4o=;
        b=I6fuO7ocQr1x5NSIEwjcmwv1k7PFHSw3vsM/9i7sfgSBqfBvw5ZqpOF9EMAsZSgbhW
         gU2CpcABS5yvWH2/2FtAes2sPD39rJXDzCX6Iqh3JNrdzlLXO0BhfVD87devxmm94p65
         d8tGjCodG9Mb8CZIlvYl7VAN4/8lQnreOjIFynvIhaZXflhAVR2x6gp4PiVMUzIsF1hQ
         5IokcphjEqtNE0bBPI+9g+s3Dm2eJnRKpzncu6ApTvoDYKgIj1WJbvHYcbpEuBUTzCIA
         +hH/oTo+7+8gCAWEn6PICTcAHimeyPrtcF/k6Et5t9Ote3VfCaosbA4df+wxPGOCslwX
         AMrA==
X-Forwarded-Encrypted: i=1; AJvYcCWv1PaTe/Sjob/1w+WgRUUHndHoNQok8sk7J3CLY+menRvIUd+m7Q3/95KwZ/ztA9CNkVpH/UcjlBqcFVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKntWnohtNXGgZrpbhCruRHszHUvQ9OLImUFl/YQZHiTSuj5i
	fO+sezvi9Tz7X2XbBGB+Slbh/98VMCY48yO3tgwPbCfLGdKH2o8OIAhEVjjs/2/4Z8eXYmYMrJn
	autsLGEm8pQX6NX+D3XTU7EyxPE8UgcaSOvs16Lr4D0PgKcumP0X9gGI=
X-Google-Smtp-Source: AGHT+IEO95u4KON9M9kPvSb6+jLVgItwLeyQ52gl27OoeaC/4UUw3Y5B6gO2wA0A8Jz4fVX+dbXDf3ZqYw7CX3nM+UyIWTj3lbjf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e9:b0:3d4:337f:121b with SMTP id
 e9e14a558f8ab-3d44196060fmr96149465ab.8.1741480322622; Sat, 08 Mar 2025
 16:32:02 -0800 (PST)
Date: Sat, 08 Mar 2025 16:32:02 -0800
In-Reply-To: <67a2b735.050a0220.50516.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cce182.050a0220.24a339.009e.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] BUG: corrupted list in new_inode
From: syzbot <syzbot+2dabb3dce04e28763712@syzkaller.appspotmail.com>
To: brauner@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org, 
	jack@suse.cz, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f254b7980000
start commit:   4dc1d1bec898 Merge tag 'mfd-fixes-6.14' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f254b7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f254b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c516b1c112a81e77
dashboard link: https://syzkaller.appspot.com/bug?extid=2dabb3dce04e28763712
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c34aa4580000

Reported-by: syzbot+2dabb3dce04e28763712@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

