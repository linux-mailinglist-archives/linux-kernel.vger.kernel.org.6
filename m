Return-Path: <linux-kernel+bounces-306442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090AF963F15
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78951F2541D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDFC18E04A;
	Thu, 29 Aug 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6lqAPiE"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CF18E025
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921525; cv=none; b=ArsbWTvSAUkAi4LFzIxAcOL157UYNm6k+oAJKIBFls902ZMTvP25k6M4JG6zebdNYIRhSSjAUfDd5b6GjddZrAQQ/EHOBIQshY81tZdlbVw/Wqk51VKtMpFGC6tylRDPtnjGwECH3pVyiS7yyHZggWM/pQLyEyEvKIsR+HKembU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921525; c=relaxed/simple;
	bh=7hkrUe/KGPGY6RW/seN1kpeFhXk11ehgjMIbRWCvfcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW+MPSNEWqz7k5Rqsg/WhTQRr6sSvZPNRjnO/jdjet/u6N8Uu1AKVP05T9mcvv9k0swAbyb16lOv/Vi8NtdwQECu3D/T0APRqpvK89YAeHcQMaOXbAL9VtwomjkkYqtBUj2sWBEyVMRbaupr2h4Xdmg7U6gA+kPOeWzWTb6zCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A6lqAPiE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-202508cb8ebso2627145ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921523; x=1725526323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH5i9APy7hcIZsD71Cy0fPlXqstfyKV2jYdTC5JW2L8=;
        b=A6lqAPiEBu1qpqVZXXAZeVByAOfXopD900Y3ccQJZqdVcZfG1HMUDFKD5AZsurJMkC
         pKzvSVhwzxeLMPHuWbQGy/G7HZ4UAZciS+nJR98Y8MxnWUp0fchKsJOm+hqJALDi+eoD
         IwMcnbUQo54xIgXt69YUTNNi+X7JncLBcQjQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921523; x=1725526323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH5i9APy7hcIZsD71Cy0fPlXqstfyKV2jYdTC5JW2L8=;
        b=jjsC1MbLcl3K6dzIg2RQhQSQUNgReSUK+Xqg2q7BEBOnBQHdBdsB4X6+z+FhV5eJQ/
         HCM64SfgTy+5idkI1BnT5TpOZIsj5G+N3iTKW29UEp2cSe3VgMH0I03prS17gw2/qblK
         LGFDyAkLWBI7E0g9XBUNRt3O9C7LH/5JzCvf0XNq3eVRKihymneNU9GP4prEfI+Ynpkc
         GATOOGgmIQ8TpqQSR382ZImWhtTLTkNdojKnnLbY25zXBzxYEy98/pI9H06fDfBnlJX0
         it2Qy2pn0zOVLy3jdZh8UfRrRny9PZ+jWYetplchouXdYWqaY3A4ynLt1K5ADNudxVh4
         GO7A==
X-Forwarded-Encrypted: i=1; AJvYcCWOpHVusVwv1LT2+/+zJF7XvHYSvX/b44jb0l9vcA87S4JTp9m4RvMYrkx7z7RD1cKXm1NUmDDYlAp5+bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVm66HLrUWYiTIixDLcpTU23VR3gCOFvsP+KBdFyVBzZM3yY1p
	uuGaaunYr8i9iI7MzDQMolCTL6STi6T/Nw7jnulOjzTt+95vMJGjm2Oqrnuy8Q==
X-Google-Smtp-Source: AGHT+IGvMUAJLJKTXy1U/I9Oz2SRJocUKAPqs8ZLqPE3NaF6A1+zA4ieje9ST+i37tUB7r8buTiUFA==
X-Received: by 2002:a17:902:f648:b0:1fb:4f8f:f212 with SMTP id d9443c01a7336-2050c4e89a1mr24399925ad.60.1724921523557;
        Thu, 29 Aug 2024 01:52:03 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:52:03 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 07/10] regulator: fixed-helper: Add missing "Return" kerneldoc section
Date: Thu, 29 Aug 2024 16:51:27 +0800
Message-ID: <20240829085131.1361701-8-wenst@chromium.org>
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

kernel-doc complains about missing "Return" section for the function
regulator_register_always_on().

Add a "Return" section for it based on its behavior.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Capitalized first word of first sentence in "Return" section
- Added articles ("the", "a") to the description based on surrounding
  and function implementation context
- s/alloc/allocation/
---
 drivers/regulator/fixed-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index 2d5a42b2b3d8..b6cb0aaac3b1 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -26,6 +26,8 @@ static void regulator_fixed_release(struct device *dev)
  * @supplies: consumers for this regulator
  * @num_supplies: number of consumers
  * @uv: voltage in microvolts
+ *
+ * Return: Pointer to registered platform device, or %NULL if memory allocation fails.
  */
 struct platform_device *regulator_register_always_on(int id, const char *name,
 	struct regulator_consumer_supply *supplies, int num_supplies, int uv)
-- 
2.46.0.295.g3b9ea8a38a-goog


