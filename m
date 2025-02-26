Return-Path: <linux-kernel+bounces-534728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A167EA46A83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7180E3AB1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1618801A;
	Wed, 26 Feb 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRpAsykh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466D238D49;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596417; cv=none; b=QQ4TIRm0cMYfKzMJkAwxGTNPiY+PoVOTc4Wgfgt2u8DzsfstwULfiv0YysXS1AU/q9LwakjjkmZEf34HC4gsbdpC6lQqqlgYsHdEAWBTzX2bBUlUuZIECVCkgNUmxjMp3um+ZPTpWXXOlLE/5OpZ4VZjcSNh6nnvTFuuF6d1HaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596417; c=relaxed/simple;
	bh=nINU/3SDwU0JVZBUj6U8Wd+8VzL9zMHFjz+4QIcof6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oS7f2tqMJS1Tpnm9hQpDKgh4lvZWYoCB3UvH5NZuXK3StDHRnJqLAlYBt3WRByGKUkj0/LH9ljEiEK/pBvuSaV5E1rDKp11iIf7LDe8FpZ+Xy4Ak1lfrFllIb+wnxJ4alVrT0a7LWXbTnIcAEP6/AXYuOnfbVzy4fJpEcW7vZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRpAsykh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C125FC4CEE7;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596416;
	bh=nINU/3SDwU0JVZBUj6U8Wd+8VzL9zMHFjz+4QIcof6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gRpAsykhD6sEODBRbeSnqmkit/o/zOVkOfnp/skKRLyOfoTeyCQLJ+njJtBtg3c00
	 ooZH/g1kOnJcda97bwyNdbV87Q8tJdmHgTfss4yi7epqxNrrM+0teOAiUKPEFRE6+n
	 sYAhMpBE3vfW2GcXmBRrRWfWy8YaJozj4b7u1clEDEb4iQWspjCD9fXuPY+OPbGHMq
	 A6hLyxSc3jPOw10/us6AhgRInsTh5rREFZ1b93jZQ6Ub4HDZb2Ym6jm3sX4/vTBVRa
	 Mk0tPJWpYnKA1hffSCqGwv84vVTaIhKoHt06l8rxHtzxrE5rzLxx+WMOIMQHUW/7aQ
	 cWr4MTIhQUgYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E21C19F32;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Wed, 26 Feb 2025 19:00:04 +0000
Subject: [PATCH v2 2/4] soc: apple: rtkit: Implement OSLog buffers properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-apple-soc-misc-v2-2-c3ec37f9021b@svenpeter.dev>
References: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
In-Reply-To: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5366; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=VGT73aDgrExisPNdjISnJVkIIHnoelD5MGuM7V0a2R8=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/r+lL1NSmyPFNZOUy2Z/1n4gcCDPeVftTqey/rEvjr8j
 GmetrZGRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAinVIMf2U/JbFu2vK/4zjr
 x/u/fu9frGzcM3/D0193Ld7IZ1c6PZ3M8IfbRcrjPNOc23syLkQ8O5ls0r48fmbkkvtnfu00KFc
 SbmcAAA==
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

Apparently nobody can figure out where the old logic came from, but it
seems like it has never been actually used on any supported firmware to
this day. OSLog buffers were apparently never requested.

But starting with 13.3, we actually need this implemented properly for
MTP (and later AOP) to work, so let's actually do that.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/rtkit-internal.h |  1 +
 drivers/soc/apple/rtkit.c          | 56 +++++++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/apple/rtkit-internal.h b/drivers/soc/apple/rtkit-internal.h
