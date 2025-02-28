Return-Path: <linux-kernel+bounces-538013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E338AA49391
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CA518945A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A6254843;
	Fri, 28 Feb 2025 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b="GqfrBNBe"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0C25332D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731451; cv=none; b=DLK/eY5BY4h5PxWlk+jYWAvDzWrAwnIf//+G1kQPPx6UEqX/+2ZZBbSAhXU6SAFprHZvoC3AboqUy/vqgbS2eMpbGFc9BIR5DfzOIXibXy+M6uHwwHM2LvkG5JQG+TlLha20QK1D3TmHEuoNyWmdSSk0ljWv004eTg7Zgjit+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731451; c=relaxed/simple;
	bh=hrJbdwVJOoCitfyB38HG9ka5RZXi4/Mo2bwmT9qycSo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=itzueyNDcmpUIvMw2LTmIqa1JDsK+zUvLEvcdivPqWp2XNNzOYQ6OVqosbgKZDTyj8xoLHXe0hKb5mwoGUBLFpgj9CqpUp2tp6J0ivyWU907UBw+44SqnrSdbqM8zLQB8ze21kND1I5l2Zx5Qqi1YTjVbPf5512XaDBQ6Gx0K/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; spf=pass smtp.mailfrom=orbstack.dev; dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b=GqfrBNBe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orbstack.dev
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234daaf269so48790765ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1740731449; x=1741336249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W31QiF/8c+lUhQwroh0rTXd/Yx8T+u6oEujuxNDtC8M=;
        b=GqfrBNBeYNPqQWV43GVUYZuG+mfOzqi8fYpjWHGh9LvvExv7xzqMv38AJbGV7GXa4E
         BrLnHxKlFdKN+jD5vD0zCWWldO4OCFqy65atL84qWG0+8soUDflEJyVbq4K4jQyqFx5F
         DYUaFAlsiQl661pt1B0U8e0c+PA2Wv2mzik34Ti3K7wWKvYyM9plF9K1pTTF30zVGTmU
         Q02MnKjnfxOL5HXOZCKduzD649wgnNPEFHzto6yAWh60SIhzrTGxZS3ZOdNCQFm+Kve4
         NcbYX8dNnTbeVE0XcVRgRzJxXG18ru+Q1i56UdoL0TDY/euPHVEYdFi21L1cq0hkADS7
         hT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731449; x=1741336249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W31QiF/8c+lUhQwroh0rTXd/Yx8T+u6oEujuxNDtC8M=;
        b=FKbwW7lIRZdAwQa0i2XmTlUPNVOmymiLM5siukCD53bvypIlbz7HQbHIY74jaCkEZn
         /7RF0CLQnq77Fyb5XAzXcsgNiP0cLiY/i3AuvpIga6joH78A9KR1FUO9NIKHn0DTh4yZ
         RUGIHWThW/vGJs/l5onFwhatn1c7qrRHOuLiUJxlkNkLeFQJA3pV+o8GLbGTDlhAsbEB
         kcM9VpNth52399llZga8AepI2cEsr4UmDw3i4LOrinv5ScW0+mwpkE1KZpb3oc5ol46c
         Eo2jQorWkJhw9wxkHZCs3F3nc5q43rcvJTebCo0s2+IJ3Vdvs5BWpdPzdQe9tIue+WsC
         rCKw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ19UeIYpa7pLHbY7sLE7zlj9hmhRaKlN6enUiEqqwt/h2faGijOjad6RUvNqM6hWGXHsgtPRWGt6WUQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAm+zI6A+t6SHUswXuMFyuc/7LU9kdGBo5//BFYhJwCzFVqNM
	iz4JCSy9sgFEh1gLILoCRlgpDB5Op1+KaKSqGFAxLoVXkXHt8onwWgKq/DYkPL4=
