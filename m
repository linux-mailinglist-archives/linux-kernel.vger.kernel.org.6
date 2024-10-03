Return-Path: <linux-kernel+bounces-349403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5E98F56A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575ED1C21BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB71A7AF1;
	Thu,  3 Oct 2024 17:39:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F91A265D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977169; cv=none; b=ZJ32LHBSBiMCtb7eyR/wXhQaFSVVi5nVcFp33Vlo+NcZaZ1r+x27nToOst7OwojQ5LX0u1DyVajxhglvybkxXH++7YcHqNPb0XlvEgnwc8tgPOXg6LQfaaZJrL7L//271zP/nrpmPuWVfDBXrwsUCn3z2oYOwQF3eYBiM9klUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977169; c=relaxed/simple;
	bh=uyC3vD4im6hVbwzLHlrdi6w/qz7FpFYRjdeZbvscZ0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rvpri50qIcrWTyulUc4ZUXziziwbu6ptxfznpixBiT2cqcrPBhhfWrZjaOYPeL8kDRcQKpt0XVmpte6ME4zZlDn4nSTYX+Kq+vTZlG9OgxSXFYCgGzPHRZI33A4OERHdK1V8nmsNVNdh4N7FJyLZE6zQFqYMIv8OcHzSrMLK0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a345a02c23so12752415ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 10:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727977167; x=1728581967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tbyr+x7ErsCxUxYFKLEm4q/vWaL1bqP++u3lXWNfSBI=;
        b=VPtz/unOzKMuNMBiXs8Z00W0zCR1MUqwdO745sWsBpuHll3NpBWqMLO9omeyJjjC/K
         AKC3CCK8T/btQznjJZJFbhytE2I50K5Eh9PSX1a0YQtsajMXlZbwxzenqz3dsoN6OrQx
         2qIKELvAQFGgyMR50W7XJqIzpeSfWKrDRsc1ulaDENpi34KPP/kcuJfz8B+WudHuPsze
         RIMiVFJ0l2o3tYza1+znmuui0eMq48sBUlTI6jhAd3VDu9Gs/GjI0TyGFczqxZziLoKr
         cBdo/c+w/rhk6M2dctCj1J9rI560bf+U6S7OzzOApOHVGTzRPIS9/BW2y4eyFHyPVpsz
         HNjw==
X-Gm-Message-State: AOJu0YxJv/p9PJ3Nd9zUehbuUs4/0r43JW8tAohZw1fma2wi6aioeJM3
	LYBG9swSIGbcvk50XXoS/uWFmyKjPMO9gAABWnB1TXgc7UACDuMFMl+iTwo+whdEJezXApH9wEv
	v+rK4gJDbMPK777zQ6mzww7EcrUTBBPdqyKVmjVI38E4vMQXYUZdGP/M=
X-Google-Smtp-Source: AGHT+IFvZjUPswoJSplRfZ23zLZBK5F8P2sIMbqakkQj+Yduii7244fuwsJS03IBkORN1BqUpReQMa8e9iQcjkanojqZ9GpuIv2e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:3a3:449b:597b with SMTP id
 e9e14a558f8ab-3a3659445b1mr73582775ab.18.1727977167145; Thu, 03 Oct 2024
 10:39:27 -0700 (PDT)
Date: Thu, 03 Oct 2024 10:39:27 -0700
In-Reply-To: <66fec2e2.050a0220.9ec68.0046.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fed6cf.050a0220.9ec68.0050.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [can?] WARNING: refcount bug in sk_skb_reason_drop
From: syzbot <syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [can?] WARNING: refcount bug in sk_skb_reason_drop
Author: dmantipov@yandex.ru

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7ec462100ef9142344ddbf86f2c3008b97acddbe 

From eb58509f460225df7cf181a07772d577a270091b Mon Sep 17 00:00:00 2001
From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Thu, 3 Oct 2024 20:24:12 +0300
Subject: [PATCH] can: fix skb reference counting in j1939_session_new()

Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
new skb, I assume that the same should be done for an initial one
in 'j1939_session_new()' just to avoid refcount underflow.

Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/can/j1939/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 319f47df3330..fecee36dbb70 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1505,7 +1505,8 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
+	/* Take an extra ref just like in j1939_session_skb_queue(). */
+	skb_queue_tail(&session->skb_queue, skb_get(skb));
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
-- 
2.46.2


