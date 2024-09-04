Return-Path: <linux-kernel+bounces-315609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6665D96C4EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212C12874A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F661E1A0C;
	Wed,  4 Sep 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPZ8wvII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF41E0B7E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469542; cv=none; b=rWw0R73OmjH53eVW79rREBGd2YrM36lNIH7N60JVpF1V5ZB9ndqjXn16CsAuFea8pGPu4bE+x5kixMmzN/vwJvAITRsz/08dZ8GOD966WJi5tnSCVqpfbKyvXH0jqlJLue8Za/Dzh5nwTnm3979GF7RSkoO+Ve9srLSjn4dSk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469542; c=relaxed/simple;
	bh=yZmRYArkJKaIHXDzJYGm8lIouQqiNCGKNEsykROu9tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Potdq5RPKA3/BE5L/tLmRpaa9JX8U13r+EFP/YsQq0LzOV//DBtcR/YddOsVQcWnAz9Ety0sUpJlWBE/FsIcLO+G5JEG6adReUxdjp0xeEmaYY4lyH2Zkc+x9adiszcq1teKAU2WiAHRlB778N5T6veYwL+4LsPypq4E3uBeBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPZ8wvII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA11C4CEC2;
	Wed,  4 Sep 2024 17:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725469540;
	bh=yZmRYArkJKaIHXDzJYGm8lIouQqiNCGKNEsykROu9tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPZ8wvII0B/zemNeac3UH29I/2dASumPLFuzWpy4d1wE2py87FodF489XQ6fWOIj2
	 sK0Di0+GHmj+F8njKy5NjlncWFXGtR5cZHEr2fX2UJx9rCfdL3vTLFlwvXQO9d8wob
	 7hIuzVaIFzJWcc4wTeonALIuUx5yVBYXWM1NdudLbQ7npkA8jnw4RfElZRlPSAjSQe
	 maDI/Z0lZIQEvHZWgfAbonLYY4c+22qx0dUoXzuParjN4SmWLESCC+51cZMziFSvaz
	 36K7ubL9I6EKoXH05us8IU5KKeYPEtBM53c/dwMJj2Qo7G+Qei2HpL+SUWx3TXGIRb
	 qx9WaWAvVwa2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Wed,  4 Sep 2024 19:05:18 +0200
Message-ID: <20240904170517.237863-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <000000000000b341bb062136d2d9@google.com>
References: <000000000000b341bb062136d2d9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=matttbe@kernel.org; h=from:subject; bh=yZmRYArkJKaIHXDzJYGm8lIouQqiNCGKNEsykROu9tk=; b=kA0DAAgB9reCT0JpoHMByyZiAGbYk02i3qZSl4gNdn1pk2k0H/eBzm8pdqNoPBbRNjxbs2v5+ okCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJm2JNNAAoJEPa3gk9CaaBzHl4P/AnY SvEmUwqv+MY08zwEntIUr0ZZ5IuJ93PpdKbwOmJrtBKmXSaSAO4b+qxF35x9SLrjPuG2OFgjTp2 iwm8ixyI1Wf/GYT7gQ67LN6gIb4bi9PtrNJPcJ92TppB9JHncfgfxgYsqQcWUh61ntEKVtIkbnj f6AIAtX9VAjvz4rOEkf22zzauWjJjDm3o9dTucB6GKcl5fKUia2fSZ/qIZb0/Jxn46GtCU2snsH HGxfbYRJ0wT/fVBuumxWCqrQNJhimqjotESWhwBlG1hDA1xCmJdPAIWGYQY9ra241jtLz8QRcdU T8j/IEK2UZf2nHOHp8cqvHkcNM5oy80E4W7lfi5UeFFoJZ2uC+sX97eJeb03FVtFOx+sS6Y8xbL 9OjUYfCJq+xkcUf06+kkuvEWoq4ZP7QwMnK3jLndy7w8vsevMY8E900ggXvqu85eMiLlwk7mWBF pJWUqvAIUq/FMwlNycW6oZ+htghXX00dUTslg1LOzMmE1Iy8aIk7k+YBHMHCrXxPUh1Aek3TCgX f4PTbDxT51rgzz7+UCCMbd9ZX7DsDeh52BU7GawhwR0sX5BJeOAHE+cRwTOMDzUOHiqhn9C8dFo +RxgF6k0dc+SmTR92XaDPawlr4WBAYjsaJPvHGpQC/llcFmBywVlRj8URJXKeS6RbY3U5RtQI8G 0HaW2
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

#syz test

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f891bc714668..792b5f09a915 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -332,17 +332,21 @@ struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
+	struct mptcp_pm_add_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
-- 
2.45.2


