Return-Path: <linux-kernel+bounces-228806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C7991673A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497DD1C23ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0C153506;
	Tue, 25 Jun 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nvheh0W+"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793A15A87A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317672; cv=none; b=V5bqxxqrPEBCb8kFw3SgHw8lvDPg562VGE/1zhPDw98+tJnie12TrCbrzJlt8sySOw0qu6yZStVca+UUy07m+eGKLO3wICCbAwNW0aMldvzN9wvCckPVf5XkJDrbcv9zbr6skI+Qw8GTy/jEwjmhB+26aPmXa+fXUnJzVgxXAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317672; c=relaxed/simple;
	bh=SZFI7ieRlfDHIKjUHJb4mAmP9g299cNGVbuTRzb5QhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvAovRy2FMHRYQexlOJAHRmVOY+bqUB8KsxA01XyaqTQSkQTMbIVsFs2QHSnD+B4GsHoP9WV9OrkD9IuLHA3Pn5y5AxYn4uvEFJC+Xc8sXXSU0aVIrTAeYgnzfo4yR7bYAWS+5RAv9zmYK2xsWIliqZQJFk04oD423qglqYHDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nvheh0W+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4217d808034so44399525e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719317669; x=1719922469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/s4zhle7xfM5JgZ6DVzSJAJxVkhzCO478oqgIVbef0=;
        b=nvheh0W+tCwhGR9F4YIII7JDMbs+0KqPXogFCHq+En1VWvmkk1rPbtWFUI2QiY9TwO
         /LaKKhIEZFLe4bFVBFqN9aK8hxXL5ce43ppfWLhpfQH/5iskRyVjsX9m7h4nr1pKLPWm
         v35tCQ5H9VEKe9OnHxCFSZEaxQoe80pt6N2hZWdMYbkflUX+QK5YxS3WY/STtvJ4Yepe
         8ftUIqRT7WF7dMgolAQeBri5AuPPRT2m8YnoYyr4ACS3IbrpthH7ZfHr5Yt2tY/CxplI
         MhWKM22Qeq0iQ8LU4F70msOQX3gvAlbezq33WPkTdL+84/01jCjkRzEDvNoGxzGUNpXh
         Skfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719317669; x=1719922469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/s4zhle7xfM5JgZ6DVzSJAJxVkhzCO478oqgIVbef0=;
        b=jD32dlxLNLxeLXRL68TJXpIi0s/KXaQBJAK/cD2Cf/ZyFaLDHhHhXucUFCzRUj3aSw
         iCfPsQyl4TwS0wItDX8Do7eUj0jhsFR4bG+qRt8KmwzyF/p2+s7kLR7N45C7wXhe/xNI
         1t2xA7h3zLAMeE60E6dgzVPly5CnPOsXx3HpBo+viBBq78WXimkkfpM9jgTBS6RZVO5u
         W0f7JPhEOtisODXxKWiLTlMiYDKy9rO9G9epkdKqxbdI1N/XGwRmXaYFpaOm/vZ46fky
         EGh+s6YyT8xYRcl+8ERr7iXLJGqENjvK0znUfLyJkxRLbxRef3iCECfuvCOC64OhAQFW
         uPRA==
X-Forwarded-Encrypted: i=1; AJvYcCX0UGb1ngGubyS9l10npHijC4EBVJ0ha1v65nCT7sxoiyVYsurvBFrRiHKV8JTx9HzZnRv5haXWQGk35VUPfsiABHfHPsnRZYdyDsos
X-Gm-Message-State: AOJu0YxhU4/aSSiC9mcEnNHtwDsxD1zm10DaUyD57ZLUX/bXm/F7QUG7
	shbo12qh2GlJHQMDkbQ3q6qK0BTLt16z33UtIZWE1AJLE6frGx2nW/IW8SL3WKI=
X-Google-Smtp-Source: AGHT+IGpK4KFob/8uwg9NoIk3lwn/csQ1kMUYHL5YqxKv1iS3jSCBr+2jObM0uKgM6FoY7LcYXKjjQ==
X-Received: by 2002:a05:600c:4185:b0:424:a516:13f8 with SMTP id 5b1f17b1804b1-424a516147cmr8586235e9.35.1719317669074;
        Tue, 25 Jun 2024 05:14:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8b32sm12798437f8f.92.2024.06.25.05.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:14:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 05/12] i2c: riic: Enable runtime PM autosuspend support
Date: Tue, 25 Jun 2024 15:13:51 +0300
Message-Id: <20240625121358.590547-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable runtime PM autosuspend support for the RIIC driver. With this, in
case there are consecutive xfer requests the device wouldn't be runtime
enabled/disabled after each consecutive xfer but after the
the delay configured by user. With this, we can avoid touching hardware
registers involved in runtime PM suspend/resume saving in this way some
cycles. The default chosen autosuspend delay is zero to keep the
previous driver behavior.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/i2c/busses/i2c-riic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 002b11b020fa..24c0d62544fb 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -175,7 +175,8 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	}
 
  out:
-	pm_runtime_put(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return riic->err ?: num;
 }
@@ -405,7 +406,8 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
-	pm_runtime_put(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return 0;
 }
 
@@ -485,6 +487,8 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	i2c_parse_fw_timings(dev, &i2c_t, true);
 
+	pm_runtime_set_autosuspend_delay(dev, 0);
+	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
 	ret = riic_init_hw(riic, &i2c_t);
@@ -502,6 +506,7 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 out:
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	return ret;
 }
 
@@ -522,6 +527,7 @@ static void riic_i2c_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const struct riic_of_data riic_rz_a_info = {
-- 
2.39.2


