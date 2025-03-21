Return-Path: <linux-kernel+bounces-571773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02CA6C21B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4280189F2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD422F167;
	Fri, 21 Mar 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Lcm9xCdZ"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79D1DB366
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580458; cv=none; b=ElvwQk+WaZgdQu/EEgR7Hap3cu9Fxb45W/Jztf8PLh1sRHNBxI3rABaWQZQpPzDTkyPSbUcuwbDg3XP+sX7j5kHR7w+dFMliT12rUTywiFlATLOI0tm1k+QfgeuCqAfmGjwG9Bh+9O57ajKUEjKMyN8moWaqvtoB7HQ9rSrmvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580458; c=relaxed/simple;
	bh=47Y8hQip99iCf7c6Dmi/CZyHe8FpzUoY9ZGUEv+WWks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMnipr2RRCGuchrNdvgbtPoNyQ2qvDatzhDSWTeAryaq3hh4PTTpAc+pFKmwfQ+Yl8P2yyAQ7Z68bpRJxpQjVL00iHhzv/JNggIun13WspZdHmYzp95deIATyVbFIgFTRtq3tB2UfJ1tWZ55Zu3rztPnglfAPo680rhqD9Fh/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Lcm9xCdZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5b8d13f73so172299885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742580454; x=1743185254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLZ7c8PVq08fNJyONQLIT/0eP11NvUsx2TyTerL7XHc=;
        b=Lcm9xCdZx3SU4zIQeK0307UQBIHvzFmf/PvKMcOr1rwqqwY7dxAsvEhHXgMB8oLDbi
         W8He2l8z0QUaqpWNKzk4Xzwm4stCtCpfgrNuexEcfdvAPY5Zs0DWHdUW3zaKBjhvF2k4
         BomHBcCf8EvIwSW8xDthRPI2H/VSnP6h2xgfBYAlsWKDR9N2pM2Qpfrc9USAE/LXmHT6
         enTLFUcC1Z/8FULl3V+X0w636KSuphDbWiukF3qchEsquaaHFX6NYP4N1WjmRrzFlBAz
         Ov63OOb6a1sPOUiSNlrY/Bx5dvgIgpKwlSc9Fy9NaKsKSYXRqZa+6sRUorYaKxufK1FA
         WESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742580454; x=1743185254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLZ7c8PVq08fNJyONQLIT/0eP11NvUsx2TyTerL7XHc=;
        b=ateDH+AyAzb854748SYP5dOLW8hsajXhBok8K1v+mWLAGJmkivCMpMsFnmYrKJmQfA
         WR4pdOaTb4xYAa2gK1sQDbYdnIe6P5y+HSgPldrBOKl92JFF693bOyL36gl3Pm5CXpKT
         rFeYNn3iSugD0eq0HhkRC0rb72Rk41RvOGCC+gaD0JLfinSxY7lZP63+7oF4SWtU34xT
         PNWllVoflqZ3EuQE8fehAri3z36/1Oxiio5mj7riW92WOdcebqEjKCvhtz3hpwg+ITeE
         9cOZj+c7ask0xJD+PH07pMMoM14hUfIFnj2tTUpg2KlP6nQHG6/Hol7pXjpefnQars1a
         HZUg==
X-Forwarded-Encrypted: i=1; AJvYcCWYXJeL5SD++d+3iFkC1bV4tSiof5b3tt7YWRwFBYj2idjVnSVUiX8xo8ULBUbVlLql8TE6dMysQWzZVeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0KC1pxvzjp0VVXvdOBQUfqBJTX9ckGThoX5sMMi977sEs10r
	Mfdm0/lCz1UVltGSJXWWEoNaWE4Iay8ylq0FJSVKTd4NvhCd27tVJfsPO1iki6g=
