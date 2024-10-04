Return-Path: <linux-kernel+bounces-350318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8F990363
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340E61C2190B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167BF20FAA6;
	Fri,  4 Oct 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oLcUbZTl"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231D20FA97
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046707; cv=none; b=YxeeNP957zPr/T1NFz32pT3Sd0oTkImkCJWXstJ1vz5JhQ3/nqwkSWYPRqww+RS06DUuM5yvX1ZCA5/gKZ2pKK25UJXVAVjx020NHAw0ZmAquxM1E0GZamC5S9/aupvEB2KxtJGgLqlNyMlRuITpO7kMMbinPHCjTxnvmZRZHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046707; c=relaxed/simple;
	bh=81lZz6tvQXAZ8py6IHRzmNqwYHG/0FHSLJkeNNpuEjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuOZMwETkXYtTMTPatzbF4KuiObn9D1qqpcEOEZIUzESUN569zDoEf9SPsSAyAifDY2q1tKXczuPmBYHy6JTq0U85TCU04HX4cQ0KmcTc78cRmtdpq+xycQbrU/9EUq7znwRRK34BDP8Q8gHG72tNMKtRiwNM7EiSWMlifk2Rjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oLcUbZTl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so20496205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728046704; x=1728651504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wq33e40qq5B5EGnE1SLGXv5afGtNdJFNQ/iJq5Jz7zc=;
        b=oLcUbZTlb3HhIavsJXgSmHAE091Gi7EQio7jc/C7NN6dUKtINImO1+sIZeIxCdBVqc
         voW/9gIovd/Bx0tdlpf5FFkRP7ZZcDegtlCU7f1LcJHQ1zsquin8EoSVnxr9HyJvkALJ
         NfIrqNWOmDcK9Yvb2csBRCqfF0jrzh8j6K4yg4wsIUs3NX5dkc8kxRBzqu1RUCz2yx6H
         No+/wq3IfwG/mAKYE7U6FYvLQ75SpLwjYIGZdMviafaBPPS+G4v0RKI8+3CbHae0Q3u3
         Zplzss3F9aO0RC1+CpNMrXXgKfwXrkzxiKWYLeTG9NozFzenp3EGl9Kf1Cez9yu9JCSP
         SkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046704; x=1728651504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq33e40qq5B5EGnE1SLGXv5afGtNdJFNQ/iJq5Jz7zc=;
        b=rBsO2WBwlxRjtNW7ascbr4yiqO9eEdWXXvnKjZCriXcWDVBY5LCG0vGuxSv9HmTYig
         YXAIERCN0mWEhFmNxeo4dDpvkXTqAzIB6h//ob2i7V2im8gILouv01DCIAyXKcbarMcT
         DJDU4y9QDq2EYsHR8VsP2/GpF41H3mZBKhSNTYDNySwp33dbTE0urfowX53JBjEqbCV3
         PPybcXclFHaHGZ5ITEL7euPynGEomqKMMsm25/RHKp1VWwTu/NAAFC9Q/kp7Uh9YIUqu
         R80Cw+vgwa/uTRCKmBxpemL3Ksj5VuIfCgrtIkv+gZTKqdyHFo9fNc2fGdXgAPICeSJ4
         oz2w==
X-Forwarded-Encrypted: i=1; AJvYcCUiEWwQ/t8d224u9hbCAWR1apXm4YVbQ8EWiCiyAXYm9+sHRq8K3rW25g0komEtwqaIJRQuOKTZrKiqZHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPxKyWp45/VC6fH00h0myhVrhEQH0n4ZezJFNBYC7pi4plXXT
	LnGIEZnMhf6CnpuyQpimYtM8tE0X+W/4WZN+ln2YH3O/4P0e5NvnDnROW+gVaoE=
X-Google-Smtp-Source: AGHT+IFtD2pF+3S+hWKaj35gJuRRUik/oqclbdt4ZgQcGB8oQY5sk3Cx9/zxl70fxbiUrrsytYJcsw==
X-Received: by 2002:adf:8b5c:0:b0:374:c142:80e7 with SMTP id ffacd0b85a97d-37d0e6bba99mr1881280f8f.1.1728046703929;
        Fri, 04 Oct 2024 05:58:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:80ea:d045:eb77:2d3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d20bcsm3197815f8f.100.2024.10.04.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:58:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] PCI/pwrctl: pwrseq: don't use OF-specific routines
Date: Fri,  4 Oct 2024 14:58:21 +0200
Message-ID: <20241004125821.47525-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver doesn't need to use OF interfaces directly. Replace the
single usage of an of_ function and replace it with a generic device
property variant. Drop the of.h header and pull in property.h instead.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bjorn: This may conflict with [1] but this should go for v6.13 while [1]
is a fix that's targetting v6.12. If git doesn't figure it out then the
resolution is trivial, just add <linux/property.h> in both and drop
<linux/of.h>.

[1] https://lore.kernel.org/linux-pci/20241004125227.46514-1-brgl@bgdev.pl/

 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
index a23a4312574b..d3f960612cf3 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -6,9 +6,9 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pci-pwrctl.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwrseq/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -35,7 +35,7 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
+	data->pwrseq = devm_pwrseq_get(dev, device_get_match_data(dev));
 	if (IS_ERR(data->pwrseq))
 		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
 				     "Failed to get the power sequencer\n");
-- 
2.43.0


