Return-Path: <linux-kernel+bounces-306436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8121C963F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C841282471
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3D18CBE0;
	Thu, 29 Aug 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FelZ1XdV"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C518C923
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921512; cv=none; b=ftWn9rY/DeRW/vFPJQgyFxHbhNXy4cR3FSBu3Gzwzyo3s1eZv8y8xdJlYLK2/WkjfLY98qEwLBquXw2wsW+H43viQ5PTg44LDC/UT3pPtKbXf7ZUTXR1JIlNeFUmnNQhCQqpT1oa7GzNOheMo8Nk79rguXySeBIE+TkVLa5nPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921512; c=relaxed/simple;
	bh=eTGOjlJK96LCgsFfSsVVu9aMWx0XcNbrIRxF246XPHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hePTkcCzVn3JBEyoKf07ldvftN1y2PeezUaJKIjqy3kRal6Cby8Z2OtoUPjKxB+Lv8CJGRwKM9QsnqKyU4mdNHfbLr2tCG9qywSJ3/tL/4hOOJE9KwWfP9AgNacmKOgrrc3zci7HNmF+AZ5g9PJNWiHqM3ROQy/QO3xoSjYctvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FelZ1XdV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-202318c4f45so4165875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921511; x=1725526311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heIFKAnQeQ+nyj/vXNO0cty0i3q7712MChM12fe4bG8=;
        b=FelZ1XdVWwU8f/ISutyBPSZT4LvhKHlrEJB4vYJ1YrbdTCFA0KmOr121rvwlIqLk5J
         0Z8849SnxbN3dQ2XaxAfUq8CXkpgAEvcHmuC76X93NnkzHZO+pIiA2F79mBr6Rc9gYSg
         Ns0sIXhSNsgmf0SCUe86IkDpUHDb2wFqRf2Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921511; x=1725526311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heIFKAnQeQ+nyj/vXNO0cty0i3q7712MChM12fe4bG8=;
        b=DXDNPLijtt16gnBMMPHEDfVKIuE7D7ZsCbAhAndp6Th/2qckyaBmLHX6o07aODqNkG
         W/vfxmxFxfHcvM/4W4jB05uVYbJPrCWecPUG/Q7AHOFRC9yVYPnKLRTO09bXYEMvhURW
         WJ7cZTPumEE0PXe6j+e3qqN26ZsYpb1q8PqG+hrrzaV5n9Ad7cPMtF45cfs+Wh0KjWnF
         Ais6xnYw8NEj5ylYOY4ngsM83KBPe33J3v6Ze1DVCUcAwctuQ80+VoXxDfQbWcrLpHxQ
         w4+onR+ZPI3pB4S0RBjT4Eyh7i1hjRF9UxfiK5yN7zxvF2LZuQ1fizgxFCxxoZ5huxiM
         CTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhQA9DaJJWW3Eyv2k256tXrq/SMP0bmzt7K1Pt2G/IUtHHynx05ep4zp5wVgrv66iaWPC9gtFk0AkzTqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XwW6XILE6x/4RwwRZbKP4/tHucYZJbACUTlbb98bne/UnP4B
	qDLaQstvj+BXiWNoJVE4E3SdRIxCcOyp655xEmht3OPb3aFtG1/lrbX3sAhieQ==
X-Google-Smtp-Source: AGHT+IEF5DMEz3vypFVgvJ9fuRxtis7hT+mK/UUazZidY3knWdLTfD07eXsusPkoSY4O2j+uwdw9cA==
X-Received: by 2002:a17:902:e5c4:b0:202:44a3:e324 with SMTP id d9443c01a7336-2050c34d93fmr23219625ad.21.1724921510665;
        Thu, 29 Aug 2024 01:51:50 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:51:48 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 01/10] regulator: core: Fix short description for _regulator_check_status_enabled()
Date: Thu, 29 Aug 2024 16:51:21 +0800
Message-ID: <20240829085131.1361701-2-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240829085131.1361701-1-wenst@chromium.org>
References: <20240829085131.1361701-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc complains that _regulator_check_status_enabled() is missing a
short description.

Since the current description is already quite short, just trim it a bit
more and use it as the short description.

Fixes: f7d7ad42a9dc ("regulator: Allow regulators to verify enabled during enable()")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
none
---
 drivers/regulator/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9029de5395ee..763048d6f1ed 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2707,10 +2707,8 @@ static void _regulator_delay_helper(unsigned int delay)
 }
 
 /**
- * _regulator_check_status_enabled
- *
- * A helper function to check if the regulator status can be interpreted
- * as 'regulator is enabled'.
+ * _regulator_check_status_enabled - check if regulator status can be
+ *				     interpreted as "regulator is enabled"
  * @rdev: the regulator device to check
  *
  * Return:
-- 
2.46.0.295.g3b9ea8a38a-goog


