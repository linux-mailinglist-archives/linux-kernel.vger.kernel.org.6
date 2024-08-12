Return-Path: <linux-kernel+bounces-283923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B818994FA70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9701C222F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EDB19AD86;
	Mon, 12 Aug 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="YRpE7b6W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wgqpdc6N"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1820C190045
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506738; cv=none; b=L2hRbWinsvpmyddySuz9djQX4iOx+cVNLKYG2r7UbYIyyct+1jCPkTt23K6S0cXXDmnpwTrv73JToYYTPeUB7Z6uajsNHzvnBIjOr5cYCtMPYmTcMghMM2LX2bavGMsf6dOE5X7SvLPDPyjo8yjzcEoNXHTMB4w3eySWOtK9Uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506738; c=relaxed/simple;
	bh=BmYNNHTv8Hiygq2iGMLsf4WXKKE+I2XbSULDmqIS6NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYYunbzjJLjQ1QH3L++uvewz7xVazl4wgGKc7govKzkMwrxkLxh4GSc7QZxRr4wefN1wZyMm+vPpLIXz4xkjMh0SsHXpa4cXyGOw9oO19FOP5yUqqZTHM6NzNEzriL2EGjygTFuliVWqIKL1RqiDcYLA7APH2Nq3L1k9mr9sFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=YRpE7b6W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wgqpdc6N; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 14AC41151B5E;
	Mon, 12 Aug 2024 19:52:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 12 Aug 2024 19:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723506736; x=
	1723593136; bh=yTavZwoWWndaIcFeLmMMJMeYE1jdKFbFedyzqbIcn6U=; b=Y
	RpE7b6WwckgERmmOHazpf9b0b/oWlE4VaJEKD32CyfRQymLlTKit7VfZC+TM+Mi/
	OZypy4b+BsjMYCk6Gqs8q/Dh1QqbF6SRhsCbCKfs4JOnYSnJUyuRAKUUgosrQt/0
	qJAzLmqdpZvt4gPUJbHoviS4Vk+48JEgn3J/EGNH44hbVjtKTjVK2QRXE6gWt2Uq
	MEtRjjX+hLPpwM0rNzvFTqhm7/pvAm5MS1kjUarUkdukQM07LnZs6MOQeKbCQqxc
	PeUcwV03OVEomV/AiSrK+NdtDlIJzoixM1FR5DBecNEvu7ydy/p6JqxtXdJ4s7uW
	5W2GQSBKgd6a/mRt2l2hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723506736; x=
	1723593136; bh=yTavZwoWWndaIcFeLmMMJMeYE1jdKFbFedyzqbIcn6U=; b=W
	gqpdc6NMIHIyLw1ig8F0MckPo2efB+yDt+E8XybJV9cjOCue4OGQD1OkczR9GFdg
	P3Ts6tWtjQKSzHPeUhsueqGXTYGk3jaaguMsS/4pczzGoahsRrhAacu1jkdwzvFt
	G5ryCS81fCm+18hW/59VSud9Yz1uHc6Epeyefjc0cf6HkBFXd9zeJr54FcwZV8vw
	eswQDPMCAJcW5lRHDU6LlmvBtUMUGy0S/AdaqQInaNf+DcKBBX8nNk8sA+ij05dM
	BmttuPXGLOUOHWecsYhYTTYWeweHoAU60nUV7XES5ZbZ7VzFUVzesQ/FxJZLNti8
	dmCoTqGtEx0oSIhjPLlyw==
X-ME-Sender: <xms:L6C6ZhEsqJHIvEHQ0O-voZIyDqKg0Phyd4e4dYo4B-RaxoYT-SjFoQ>
    <xme:L6C6ZmUl1MFburQklkxnpKYLh5ujaHgMCTr4FWcLzAgtX1a_BVIeE_i6aOkVYLPf-
    FUJlCLoKO_AS_Ma57s>
X-ME-Received: <xmr:L6C6ZjICaScTVNjo2DjOoYMXEEHyHfCYu6ZwjEKoR0hZvdv9frp_wGYmtIgqo5eR6F8KnPnDszg3yi_XeKeSO4ThYCAAW-ap1qdKnCdIQ8bTjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:L6C6ZnFHqsZm3NMfskCZZbVIXnJm23oj9p-wusBCSCMHTIvLHqGcYw>
    <xmx:MKC6ZnW1H6lw-G66rdM8wPjOubRm9Jw_ZUdd4E3zne7vo9_E_mKrHg>
    <xmx:MKC6ZiP9Sb7ULfKvPL_4qdZvYdSLclj795UGIE-frtAeZ7wbgysz7Q>
    <xmx:MKC6Zm3Lz6cT1lOl_VhQwdw36homAVAY7vUuB46jb0_599_pj4e9Dg>
    <xmx:MKC6ZkgcfiCT2s1KsJ21ewJ12Z2kF-UmthHrtb1wpQD-UYAiYi2elv_T>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 19:52:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] firewire: core: add helper functions to convert to parent resource structure
