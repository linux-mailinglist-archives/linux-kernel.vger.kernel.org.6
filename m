Return-Path: <linux-kernel+bounces-354197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E69993969
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8EFB22F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25E1DEFCF;
	Mon,  7 Oct 2024 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PRLGd+iU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7D28EA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336959; cv=none; b=K3GTGwCKjwbH38BfQvwDD0MQKPQfgPIiyN+wxfpwRZfboXFzb86XiWzODhSUpJdVWQpXy8vYyCMLwwoqFyvFAetIIdHIM2+vPUD4+gJ8zH2Vp2gWlqLX+jcnlj1JpyycL/T5rfACRSgeM1I9tDSzeRDVPedZrqc7AHpw6nhpj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336959; c=relaxed/simple;
	bh=TykJJMM5IzwfbahmKZJTnRFTzpHvJ80eOgoE0YjZMYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRf0GpK28YhbeaFGMJWpTTcuyosa6rtNPGIh9cF3lmHYlr9xIur0Cr3O5P00ATlY2lRj3XnQ6oxC4ODdLOjUQOgvB0vX6fjxj+it5u/i6ZTHZPNKU1HN76BzmxBL0t9IhdwXntn/+NwVcmD+AyUGAtVTXVnukvMlNUF/abWsiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PRLGd+iU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so43844675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336957; x=1728941757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49ytr3oVzMOQdVnJdbtLDkZg4U2+YqG6lYXkOtuknMY=;
        b=PRLGd+iUPIHevsvgJp4Zf8P3EL1s0PKkKau806VpvjPye1nvxHRaVO5tyXCWrGdTvX
         nZsFctYEXDd0aQS6CABe8y6BQlEjvkQTxhg2QO5jS6U3+gWwveI3iKSv7Oixj9GLFKfd
         +0KzWHdZlA8YTi2eIsqf623ys6QfQozAhkUUrLUhf1PesL1Ad4ZD4e2VnCkv7KtHKvWg
         m76s1EthGbpEew5MMeTLWvUP2zFwQTRlhn9HccL+A/o6d5e/iJU40fmDznEBJtMqmJnq
         TVTvPPRL5oPmxYVf5lT7GsxoN3dwvMfPsuD2HJb+4e0cuEPNgYhlaBbCbF0jQlmYjvCP
         KXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336957; x=1728941757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49ytr3oVzMOQdVnJdbtLDkZg4U2+YqG6lYXkOtuknMY=;
        b=uU5p9umGUDJwaDSUsjBRRzPg1/tNuTzlBoIEnqI/qnWNGbsYytm1YWHCcAin8wTvYk
         VlkkE7CUT5BbhGV1SnHfC8ktXsOZAK74tw9rbSXH+rb2bxyLQNbZFiu2os3DvPdNID+t
         8bzMlCfQhM0UJRPtrDHQ6eDGnNpY6umRVmvxM/wA3MxdaiBaHzhx7JeP7B4XSRCIhPKg
         wU0Ocq9UjrOOCYsln1DbACx856yeSz8RVwgOh0GRzVpGbej1f2HQHTqKG1uEfjPdPkvX
         8wnewbMYyAEyvbJGU8ZUQ5rnHqIFKlfAH3RT5ZgksgEvVPOoMx3TKwkC76nmfarnJo/J
         YHsw==
X-Forwarded-Encrypted: i=1; AJvYcCXho7z7A28ZvIYkQFBAW4YAHnBAcAIo8o4gNbAaDc719rYOtQLfTQpsMKnCiKbcgndKKtPR5w6j9F/q67w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ul1G/agSEyEmZMnWzcN//Bn5yaZmZni+wxGPIe3QNt1l4TS0
	PjZCswQOSZgNV+I6AKBXGc9MJcs58TSAy1DSF9ih4aDFgJOXLhXZwHr8P16UXYo=
X-Google-Smtp-Source: AGHT+IEANzLF+YRzAcqDXPNSr1m41nJQ4hZi4WyDM2XMIIfrfbIkQHrP+5IaWRoz90/emp42kZFqcQ==
X-Received: by 2002:a05:600c:3c94:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42f85ab8972mr102989265e9.10.1728336951961;
        Mon, 07 Oct 2024 14:35:51 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:51 -0700 (PDT)
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
Subject: [PATCH v2 7/8] net: inet: do not leave a dangling sk pointer in inet_create()
Date: Mon,  7 Oct 2024 22:35:01 +0100
Message-Id: <20241007213502.28183-8-ignat@cloudflare.com>
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
object. If inet_create() fails later, the sk object is freed, but the
sock object retains the dangling pointer, which may create use-after-free
later.

Clear the sk pointer in the sock object on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ipv4/af_inet.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b24d74616637..8095e82de808 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -376,32 +376,30 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		inet->inet_sport = htons(inet->inet_num);
 		/* Add to protocol hash chains. */
 		err = sk->sk_prot->hash(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 
 	if (sk->sk_prot->init) {
 		err = sk->sk_prot->init(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 
 	if (!kern) {
 		err = BPF_CGROUP_RUN_PROG_INET_SOCK(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 out:
 	return err;
 out_rcu_unlock:
 	rcu_read_unlock();
 	goto out;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 
-- 
2.39.5


