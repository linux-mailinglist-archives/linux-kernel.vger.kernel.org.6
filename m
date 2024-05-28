Return-Path: <linux-kernel+bounces-191774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F58D13E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7061C215D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D14CB2B;
	Tue, 28 May 2024 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GicH+Ion"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CF17E8FF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874277; cv=none; b=Kkj5ICP222PnyrdWQn1Ftx33FCsN8uRC2Zwb3nLZr/THPpmL+zVpamP7NKC1kxmw/vm5HPo/A0uasAhthw2OVG4rVnM16GgxYlr2pG+DNxlotU8Aa13kkLP1Pq/OC1AqSNpXXNqXngs6fa9vlJILtG3H7gh9gooezOqA6gj+a1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874277; c=relaxed/simple;
	bh=LuplH+j+rdgbuAnCMvpduWskdsgcPKBG+yd1aJ3/a7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZnnSnOnubWdZy1uarNZhPeJ90OU25XEGdai2geWaUEOT5rTLEeElCoeFKYIS0GUKaS6rUfnIrAgd/suDZW01WIqapz1M9+yt3O+wz+l7El73wv5UOOwjwaARVbThgaWVzuV4PktZTINttwim0rbOnKI7Z5kxArPINrFou3WJmIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GicH+Ion; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bff7b9503aso296514a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 22:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716874274; x=1717479074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5+FTMhLZZISywec5OjCyTlZLnXVqZ81FTRU8X4RIME=;
        b=GicH+IonQ4OlBoktPlpUboxNm+19EznfwMFc5iHZZGYUPRUNZOaCmJmg5qSHCWGhCq
         1kLFT17hOefhIFT5xn2IisBSU8BZ/bf89KSadg5ynHE/JJ8aj99HuXRaeJELCis8JyoZ
         y9rhk2d/L/uIskbV/5KJn+B46wNZaB8L8yj0oeoaGablcdndYUBW0UvDzotNpLYXer0C
         txvw2lqMOpX8ZtmvyRGPvYv+AqITwqc8xAdov6SjJoGNy/WqUcaVtlWfyLWFsmZIIHwz
         OzN6SGXFLCpUhHIh/fGgk21H2bL3QhCe7Cda1vDaC0KRaIU/t3l3qDrLAaRJHRR4RDk0
         PWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874274; x=1717479074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5+FTMhLZZISywec5OjCyTlZLnXVqZ81FTRU8X4RIME=;
        b=ZonT/akhX7DSm6hLbAtXDP4ZLj+08gJdbFyoIbt3wXyE21UM9nmdjxai+hFjYdsho4
         pX8g2crTTeOnowRewWvxnyE7zkzcOS7dsi6kqO0oCQugcFk0oGWvKWolM6CjogUAB9+J
         Z63E+eU+0BxvUHH1beMOE2+beyqSxsbz+ui5nbObdJSpspmokDAK7fCFw1ZIZHZJpEh0
         2KvdgrzKwGicR1nimjKT0tchw+HRsiO7chP0CUiip1oTLpKvJNuXpH0LnUnFZjXNWO+d
         ZAXfGULc9n2rRZRj+nJ4+RHCGRi/mhEs3/F54uYeyJEqeh5uBnQXnN6VYBCOd83iQBNh
         BYSA==
X-Forwarded-Encrypted: i=1; AJvYcCUIdIM0F8idGPQnras3kJE3pJ7fGb62ImHgVBa0ayHQm8ihEN/LCEYulNIpuf/r8EegCsuUtFF98yzV5lPMc77H8rFy4ToTAjAm9Hxd
X-Gm-Message-State: AOJu0YwpRStvmwRA9+zZtm6C7fRUHHzRS4Om1nr0EaT6JV9CTRBjKelp
	qf2nvi2a42euORmY8J93KLgH+MJPIrvxdHi28AXwU2wCFSiqUlXPUAHurOLBmSg=
X-Google-Smtp-Source: AGHT+IHdYcyh6ZysKM6c3Dy8D0ABzlGEvenJ88MD9FcJr8sFvpoi0fh+nzrgZbCmj4RYtNElGXj+Dw==
X-Received: by 2002:a17:90a:1785:b0:2bd:feb3:58b2 with SMTP id 98e67ed59e1d1-2bf5f20796dmr9449160a91.35.1716874274082;
        Mon, 27 May 2024 22:31:14 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bda3aa45aasm7104744a91.1.2024.05.27.22.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:31:13 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Fix missing cleanup on error in _opp_attach_genpd()
Date: Tue, 28 May 2024 11:01:04 +0530
Message-Id: <b1378c474427edae9c17a6e84b628c1f1cc59d6c.1716874256.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 2a56c462fe5a updated the code mistakenly to return directly
on errors, without doing the required cleanups. Fix it.

Fixes: 2a56c462fe5a ("OPP: Fix required_opp_tables for multiple genpds using same table")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202405180016.4fbn86bm-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cb4611fe1b5b..4e4d293bf5b1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2443,8 +2443,10 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 		 * Cross check it again and fix if required.
 		 */
 		gdev = dev_to_genpd_dev(virt_dev);
-		if (IS_ERR(gdev))
-			return PTR_ERR(gdev);
+		if (IS_ERR(gdev)) {
+			ret = PTR_ERR(gdev);
+			goto err;
+		}
 
 		genpd_table = _find_opp_table(gdev);
 		if (!IS_ERR(genpd_table)) {
-- 
2.31.1.272.g89b43f80a514


