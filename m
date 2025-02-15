Return-Path: <linux-kernel+bounces-515950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5765A36ABE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BCE189687A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A6B13CA9C;
	Sat, 15 Feb 2025 01:15:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21E1465AD
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582106; cv=none; b=M1UllNDtm4CYz9laLwyvgMgFy58h/BzIT3ZJl/sTdlbNMXfg02zhmKytdPKzFPaPjDnSPgnAZDYUZJnnGsA4ECLm0kG5vvXCq/srydnk1/M4zVnNvAsTQtVr81v+/Ujub0cyzJ5To7rhajzWOENcS8g3CZrz1/gDexXcBkahvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582106; c=relaxed/simple;
	bh=U7FxL4j2LqcM4+Gtps/EVy7SQALwqQkDxppAFze64Qo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a08pOI0Z+722YQoNRCbxF+44l+ZGuZV/3U41FgKh3I7Vne3bT3zKABU+sE98buAwBMQ+eGKGyxc8e4HFgAefMvphWH3hXPgsGJl3j82iZFc9UaQmdw7u176lJnAvEAfYSbbe+HwuS6oDOLFZLiqmLY6oMxcwegjLvQ/F8xnw768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8556ffa0a2eso86422939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739582103; x=1740186903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrf80u9RtiMg/ng1Q6nMNbwQnDmRPY8LCNmDN+G7pmA=;
        b=QcxFru8Zeow6u2/H12oSHPC3Q1dBrzYbYcqr/8Z35VBlzOLH7f4+RQwvTWf88vu5LD
         UGyiyC74PXaEWW7Fr5cyzd6CcOzCGzXFZ6f0v19cSkqdi/Hi1krHC+KTg9WUr2DLcesZ
         k5WAR6TduOFMhHdBKCaKAmQ0n/cQja2ptlMJ+u3+ceuEeHPTvh9p277YBSK2NfTwnEKx
         H35aimGNiOGiSOOs/fSMxI01wkb/rdHBi3Z1LkjhvvSeMP531R5beL+x9HMx4KnEraqG
         Zk7z6I8218Fga4QGILomh6bt1e/csJ17lwp+On7/6vUaCUEuZOtePadZEnTWMLn+/SMI
         Kykw==
X-Forwarded-Encrypted: i=1; AJvYcCXi4pLXkrWm2yIav/oVUEWY7nrwFzoEw1298oWgp3jVGugEbEbi6Bx4gASSF+1mmvTDNLXjQZK1m2Fa72o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCk/ht5xPeEr79uorLcmuEYFNgbNIqF0B6CzzhB5uhSbLQVv6
	GKDcBv9xO6HVDsU6TZhaWZdu2N7tSb3/Kkctm3aR1whwi6nggZ27t2GaX2Jey+meojXnWFIt5hn
	KUyxHu+iABSZwYMuNPKGSLZjx+8suLGYM5QVk+OQ3Ycb4HLlNaWj3C0Q=
X-Google-Smtp-Source: AGHT+IH2l+ss1a/isSoafGfmE0IeyzQGH4IS5Gg6RQGPlb+krLC/EE1vVc7NEX7gDrLNCA3nxjTjm0IflTiV0qYR/SzyxUVfm/4R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378e:b0:3d0:23f6:2eed with SMTP id
 e9e14a558f8ab-3d2807b0595mr9685325ab.11.1739582103635; Fri, 14 Feb 2025
 17:15:03 -0800 (PST)
Date: Fri, 14 Feb 2025 17:15:03 -0800
In-Reply-To: <72BB1BE7-6EBD-45DC-ACD5-B931F5C20E0C@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67afea97.050a0220.21dd3.005f.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in shmem_mapping
From: syzbot <syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com
Tested-by: syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com

Tested on:

commit:         df5d6180 Add linux-next specific files for 20250210
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13bd19a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cd616b6e736ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=012c6245eaea0e23f7f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a7a098580000

Note: testing is done by a robot and is best-effort only.

