Return-Path: <linux-kernel+bounces-364355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18DF99D3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765CB1F2455B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D441CACC4;
	Mon, 14 Oct 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c3QI9aUK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CB1C2DB0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920317; cv=none; b=kdC9O0B68A2DXVR7WmrGoKkV07o/cPNO+GaoH31DRtlcCO0BvDzIaRPgehThAnXmALWEampT7ZLCDNVqlKwGCFNeMaclvUyHb6O2lxS7+NeflIgO3WQ4TUdZ5NgKKJ/5CN4ByAdVU6jSEruLZ3RouaukQdXfHBdnp9tpdT/kgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920317; c=relaxed/simple;
	bh=TykJJMM5IzwfbahmKZJTnRFTzpHvJ80eOgoE0YjZMYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QK/igDEJE5AUEShOPQKgNCqx9qGdygQxpATIb7U546G0aH8zHGGeoprciVIWvKvffpbOHTaZn7qtw7w/CBNlhEXoFRpr7lQT1nzTCIF38rUKa4Fu02je/SIU2q/qIISjr/eRsif7/+Uv/Nze/ETkUhOhPprNH3RWk6bkkICB2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c3QI9aUK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cea34cb57so2958751f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920314; x=1729525114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49ytr3oVzMOQdVnJdbtLDkZg4U2+YqG6lYXkOtuknMY=;
        b=c3QI9aUKu6Bi2Q+b8cXS2JW0XWkQrdIxfWRocPjUJ4ipX/DnkFkgfFSoH96GxQjskv
         H+s5a4sZHs/D1d604fpqEK01TyCQyKdFJfgkd5WKBzAQ4YFDKPAuRNsEujbfaEd0wOhk
         U2hsj7sc/AdfjvUi3lHThlaDFMkKysLdxdMTn4G92x94laSnlToVfQ6jeu7c7CEluJLR
         X7FY8MsnnN/Lg7qWc2A6dzJdJOp1vw6kW+mXrHEJdVrmmt/tKVS+YhzaH1YxoMHJrjNA
         ENQozVzUkLa+X1wb/Djdwd/P4v7UX4Lz8Znxc0zcjnVBrmGvRw90fT6hrOYEPY+RxGlk
         mttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920314; x=1729525114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49ytr3oVzMOQdVnJdbtLDkZg4U2+YqG6lYXkOtuknMY=;
        b=ACbW9KJmklWpelrNsqrHh3Fgrc6QKvUUxF/EC3nDcZeGfJZRhmeKP04+cZ4eyw9FSr
         AeJP/hRcv4M1rDSdr44x/ED3otHbubG0OmAfFUen172nR4O6609td5WVIXVBUlRlP6lY
         DkChuct+20YW9KSO0lyYVAnMn2pIfbmijzM3HPcEpHipjLo/QvEqoMGewgUmgw0ldEH9
         L6d930OpKK3wmCf9y87/Lccw0Dz3KwfTSoPbCQQlfnoRdQJeFGQHx27Y/XDjwtsB1kLQ
         NrBTnlROE8lpgWjzoxAs8jxulm8CAiB4N3dbcftzWgV0kI66cWYcrUQIkduTVLPIEbiH
         3j4g==
X-Forwarded-Encrypted: i=1; AJvYcCWoxY4NB0hbaAQgEC0N2cunyABQCGt+Qn9Tf3/14aZliZiw28uPPT0dktB4O+O85JBK/jn4Fo0ikbjFg1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuNSgi3jWXxCxCc6mfwyJ44imNupNFM2agm+MNA3XKWal1uVN
	aed3Pch8ad3WsgBDfcsuk84/vA+EcmesXWtIJFe1oaPb1NsoO1qb9rweRLaO7r4=
X-Google-Smtp-Source: AGHT+IEK1fXfdN4ULr/3sLohnKiPnjVrQV68cRQbTA59WSVC//oUJKPx9zNQVb7mUdYnIwSncrGyLA==
X-Received: by 2002:a5d:688f:0:b0:37d:50e1:b3e1 with SMTP id ffacd0b85a97d-37d551b79c7mr8936288f8f.16.1728920313945;
        Mon, 14 Oct 2024 08:38:33 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:33 -0700 (PDT)
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
Subject: [PATCH net-next v3 6/9] net: inet: do not leave a dangling sk pointer in inet_create()
Date: Mon, 14 Oct 2024 16:38:05 +0100
Message-Id: <20241014153808.51894-7-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
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


