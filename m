Return-Path: <linux-kernel+bounces-337152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CEF9845FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F86B2844C4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91721A76B2;
	Tue, 24 Sep 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6lEXzGV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2C1A7AF5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181158; cv=none; b=Xzj7Q3RGE04OJFhluSB51imxipl1DgRNxT270fH+7GYeGNB/4a+6pltCV3X9VyGaXnp5aCahE6xYpFWSd2bxSKFN4m+gq8bV7Wc5JkpvStKWZ3akRYq/7hR5tYZ/WOmrBd51Ih2bs3c4wuydYLQcxrWp6Vni6BXd8+3w1zYBojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181158; c=relaxed/simple;
	bh=ihUrjom1CVLpewOUxHxXnQDiC74uuQESPKR49w6+r30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDvk7cCgwjzKi3kOqjWA2BGawzdGF0uCZSzVvjqNQf/VqAFn6X6xsPuh4xzzeuXNciV6V2P+g2yan+Z5yPSEmxnIlJ5SoCa+rArBgMDPleJfabIm5pLLqmN800G9tdRyDm5tK6uFEe0y8qO/3GNRYtHleabh5n1gdPAK5krppos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6lEXzGV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718d606726cso3682806b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727181156; x=1727785956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HTEls9oNKfjurlW/7JQf2pxCuaRhIqDrMhYGPg6XCE=;
        b=d6lEXzGVhlZODC4c71978IG8+zwWUWaMXRu07J8BQgyYg0Xkw+fbMCC5PJbGdLLZ+W
         DPNN39Xls/oAtHrFi6J8xj17ySp6o/KgTRcl1qMI9c8AE9eC+6BVLGCPMQ1eK3iElm0p
         vd8JlPqZB/4NbIUnwCkN7ERN4BOZLxTdbSP0DFODrsMdQt6Hz+ZRK7W7IbVbHwdcNOq1
         vz1sB3Fdrpx5l0HZdBK4Ymm34fJaglv9nxSOXTCYSyKteHij1R/K7Y4yBZnuub6IjPh/
         Ohy+ntgELZdNoFnn5MHo2ox+sV3LvKay8xDszzCqPNCuCOb0pnTjapm4VMya35ymdMYq
         Ubzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727181156; x=1727785956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HTEls9oNKfjurlW/7JQf2pxCuaRhIqDrMhYGPg6XCE=;
        b=ZNudnmkgOglcXCke+dczU4hpyfo1IqjqVrbsqjS2LWUOeS3o0iRlbJGA2LElwVj6+T
         qNHh3vLvDETSSWmPFb/TYbTPBi2bE9kRVCdgBh7zPksiaTiRt9CXxQlSTaP55CpOTyp+
         FqIbS9WSGt8cTudzEoWkbDmMjBUoZE9Vs8dXSmEv8YMtIi1bBJweO7TJ+ro7RKi7xvS6
         eOijLRZpRxkq0xI9meaK5XZhZk8eHAuhzjtKMvDI+XoNOs6mJRMCJ6+FjB7PsVg1OmTk
         z4O7X0AlujKhwOlAT/+gtb1D1oF7Ok618kIrat+Dc030nPEEqrQaVJvKM6+5T+xqoWQG
         S0bg==
X-Forwarded-Encrypted: i=1; AJvYcCUzvTvC+2kCgXNopxV2y06OE+FI011nA2Q+QskPlAjJFvPZlE7dH0A6eNi4KOVyC4t1+5GYARUu9VkOo+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2L3v1z4sPvtLgCdzoAMJHanl3UerUBwUc5WnfAbGnR/h1xCs
	0qxQw9zIe/AMq8Nkr+ihaLYNY4rdvDMXTVKfGbjOa69Th1Vowp73
X-Google-Smtp-Source: AGHT+IGDCkwZpNocsyz0AWFpALmNxVSU6O0yLt8LNXOO4zrtUvGJA4rbuajl7pvGROR/U99U4Oaixg==
X-Received: by 2002:a05:6a20:4388:b0:1d2:e78a:36a2 with SMTP id adf61e73a8af0-1d30c9891d1mr21687125637.8.1727181155920;
        Tue, 24 Sep 2024 05:32:35 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c5ad4sm1115566b3a.188.2024.09.24.05.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:32:35 -0700 (PDT)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH 3/5] rslib: Fix wrong result if gffunc(0) != 1
Date: Tue, 24 Sep 2024 20:31:39 +0800
Message-Id: <20240924123141.16962-4-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240924123141.16962-1-zhangboyang.id@gmail.com>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rslib allows customizing the finite field by the `gffunc' parameter
of init_rs_non_canonical(). However, there are several places in rslib
use hard-coded 1, leading to errors if gffunc(0) != 1. This patch
replaces hard-coded 1 with alpha_to[0] to fix this problem. One of such
`gffunc' might be gffunc'(x) = swab16(gffunc(swab16(x))), as
gffunc'(0) = swab16(1). This special gffunc'(x) is useful when
implementing RS coder for 16 bit foreign-endian symbols.

Fixes: d7e5a5462f68 ("[RSLIB] Support non-canonical GF representations")
Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 lib/reed_solomon/decode_rs.c    | 4 ++--
 lib/reed_solomon/reed_solomon.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 805de84ae83d..6c1d53d1b702 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -104,7 +104,7 @@
 
  decode:
 	memset(&lambda[1], 0, nroots * sizeof(lambda[0]));
-	lambda[0] = 1;
+	lambda[0] = alpha_to[0];
 
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
@@ -198,7 +198,7 @@
 	memcpy(&reg[1], &lambda[1], nroots * sizeof(reg[0]));
 	count = 0;		/* Number of roots of lambda(x) */
 	for (i = 1, k = iprim - 1; i <= nn; i++, k = rs_modnn(rs, k + iprim)) {
-		q = 1;		/* lambda[0] is always 0 */
+		q = alpha_to[0];	/* lambda[0] is always 0 */
 		for (j = deg_lambda; j > 0; j--) {
 			if (reg[j] != nn) {
 				reg[j] = rs_modnn(rs, reg[j] + j);
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index bbc01bad3053..bb4f44c8edba 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -131,9 +131,9 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	rs->iprim = iprim / prim;
 
 	/* Form RS code generator polynomial from its roots */
-	rs->genpoly[0] = 1;
+	rs->genpoly[0] = rs->alpha_to[0];
 	for (i = 0, root = fcr * prim; i < nroots; i++, root += prim) {
-		rs->genpoly[i + 1] = 1;
+		rs->genpoly[i + 1] = rs->alpha_to[0];
 		/* Multiply rs->genpoly[] by  @**(root + x) */
 		for (j = i; j > 0; j--) {
 			if (rs->genpoly[j] != 0) {
-- 
2.30.2


