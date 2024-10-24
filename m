Return-Path: <linux-kernel+bounces-379639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E19AE16C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0951C22337
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2261BE223;
	Thu, 24 Oct 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LyoA0BLL"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590E1B3954
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763390; cv=none; b=H5Mz8K/lGgfv9Xolhu8eYXNGat7QBt4YDVvKkiZ6YwZWT3bZ6XDWhEKtXiZFZw/KAjg+5FS0TfrqCt9mi1ajPYgDxSFO3x+0UFdxSWoK4ByhQlH0vYH+2vZqOaQAr2A0oRvR7MgCFITcnoy9xDagtb+2TbRqxRB/DRFJpAx3UZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763390; c=relaxed/simple;
	bh=sfzqqT3D5kVBFiYY9+bS5W7N8XOEpbnrlwG0ljKgZyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCdV4yct7Y86Y9XhzjT7UGMklJW8Zfyb9Zd1orejxKr/wt9vym6lLL+o1HNyA0AYNjBOhLygolCiz/L/3UdBHpHIA3KrYhFk8L1OgrI9bnH4qLqrc9ugZUhy0utqJM7aY2InSUtg6eaki5lzx+WLQxRk5QTzvzqm8sUdxEwoIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=LyoA0BLL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so820878a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729763384; x=1730368184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FW13s10cjrJ6xBnvvtPrQKRLAFq+b81IIrkXP7L0g0=;
        b=LyoA0BLL8vbD8ZC7Eu/CYXLXuh/kFEKA/oeDwP/9SWMkQ/AZKOqXemmPeDDgWgarNh
         PZTjBqBsXuCTHG3q3ofd1JkOnCbU24rId6XrGMTbmkAu/uC7mLAdbKwzwoO/ctgSvYdX
         hctT8exVs/FKiQ7CISzqdnJXdEpiFzPM67wYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763384; x=1730368184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FW13s10cjrJ6xBnvvtPrQKRLAFq+b81IIrkXP7L0g0=;
        b=byKDHVfXi3AmC1C75kZVQxKXRIY2DNihNnwd6CerpFVB8vjppHc9Cr6LYIr/d9LTkL
         0RF9mV8js8qzJJqc5/775ifCC6yKOH/B4BtDjftTTtyRckSXDYpi/hrVtJFoC+lSjpDG
         hOl+IMW5WxlKyerq/H3Imr/jxQH2rby+hNKrpPPWfheCa/TgUY12arpnoapdAn6MD3wh
         lFHRZvOqyheibi4RhoWKAF3ISdg/6mzMAAXyG5TkpPlYyMpwRif7PSeUru5ostpKnZhT
         H0QwwDYii79V5TKt4NsRNHxoHfJPmqvV15Q2MkBuq6+z+7XNTkkOaRmgzxR9HqcYtBi8
         weMQ==
X-Gm-Message-State: AOJu0YySA2n0NLApqJ/6SSpozuS5b9yEpe2PvbcQ1JgY5dK0KfmhgZUH
	R7bTCbVH/nxMt50twl9mWTlPtT7DuAaTAStFmrkd8s29xdGLE0WINtiuo847+WmtC85AILuXmlr
	nD+w=
X-Google-Smtp-Source: AGHT+IFVeQ54olqulFSEmUbhBkaP2nl+nxzVLONvwRPdHeqidkUJ/1eVmOBIT93TMx3XDJIFOixDmg==
X-Received: by 2002:a17:907:9494:b0:a9a:f82:7712 with SMTP id a640c23a62f3a-a9abf92f3e4mr515408066b.52.1729763384359;
        Thu, 24 Oct 2024 02:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:f79d:49dd:b804:3f48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6360sm593159066b.29.2024.10.24.02.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:49:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] pmdomain: core: fix "sd_count" field setting
Date: Thu, 24 Oct 2024 11:49:18 +0200
Message-ID: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "sd_count" field keeps track of the number of subdomains with power
"on," so if pm_genpd_init() is called with the "is_off" parameter set to
false, it means that the power domain is already on, and therefore its
"sd_count" must be 1.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/pmdomain/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5ede0f7eda09..2df6dda98021 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2221,7 +2221,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd_lock_init(genpd);
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
-	atomic_set(&genpd->sd_count, 0);
+	atomic_set(&genpd->sd_count, is_off ? 0 : 1);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
-- 
2.43.0


