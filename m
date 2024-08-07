Return-Path: <linux-kernel+bounces-278239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A7B94ADC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C433281798
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29013D61D;
	Wed,  7 Aug 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="RjUJLLj9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707F13A250
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047008; cv=pass; b=h6EQMVF+0zvyN2yqu0znpLerRhRmCqK886CQ7yhy29uPDpw3ChyG3NbObjvoFdy8aIqZH8tfKef3NP5MMsRK/fHNsaE8jkQxEZ8vpWO+Tt44C33B+fZ2seKAoi23U59U+kBmA0I3zyDNXt4KAH89CRTeIT5cNQcbDiLVROAMVrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047008; c=relaxed/simple;
	bh=hWBWOZNGGQpzEcXjwpQGfludEjZm79G6KIipOf2hddU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHW2E84397Otm+BIlYfsXz0eAFHlsvO3wcINDGsR8Pb9MMn1lromls7X/29UKyfFepRp7wvsI2eW2sdmpGc+ZZgTzeDMLH8ZGvt6EKCTn1uepMoFity0gH4LXujuT3MJZT4iWV7agahOGK3o8uWRXsKPBE5YM64MR+4z8RelKXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=RjUJLLj9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723046993; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kHVV3rIPzmwA2HcpXjLPE26bMMKmuDLza/WXLbdHteIx7sN103/Iy8YKnH76LPLiEgBNVwFPwH3tyVwM4Riv12sUxRxo6c+/BKV5JRX26vUjGjd9XO+f82PK80en2z5WPlQZ2AWF16q/pFMGXkrwuc7sqV3zoHLAzfiZe2w7LYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723046993; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J29M+xTzHtWGYHNY/aAB6XIac64gox5At2FLEcBydXI=; 
	b=DRs4rbvmSG8J9ugP/4hHMPH6LmvLL8puLvyjQeGX4J4w7b7lkbgtqjHqVdxZFwfZcc5j6iQdNXyOPikdXc80EjS9B058MXTccohLUZM24zy7VGgsp/YksyjQKGQTiInSvR1R2XznIfEDd5OEa1NGbmP4JnSou2c0EMTyLdj2uBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723046993;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=J29M+xTzHtWGYHNY/aAB6XIac64gox5At2FLEcBydXI=;
	b=RjUJLLj9mzJAKaTlej65pd3DNRRN8diYNYhdgCK/IdxRkpDq5FyzLJvHSvruir6M
	g0lTWw3LWLJjmCudRovwSlTwAel/x4smjjrywoMuFETf1330Hw5fhhmynOJJ1iKKw2j
	qg0cmfC5lk4BJSvR+jDJ4+xW19dw4HSScTYnFJeg=
Received: by mx.zohomail.com with SMTPS id 1723046992518427.5667049103944;
	Wed, 7 Aug 2024 09:09:52 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/3] drm/panfrost: Add cycle counter job requirement
Date: Wed,  7 Aug 2024 18:08:58 +0200
Message-ID: <20240807160900.149154-3-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160900.149154-1-mary.guillemard@collabora.com>
References: <20240807160900.149154-1-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Extend the uAPI with a new job requirement flag for cycle
counters. This requirement is used by userland to indicate that a job
requires cycle counters or system timestamp to be propagated. (for use
with write value timestamp jobs)

We cannot enable cycle counters unconditionally as this would result in
an increase of GPU power consumption. As a result, they should be left
off unless required by the application.

This new uAPI will be used in Mesa to implement timestamp queries and
VK_KHR_shader_clock.

Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
---
 include/uapi/drm/panfrost_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index 52b050e2b660..568724be6628 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -40,6 +40,7 @@ extern "C" {
 #define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
 
 #define PANFROST_JD_REQ_FS (1 << 0)
+#define PANFROST_JD_REQ_CYCLE_COUNT (1 << 1)
 /**
  * struct drm_panfrost_submit - ioctl argument for submitting commands to the 3D
  * engine.
-- 
2.45.2


