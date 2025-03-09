Return-Path: <linux-kernel+bounces-553130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2EA58444
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8CE16B6DF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D91DD9A8;
	Sun,  9 Mar 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DePFjXu/"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CD1DDC35
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526999; cv=none; b=BL8cp5NFAyA2133A+k/PmaFWXUHgfJoXD5p0j9BRsgLimQiYLpi/ATPQboU3/X5ll8Te30fHMyEBPc/+5Rpl1VRfvliqgL2InVMc3MQSNQeTogyfSxJEONLKUaOCfq/7cJ63ETHugoDLwUb01WF61G2aB2det2GqBGOoaaPbqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526999; c=relaxed/simple;
	bh=h11slZywu67PPCzd8E5r1pZxOSwbTAwOByW1hwfHQ8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6DscAw7l4u97TB9Iiv4AIqwp8/CB3XvSwIXCbF5j6V/JGps5bOxkICWSJgmlJDlWMd34g8Me+ndqLN8ErLoCewNxS0NY5o4m9vrETUVJ9UgVE5lhJOOnhw9/shNx9PO1LxjfM2fPpOkxeSK+RvcfBIf6Rm6RpCM/wKlK9uKwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DePFjXu/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 25A513FE42
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526986;
	bh=oUkDN9VrMm5b6Y+/DOvznDBPjXORLJgfeSeYgeNTS6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=DePFjXu/AShaiUmWmTFaHJkoZa8XZONUqU9g9ITFRKjzgzYt9asa2RWj/6gxsImLe
	 z1bKC3slsAE8AKxjN7qWGiqDtu4wEXl/6Vk76dCYO/h/FuljbMpJk4DdJRDNT2hW3Y
	 vC9LbR1R47Tym4o6mKBtBI7gqoSQKrj62/peAx1QnSsWOOU7NWn0WBeTWS3oTdjp/U
	 bIS2iwZMovFJQK8TrsxseS1T6WG10ooq3MHx9BbKvBzqi2Z4ZOvxDIY4QguJbz/4oJ
	 05msNv2C3xZjCXrVtj+Nj4lzfm0WW41vpVLZ/G/AJSBGjlmzAREUZLOlH66IBjEzMa
	 CmqaZR4XnSAjQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab39f65dc10so433923366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 06:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526981; x=1742131781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUkDN9VrMm5b6Y+/DOvznDBPjXORLJgfeSeYgeNTS6Y=;
        b=XRcNcrvTfYxKM8T7miv+qLeJO7/pykhgmjLctnb4BUxVpOxbwSydqGwPnuAao1Ux0P
         v8kOkuNt5KP4HbQKN/Sjbf0L+ivkZnOPm7AXQ3NxfPzosgB1AuoMIADU7stWzBfU1MC1
         88Qzmnj4FG3/ylvca7YoaGOa60H2MOElXrmxc4OiQMndki2WDdBnBrbdr/ITa+Ug/Yy4
         M8SHDSypROv7hSpm7AqIVVstVrUni0YONVu4UH2GHvEOWxc3hyWwDG1a3zemOvs1LR3E
         dwWobtFcDeDv3AbSL/YWbNm6g3GSs117tMHowjbB43MbWsR5zeTg6wVPe7wrNCnZlyd4
         wJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCVrBz9S5mVvqLWAJp43uFYmR8vXpqR0jfZ2E317CwzAAkGoRfi9YuK4oGxw99BtfVBvA6D8ZJopioDqHbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuzz0Z948vAwthUE7tutScx47ptVJ9Z61n1PwhuU4qJoiwEL9d
	Y0W9UtkZOR6XaX1Z8SLDqb/oZeC1EhbuPEb0/tD5ZS7O/o6hGAIqjLID+VqqBCbPalTaiIFfr+y
	ac72TNO/UNlCt93IEIQJZWZF1CekuNfhlvNuJGFba8HKrnIPXRWqlM2CR0MW5NBlMu/IN/cfT+y
	f8jBCf5tbJ1Q==
X-Gm-Gg: ASbGncvDmfLLrirwG64/UHAQ28F9+9lrKJDKUtGcNA11ATkO5yCp3+5BT5cavC6I3r4
	yp1aXPhE3+KgLcktnl8SBkSwU4jDSZbAQVcbotyA77CLD6JIQupLWAzGpK3dLFKHA8Je9rE7gTI
	/kkgssDtqC8ys3cQp9GFEkhnS7+AGzAPTXAopRyta8OgISpygDDU1/po3iK8rG4ID2SSYsvEeMJ
	O3JCz9YIEB5hSMaVqpmOQmNI9L3syvhgpAjNzLIHuzkNZPu4yXnv+vtgvIHYbkjDwGbG3GZayV3
	dvMn3Rzi1kU/bDi66sECYS6iLoXzEHywrZrufhg4+VeiHeSXTcFccAQoVCysm4HgtNqTEjGQlAG
	qET0xFFF9wkakgeNmOA==
X-Received: by 2002:a17:907:9615:b0:ac2:9c7d:e129 with SMTP id a640c23a62f3a-ac29c7dee94mr115088066b.38.1741526981515;
        Sun, 09 Mar 2025 06:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnWyfFVWjU228SRznBeLkPmsqMd2onjEQ1MWjIegB/cFAZnvOBfloK324qPC2AGva8B49jNg==
