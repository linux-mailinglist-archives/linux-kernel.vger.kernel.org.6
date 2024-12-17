Return-Path: <linux-kernel+bounces-449222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE51C9F4BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E3E1893397
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7ED1F4733;
	Tue, 17 Dec 2024 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="b/sEJ3gG"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8051F1917
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440843; cv=none; b=Lkr7lyJXas1a+DBH4O4hna/AYDrsPc9evs/Mx5+KW2In5+RCz2GZTErVdQvzBpCZVq9WrmUVzwbukEYntkYP90EPE4ioMbWbFtN4NmGZcuCe+L5hAAYg09F0K+Cx/BeLjMFmdNzGyIh2SlJZzrVuwEZrg+L6pEAVVaL5ptVzBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440843; c=relaxed/simple;
	bh=tiFDbuiLhdgo9Mpr0DUuNilHyCSbQ7kNQKNgVyN9Ab4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cq4CPcKe6nZoH4xaZMeT5DcKPPzl3swXjwsjNq/1QUiSMr0u7PzHTS05Jk1OtjuxLhrYu1mIPBPXIf81KIL+3ir5owIGGyxGsADlvNzriF5C+au+C0MLrrjSIVpu8VdLW8AwbTxVTs90mnearrQO2VbLLxpZQtLeisdbXVFtkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=b/sEJ3gG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e27c75f4so4062036f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734440838; x=1735045638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKZH+3oGIzxnCr2Yt/BTYyEjHKZwxfdTXrPGk9BiJzI=;
        b=b/sEJ3gGgHTapuU0Djl6NbwvA10hokQ6/8jlaemZlGuCI0mzasiUTHyEYBBElGfbFo
         V0C5+LiaBkg5gCAAsZhaAcpkKJtSyiDo4NgHX8o/jMV5iCO5IxlNUWGCIJTxe3ohbiso
         lnTU0T9BybocVsdjBPu/GyHajCSkOR/yxzk3jr0f/EsdZxppHhGuK9WnLJCb65JajfF1
         4ghEiaY9ETW2QRQ/yp/XhpJFN/JyY1DVISXku1Xn7j1wz7KP4GorhvOrJVb5dzquW9hs
         PSVtgfeqBOEnQ0bTF55pEMRMCl+Fki/r3LPzMxuM1e/qmrvPdfHJfcRkEroqClYNtuD1
         c2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440838; x=1735045638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKZH+3oGIzxnCr2Yt/BTYyEjHKZwxfdTXrPGk9BiJzI=;
        b=lS+fja5v5NvynuOYCQteOqPWITDS51USkIMGlNWpUEuxUFsX0bviT6NISYebu41hZx
         T84kvDzW8B8hFNmn9Nv49eGDf43RtsXfMqoqFWUODhFbzHDSzIg38W9pHdaeQ2Qy880M
         X4bIP2dfK9zePheOy/G6w3fuTcIMUABr6c8Yukp888/05eTm5v5/bZYjnI+ldBZpoVqY
         KYv8mddjcpcv9kt6wYIAKO12dbS81DXrXkPN8k3F6JqL9WSXiOcfsFaNcGUtqUYlr55c
         9F9gJiBL1LtOhHAvojsdEAEkUzL0+vN5O6p3aSjcnxeWKJqDKHSrmGWqWScJlR/2A39e
         0QQA==
X-Forwarded-Encrypted: i=1; AJvYcCXsmvUKLPu+jzmt8RO8Uo9xQaEb9wkwAARL+19C+SQggDyeSGL11rMZd59eIB2kzkgezcqoNzacJwK5JdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6mcuS7rZ4MRlyP+POAaKnyCrjp70NQVxkzm4ByzvFSeRFPRp
	KiHoDqSVpl0OUu8bhra7NF2d9LVzMB8Slc0ldy9KHKfw6zlvamL+F4e7vpovN4mFEgjsdbZ4Sqv
	P
X-Gm-Gg: ASbGnctoW3sm9Ulia/xZfK15oJVErLN3iVPCTxl8OGX7kvxPAs1c6MOjBTjsRE9P8+o
	xp6wBXet+vfMkkEU4o28nem4xsMgwYUq2Ko2jf9HmHT8xG/Zy4E18+SXtjNfbQHKRUFTGvDPijt
	tqLxkKToXLFEaJjeg+7qo75UR85h0cERpraXbbvJPxd1pedIL15FoYhmbHWk+nquueAG6MyIynF
	esqhkTaBkIDm83sQfABlxnXNW5UbRpMdLQCz8FUt5ulWdZQ5+mDn3lf
X-Google-Smtp-Source: AGHT+IEgPO9ABbOL7ucdASbUynPyCJFyYcZhfnFIvIt0jen9/oVFeATEDojSNgDCknf4p2ZBBQdeOw==
X-Received: by 2002:a5d:47a2:0:b0:385:e176:4420 with SMTP id ffacd0b85a97d-38880ac2e1emr13175713f8f.10.1734440837798;
        Tue, 17 Dec 2024 05:07:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:4699:6189:1775:3ce7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801bb00sm10970196f8f.62.2024.12.17.05.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:07:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: qcom-wcn: explain why we need the WLAN_EN GPIO hack
Date: Tue, 17 Dec 2024 14:07:14 +0100
Message-ID: <20241217130714.51406-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the recent rework of the PCI power control code, the workaround for
the wlan-enable GPIO - where we don't set a default (low) state in the
power sequencing driver, but instead request the pin as-is - should no
longer be needed but some platforms still fail to probe the WLAN
controller. This is caused by the Qcom PCIe controller and needs a
workaround in the controller driver so add a FIXME to eventually remove
the hack from this driver once this is done.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index cc03b5aaa8f2..9d6a68ac719f 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -396,6 +396,14 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
 				     "Failed to get the Bluetooth enable GPIO\n");
 
+	/*
+	 * FIXME: This should actually be GPIOD_OUT_LOW. The driver model can
+	 * correctly handle provider <-> consumer dependencies but there is a
+	 * known issue with Qcom PCIe controllers where, if the device is
+	 * powered off abrubtly (without controller driver noticing), the PCIe
+	 * link moves to link down state. Until the link-down handling is
+	 * addressed in the controller driver, we need to keep this workaround.
+	 */
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
 						 GPIOD_ASIS);
 	if (IS_ERR(ctx->wlan_gpio))
-- 
2.45.2