Date: Tue, 13 Aug 2024 08:52:07 +0900
Message-ID: <20240812235210.28458-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
References: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of local resource structure commonly have data of client_resource type
in its first member. This design sometimes requires usage of
container_of to retrieve parent structure by the first member.

This commit adds some helper functions for this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 38 ++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 81fdb2be9063..e72f91cc3711 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -139,6 +139,26 @@ struct iso_resource {
 	struct iso_resource_event *e_alloc, *e_dealloc;
 };
 
+static struct address_handler_resource *to_address_handler_resource(struct client_resource *resource)
+{
+	return container_of(resource, struct address_handler_resource, resource);
+}
+
+static struct inbound_transaction_resource *to_inbound_transaction_resource(struct client_resource *resource)
+{
+	return container_of(resource, struct inbound_transaction_resource, resource);
+}
+
+static struct descriptor_resource *to_descriptor_resource(struct client_resource *resource)
+{
+	return container_of(resource, struct descriptor_resource, resource);
+}
+
+static struct iso_resource *to_iso_resource(struct client_resource *resource)
+{
+	return container_of(resource, struct iso_resource, resource);
+}
+
 static void release_iso_resource(struct client *, struct client_resource *);
 
 static void schedule_iso_resource(struct iso_resource *r, unsigned long delay)
@@ -151,8 +171,7 @@ static void schedule_iso_resource(struct iso_resource *r, unsigned long delay)
 static void schedule_if_iso_resource(struct client_resource *resource)
 {
 	if (resource->release == release_iso_resource)
-		schedule_iso_resource(container_of(resource,
-					struct iso_resource, resource), 0);
+		schedule_iso_resource(to_iso_resource(resource), 0);
 }
 
 /*
@@ -682,8 +701,7 @@ static int ioctl_send_request(struct client *client, union ioctl_arg *arg)
 static void release_request(struct client *client,
 			    struct client_resource *resource)
 {
-	struct inbound_transaction_resource *r = container_of(resource,
-			struct inbound_transaction_resource, resource);
+	struct inbound_transaction_resource *r = to_inbound_transaction_resource(resource);
 
 	if (r->is_fcp)
 		fw_request_put(r->request);
@@ -793,8 +811,7 @@ static void handle_request(struct fw_card *card, struct fw_request *request,
 static void release_address_handler(struct client *client,
 				    struct client_resource *resource)
 {
-	struct address_handler_resource *r =
-	    container_of(resource, struct address_handler_resource, resource);
+	struct address_handler_resource *r = to_address_handler_resource(resource);
 
 	fw_core_remove_address_handler(&r->handler);
 	kfree(r);
@@ -858,8 +875,7 @@ static int ioctl_send_response(struct client *client, union ioctl_arg *arg)
 				    release_request, &resource) < 0)
 		return -EINVAL;
 
-	r = container_of(resource, struct inbound_transaction_resource,
-			 resource);
+	r = to_inbound_transaction_resource(resource);
 	if (r->is_fcp) {
 		fw_request_put(r->request);
 		goto out;
@@ -893,8 +909,7 @@ static int ioctl_initiate_bus_reset(struct client *client, union ioctl_arg *arg)
 static void release_descriptor(struct client *client,
 			       struct client_resource *resource)
 {
-	struct descriptor_resource *r =
-		container_of(resource, struct descriptor_resource, resource);
+	struct descriptor_resource *r = to_descriptor_resource(resource);
 
 	fw_core_remove_descriptor(&r->descriptor);
 	kfree(r);
@@ -1387,8 +1402,7 @@ static void iso_resource_work(struct work_struct *work)
 static void release_iso_resource(struct client *client,
 				 struct client_resource *resource)
 {
-	struct iso_resource *r =
-		container_of(resource, struct iso_resource, resource);
+	struct iso_resource *r = to_iso_resource(resource);
 
 	guard(spinlock_irq)(&client->lock);
 
-- 
2.43.0


