Return-Path: <linux-kernel+bounces-258904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EF938E24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2CCB214E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D0F16CD31;
	Mon, 22 Jul 2024 11:40:42 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8617597
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648442; cv=none; b=Ka7m6OGOchAITA7/TPq0eEkfkF4hCC/A++lsRSBcy3l5P16PVKWgQzdMrFU4gsDyv5dllzQ/j9ZJHrrmc4AXh+84oXx8opRqMhEVmW1CXSHpcFPC1ll5QZHyMsDg7O52u36JZEPG3yf8spl+qzpTOMwTkp9Vo3+O/cZ3hM1P2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648442; c=relaxed/simple;
	bh=XcCS0t/NCepEBg34EMJfxW9WkiOyTn1ocn+BRBvY2FU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NUcLWY2ZovTAEYjY/02imtPuEaURva5Ksqs0A1Y4sgS+Ud5fR4p/7Btky8J4VckHDaghovMycbxxVSd2uADFq8B52//L1Avx3kq5X2UUSpqu7kD7bjqAqgrIH1Vxe7j0fOz9HW6BdIVbR3zUowy00ZZH9KEU1OfrA12rGpaRhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-803aad60527so678691539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721648440; x=1722253240;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2wxXXiPEQlTRFGH0mSk2E1ShgijLlffjgmbmxdv3qA=;
        b=lr7rjA1tqBWNLvjX63dRKCuyDpbu7EfE83JaDFx0PswroFuyVhp5GOv+O0C0qSz4nx
         TXoG1W9gS9mATbSTlLu4dWUlIgMr0NwN+SjCKyVlVJa9rmNffv95lfff/5HiX+LhB9So
         cam6zEx7srOiUFhHUvsGpwX0oVNptCW9cYOzKUNhnrGKT9frqR09nRt2+JitBbDX47rK
         i5iIxicclyAnwBLl15k/iBmfFOVMSfLWGuV77MumYZrpXZXMTWxBAV/qbZ/+/a1a/7gO
         PlozuAx8gaRvq9liTdb85+TV5erVqlOHHdA+ms6ka/5C0dA9qxzo+8+oVNMtcN5oLzv4
         /fZA==
X-Gm-Message-State: AOJu0YwJm22WgElRQhAqXFtTUCCbY0buiM/ClPc0GhMCuIsbFuw9TilZ
	5uG3y7UuicwjOsbLAINkswUhtB3wMJGzjW14Bf+jZOEEz98oga5rGMMjrGYVjjyuLutirhTwLcQ
	/YbhTHUIYDaicvm/Td8dFkt9bCWsVzTYyR7qMjjwyxRVrThqzknUWIOo=
X-Google-Smtp-Source: AGHT+IH1DWGx/CFNnr/61RgX9m4b0i7ybFIOl6wHFY0716Ubs6ablDQRl3DZgOkS2mNd7qp41vT4GVUkNXK3RtlXpZSSbFZ3n3Fp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:9812:0:b0:804:bfc0:382e with SMTP id
 ca18e2360f4ac-81aa7cf6b47mr6529139f.4.1721648440375; Mon, 22 Jul 2024
 04:40:40 -0700 (PDT)
Date: Mon, 22 Jul 2024 04:40:40 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b790b7061dd48352@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7846b618e0a4c3e08888099d1d4512722b39ca99

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

