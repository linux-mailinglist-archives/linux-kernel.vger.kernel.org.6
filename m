Return-Path: <linux-kernel+bounces-258174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D219384B6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42685280F29
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1955161914;
	Sun, 21 Jul 2024 13:29:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3078F58
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721568546; cv=none; b=XaJQFn+7pUFY5QKO6nPHUexScpM6llwHuKlpE08HEoc9UqITAbP67TpmasdTp7spN7EzeRNnGweQRD19Nn5c2bFC1Njax1zg37EHQOhqOsdqB10QDKK/qv92XL47A/5JQSdUs3VkgKaTOPmGXakKgC0DTZSHE7B9vFPcnVxLTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721568546; c=relaxed/simple;
	bh=itEAccEHu9FGANKvY0tCmqaqFFCyvqvmpZ2dxIQ6eWY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iHlLlYPFVSEcdcDby1+dz2ittZUmxB2YWmNUoi22OHP8scGv6DMc4LtiMH1fFV+GfIrNyYgsynnWYi98HQIkVfnnoT8TlIVBJ7FNrrN9VNlWHpR/NW4AQCUAQ7mawinxeqcUAuC4gji1Cx/MTfXb3DN0kwGeyJ4dYkQvW5kTt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-396c41de481so53736135ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 06:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721568544; x=1722173344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P6Ux8igmJICmLyt1pfF4NBTtcQ+TdZWLBjL3VP03aY=;
        b=Pi4D2kIHGCHlk2pnhes3nVg4ig27IZWU1C2sgOkMWrjddIeSlq/V6GkUI0HghN2425
         WsCeqoPWYhbIjvs66iav0giwp06bDT9IjubjPRPqKC9oxPbVHOD+N/E2hc2CjFcBq3Mr
         cLyHRDD8Jshkr+Nkzn9i/H5qSgLOHgYWKjw/E6Xq8eOIopHdcWwBEvPj1i9ulTenfw1K
         OtmUsKGhUmUPmg47Bd87d78fwWGfNbh/LFYgutYxeS/7VeKaeyK0ah2EZKYpHDwc4MIj
         uKch64IhG2ztomJnQoNPMB5C7Vdx5TY7hRItQwfzWJXIrWVoeCUq7lNkEFNfeajxK6yX
         HQYg==
X-Gm-Message-State: AOJu0Ywobf0Mjerp2XBMQ4ytq2mbctCBEpGr3y028ptgnyqDdvK31OO9
	MqegoGap7nfZe2HCPuraBbiTBUvxe6Fb2rKKpXWkTZcwjGjwA3TzyzkWuQ9QwBweb5te7uLg/nO
	+fGn4+iTvKkrD42RS4FOGuT7t+xcE5BnaGpkgXXKUGf6PvJzmnegrwBI=
X-Google-Smtp-Source: AGHT+IEBcdEuJDYzsXBfOnE5ALE97p4Fq5HlnKvsKOPeapSnR3WpiIrgmgaPzTbXAWy3xA8M0suKrXI1PaAAlR5Dhpz4zTmr8Rmm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-398e1995fe7mr2943765ab.0.1721568543998; Sun, 21 Jul 2024
 06:29:03 -0700 (PDT)
Date: Sun, 21 Jul 2024 06:29:03 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000859970061dc1e9b7@google.com>
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
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index fbdf5a1aabfe..8fccc311397c 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -676,7 +676,7 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
 	struct ptr_ring *q;
 	int i;
 
-	if (unlikely(!bq->count))
+	if (unlikely(!bq->count) || unlikely(bq->count) > CPU_MAP_BULK_SIZE)
 		return;
 
 	q = rcpu->queue;
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9e0e3b0a18e4..4b9203deb711 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -378,7 +378,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	int to_send = cnt;
 	int i;
 
-	if (unlikely(!cnt))
+	if (unlikely(!cnt) || unlikely(cnt) > DEV_MAP_BULK_SIZE)
 		return;
 
 	for (i = 0; i < cnt; i++) {
--