X-Gm-Gg: ASbGncu98FFJ1sIvK1ULRmfq+ZMFyUWFxIvS7QMWG6Iiu73Hnv22LQAYS9XBVqP11Km
	68/w81Tu5qLq37sHjyY2w2eOAZ9/1NBecoWLnX147DLXDNmReS98v9BiiYTkX0qR2sTTYiFbnxS
	sgAszcxRXqr2PVX8id4KPcmfSnmUGtla7FtR1TR8m7RmuouyNqEvYVHVUe4fazu3YHifQfe1E01
	TcTFRijJjBx+oU8wSVT7rZvojTaxaF0GpmDISlSDTS/Ar40N799A00YsUmR5FjAPZhNKVEIFRPB
	kJrU1TXmGDGO8FUesCCuanyfSfmP12i2NihIcw==
X-Google-Smtp-Source: AGHT+IEczsW28uJG6k0w5Jht9KrDUfTpgptHKFfzh2Av0BbT4LAl5Z1Nekai2KNHJeGcTi9+7w9DfQ==
X-Received: by 2002:a05:6a00:9164:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-7362a7367f2mr426733b3a.21.1740731448628;
        Fri, 28 Feb 2025 00:30:48 -0800 (PST)
Received: from debian.. ([143.198.151.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734ad3f3c2fsm1238352b3a.54.2025.02.28.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:30:48 -0800 (PST)
From: Danny Lin <danny@orbstack.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Danny Lin <danny@orbstack.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: fully namespace net.core.{r,w}mem_{default,max} sysctls
Date: Fri, 28 Feb 2025 00:19:41 -0800
Message-ID: <20250228083025.10322-1-danny@orbstack.dev>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{default,max} namespaced")
by adding support for writing the sysctls from within net namespaces,
rather than only reading the values that were set in init_net. These are
relatively commonly-used sysctls, so programs may try to set them without
knowing that they're in a container. It can be surprising for such attempts
to fail with EACCES.

Unlike other net sysctls that were converted to namespaced ones, many
systems have a sysctl.conf (or other configs) that globally write to
net.core.rmem_default on boot and expect the value to propagate to
containers, and programs running in containers may depend on the increased
buffer sizes in order to work properly. This means that namespacing the
sysctls and using the kernel default values in each new netns would break
existing workloads.

As a compromise, inherit the initial net.core.*mem_* values from the
current process' netns when creating a new netns. This is not standard
behavior for most netns sysctls, but it avoids breaking existing workloads.

Signed-off-by: Danny Lin <danny@orbstack.dev>
---
 include/net/netns/core.h        |  5 +++++
 include/net/sock.h              |  6 ------
 net/core/net_namespace.c        | 21 +++++++++++++++++++++
 net/core/sock.c                 | 16 ++++------------
 net/core/sysctl_net_core.c      | 25 ++++---------------------
 net/ipv4/ip_output.c            |  2 +-
 net/ipv4/tcp_output.c           |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c |  4 ++--
 8 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9b36f0ff0c20..0459523602cb 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -17,6 +17,11 @@ struct netns_core {
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
 
+	u32 sysctl_wmem_max;
+	u32 sysctl_rmem_max;
+	u32 sysctl_wmem_default;
+	u32 sysctl_rmem_default;
+
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
 #endif
diff --git a/include/net/sock.h b/include/net/sock.h
index e771d99f81b0..25f1816e650b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2847,12 +2847,6 @@ void sk_get_meminfo(const struct sock *sk, u32 *meminfo);
 #define SK_WMEM_MAX		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
 #define SK_RMEM_MAX		(_SK_MEM_OVERHEAD * _SK_MEM_PACKETS)
 
-extern __u32 sysctl_wmem_max;
-extern __u32 sysctl_rmem_max;
-
-extern __u32 sysctl_wmem_default;
-extern __u32 sysctl_rmem_default;
-
 #define SKB_FRAG_PAGE_ORDER	get_order(32768)
 DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 4303f2a49262..61a417f499e9 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -317,6 +317,27 @@ static __net_init void preinit_net_sysctl(struct net *net)
 	net->core.sysctl_optmem_max = 128 * 1024;
 	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
 	net->core.sysctl_tstamp_allow_data = 1;
+
+	/*
+	 * net.core.{r,w}mem_{default,max} used to be non-namespaced.
+	 * For backward compatibility, inherit values from the current netns
+	 * when creating a new one, so that setting them in init_net
+	 * affects new namespaces like it used to. This avoids causing
+	 * surprising performance regressions for namespaced applications
+	 * relying on tuned rmem/wmem.
+	 */
+	if (net == &init_net) {
+		net->core.sysctl_wmem_max = SK_WMEM_MAX;
+		net->core.sysctl_rmem_max = SK_RMEM_MAX;
+		net->core.sysctl_wmem_default = SK_WMEM_MAX;
+		net->core.sysctl_rmem_default = SK_RMEM_MAX;
+	} else {
+		struct net *current_net = current->nsproxy->net_ns;
+		net->core.sysctl_wmem_max = current_net->core.sysctl_wmem_max;
+		net->core.sysctl_rmem_max = current_net->core.sysctl_rmem_max;
+		net->core.sysctl_wmem_default = current_net->core.sysctl_wmem_default;
+		net->core.sysctl_rmem_default = current_net->core.sysctl_rmem_default;
+	}
 }
 
 /* init code that must occur even if setup_net() is not called. */
diff --git a/net/core/sock.c b/net/core/sock.c
index 23bce41f7f1f..fcee181d6ed9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -278,14 +278,6 @@ static struct lock_class_key af_wlock_keys[AF_MAX];
 static struct lock_class_key af_elock_keys[AF_MAX];
 static struct lock_class_key af_kern_callback_keys[AF_MAX];
 
-/* Run time adjustable parameters. */
-__u32 sysctl_wmem_max __read_mostly = SK_WMEM_MAX;
-EXPORT_SYMBOL(sysctl_wmem_max);
-__u32 sysctl_rmem_max __read_mostly = SK_RMEM_MAX;
-EXPORT_SYMBOL(sysctl_rmem_max);
-__u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
-__u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
-
 DEFINE_STATIC_KEY_FALSE(memalloc_socks_key);
 EXPORT_SYMBOL_GPL(memalloc_socks_key);
 
@@ -1333,7 +1325,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		 * play 'guess the biggest size' games. RCVBUF/SNDBUF
 		 * are treated in BSD as hints
 		 */
-		val = min_t(u32, val, READ_ONCE(sysctl_wmem_max));
+		val = min_t(u32, val, READ_ONCE(sock_net(sk)->core.sysctl_wmem_max));
 set_sndbuf:
 		/* Ensure val * 2 fits into an int, to prevent max_t()
 		 * from treating it as a negative value.
@@ -1365,7 +1357,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		 * play 'guess the biggest size' games. RCVBUF/SNDBUF
 		 * are treated in BSD as hints
 		 */
-		__sock_set_rcvbuf(sk, min_t(u32, val, READ_ONCE(sysctl_rmem_max)));
+		__sock_set_rcvbuf(sk, min_t(u32, val, READ_ONCE(sock_net(sk)->core.sysctl_rmem_max)));
 		break;
 
 	case SO_RCVBUFFORCE:
@@ -3598,8 +3590,8 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	timer_setup(&sk->sk_timer, NULL, 0);
 
 	sk->sk_allocation	=	GFP_KERNEL;
-	sk->sk_rcvbuf		=	READ_ONCE(sysctl_rmem_default);
-	sk->sk_sndbuf		=	READ_ONCE(sysctl_wmem_default);
+	sk->sk_rcvbuf		=	READ_ONCE(sock_net(sk)->core.sysctl_rmem_default);
+	sk->sk_sndbuf		=	READ_ONCE(sock_net(sk)->core.sysctl_wmem_default);
 	sk->sk_state		=	TCP_CLOSE;
 	sk->sk_use_task_frag	=	true;
 	sk_set_socket(sk, sock);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index c7769ee0d9c5..aedc249bf0e2 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -676,21 +676,9 @@ static struct ctl_table netns_core_table[] = {
 		.extra2		= SYSCTL_ONE,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
-	{
-		.procname	= "tstamp_allow_data",
-		.data		= &init_net.core.sysctl_tstamp_allow_data,
-		.maxlen		= sizeof(u8),
-		.mode		= 0644,
-		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	/* sysctl_core_net_init() will set the values after this
-	 * to readonly in network namespaces
-	 */
 	{
 		.procname	= "wmem_max",
-		.data		= &sysctl_wmem_max,
+		.data		= &init_net.core.sysctl_wmem_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -698,7 +686,7 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "rmem_max",
-		.data		= &sysctl_rmem_max,
+		.data		= &init_net.core.sysctl_rmem_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -706,7 +694,7 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "wmem_default",
-		.data		= &sysctl_wmem_default,
+		.data		= &init_net.core.sysctl_wmem_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -714,7 +702,7 @@ static struct ctl_table netns_core_table[] = {
 	},
 	{
 		.procname	= "rmem_default",
-		.data		= &sysctl_rmem_default,
+		.data		= &init_net.core.sysctl_rmem_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
@@ -748,13 +736,8 @@ static __net_init int sysctl_core_net_init(struct net *net)
 			goto err_dup;
 
 		for (i = 0; i < table_size; ++i) {
-			if (tbl[i].data == &sysctl_wmem_max)
-				break;
-
 			tbl[i].data += (char *)net - (char *)&init_net;
 		}
-		for (; i < table_size; ++i)
-			tbl[i].mode &= ~0222;
 	}
 
 	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl, table_size);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ea7a260bec8a..6c706ab6ba1a 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1644,7 +1644,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 
 	sk->sk_protocol = ip_hdr(skb)->protocol;
 	sk->sk_bound_dev_if = arg->bound_dev_if;
-	sk->sk_sndbuf = READ_ONCE(sysctl_wmem_default);
+	sk->sk_sndbuf = READ_ONCE(net->core.sysctl_wmem_default);
 	ipc.sockc.mark = fl4.flowi4_mark;
 	err = ip_append_data(sk, &fl4, ip_reply_glue_bits, arg->iov->iov_base,
 			     len, 0, &ipc, &rt, MSG_DONTWAIT);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0a660075add5..4d6a9c505e25 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -241,7 +241,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 	if (wscale_ok) {
 		/* Set window scaling on max possible window */
 		space = max_t(u32, space, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
-		space = max_t(u32, space, READ_ONCE(sysctl_rmem_max));
+		space = max_t(u32, space, READ_ONCE(sock_net(sk)->core.sysctl_rmem_max));
 		space = min_t(u32, space, window_clamp);
 		*rcv_wscale = clamp_t(int, ilog2(space) - 15,
 				      0, TCP_MAX_WSCALE);
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 3402675bf521..62f30d5c25c7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1280,12 +1280,12 @@ static void set_sock_size(struct sock *sk, int mode, int val)
 	lock_sock(sk);
 	if (mode) {
 		val = clamp_t(int, val, (SOCK_MIN_SNDBUF + 1) / 2,
-			      READ_ONCE(sysctl_wmem_max));
+			      READ_ONCE(sock_net(sk)->core.sysctl_wmem_max));
 		sk->sk_sndbuf = val * 2;
 		sk->sk_userlocks |= SOCK_SNDBUF_LOCK;
 	} else {
 		val = clamp_t(int, val, (SOCK_MIN_RCVBUF + 1) / 2,
-			      READ_ONCE(sysctl_rmem_max));
+			      READ_ONCE(sock_net(sk)->core.sysctl_rmem_max));
 		sk->sk_rcvbuf = val * 2;
 		sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
 	}
-- 
2.47.2


