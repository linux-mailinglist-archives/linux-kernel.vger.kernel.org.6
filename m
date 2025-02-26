Return-Path: <linux-kernel+bounces-534692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC00A46A04
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CDC18894FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA5235BF4;
	Wed, 26 Feb 2025 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHSb4t8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00DA236436
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595565; cv=none; b=WjjF6LPZwbueu8Hn+ASnAUaSZ8clfqhMd2tFhQjdhrUbHqlyzqb+SnHkKQ8aBxQShw3Dq7vC+gF4nZoi4HUH+BKP2OJUJWWYMtDVa+POnD2Ysd8Cpc5i43jwZ1zOXAE+OODty1+xZVA2xk+JFpOBjcIKnVVJrfn0uAk7wx6Zb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595565; c=relaxed/simple;
	bh=FE28cHM2Xu+6IwRPzQpF/Y9BjWJU8LBOSYm56nzMorc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0WGFZfb7yDoQ1nrFIn8gikq6XaBpB3XGcu8hNDsF4pU0gPC7JIguHDtENF+4Wlgbrqgz45+syKfOdGkBa2zbcXVgcoesDBtDlD7KPPiGUKg/CYr4kiBgqSwxGnD1NzNQHlxm7FA/P6tOhamYo0Xqen8kY77Hur9hKpLKaO3HQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHSb4t8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1380DC4CED6;
	Wed, 26 Feb 2025 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595564;
	bh=FE28cHM2Xu+6IwRPzQpF/Y9BjWJU8LBOSYm56nzMorc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LHSb4t8WjHOe36CjKcO4O8TgvN3XrISVlK3/CrJH1N++dPJKNjBlGGu7LO0cQ/eRU
	 BsAe+XJWUk1GORxjKthDQ+iHO1uxT8ZfYonEtkziW3IrhbBLfcZYk1JEs5Atf5wIuH
	 Oj1yEX6/fF8DNrZ3Nosk0hT7L+3E/hTBgh+jgR/0tx9qk/sG6eHgY9yd3P7jwat94J
	 fD2FlMy2uqAwONvzEcZOxLL2lPxUFtp8UVR/Hr5Ht1QldylfATd2h06BC+5PHaiCSz
	 U603RnIaK+cJ4xuLTsDpn3dkVtpPib5h88OmfPiIKSrqBjxADZmwnUwwoAvyIe7wWz
	 fhCmRkY59oXDA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:55 +0100
Subject: [PATCH 03/11] nvmet-fcloop: refactor fcloop_nport_alloc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-3-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

There are many different operations done under the spin lock. Since the
lport and nport are ref counted it's possible to only use for the list
insert and lookup the spin lock.

This allows us to untangle the setup steps into a more linear form which
reduces the complexity of the functions.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 156 +++++++++++++++++++++++--------------------
 1 file changed, 84 insertions(+), 72 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index ca46830d46ecbaae21f3ee3e69aa7d52905abcae..de1963c34bd88d0335f70de569565740fd395a0a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1038,6 +1038,8 @@ fcloop_nport_free(struct kref *ref)
 	list_del(&nport->nport_list);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (nport->lport)
+		fcloop_lport_put(nport->lport);
 	kfree(nport);
 }
 
@@ -1206,33 +1208,63 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 	return ret;
 }
 
+static struct fcloop_lport *
+fcloop_lport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_lport *lp, *lport = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_for_each_entry(lp, &fcloop_lports, lport_list) {
+		if (lp->localport->node_name != node_name ||
+		    lp->localport->port_name != port_name)
+			continue;
+
+		if (fcloop_lport_get(lp))
+			lport = lp;
+
+		break;
+	}
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	return lport;
+}
+
+static struct fcloop_nport *
+fcloop_nport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_nport *np, *nport = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_for_each_entry(np, &fcloop_nports, nport_list) {
+		if (np->node_name != node_name ||
+		    np->port_name != port_name)
+			continue;
+
+		if (fcloop_nport_get(np))
+			nport = np;
+
+		break;
+	}
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	return nport;
+}
 
 static ssize_t
 fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct fcloop_lport *tlport, *lport = NULL;
+	struct fcloop_lport *lport;
 	u64 nodename, portname;
