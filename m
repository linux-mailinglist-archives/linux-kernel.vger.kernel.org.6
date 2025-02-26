Return-Path: <linux-kernel+bounces-534673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A02A469CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1450D1881FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B16235BE1;
	Wed, 26 Feb 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="c3E8mzj3"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7E23535C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594675; cv=pass; b=CVGC3uTZ+lgUVTOtUmBTuS0Eqh6G0gYVvevbDnquTSKGZKVuG66NYTquKGIchQBksPNM1TgLllsqZdLWJaG7QYSqT8wJ9XQx4/qdWIfZY08FJg1KDeC5PmG+pKwfn/debHyDnM0xanEaBw2logLk+a7w6HxWBM+HEHd2wB81fX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594675; c=relaxed/simple;
	bh=c+YMGqAnFgguqdQfrzdBQ8QGzGxzkpViK00FUjjRwfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0G27qFAMr/wbuMjbuWA6WtR/U9Ym0JIDTrOHiDHjd/m7pOxnMbF+LXfqiXMNkFOkx+E0FjUi4tp1treu0lwwwqQB3EfwrALBGlMs9kOZu0Igan9hx2948DpQDYZKfVlXlRCw3cPFlPaLDjPpWXHCMpjVxK/w7GRZZpLh9TCPm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=c3E8mzj3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740594662; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q2BWvuDK91v5pAYlhgQ3R68ijrVK7tp6x9GZ1Q/tg59cnU8I2ISurwv36gMbJm90cq4/TurUVk42dvCng+W+z9fe8cT2/lQeg60kKwXTBWGUVr3YmKVLVUmCDC23ZH75Mp9ukF+Gm62EzzOrJA9ZVfyixBoXPcUT+yaaxOMbdAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740594662; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=spHL9DChNsuSuJujNgDcb0Loo1Px9GacjVAT9YjIB/U=; 
	b=jrZ8RTHjNVau5iF/di6DVQjO1X4n6s0HlPjZRVKBeXergR8Fio35bmkD2ZbigMlkyGVP4yV3Ze0YyrznGpqjVhWdAVENEu7/Ej23RPvdKCtZVHQxVOMTxbkvWctl7cWn4P65wN2K9DCJDld2b8TT3XjKewhy9PKcyxMD6bnP8BQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740594662;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=spHL9DChNsuSuJujNgDcb0Loo1Px9GacjVAT9YjIB/U=;
	b=c3E8mzj3Ngexvafdh6DfpgeMOnyQxQpzv/c0J4CywtAhcSVEW/n+z/OJAmy/b65I
	bizeV+2vlerIoY8oPNX7UuxfpQkAMBe9zN3Tack0CZHk4714Kho1lbEhulrw5u8Ehdd
	NnWumHzFFGfTlKOXW2vlNXwcrgMdPjXzbLmETYVg=
Received: by mx.zohomail.com with SMTPS id 174059465987479.41071816976432;
	Wed, 26 Feb 2025 10:30:59 -0800 (PST)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [RFC PATCH 2/4] drm/panfrost: Split LPAE MMU TRANSTAB register values
Date: Wed, 26 Feb 2025 15:30:41 -0300
Message-ID: <20250226183043.140773-3-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The TRANSTAB (Translation table base address) layout is different
depending on the legacy mode configuration.

Currently, the defined values apply to the legacy mode. Let's rename
them so we can add the ones for no-legacy mode.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_regs.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
index b5f279a19a08..4e6064d5feaa 100644
--- a/drivers/gpu/drm/panfrost/panfrost_regs.h
+++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
@@ -317,14 +317,19 @@
 #define MMU_AS_STRIDE			(1 << MMU_AS_SHIFT)
 
 /*
- * Begin LPAE MMU TRANSTAB register values
+ * Begin LPAE MMU TRANSTAB register values (legacy mode)
  */
-#define AS_TRANSTAB_LPAE_ADDR_SPACE_MASK	0xfffffffffffff000
-#define AS_TRANSTAB_LPAE_ADRMODE_IDENTITY	0x2
-#define AS_TRANSTAB_LPAE_ADRMODE_TABLE		0x3
-#define AS_TRANSTAB_LPAE_ADRMODE_MASK		0x3
-#define AS_TRANSTAB_LPAE_READ_INNER		BIT(2)
-#define AS_TRANSTAB_LPAE_SHARE_OUTER		BIT(4)
+#define AS_TRANSTAB_LEGACY_ADDR_SPACE_MASK	0xfffffffffffff000
+#define AS_TRANSTAB_LEGACY_ADRMODE_IDENTITY	0x2
+#define AS_TRANSTAB_LEGACY_ADRMODE_TABLE	0x3
+#define AS_TRANSTAB_LEGACY_ADRMODE_MASK		0x3
+#define AS_TRANSTAB_LEGACY_READ_INNER		BIT(2)
+#define AS_TRANSTAB_LEGACY_SHARE_OUTER		BIT(4)
+
+/*
+ * Begin LPAE MMU TRANSTAB register values (no-legacy mode)
+ */
+#define AS_TRANSTAB_LPAE_ADDR_SPACE_MASK	0xfffffffffffffff0
 
 #define AS_STATUS_AS_ACTIVE			0x01
 
-- 
2.47.2


