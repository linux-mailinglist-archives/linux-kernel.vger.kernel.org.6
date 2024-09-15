Return-Path: <linux-kernel+bounces-329836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E4C979689
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7DB1F21ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF51C5781;
	Sun, 15 Sep 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0DKSLkl"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831C946C;
	Sun, 15 Sep 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726401737; cv=none; b=AtHqdAbpVq+70wdAamZ5vBz72mZgDg5mrA/HdKV+a8m6ATDIaxxCmuhI/gIac9br0lnnL/C081O6nj/JIJqt2uCG5R/9bg3pzsGQTd552/e1j0ygOiKPZdkW0QH/VYpLZxuCc9XR/z0UMgld9sB5OCx2H4nyuPo6aQHkO2nyS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726401737; c=relaxed/simple;
	bh=8NYrX81w/hNuTph7kpeCh4h7CSnq9hQYHjgMmE65ApI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HRhhBjfFbW3iwWvLAQbpkIxtCYv3utVhQ5f6zveS2MFVQjfhep+SjMPHwVQpl+QAVJ4NSiWlbTy29LPh7FaeNfh/0EGAJJA7xOU0hfVGEbYYDFZUArRvWZhrYhQxGbCLsjswWOShPUgn6A2mnfi5L0Opon8z4mbwT13dOcYhtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0DKSLkl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c5bab490so3062353f8f.1;
        Sun, 15 Sep 2024 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726401734; x=1727006534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P40wET+w71UJyEkZ9BoZfs/VvG0c/BBfUWCIfkdVP7I=;
        b=M0DKSLklfy3U4giMgV7flMdbiwuk4PSNPHqeanKgU0gBQjYLHadlTt4fAkrU1Qiarf
         fidWklNof3dGR0zRVMJeIibrl86qCVn7B0u+mdCz1+lpZtGaMfIrJCxhB67iE5TyU9VN
         D/e1TBMxYT56vniwlweETHIhj/bK5pSfDXrp3E+6C/38ApdCelyek4bEWqwpJrgsNjaK
         HCQxTlDrPXrB1swJgw8tAcwTSoMBce/6qgYaVk2nCp0fBcVwJCj5KTwlw9v4b7FUGLZs
         mnx7vXsXfBa7jylcG/UftyL46DlFfeQK6pQc+cIUILOJMyvEpJzetk96R9rbvGiWk2go
         o7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726401734; x=1727006534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P40wET+w71UJyEkZ9BoZfs/VvG0c/BBfUWCIfkdVP7I=;
        b=AuvwUrAc6u04MzukhxWofjhRbEfDnujdy/jOjDTYnKskogt7LCc99AlitZnko3LKIZ
         mAIPFvX25JjHg7oyevj3D0hPcwSBADV20/a8qK0oA8YjTFDpiHYbngqHdCVjyN7Pj7gm
         Qs70XkMWyDPqfoLBHZzUz8Sgm4YMg2GmO5QlAPmmT+vhNO/T9TSRARqn7TqsH+jxCfT/
         Xz/brgbuxI7l0Vm8SSqICNRPUe+wkWWJXpPVe4M4QXBVjOf43qCLAo/8DZagtsUt06Rt
         RHBUriM3Ia9GkeEc8UVKzpVjGEn9jKCyiTvwKIH3OoWve3toBU3iSQHUmIKwc/IZ05PV
         5z2g==
X-Forwarded-Encrypted: i=1; AJvYcCUdzQZcai969/8+QcaaG59cIGPXc2aNizwpJdx37XTP5UY9Bd8XmVSwpcIVWo1JVzALX+StQOOMyHoX/19E@vger.kernel.org, AJvYcCWLcBK3CGUgJFG4WmE6Lq7rCgnChmNKxA6+P/T3aBKT1r276x/qZ1sKKygXGI8QekznWNSODjKNRbibZqbi71Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MoAegL5Yd5pEXPIVJCXTjodVUOs5R/LM+5kNCvD2lsZQxozf
	DWuCd4Duhn+4sjAXpYjlz0r4JlQTBWQBDFyQ/zMd7Xkktzwcdu9lDku6brxx
X-Google-Smtp-Source: AGHT+IEMZq4/JjBZ/u6UVGa7+slA/nrX41Tt9k6PRPk4mhaKvy6qtno+rb2b7xGKC7WriVIwr6K5xA==
X-Received: by 2002:a5d:5745:0:b0:374:ca0c:51b0 with SMTP id ffacd0b85a97d-378c27a8a55mr7714570f8f.12.1726401734007;
        Sun, 15 Sep 2024 05:02:14 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78054b6sm4497832f8f.107.2024.09.15.05.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 05:02:13 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] drm/i915: Fix typos
Date: Sun, 15 Sep 2024 15:01:55 +0300
Message-Id: <20240915120155.101395-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 2 +-
 drivers/gpu/drm/i915/gt/shaders/README   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 1f83b3b67ea6..062e61cf70a0 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1017,7 +1017,7 @@ static void hsw_activate_psr2(struct intel_dp *intel_dp)
 		};
 		/*
 		 * Still using the default IO_BUFFER_WAKE and FAST_WAKE, see
-		 * comments bellow for more information
+		 * comments below for more information
 		 */
 		int tmp;
 
diff --git a/drivers/gpu/drm/i915/gt/shaders/README b/drivers/gpu/drm/i915/gt/shaders/README
index e7e96d7073c7..4f5dab3fdcca 100644
--- a/drivers/gpu/drm/i915/gt/shaders/README
+++ b/drivers/gpu/drm/i915/gt/shaders/README
@@ -24,7 +24,7 @@ on building.
 Please make sure your Mesa tool is compiled with "-Dtools=intel" and
 "-Ddri-drivers=i965", and run this script from IGT source root directory"
 
-The instructions bellow assume:
+The instructions below assume:
     *  IGT gpu tools source code is located on your home directory (~) as ~/igt
     *  Mesa source code is located on your home directory (~) as ~/mesa
        and built under the ~/mesa/build directory
-- 
2.39.5


