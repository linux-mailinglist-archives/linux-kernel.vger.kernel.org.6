Return-Path: <linux-kernel+bounces-274387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B69477A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975481F22217
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894C15383D;
	Mon,  5 Aug 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="AANgKhgW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t5GVy5Ck"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAE14F9E6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848058; cv=none; b=Lt5IQzU7ugY1lvySEG1EKDMjJxw5ve5ApyBj5r6hZ3R2ORSTXYXnJnrN6dJNa7Y9DUGYV1s48oItDZTa/vM/W4BkEA3CywL5cZU+U3hvVcZR6+SgIyof1649qqf5NkfXeV+W/L9KVAzfDKR4ZQ14qhpYVNLN/D8Cq1dWPRfba14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848058; c=relaxed/simple;
	bh=JeyYRSMCwYlr7qNMG60tXxpFd6Zjzxm4aN90qQy7yKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWc2+CwSlUztx5BUihHTQcuEwrmL4r1wo14GqhXxYyTRlTcxQP9Brq4Pxl+tkfO8v0SYAhvKwKG2hj7sJD3hTMS8m937zWZyKcWxviFSrf6dTjNvNU6YgOZQTwnzNFDLKDcr0tEyK9stMJN1WR9cfRn9+zRDfZLtcPJx9mgLDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=AANgKhgW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t5GVy5Ck; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 10DAA1151CA4;
	Mon,  5 Aug 2024 04:54:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Mon, 05 Aug 2024 04:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848056; x=
	1722934456; bh=8IZ5bfVFLX4rIiQS2rZQ4M3BHJvsAdGdGKx2Wo29X3M=; b=A
	ANgKhgW8x+mJuguKWNA9VpSSjsBdqALT9LkFuuX90aNcSNe+5XXJGYegN4s2FjMY
	Q2j1JiLm9yuypis5IB52w63n6s7i+M1eqfRZcqXl94CLuPvzlxzTAQJbb7jD0UXI
	xbwACCI0HIEmlks4O7EjpOX7uOqO3D1SAQwzaoiSACbkl1j4r0WGdelFhM+pxlw5
	M+gRBip0EVB9u6xnwfkuX65NbIt7ZPCc4214994O/hELj9xGn0SH5k3GdiMg7biQ
	22M3GsFWHUZy8DTg2NoQs0E/WpZZriCvCKKOWWMoJKp8K9sRQgZv6M79BDaxdAgr
	YXiCfstirIuuLS6b4jzKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848056; x=
	1722934456; bh=8IZ5bfVFLX4rIiQS2rZQ4M3BHJvsAdGdGKx2Wo29X3M=; b=t
	5GVy5Ck17hD6N+cd6fF/dIcoSLiyyMgGL1zkeYC8942J1TrdxK48J3BOBcBp+D3B
	70bF3aKJ0kNIBHhg3Gear/6HCw+dHjwtPNhsdPnzVFLIvo8PejB+6QTfmnpdEtA9
	Hl0sABwKSUCzV+gWaWA/oXuhwVfWGgEsuZ/WVpc+k8IuRCn62S07msvchqdGTqiv
	4AM9s0VwTzx0T8Xy/hj5b0WqZycwBwz+9FTUK6tWkw6y+9S1CHhumIXgykUq4oyK
	agvId98UW12PH4NeLLchKMOLULt9JULzTE18cI1bV4P/IP+aRmUwvfu05AJTgU7u
	h0upm/l4RukVPIm2zuOHQ==
X-ME-Sender: <xms:N5OwZifsB9cGHMCsmaul3i7wcRRiMRBB78N-D-8czMhIVYmIK9cQGg>
    <xme:N5OwZsOydHrLxuKj_ZkuInzeIc5cgD7bAiRWPGAaSOJtsD_S3BN5rC5cXqNwTweit
    RG9NazF-GMNGo9CXr8>
X-ME-Received: <xmr:N5OwZjinb9nO6uLH29r2_vyY4bo83YGSn28OD2rkTH6CwjtspS5kOHplRdZ_g8pyGnItT9ijZRR4G5TJuJDCOERs2j95VurkG6Zqdym2gRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:N5OwZv_uSeFQk3HdsU_dbxsUpMUVYjFnkh9w0HjYpG4JteO0MrwBpQ>
    <xmx:N5OwZuugiwqO2jtp-y2e6C6zSVgsYFlVPSyHmIhRviRUMsk1b6XQaw>
    <xmx:N5OwZmFCkZN56wrw5DFpSijH-zg0zqJE7knbpmdiyCu7RynbMBCOHg>
    <xmx:N5OwZtP6hRiGk06xgS1b0YSuf6E47vojbk2UAN21Vbiv5VItd_OhXQ>
    <xmx:OJOwZn7AswjMstBN_vMeZeXZb-I88Tog3y2msDy-OL5amN7SCAf86guP>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/17] firewire: core: use guard macro to maintain the list of cdev clients
Date: Mon,  5 Aug 2024 17:53:54 +0900
Message-ID: <20240805085408.251763-4-o-takashi@sakamocchi.jp>
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

The core function maintains userspace clients by the list in fw_device
object associated to the operated character device. The concurrent
access to the list is protected by mutex in the object.

This commit uses guard macro to maintain the mutex.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 619048dcfd72..a51aabb963fb 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -375,10 +375,10 @@ static void for_each_client(struct fw_device *device,
 {
 	struct client *c;
 
-	mutex_lock(&device->client_list_mutex);
+	guard(mutex)(&device->client_list_mutex);
+
 	list_for_each_entry(c, &device->client_list, link)
 		callback(c);
-	mutex_unlock(&device->client_list_mutex);
 }
 
 static int schedule_reallocations(int id, void *p, void *data)
@@ -470,7 +470,7 @@ static int ioctl_get_info(struct client *client, union ioctl_arg *arg)
 	if (ret != 0)
 		return -EFAULT;
 
-	mutex_lock(&client->device->client_list_mutex);
+	guard(mutex)(&client->device->client_list_mutex);
 
 	client->bus_reset_closure = a->bus_reset_closure;
 	if (a->bus_reset != 0) {
@@ -481,8 +481,6 @@ static int ioctl_get_info(struct client *client, union ioctl_arg *arg)
 	if (ret == 0 && list_empty(&client->link))
 		list_add_tail(&client->link, &client->device->client_list);
 
-	mutex_unlock(&client->device->client_list_mutex);
-
 	return ret ? -EFAULT : 0;
 }
 
@@ -1884,9 +1882,8 @@ static int fw_device_op_release(struct inode *inode, struct file *file)
 	list_del(&client->phy_receiver_link);
 	spin_unlock_irq(&client->device->card->lock);
 
-	mutex_lock(&client->device->client_list_mutex);
-	list_del(&client->link);
-	mutex_unlock(&client->device->client_list_mutex);
+	scoped_guard(mutex, &client->device->client_list_mutex)
+		list_del(&client->link);
 
 	if (client->iso_context)
 		fw_iso_context_destroy(client->iso_context);
-- 
2.43.0


