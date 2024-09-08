Return-Path: <linux-kernel+bounces-320096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1997061A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A4F1F21E59
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481431474D8;
	Sun,  8 Sep 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="boJqIOB5"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222F535DC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788659; cv=none; b=ceqVrmecoXE0ccXBdH39yH85S1f/2K1ZZU/T4Wy6pkMHCU3bSiAAT+jE6CmGcN6j2RX79SH92dLd5GKVHl0jxTf7UJ+pq5YAxdUIJpNl6zRZ6kPcCtI9leG9Z73mq/5FoKJYgjFeBPl1miJ2gqTJ3eQB+2mK+XmtGeOyL0x4qj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788659; c=relaxed/simple;
	bh=gxMndmv/fRnKW066dwt13nUFwmx+L+xWVtBgbG9U8yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpaTvdRMXDfa1gXcDxeKCShUr0ZPpKdIa5KmIJaHL4enx98u88sVTi6yXJTPuOwtAWV9TGOvIDaD3YQfuWncYBM72mqmtJH8Ecqe13PZuiiAv7PUB8MNTdVaYXXJgjcQxmSiZ6piRwFWQMKrYGjoOoi2H0JGHKaHH6ZVFUO4n7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=boJqIOB5; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jewa8MDez9iiBBqGD2bipQPx4/CBs8ls2zOq7Zoe8ko=;
	b=boJqIOB50ybGVA/VgdiEV4775CYH/ZeM3lsUXtQTDeakamvaBMgPaSEYXbtv2HfS9ucZqe
	Qe2TE6SgS69GEFdxufacLTey+BBgcC2p2srxztO8iU0wga5mItxB6APmUHtRcXF+KXojP/
	0xPz8xA43ZPSipVNf7FyUCLE8ca0G4M=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 01/19] drm/etnaviv: Implement drm_gem_object_funcs::print_info()
Date: Sun,  8 Sep 2024 17:43:39 +0800
Message-ID: <20240908094357.291862-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240908094357.291862-1-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It will be called by drm_gem_print_info() if implemented, and it can
provide more information about the framebuffer objects.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 32 +++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 4247a10f8d4f..543d881585b3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -534,8 +534,40 @@ static const struct vm_operations_struct vm_ops = {
 	.close = drm_gem_vm_close,
 };
 
+static const char *etnaviv_gem_obj_caching_info(u32 flags)
+{
+	switch (flags & ETNA_BO_CACHE_MASK) {
+	case ETNA_BO_CACHED:
+		return "cached";
+	case ETNA_BO_UNCACHED:
+		return "uncached";
+	case ETNA_BO_WC:
+		return "write-combine";
+	default:
+		break;
+	}
+
+	return "unknown";
+}
+
+static void etnaviv_gem_object_info(struct drm_printer *p,
+				    unsigned int indent,
+				    const struct drm_gem_object *obj)
+{
+	const struct etnaviv_gem_object *etnaviv_obj;
+
+	etnaviv_obj = container_of(obj, struct etnaviv_gem_object, base);
+
+	drm_printf_indent(p, indent, "caching mode=%s\n",
+			  etnaviv_gem_obj_caching_info(etnaviv_obj->flags));
+	drm_printf_indent(p, indent, "active=%s\n",
+			  str_yes_no(is_active(etnaviv_obj)));
+	drm_printf_indent(p, indent, "vaddr=%p\n", etnaviv_obj->vaddr);
+}
+
 static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
 	.free = etnaviv_gem_free_object,
+	.print_info = etnaviv_gem_object_info,
 	.pin = etnaviv_gem_prime_pin,
 	.unpin = etnaviv_gem_prime_unpin,
 	.get_sg_table = etnaviv_gem_prime_get_sg_table,
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
index a42d260cac2c..3f8fe19a77cc 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
@@ -68,7 +68,7 @@ struct etnaviv_gem_ops {
 	int (*mmap)(struct etnaviv_gem_object *, struct vm_area_struct *);
 };
 
-static inline bool is_active(struct etnaviv_gem_object *etnaviv_obj)
+static inline bool is_active(const struct etnaviv_gem_object *etnaviv_obj)
 {
 	return atomic_read(&etnaviv_obj->gpu_active) != 0;
 }
-- 
2.43.0


