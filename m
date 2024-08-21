Return-Path: <linux-kernel+bounces-295370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7AE959A27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF597281F89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721E1B78FE;
	Wed, 21 Aug 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="YMTL7SeQ"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733391B78F0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237999; cv=none; b=hClkOXXQsBsSPh0Yd989xRo6rnTnp+6rQSHeRoF7e3Sij3NeQJWHQ9xfltDakSENpxzhK6C2sm/xmwcu2EqvC4DbZELLEf0aUkHozdFGNfvxqtkaauUUJTlrlbAIPVesMwrL270Em/AWur3DQJpv1gxP+qATy5XWQEznvTfSKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237999; c=relaxed/simple;
	bh=+r16e6E/NoU9KjknAuvQSKBFp/BO5QVchGpqTPpo194=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KySS5ZR3LF2ovQBCk9q9YgejhKcfAUah/8wV98jhGP+6KYrUfkPlGf6NFe4eGC2Ofo/O8ExmV+muiqvxX7ehWW+pT8mWAMVRNJZjq43AaRUM6MuVb6UOU1VaQMNOjMp7ru/4KuXHyBV2gzEpjUaFoov2ZTjED3g88Ga+ojS6zTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=YMTL7SeQ; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87DDB1483DF7;
	Wed, 21 Aug 2024 12:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237995; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TJAnNoD40VE5kpvISU24IPj7vHBlSQ5pDs+zABOQSs0=;
	b=YMTL7SeQM64uKQNcWd8bzFevbMhV0oqgifu10n6KA86rdiPH5/XtLyoqVc+EjgRrO042ZV
	WspHsUoaxdQq2QWugRBxsls/7Lr67GHSs4My+YXTlAWDHxnAO71iIh1hQNfQwz22PC9Xb7
	VFt8vRJbDCBibIR5iHN95fGK2EdFn3g2yAr7zDjHfDL/8WF7Ee/PcbuTenMYgRw/EJ90k8
	AYoiuABeJ1Qz8Zg4W8Q+Zoq3o3UwsFXw5iWE7tlW7fXqPdiWycUMIYkYy16Cy9dOQbywCK
	t5eOW43r8s7ziqZyRRTWZ7q7pax4+IRdh2JtBQWCJ44zTUryvP/r7L5kvwG0Vg==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP OTPC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 07/12] nvmem: microchip-otpc: Add missing register definitions
Date: Wed, 21 Aug 2024 12:59:38 +0200
Message-Id: <20240821105943.230281-8-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

According to datasheets DS60001765B for SAMA7G5 and DS60001579G for
SAM9X60.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/nvmem/microchip-otpc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index b8ed7412dbca..4630e96243ac 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -21,9 +21,24 @@
 #define MCHP_OTPC_AR			(0x8)
 #define MCHP_OTPC_SR			(0xc)
 #define MCHP_OTPC_SR_READ		BIT(6)
+#define MCHP_OTPC_IER			(0x10)
+#define MCHP_OTPC_IDR			(0x14)
+#define MCHP_OTPC_IMR			(0x18)
+#define MCHP_OTPC_ISR			(0x1C)
+#define MCHP_OTPC_ISR_COERR		BIT(13)
 #define MCHP_OTPC_HR			(0x20)
 #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
 #define MCHP_OTPC_DR			(0x24)
+#define MCHP_OTPC_BAR			(0x30)
+#define MCHP_OTPC_CAR			(0x34)
+#define MCHP_OTPC_UHC0R			(0x50)
+#define MCHP_OTPC_UHC1R			(0x54)
+#define MCHP_OTPC_UID0R			(0x60)
+#define MCHP_OTPC_UID1R			(0x64)
+#define MCHP_OTPC_UID2R			(0x68)
+#define MCHP_OTPC_UID3R			(0x6C)
+#define MCHP_OTPC_WPMR			(0xE4)
+#define MCHP_OTPC_WPSR			(0xE8)
 
 #define MCHP_OTPC_NAME			"mchp-otpc"
 #define MCHP_OTPC_SIZE			(11 * 1024)
-- 
2.39.2


