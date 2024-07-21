Return-Path: <linux-kernel+bounces-258235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116E938557
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3781C2082B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F316848B;
	Sun, 21 Jul 2024 15:47:47 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AE8F5B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721576867; cv=none; b=Le9g9TmYA4QgDJOzXqMiyqqBwoHgOtlKQ+sgckFAVOUPxnWNr1FTLEsdvR1Oz5y47zKDceYgiBOGWqFcd9D2mshsgXVlFffN9eRk6L6E6EUmRwiEzQdrb8mBtDon6lLB3YQ+nkr0G+Sv9pwVBH9hRJM0LLaRmNG8pt74xP2tvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721576867; c=relaxed/simple;
	bh=C9YJsyvrUyYNdBiqOGd8hcZB/6cZChpiNSKrPwZ8/gM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sfPRUkfmMr0p/oW8KTi93eyEQLETz5n84Be+bpyZMO5UYVZlGJGPBAtda3miqc5yx+l+V+gOBcDlGscAl70NfRP41Lz2kTK+7o71j3jjoivKEO/VU4ldOicxkJRxEUaxY1LTZDZGzFz7eGtf3NvxDI9NGpI21Rt5yBPGKHJf6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-80ae24094f8so575290239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721576864; x=1722181664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHJ8G1ZFmyYIEYdyzBzqOr+p5pbIPQqoawPCazoJOIs=;
        b=ky2n2yfQICAA3kA4yUXPYxCKsnkxOWOwzfJzq92n5cC1CrEw9b8uRgyKCR3fpvkc0R
         6eC0Y3xuPxN4wU8f8/QydSukNiw9ymLDMXS7cPFCR9DZBw6T0MgfdCuB3i+vrRccnXZx
         72z75vRJjQixMfTmTTM16U09skWJe5aBcoNyAo5Se6Fqpn+jobWjzoS24f/IO3SNeAFn
         hC/V+9mwrdyMAcHfFq1PI+ZgqbGhXSJ8XUh1QExesDure22cb1eovO24YY0Fp6sEfAZr
         kpFWzarfWa0PXpR+1TaB6bXQl8YuznOWbaXCBx3ZeF37D0GWaaEPDWoTfFt0fFBC/FqI
         qF3A==
X-Gm-Message-State: AOJu0YxjbX3lfzA6dDi7zx5SLwBQYyPBvwY8PDl2aTxq3OWJRnMcw7kn
	tB4VaVMm9siY7p4RwnFu2JVl2MNp6Vi0cJtT3bqcs93CixasUQWzQ5XdVpXBCTeMBRm05P1ouo5
	qVjRGvhHs4pEZJCyD6WtOUay1O46YzAx8jV2/gIUnSCXOHdqelbsQXsc=
X-Google-Smtp-Source: AGHT+IHOhdfqsJck4IiQgR8wUuhdfsK/sa7tZ81Wu0amYUI1XxUoQhTa0JKEpW5chSBtbQKndTpRXzVxPJV62UZQsvYGRUVw/AXW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8410:b0:4b9:eee6:40d with SMTP id
 8926c6da1cb9f-4c23fe04aa9mr304785173.4.1721576864659; Sun, 21 Jul 2024
 08:47:44 -0700 (PDT)
Date: Sun, 21 Jul 2024 08:47:44 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078c94d061dc3d97c@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free
 Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git upstream

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

