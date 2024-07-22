Return-Path: <linux-kernel+bounces-258871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E448938D88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5EF1F21B59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2D16B39E;
	Mon, 22 Jul 2024 10:31:17 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9093234
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644277; cv=none; b=n9Rz4Kue7f7TAqpM/+xorBPi4dWSCuYYNTnXJpFrR4PNjLAYmB9HQsRORUQ2GicYF1JUN1VVVLaB1MgkNRjPRla08kmlQZV/n7O4X4k9GXsI8qtMASHgrp0Y1nfQTL8zcKHbGqMBex8WqNOLipj2252ujkMteV+DPATXAKE2vns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644277; c=relaxed/simple;
	bh=tB9IYwOIvf0KVBikfDFuyKWQ1q4iL92fhsUzCnQ824k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=il356CLqFIU2uXKyQ4UiigPDKHjUY8n1w8KiQKpQ4E+2l0i2k9wqBnobcnxSEYWsJOLBg9mzQL5RB3tI5y5674qYenuRS+rxigdBzUqLMDDGmaCorFmV4cyQ7Zy+t48Cv7U4AzmIxLwB5wdRE10RKEHn3FbSUV6O7p08bx7pfQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-80ba1cbd94eso737187839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721644275; x=1722249075;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rxad1YeeAWbzbQcxPSJ1/CdGoGaEezJkjYOmFEsMKM=;
        b=IKHapoozooYLNrabmokyjmKXZpxWNAxxz/obot+zPbUB6fLWK4Ing2sqBJFOQ4eCDV
         TXd7wiJcoz/wtcb1dy/1/s9cI4VXiIBz+v3Vls03K9fK5iRfEyMyYOc9R5RGdhkG/hjO
         BV0YuDOgPYs5Q/Lr6AGt+UZ90XqZNKvtZR8nddrK0VkU/0IyrVZS2GseZEx2Cg9IOqL4
         4Dg4nDFodqowF//HyhrIlOtaux3SZlJpJLp+aZdTv7f9BVxCzS+dbhAFXlPFAv9QcVj+
         BmzWPPI4x/Wmx2kOmdzNJdU1ijYJVkBvyDibEEIrl8W10zLJ/DLxZEPYO1V9lICals3S
         aeVQ==
X-Gm-Message-State: AOJu0YwDl2URjPJKYvjj+oaffBYt8c0V+E3/02T03tLZ5iFPNwPixN5P
	0K9Dv2E4gyuzpJJUi+j7oun6fJrX+MeAZ928cOfk4zpBcexFC6QyRHc90zRa9KyxczMxX/dDPpH
	vQ5KBRCIkP4j/lZ3XmvUKLONcNZ14pAveTQlXeuZ6u/4JlgJS+LjPrQ8=
X-Google-Smtp-Source: AGHT+IHxGn5ANRBb3z+jAj2cTC6oxIcRBZUhX4JNkrgp1gQdn3vWRLUTOXHlXgVGgCzwIfiGwjuDcOfzpsB1cGmGpA2gLhxT33c9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8323:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4c23fe4901bmr515565173.6.1721644275001; Mon, 22 Jul 2024
 03:31:15 -0700 (PDT)
Date: Mon, 22 Jul 2024 03:31:14 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070ff46061dd38b75@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 include/linux/filter.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b6672ff61407..22691015d175 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -842,15 +842,15 @@ static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head **lh_ma
 	if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
 		return;
 
-	lh = &bpf_net_ctx->dev_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->dev_map_flush_list);
 	if (kern_flags & BPF_RI_F_DEV_MAP_INIT && !list_empty(lh))
 		*lh_dev = lh;
 
-	lh = &bpf_net_ctx->cpu_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->cpu_map_flush_list);
 	if (kern_flags & BPF_RI_F_CPU_MAP_INIT && !list_empty(lh))
 		*lh_map = lh;
 
-	lh = &bpf_net_ctx->xskmap_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->xskmap_map_flush_list);
 	if (IS_ENABLED(CONFIG_XDP_SOCKETS) &&
 	    kern_flags & BPF_RI_F_XSK_MAP_INIT && !list_empty(lh))
 		*lh_xsk = lh;
--