-	unsigned long flags;
 	int ret;
 
 	ret = fcloop_parse_nm_options(dev, &nodename, &portname, buf);
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&fcloop_lock, flags);
-
-	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
-		if (tlport->localport->node_name == nodename &&
-		    tlport->localport->port_name == portname) {
-			if (!fcloop_lport_get(tlport))
-				break;
-			lport = tlport;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-
+	lport = fcloop_lport_lookup(nodename, portname);
 	if (!lport)
 		return -ENOENT;
 
@@ -1245,9 +1277,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 static struct fcloop_nport *
 fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 {
-	struct fcloop_nport *newnport, *nport = NULL;
-	struct fcloop_lport *tmplport, *lport = NULL;
 	struct fcloop_ctrl_options *opts;
+	struct fcloop_nport *nport;
+	struct fcloop_lport *lport;
 	unsigned long flags;
 	u32 opts_mask = (remoteport) ? RPORT_OPTS : TGTPORT_OPTS;
 	int ret;
@@ -1261,79 +1293,59 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 		goto out_free_opts;
 
 	/* everything there ? */
-	if ((opts->mask & opts_mask) != opts_mask) {
-		ret = -EINVAL;
+	if ((opts->mask & opts_mask) != opts_mask)
 		goto out_free_opts;
-	}
 
-	newnport = kzalloc(sizeof(*newnport), GFP_KERNEL);
-	if (!newnport)
+	lport = fcloop_lport_lookup(opts->wwnn, opts->wwpn);
+	if (lport) {
+		/* invalid configuration */
+		fcloop_lport_put(lport);
 		goto out_free_opts;
+	}
 
-	INIT_LIST_HEAD(&newnport->nport_list);
-	newnport->node_name = opts->wwnn;
-	newnport->port_name = opts->wwpn;
-	if (opts->mask & NVMF_OPT_ROLES)
-		newnport->port_role = opts->roles;
-	if (opts->mask & NVMF_OPT_FCADDR)
-		newnport->port_id = opts->fcaddr;
-	kref_init(&newnport->ref);
+	nport = fcloop_nport_lookup(opts->wwnn, opts->wwpn);
+	if (nport && ((remoteport && nport->rport) ||
+		      (!remoteport && nport->tport))) {
+		/* invalid configuration */
+		goto out_put_nport;
+	}
 
-	spin_lock_irqsave(&fcloop_lock, flags);
+	if (!nport) {
+		nport = kzalloc(sizeof(*nport), GFP_KERNEL);
+		if (!nport)
+			goto out_free_opts;
 
-	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
-		if (tmplport->localport->node_name == opts->wwnn &&
-		    tmplport->localport->port_name == opts->wwpn)
-			goto out_invalid_opts;
+		INIT_LIST_HEAD(&nport->nport_list);
+		nport->node_name = opts->wwnn;
+		nport->port_name = opts->wwpn;
+		kref_init(&nport->ref);
 
-		if (tmplport->localport->node_name == opts->lpwwnn &&
-		    tmplport->localport->port_name == opts->lpwwpn)
-			lport = tmplport;
+		spin_lock_irqsave(&fcloop_lock, flags);
+		list_add_tail(&nport->nport_list, &fcloop_nports);
+		spin_unlock_irqrestore(&fcloop_lock, flags);
 	}
 
+	if (opts->mask & NVMF_OPT_ROLES)
+		nport->port_role = opts->roles;
+	if (opts->mask & NVMF_OPT_FCADDR)
+		nport->port_id = opts->fcaddr;
+
 	if (remoteport) {
+		lport = fcloop_lport_lookup(opts->lpwwnn, opts->lpwwpn);
 		if (!lport)
-			goto out_invalid_opts;
-		newnport->lport = lport;
-	}
-
-	list_for_each_entry(nport, &fcloop_nports, nport_list) {
-		if (nport->node_name == opts->wwnn &&
-		    nport->port_name == opts->wwpn) {
-			if ((remoteport && nport->rport) ||
-			    (!remoteport && nport->tport)) {
-				nport = NULL;
-				goto out_invalid_opts;
-			}
-
-			fcloop_nport_get(nport);
+			goto out_put_nport;
 
-			spin_unlock_irqrestore(&fcloop_lock, flags);
-
-			if (remoteport)
-				nport->lport = lport;
-			if (opts->mask & NVMF_OPT_ROLES)
-				nport->port_role = opts->roles;
-			if (opts->mask & NVMF_OPT_FCADDR)
-				nport->port_id = opts->fcaddr;
-			goto out_free_newnport;
-		}
+		nport->lport = lport;
 	}
 
-	list_add_tail(&newnport->nport_list, &fcloop_nports);
-
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-
 	kfree(opts);
-	return newnport;
+	return nport;
 
-out_invalid_opts:
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-out_free_newnport:
-	kfree(newnport);
+out_put_nport:
+	fcloop_nport_put(nport);
 out_free_opts:
 	kfree(opts);
-	return nport;
+	return NULL;
 }
 
 static ssize_t

-- 
2.48.1


