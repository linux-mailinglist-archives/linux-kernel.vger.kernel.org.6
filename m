Return-Path: <linux-kernel+bounces-300192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE63E95E012
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 23:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790A7B212FB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B543C13F01A;
	Sat, 24 Aug 2024 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="X9wOQXgI"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E243AB4
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724536428; cv=none; b=IEjsJ6pfXLMfOWH3LxX/cl7X2HrLfch+p2mTMT7cfRk1sNuGQyKyxysn87hW4SZpfeYTz2EI7o+YfOr9caErdexxvaPh+7Ywh1CoBRkHj4JH8Jj2A7+wwvQxc3ZiylkNagz545mC/foqjedet0BotprhcHtIx9mFIDkicHpvKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724536428; c=relaxed/simple;
	bh=fdtk3j6B/K4q7tovpsSemG8d26oWj+UYPsItdJYC3gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZEashNFk6kV0nuhFLZ8RycxyX9pMGdxqGQduViEEdXnhVmsypDUiJF5YuwGBEiU+jYKztJK/h8mhC4yPJTxOM5F4vkcCHvwBkfzCEKI3ZhxX+2b2zeTywG9F4vFuW8z2u0BbroY2yyemmM5+ObWS3YhZdX4/GSHgZkpUrITQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=X9wOQXgI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d6f47112so205595585a.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724536425; x=1725141225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/a//zUE8DB7atDLpLvSVe8EWN8ejgSw7SHzNNMS+z0=;
        b=X9wOQXgIyb7IdusKNU9hhPzNfDap5sijjiAbAtJ1P7KERbAYb4KjMknmAAR9aa2S7m
         IVMFlNw+oLKi9WZANf59QFsfKNNejUll8iHOZ0quNEtv0j75yflw8f0hDhAvb9tXgO/C
         DHD/9DfQRjrMKGh3yy2fcCooOFXBdZgqEATQ4aLEiU+1H1a0VQmq9zoZGfzzBs9neA9l
         ufdujvY/4snvvK53OlqONfwM5UxVekkaPY2TodRE0AVhEVcHl/vja2tml8zg3x8KtD8c
         GpMpDvckLcNGw9MDq7A6dzdJIcHxW8eLO0+rSRoakPNHAhxtOP2hNXRiZLfolmVH5jBs
         sUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724536425; x=1725141225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/a//zUE8DB7atDLpLvSVe8EWN8ejgSw7SHzNNMS+z0=;
        b=UN7Zl1oZAwq3/bSM110v7a/LTRvRhN31vU9465ArwEnEjkwBmCfJ/dJral2wQn2wiv
         Vhxw+OOIumuFGg0T54+J0ey2L6aNCiB6abcegVaDnnU7QcnUoddpPfWIPrsca6MTosHS
         EinkkHlh6xvVsCbkJ32lnQBsCkDuIe6/pRLuJ92zHlROgz1I0G85GyFBfw+gRvMm8eJM
         Ozm4F8dZJJiqhULueEdnGVyoRL9Y4/f+/9D30tnAHxNwgcPI9SxJe4h0mjGhfrm8vCCb
         swth47WmUJoPU3HwAyEu6Jr4fxI2OffGbkuHivCvNArjQDt0Zi3v/cEnOZclxreJJjKx
         tFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYhNVMlGJgnDLO08bAq4U4gQ8lzrkZ26t/XQe0BVL+MAzL6e3rwURXxB6+d9Vel0SGkj1PY9HhnBCARUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxy6Pl3ClYgdhRmS0GyKvNM8PGOBmBDstIzgQxoTS6RhqhE9xa
	e/KRG3h5SSdJfqA++32WSfJ/dzCtD+zv10JL709EtipvWaxKfUSa+TCbR7V52D4=
X-Google-Smtp-Source: AGHT+IGzJvpxizj5rbw73KGKfrizqiVQ48WAULMqVuTXPMQVzOBwNrvgkAAymySzOlv9q4M0xExPyQ==
X-Received: by 2002:a05:620a:469e:b0:79f:148:d834 with SMTP id af79cd13be357-7a6897a71ffmr712460885a.59.1724536425193;
        Sat, 24 Aug 2024 14:53:45 -0700 (PDT)
Received: from devbig254.ash8.facebook.com (fwdproxy-ash-114.fbsv.net. [2a03:2880:20ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb19esm307937385a.74.2024.08.24.14.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 14:53:44 -0700 (PDT)
From: Maksym Kutsevol <max@kutsevol.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Maksym Kutsevol <max@kutsevol.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] netpoll: Make netpoll_send_udp return status instead of void
Date: Sat, 24 Aug 2024 14:50:23 -0700
Message-ID: <20240824215130.2134153-1-max@kutsevol.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll_send_udp can return if send was successful.
It will allow client code to be aware of the send status.

Possible return values are the result of __netpoll_send_skb (cast to int)
and -ENOMEM. This doesn't cover the case when TX was not successful
instantaneously and was scheduled for later, __netpoll__send_skb returns
success in that case.

Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
---
Used in the next patch to expose send failure stats in netconsole

 include/linux/netpoll.h | 2 +-
 net/core/netpoll.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index bd19c4b91e31..10ceef618e40 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -56,7 +56,7 @@ static inline void netpoll_poll_disable(struct net_device *dev) { return; }
 static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
-void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 void netpoll_print_options(struct netpoll *np);
 int netpoll_parse_options(struct netpoll *np, char *opt);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index d657b042d5a0..664343e3b688 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -395,7 +395,7 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
@@ -419,7 +419,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	skb = find_skb(np, total_len + np->dev->needed_tailroom,
 		       total_len - len);
 	if (!skb)
-		return;
+		return -ENOMEM;
 
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
@@ -495,7 +495,7 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 
 	skb->dev = np->dev;
 
-	netpoll_send_skb(np, skb);
+	return (int)netpoll_send_skb(np, skb);
 }
 EXPORT_SYMBOL(netpoll_send_udp);
 

base-commit: 8af174ea863c72f25ce31cee3baad8a301c0cf0f
-- 
2.43.5


