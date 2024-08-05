Return-Path: <linux-kernel+bounces-274391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A509477AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9AA281C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8514E15532E;
	Mon,  5 Aug 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="bMU9vwIG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7gSO2to"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7614B965
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848063; cv=none; b=rjYp5boHLW5izTY37ot5RcEkKbZaSBiki3+rKu8aSEVASCZHCI7XnvnNtMqpkFR41NGzx8L7W+2/nSaGWhQ///p0Yw/Si6nB/F6voqoJfRhELb2P1+Jyid1yaESj5QlsSCweV8PTJRT7GhTSo9ti1yNKa8pBX87We6vgwnmn3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848063; c=relaxed/simple;
	bh=cWH7ne9vlR3TeVR1Q85Yfp2ze/ZNy4hqU1VPnNmO3sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrE3F4QzzDYkG3jVEt/BcvY1/kyw+BvxlKU09Ob0fbm0ZIY1wQ6J27OQv1VXRF9xcFVF/isBkTJdUJI+g3ulDwZf+36zh7YzxbXdty4/u1QOpiERDQmo5521nw3mD6TTlDUAMk1o/lPAB7QG4/7MArWIFP3Devewgky/mXAuwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=bMU9vwIG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7gSO2to; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5D9551146CF3;
	Mon,  5 Aug 2024 04:54:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 05 Aug 2024 04:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848061; x=
	1722934461; bh=ylV0FAWwnqnELWHfpdHvBmEJyKerlndDqM/PUzAtIHU=; b=b
	MU9vwIGsccQJysQDz1zz3I8fN6RG3UJNLHZpLiAsf8eW+5JjtLES+J3OoQM7fCNp
	pcgvLjNd9faLG/K8xiTGqnfr/tz+9ketzmnzP/UTKWmf6OghQbDn0o6HzOssLI/T
	FliVMM+VGovFKn/zrroWCzt5R/VgTFmZ3o04c6FZ2IOuUKV9TbOCC04f7vxawu7U
	HycJ+waaQGb/fbfxHQAuaff1spFEduZVcM94/XvxaElhKnYJ8qOFJuXTHfy2YLeo
	dXCHkZ/i6mBsG3FIynhMq+GqD+cvIL+JU6nYxwAlL8xWLZzBPIOSpuAxFnWf0sO0
	U2iNScWh6iBZIvBsGHXJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848061; x=
	1722934461; bh=ylV0FAWwnqnELWHfpdHvBmEJyKerlndDqM/PUzAtIHU=; b=Q
	7gSO2tog4qr6Xnc7Yd4aluTsVam2eWo7VfkAbIGTkuuCUazPHLBUSJs2DVrs6Np9
	ga2H6QMnmQsFQhEjR8ik+wDWeDZyxNVH2Amxgp2y99lhPpnvThkYMgkFYsCCxEJo
	K+rgKK/3YlSXn/MXEVKWMK5VNVdgYsGG00ggWrdsJxtSup4xndHK37xviZ9NzV9B
	6XqvnYLPEu0UmdTC/5Brz4rvgsyG0ioLsXiGBnWCLx2MNg9616uhnlhkhVdL7X5E
	/Gk0v42PCWWowxGFCZ/8cw/ZMAYL2oMXacF4aHI94MHnUO8PDODSyYslVAmP4TBO
	qohgKSRgfSZevhm7Uc7Jg==
X-ME-Sender: <xms:PZOwZk66Zehc9eVVVtgFi9-obGEMOPiF6VPEn6Tns1XDVdH7YnF_Lg>
    <xme:PZOwZl6DkAR0dgDk2f2v51af9_96rplzZRW7e569rR3-yz4CCcETO6YKwM09UyTwl
    rFFTTaowNfbERFJbzQ>
X-ME-Received: <xmr:PZOwZje7ll005moVdyxNY72pKWVN-duMjVqtrnxjxZ1JqDXgwhvlpJDAM-1dQMiIa7N04WG1P7mP3ikPGnysYxjk2HZ1B5_FjRuxPrzJV34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:PZOwZpKM-NLv9yCL7TJKM20moomhd9B9UI13TONslioLUqQYM6fsNg>
    <xmx:PZOwZoLK-pBx9tCD3GMvwb-q0KmuDE-PhBSONWLmtMUijmjvw-MCZA>
    <xmx:PZOwZqyhd_mAqWQsG8o0KurhpMFOiWKlYSxHXSA_K0rF8AKoJk64PA>
    <xmx:PZOwZsLvXVhC8VmW_BnSyB3B7BR_f9bFAJO7itNFQ1GiZtqYW5GLuw>
    <xmx:PZOwZvXlrzM66ZYs2DzutLpQFPPLEdli_3BwfTs4ib8yoWYDNl4GZyTg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:20 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/17] firewire: core: use guard macro to maintain the list of address handler for transaction
Date: Mon,  5 Aug 2024 17:53:58 +0900
Message-ID: <20240805085408.251763-8-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
References: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core function maintains address handlers by list. It is protected by
spinlock to insert and remove entry to the list.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a0224d4d8e11..a006daf385e9 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -596,7 +596,7 @@ int fw_core_add_address_handler(struct fw_address_handler *handler,
 	    handler->length == 0)
 		return -EINVAL;
 
-	spin_lock(&address_handler_list_lock);
+	guard(spinlock)(&address_handler_list_lock);
 
 	handler->offset = region->start;
 	while (handler->offset + handler->length <= region->end) {
@@ -615,8 +615,6 @@ int fw_core_add_address_handler(struct fw_address_handler *handler,
 		}
 	}
 
-	spin_unlock(&address_handler_list_lock);
-
 	return ret;
 }
 EXPORT_SYMBOL(fw_core_add_address_handler);
@@ -632,9 +630,9 @@ EXPORT_SYMBOL(fw_core_add_address_handler);
  */
 void fw_core_remove_address_handler(struct fw_address_handler *handler)
 {
-	spin_lock(&address_handler_list_lock);
-	list_del_rcu(&handler->link);
-	spin_unlock(&address_handler_list_lock);
+	scoped_guard(spinlock, &address_handler_list_lock)
+		list_del_rcu(&handler->link);
+
 	synchronize_rcu();
 }
 EXPORT_SYMBOL(fw_core_remove_address_handler);
-- 
2.43.0


