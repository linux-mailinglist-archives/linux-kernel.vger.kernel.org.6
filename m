Return-Path: <linux-kernel+bounces-315672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7FE96C5A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A781F26254
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CC1E131C;
	Wed,  4 Sep 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R59lwU0l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED211DEFE7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471947; cv=none; b=Fl+R+JRkOe9qbkIXXvfdHkJZzSy+ghgsk2bgTpdS7+QM06Cze8M/dOnpR/3upngFvyA0axt4WjKYhVtT5McjgT1NaLcd12V08P0WPv2hUCsBJlT6TTIuXFwVJ3VhZGQlcIY/UB0OentmuLDUYn2v1rv3Q18IAMW+Vl0KGx123ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471947; c=relaxed/simple;
	bh=G3WZEbIUL0e8UiShlJ69ZfqKnEKEr/+gItvu7/2c1z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnvfXDfYxfO8xzi5RqHx9S1UF4+LcLHOWW9FR2PLwhZHuu/OVUBzrY7cjq/OKz1r9tq5HY+zz0yxRez1I1A7m7pFVBYPooy/R+XYQf5KMOwprJjeQF79XRcXtPBAKYeQHB+OJb5ztbkNmVFBg57QjtDRbAvuW2ujeRQrUzRPyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R59lwU0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E022EC4CEC2;
	Wed,  4 Sep 2024 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725471946;
	bh=G3WZEbIUL0e8UiShlJ69ZfqKnEKEr/+gItvu7/2c1z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R59lwU0lcYLfjU5PGdo4vH0BZBaXE+Pph3n9W+ySMK15vnzTVpIKV9n3IDDOTXZ84
	 /iwete7nHAaBMIR/DhUuJSWhC6fJwcIb7xG87LIKUEapp2E/PdZ39zPyS5J6+iAC70
	 c4qACgMSsGf9wp2hkOUDoVPbmFV+CIoP5Pgd1tiXFlWDPUJ6m0t0NP/nNBzyzby4kM
	 rgDvNgHKIyNXoX1p/lU4zYXUaxvNIESfEY0gVZZ/QufvWCnHjB+snqFRMsp6btEY4a
	 mkoUzn1MJ4MPY5lXypnpeJulakGwiuc40ce808zzopxhvpaUOqtWAp+7ZH1FxNtbXS
	 z1zvEI9Ho45Ow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Wed,  4 Sep 2024 19:45:38 +0200
Message-ID: <20240904174537.317976-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <000000000000b341bb062136d2d9@google.com>
References: <000000000000b341bb062136d2d9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=matttbe@kernel.org; h=from:subject; bh=G3WZEbIUL0e8UiShlJ69ZfqKnEKEr/+gItvu7/2c1z4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2JzBsIts6IlgrF+q08l4RDAPtRaDELzjYcaFK V6msmzDxf+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZticwQAKCRD2t4JPQmmg cyzTEACf18sgK5rE4CdRrHyRo3VIAzuWhsmCinv6XLRncaSE6rZgUPa7p8l0fHtFYbx6GoZHjqa 0JKWEr3+FEdiCRb7B331GYS9+nSn+/1N7+Lcp9UwZkJXxKIn2+xt0BQpsvbFM97+EniCqbkT9rK 1SaaJDcBh7cfP9QkDh7Zu1e8cmUGGNX+hO4Z4KFn6YJGx7cSW+5/Qs1KxaVE+zvXThxIJ+aMFEI N+MjSmO+ONrdM9KNrZ9TjqBsRlRmW+r/1TQIXVPH0VdSJZNG2BwQ5YgQEvYJEym4T3t+T6ejdNT LWOAuzqGO+5g3cPyhCX8E9hgwLdVb3T8oINagYR+OlSE/HnoWgNlhPqbybuv+B6EhOkgETtVZ9J h/j3Z6t3m6YfwJu+wzbg4vsWyWiDbXo4jRg+N8neIxgLWI1Zfyy5sYZP1eG8W1gvGvEXYwiwClB kuC9NcqfVqnvCTezpUkS6bZlhjpTkkef1G1PvKb4a4MrJTfhj2/ZGgXoAiv/iwCqkq8h6awxkv3 YI9cQMP4JHjZkFtu+FYVo0Fh4SFHbcB9ULo8Wxf1onnEiEekjOO19d+yGz8gb0Mb//WuejS0NCd R1Pfo9/b26/P5meOEqsfhufggtJ4PNGdMHdawRq3MUFnXrnV4KKsEBqE402KnvnqVQwkT8nSa+m E+aWazh8oDhCqUg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

#syz test

v2: include Edward's patch, easier to test with syzbot.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f891bc714668..3a5839ba92f1 100644
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
@@ -1462,8 +1466,10 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
+		spin_lock_bh(&msk->pm.lock);
 		list_del(&entry->list);
 		kfree(entry);
+		spin_unlock_bh(&msk->pm.lock);
 		return true;
 	}
 
-- 
2.45.2


