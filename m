Return-Path: <linux-kernel+bounces-258213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13893850E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868541F224D8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8E166308;
	Sun, 21 Jul 2024 14:44:16 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834C8F66
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721573055; cv=none; b=o6GU5PjL/SWkTqrtgcFHhIYGaGjpB+jtq3bcmyLafOhbl0Qfs7WUQb2ZBhliV7poPEormCUp802Bm6h6xN3JJXnbL4wAh+QY8D4uxl7lFVGivEcStH3S85qdQW9kbxRCm9VIZJy8vzyQrj4rJQISiTt8Cr1kaPzAHxG2I9n9y7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721573055; c=relaxed/simple;
	bh=AhgsfNzCNBk5RRiC24hJSXrOYelvEEpJEh3HYO7is1g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RtLx1qRs55ytegRTftLj39kbGcBtOzSH2iBllnfSwwahEs2ejI7S3qDo+K4RHolLUCorgx/D7qcnAtRCLALmaRCAREhG8tddaZC1RuUfGVuX29fjqzUyehKBB+8pX2DSp64Mr6NFOAlslYSZNi24cJhg1hADTML2iNNGZO6STMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8045e14c387so737397439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 07:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721573053; x=1722177853;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mLe0bdQgM23BiMtq0NAyvfIOzmDsJmXBKYteAwRaKU=;
        b=T+1E6qhKlZ+dAzqvkgNK0fbW4ntWOHKibKw4R7LCmrJeur8+XgQzVpy01r8tJTHw+g
         PZe4dtCJqqiH6bPVZbTGuDsFIy+9Wtc9cOvyV/a5PgftvcMwggNkDiEejZUq0awDeRqe
         gu4FEQxygiMrmw4voHvLAPZlyLG2kESRUK3WBl49mrbJkNrziVLtxgKsY/FKCF7thd1M
         7Enhz7NE4Hm7zbWL2y1mnia5/9oj647Ua7wpUcdBtuwyYMLD+occYR8yCuUlPIPRr3+H
         0xCbfF/hCpUzFhmPKInnl/ePt4+SrUJez5rwPsm3SdnTBHbz3aGkhodk3XuDfVOEA58/
         DHPQ==
X-Gm-Message-State: AOJu0YwcXYREnyrS0mTspBqEp20gS+W1yIOVWqZ6/AB6rTHFEEYziMr1
	BlBsmWN//vyZCQrJs8P31l0BHDKYahSr68K77J0cqb4+bDnmFIyFGkSYmDU1I0r0iCoGVMjXZDM
	lgjjQDa8ZctA4pPNZbjYfu0PdnoiZr3Si7Ho1+/zim4mpSIxmkeZDwF8=
X-Google-Smtp-Source: AGHT+IE0MDmhkYENCstt90DhxFqtOv1KhVlI1qu8Fv5mWnK3A5qFHlHGWxoOahReh78ZYU2BBFaflYxDF9gGkZ9c8yJ6wKtTOjEF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:850d:b0:4c1:b049:25f with SMTP id
 8926c6da1cb9f-4c23fd618eemr396507173.1.1721573053579; Sun, 21 Jul 2024
 07:44:13 -0700 (PDT)
Date: Sun, 21 Jul 2024 07:44:13 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050517b061dc2f665@google.com>
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

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 kernel/bpf/cpumap.c | 6 ++----
 kernel/bpf/devmap.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8fccc311397c..22e1c62fc0f4 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -708,6 +708,7 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
 static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 {
 	struct xdp_bulk_queue *bq = this_cpu_ptr(rcpu->bulkq);
+	struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
 
 	if (unlikely(bq->count == CPU_MAP_BULK_SIZE))
 		bq_flush_to_queue(bq);
@@ -723,11 +724,8 @@ static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 	 */
 	bq->q[bq->count++] = xdpf;
 
-	if (!bq->flush_node.prev) {
-		struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
-
+	if (!bq->flush_node.prev)
 		list_add(&bq->flush_node, flush_list);
-	}
 }
 
 int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 4b9203deb711..dfde65014374 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -454,6 +454,7 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
 	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
+	struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
 
 	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
 		bq_xmit_all(bq, 0);
@@ -466,8 +467,6 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	 * are only ever modified together.
 	 */
 	if (!bq->dev_rx) {
-		struct list_head *flush_list = bpf_net_ctx_get_dev_flush_list();
-
 		bq->dev_rx = dev_rx;
 		bq->xdp_prog = xdp_prog;
 		list_add(&bq->flush_node, flush_list);
--

