Return-Path: <linux-kernel+bounces-265796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A393F611
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE951F228DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F684148304;
	Mon, 29 Jul 2024 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="gWEudYUT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CM+xpBce"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DF1420D0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258156; cv=none; b=ilLRfQfGFX4U2KDMH6rsorB5nbF3laiD/wpSZLswsqSpmB53TkV+LsjE7AIDwN1OAkypvnSaxh3XAU6fhzbhvnEY3YEKH54+2imn4doz8eSgqwSAEblXeCCDVPbQmKXR5fd3GcT3CIkm6zneeUc94GicL/eh+XXUi+SjEBZVoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258156; c=relaxed/simple;
	bh=04q5bqqX+y25zavlP8QbkWiR+H/gzCvq8zQ4k7IsM8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCHkyrFhnshW1fSpZE+7Ni1nOH7cmq5Tp4z75ej9g6NWFXn3u1MNEcGGUOB8h1Qtqjpu4D/Y77wPTnUS9Eu9TW/C62eTquUfnnEoSGtS7Bvek5+GgCq8cAPacxrZ3MjNYwypHhz2hqGSbYzNbrQounr3uoTzSywmrMS3BXpjgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=gWEudYUT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CM+xpBce; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6053B138010E;
	Mon, 29 Jul 2024 09:02:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jul 2024 09:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1722258151; x=1722344551; bh=aeb3978Igkxko1nbjSnsq
	uTkOB9Ewk8mId09iKGKN1E=; b=gWEudYUTSqNTtgF0RrEOytLCcKoXFD88LJ7qi
	sC7ZL6rw0oDF7pnz9CbDrzeFwkQ9/oTDR8dlOchhf1k74ZhLY9/wAeJaU34ppDkY
	fRi47rLnBX9elCg0XSKfgbsdudb/06tS+LpvluJn/xrxCY1hXT/R8aOPKPADGXkT
	v9p79sZhTB4tDX22G/FWdyg7bCuL9demLC34fZN/lWTc7D1I7MwxomsuWxjhDExM
	0JTlxga2Mp9RCmCgKQ03v4CMU3l9qsHef54TrnhHLIDxC1hjmNQtH7uHAGnqK4eY
	wOr6+QV4JaThgPHXkb3F7+VTAen+1sW0Xu2wlOZ8uz7jqj0Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722258151; x=1722344551; bh=aeb3978Igkxko1nbjSnsquTkOB9E
	wk8mId09iKGKN1E=; b=CM+xpBce/KfKua7TQub/byOXuK8tjtHAu8JiUiiMm2q/
	587NezuD7RuJ6XNmOHNYYf1Paz7OhF1mLwvYsNjRH2y+b8m/7b2HW/xtTEF7nvoo
	uV3ZRW+rYYduQewajhntFOibas1ZITQ/ATsni61wY9he+vvGjbT5C+zrMrJk16p9
	7LGxdhfV0sYJRxIYB895QV2WhDK2uENoiiAfcsbcqOzkUi7p2r3Gim+hK5cXWRL4
	YRDPgn2l/YYJ79Le90GrN42h0E0WdfOwL0hg6/nr1rbgyrb1d+LghYIQRGSDAmAp
	YUHA8eW8Olvm64tMNL+mZF+uzWlWpr4RDu/O9PafoQ==
X-ME-Sender: <xms:55KnZjP9qakcFLgpCZbpU7EkqDEcjRvDaS_HbdJGA-0_JzmMXOjvLA>
    <xme:55KnZt-81uOWU6XOeNHWEzIK4utcSfXRcN1FTnLbB5hKiH8ALvPzbh3Afo2OuognN
    raszdvRZwD_6xY>
X-ME-Received: <xmr:55KnZiQdE2flJ8mf2Ek4ViX7d6Qppy7UUZng4UXuQE9IAqleXBIk5GrtSkGYKXOZKoSWLC0L9H-eJ1dQgbMcPtE_QYtDqbwrKEcb4Ldm6QUpEvFR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifhrihhffhhinhcumfhrohgrhhdqjfgrrhhtmhgrnhcuoehgrhhi
    fhhfihhnsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeekvdfhkefgtdeugf
    elueejffelueeludegieejtedtveekteetieehkedvkeevleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhhifhhfihhnsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:55KnZnssZWmF7VsxNu11Ijnh-49nBz0P6Y1YuHR4cscOZ5y8QFn6wQ>
    <xmx:55KnZrc2sq0BA0DkL-J7P8qe9zOGkAIO4Y64QtIVomloljD3TxLPBg>
    <xmx:55KnZj1SpLUA3lTMMvMgLtLfanBGkKGz4LYgQCzZ8zd8AH8jtCyjWA>
    <xmx:55KnZn9jsyFyINzW8sbj1TBuyrcjzsXWqOz4B3KIJv7r2HLiU1fuNg>
    <xmx:55KnZi5DOFoVBpnDFeDAMORWP34klVSmUNRqh1i6oBH-GhcrhqSc_jSD>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 09:02:29 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Griffin Kroah-Hartman <griffin@kroah.com>
Subject: [PATCH 1/2] staging: vme_user: vme_tsi148.C: remove redundant newlines
Date: Mon, 29 Jul 2024 15:02:12 +0200
Message-ID: <20240729130213.48941-1-griffin@kroah.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/staging/vme_user/vme_tsi148.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 9066c53150ec..9b1e9fd9ff20 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2505,8 +2505,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_master:
 	/* resources are stored in link list */
 	list_for_each_safe(pos, n, &tsi148_bridge->master_resources) {
-		master_image = list_entry(pos, struct vme_master_resource,
-			list);
+		master_image = list_entry(pos, struct vme_master_resource, list);
 		list_del(pos);
 		kfree(master_image);
 	}
@@ -2603,8 +2602,7 @@ static void tsi148_remove(struct pci_dev *pdev)
 
 	/* resources are stored in link list */
 	list_for_each_safe(pos, tmplist, &tsi148_bridge->master_resources) {
-		master_image = list_entry(pos, struct vme_master_resource,
-			list);
+		master_image = list_entry(pos, struct vme_master_resource, list);
 		list_del(pos);
 		kfree(master_image);
 	}
-- 
2.45.2


