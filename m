Return-Path: <linux-kernel+bounces-315857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9791A96C7C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DCB1F262C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6B51E6DE5;
	Wed,  4 Sep 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TpOz+5uc"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE701448E4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478956; cv=none; b=stDMc+9Fm7NlCbRbA68eX/+HLhxmpJu/vMM04NVIi7xFI5G8F7+eE4ElYseEu4s2ao3o2U1qYUyEY15T7pNx0dMM3bdjv0xeS33YzL21U0kE3XN7uqzD1A8YnE/ICbEkCt8oIBtp2matsL7Y5c3We7pAXp9VfvD6B0rcyjtb9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478956; c=relaxed/simple;
	bh=HPWO/QLWDgxzRKoF7in9Oi7XC89XY0rfcsR+2YhVW1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI/EhPyQYX+OfzxpNlJTkYH6XyJbU2KzmxS1ItXTr35vuoEMLmA/FjQafXdyedMPVH065UMG9QcfDyLFFcq2YVEUDlSC3Con/fyrmb8NF43mUv3NdGeewXLRvHAvF0e6VLoy2F89yW79mVGjFPP8v72hZQdCXiYL2ha3v1ihmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TpOz+5uc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso9937735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725478953; x=1726083753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szwxrglvpeUQl4D09BmEH2+sb0TQ16anV8CEupHgKHo=;
        b=TpOz+5ucWeQ/PQB8bEI61/Zy1Y8Kg8EXSc+vMwiWcVUHzdYjlc4Ft+rhe7ViEyBKzN
         R/pq8RltUq1BqujGyXEBd0TBkC6i88PCdqv1uGaZx9GlAQWczxntZ0A8mLWVznNVAZTl
         H0dgMK0AAuATNEj+rN7bN+qTePytnY9tYUreVpmrUt0QNQm7uIKP4ittNsd93S2/E5jU
         RbRjaHj7ynp7f+ogX8SSIHckcvnouumSv+yY2QtcmfUmKSyns2HRLDtEkvEzQ2Jjm+Us
         fQWlSFbGdVt0AL1IXXCTWtE3jtiTHxOOQk5FK/B8aPJV6FWkn0nt7wesiw+Wp04rxiCn
         ne/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478953; x=1726083753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szwxrglvpeUQl4D09BmEH2+sb0TQ16anV8CEupHgKHo=;
        b=jIYeLv8PYdkIiHX1iSylbhD3az7cTBrWopxivMtJkF64vAeN5vOZM3qhh7psBeTmfg
         Rnk3Cdku4ANUCxeHcFX4itrzotozo382x4sJSDABsTj8SM47IUzdwgsDFK5cYo7QqFUa
         hEz9rexGd5khdsvTQqb+CjIejdSZKn6gzugM52BxMkVPwXGDnwMCqDCtGMcBuP3PWuXX
         Zw3qpSFisgjgZo9/mvLGJGKZ5+zfRz56l73040XnFqmgl3BKVt00ZWvdGFhtAkePFngE
         oXAOK6txYiy+5Rdi6gpyFHPhaZKQhzW+YZ5BcRAyJ+aN2rWlH0Z8fyG2wj7TRElmZo0w
         /e7A==
X-Forwarded-Encrypted: i=1; AJvYcCWMQPovhzTrH2a+WQjjXnA+goSiUWLb9c5etvvGEpdbsHOizisrSvojgxVbYjv0S+GDNXzBlgw8DTCaTwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lW2vnQ1Wt0Lz1pOQIUlGWTPSwRh502vA2ZEHkLrp6GWB6aX4
	7QOFb+m1Gp+U1hXPS3SJzUJGnEb3hWWVxQe9mPGqWTcObCrJIPCVzkkUybiHsq4=
X-Google-Smtp-Source: AGHT+IFk3uD14cxjLLnbcx+WXfHpLB4aaPC/kUY7CjP/WqEDJMsp7u1Er/Xm1lUwOZqJYbZXIZswcg==
X-Received: by 2002:a05:600c:1d1e:b0:42b:a8fb:570 with SMTP id 5b1f17b1804b1-42c9548ce8amr28233995e9.24.1725478953005;
        Wed, 04 Sep 2024 12:42:33 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c03595fcsm12473625f8f.98.2024.09.04.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:42:32 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v12 1/5] PM: QoS: Export dev_pm_qos_read_value
Date: Wed,  4 Sep 2024 21:42:25 +0200
Message-ID: <20240904194229.109886-2-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904194229.109886-1-msp@baylibre.com>
References: <20240904194229.109886-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ti_sci driver we would like to pass the resume latencies set on
devices to the firmware so it can decide which power mode is the best to
choose. To be able to build a driver using this function as a module,
this function should be exported.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/base/power/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index bd77f6734f14..ff393cba7649 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -137,6 +137,7 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dev_pm_qos_read_value);
 
 /**
  * apply_constraint - Add/modify/remove device PM QoS request.
-- 
2.45.2


