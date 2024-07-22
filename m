Return-Path: <linux-kernel+bounces-259189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFD93925C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1445B1C216B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4B16EB44;
	Mon, 22 Jul 2024 16:12:48 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16F8F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664767; cv=none; b=HL3BGSjfKSREWr8S2qMQgrWdNSjCQgrN42gQaWn6VzrvvW1cAJC44arEyRNjhuxdRD6My9DCpdKa88MlSp/RBBrmeYRve7LmV5HcY3Ya2hU7MQKLLYt2fRqvwliN2t6rmrW9zxv7L7cubne6pSvZVEgD+vaw3XT3gwzN4AFBskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664767; c=relaxed/simple;
	bh=raWnl5yd/WoJDjEVHG2f1oJYeWREY9V4eS0WpJDr6Xc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MySjb3V4hhrG0RqyPiVtCug9OdGuE9/UkwbVi8gPcdClqt6KBHMqrgFk19xauBYvRpYZCYTn4FojJtFhIoodPJRG+wWFTLctx2+V0meYy05hHnz5NStftNW/fLpnk3hRSG/igo96zY0CdDtktxm9BGp1Hm3lqFhETQqD3hqvd+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-80ba1cbd94eso786137539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721664765; x=1722269565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwP8JDD+wLN0+te14QljZ4JWGndpfzGPPVNtJMbttm4=;
        b=MAyI0wWJ/FWFLOr9J/qfdplu1B93jikDeSG4yjpSVp4nxwbq1b22MGYE+D9dS2nFZw
         5sxJ/GU2XL5SLLBgfb2FctLG55LJqz/I2zJIvpM16c7JJCfBE03DRVorYaUlzr+mcql1
         XJJ1Tu2751qYkN8OavJwdQwR7p1USJKnxXu5oaYqMt2xCnLNo0yn21Q/Tr5eQuh819Xz
         JI7h/4DuLSsHSJ9fKQCHEFXg0FUOaEmLlbmqL1IF/hOkd4/HQW9y0W8DxJRBNUg9I/Cn
         DnerjjIVfVBgE9r+6Jwpj/HeA6c3/z8U5OUMgsH7y4QyYokGuvrY25N4mG8pelEyGBXT
         OMIg==
X-Gm-Message-State: AOJu0YzUT+DKuvl7/6n0RA1TAhz6X8Igga+WUiwXyb9zqvwlIYt5FFNm
	QFVkVvnli4asxhDhGTp3czPq2Vd/PHQr8UvLHfbGxM+SD/jq3slrMeZigVAhBsrZK7eU893sU3/
	02wVGlrYKfj3BG7+rlEup4yvCd8PjttluZYd6LfEQsRNOyFqdeh2pVhg=
X-Google-Smtp-Source: AGHT+IE40z6OcrEQdRpo89bNvhBcItHkTj7K3xRrYuvpwPC3haBbC834g85NQw89WNHYHQmHJAXYwb6SMDITkQpURm5dxOtp1tgU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:381:7405:7887 with SMTP id
 e9e14a558f8ab-398e49e04a1mr5230985ab.2.1721664765251; Mon, 22 Jul 2024
 09:12:45 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:12:45 -0700
In-Reply-To: <000000000000e8fcab061d53308f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c16969061dd85071@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
From: syzbot <syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 kernel/bpf/cpumap.c    | 2 +-
 kernel/bpf/devmap.c    | 2 +-
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

