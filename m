Return-Path: <linux-kernel+bounces-418041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7359D5C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F9C1F22423
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0521DDA00;
	Fri, 22 Nov 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxophegV"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513118A6B6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268902; cv=none; b=L4ULYlyjXcfgQaHscuCaCULjvjnrISkTvjMMYI9GV4lj/QlzAFj6ZypYpdM4KiTDYmJ6YYaboZ49mp3IIuz/Lp2RKDmiNNCKmeDT7C8+HTUp3F49xGPGYwa1S0001yUqseYMVV22pqC1Z2lLTlbAdTRZniBtbVQZtgWSztxyctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268902; c=relaxed/simple;
	bh=w9LCIWUOMl/uTKpIvXEyGapEo1u86swQRW6MRCHY3D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gve27xEComAkbAUvDfWT+9GfVruwKCVkTVHJj/Gi3vjyZmeFKAVH/DfrUt+4ncxbVl43eMz3IsK43chsBnbwglTm1UVVRJZ57y2SPOTzfYeQyigaayD0AkxmGLyqI5BDxjPmjcYfP3Z6wuixAGXl4RShXPQWN2xFw+/12CA9Imo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxophegV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609d8874b1so12392551cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268900; x=1732873700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/BFNmnXBO58C7oe88M+ixtZQGuz6wm+Rt7+horX5NE=;
        b=bxophegV0qAeFpYhJAVl/AFaeEm2uRTWoPgNLgEsKfH2O5EzErr1+Bfjb6NHusm4E6
         bEQFa2oH9nq3H8m/zfMspitRKAbdH2ddonPWyO+7HSOEnmZNVpqTUM/CAM1wkYIkOxyi
         5aY1cwcHKHAGpj9ZoVFgRo5XEk+ZriS8B9z1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268900; x=1732873700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/BFNmnXBO58C7oe88M+ixtZQGuz6wm+Rt7+horX5NE=;
        b=skixVRG+pZH4jJFkNRSrJVbgWoOZG+/XZzeXUj/kqawHXo7JTSnLSQQgvDXI84178u
         pgIfXZN8/87PAEaRJjyCP0PSSFgKkZBqZWjBS8kUA73pQ9OsiBRZ97lh0Mr53Udtf+Nz
         I6V9KwNktqwr+zISeu/5tRQvdqJ5x09P0+PX5sTblBgQgHYgbOCzkUVfiBgA65V93Zww
         SN7L2S0ppKwrYDj/BFpGOPIjr9NRCKY68zF2xxKOyluQPmYasRq+DXwln1J9Xp8rC+El
         1rlBYg59idSNMEXM2N36MRqEHjCK2/lx7pMPAhbJmchYKsJPVS8QmbtgozfQZ9krOLt4
         ZTNA==
X-Forwarded-Encrypted: i=1; AJvYcCUXzaSG6/dqWisxkcpjCQSxOlEmOKDlj5fpSeOgXNFzfZGoIgalnprnpprXiuLs4HG++Q6ilb+kk6fgnlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSCNnTPpiP36faZMPn+WCrxofRLBnnINdW3KpS/Dlg7X5DZRF
	XO2UEqaaRXH8ivuzERLXvHHWGoQ8Fv+r/1TwSNaHOZ9SFH8Kh0gMIgLZ8GroKg==
X-Gm-Gg: ASbGncs996qI4gtBZUwBkHPLYXopVmJa63PazmyzCEICIbBD30g23LkWVT8XzG/2UDV
	XJA8ONJVoYF//Khv/cHYNq872+g1QUXE8vuP7vxt9udm/vCw3HRT4tyLK7qlBEj+Zc+R01Z9byh
	Bg/d7vwk/xpPtWgFamrdnGUFpkaYLAxxsaE26C/FYHZLx2THcBOPeFSaIv4/lzMD6ByqTVNILkA
	SpVBCPRNE5Ap2nDSP6XZtMbiheVUK74R7dM//PFKOruGml8N/FODKBo+ll1Hj+DfKOjtmjR4GyC
	cy+Dnil2HtMDDYPmu/NvXDqG
X-Google-Smtp-Source: AGHT+IHHdb/bCzojxcLvKgiZFS7wveq70HirCmNUp9dbcD65FOXFHZVsY9GQS/ctk0cY1TQI6tOweA==
X-Received: by 2002:a05:622a:1e8e:b0:460:ab29:e6b1 with SMTP id d75a77b69052e-4653d617eb8mr30106331cf.44.1732268899812;
        Fri, 22 Nov 2024 01:48:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:47:58 +0000
Subject: [PATCH v2 1/7] media: ipu-bridge: Fix warning when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-1-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0

One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
throws the following smatch warning:
drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented

Fix it by replacing the condition.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..be82bc3e27d0 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
 #else
-		while (true) {
+		while (false) {
 			sensor_adev = NULL;
 #endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))

-- 
2.47.0.371.ga323438b13-goog


