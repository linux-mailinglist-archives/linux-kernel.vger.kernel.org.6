Return-Path: <linux-kernel+bounces-346748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7698C845
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA33E1F25946
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671A1CF7AD;
	Tue,  1 Oct 2024 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PTaISppF"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4F1CF5F0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821855; cv=none; b=rYNcfeaVGqQtgRHl3DLUaeAwlS+mV/AHOAHTW3AsQ3CpNbheZGvtBVTl4pcfwNG79TA72iddPAf+CliEc8LzJ19W/mcliFb6HhXMK+50o6cmutMFli+3FvJo0lWJ3zjqhMZOq76fEAnfM9GbJDVr4JaFhCmyuKYxQXwBZ/fBs6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821855; c=relaxed/simple;
	bh=V9Njp+Hss1MP7IhsB17a7/LmI6/c4TSAPkMBpdvoTI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/CcP9ToL892nv/vKfox+zHxi7RBYBzCKhDQmE2OWK+vgbE8xIYgb91kOo9ioNspH3SoQTNH+o03XjqOgKFPHoI04xaIseXe6yAk6jcJhEtn43zF+pc0wWjeHT7bC1jmeutJ9Pvn+EYE6wxJj6QuTEEqafuAKwsGkLDbgbMQpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PTaISppF; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e03f0564c6so3812564b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 15:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727821853; x=1728426653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9Sl44lq8X2WGm+oVf4+6IoQK0XVriOutR+vfMIV4VA=;
        b=PTaISppFa54EdVufO4rTjF1hU+hLTnfaBDct/jgGkOGPZRE60gyg9sn3vs6mDxFiup
         TuL8SJcZ4y72K0ubQfWqNSOct1/iBB9nM5mgiddpVNRZFJANsxDdEqUtyfF05Wvmz6iZ
         4mi3gXxki0o2k7f3CIhqb21MY7O9EGB+9Uw/C3+9Gnzx7Tfq46G9/8QHezW561B566Nq
         mvpWWUilg2r1hlDdKwNuQg8bDtjf++w11ZwNpeOLu44cwUPmPJn08/uU/ZIh6M0yh9sK
         +NSX8Zh2EK3G7vN6Rtdmu0aWDj9zapKa9G1YvqMBn31oyRKJdcPKcqqPxcJDXeOs65Ki
         gPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821853; x=1728426653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9Sl44lq8X2WGm+oVf4+6IoQK0XVriOutR+vfMIV4VA=;
        b=ltqbSsZWUPp8B819UazJCegcQr8fl8IBj4tf6N/8YzqE+mgg8JhCPk4CKNGG1Q/AWu
         lIGYNeUM1U1JgO87cF0fGZsEm0efYPsXIZ48QODp4wANvx60jAlf85c319MIjgsVg4vV
         q7hVQ48ZvpSg8ulw7OqM4rH2vgacGcsKkpmtmqvb4NOKPVjLBr+xT1ZzQChSPgZhD8nC
         TqvOiow/DEJOazNScvQGcRJHCVGMMGeiCX8jAslm0DVqmmHKY1h1O0ET/flhn+YYPBJv
         kPZecN5iKjLn/e9hE2Hy5iuUe2sRTfhk06Rpj0iZ324FwdRuP/o2ktEzVVn8skYavBJ2
         26oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhN2O7GIKlKMDW2a/pul/idxTA6l2teCn65BcBe5yXj0bVf5QbP21RqxZ5MEtkj5pMu76ovFuwRHJPv8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8WYJP/YEEiGQN5qWGpvqQcZ/fDo321x9PRyLm/RLiH+yWi23
	8QbRMeDuvxJm3r0x0cRtoF6re1H0YxTkgxTH0rflGMxyxM3zOfDIyYKCUK2+3gOfTeciJfhKsmP
	J
X-Google-Smtp-Source: AGHT+IEN2pfHky00i0eXvdOYYGLR6DqqFZpSA+Qwe2ckMPGBiP2uT0h9yCZCjMfnku65naZhHJqcAw==
X-Received: by 2002:a05:6808:3a15:b0:3e2:7b57:9930 with SMTP id 5614622812f47-3e3b41631b4mr1047352b6e.36.1727821853123;
        Tue, 01 Oct 2024 15:30:53 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e770eaa056sm3002097eaf.31.2024.10.01.15.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:30:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Oct 2024 17:30:20 -0500
Subject: [PATCH 3/3] cxl/region: Use cond_guard() in show_targetN()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-cleanup-if_not_cond_guard-v1-3-7753810b0f7a@baylibre.com>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
In-Reply-To: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
To: Peter Zijlstra <peterz@infradead.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Use if_not_cond_guard() to avoid goto and rc variable in the
show_targetN() function.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Co-developed-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/cxl/core/region.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e701e4b04032..e7c0221edeae 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/cleanup.h>
 #include <linux/memregion.h>
 #include <linux/genalloc.h>
 #include <linux/device.h>
@@ -770,28 +771,21 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled;
-	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	if_not_cond_guard(rwsem_read_intr, &cxl_region_rwsem)
+		return -EINTR;
 
 	if (pos >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
 			p->interleave_ways);
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	cxled = p->targets[pos];
 	if (!cxled)
-		rc = sysfs_emit(buf, "\n");
-	else
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
-out:
-	up_read(&cxl_region_rwsem);
+		return sysfs_emit(buf, "\n");
 
-	return rc;
+	return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
 }
 
 static int match_free_decoder(struct device *dev, void *data)

-- 
2.43.0


