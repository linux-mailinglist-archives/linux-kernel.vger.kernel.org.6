Return-Path: <linux-kernel+bounces-524917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2CA3E8B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF3C19C3575
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB17267B13;
	Thu, 20 Feb 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lPMEb5bI"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43E26389E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094929; cv=none; b=uLGM3ldOqk6XhTDC1S75uov064dqQYrgyHRTapiuqiqGV6Xrjuy3qstEEgDir5USW6HUZjRqfdD3oE89WiYJvrmuFCy33B8WoyqjX56bT+s7m1NGVJeo3jh+IO1ADau9e0+yeIf5rnxjyO8uL7KJZX/NTh5XB1F+PZNlO/wE8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094929; c=relaxed/simple;
	bh=Loy+u2W6mTad4wG5QE0+AHtwRi2IesgDd6Xo4jwfNA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcH3Uc6HsHFb3JO87e/WZ7EClrWbwwYG2i4ffQiEBqLf0s6s1ZaXVS4+XyuFDA75T6UrXMAmSlyQBpqysbqNDa+ennyPKJd57YoHVt+aFxYGqcuTH+ju0VDSt1JvNyyjJp1nx3S8ppKVYqd495wigxQoLHzr+PyMQaqObMRM+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lPMEb5bI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8ei/G/C+Q2EB4HolW6F+KXHikaTWJisX5oA6+ZThEK8=; b=lPMEb5bIU9ybnKqWwCujlG8mZ+
	+nrXybstNXgJrS/gk9FKpnPBrt4LdexLrxAh6ngSYgDYdscNrm6grTGIh8daT0i+/744cO/kTGtXm
	TrFzZq+Gn+1Yht+okl3AuxMo3ck21UwFeXLBjS+Hsfj+CbOld+kzMEqUp1/y5hU4oWbPpD01ChFC/
	h1QLCsBnTcXxKx8caaERXETyL5XSBgpMQVJjRrckjGVzDawDcdr45XOa2ly1HqleO1TcY9xMxkSGS
	EaZpdkB94mynONN90I4JJF+taU3sCB+jOfuxVRkoSeX+BjPUbDP3K2xmv1vjFFV5Q3bJ8TtvfgX0Q
	Wq1eJi0A==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlGAy-0004Wc-Dt; Fri, 21 Feb 2025 00:41:52 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: gregkh@linuxfoundation.org,
	heiko@sntech.de
Cc: rafael@kernel.org,
	dakr@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de
Subject: [PATCH 1/2] drivers: base: component: add function to query the bound status
Date: Fri, 21 Feb 2025 00:41:40 +0100
Message-ID: <20250220234141.2788785-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220234141.2788785-1-heiko@sntech.de>
References: <20250220234141.2788785-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The component helpers already expose the bound status in debugfs, but at
times it might be necessary to also check that state in the kernel and
act differently depending on the result.

For example the shutdown handler of a drm-driver might need to stop
a whole output pipeline if the drm device is up and running, but may
run into problems if that drm-device has never been set up before,
for example because the binding deferred.

So add a little helper that returns the bound status for a componet
device.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/base/component.c  | 14 ++++++++++++++
 include/linux/component.h |  4 +++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 741497324d78..d63e01f4851d 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -569,6 +569,20 @@ void component_master_del(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(component_master_del);
 
+bool component_master_is_bound(struct device *parent,
+	const struct component_master_ops *ops)
+{
+	struct aggregate_device *adev;
+
+	guard(mutex)(&component_mutex);
+	adev = __aggregate_find(parent, ops);
+	if (!adev)
+		return 0;
+
+	return adev->bound;
+}
+EXPORT_SYMBOL_GPL(component_master_is_bound);
+
 static void component_unbind(struct component *component,
 	struct aggregate_device *adev, void *data)
 {
diff --git a/include/linux/component.h b/include/linux/component.h
index df4aa75c9e7c..9d6c66401280 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -3,7 +3,7 @@
 #define COMPONENT_H
 
 #include <linux/stddef.h>
-
+#include <linux/types.h>
 
 struct device;
 
@@ -90,6 +90,8 @@ int component_compare_dev_name(struct device *dev, void *data);
 
 void component_master_del(struct device *,
 	const struct component_master_ops *);
+bool component_master_is_bound(struct device *parent,
+	const struct component_master_ops *ops);
 
 struct component_match;
 
-- 
2.47.2


