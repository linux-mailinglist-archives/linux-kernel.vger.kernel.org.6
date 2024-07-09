Return-Path: <linux-kernel+bounces-246059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F228792BD23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2106C1C2258E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5036D19E827;
	Tue,  9 Jul 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbSKZK9f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7C19B5BB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535803; cv=none; b=siTqKUexHHFjLdcBDiSBqg1Fdtqy0EjYQj7h18l8pyGjR3CZuzbAuwE7EJNMIA8m60cFrq9LOZX/Oo05C416GSJYtZdK2vw3BtvCGPfY+33P4kKblOXUuFqVQfhUl2FZKXdXL91nF2TiT5epGlbOqbBjTi/3T8Nh2/+CIbsf6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535803; c=relaxed/simple;
	bh=WQjwBERS7lelFQl0uZm8b6KivHuPwkMHqfeCg52LURM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnibIakIoeuYuPuUg4TCTRLOF04Bxhrp6Hc2yVgZbUKqmkPdn0oEPaszD4B4GKD17RBqYXOX3V3RhNOTsQHxJhJ//LvSkOxy5J9y694hAovFaSSfi/1Qj+zAKBoHOjnVyCR9uNpxgdwuCew/K2g1MuHLlkYVc3Ah2Z0u4lW4Zok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbSKZK9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720535800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VY5cv6sxNT2DPOy4FzjQps6pTC8NBCeP5vVD1fSftYw=;
	b=RbSKZK9fKErWOyXNOIq8ovisDM3Vg5nKls2YE6+lGWXVAyrCxHJdbfWYa3ff6W6almiZz6
	wV6PhsVNExG9JcvM8BjsI+2BogTPFr0rzG/R6at+0SFAs/uRttekrkB4ZUzMjxdIBQhIJN
	/1kyKtpwvz5jW3aJDUanWhBarBIKpG4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-FtOXFfmcMq-zLyu0nqiZzg-1; Tue, 09 Jul 2024 10:36:39 -0400
X-MC-Unique: FtOXFfmcMq-zLyu0nqiZzg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c9ad83844fso4562966a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720535798; x=1721140598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY5cv6sxNT2DPOy4FzjQps6pTC8NBCeP5vVD1fSftYw=;
        b=j6oGQvNSZl4axBBRXkmtiUsPIcHg5BVzgGXtvG+E1GK7ILi1EBayylcnSifUh4TEf/
         /PlKlegB7B6gfVrMkw6Slr0JyS/XkRlc+gU3z1n+v92H/0CiEHyfdK5Hj6x4yqB2MW/b
         ScXc4jhQLf/xAhaTJF7q3VpDOTwHXOakDwBzn7EeDx5GS/4RoOKuQG7ILLjfunYAb6+b
         du2LsUH9QNAjoepVbp2XZfKZWFmIhNJN58MB3cCuyDYfZ4GZ9ht9FSD+FeXtVgpM86K2
         pW4Nl1g4IDxN1s5SdRvj8ItErEIyKhwrCUx9GkZc5XEjr71NEdUpEZr6ZSPi+qUp0DQC
         P6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWey8k8zhQ/6cmwdxvNd6ZEydU9u+rcPSuM+CXA2tVnzDr/6vkMND6g5EHFDAjkrSNELvOAld+yzf9QaouxCfgA2aLU8kNq1ybS3sdf
X-Gm-Message-State: AOJu0YzHT7YGeAcpmO/CibJTQPxKFJiOBtQJOqzB5W3jyNqU3t50Nk3S
	MO00/QikIgfrgrSLkWnTTRbRvH/wkyQ5UQi3nYiVpgqsNrwi2nHjxuSFf9s/q+j1wBZnEuU1Q7e
	B+o5LyDjA3jsJRhmNWOjnltmAPJ3/6nYZxzH/mQTOCclILv6y3eo8AdZThPVUJg==
X-Received: by 2002:a05:6a20:12c9:b0:1c0:bd6c:aaa0 with SMTP id adf61e73a8af0-1c29822cf04mr2855571637.28.1720535798207;
        Tue, 09 Jul 2024 07:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdNuMmNKEdIA7G57C1sSolv8a1HSGdR8PtE6IeisaSLdShvUO/MYQMkLuFezIlqGMF4DHpQw==
X-Received: by 2002:a05:6a20:12c9:b0:1c0:bd6c:aaa0 with SMTP id adf61e73a8af0-1c29822cf04mr2855540637.28.1720535797850;
        Tue, 09 Jul 2024 07:36:37 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c5d82sm1892427b3a.45.2024.07.09.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:36:37 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next] tipc: Consolidate redundant functions
Date: Tue,  9 Jul 2024 23:36:32 +0900
Message-ID: <20240709143632.352656-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

