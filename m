Return-Path: <linux-kernel+bounces-332797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B997BEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8F71F219E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DDF1C6895;
	Wed, 18 Sep 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY3UfMHs"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA148493
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675449; cv=none; b=fz5k8oflIjJwpBy5ceP2WEyTPCPdoTUVjb1tICg9oEOHRdL7Ddba5SbGMqG1pEtN3/7yT7Z8hDOI8tsBlyLflORD3Uc7KIzGeMl7VePpPzsCUiroQ6o1keQLdkfPEy2Y1XYngVhs+xHVDu7G9tgPce9FeyOECDf+nUm0nHMDk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675449; c=relaxed/simple;
	bh=ozrQO1aEIDD0W+lFZwldZmF6sA17Zv2GFaRWEMjAFzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRYjvA5IwryY0jNuNV28RO+/0qUwAZPMCryjaHgwxsWpteO4poMGn7xggQpaT/bP9yQPVI8MQ5Pg6SBZMZvIOS6gUnRhzuPWkbjLtuFKAqTZCLxgWceI8EyRbpqc5tYqf0YirlbY/oKeHd8RKL5fQgaLBwFVeCY/LLJJIfjHDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY3UfMHs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso6287829b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726675447; x=1727280247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbb0Hjd7+5nF4mKg1sEBsUMQxoFEUBChLl8r3aAHU3s=;
        b=hY3UfMHssSB08WDTKNom+plwjqPWdr7rYx025WVCUI3Pmkc1Zcp+cHx3GBBrWcW4mN
         l0+nI+HNR5NI32BFje6xcp8yXZC0b2PlKrORFZHXzA8Y7I62/1fZzkmwTPz8Zg633tWm
         CQuLiMUBL7sILb/kI9yAaPSl5siVJBj/qYOYFT09rVVCSQYNlq/pRiJYpoU8DOgYDCxV
         bvlWC4X2lVhoTUlsDkm29gd0x5AUh89kuh4aHZAn7fL1f3nt2CP+qQKVRG809UlGE3pB
         wVhJjbQ8W/TIItAO0A2Cmq4rwNJUbjXdCVHpgI2Rmxc1Lu8tldkUDItlDzom3HD6K/Y0
         c8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726675447; x=1727280247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cbb0Hjd7+5nF4mKg1sEBsUMQxoFEUBChLl8r3aAHU3s=;
        b=r1TMJWaTM/qxLzjh6b2/9lTZnP8OOIAPYGxN3d/X0P2S0pKJPexfkSgJTPAL+Bfwja
         aA3EX0mxL9uBfOkq21Ib3MqXVr6YlR/auKlzw+oIaKkZg0cd1fGcYJgnh4zmgsB2oO2o
         aqyB0H5lmybI1bQj4WaHEJYwlE8JF1mcacIwafD+jd/zqEAVVlOwEzNFVSY1pxJ2pFpX
         f+E1MhknlPPKRRdnKxmt5HzXqNItkTxMqTbFzujyWYV+Ys7uAO1nBLLtdly5e9m+/QAA
         9rK5tIysytBmUBgIL9wq8unX6af8dJVIqV6CcmTVXDIFGF9eBbRNm5/1zJO7Ig6GTnBV
         goPA==
X-Forwarded-Encrypted: i=1; AJvYcCXIb+UGf7SqKcUx/ZAxEahDIUqyfr+Vwj4/8dTfLPl0q1FPa7xoMOPSgF9IVbgGqwHUJu6/4UUM7Oszo9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZt/rzbe3Yi24dt9UqJpdSYIY/8BB76Lb/1vYYTL1Bg4JuU1eQ
	R9EVbay/bHx7mtlGZZfE6tMzi5FOlIh8RuuYpxdc+U+U00ji1hv+
X-Google-Smtp-Source: AGHT+IFB52Zlmtk237jAyuKF/Pb5UUk29pX+WPYY51n4ADH3HRZb/nKR1h6zpNXPmCda9F3WXC03ew==
X-Received: by 2002:a05:6a00:2282:b0:718:d573:25b0 with SMTP id d2e1a72fcca58-719261eb5e3mr35946101b3a.20.1726675447454;
        Wed, 18 Sep 2024 09:04:07 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7e083sm7095632b3a.140.2024.09.18.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 09:04:06 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
Date: Thu, 19 Sep 2024 01:04:02 +0900
Message-Id: <20240918160402.242505-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000fabef5061f429db7@google.com>
References: <000000000000fabef5061f429db7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/smc/smc_inet.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a5b2041600f9..e101c8eee187 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -111,11 +111,17 @@ static struct inet_protosw smc_inet6_protosw = {
 static int smc_inet_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	int rc;
 
 	/* init common smc sock */
 	smc_sk_init(net, sk, IPPROTO_SMC);
 	/* create clcsock */
-	return smc_create_clcsk(net, sk, sk->sk_family);
+	rc = smc_create_clcsk(net, sk, sk->sk_family);
+
+	if (rc)
+		sk_common_release(sk);
+
+	return rc;
 }
 
 int __init smc_inet_init(void)
--

