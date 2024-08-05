Return-Path: <linux-kernel+bounces-274389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E209477AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B4E1C213F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23B1547FB;
	Mon,  5 Aug 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="nilAbEbG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9SWiOXW"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D04153BE8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848061; cv=none; b=m9ceL13mSzmp+1nWafBufF09pq49lNZwX5sxnJZqgmDvJ5riZ7it/xy+73a5GKX5qxtyRFsss5ZcrVfxmWKfCetz8bbFqmTJVg2n9OALNlsTnfdMDa16iTIuo9alkFqt7NIxfluHYQSq2KxQWHosvcXTALauVq5o2d0v4oLpZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848061; c=relaxed/simple;
	bh=cscKU5uPCciyY7dYw/8esZBE005/LOUY76gf8+d1Fko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUcW1p1xx5vBd+7lqyZZJnBwiJvmES6qgSxzILSmoHEtLQSDgDajG7esoBtnmuvQUVHsmH04OoVeE30ui0t5lqi9AWLsl7R0BwPG1AJ/lF7utxkXq3uccNBhrIBwL2nmyJLhgFJPr5ue+/1z+Te3NNIYG1weTNzQmbUoqUTmLj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=nilAbEbG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9SWiOXW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id B0358138FD80;
	Mon,  5 Aug 2024 04:54:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Mon, 05 Aug 2024 04:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848058; x=
	1722934458; bh=Qc/S6YXZ+4o3poTVbyilyGCeWi9HX+4N+cgNY9BibBI=; b=n
	ilAbEbG2omaCte4zRoqkz89Be0gWKCrs08zudKNowYZpU7T3+il94kohdq7vAGpM
	sSrfa0iiFRQJpjIMarG4ftE3+dw064VL9277vx+MoUoEm+DTdRghuiZzCEJ3qQ8G
	z6YCNr4hc5aB6VR4hKuPAw484tpAjTGWFwidceYrgHoYSLoyjnbjfoeWSd9oamfF
	FPkXA37f5e+dNgx64jGUEFl75nrd26u2F1Sb+Qt8J7e742hjC1BpIGea+XYaWAXk
	aBhsceK+zlVPzowOlLeEbb9YtDiMJKbyQJT8W44DZDYgmWTDbI9PdqjtbQEdhACE
	9pHD5bMeux9tkbIjydvng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848058; x=
	1722934458; bh=Qc/S6YXZ+4o3poTVbyilyGCeWi9HX+4N+cgNY9BibBI=; b=U
	9SWiOXWfPBTsV98mfVsZx2ImU6H906iY1bvCvhkAIM6mKhXdO66O0inuoFmQoWPp
	BaCp85k8HsL82et6jRol8WtPsbHdC+1mIqMcCcwAHeo/u3ImKZ/1FVbhqu0cR8ex
	LMJuioCfsR80vAXzqVWQbbFImDhcf1aOcBwo82Ati1iPgDAivpv9IIb4Lh0DlbjO
	K6ueboBW/gnfH7GRrCBvSp8b0D6atvdLMSWWzlmT0e896kloKeyijOTlvhPzlkk1
	xcC+3keb7ZIsYQIeRLRX1ocSv/MgrWCFw6G+M/a86x6Su9eLOf83enfYGTsdu/mw
	sL3wigY/LL0/lLkkmOJLg==
X-ME-Sender: <xms:OpOwZoqxZBEO6zJqq2ngAwsL4Imit2F5xdTSSUN1uw7AI861eEvThQ>
    <xme:OpOwZuqvj35qD5pCiUWPoyVbacau0h7hGOuJI_u26FXNvd4WE0YH_oNbmZxf70Xri
    rS5El3PmJr_26_oipA>
X-ME-Received: <xmr:OpOwZtN6Ugoc3vhwiX8WkzxewSoUDJP8G6o0uz7W1IYO1Hfv3wKEo4PdA1GsjCLKXTuVtOclk16K3sZtvPs-gtDPMbwBS2OcqfbhD0HJEhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:OpOwZv5J3_j5tVMYrxfc8ipLEQkwZAy6Prj4KLm8UrN7cozZpRNB9A>
    <xmx:OpOwZn55-Enoub6nVpPscedYhdvx9dEwFNO44EEdOoISWaVvSUVOfw>
    <xmx:OpOwZviKAYGhoyBbPSZuCdtDmNlRu5EoBBEfsoAFh2gcNlrrre4njg>
    <xmx:OpOwZh6NwO88IPDpuvILQggsFkLRZVr3Dgt3RL6Bc2t-ZB7gZVIG0A>
    <xmx:OpOwZnH4fWqgO2nyIQSizCI5IxlY6YtkDsBkn5emNBPkb9XGTdfBjTWf>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:17 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/17] firewire: core: use guard macro to maintain RCU scope for transaction address handler
Date: Mon,  5 Aug 2024 17:53:56 +0900
Message-ID: <20240805085408.251763-6-o-takashi@sakamocchi.jp>
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

The core function maintains address handlers by list. RCU is utilized
for efficient read access to any entries in the list.

This commit uses guard macro to maintain RCU locking and releasing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 35 +++++++++++++----------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 2a2cbd6e2f9b..a0224d4d8e11 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -925,16 +925,14 @@ static void handle_exclusive_region_request(struct fw_card *card,
 	if (tcode == TCODE_LOCK_REQUEST)
 		tcode = 0x10 + async_header_get_extended_tcode(p->header);
 
-	rcu_read_lock();
-	handler = lookup_enclosing_address_handler(&address_handler_list,
-						   offset, request->length);
-	if (handler)
-		handler->address_callback(card, request,
-					  tcode, destination, source,
-					  p->generation, offset,
-					  request->data, request->length,
-					  handler->callback_data);
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		handler = lookup_enclosing_address_handler(&address_handler_list, offset,
+							   request->length);
+		if (handler)
+			handler->address_callback(card, request, tcode, destination, source,
+						  p->generation, offset, request->data,
+						  request->length, handler->callback_data);
+	}
 
 	if (!handler)
 		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
@@ -967,17 +965,14 @@ static void handle_fcp_region_request(struct fw_card *card,
 		return;
 	}
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(handler, &address_handler_list, link) {
-		if (is_enclosing_handler(handler, offset, request->length))
-			handler->address_callback(card, request, tcode,
-						  destination, source,
-						  p->generation, offset,
-						  request->data,
-						  request->length,
-						  handler->callback_data);
+	scoped_guard(rcu) {
+		list_for_each_entry_rcu(handler, &address_handler_list, link) {
+			if (is_enclosing_handler(handler, offset, request->length))
+				handler->address_callback(card, request, tcode, destination, source,
+							  p->generation, offset, request->data,
+							  request->length, handler->callback_data);
+		}
 	}
-	rcu_read_unlock();
 
 	fw_send_response(card, request, RCODE_COMPLETE);
 }
-- 
2.43.0


