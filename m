Return-Path: <linux-kernel+bounces-363283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1199BFFF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C70B22DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED461428F1;
	Mon, 14 Oct 2024 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dJUFfBTP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709213D612
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887320; cv=none; b=G5iPaOldtbCV+IAUmNx9kho5TkcP7f93SS3IBdPJf80mtZwZoatWtz3xDQ0oz83wbS8K9JiyXPHN5YGboiwAuhgc8gnNl33P2+eHQMLuacypKmbEoWAQKB5+xHPqqpepn3ZzFuoxxuoGsmgRVMO0cNXXcvvK8ibPYHZJbxQfBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887320; c=relaxed/simple;
	bh=JRbKMPgirH46CupQL/GAC7oVLBzKdDbjv8YxLj+iEDc=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=NpWlVDWqMdn+xfw+Uw3TO8d/yWP8cYWdUHR5G85VvB7V/C85ot7/euxqdk1aRyk7/PTn+jVdwVDvlJ/lbAXkZV9fl7/RKpZAAK82ErgM1p4eHjIyInDJFKg83l3rI5AUmBrSKLh6bw6kGTWn2SMSte9SV32cGV3/1ZjFajOlKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dJUFfBTP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4305493bc6dso4739045e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728887316; x=1729492116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:to:content-language
         :references:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uCZZ9FjKZxV+PCdevd/aveQG1rMpN/Ld1gEuT/TvepM=;
        b=dJUFfBTPUkjufJOSr4QY8V2yX7slu6Omqrj77CnVNKurTxCrgfWn6do9UX3mPWxhWp
         3UCziU28Zu2O9C9r9tdTF5t0QFTT9qAsMiyabjLAsbytJOQDfEry8oqJ15oZn2U/tz73
         o6CrWBoLv/jLh0jOBxtfFgmw1fV9KoBW6gHLfkGoabFgxwKYTSynX3CuS6tAvy3eLjKz
         TF/cC0AO9oB4pY2E50H+yZX93G2RlEOdjfWv9ik3KcaZTLRQJXqMcyrj0yfpLY8tJc/C
         ukgU9UWSHqAxFZckqVkrYgu83AWsYHrQy6q+sDlCSbJl1p217QUV7lNjKFqojkQOcPWr
         5mHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728887316; x=1729492116;
        h=content-transfer-encoding:in-reply-to:from:cc:to:content-language
         :references:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCZZ9FjKZxV+PCdevd/aveQG1rMpN/Ld1gEuT/TvepM=;
        b=UsJP3vhAinj731pdm/zZrLUzVI/Ya6EkQRr1joSbd7QuWLlstsAaXBgAbxcTGx9sPn
         Y4mAtG6ttl/lrH1MkRk/GASMqY0TCbUBAuhflw1VwEA0phxlElpbGFreTqteGNP9xWeM
         aRUQLlVWY/fy7tc6LDvZCfCbhqF5euwVpwl9QhMaK5rjgEjCuo+g/0otREoU9FLQ7YRt
         8byz7IO51FJgthgjMkFqpF2PuPdw4J1F/EU+gH+R4pGXn9vaClslj7XL1RzaDqgWfcAb
         BPmNoZS2Az3anhw5uXP/q/y29m6522GK77D6oBbYMMlP0x0NeZbuD6VflRc87aCpCV7l
         Fh6A==
X-Forwarded-Encrypted: i=1; AJvYcCUkYRKP8b6obxQVqaJxtbR/nrO9BbEjeBp6ywSlMOho3OWnVmXCsilpko10NRVvXBw6Tu3N/ruWbaYTFI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1yLkswJNDT4n3O3ero9wXvy0OSlEe0ItXlx4yOcNR7WEXaow
	qG4iycaM4OW091KHXbL6s2+S/zAops4t4v1YGqgz2GDzoHEG/qGiEsN4sNMh97E=
X-Google-Smtp-Source: AGHT+IEu848ehJLCU+9MlmBbgfQ7bXntySu1ySCTvp51reyAcYKi/1I3dXjf8s97R3nTYr9PqeHH5Q==
X-Received: by 2002:a5d:5f88:0:b0:37d:54d0:1f0f with SMTP id ffacd0b85a97d-37d55198320mr3460853f8f.4.1728887316165;
        Sun, 13 Oct 2024 23:28:36 -0700 (PDT)