X-Received: by 2002:a17:907:9615:b0:ac2:9c7d:e129 with SMTP id a640c23a62f3a-ac29c7dee94mr115085566b.38.1741526981136;
        Sun, 09 Mar 2025 06:29:41 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:40 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH net-next 2/4] net: core: add getsockopt SO_PEERCGROUPID
Date: Sun,  9 Mar 2025 14:28:13 +0100
Message-ID: <20250309132821.103046-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add SO_PEERCGROUPID which allows to get cgroup_id
for a socket.

We already have analogical interfaces to retrieve this
information:
- inet_diag: INET_DIAG_CGROUP_ID
- eBPF: bpf_sk_cgroup_id

Having getsockopt() interface makes sense for many
applications, because using eBPF is not always an option,
while inet_diag has obvious complexety and performance drawbacks
if we only want to get this specific info for one specific socket.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 arch/alpha/include/uapi/asm/socket.h    |  2 +
 arch/mips/include/uapi/asm/socket.h     |  2 +
 arch/parisc/include/uapi/asm/socket.h   |  2 +
 arch/sparc/include/uapi/asm/socket.h    |  2 +
 include/uapi/asm-generic/socket.h       |  2 +
 net/core/sock.c                         | 17 +++++++
 net/unix/af_unix.c                      | 63 +++++++++++++++++++++++++
 tools/include/uapi/asm-generic/socket.h |  2 +
 8 files changed, 92 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 3df5f2dd4c0f..58ce457b2c09 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -150,6 +150,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PEERCGROUPID		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 22fa8f19924a..823fa67f7d79 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -161,6 +161,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PEERCGROUPID		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index aa9cd4b951fe..1ee2e858d177 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -142,6 +142,8 @@
 
 #define SO_RCVPRIORITY		0x404D
 
+#define SO_PEERCGROUPID		0x404E
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 5b464a568664..2fe7d0c48a63 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -143,6 +143,8 @@
 
 #define SO_RCVPRIORITY           0x005b
 
+#define SO_PEERCGROUPID          0x005c
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index aa5016ff3d91..903904bb537c 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -145,6 +145,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PEERCGROUPID		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index a0598518ce89..6dc0b1a8367b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1946,6 +1946,23 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		goto lenout;
 	}
 
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	case SO_PEERCGROUPID:
+	{
+		const struct proto_ops *ops;
+
+		if (sk->sk_family != AF_UNIX)
+			return -EOPNOTSUPP;
+
+		ops = READ_ONCE(sock->ops);
+		if (!ops->getsockopt)
+			return -EOPNOTSUPP;
+
+		return ops->getsockopt(sock, SOL_SOCKET, optname, optval.user,
+				       optlen.user);
+	}
+#endif
+
 	/* Dubious BSD thing... Probably nobody even uses it, but
 	 * the UNIX standard wants it for whatever reason... -DaveM
 	 */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2b2c0036efc9..3455f38f033d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -901,6 +901,66 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 #define unix_show_fdinfo NULL
 #endif
 
+static int unix_getsockopt(struct socket *sock, int level, int optname,
+			   char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+
+	union {
+		int val;
+		u64 val64;
+	} v;
+
+	int lv = sizeof(int);
+	int len;
+
+	if (level != SOL_SOCKET)
+		return -ENOPROTOOPT;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < 0)
+		return -EINVAL;
+
+	memset(&v, 0, sizeof(v));
+
+	switch (optname) {
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	case SO_PEERCGROUPID:
+	{
+		struct sock *peer;
+		u64 peer_cgroup_id = 0;
+
+		lv = sizeof(u64);
+		if (len < lv)
+			return -EINVAL;
+
+		peer = unix_peer_get(sk);
+		if (!peer)
+			return -ENODATA;
+
+		peer_cgroup_id = cgroup_id(sock_cgroup_ptr(&peer->sk_cgrp_data));
+		sock_put(peer);
+
+		v.val64 = peer_cgroup_id;
+		break;
+	}
+#endif
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	if (len > lv)
+		len = lv;
+	if (copy_to_user(optval, &v, len))
+		return -EFAULT;
+	if (put_user(len, optlen))
+		return -EFAULT;
+
+	return 0;
+}
+
 static const struct proto_ops unix_stream_ops = {
 	.family =	PF_UNIX,
 	.owner =	THIS_MODULE,
@@ -910,6 +970,7 @@ static const struct proto_ops unix_stream_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	unix_accept,
 	.getname =	unix_getname,
+	.getsockopt =	unix_getsockopt,
 	.poll =		unix_poll,
 	.ioctl =	unix_ioctl,
 #ifdef CONFIG_COMPAT
@@ -935,6 +996,7 @@ static const struct proto_ops unix_dgram_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	unix_getname,
+	.getsockopt =	unix_getsockopt,
 	.poll =		unix_dgram_poll,
 	.ioctl =	unix_ioctl,
 #ifdef CONFIG_COMPAT
@@ -959,6 +1021,7 @@ static const struct proto_ops unix_seqpacket_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	unix_accept,
 	.getname =	unix_getname,
+	.getsockopt =	unix_getsockopt,
 	.poll =		unix_dgram_poll,
 	.ioctl =	unix_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index aa5016ff3d91..903904bb537c 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -145,6 +145,8 @@
 
 #define SO_RCVPRIORITY		82
 
+#define SO_PEERCGROUPID		83
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
-- 
2.43.0


