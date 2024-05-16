Return-Path: <linux-kernel+bounces-181263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7468C79B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF652847CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C3714D449;
	Thu, 16 May 2024 15:49:17 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC137143895
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874557; cv=none; b=c24+R/qivvayQn3bIeyV/0p9dvcOcfMVyE5VdZLCNTZ1YVh5X2Cpj+kPooxJp5cjytsZ2EBHBiGFfvZqbpz5/8G6Rs777mlIYqsZVFbbfHDszpuMP5xkReOJYeQQj5pb2zz9XSezHppJSEB6aL3/BCmOOG2pH2wzSZfCLACgkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874557; c=relaxed/simple;
	bh=xFcKxnrqOdZ6PUt0MN/5m5P3hjOllGJtNyi6Y3cFKPo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j1wrrd6W6McM7OQXtWmsf9jTEJb02GrVxJD/WQpPZtejBUKLjN3yZMnKsde3o2NJ5xwnTvQc3lyacoOqPdjDwOKS7rvCtTfj7TkGkQri40T1T9Li8zzKAGbq5kFzeTsFG4ghxMDdF81/6nLeak2yI0h9Lwxy5IDloR/Z6BDiUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so869480239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874555; x=1716479355;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzybynlll8aTlRUTGkiirdKXhhmo+chE7YKKEdoW2Dg=;
        b=YrOmzvLu1s8CVthmivt/TIZPdXWLHlevUY4oaLdeBNCjIyqesqahRB6KuJfZ5MvxmM
         KMUfze4l8EWFSk7todapLvwOCHV/D5s2e8bxupSKxsN8bJ4CI2/eQrx+YOz7a8hKwE6d
         oYldUFupNEmKRv39AQjXMLVXv+KUg0KINapEpXwLdG/s3p+2+8JFwF4kqEBHb7zo6/or
         vvQaSytNpcudOAWnrJcH1TF0KmNmC5gQhnLca2aocV662YsM7YjmF6MaYQf9Kgaq8PES
         vT/4wwSLdw8iCev2P18WRUhCX7b9hKRteFmf3WkmmRu7s9VvZRp+OMrIGrXimkWzt6JZ
         uFeQ==
X-Gm-Message-State: AOJu0YzQ5nAAPfSnxdTdJQiGXS96pfyvS41goSJnNl3DbxC8qLS5QYLI
	3T6WPFMe8Thjj1JNpXE3B+2ZSy07OjKQ86qeV1W7EZFc/k1QffV+tEFRmzS8GAKrR1nITXtouBW
	yGhMKydpF/aC4OFSXIBx6iTddpRJuOt3nUK4N1VLJ8qUV6vIhGRmO2R8=
X-Google-Smtp-Source: AGHT+IH99AGHDkez492I2+Ury/bIa6UFSuDDUv7plK5Wuh3kReSs/83KqG4W7DDTh4mlRZrZZq08Dwtu5y89dKLBXLpe62ASJ/GF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1351:b0:7cc:2522:f5fd with SMTP id
 ca18e2360f4ac-7e1b51a9835mr117464639f.1.1715874553556; Thu, 16 May 2024
 08:49:13 -0700 (PDT)
Date: Thu, 16 May 2024 08:49:13 -0700
In-Reply-To: <0000000000007e4a2e0616fdde23@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e82ae0618942dcd@google.com>
Subject: Re: [syzbot] Test for 5681e40d297b30f5b513
From: syzbot <syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for 5681e40d297b30f5b513
Author: syoshida@redhat.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 71b1543c83d65af8215d7558d70fc2ecbee77dcf

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index a6fb89fa6278..7e8a20f2fc42 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -30,10 +30,6 @@ MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
 /* CAN_HDR: #bytes before can_frame data part */
 #define J1939_CAN_HDR (offsetof(struct can_frame, data))
 
-/* CAN_FTR: #bytes beyond data part */
-#define J1939_CAN_FTR (sizeof(struct can_frame) - J1939_CAN_HDR - \
-		 sizeof(((struct can_frame *)0)->data))
-
 /* lowest layer */
 static void j1939_can_recv(struct sk_buff *iskb, void *data)
 {
@@ -342,7 +338,7 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
 	memset(cf, 0, J1939_CAN_HDR);
 
 	/* make it a full can frame again */
-	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
+	skb_put_zero(skb, 8 - dlc);
 
 	canid = CAN_EFF_FLAG |
 		(skcb->priority << 26) |