index 27c9fa745fd5..b8d5244678f0 100644
--- a/drivers/soc/apple/rtkit-internal.h
+++ b/drivers/soc/apple/rtkit-internal.h
@@ -44,6 +44,7 @@ struct apple_rtkit {
 
 	struct apple_rtkit_shmem ioreport_buffer;
 	struct apple_rtkit_shmem crashlog_buffer;
+	struct apple_rtkit_shmem oslog_buffer;
 
 	struct apple_rtkit_shmem syslog_buffer;
 	char *syslog_msg_buffer;
diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index be0d08861168..7e7b4f64ab17 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -67,8 +67,9 @@ enum {
 #define APPLE_RTKIT_SYSLOG_MSG_SIZE  GENMASK_ULL(31, 24)
 
 #define APPLE_RTKIT_OSLOG_TYPE GENMASK_ULL(63, 56)
-#define APPLE_RTKIT_OSLOG_INIT	1
-#define APPLE_RTKIT_OSLOG_ACK	3
+#define APPLE_RTKIT_OSLOG_BUFFER_REQUEST 1
+#define APPLE_RTKIT_OSLOG_SIZE GENMASK_ULL(55, 36)
+#define APPLE_RTKIT_OSLOG_IOVA GENMASK_ULL(35, 0)
 
 #define APPLE_RTKIT_MIN_SUPPORTED_VERSION 11
 #define APPLE_RTKIT_MAX_SUPPORTED_VERSION 12
@@ -259,15 +260,21 @@ static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
 					    struct apple_rtkit_shmem *buffer,
 					    u8 ep, u64 msg)
 {
-	size_t n_4kpages = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg);
 	u64 reply;
 	int err;
 
+	/* The different size vs. IOVA shifts look odd but are indeed correct this way */
+	if (ep == APPLE_RTKIT_EP_OSLOG) {
+		buffer->size = FIELD_GET(APPLE_RTKIT_OSLOG_SIZE, msg);
+		buffer->iova = FIELD_GET(APPLE_RTKIT_OSLOG_IOVA, msg) << 12;
+	} else {
+		buffer->size = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg) << 12;
+		buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
+	}
+
 	buffer->buffer = NULL;
 	buffer->iomem = NULL;
 	buffer->is_mapped = false;
-	buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
-	buffer->size = n_4kpages << 12;
 
 	dev_dbg(rtk->dev, "RTKit: buffer request for 0x%zx bytes at %pad\n",
 		buffer->size, &buffer->iova);
@@ -292,11 +299,21 @@ static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
 	}
 
 	if (!buffer->is_mapped) {
-		reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
-				   APPLE_RTKIT_BUFFER_REQUEST);
-		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE, n_4kpages);
-		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA,
-				    buffer->iova);
+		/* oslog uses different fields and needs a shifted IOVA instead of size */
+		if (ep == APPLE_RTKIT_EP_OSLOG) {
+			reply = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE,
+					   APPLE_RTKIT_OSLOG_BUFFER_REQUEST);
+			reply |= FIELD_PREP(APPLE_RTKIT_OSLOG_SIZE, buffer->size);
+			reply |= FIELD_PREP(APPLE_RTKIT_OSLOG_IOVA,
+					    buffer->iova >> 12);
+		} else {
+			reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
+					   APPLE_RTKIT_BUFFER_REQUEST);
+			reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE,
+					    buffer->size >> 12);
+			reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA,
+					    buffer->iova);
+		}
 		apple_rtkit_send_message(rtk, ep, reply, NULL, false);
 	}
 
@@ -494,25 +511,18 @@ static void apple_rtkit_syslog_rx(struct apple_rtkit *rtk, u64 msg)
 	}
 }
 
-static void apple_rtkit_oslog_rx_init(struct apple_rtkit *rtk, u64 msg)
-{
-	u64 ack;
-
-	dev_dbg(rtk->dev, "RTKit: oslog init: msg: 0x%llx\n", msg);
-	ack = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE, APPLE_RTKIT_OSLOG_ACK);
-	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_OSLOG, ack, NULL, false);
-}
-
 static void apple_rtkit_oslog_rx(struct apple_rtkit *rtk, u64 msg)
 {
 	u8 type = FIELD_GET(APPLE_RTKIT_OSLOG_TYPE, msg);
 
 	switch (type) {
-	case APPLE_RTKIT_OSLOG_INIT:
-		apple_rtkit_oslog_rx_init(rtk, msg);
+	case APPLE_RTKIT_OSLOG_BUFFER_REQUEST:
+		apple_rtkit_common_rx_get_buffer(rtk, &rtk->oslog_buffer,
+						 APPLE_RTKIT_EP_OSLOG, msg);
 		break;
 	default:
-		dev_warn(rtk->dev, "RTKit: Unknown oslog message: %llx\n", msg);
+		dev_warn(rtk->dev, "RTKit: Unknown oslog message: %llx\n",
+			 msg);
 	}
 }
 
@@ -729,6 +739,7 @@ int apple_rtkit_reinit(struct apple_rtkit *rtk)
 
 	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->oslog_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
 
 	kfree(rtk->syslog_msg_buffer);
@@ -916,6 +927,7 @@ void apple_rtkit_free(struct apple_rtkit *rtk)
 
 	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->oslog_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
 
 	kfree(rtk->syslog_msg_buffer);

-- 
2.34.1



