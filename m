Return-Path: <linux-kernel+bounces-434927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6669E6CFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BDD167500
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C762010FC;
	Fri,  6 Dec 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pgN8r8/z"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3D201005
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483651; cv=none; b=W5yiO3tz7ecfDa+YrW7dBn4OXMYH1J091HQ43Yf8uINwQGSUjNYZ0Iwhr/bNuA0yfeh4yAjzBmgKlho5gXC1wkpeGJYS4O0pH771oAG1l9A3ZMN37E3uO30W5e9U/yAO4Ed73Ts2O4+3S+/15tjpO+LwSoO8I/ZA0t+kn+bxb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483651; c=relaxed/simple;
	bh=a0X4aOYvG3pTfNgIEESajz8KrdCPF4/aLinqArXPrIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsyX7wiN28HZ+d7nSKKTDLkTdLxa04jzDbuB9Q6U2dmGZH4Ngt1Gr6cvIpI1VFBrhfdZVZ4TuGqPpUdoc8r8egD1+Dtj8Wp/r7mn8X5LQrxMGpCnchJkve3FithvSbrUHNZwo8FDOzruKhVGxc3VuSydy99rXy1LiHmwjqIKrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pgN8r8/z; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa5500f7a75so259751766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 03:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483648; x=1734088448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcFmoPRqWug/wF9N6rxPklzROiRzJUhH8R20dFRmNrI=;
        b=pgN8r8/zwM6QCbeVS/nKYXVqlIWc4HYobrPKAgRlsRchnq65qWHTmAfRn1gkIKgNQz
         YYPRUg/BmEcW0yfhOzPghaZ8BvOSjz14VaiKumjXY+1m/I5U/G3ulCSFZVmtrj9WDwJr
         A2uAkoZA6MrJTt/KnGwJNmpz35QCk3Azc2KdY1/xUW0Kq7KHbVjZp31yUgLZO0TsHdcj
         7IrjROxweNebSkQOibunqR2EFmQnpvfH53BXDd/G+ssXqPegTdQBHeTXiOVcTUyjeWqF
         8DxCYvdDaFsu4+bZaru6XgqVsDVdsKLVGKtgygyDB2l/jdC1wR6mFL7BdxZXebuL5rHh
         zV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483648; x=1734088448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcFmoPRqWug/wF9N6rxPklzROiRzJUhH8R20dFRmNrI=;
        b=wQF04b1psQGc1FHi01UtN5z9y9hFPLBKwnYmKY+JtmCn8ARj3pI6iPiEoBi466a58j
         h0g4lNqwGLRmRgvjF6geUUATLCpHimPR93jgrEN9xSuvxw7+WKf1DRI2BNQ6DgwvXKM+
         X9Z6yG+VtTRPv+rtJSlb3TJwth8Ur2OLgFrmYeKHo6PJKV9c8K1O6RofWJ3aZCu/SqHA
         nejK/Xx6NJuE8pUwMORe4WIciv1Vj3WDuH6tezk7im3zzx1VXdG430+ZjO5urak3/O7b
         TVAsL21c0V5Oe/9HnEKwZ9UOo/jTz1OHESu7cPyO9wqsnCSx+tXKZ8XMDib7Pf7zZqZD
         LGfA==
X-Forwarded-Encrypted: i=1; AJvYcCWVt3NA75zGf2xcoif+IXAQoLj/10Q9DGCSDF+pJAcGT2ZlvGJus4pipEsKmrPL71pN/kyxire0/NmoNeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YGAC3ARjulBj4OJ9K9fpPuV4e4i4RR5B5zpz9NKR1Hc4Ksuo
	bVwjsErhynEWx7Q7cTtZj+I42a1iw81xWnWHuvEvpD7pTCw8+NBUAD7gZPqF77s=
X-Gm-Gg: ASbGncuo3baGHeFq8zVa7ROEqxxJDuqJxyMmJOCo1AYGrngAHL0sO/Faw4U8mtpAs05
	PMxKMsDQZfkjs45hbDOKHmJrs3y8GuemVnuCM83Z7NFbybKJi23vvF/md/5ZgXW2kQ2wAcStQyA
	dIyMWZiEjguklzqR/LmVV8IUCOeaRscVNq/xvAR5kXzuE8LNrepE7ZGKaR31g6103FVU3uZiAxx
	p/He1aTQU6XkcWF77ln3TpVXvuN5A8oFJbvGGq1xtUrk+lLNAmXiQ3pmM7SBAdFdSG0XXIi8HLu
	FU6S
X-Google-Smtp-Source: AGHT+IHiSsJnrO9WOBGpjGpJxD2jcZJI3sgccO1J+MWdvjykKFu0VlpAlkqINSQOhBcrCp7fpOjTGQ==
X-Received: by 2002:a17:907:6194:b0:aa6:3e97:f9d8 with SMTP id a640c23a62f3a-aa63e9814ffmr105149766b.54.1733483647971;
        Fri, 06 Dec 2024 03:14:07 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:07 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 08/15] iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
Date: Fri,  6 Dec 2024 13:13:30 +0200
Message-Id: <20241206111337.726244-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable runtime PM autosuspend support for the rzg2l_adc driver. With this
change, consecutive conversion requests will no longer cause the device to
be runtime-enabled/disabled after each request. Instead, the device will
transition based on the delay configured by the user.

This approach reduces the frequency of hardware register access during
runtime PM suspend/resume cycles, thereby saving CPU cycles.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- used a non-zero default autosusped delay
- adjusted the patch description to reflect that the default autosuspend
  delay has been changed

 drivers/iio/adc/rzg2l_adc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 953511191eac..c3f9f95cdbba 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -208,7 +208,8 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 	rzg2l_adc_start_stop(adc, false);
 
 rpm_put:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -372,7 +373,8 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -410,6 +412,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 				     "failed to get/deassert presetn\n");
 	}
 
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
-- 
2.39.2


