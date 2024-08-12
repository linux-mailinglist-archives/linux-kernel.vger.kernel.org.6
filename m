Return-Path: <linux-kernel+bounces-282807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E1C94E8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F1C1C216A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE7815C156;
	Mon, 12 Aug 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qDMYfR4M"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3615217F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452545; cv=none; b=Pkcy2yVMjjFDx450bKaOVYL6cRMWBYYIBDBPlXnZB7WRZ1It3CurpW9XytSsWm0DAVwct4FxmjBDgy1Vu+62TWAj/m2/Q5XvkXoPCAyVFkco5mNUM+WRPZBEpWfgapmyWNUEiIvGVSkMJpo1TxHMzHQyeBTMVbZ5ofyQUMiGHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452545; c=relaxed/simple;
	bh=H+Q0W0+C7vO21Ng0vfwJ15BU2bl0i2IFYPaB7vs4sgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxIKqi/tpFRrhI67qL2B+1/JhL3jcuHoz4dTjy8kZSeuoKFcfUefylOGHJn/dGjMxcqAybEyr0jF6WrWC1VhAFxow5aFFnk3rXYPokf2+mNM88cU1yvUchszNrH1BbdT72X49HTi5hwb56VN55xW9FB4wL0aSjGfkuaoL45t0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qDMYfR4M; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XAfPm
	CkuAJIbdSPk7lsR2wzdTAFCy4k9mQIvPCoTle4=; b=qDMYfR4MyXRlT5rxVX54W
	oBf2QYKxs74RA3PTKT9s6eqLqE1iJs90rUWn4Ecb9i217cvjkkEgnztbdJOJzpWL
	sdbzBQuW//UQpnCshnucECYI8bF8wasZDP663C+x3Dk8BLLOUFEP7pZfs8jdLdJb
	jfplDdzRCgTiHUFtA/86tQ=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3X8hYzLlmO+0kBw--.26122S2;
	Mon, 12 Aug 2024 16:48:25 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: tglx@linutronix.de
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	j.granados@samsung.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	mcgrof@kernel.org,
	xavier_qy@163.com
Subject: [PATCH v2] Ucount: Optimize the ucount code
Date: Mon, 12 Aug 2024 16:48:23 +0800
Message-Id: <20240812084823.563277-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8734ncu5c0.ffs@tglx>
References: <8734ncu5c0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X8hYzLlmO+0kBw--.26122S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww18ury7GFyDuw18uw1xZrb_yoW8Jw1fpF
	10g34UCr48Jr45WwnFgw4kZrW3Xw1F9r15tF97C39ayrnaqr1rWw1UAr1Sgr1aqrZ7Gry5
	XF4qg340yF4jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piH7KxUUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiwhY5EGWXwMfx0QABsp

Optimize the memory release operation by placing it outside of the
spin lock in alloc_ucounts.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 kernel/ucount.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 8c07714ff27d..87a773e6ff15 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -164,7 +164,7 @@ struct ucounts *get_ucounts(struct ucounts *ucounts)
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
 	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
-	struct ucounts *ucounts, *new;
+	struct ucounts *ucounts, *new = NULL;
 	bool wrapped;
 
 	spin_lock_irq(&ucounts_lock);
@@ -182,9 +182,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 
 		spin_lock_irq(&ucounts_lock);
 		ucounts = find_ucounts(ns, uid, hashent);
-		if (ucounts) {
-			kfree(new);
-		} else {
+		if (!ucounts) {
 			hlist_add_head(&new->node, hashent);
 			get_user_ns(new->ns);
 			spin_unlock_irq(&ucounts_lock);
@@ -193,6 +191,9 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 	}
 	wrapped = !get_ucounts_or_wrap(ucounts);
 	spin_unlock_irq(&ucounts_lock);
+	if (new)
+		kfree(new);
+
 	if (wrapped) {
 		put_ucounts(ucounts);
 		return NULL;
-- 
2.45.2


