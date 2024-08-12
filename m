Return-Path: <linux-kernel+bounces-282480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E094E489
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711981C2112C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4954E7404E;
	Mon, 12 Aug 2024 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="S856z2uj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sOX8uFj9"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD5482DB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426981; cv=none; b=OAtDgEToR21RwC1CR6zWe3W9rrlFj4ohuSXx0048mbgFvRWgwYX4hKegrrWZxGKni5x23GuRFz3x97a+6SL76ScK0H7gdHU5TEOCPRtsjUeR/OGkk57p0XLZwtwesxU0M4th6u5HskoVUCqkvcod7op4iCrlUaPAUUz26Jm6/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426981; c=relaxed/simple;
	bh=TpYQD071S1KYSOCy8p4Xq+KnhZa0VI3Yd7ChhcLowQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jweGqOPwn6/enbVpZKHkgnwWmMXiFd/UJmrrURjr6RbBBxTzlpZcYAgfXiNJe5gI7rSLPQXbbGZ4BTYNVTPnNWfT7BudJ80c4v0wcjK+D82sZRZFqCG0K64n+OC3PXzOEFx24Doi6dXZ1O0dA7MCVWQ1kkLwHQp0VSEF39EQpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=S856z2uj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sOX8uFj9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 955AD138CD52;
	Sun, 11 Aug 2024 21:42:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 11 Aug 2024 21:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723426978; x=
	1723513378; bh=losiMWDobhTks5tA1JStZawdF4CWd89Wr88BY0X0J1I=; b=S
	856z2ujthWfeYklekkjlx4LFhUWDfY9dFo4sjr9oFyDNhHzuHQT0obhKuipSSOf2
	yRngsinvk6+x6Y4FM6zcf8R/UQVF3mk4j+IFxFwalVjzU4CEdd1QdWklaeZBFE2q
	+iuuPocxPHYXjkCijVTlaTXJ/zTD7U/azmRQwrFUfpDRbs61PWuY7T/jMuKUb9G0
	sxEGaErkNkQKBnIpwIZkiQcLq2mlsaTdTiP0ngWc0SIMy7DeBT/b4rf80WrRvJv8
	aKWn2wZnE+qEFyFIJAjNtoVqct/2eAgdJ7Im8PE9IYT633rhV5hBYMloo/+7FLdH
	q09l/y3dXfL3iNpwAoonw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723426978; x=
	1723513378; bh=losiMWDobhTks5tA1JStZawdF4CWd89Wr88BY0X0J1I=; b=s
	OX8uFj9c3FMexS4a0P6Ju4eFPhBgIkojEOXkQX2r8kosbSPVuNIXkdAGnXNAdAhr
	MjHDUd/q3v+v6R6vmxzP2C8TQfIEuWaYneMWoSnDywirhXr/hdkO1ZxjtJ7aqmRs
	f3lvxifm6WjYptGzE+SQj7L+0EywXEXPjQ28KbOrcTdiCFB8/24O/biRznMTEBhr
	izV9b3+yjNLP+uXexF41L2Cx4wvbvJxkuRTzBWhjca+pGSYbERiNDUrY+xWAJPcH
	5iGPQRYKfvWUICDN0EjyO7k9iHZZRi7F8TldBEcKRbNRpR9bh3YKl0NugcutPpVH
	e50ZQgLyb0fh6QsHXZiTw==
X-ME-Sender: <xms:omi5Zmzg_7cyZKH5vr-gEhbGMp1kIGbNcftb-aQgsBRnPW79HJjx1Q>
    <xme:omi5ZiSyGQ9zqRwFS3qwxd--OgIEn02CohfF5aHYbXuXqx9hajV3VgDg8usmXDwri
    Y-rObtVnK5o8DMITZo>
