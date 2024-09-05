Return-Path: <linux-kernel+bounces-317414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69B296DDD2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7181285989
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE419FA98;
	Thu,  5 Sep 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TUZoxsZP"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DE19E822
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549541; cv=none; b=qsF67cZxqAGlkfs0vqbmPocAFZRK60O6eUUzy4JjjmOzKPsHx37Fyhl7DU6g19h274el2CroQT2WvFMs6ih+rTYBrRLnYtAQdrNYJsg/m5ZfPlw+Hex6qqusroW4fiW90CyHAolYl9CSYa+j4t3yoJcaYg5RV9AClOlUeKfsPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549541; c=relaxed/simple;
	bh=6rh93EwLIsxFVPtcu7P4JnnZPCEmutiOeQSQf56BzFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Frg7Pt9n5XKNNfTpP2MMUaz3EEmUyBgx5VtLYbtS01VNDHOdWPan4+v4nzRyf5o5eZ9lBLdYN06Gh1QbZkUZxluZHWUgM88GH4vBQqIhm6HhTvOE4EZbsK0ExBY6GwKoflt8mSzhzPV4p9POipkErxaj0xXdusQOQjsdjKQxoLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TUZoxsZP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3780c8d689aso549368f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725549537; x=1726154337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0Vl4tpyTXDZrAVsn0EizZ+7WJ1GTPckaSr1yyqR3dE=;
        b=TUZoxsZPwJ08qSLvVkHVbY25wijbjm8nk/D6AZ3aHWV1MWQ56TMhn6HmbGBt/WPWZt
         GerK/SjNVEw7bw/jK/U9EpaGLLN7w9hsZjbJUIukMx6xB+KxLIroKjRgm7wtEjWrnqeA
         4eRUzQJHAdU38CDi7y6DzvYEiNI+KJ3oqcUSQXbUF52c4mwH1db6mkXnaKy7O00peTU/
         B5DSnG/gc8XO3nRUPWoOvpSrceVmsV2vh1fqn6eMmM3zbyOPo/qFo3vPlCyjtgIEskd3
         1BlJSl00NqPqgDeqiBpqgQbkd3uViCt1vCHAdgpW8AlbIlngx8z2HY/L5wXa9Yn5Uw1t
         0tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549537; x=1726154337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0Vl4tpyTXDZrAVsn0EizZ+7WJ1GTPckaSr1yyqR3dE=;
        b=RaPAmCOSUeoPe4k67fVvSsQxcnfrmCAymfiE/5KEreh309gDIzP3TMMSOSann+Zub3
         NmQK80Fddqygpptd/DcVoeunziQgmvroApTRb9jCNhu7t0XzoVocgGZSS8RWCxlQTNng
         J/Gb918HklNsoa+eXV8TZqDnKtMwNPoqqMXngPaesVseWURxNT/IOGYtgJgt2tk81xVS
         wEQ7DV3Z46BX6KtYXcGO+cPdcjvFcgxJng1yT0gwlGB5r6AJqrJAtDG/Xe4lH2rqPwZI
         kgYH3b2M6NNfoRvLDDU5E+Kc6Q+l+7g2zFU0C7P5EkpQ1RQJljIsCdsob14okSM+LcY+
         9Q8A==
X-Forwarded-Encrypted: i=1; AJvYcCV+n2K3xIg3hRRfgK1XJIo73LHZZaSF6avNYgv4ZgLVQwM7ZS/uhjtaT0Yix1bvnH74OfZjtj11L2r+u7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ThGEq4apy4ol6nm2NF4rIBi6HF9gz9OsZ01eTls6SbOS1V8z
	Y3EBsb1XZvTbfAgsMy7PlLwbmvDIi6tz2T3OZR78mEaXCNuq22Sg+8S/ynMI0qewfBRWMSi/W39
	m
X-Google-Smtp-Source: AGHT+IH9xNazHjmSJ3hyxjYKXfwqg38Yj2TRfF9FzTKUtl1iILlE3/VnMeWvebaRlN6CdsKg6540yg==
X-Received: by 2002:a5d:440b:0:b0:374:c847:852 with SMTP id ffacd0b85a97d-376dd71aa2bmr5172236f8f.29.1725549536653;
        Thu, 05 Sep 2024 08:18:56 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1de81b2sm14031076f8f.30.2024.09.05.08.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:18:55 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 05 Sep 2024 17:17:34 +0200
Subject: [PATCH v2 4/9] iio: backend adi-axi-dac: add registering of child
 fdt node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-4-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Change to obtain the fdt use case as reported in the
adi,ad3552r.yaml file in this patchset, with the DAC device that
is actually using the backend set as a child node of the backend.

To obtain this, registering all the child fdt nodes as platform
devices.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Co-developed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index cc31e1dcd1df..e883cd557b6a 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -783,6 +783,7 @@ static int axi_dac_probe(struct platform_device *pdev)
 {
 	struct axi_dac_state *st;
 	const struct axi_dac_info *info;
+	struct platform_device *child_pdev;
 	void __iomem *base;
 	unsigned int ver;
 	struct clk *clk;
@@ -862,6 +863,20 @@ static int axi_dac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
 
+	device_for_each_child_node_scoped(&pdev->dev, child) {
+		struct platform_device_info pi;
+
+		memset(&pi, 0, sizeof(pi));
+
+		pi.name = fwnode_get_name(child);
+		pi.id = PLATFORM_DEVID_AUTO;
+		pi.fwnode = child;
+
+		child_pdev = platform_device_register_full(&pi);
+		if (IS_ERR(child_pdev))
+			return PTR_ERR(child_pdev);
+	}
+
 	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),

-- 
2.45.0.rc1


