Return-Path: <linux-kernel+bounces-300579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5981B95E567
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14BCB20DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DB1714AD;
	Sun, 25 Aug 2024 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ank4li6u"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE098155324
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724620790; cv=none; b=lG5DXDxdT0hhzj9gaTW9wgLcdtcBSKRq9Uns6t0tAgJpDp7fRDiAEug6yfCfs5OVOMpXDfhpxinrbTN41MDAmpLMWQAEIGdSruT6I+eULsPDMEksARDqrL/ioH1EzgEWO+FyUNSWGAa0tx24TWa0QlECAUZEkMJvUBuWXhngY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724620790; c=relaxed/simple;
	bh=2OtoFjLqL/KJjirDgnpLHu9/Z2NSggZYcJnN4TQHN4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVkd2u1LW7DY7SzPTElYtq8NMXf4yRfGc5/lisUyGjTQKHjbEanvtAQcyUzYIDA452Eu6mfpnWa/Y/24LfgTBHMxJlcXAOrs0cSjMB46sWR8dzel7J1DJOutay1w+0H+i3QLFoYQiJqBKarSTKau2jg3WeLYd3VLG91g/5dYNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ank4li6u; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724620785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLbhQyosuMgaDHpyK8Ik2GZonV/i451ZkcNyo7o4Klg=;
	b=Ank4li6uKLashLRJebuBqMNVJAbsVilbMMwfvE1m0KuoGhu3su+xqWUwbSgotOfUgsG+9N
	VvRij9u1KKcsaidwYwdsfJPIluV0TWmT3DfY4M06PEmWmje/6D+i9TfMRUMOM9ajNe9VKE
	NCP5z37M14j9M+Ds1Y3R7n5wqNLzkUc=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 1/2] drm/etnaviv: Implement drm_gem_object_funcs::print_info()
Date: Mon, 26 Aug 2024 05:19:28 +0800
Message-Id: <20240825211929.614631-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240825211929.614631-1-sui.jingfeng@linux.dev>
References: <20240825211929.614631-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It will be called by drm_gem_print_info() if have implemented, and this can
provide more information about the framebuffer objects.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 32 +++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 5c0c9d4e3be1..9a688c95f34d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -533,8 +533,40 @@ static const struct vm_operations_struct vm_ops = {
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
2.34.1


