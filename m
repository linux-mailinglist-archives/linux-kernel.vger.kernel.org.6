Return-Path: <linux-kernel+bounces-268000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0AA941F30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A631C226A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0318801C;
	Tue, 30 Jul 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="F1BsCVrc"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F92183CD5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362874; cv=none; b=OXzaxlJaqXBW5hK5XIWnWudsf8kZbog1CiC7ImATZxhMoL4JVvV5CJmKQC1+Om264Q8vkU66itta0ZoN6UTJ4iuCz4jRpMCW+/8P6AGDBd+NsCA43oagp6vCGHpMTqgU3LRj+JSrL5RfFSdoSytQbItEbwSW89A5RofV4+mzhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362874; c=relaxed/simple;
	bh=bYNR/btMc8dzDhzuaBsxtAvjoc9Jjq6/rWmwqhOdxWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=APwlL1kv1hagWc1chIMCzvFNbHcFGh01nr/GXcXBgKwAhWNffZ6n41l2UJu2XtbFfjFf2GCxQvC/2G6RENMn320qsqhBllYdbclFTU/v+CRNWLR5ohoihG5L/GfswBsKlTJPAJYsyrQrjQs37V4KP+X7y5gYqFS4W8GoltlvfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=F1BsCVrc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cd48e1095aso619232a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1722362872; x=1722967672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H48IHRHyRWWq9dKQtedJa/9T79oz7qCSKd+qUxCh+SE=;
        b=F1BsCVrc1Fjr+qSivthwhGsh1Abj3zbicys6Mpk7DYRWTWLxBi8p5jD11TTlZmEv1x
         JXGRg1PE0ZZRlFx1RAbqmi39EvTA+vEkiW3g4KesRkV3Lsea89SP9ljNIXbPsQLwn67m
         kGZ2Zvx29ujFPHwFik4HHxIRbKpkvfpSF0VTvan/MSD++eyydaWvgklSBFZTqgS7ct1v
         vsqbnE487CxE2DR5KeFp9hOVkmxnRALP8Q0W1vz7F4+ZYRvUrAfQ4iLY7UINWS6lu5fW
         K7E3VLIV6Ti11Z3g0SLyTYTI/iWVZFmNkSq65lFHlVhRhd0Mu6//PidBLLhRbDL0Rkgr
         XsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362872; x=1722967672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H48IHRHyRWWq9dKQtedJa/9T79oz7qCSKd+qUxCh+SE=;
        b=NNqHWYkzR8JBT9vjxnScseddp47zLp0nvh84iJ4aHDQfUiVwXxz23KUhBnyPPrwWIX
         FWCI46Dxj+F1vuhcg0DDf2gdN5sBEvbdT7RqYEDSiE7hGwVlyznFjYiQECjpLPq5O9bi
         ALzwyLdONhgusUGy8EqKLtBUCdh/auqbElZLVhvW5i3n9a6Qd/iLB5bsg7XVo3Ln3yWO
         EeC3XAAFI2vcSudddAmN61p4vPHAFWaRSyiwCwc57ShrG8Xonp2Iy7/fNXQIl9rkGPwM
         V5Fl6RZdO9/glKEfFxIXGsTMkH27p6+yWdRtfC9AczfDRUK0UapJP8rkA7rEK14Vk0Yl
         XUZQ==
X-Gm-Message-State: AOJu0YyTJX2v60J7h8z+KIp2owyaxjJ74dKFZWARpEfisVhflHicZ2SH
	tiobzhSiyf0JRnsBl72qhCW7V/OYhA/nVc5xsc/ZgiJR37kwv+cpWEhT19cP5kBvJe40LfRRg0s
	Yaqc=
X-Google-Smtp-Source: AGHT+IGfcTXFdpNRj7O+g8JFWE4wg32EG1JY9VNUITgF3zpAtMYSf6QoI8qu+3SgYlVL0bHX53DAbQ==
X-Received: by 2002:a17:90b:3104:b0:2c8:e8ed:8a33 with SMTP id 98e67ed59e1d1-2cf2612d0bbmr12646309a91.4.1722362872426;
        Tue, 30 Jul 2024 11:07:52 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.165.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c56790sm10914941a91.11.2024.07.30.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:07:51 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Calvin Owens <calvin@wbinvd.org>,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH] wifi: mwifiex: Fix two buggy list traversals
