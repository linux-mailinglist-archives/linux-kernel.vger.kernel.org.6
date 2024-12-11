Return-Path: <linux-kernel+bounces-441622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD59ED0D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914C918825E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022F1DC1B7;
	Wed, 11 Dec 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SwtH0BVo"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C81D61BB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933245; cv=none; b=B1Pg78DRA5afIm6h0POz64cp/vU0hpcQae5AXktAECV4xayXlretaiytmDNZOK6fK7d94Gld7h1PAXdpuPGT6wneGWhvs+yz9wM0IOYWTUut156blx9dv7t/wsJP0r93WPzEM1iuNd0hsEjrV02wVE3GxFDBmJ/dISxZFVVpP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933245; c=relaxed/simple;
	bh=q3MgbVb5/iRtsmwIocyzfKWa+QzfMXSv2W6hqdMRRbU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o3MHEmA+Hgq5QUKjxpXf1lE152sdHhtRM8LhNKUJfWPfB2/zHBfSjHG+N+0JfQ/tyeXcCAHq0GQXyHqt/ZhrxAVhOg27DWJOWyqhr8vtxcmmB8kqymxowKeGzx9DCJ7fKz3WkIqw63J/YuPdMip3RycKRt2PfYVQ3vwfkP2miy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SwtH0BVo; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8fa32d3d6so56513516d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933241; x=1734538041; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9J29LWzCU8drwsrvfcYJ/OGiJlSXBsqUHcuK76qfw=;
        b=SwtH0BVo+O14WgVT40QQvmNeSNIry75n/djR3g+DUOM8b41RjU14l3rgIxA6MxyNGG
         aNRGPZUwSbnpur+Y3MqdonNzg8S1e5iHecW1XzBCObCqRAPiE32q8oGFQxwYaDsBXWj2
         aHz1lyGj3+S+xa5W4BJc9bCSIlMRF7J1iTAgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933241; x=1734538041;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3O9J29LWzCU8drwsrvfcYJ/OGiJlSXBsqUHcuK76qfw=;
        b=B5yS+M+C2j4PwBisgFP3VCu0goCSvGwB2L1VsINl8KSEZAWt6XySTUksR7U4PtwIAI
         q4np40XdmvhKjqyZ/CQORtm1IEojKw0xjX2LonPkEekeiVWiT9f6lbinwpF6IsfxLX4w
         WETMxcqi2jaCkVWp0T6w4MUPcQKxXWydEd/msHr3kFfjcCe4CvW8Ys1KgWJDkrqSNcor
         dD76eLMxPHaP89SSWDFRZUNayj0wIyPupfnb1iq8SantEyc0QASmS2yBXQygI6+hx7aL
         P1dZ3i6/k9p9ZY+zZRI9lCcwP6C3rLMOLVqh8RYhsEGHBvixp0kQzADv/7hdGGmu36xB
         mEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWza40+DHI4MEuPO4bT0g7RuLDB7DB296me37vWIYo2A1/szda3nU1wUNAcuV+eT+s951pr3+/zDcUn3WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyznA5LsXa4Wg5CuzPD1HzQYuJdCQcRbGZBPhpQMxlvrOUx1TSd
	TbdXNgjEQ9rnbawNq/qDFMVSPVRAO0EU0mg/6XfBxqmGYxEDN/LyWZVYEUx0HQ==
X-Gm-Gg: ASbGncuFCAYATimZfUwYjlxZ+8RaLIKDMlF6aq+7tfpsyFoJYqF0fLxaAdtwRaWHSTr
	Rtsjq6rVKmOCJ4wueO+4U3T4rqS1o32gDWJjHiLxihO7GdSmyzwwFkhzqzkh6UtUnrWAg2WgEWs
	Yp0tMDWTtAg2VyZPezJqEYdiKPLTPV4G/lsW1rlvWVdk7XiGUREjGy+J/ZmpUrMA3Op0pRQW6I/
	nQ4WgR+4kDT70OuqJ50+1rM8JxxHWk4HDSYV9d682dU1Wz7zzgCUua0BBqL/K7qOEj7DSIWhyz0
	vYHSJbLKZkgelnTvD3bHtb6Jd3Bp
X-Google-Smtp-Source: AGHT+IGjXMkyooU2Nlfv5traS1PR40dqAVdz7XsfULYSTHtrwgyML8EAsh9I9AC7bVBVYJ7VALIc+g==
X-Received: by 2002:a05:6214:766:b0:6d4:1a6e:d343 with SMTP id 6a1803df08f44-6d934b2bb72mr58520676d6.23.1733933240945;
        Wed, 11 Dec 2024 08:07:20 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/6] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Wed, 11 Dec 2024 16:07:16 +0000
Message-Id: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALW4WWcC/3WNSw6DIBBAr2JYlwZGROiq92i6QDooC6uBStoY7
 150Y9LP8s3MezOTiMFjJKdiJgGTj364ZxCHgtjO3Fuk/paZAAPBOQB1/kn9OFEDDkFpprQUJF+
 PAfNqK12umTsfH0N4beHE1+l3I3HKKQiJUAnb1LU92y4MvZ/64xBasmYS/FGBMto0Rlaqkqid+
 6GWuwqc7WqZVcZQMG2VMPLz67Isbzwv/jIXAQAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

We want to be able to compile_test the ipu6 driver in situations with
!ACPI.

In order to do this we had to add some conditional #ifs, which lead to
false positives on the static analysers.

Let's implement some helpers when !ACPI in the acpi headers to make the
code more easier to maintain.

To: Rafael J. Wysocki <rafael@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Robert Moore <robert.moore@intel.com>
To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Changes in v4 (Thanks Sakari & Mauro):
- Squash the two ipu changes and merge everything via ACPI
- Space after ;
- move acpi_device_handle to avoid fwd declaration.
- Link to v3: https://lore.kernel.org/r/20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org

Changes in v3:
- Prefer static inlines to macros (Thanks Rafael).
- Link to v2: https://lore.kernel.org/r/20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org

Changes in v2:
- Add helpers in acpi to avoid conditional compilation
- Link to v1: https://lore.kernel.org/r/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org

---
Ricardo Ribalda (6):
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

 drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
 include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
 include/linux/acpi.h                 |  5 +++++
 3 files changed, 30 insertions(+), 26 deletions(-)
---
base-commit: 6c10d1adae82e1c8da16e7ebd2320e69f20b9d6f
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


