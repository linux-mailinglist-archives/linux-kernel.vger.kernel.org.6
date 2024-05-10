Return-Path: <linux-kernel+bounces-175930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8068C2771
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040841F25CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35806171645;
	Fri, 10 May 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcWpxyUZ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD80168AFC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353846; cv=none; b=rICwzkoRXzVkShzVSwyK3+9JH5EHAeNWLHJg4Q7wrTjXVuuHWWNMu19RMoqkXNCgd9zl/8aHKEGinLV+nDl7afVRzWZZOuhlLmdGak8g0Y58uvAcb9P7W0m3lpKaDPJrRAXF3SaIh1RbUfAgq0Kr/4/v0ShAhmM+Lmtr9HOCr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353846; c=relaxed/simple;
	bh=+6E1QWCdVlRF2Y2CqF81C3CJFrg1T9UMcvxSi9JgmAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FRqATq4s6iABGOlmt9IdZvOcwCEQOthjEvX72B48Ic3Y44xHfX910zdpfgeeAusn9S+Rztkh3kBOcC8Lz6DOmJWlcNJbEY/U6Q7vzrpJT3Ii2FKp8qv2yQIOIv4l9zPJOcEZe2HyUQ1ManS1jgUrJ6n3DWutf4T+byPGqxrBrh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OcWpxyUZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4702457ccbso556827366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715353842; x=1715958642; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0b7Me9PZDwaqOlHu5lGpvnIETDgfY8E0wv6t+cYznU=;
        b=OcWpxyUZfXPfg0uKeVjmrIhMlYImkiA2cJ1kanM10vMrZY0LTU4VDGUAWVkHrqr29U
         MMZ2s7W+8/Q2tTz4XrZqlmCNEPLiVM/j3Mb0sP3Sc7Stbq+zw4eD+ILv8yugNAyoOocQ
         DUHXOCtl1QMd0tHyANLLDWCTBLNKfrMWAGl6nNAke2EGt7V6IOwl5IL4kDMVmJMJAnu5
         +0wOmRmjc0OJ5O7Zodxv7NtV1hvJvKiGJBOn5kmQ4tcZUF5QcI63CWUXc6uQrLYAbj4A
         XAElsmFwdwTQHlw4SdG278Ccc+uzkTDxub9BMy1V5jGSBl+6VffJWSxoUwIuwOXF0vvb
         ACvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715353842; x=1715958642;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0b7Me9PZDwaqOlHu5lGpvnIETDgfY8E0wv6t+cYznU=;
        b=EiVc4TApHV/W/NaP9jQhfav4O27d+WQwnTDEcPJlthT92dG60JKtyGQ/iTR2rZii1N
         78dIhxwIjT8Wqakf02Oyg0kbph/zpGQw5j8WHpUelg45hG+YVmnAb6mbJmQyClkIe0Kt
         LdIitD+PLcnBWYOZiIz4DBgRvB/deoGlN/653TIz1/7cEEz7vtBiViDghqdZ1Pys4dhx
         Lly4Ew23TUADANTsrtCADx4J21Ojy50x1qd7/uUX2cO3PxUFxuygm3ANUTQJ/EdEcYCo
         FsxSyUc4qP4YsWEg0xWMwSHnAS2a2SY79coCYMm576WBhwFNUJ3GMZar6c1o4DPEs8/+
         IA7g==
X-Forwarded-Encrypted: i=1; AJvYcCXYOHcRsn5l9zfPbWgRBXBFz6UtsiSVtBYUKo3PTH0UvExIJjKYC3TQTRWfK/e3cUkoSps9XPcHFp5G9/wBAoWkoSYuLNFZ5II5fG5e
X-Gm-Message-State: AOJu0Yzx8dgutptl22hG2Qx0KRpscbwxjDOcMD1gzEjOQAwxDMbZsXQB
	qrWV8HHxYbUCB5qzVribCoV0YIkrP5LqmUwra/JQqjn9KhQ6IvNBSqYroomYHwg=
X-Google-Smtp-Source: AGHT+IE278hcS/Jr47z3kbE/00DWI4mUA+YI1L1n39yqUw2ZRvvYK93xTf7orCqbrqmfdjKjhusspQ==
X-Received: by 2002:a17:906:aad1:b0:a59:c23d:85d2 with SMTP id a640c23a62f3a-a5a2d66b4b8mr183158966b.55.1715353841538;
        Fri, 10 May 2024 08:10:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01932sm189826266b.168.2024.05.10.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:10:41 -0700 (PDT)
Date: Fri, 10 May 2024 18:10:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bingbu Cao <bingbu.cao@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] media: ipu-bridge: fix error code in ipu_bridge_init()
Message-ID: <71dad56e-0e2f-48ba-90bc-75096112a1ba@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -EINVAL if "bridge->n_sensors == 0".  Don't return success.

Fixes: 881ca25978c6 ("media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 61750cc98d70..a009ee73e26f 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -839,8 +839,10 @@ int ipu_bridge_init(struct device *dev,
 		bridge->data_lanes[i] = i + 1;
 
 	ret = ipu_bridge_connect_sensors(bridge);
-	if (ret || bridge->n_sensors == 0)
+	if (ret || bridge->n_sensors == 0) {
+		ret = ret ?: -EINVAL;
 		goto err_unregister_ipu;
+	}
 
 	dev_info(dev, "Connected %d cameras\n", bridge->n_sensors);
 
-- 
2.43.0