Date: Tue, 30 Jul 2024 11:05:30 -0700
Message-Id: <ff796ca4b4f5610bc2d4a479b8cafbb595c7b3a1.1722362534.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both of these list traversals use list_for_each_entry_safe(), yet drop
the lock protecting the list during the traversal.

Because the _safe() iterator stores a pointer to the next list node
locally so the current node can be deleted, dropping the lock this way
means the next "cached" list_head might be freed by another caller,
leading the iterator to dereference pointers in freed memory after
reacquiring the lock.

Fix by moving to-be-deleted objects to an on-stack list before actually
deleting them, so the lock can be held for the entire traversal.

This is a bit ugly, because mwifiex_del_rx_reorder_entry() will still
take the rx_reorder_tbl_lock to delete the item from the two on-stack
lists introduced in this patch. But that is just ugly, not wrong, and
the function has other callers... making the locking conditional seems
strictly uglier.

I discovered this bug while studying the new "nxpwifi" driver, which was
sent to the mailing list about a month ago:

https://lore.kernel.org/lkml/20240621075208.513497-1-yu-hao.lin@nxp.com/

...but it turns out the new 11n_rxreorder.c in nxpwifi is essentially
exactly identical to mwifiex, save for s/mwifiex/nxpwifi/, so I wanted
to pass along a bugfix for the original driver as well.

I only have an IW612, so this patch was only tested on "nxpwifi".

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 .../wireless/marvell/mwifiex/11n_rxreorder.c  | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 10690e82358b..fbaecfd32429 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -249,20 +249,20 @@ mwifiex_11n_get_rx_reorder_tbl(struct mwifiex_private *priv, int tid, u8 *ta)
 void mwifiex_11n_del_rx_reorder_tbl_by_ta(struct mwifiex_private *priv, u8 *ta)
 {
 	struct mwifiex_rx_reorder_tbl *tbl, *tmp;
+	LIST_HEAD(tmplist);
 
 	if (!ta)
 		return;
 
 	spin_lock_bh(&priv->rx_reorder_tbl_lock);
-	list_for_each_entry_safe(tbl, tmp, &priv->rx_reorder_tbl_ptr, list) {
-		if (!memcmp(tbl->ta, ta, ETH_ALEN)) {
-			spin_unlock_bh(&priv->rx_reorder_tbl_lock);
-			mwifiex_del_rx_reorder_entry(priv, tbl);
-			spin_lock_bh(&priv->rx_reorder_tbl_lock);
-		}
-	}
+	list_for_each_entry_safe(tbl, tmp, &priv->rx_reorder_tbl_ptr, list)
+		if (!memcmp(tbl->ta, ta, ETH_ALEN))
+			list_move_tail(&tbl->list, &tmplist);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
+	list_for_each_entry_safe(tbl, tmp, &tmplist, list)
+		mwifiex_del_rx_reorder_entry(priv, tbl);
+
 	return;
 }
 
@@ -785,17 +785,15 @@ void mwifiex_11n_ba_stream_timeout(struct mwifiex_private *priv,
 void mwifiex_11n_cleanup_reorder_tbl(struct mwifiex_private *priv)
 {
 	struct mwifiex_rx_reorder_tbl *del_tbl_ptr, *tmp_node;
+	LIST_HEAD(tmplist);
 
 	spin_lock_bh(&priv->rx_reorder_tbl_lock);
-	list_for_each_entry_safe(del_tbl_ptr, tmp_node,
-				 &priv->rx_reorder_tbl_ptr, list) {
-		spin_unlock_bh(&priv->rx_reorder_tbl_lock);
-		mwifiex_del_rx_reorder_entry(priv, del_tbl_ptr);
-		spin_lock_bh(&priv->rx_reorder_tbl_lock);
-	}
-	INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr);
+	list_splice_tail_init(&priv->rx_reorder_tbl_ptr, &tmplist);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
 
+	list_for_each_entry_safe(del_tbl_ptr, tmp_node, &tmplist, list)
+		mwifiex_del_rx_reorder_entry(priv, del_tbl_ptr);
+
 	mwifiex_reset_11n_rx_seq_num(priv);
 }
 
-- 
2.39.2