Received: from ?IPV6:2408:8409:2430:7301:d840:f615:51b4:40ae? ([2408:8409:2430:7301:d840:f615:51b4:40ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c35522fsm59294215ad.296.2024.10.13.23.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 23:28:35 -0700 (PDT)
Message-ID: <658bf0ce-9565-4b47-9043-a853374a74fa@suse.com>
Date: Mon, 14 Oct 2024 14:28:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V2] ocfs2: BUG is meaningless when the flags is 0
References: <tencent_9D4C78EA6D442CB56C2C97D4EB8EEC26CC0A@qq.com>
Content-Language: en-US
To: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, Edward Adam Davis <eadavis@qq.com>
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <tencent_9D4C78EA6D442CB56C2C97D4EB8EEC26CC0A@qq.com>
X-Forwarded-Message-Id: <tencent_9D4C78EA6D442CB56C2C97D4EB8EEC26CC0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Let syzbot test this patch first.
(Hope I used the right command to trigger the test.)

----
Syzbot reported a BUG in ocfs2_read_virt_blocks.
------------[ cut here ]------------
kernel BUG at fs/ocfs2/extent_map.c:971!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5221 Comm: syz-executor117 Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:ocfs2_read_virt_blocks+0xaa3/0xb20 fs/ocfs2/extent_map.c:971
Code: 8b 54 24 30 8b 4c 24 1c 4c 8b 44 24 38 45 89 e1 ff 74 24 48 e8 7e 0a 0c 00 48 83 c4 08 eb 25 e8 43 d2 34 08 e8 ee d1 0c fe 90 <0f> 0b e8 e6 d1 0c fe 4c 89 e8 45 89 e5 49 89 c4 e9 01 f7 ff ff e8
RSP: 0018:ffffc90002e2e820 EFLAGS: 00010293
RAX: ffffffff83881432 RBX: 0000000000000000 RCX: ffff88802d3e9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002e2e9f0 R08: ffffffff83880eae R09: 1ffffffff203781d
R10: dffffc0000000000 R11: fffffbfff203781e R12: ffff8880764d8878
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffff920005c5d18
FS:  000055557cd55380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005628fd41e058 CR3: 000000002d2e6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <TASK>
  ocfs2_read_dir_block+0x106/0x5c0 fs/ocfs2/dir.c:508
  ocfs2_find_dir_space_el fs/ocfs2/dir.c:3427 [inline]           // status = ocfs2_read_dir_block(dir, 0, &bh, 0);
  ocfs2_prepare_dir_for_insert+0x3f2/0x5c60 fs/ocfs2/dir.c:4274
  ocfs2_mknod+0xcaf/0x2b40 fs/ocfs2/namei.c:292
  ocfs2_create+0x1ab/0x480 fs/ocfs2/namei.c:672
  lookup_open fs/namei.c:3595 [inline]
  open_last_lookups fs/namei.c:3694 [inline]
  path_openat+0x1c03/0x3590 fs/namei.c:3930
  do_filp_open+0x235/0x490 fs/namei.c:3960
  do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
  do_sys_open fs/open.c:1430 [inline]
  __do_sys_openat fs/open.c:1446 [inline]
  __se_sys_openat fs/open.c:1441 [inline]
  __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

It is because the parameter v_block passed to ocfs2_read_virt_blocks() is 0,
nr is 1, and inode->i_size is 0, and flags are also 0.
In this path, v_block, flags, and nr are fixed values that are hard coded,
so if i_size is 0, the bug will be triggered.
Therefore, it is more meaningful to check if the flags contain the READHEAD
bit when their value is non-zero.

Reported-and-tested-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=797d4829dafe3f11dce7
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: keep rc to 0 when falgs contains READHEAD

  fs/ocfs2/extent_map.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

#syz test

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index f7672472fa82..0043c2428ef2 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -968,7 +968,8 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
  
  	if (((v_block + nr - 1) << inode->i_sb->s_blocksize_bits) >=
  	    i_size_read(inode)) {
-		BUG_ON(!(flags & OCFS2_BH_READAHEAD));
+		BUG_ON(flags && !(flags & OCFS2_BH_READAHEAD));
+		rc = flags ? 0 : -EIO;
  		goto out;
  	}
  
-- 
2.43.0



