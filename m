Return-Path: <linux-kernel+bounces-561222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3409AA60EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCFB3B8C67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949EB1D5CDE;
	Fri, 14 Mar 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jnN5REUy"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467041F791C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948310; cv=none; b=ZC/Z30mPy8LVC5bFkkRKH9cLk2wti0BGYZkjslVlqUW0meczrXg1NqqMHAdIX4HqgDoVvOZXY+efylZFJCi2tDJrMYWrUInyxaIkG0ZBvk+/JYVvpqGCgCqmo8iTUA6eTSpv6n3xFRqwmar1aBuc/sB33NWhFpNg5KpZIiXF7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948310; c=relaxed/simple;
	bh=P7YjAAaS79yPiR75enjK1Rxo2NYk1d3L4cofVw+VVTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmOwMNuZWK3BYIKYNbJXdFoa0uscWXakkV7pshcg2uOFhkXs/UrFzHuFFahzXrX95oNcQWufh70zgwW1p5X37PUwfz7YOpTA2r1j4SoWv6t/C83xuUEzytATBAVMo6El+kSLJ1cKtFxPU5VvxsK+B8zPOm0o2qFOQKcC77rQVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jnN5REUy; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DA1244284;
	Fri, 14 Mar 2025 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741948306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlB5MQOuYaWQrpOWhB9woaeEf6g8GikGRsA35Bq/gXM=;
	b=jnN5REUyT8QbnSBd1lYuqg7e/9eOngFqXhr8ESD7QRQvpCSeHJn/BzBaiX4OdhuLJmZ1PG
	ZAugrkJ7tR6HCzyfRempUlSl8KyIQPKPBqZZXydJoqb17taTGsg1u5pd8LnvmQz2dnWsRL
	sKSa1EzNWWYbli6wPq7bwhkSBdwdiqUdX0KuuOi4povOgf/37+VB/t443bpXM+uCp8VQEN
	GVSH91QtQXeEt1zRubonQS1Ovd9WQqY5brokaIBsbRnaedVsxGzTp8WBsHbY5YAt1y3yYG
	8S54lgUQ0UzUlzsf+kTn4wiYdxygSRMbII/ShWtYfCkccSQSmZcKIYWIhv2UIw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Mar 2025 11:31:18 +0100
Subject: [PATCH v7 05/11] drm/bridge: add a cleanup action for scope-based
 drm_bridge_put() invocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-drm-bridge-refcount-v7-5-152571f8c694@bootlin.com>
References: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
In-Reply-To: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Dmitry Baryshkov <lumag@kernel.org>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefuddprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepihhnkhhirdgurggvsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopehjvghrn
 hgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhksehshihsqdgsrghsvgdrihhopdhrtghpthhtoheprghsrhhivhgrthhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgv
X-GND-Sasl: luca.ceresoli@bootlin.com

Many functions get a drm_bridge pointer, only use it in the function body
(or a smaller scope such as a loop body), and don't store it. In these
cases they always need to drm_bridge_put() it before returning (or exiting
the scope).

Some of those functions have complex code paths with multiple return points
or loop break/continue. This makes adding drm_bridge_put() in the right
places tricky, ugly and error prone in case of future code changes.

Others use the bridge pointer in the return statement and would need to
split the return line to fit the drm_bridge_put, which is a bit annoying:

  -return some_thing(bridge);
  +ret = some_thing(bridge);
  +drm_bridge_put(bridge);
  +return ret;

To make it easier for all of them to put the bridge reference correctly
without complicating code, define a scope-based cleanup action to be used
with __free().

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch was added in v7.
---
 include/drm/drm_bridge.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 5c1e2b9cafb12eb429d1f5d3ef312e6cf9b54f47..a5accd64c364ebb57903ae1e7459034ad9ebf4f3 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -23,6 +23,7 @@
 #ifndef __DRM_BRIDGE_H__
 #define __DRM_BRIDGE_H__
 
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -995,6 +996,9 @@ static inline struct drm_bridge *drm_bridge_put(struct drm_bridge *bridge)
 	return bridge;
 }
 
+/* Cleanup action for use with __free() */
+DEFINE_FREE(drm_bridge_put, struct drm_bridge *, if (_T) drm_bridge_put(_T))
+
 void drm_bridge_put_void(void *data);
 
 /**

-- 
2.48.1


