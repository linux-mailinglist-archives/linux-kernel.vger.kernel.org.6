Return-Path: <linux-kernel+bounces-227859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC3491575F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5CA282F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA771A01D7;
	Mon, 24 Jun 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2ansTsJZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229E2BCF6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258331; cv=none; b=ESfMSWDv6D7CAqA66rTrYMXi/SLmDWQmq2HhEmOVHPlixW2Mw8PCB664lLYG+XcH0/4VlktgmkgTHU5mgSARXememX4KE46af41m/WAvGH39ppIwwLpne5SydF/lOUW0+fyPSy/VXnNTqNAccziGBfeOwg8oHvLl3o9/Ru9yHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258331; c=relaxed/simple;
	bh=HfwFbWNaiNRg8TyHYnd3L0KeFcsIMwGZDXWebHcn3SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXuhq7RWI7pv3f+c+kMyQJM2D1tTbLV0dfu3EHt0uXe3nxauIvf9v3TNlWS8FqhX3irpSqOfvggQ/DcIBnyoCP50+0U2959QDsGrEy74TFL5JpDEOzo7ONzmz+Zry1AobzvT2I2FtiNLDTSNU+wIsCOFKQJjMwriIQXFBZ7b6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2ansTsJZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso52109005e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719258328; x=1719863128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHNCUGtS2GKKPWqaEddKMqmnF0GyncsWrVdaPJ8EJoM=;
        b=2ansTsJZAmrRCKMiVrPhX7rTZBtv5X8QCTIDSfpMdUzS1v5uFuO6xNAfrJaiRTmVnA
         HEhFaSN5ZcK9bkPi3MRoWYxB4I4m/+mkIdtr4aXMlFb+mJAjbgip+W7z0uFF48U1FFw7
         N7Hw57tPM4BvrjDkeLVXmDLYKjoHYOR8ApwQOM5W3bagejl4lammBj6gtqAItLyyRwHr
         7oiwNUuk69UY6QxkFuT8g5XEL1EGT7KSSJi25H43FEUZ2JqUNsd878qBMw8mCeCm5s7X
         p6mPOltCSWCzEerrT1oydGZjaUIhzvMuJ34U5MWwN8ztgcpSrMulGj14Z3k0IzDA8VE6
         jAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258328; x=1719863128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHNCUGtS2GKKPWqaEddKMqmnF0GyncsWrVdaPJ8EJoM=;
        b=dFESvCGIR0+owSoRkEuocBa+rRFKOvE6EQxUaR+pDhPsenkmK3YElh89Uvan8TFa/B
         PUhuBvlXR3hGJCK8bV+Y8JDWGoop7lNDJRoxRmyyZIviL+mZpagSsE4X8DPydStYNrXQ
         KgwFwKXSmrrRDbYDn//Ipnpzzd7BWSYCPUgIqik+01obHRgNZB+16kcju9E2d5FNIIFu
         lwnfeE66MjlWdQiUug8iMgrpl79Jbl4BbMY7aFlF5PXAtIIPuqzWRrz5lutktB0Qp3oI
         +Oo4fHTpfb/+ESklgxaqYNzNq/7uDcUDszbiUdTMDMuVw3qVcAzp97/RqEjOPUBw0Mj9
         Pumw==
X-Forwarded-Encrypted: i=1; AJvYcCUQj8ytvpxwl23H8AEXmdPjVTj2sGTakdua9mZt2AeRAeQwadN5o3RBC2xIXObG1kPSqE2c4Xsnasgxmq1w321azXB0vRMzQuPoDrjy
X-Gm-Message-State: AOJu0YykPTf7L+s7lfHhMkg7UXuf2ePoyol+B7/VChSKLUn/ISlAJmJT
	N5+p8SD+wdn283n91/Tz1a3GiZXlPjExMRgRL1CeCvmKM4K8VfrDUx1S8VVYejM=
X-Google-Smtp-Source: AGHT+IHHn6x1AxgTsnp5UO9F48QMyqsVVY2g6fOphzXTLGr96mHa6mvLaKWJAyIwfqC6JKPXW8LTFA==
X-Received: by 2002:a05:600c:791:b0:422:683b:df31 with SMTP id 5b1f17b1804b1-4248cc1792emr46281025e9.7.1719258328100;
        Mon, 24 Jun 2024 12:45:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b80e:a46a:7fb3:4e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42480bcab9bsm154626745e9.11.2024.06.24.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:45:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
Date: Mon, 24 Jun 2024 21:45:18 +0200
Message-ID: <20240624194518.37458-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We unnecessarily fallthrough the case for QCA6390 when initializing the
device and hit the condition where - due to the lack of the enable-gpio
- we disable power management despite using the power sequencer. We don't
need to look for clocks on this model so it makes more sense to just
register the hci device and break the switch.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA6390")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2b31f3dc33a9..bc6a49ba26f9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2402,7 +2402,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 							   "bluetooth");
 		if (IS_ERR(qcadev->bt_power->pwrseq))
 			return PTR_ERR(qcadev->bt_power->pwrseq);
-		fallthrough;
+
+		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+		if (err) {
+			BT_ERR("qca6390 serdev registration failed");
+			return err;
+		}
+		break;
 
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
-- 
2.43.0