link_is_up() and tipc_link_is_up() have the same functionality.
Consolidate these functions.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/link.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 0716eb5c8a31..5c2088a469ce 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -241,13 +241,6 @@ enum {
 	LINK_SYNCHING        = 0xc  << 24
 };
 
-/* Link FSM state checking routines
- */
-static int link_is_up(struct tipc_link *l)
-{
-	return l->state & (LINK_ESTABLISHED | LINK_SYNCHING);
-}
-
 static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 			       struct sk_buff_head *xmitq);
 static void tipc_link_build_proto_msg(struct tipc_link *l, int mtyp, bool probe,
@@ -274,7 +267,7 @@ static void tipc_link_update_cwin(struct tipc_link *l, int released,
  */
 bool tipc_link_is_up(struct tipc_link *l)
 {
-	return link_is_up(l);
+	return l->state & (LINK_ESTABLISHED | LINK_SYNCHING);
 }
 
 bool tipc_link_peer_is_down(struct tipc_link *l)
@@ -1790,7 +1783,7 @@ int tipc_link_rcv(struct tipc_link *l, struct sk_buff *skb,
 		rcv_nxt = l->rcv_nxt;
 		win_lim = rcv_nxt + TIPC_MAX_LINK_WIN;
 
-		if (unlikely(!link_is_up(l))) {
+		if (unlikely(!tipc_link_is_up(l))) {
 			if (l->state == LINK_ESTABLISHING)
 				rc = TIPC_LINK_UP_EVT;
 			kfree_skb(skb);
@@ -1848,7 +1841,7 @@ static void tipc_link_build_proto_msg(struct tipc_link *l, int mtyp, bool probe,
 	struct tipc_link *bcl = l->bc_rcvlink;
 	struct tipc_msg *hdr;
 	struct sk_buff *skb;
-	bool node_up = link_is_up(bcl);
+	bool node_up = tipc_link_is_up(bcl);
 	u16 glen = 0, bc_rcvgap = 0;
 	int dlen = 0;
 	void *data;
@@ -2163,7 +2156,7 @@ bool tipc_link_validate_msg(struct tipc_link *l, struct tipc_msg *hdr)
 		if (session != curr_session)
 			return false;
 		/* Extra sanity check */
-		if (!link_is_up(l) && msg_ack(hdr))
+		if (!tipc_link_is_up(l) && msg_ack(hdr))
 			return false;
 		if (!(l->peer_caps & TIPC_LINK_PROTO_SEQNO))
 			return true;
@@ -2261,7 +2254,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		}
 
 		/* ACTIVATE_MSG serves as PEER_RESET if link is already down */
-		if (mtyp == RESET_MSG || !link_is_up(l))
+		if (mtyp == RESET_MSG || !tipc_link_is_up(l))
 			rc = tipc_link_fsm_evt(l, LINK_PEER_RESET_EVT);
 
 		/* ACTIVATE_MSG takes up link if it was already locally reset */
@@ -2300,7 +2293,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		if (msg_probe(hdr))
 			l->stats.recv_probes++;
 
-		if (!link_is_up(l)) {
+		if (!tipc_link_is_up(l)) {
 			if (l->state == LINK_ESTABLISHING)
 				rc = TIPC_LINK_UP_EVT;
 			break;
@@ -2387,7 +2380,7 @@ void tipc_link_bc_init_rcv(struct tipc_link *l, struct tipc_msg *hdr)
 	int mtyp = msg_type(hdr);
 	u16 peers_snd_nxt = msg_bc_snd_nxt(hdr);
 
-	if (link_is_up(l))
+	if (tipc_link_is_up(l))
 		return;
 
 	if (msg_user(hdr) == BCAST_PROTOCOL) {
@@ -2415,7 +2408,7 @@ int tipc_link_bc_sync_rcv(struct tipc_link *l, struct tipc_msg *hdr,
 	u16 peers_snd_nxt = msg_bc_snd_nxt(hdr);
 	int rc = 0;
 
-	if (!link_is_up(l))
+	if (!tipc_link_is_up(l))
 		return rc;
 
 	if (!msg_peer_node_is_up(hdr))
@@ -2475,7 +2468,7 @@ int tipc_link_bc_ack_rcv(struct tipc_link *r, u16 acked, u16 gap,
 	bool unused = false;
 	int rc = 0;
 
-	if (!link_is_up(r) || !r->bc_peer_is_up)
+	if (!tipc_link_is_up(r) || !r->bc_peer_is_up)
 		return 0;
 
 	if (gap) {
@@ -2873,7 +2866,7 @@ void tipc_link_set_tolerance(struct tipc_link *l, u32 tol,
 	l->tolerance = tol;
 	if (l->bc_rcvlink)
 		l->bc_rcvlink->tolerance = tol;
-	if (link_is_up(l))
+	if (tipc_link_is_up(l))
 		tipc_link_build_proto_msg(l, STATE_MSG, 0, 0, 0, tol, 0, xmitq);
 }
 
-- 
2.45.2


