Return-Path: <linux-kernel+bounces-303035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF696066B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A09B1F218C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED81A01CD;
	Tue, 27 Aug 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sjlz9zS5"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82819FA7B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752574; cv=none; b=S9nx3BCZMuR6ZriOZTRpPC5KmE0tuQIJsJL1YsCqaDjc2q9KEOK1iPv6ao1Kqvz99WZFLjvi9X9SSkCCYDIXqpspVIJfx/mfBQiKda6q/gwZhRdEDTuwO+3h1XLZPLn/YEAehXRLxLSeVt4fdxHQKzncrLeQFLmIfh1ofnOfJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752574; c=relaxed/simple;
	bh=61aWqOIzzepMknkcXPfDfYv2R9zOeeIrclywPB2sVo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGUu9LgNHlYudgoVbVOW16KzabHjQm+suGAKp9mMIxBjJ1wtiHBeGLnoxyaig9gpWG9ypmqWBESwi0klRaeB0hgpaeQPI5PDmstjXq7e45ceJyL1GwYOXwGS+5xmD3HmD1i/3riE2O6ySt27AouQA0Yj9Zhgyng9Oh1roIWruTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sjlz9zS5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201fbd0d7c2so43047345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752573; x=1725357373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/5VBNfYAsqRzbHrubk/0yjXqiOSkP3Dbb2C0/1kFpM=;
        b=Sjlz9zS5ZA5YBaJwgb9XuF9KPZz2YJmuLaBhLVivgf6M0eTMvMoMbPDHT1dza2yq4K
         jozebKbHlGroWn/3V8WyWXL7YavDy21DBmPpMD+Ektgh9zVB1xwcqajbvYoRTLHtJK4v
         AQVQewejI3Qi/a6riUpy7GDJs+5DV6PWYh9Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752573; x=1725357373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/5VBNfYAsqRzbHrubk/0yjXqiOSkP3Dbb2C0/1kFpM=;
        b=P/RNUmGHJjIVRCW+jtgWOj6+1l3uFfqO6tUtxEglB1XrJOKTbrEtqR3AxrR0hJ3mGY
         HUaPI4nrOxI3YyA8Off+oYVR1ONtUORbZOOk0HoLau1DPjI3h5IBjotzk7Q2eBfPnAu8
         2nS2H0LxGVjnN+QJEq6kgTaz6PUuDHzu9LIRqJ0E/XqWNvl+IaTlZDU1Hm8e0I3l6S10
         zCtWjGHdwGI8ZdBQGbaF363pn0VNNL2Z4vQeGKNUyOAo9duIOnyxvlUye3dea0ABRPjY
         4f1KCVeZxWpa321y4EKXz37j8odNGkr8e2qfujdlJBHPl3VWrY5E4gkOM+9CjQLXE9vZ
         fuJA==
X-Forwarded-Encrypted: i=1; AJvYcCXXt3uUKU7on9Kukeuk9I+McP/3ycpeLRCBLLj8vi6GzsE6r+CXBdkAR4MWUZu285aipt0wRv441+yoWX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9lnYrYhdc0sXRWYisi0b/XtuahHc5PuqC4xlm/U/gF2UvoyB
	uGwR3TpbCtK4jtnfLYM6fvz1yUlU9uijfOAhPylUNTxC5jXqNQdUWTUTJtWkWWFmM9zzeDQpa9w
	=
X-Google-Smtp-Source: AGHT+IGK0iObEbnV0ut5x5siCGHthaaUKI10Pjne/4Dtm0WJAt/GcXg1cPDu6YGnkB3ody3D/pB6Pg==
X-Received: by 2002:a17:903:11c7:b0:202:4d05:a24a with SMTP id d9443c01a7336-204df13ee41mr24113125ad.16.1724752572692;
        Tue, 27 Aug 2024 02:56:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:56:12 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 8/8] regulator: irq_helpers: Add missing "Return" kerneldoc section
Date: Tue, 27 Aug 2024 17:55:48 +0800
Message-ID: <20240827095550.675018-9-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240827095550.675018-1-wenst@chromium.org>
References: <20240827095550.675018-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc complains about missing "Return" section for the function
regulator_irq_map_event_simple().

Add a "Return" section for it based on its behavior.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/irq_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 5ab1a0befe12..5803ef016b7d 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -414,6 +414,10 @@ EXPORT_SYMBOL_GPL(regulator_irq_helper_cancel);
  * notification helperk. Exactly one rdev and exactly one error (in
  * "common_errs"-field) can be given at IRQ helper registration for
  * regulator_irq_map_event_simple() to be viable.
+ *
+ * Return: 0
+ *
+ * Actual regulator error and notification are passed back through @rid.
  */
 int regulator_irq_map_event_simple(int irq, struct regulator_irq_data *rid,
 			    unsigned long *dev_mask)
-- 
2.46.0.295.g3b9ea8a38a-goog


