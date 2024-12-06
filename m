Return-Path: <linux-kernel+bounces-435729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC829E7B7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4C728234D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE43A213E70;
	Fri,  6 Dec 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E17rPUO5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C326204575
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523186; cv=none; b=cNjEF5eX2Fm52ZzCCEOA/NTvxMNMmVF4iW22KqBO0GN8tmU90iaL29rDZa0j1gOTQ41vnAdifzxsVvZ9rVs2KKBJ2qMTFMxlXrFSTgkkE86o7rF0XOnLNtkVa3qDjPp0OTZkkVIQjYOL6y1THIvE/7yq6qPq97ZyUo2O3dimaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523186; c=relaxed/simple;
	bh=UYKwDCjPt0Pb4J8LYvmA473uK8bBnXmKBatytxsKAXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEDCXQqE0Ouku1D0BiasQsf4GPMFHzQo7bEmncaKWR3cfpZgogb1QUOtNgsfygruiKJT9aLY7dJ9DV2VWQi0AMzG67WChaDBwYJQefT4Hj4yrAcQPgKkcQmpwoUhbgNBr8iMiQXnGxVwKJYG5n5thuDsHuM0lVauXHib7CB/SU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E17rPUO5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21619108a6bso8529115ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733523183; x=1734127983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO297//2n/rgfagI213U6eCWKlgwMp68Rn9iCoz6hZE=;
        b=E17rPUO52OOsS8h8eIj0qqMPydIHKDWtywMlgJUSVjgU0voEmwGl1ShzoAyr42HoLO
         GjWeBKdLzg5rGUHQxzBEs5Pe4Z8cwlJn6vqZKKBt8bN2Y5DUJU61BGQynstE0SKdmxaB
         PudlAA6UvPShVjhxYw2it9OnVGq7zYM/1bkiBoCxsl9uaf4TpJvQei1DXrEj1UI9hBMj
         QpWYP41/e8PemK2gGBxLlqjuhMBRb/gLIeGD3RaDbQb4wd1w0ebc1dWSOZBpESrxOXc0
         7RketTi76eBeieCqx74NKpD+Drq3DrQ1eHgNLBSiS0o+1aBmXFDZWNz/57YfuUJ4HE12
         fVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523183; x=1734127983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gO297//2n/rgfagI213U6eCWKlgwMp68Rn9iCoz6hZE=;
        b=sJoOFnoMCs0eCxNmgCvhGlk96pd6UWbhhcbDFITSvltf06KaNmEKOgVchQ25yvJKGG
         1vabYRqYBoan0AOxmIFJq5o2SM8s6+nBTgyGBXYUXwjkxcx/Bw5Sg0qrX2+0aia4jAZE
         d+bwp/XTXLp2s038iodlU/wzblVeUdSmAfliPmqZdcxuniRmhwny70XsfFwUPAEhP6sP
         qw+1j9OdYeSTBZlB3BP2Lkozxx80+D/91V0+2bjTQPXpuRKYFFdVxon/eV8GVZQ2xLPX
         YmVLkoo3V5hcoEKFHGZB/A5Snq9dOOei3N8P78yTuizyhKtCTSjkuFsvqGHF7SBBNWiI
         ZMiA==
X-Forwarded-Encrypted: i=1; AJvYcCULXQdpZg7UzKgtkUUyoF0y3OfrPr8+b5PbF1AvY2Z+R3t+EPNz5JMnyjxMB+NcOLeTotG8glxfuZ37uuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZJ7p5AZMHNHED5hTeI4QhRnduLB+DiCR2lRYskYi+JbEfm8u
	+j3jmxduwfib2XgHrqrgXix/AzKkks5phUgHck0lDY2xcVCOXI8TAocRwxX6sW4=
