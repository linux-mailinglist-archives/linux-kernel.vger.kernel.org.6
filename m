Return-Path: <linux-kernel+bounces-354195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCFC99395E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B04128307E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB911DED41;
	Mon,  7 Oct 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XbgRrvyu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB1991C3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336953; cv=none; b=gF5n6FHRMAJ+M12zNsHz0efSM5b9h4PC2yrD1jADXM5RVjr/qYCe/0quhBVxf3Est0y0WKDSqilm3vkVH9L4kaQ1q9VpRa/7Om3XGTPrxewrj77qcsHQPBwTzDJw2XNrhuxDK8hVuCacZodcXi2X+WIdmnSDzCASEFLsWaUo+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336953; c=relaxed/simple;
	bh=CZ5nZ72LPsUscQ/XLvrhFET6jRbMhyKZW1WicnfpLPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wk11wakCB7HWXZE8/hPenWZwSv7T1M+VqqtK5lRV0gx4S6wbLdat7L9PmE4groj0LDDt/IQOfOZdLL6YTNnZUSQFd1huLLA6NlrIeSF2fIXzq/+wUjjmAQh0WeMtnjOc2zx/5M8OmiJ1KVMIp1Y1Mz66Yq5hys39UMFTuCY7Bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XbgRrvyu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso43861485e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336949; x=1728941749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU52YEIbPPjVkPgQ3Y9wQ3w91aLQy4KsNcSSu3XlZvI=;
        b=XbgRrvyuC2C4UUGZm1Kyg96OotgJi3Y38sEyztjS4C7nn6SzwMxGBHUv+ISEXyhnCe
         NwCcE5oQT+9dmYlJgr4gj7chS4UxdDFK/yvxlG6ToSyZk/7mFcz9HRHnfgtjH4n+RDnQ
         Y9uLI7/25fDkq10IXfmGRUhdKg8ek/QPQiatskwJDBcE5sZp1/cRIfnkfUSvngRmMyFU
         qGG67meoIL8OdvgiUmEF5XBWJtcQGpV53mCCeAAFh5tfYNLlu9S76mcaFC5SzHUQo9hA
         O1B6ZCKm6FzwhcasSZe1SCWk4GdzS+65+UWUWatz8tpZklAEPMPbq6Zp78R9NMz7Z6HJ
         0coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336949; x=1728941749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU52YEIbPPjVkPgQ3Y9wQ3w91aLQy4KsNcSSu3XlZvI=;
        b=URcwC5MFfVZg4iAMxmNwR45KlZOJy88IcrgFIZ768vMrGlzTsV3ZX7tdndhzgargOz
         m8lcqFf7a11FDzAGgpH+Ce5IEdfY9V6nr92Ho370RdI+rY4XNBDQv5p6kt710NMbJH+v
         b3j0Zv2eYfX35Z8PgJLrhuxwOJxCjHfiCMXC7UZ5M1V0eB22jR5PZgSeKSxwWhj4dnP/
         X/Nw/DVTCLN7Hf/+Hh+RRAR7Hz0GYIXNZlYPtnu8hF+/yVHTEUSFb51AJBlWSEiAlWD9
         Ax+3F5tjiXTDJtA2CaaqA/jSOi3+R6QubqGcXS6wlv5NTz4EjKSQ/bFjL6uhPzHwHuGm
         Fp6A==
X-Forwarded-Encrypted: i=1; AJvYcCUv5T1EbsigoNFnV1tH1ZwrDnydX1eI9XVavqnQbua02MhRY3qxa9oVqeYAOzLKZwEYLdvhtPR5vMfdz4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OSJAqbG9Ye0LXSKeDrvIO2fvSbasH4RAA48KJiutkDJFpuvX
	2DBTNJYW+5GpmI3m2RVRjfPNDr5Qd8ulBst1b1Wy2hIve3SAz3T5OYJ3MWIKjM4=
X-Google-Smtp-Source: AGHT+IF3Mr1m0BA+tyZxEbsXfJoH0mYfnXmhY4oQRsrEz2kQrNeN0a7g/aWeWG/UvI2YgEescmo9xg==
X-Received: by 2002:a5d:5f88:0:b0:37c:d179:2f77 with SMTP id ffacd0b85a97d-37d0e6bc9f8mr9021915f8f.12.1728336949047;
        Mon, 07 Oct 2024 14:35:49 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:48 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v2 6/8] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Mon,  7 Oct 2024 22:35:00 +0100
Message-Id: <20241007213502.28183-7-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_init_data() attaches the allocated sk object to the provided sock
object. If ieee802154_create() fails later, the allocated sk object is
freed, but the dangling pointer remains in the provided sock object, which
may allow use-after-free.

Clear the sk pointer in the sock object on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ieee802154/socket.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 990a83455dcf..18d267921bb5 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1043,19 +1043,21 @@ static int ieee802154_create(struct net *net, struct socket *sock,
 
 	if (sk->sk_prot->hash) {
 		rc = sk->sk_prot->hash(sk);
-		if (rc) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (rc)
+			goto out_sk_release;
 	}
 
 	if (sk->sk_prot->init) {
 		rc = sk->sk_prot->init(sk);
 		if (rc)
-			sk_common_release(sk);
+			goto out_sk_release;
 	}
 out:
 	return rc;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 static const struct net_proto_family ieee802154_family_ops = {
-- 
2.39.5