X-ME-Received: <xmr:omi5ZoWJjewE2Gk6XxhOAOh6gZXGV0bLLuEKWZW3tNbm5GA5lIAMvRPtJB4RhuzzeBCBf2qoBoudgkuc0Vc5eUta_RD2TsevAgryOhORcPRPAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhho
    thhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrth
    htvghrnhepvdejgfejuedvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffek
    vddtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepoh
    dqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlh
    eslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:omi5Zsh3UENwNHXnT5Tkg7S_78k_gZ8oNuukKUIsoFJsEhWCAf9LqA>
    <xmx:omi5ZoB0hA12oJevx0NBXpMB1sOz8q82Nxf8vtVVojp-bNlgOS3tJw>
    <xmx:omi5ZtI296jEcOY-1YBm0wPirttJJqNrQddDNWqBi4h6WLXo8LaQ6w>
    <xmx:omi5ZvCUuCQ-TxVJ7myfXk2kXUPjT0AQeJsRjtQtEoryNkmO2LVgKg>
    <xmx:omi5ZrORuRUJy6pmOeLp8l_I0iH20SBTedgB3KlyDT2jLwTcBJbBU5xO>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Aug 2024 21:42:57 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: core: use lock in Xarray instead of local R/W semaphore
Date: Mon, 12 Aug 2024 10:42:51 +0900
Message-ID: <20240812014251.165492-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812014251.165492-1-o-takashi@sakamocchi.jp>
References: <20240812014251.165492-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data of XArray structure includes spinlock and requires no external
lock, while the data is still under the critical section by
fw_device_rwsem.

This commit deletes the critical section.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 9f3276aa463a..32ac0f115793 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -806,7 +806,6 @@ static int shutdown_unit(struct device *device, void *data)
 
 /*
  * fw_device_rwsem acts as dual purpose mutex:
- *   - serializes accesses to fw_device_idr,
  *   - serializes accesses to fw_device.config_rom/.config_rom_length and
  *     fw_unit.directory, unless those accesses happen at safe occasions
  */
@@ -819,8 +818,6 @@ struct fw_device *fw_device_get_by_devt(dev_t devt)
 {
 	struct fw_device *device;
 
-	guard(rwsem_read)(&fw_device_rwsem);
-
 	device = xa_load(&fw_device_xa, MINOR(devt));
 	if (device)
 		fw_device_get(device);
@@ -874,8 +871,7 @@ static void fw_device_shutdown(struct work_struct *work)
 	device_for_each_child(&device->device, NULL, shutdown_unit);
 	device_unregister(&device->device);
 
-	scoped_guard(rwsem_write, &fw_device_rwsem)
-		xa_erase(&fw_device_xa, MINOR(device->device.devt));
+	xa_erase(&fw_device_xa, MINOR(device->device.devt));
 
 	fw_device_put(device);
 }
@@ -1087,12 +1083,10 @@ static void fw_device_init(struct work_struct *work)
 
 	fw_device_get(device);
 
-	scoped_guard(rwsem_write, &fw_device_rwsem) {
-		// The index of allocated entry is used for minor identifier of device node.
-		ret = xa_alloc(&fw_device_xa, &minor, device, XA_LIMIT(0, MINORMASK), GFP_KERNEL);
-		if (ret < 0)
-			goto error;
-	}
+	// The index of allocated entry is used for minor identifier of device node.
+	ret = xa_alloc(&fw_device_xa, &minor, device, XA_LIMIT(0, MINORMASK), GFP_KERNEL);
+	if (ret < 0)
+		goto error;
 
 	device->device.bus = &fw_bus_type;
 	device->device.type = &fw_device_type;
@@ -1152,8 +1146,7 @@ static void fw_device_init(struct work_struct *work)
 	return;
 
  error_with_cdev:
-	scoped_guard(rwsem_write, &fw_device_rwsem)
-		xa_erase(&fw_device_xa, minor);
+	xa_erase(&fw_device_xa, minor);
  error:
 	fw_device_put(device);		// fw_device_xa's reference.
 
-- 
2.43.0


