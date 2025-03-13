Return-Path: <linux-kernel+bounces-559966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B6A5FBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88623AC8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B141269812;
	Thu, 13 Mar 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a62nGLGB"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAD13B280;
	Thu, 13 Mar 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883316; cv=none; b=FlIKGC49NxVtR2uvY2zRjDuP7i4m4QERJunRut6ELS2NqXAha2MUct8Kk84EYSE9ecAm8881XdjclZwzMR5hilIuM19z2Trg0lhu+cOFh4f8uYmerH8x5eZwMu3kE2ERj4N7qxK7WM1ZV/tPMNkkgCYqnw4RwM9HqF5sDjlb+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883316; c=relaxed/simple;
	bh=tXHlN/vZaT3vrheBggtmIQEZ2sR6fVrJjqBtDYhsxyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rD18LuB2L+e8ux+SspyP9jtX7CJxcldkRBvToE0f3kessmHQ2Q/IIjOxdOQQ0LVCx68fzVPt12T8lat75Si+NBDf0N68rdGYjwMpdyF3hLjon2xtnQOm3kTWFXqb0trWKPNUxSIwcqwdPjue8TD+02FD5bABzShoZ/pGsQ/PKg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a62nGLGB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e241443e8dso2144196d6.0;
        Thu, 13 Mar 2025 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741883313; x=1742488113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+rzi9Cs1mysyZu/RVktFl1DJomxhH9G8QJ0f6e3ElM=;
        b=a62nGLGBP4/PFQl8/5dW5JV+G+zEIR4GsQsRq4omnf3KPS6VHcBDuGHdxvY+XaG4cv
         Gx5zwDrnTh2lAHS0RhVU9bSZAueKs2tjz5InLXYy9jwaUEtLmTN1W6ah979pKou/umjA
         SYQBO2U41r7vAbVeExhrjMydH9c4v5iDlCuSNg905VJGB/Q0YmjcQPwCLzI92ldhkVhs
         KDHJxFilMffgRjzBdtZx/M/P/LGjelL5n53sT0R/gSkJYth9CaHmYPtmdoQPPtAu0Yxp
         okjB/1sBuYmm/yw0A+8T2wBbDeGq85Q+CCLhBDOXBHUgT7wY3G/Jnw5YOR3WJStR4xQO
         E8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883313; x=1742488113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+rzi9Cs1mysyZu/RVktFl1DJomxhH9G8QJ0f6e3ElM=;
        b=tvHBchzEZHb+qFnhnxhZNrmhy4MhHipDMuWAwhY9a8kcndLZzzcBIMmjnrvA/yRIoA
         2Kz9ccvMvsWlP7gZrUYFTh7/8igGG7DMda1UhLosBhUaT7z+tweNwuXNq/te1aHn0gaq
         qd8uSe4lyNpVYtT3kE8GsOTCK9z6Y6WYLWYxpKpp4vnVtLmX3fiXYaeZJijTGI+TTZwC
         zCH4CxgV0kecxfm7yyp0YTgyxMsTnH1OPkzJh+H0IWKvUEq1Imp7CWn4LIQpZjR4QhMO
         XvW24NoaVmtHcvMHxSFro/x9gJyfXdBJPvYAvA97mYrl1EfC1Wb5718fAwvxXIOoAdHS
         VUfw==
X-Forwarded-Encrypted: i=1; AJvYcCVKpQSG8DmXqIcmKuGRc/FINr9BrgJmT2Vs6bY8ipMtASLsDJPm2E82MeTOyP7BEyqHUa+072FrjSnB5EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMkgyeMszOAEz5euMyeVTGZxIgwtkNDkMM6o2/2tm9yAVMGlc
	IvnBudtuECwws+FbkAXdks4dVRzyiRfBFp6EVGoxBO5b17vXHANZIHxE
X-Gm-Gg: ASbGncvfUXV4IkdDKdF15AaeSa3WBKAV2tibvNCoDQik54BQN0MhuzByntpzM1IubUg
	pbGjdhSpMG5nlmvhfVA7ncFchVrHAt1RCGXuL9HAXZm2xNg0lRgqhhLttNUt0wLiiMRzLd6STVM
	41ilefjuQzq1vPlLfEjyqeoAKslR2DQEY/KKhCGP5lWcoXFwycSzvWcBND4r6UieabPfeIWBVi+
	j7PMYeNSiHxxDm+BHEpSLk846lgkxKFCW1m+iMPZg/aC7yWyLKQc4SXX+3dO3zFD2SxsP+ib6aH
	S1R080MJyfE+N8lq5pVaDbwIoZ18/2kaEC1+LNkZBw==
X-Google-Smtp-Source: AGHT+IGC+14nXQfNX07ccYgxn4C7VYfVsX63xsHWJGYDCFdwepARsok0fgZ4rWNamxi+RO+7wfyN1w==
X-Received: by 2002:a05:622a:5e8a:b0:472:2122:5a43 with SMTP id d75a77b69052e-476665885eamr112495941cf.1.1741883311524;
        Thu, 13 Mar 2025 09:28:31 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb66070esm10969721cf.39.2025.03.13.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:28:30 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] platform/x86: wmi: Add Null check for device
Date: Thu, 13 Mar 2025 11:28:20 -0500
Message-Id: <20250313162820.3688298-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all devices have an ACPI companion fwnode, so device might be NULL.
This is similar to the commit cd2fd6eab480
("platform/x86: int3472: Check for adev == NULL").

Add a check for device not being set and return -ENODEV in that case to
avoid a possible NULL pointer deref in parse_wdg().

Note, acpi_wmi_probe() under the same file has such a check.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/platform/x86/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 646370bd6b03..54e697838c1e 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1091,6 +1091,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
 	u32 i, total;
 	int retval;
 
+	if (!device)
+		return -ENODEV;
+
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
 		return -ENXIO;
-- 
2.34.1


