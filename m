Return-Path: <linux-kernel+bounces-553129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36961A58441
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660C716AFB1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749F1DC05F;
	Sun,  9 Mar 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oRlxWnyb"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851F1D88DB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526993; cv=none; b=go3LPliuRoYpRb6AfvuhiN8Jz43mUEzMpk4AyVkGk7RSAXvXftGYL7uDQjVDE1BqkHThi5e7HzpufDdXrVln2YfHKfy5Q3L/GKZVbx3A791vJX/h9UAClcdX4qv1TIjGUIH5n2ZobMer4XHSFQvhWuqtVEeUlQxEBpk0chygWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526993; c=relaxed/simple;
	bh=vnuWxUByDaK53vFXT9n7vqyzxlt2qtW+8f94W06a7gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=re/E3lwm69LuGyV3t5m8NAbN44fGjrIE3ZMh7v3cV0rJMvQCT8DSnFoEf4RqLFoFNpna9YTT6hIjk5NPexIewPvvWV0mzQPw3qMk4wF349rz2YL5oECxRs3JJdvlZtS8GQTYMcl7jyNm4FTn3iStPfVQIi0enIIQIDWmcZKJoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oRlxWnyb; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ACFBB3FCCD
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526981;
	bh=shYgV0qT/lqjUQTrvdmbHNW7lzUO23tYACdmBi90n70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=oRlxWnybkcFDjXZsxKiEarmghlZFXhhgwlib0iMzHEtAJpZDHI4dAcGennsqiJXr3
	 r0EzFpAoiY0KogG/FbKFw1P2MbYVrlOfqdMspqiBRA3mQFYQYkMZq9IpRPFS7QOEZH
	 g3ygKbbzX8P9TiW2oZ83wFxUGgIMqPTNj9PpThtiGYv47AGYp+XJukEdFM6+8oGCLF
	 IgZLOltJRmMVvrAsOzMIcbTt29lvcrUprulE+vByl+eMW557c1CwXSHBsTgatRu/VO
	 Y4WL1S2/bA/up5Kp9OjyB/I5As0HVsEa5AWIJzR/k7fvkl7tXP85q/eOwQuQjycJCU
	 dxnVnR4YrV9IA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so59421966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 06:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526979; x=1742131779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shYgV0qT/lqjUQTrvdmbHNW7lzUO23tYACdmBi90n70=;
        b=prkzc+sSfLfgSY1148n32JnKmHx7ZgpmrMkcTowmpDi54SlSxuM/GibAeI708XjFSl
         cqhQtomipqeAljpYfq3hQMqt/dVDdeGgHUzEKf8rCtjER+EI4Pn4CjRExPRHfsjNok8z
         BlI9pCG/zez5L0H7meFRqD+aNyYQ2pkhEbVUOC4ZbPYEBInsw/wPGy4CEmrMCMk8Uazm
         ApWWTbn1LhdY9YfRcBQHR6Z19YbI419d23wgy1fto2FBQZgpNckDjSUlM/WjJxTItFZB
         ffuYijj2ElKu4Vx/SckKUEcJQgsoE81lET0joT7kG3K2HRCVqcSkRme07pkg3ZbDhb4P
         uyBw==
X-Forwarded-Encrypted: i=1; AJvYcCUODOtkwtHhaPY8WkgSb/HFMctrN6RvJYu39DVMhoFQBTjtP6xA1Q/GJowR4fq6Q1+nlFekCv9K+Gc6haE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMjyTkd4wL+NriM4V/MokBSARdaDACQA9+48g1JUyt0jg6NNY
	XDOqP31tQqOLyStRkcw2qKutHKORG8znu8fDiZ5skNkwoORfDVkTmkIxxZOcDyCfsyvIQ132Bqj
	1aYVYHieAiwMpEOu2WA5XH1mFAeITf6C5s6lLr3Ch/ToQPKGkC3jRJJ1Ft808yJYVmNWXMWkS2G
	hh+/QtdKU5Vg==
X-Gm-Gg: ASbGnctbAM6xJsnvUCBQUPs0idt7sCYkBxK3FK4SuuzF5pueOTHA4wopNtZIcj0Qss8
	3miX9X1TUhofyBPKAqkudAZ/rn2C7rDmOyYZTWl3Hdi/WgHUMhAOXVq9/wlQeJCs0QfAOR3U5Hk
	FUGqJCB0IuOk3J0N+Lms4cblqZiLO5czKg6w9WXWCzc2zkkrYg/EBIO50uPox3i1lppR0C9JgMQ
	Cp8P9SeIqPhA7VcpOWFlyRxDG85NQm9SDqtcWX4j3rsWZw4ttFXVjOvFMFgaDGBpHeh4HYdihEe
	pS8Ufm/W7nqGadUDR1DN+cO6AFBiXl8OgUbcirwZvHImhVHmG4LI1L9Tmpqk2b4fK0x8TPxdDoT
	jAslVAyFDjwHYPJTU0A==
X-Received: by 2002:a17:907:c302:b0:ac2:f93:b7c5 with SMTP id a640c23a62f3a-ac2526e1ba9mr1073987466b.31.1741526979545;
        Sun, 09 Mar 2025 06:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWS1LQrRdoibpiP6escIaOL/a7XzBpJqfiCaikM73Pa+IXdnzBUWE6E4F2v53XQL0h2fMQ5g==
X-Received: by 2002:a17:907:c302:b0:ac2:f93:b7c5 with SMTP id a640c23a62f3a-ac2526e1ba9mr1073984866b.31.1741526979165;
        Sun, 09 Mar 2025 06:29:39 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:38 -0700 (PDT)
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
Subject: [PATCH net-next 1/4] net: unix: print cgroup_id and peer_cgroup_id in fdinfo
Date: Sun,  9 Mar 2025 14:28:12 +0100
Message-ID: <20250309132821.103046-2-aleksandr.mikhalitsyn@canonical.com>
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
 net/unix/af_unix.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7f8f3859cdb3..2b2c0036efc9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -117,6 +117,7 @@
 #include <linux/file.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf-cgroup.h>
+#include <linux/cgroup.h>
 
 static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
@@ -861,6 +862,11 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 	int nr_fds = 0;
 
 	if (sk) {
+#ifdef CONFIG_SOCK_CGROUP_DATA
+		struct sock *peer;
+		u64 sk_cgroup_id = 0;
+#endif
+
 		s_state = READ_ONCE(sk->sk_state);
 		u = unix_sk(sk);
 
@@ -874,6 +880,21 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 			nr_fds = unix_count_nr_fds(sk);
 
 		seq_printf(m, "scm_fds: %u\n", nr_fds);
+
+#ifdef CONFIG_SOCK_CGROUP_DATA
+		sk_cgroup_id = cgroup_id(sock_cgroup_ptr(&sk->sk_cgrp_data));
+		seq_printf(m, "cgroup_id: %llu\n", sk_cgroup_id);
+
+		peer = unix_peer_get(sk);
+		if (peer) {
+			u64 peer_cgroup_id = 0;
+
+			peer_cgroup_id = cgroup_id(sock_cgroup_ptr(&peer->sk_cgrp_data));
+			sock_put(peer);
+
+			seq_printf(m, "peer_cgroup_id: %llu\n", peer_cgroup_id);
+		}
+#endif
 	}
 }
 #else
-- 
2.43.0