X-Gm-Gg: ASbGnctO2KLYvlpO0KLyTC6+o6vwZIcCc/rSlA1iNdwzJkf10mHZDbxyezTp1oQb9WJ
	ptPMhRZzcfOjUoQ31bjGyEC0Qf5VwSfQhFH32bs7zXjbeiZrTzC6dTDnLiLNJnt8GIlQD06Xnrs
	AVwhK7cZXbJCyty525Y+5/oja2IxqqgAbSXGIh70U3ziRGp/PAS0rlEOOyL7JnQrtVyBg9tpy9c
	TM/CuGNJMmNxciAB/aiiZQvhEtcABB1yjPpb5zy9n7lxVi80xntuv8cgpGQQ66+LNEB2pqZz7ci
	jY98ebShcmcukYklrhv9l67IR0kFXzukMxJkN0RDH0aGFKyOJwDWoJCBNkwBG/3YaDbthefUBDt
	QIbpGjNgOmVW2ZGkpsDvejHjEP6QPVyZg
X-Google-Smtp-Source: AGHT+IFUnfQhtjCQYv7DzHsq6hKskzByzvAs8wuY7quw/aYR00Op6Rp9Y4a5IxpqPKPkNuMTQdbM5g==
X-Received: by 2002:a05:620a:269a:b0:7c5:3ca5:58fe with SMTP id af79cd13be357-7c5ba15a54emr539420085a.22.1742580454012;
        Fri, 21 Mar 2025 11:07:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b2bb6sm158643885a.11.2025.03.21.11.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:07:33 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com
Subject: [PATCH] DAX: warn when kmem regions are truncated for memory block alignment.
Date: Fri, 21 Mar 2025 14:07:31 -0400
Message-ID: <20250321180731.568460-1-gourry@gourry.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device capacity intended for use as system ram should be aligned to the
architecture-defined memory block size or that capacity will be silently
truncated and capacity stranded.

As hotplug dax memory becomes more prevelant, the memory block size
alignment becomes more important for platform and device vendors to
pay attention to - so this truncation should not be silent.

This issue is particularly relevant for CXL Dynamic Capacity devices,
whose capacity may arrive in spec-aligned but block-misaligned chunks.

Example:
 [...] kmem dax0.0: dax region truncated 2684354560 bytes - alignment
 [...] kmem dax1.0: dax region truncated 1610612736 bytes - alignment

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index e97d47f42ee2..15b6807b703d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -28,7 +28,8 @@ static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
 static bool any_hotremove_failed;
 
-static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
+static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r,
+			  unsigned long *truncated)
 {
 	struct dev_dax_range *dax_range = &dev_dax->ranges[i];
 	struct range *range = &dax_range->range;
@@ -41,6 +42,9 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 		r->end = range->end;
 		return -ENOSPC;
 	}
+
+	if (truncated && (r->start != range->start || r->end != range->end))
+		*truncated = (r->start - range->start) + (range->end - r->end);
 	return 0;
 }
 
@@ -75,6 +79,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	mhp_t mhp_flags;
 	int numa_node;
 	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
+	unsigned long ttl_trunc = 0;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -97,7 +102,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
-		rc = dax_kmem_range(dev_dax, i, &range);
+		rc = dax_kmem_range(dev_dax, i, &range, NULL);
 		if (rc) {
 			dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
 					i, range.start, range.end);
@@ -130,8 +135,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct resource *res;
 		struct range range;
+		unsigned long truncated = 0;
 
-		rc = dax_kmem_range(dev_dax, i, &range);
+		rc = dax_kmem_range(dev_dax, i, &range, &truncated);
 		if (rc)
 			continue;
 
@@ -180,8 +186,12 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 				continue;
 			goto err_request_mem;
 		}
+
+		ttl_trunc += truncated;
 		mapped++;
 	}
+	if (ttl_trunc)
+		dev_warn(dev, "dax region truncated %ld bytes - alignment\n", ttl_trunc);
 
 	dev_set_drvdata(dev, data);
 
@@ -216,7 +226,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		struct range range;
 		int rc;
 
-		rc = dax_kmem_range(dev_dax, i, &range);
+		rc = dax_kmem_range(dev_dax, i, &range, NULL);
 		if (rc)
 			continue;
 
-- 
2.48.1


