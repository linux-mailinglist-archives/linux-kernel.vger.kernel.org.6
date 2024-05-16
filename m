Return-Path: <linux-kernel+bounces-181185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6168C789F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514EE284397
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D914B979;
	Thu, 16 May 2024 14:48:48 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8EC14B959
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870928; cv=none; b=dvH8OZ+R5Xvt+aRasY+q2gweIh2yDzzd0A+vdzsiaFS1mWLSKYJTTeAtv8zxlFQHBKrLitM6thiBRR3WRAYzdtU/eMyEtRyJyl7IMYAH7W/qtW6bWor3UWRG7mXSeGfifDw9UZRI6f6VpzFQfl9oDTTUMr9B6hDKO3gNcwihJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870928; c=relaxed/simple;
	bh=6bjpy2R23BCG5xOBILH4E+1osU51ofiN4fTAHBzuyP4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ssw/307qhr4OK7NzHUm3GUzPEOP9ce1Mx5gXYdsHegDvMVbHizvZHV7NkC6sEjSbIg8EnNUm43EdKUrImBTePx6nBqL0Fm1x1HnFwRwALobXg594tkTLtPyGJ1NlMwOxWoAFQetHmPHm/G2mpPZ11CLduYgjl1TO5BXbfo5BphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1d3e81a00so614013039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715870925; x=1716475725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIfzr+hfxXE0Yom5oh+at3Y9Ho3Ikwwt+w53cnIzr7I=;
        b=q4EZyzkMLnOn3fwgjSm3h6+DAJAn9pa7xSdzExYzohkwShPKPHYTJpbrSD0cKe78/A
         TaCGLivA1DJ1aUnudUbBYM6VWQmnFpWplNVe9FLLkFJwf45o0VMyXD2ltNExcowSoPDw
         VtsQFZT/lrslx6caeuZBjiCPzKSyYqvXG93IPiitWOy+S+1MdrxGPTFd/pYVLxZ725eP
         KjYKZVcsCN2ktXXD31IXvPWQWJOIOARQ1b+b9MiPmbpGhM3AqG7HJOG9PiAvdIR/1i+O
         Ci0fvXhUQkuEsG+dZhUyAE9/iJbZ/nR58ZOZ33nRBJqQ0dmGrfWzn86rqFu1p+QsMhVw
         B7yw==
X-Gm-Message-State: AOJu0Yx+kIC220lgfujsp9IId1ElD+leObIggrUo/sZrNqYm2/+1H6Z3
	QOUcrDo7Y35VcsmN8UupJVAWTiIirQrCY66GAevYvH0+8dEoT3Qazb4Sm0K3YbCE49NYl/nkemq
	hPDY2FXOa96nRqxekJv0t4XZvhWzzOX25sXU5sGMnyKWAfQSKwZ0Ng0w=
X-Google-Smtp-Source: AGHT+IHZ14Sr1btn4O3xqJW0Fmcbj8mE4cPYkoAThKl7EPyIbNe1tAR8tBFt/xxz0puCSco/+cIS9E+Owhnhzpvo067q3HhQYEzd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2727:b0:488:ac5a:7fe9 with SMTP id
 8926c6da1cb9f-48958e0d6e5mr1135126173.4.1715870925031; Thu, 16 May 2024
 07:48:45 -0700 (PDT)
Date: Thu, 16 May 2024 07:48:45 -0700
In-Reply-To: <0000000000007e4a2e0616fdde23@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f79cb1061893548e@google.com>
Subject: Re: [syzbot] Test for 5681e40d297b30f5b513
From: syzbot <syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for 5681e40d297b30f5b513
Author: syoshida@redhat.com

#syz test

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


