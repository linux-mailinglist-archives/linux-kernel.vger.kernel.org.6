Return-Path: <linux-kernel+bounces-258154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80958938474
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310A6281391
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFC2148FE5;
	Sun, 21 Jul 2024 11:37:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE53FE4
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721561829; cv=none; b=OA9/k8LYdgb6QTc4unYXwrUPfEJj9y7jvS/U9O8NcW7AM0DLP3sFp4ZNz0WqBh5kYvHgcsk7k4+actN3pBduFFOt09KDhdOFpOHOCakx2B5UPFpnEQGP6WN1snWMnDSxg4nAKbC7U5DeNcYkFJRAU+ElCNyFdUqP16sp3P76b7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721561829; c=relaxed/simple;
	bh=CaKoYVXrxQ+9JPAcdKGaqOY52AKDN7sVoCePwisbqmg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pzEKZgjWJgb2zvdXNZz31kWRee6eCCcp12lRb1oxz/byOtIZu6ZBy7CU6BH9mNrHBfaIxreZN6P8n9kdVEry62vq0svyhqOOK30Ber9I25cCjpoBMMBGlpRNB6m6W4CbF0odSi8PQ2XZYc6DUXf3QRNTQle3jDNvYSeApt2t7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f92912a614so576690639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721561827; x=1722166627;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fURXluOxv6X6hFtzsft1gPRQ0VYCqvZKzvY0qAYYfYY=;
        b=Rk/tQKnFqUebRhBXuKqoxT9wFzCAQAZDj+ZWB+mv4AvnM3OV0pS3M7BSQHYGMbdJqH
         +XsUqHAbEr2zFDGhLWDMBTeKqQgQCNsUPOJ/YN/3NmoZOamCmg9Cnu8h4GGGIXKB9gsm
         2gxdcKCVB5L58fB3lVu+RoenaB38/VgPh3HuzKgHzc6rvdt8hUHhh49p+/B70Qq03JQz
         aR1D2m89YGlQj1VP4Rzcw+K9t8WrwSb2DKh/YYNwaQJ7S5kaOGWGSHfcVRTw9yGp1Ltj
         TfQFdoq6nHJLMKSkS6i8p0jambXI9yT4c19uLNpLP7DHXq+BMqhgEXJpnOz7pCbNas5N
         x2EA==
X-Gm-Message-State: AOJu0YwXne3fjxVWh/jJfvVjkdQ7wf5uPkr4mu4Vs8B9lGQnRk4QojQi
	Kd0xQtCvd4eRtkcKAdw0LyaIP4479qqayZvP11yujYv3Ovp6TrpHYHGRstBQXzlFHf5Xrx7Wl3m
	8x7BMBRhodU3KPY4clbdBUwkmpfsHq3xR3ka/7qDhNRjtJjQHoakQFEY=
X-Google-Smtp-Source: AGHT+IGWsGriXBwxljaIWPj7KlMuHarpvfzZrSAHx3ynn2UGjAOBIzebiPRHa0lZHJ2QCRLDpVZqLBlGAFfTLpUVFj07gfXrOG6Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-398e17ab520mr5363425ab.0.1721561827357; Sun, 21 Jul 2024
 04:37:07 -0700 (PDT)
Date: Sun, 21 Jul 2024 04:37:07 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002dc731061dc0595d@google.com>
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
 kernel/bpf/devmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9e0e3b0a18e4..5e2ee97ad09f 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -378,7 +378,9 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	int to_send = cnt;
 	int i;
 
-	if (unlikely(!cnt))
+	printk(KERN_INFO "bq->count = %u\n",cnt);
+
+	if (unlikely(!cnt) || unlikely(cnt) > DEV_MAP_BULK_SIZE)
 		return;
 
 	for (i = 0; i < cnt; i++) {
--