X-Gm-Gg: ASbGncvguQFxYVvXzo7Yfg4qG3jJz/qsgW8/akrv7NvA/MVIGM3Mu4+CBc82/6wk92X
	RXF3RFn/mQLbdhbFtjmyFn+i0WA+8d3cONkBugJL+M3mhuNf+xOR7txEGX8llW8G/G+Ovpm+czC
	78JY2NerA68MHe8lvDCLqI6mb7v3S7JJbU6j+7xXNkrHwq85t3027N02eZls8b5QYGdQ+N2854+
	zaascdN5rLnyTih3Y5MY37k/plsxwQNl+7+fsL6p9VgMmaW
X-Google-Smtp-Source: AGHT+IEV5xymYqZ1yJV9BrjFB0Nh2Eg2LOwsypkmTdkIep4O1iPhv+s2TJ3JIQRJlUDRcRjBY3qeBw==
X-Received: by 2002:a17:902:f54d:b0:212:68e2:6c81 with SMTP id d9443c01a7336-21614d4ac70mr65378675ad.24.1733523183496;
        Fri, 06 Dec 2024 14:13:03 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f31a87sm33273575ad.268.2024.12.06.14.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 14:13:03 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 06 Dec 2024 14:12:51 -0800
Subject: [PATCH v6 2/3] pmdomain: ti_sci: add wakeup constraint management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-lpm-v6-10-constraints-pmdomain-v6-2-833980158c68@baylibre.com>
References: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
In-Reply-To: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=UYKwDCjPt0Pb4J8LYvmA473uK8bBnXmKBatytxsKAXw=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBnU3bsqDLxWO2AWpws47wAA/jFbeDffWrz4qPsb
 SyYgMi7CCaJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZ1N27AAKCRBZNxia0/vG
 ZRrND/4xtabQMPgyDLpYgMJPS1c2LUeKnOTWkJ83z8YH1AJs8pNydn7rBCna/HveiMWUjn7DPkE
 KKjuHB+QYLsgb94migpG4raM9BQZK3UVq5Vv08t7RT8UtHiwo7OTJj2DIPhXk/U+ic7dmaFjD5u
 yDFV0bFWqpRXJ9oHvLvS7yCWjQy/U7jJxQKVMUQT53bQ9rDXdewLkUzf5A6lwtPodtCArIZnYb0
 OhbDVEfLGmcRMBVjYsQKYXHRCbCsucsAvqB2quIcXCKrLewvW3dyfsCuJQ74kWnTjccm/hXToSo
 MQmwb2jaRhnuUDS2TYZq3y8pkiGM6obB910shrpH8UrZqdHwDlzhahtBnvbE0gk3tkC+LfUJIr9
 PE5ciY2YECShjBF4B33L5g+4cIngkCf+Em49mC8LJKf4ETH3rac8WXlgcMHS4NfaAbvzeXiphbH
 T+qnxrpBzYPUkTAmkj+Iffpmjf2oGsbILBNduO/ep9k87AbAoVe1W3jZxjUUiqa56o1rNN6JjS/
 Gfb+K9K6+UA9ipYUJc+bQDtSaeFArjOtcjDKKt+8NDeK6asdGBb0r6RiPId1HLPfe+IZcoxY1ay
 QeyzotFYL8gGZxyh3wpDySjl+gEVhMUHtI/AfAebsDjUEBM5fUE+puI97FJnlCZUo3fKYudUuqJ
 4TCOKcNnemEYO8g==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

During system-wide suspend, check all devices connected to PM domain
to see if they are wakeup-enabled.  If so, set a TI SCI device
constraint.

Note: DM firmware clears all constraints on resume.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 963fe1901c959197d5d8b5d34fd8420dfb180087..587961519dcc9e13c32efe76cdaf801281f72f67 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -79,6 +79,21 @@ static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
 }
 #endif
 
+static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	if (device_may_wakeup(dev)) {
+		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
+							       TISCI_MSG_CONSTRAINT_SET);
+		if (!ret)
+			dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
+	}
+}
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -121,6 +136,8 @@ static int ti_sci_pd_suspend(struct device *dev)
 	if (ti_sci_pd_is_valid_constraint(val))
 		ti_sci_pd_set_lat_constraint(dev, val);
 
+	ti_sci_pd_set_wkup_constraint(dev);
+
 	return 0;
 }
 #else

-- 
2.46.2


