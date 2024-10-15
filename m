Return-Path: <linux-kernel+bounces-366721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0D99F90F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B35428408B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7881FE0EF;
	Tue, 15 Oct 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GMrs4nau"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538481FBF52
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027667; cv=none; b=V17IKgywFEJYaTA3Tqks01MCNwlk5+n6Ogga/9uv/BQsNNq/WhUvDvTjfahdT6jySl6ot4STCvn0OvfnH3uouWYknLKoqHtp487JeYWkMzXQ00+FvMZ7a93n3FEFwmbhaiCSV6T9XynWrIG1FKg6cv1gyoeqds1/vvxiYmssM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027667; c=relaxed/simple;
	bh=LUYhe9VHGlNz08wkcVEoMhN03ZHvrxBxGdQ3Fz1JnbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sE7ImU6bSzk1dxBqTLKuwGFAwCwTysRLN76/N99v1ZlZQfvZsl0MAXI5vXSEa1tqbZsBRyUbqt5NUTCIhx2b4jGyS3To6CAx6L/M9Z0fMVNt+aBrtt5b9IP7Zw27y8dGYj6jv4SE0bbUnZ00+1purEH0BkZYJks2YU+wjKGVNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GMrs4nau; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729027663;
	bh=LUYhe9VHGlNz08wkcVEoMhN03ZHvrxBxGdQ3Fz1JnbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GMrs4nauD3DWAtU3TrhQDz41pEJedlZGt9I/ZG9+Y7kgOje+X1pbgsd8GLRK0+TnD
	 DukLXXb8mQ/n1EWyaJJUWmKh7aSu6tCoBsh8BrAK+lUrGaGEuURwVd5R7RdXKg+x3b
	 PLKfCUSzEkHUk1S1DMHbCO7PWuKkBA39NteNMwyqLbjOFcLUEVGX8U5W1XUy7NNdLD
	 Yq7BLbLWvuUgTJyMiIv9narmH+1rkM9zh5dHzkVbINVzWXEKV0qFiQe/zc/eppIY5i
	 AaZWhn/6OnGgEo65ZCA4D0VQq+5bL7GLix6F9FZLnVjnviRz8dIDdkTq0p6MS8Pdb+
	 xVqABTn1QsHBA==
Received: from [192.168.1.206] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 53DF117E374C;
	Tue, 15 Oct 2024 23:27:42 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 15 Oct 2024 17:27:17 -0400
Subject: [PATCH v2 1/2] driver core: Create device_link_is_useless() helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241015-fwdevlink-probed-no-err-v2-1-756c5e9cf55c@collabora.com>
References: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
In-Reply-To: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 Jon Hunter <jonathanh@nvidia.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Create a device_link_is_useless() helper to encapsulate the logic that
checks whether a device link is useless and use that instead.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/base/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b69b82da8837ebb6b3497d52d46a43e26ea1c64a..88a47a6e26d69aacbaeb094c42be4fcf9dde4a6b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -668,6 +668,19 @@ postcore_initcall(devlink_class_init);
 #define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
 			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
 
+static bool device_link_is_useless(u32 flags, struct device *consumer)
+{
+	/*
+	 * SYNC_STATE_ONLY links are useless once a consumer device has probed.
+	 */
+	if (flags & DL_FLAG_SYNC_STATE_ONLY &&
+	    consumer->links.status != DL_DEV_NO_DRIVER &&
+	    consumer->links.status != DL_DEV_PROBING)
+		return true;
+
+	return false;
+}
+
 /**
  * device_link_add - Create a link between two devices.
  * @consumer: Consumer end of the link.
@@ -771,13 +784,7 @@ struct device_link *device_link_add(struct device *consumer,
 		goto out;
 	}
 
-	/*
-	 * SYNC_STATE_ONLY links are useless once a consumer device has probed.
-	 * So, only create it if the consumer hasn't probed yet.
-	 */
-	if (flags & DL_FLAG_SYNC_STATE_ONLY &&
-	    consumer->links.status != DL_DEV_NO_DRIVER &&
-	    consumer->links.status != DL_DEV_PROBING) {
+	if (device_link_is_useless(flags, consumer)) {
 		link = NULL;
 		goto out;
 	}

-- 
2.47.0


