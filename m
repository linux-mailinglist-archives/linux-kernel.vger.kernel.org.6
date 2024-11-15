Return-Path: <linux-kernel+bounces-410880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A9C9CEEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E8289031
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190A1D4613;
	Fri, 15 Nov 2024 15:21:43 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15D16F282
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684103; cv=none; b=uvAN6JMuqizGvFkOGSVjZjN5bY2ndfyUJ2l+xMqq1N6IRT5HaTGF0PcJDjd1LEN3bR9H6+SJ+Uh6S00YYtA6FNtmy0e+nRxb6sAjbM9FB9cNF7W0YwDV6D9PQxTlExNyeH9gqZ3BilkL9TmW4cED6QCo/Tm5h3Ch92j2MMVzmjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684103; c=relaxed/simple;
	bh=Lb0G9mdyHVtMwVgHI/O8f574sC+XbcQnuvGqZzDE0D0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QdXH4eYrgbQAnraoSZhF5OxhyGJdEkftqxNN0bd7+zfmcCnO52i+LDX2T4ub725qmzDqi8HkIOdOD3RjqODUGaaN3aencCLCazO+ll95NZzCv+6lTu43H69ZNYbk/ayK8P2nlOlUvAljR0YYXIlsPL24OerzgRXBmsgoRaihhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6c01d8df2so16968595ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684100; x=1732288900;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opHRQjrPsSovgnJtOEqG2C6LUU0u43OG3/mmNiSILaU=;
        b=py/evuVCjTLeup5YY7WwB3OnyD+HabCJ+6W1LnGhEVxeL5YUhxXRzaekiCqfdPbepV
         7QOc7lPo3W46Q6PPOENPbs/6KfNtypEPYyMIQKqZscVmko/wlOzL1jzHsigFXINbki15
         mVBEB3CQ+j1OjmNRjJjLCOD8b0Hn7K6H54mmbMwSj2DsSWoW7cnBuVbVbQqAFzCjNIpY
         yozulxPXJGSYbI0MK0aEWCpenem7oE1xt9hDgf2xD22iv8AxxRiqKh3+dZVWERWJWSAE
         6adnRgk746LnaYDsKcvyvl7BvyBt6z2a83Q1yLSTr6aM4ugEWyiLRnK/Z9W6xAjKeLee
         45AQ==
X-Gm-Message-State: AOJu0YyMfPipClztlEltW/+7czDlxRPicMwPmKaTUfV6jI0NBrmAyzUU
	GXoZAOebYKDKYBBNe4YqR1JZnYVYI3T1+rt7yY5EykmCAoFHVqfbGqP0v4fDBSJBuk8KwbARlOW
	bW90Y8QoBDMZ3LYXx8a8di5+zU5I8xYcOrkHNHVph1QhptC0Es0D7K6I=
X-Google-Smtp-Source: AGHT+IGGopq1tuTKIgcF6N95oMYKHBJzhnxroVnYP2Dpndx7u2JMe4EP6eCn0sHaCNw9fqNM/joQmHxYriWsGR61gJSc3QgkLzFs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:de10:0:b0:3a6:bafd:5650 with SMTP id
 e9e14a558f8ab-3a71dec4245mr82796145ab.10.1731684100125; Fri, 15 Nov 2024
 07:21:40 -0800 (PST)
Date: Fri, 15 Nov 2024 07:21:40 -0800
In-Reply-To: <000000000000736bd406151001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67376704.050a0220.3bcb1c.0000.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in __crc32c_le_base
From: syzbot <syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in __crc32c_le_base
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cfaaa7d010d1fc58f9717fcc8591201e741d2d49

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b11bfe68dd65..e0b515aa1c63 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -18,6 +18,9 @@
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
 #include <linux/unaligned.h>
+#ifdef CONFIG_KMSAN
+#include <linux/kmsan-checks.h>
+#endif
 #include <crypto/hash.h>
 #include "ctree.h"
 #include "disk-io.h"
@@ -93,6 +96,10 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 		num_pages = num_extent_pages(buf);
 	}
 
+#ifdef CONFIG_KMSAN
+	kmsan_unpoison_memory(kaddr + BTRFS_CSUM_SIZE,
+			      first_page_part - BTRFS_CSUM_SIZE);
+#endif
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    first_page_part - BTRFS_CSUM_SIZE);
 
@@ -104,6 +111,9 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 	 */
 	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
 		kaddr = folio_address(buf->folios[i]);
+#ifdef CONFIG_KMSAN
+		kmsan_unpoison_memory(kaddr, PAGE_SIZE);
+#endif
 		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);

