Return-Path: <linux-kernel+bounces-258144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0B93845E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 12:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FBB1C2098D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 10:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C55FB9C;
	Sun, 21 Jul 2024 10:45:19 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFB1429A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721558718; cv=none; b=Cr5P5UJb3PyvF33tEbr+l8jXcCWkEtnlUpoobDcOxxSEXVUvLvq4XP0U2Rp1GKWoNRSqDk8GsZGwle6hv1jRe0f8O4cDVrvKH40/em5I+eAwoB4LQ1cKrLqYhnjpN4R7kbLVP532dplnUxmssFU2nAuOuQmQGkAAFbVXtGcRnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721558718; c=relaxed/simple;
	bh=GOEFmI/S8Uj0Ov65Vixl8DR7ws9zddtNmYt/C8uHuVg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pn0swaizqHLt98Z9N5on4qbmOltKugSlhMYSqtydmHPVfKotI7Pi5aIfln0QkjsGjSR8Pd9YHtkJjxi5r+0VkNCc+LzumGFAZbOQgTQPxhFY1hEEjXQXzLd49J94tzS8PnXyImG4EyLHmYKZ1QVKPeZBR6dC9d0m1N2fJ7uCaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8041a66f2ebso515421539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 03:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721558716; x=1722163516;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AESplfQUZHCNIC5YyfVm3dVd8eYKKisVDs0MRYDnBZs=;
        b=mwJI6N0fl35Dztrv2qnKEEBWGnYwHRrQTLrn7HKy6YvzL0IGts8WuVn6nrQNpvpAlx
         xznb+K8K6If481vEo2KC/P6bXeneFltN87lRIvn68FGWDEJvBf2t3Ro2SBoU/5DRjX8R
         KMfNy2mGjF1w+qyvzq+T7xV+Dt0lMSOeAP9OGS4WIrd/3abO3Bl2vF3cw/9UDWS8ZN5C
         O5DfF/ppZg89hItVryI49w+Oz0C3619FMopxPWYtyQeebRimu57VmPd3/mmi4LzBDwWv
         UY4+YzD7F4ju6HLQzWSWYlBpFXzLkN7tuYAAq3zTwYX9VTQcmLcyROZ313b3RSatsEea
         nikg==
X-Gm-Message-State: AOJu0YwyV6+dZ/oJsltinBjoeEwmwE7FYvzsL+77NAhgJZyuE3iRg/Al
	DTx1NDK80o3mneL/qiPBU9Tmnwd0rPkombq3rpT0l+aTenHtG5jZCbp1A0GB9fM7hFNycjdWe2E
	7NUX1mWTVdOLOZ8+SAu78EERoucciRkJWdSuZc00AkAe5Kg8o9Y/mgZE=
X-Google-Smtp-Source: AGHT+IEE10DeKQeW1x4grKxLqfaPNgjO4gKD6qus5Ewudug2GVeNPtOATxiY2nomj2khaAdLlR1cXe2wr0vMM7NJwZ3KGXsCI+0d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4091:b0:4c1:4388:46bb with SMTP id
 8926c6da1cb9f-4c23fb56fc9mr343543173.0.1721558716393; Sun, 21 Jul 2024
 03:45:16 -0700 (PDT)
Date: Sun, 21 Jul 2024 03:45:16 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c038ee061dbf9f22@google.com>
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
 kernel/bpf/devmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9e0e3b0a18e4..bca00badc0f8 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -465,7 +465,7 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	 * Do the same with xdp_prog and flush_list since these fields
 	 * are only ever modified together.
 	 */
-	if (!bq->dev_rx) {
+	if (!bq->dev_rx && bq->count <= DEV_MAP_BULK_SIZE) {
 		struct list_head *flush_list = bpf_net_ctx_get_dev_flush_list();
 
 		bq->dev_rx = dev_rx;
--

