Return-Path: <linux-kernel+bounces-311682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD9968C14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B37283A24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62AF1A265F;
	Mon,  2 Sep 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKS243Nz"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27538DC0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294979; cv=none; b=IFA93f5D9wz6b2c0zIwhq7KOuZ0bpn30RyZTLF6r8p+nX96Ra31UO/w+yZfP70hY6ew8R6N7xmEsqBtzaK2W8Lh05ggkTVi/t2YKmzUwexGgZ23mPmtgv+j/OCiHiv01/DlnEtFtnv1xDUIuTqTS3XlCUmAAF3cTQOHIWMCBuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294979; c=relaxed/simple;
	bh=qvvHFJ8lnK9KIhCzGUcKDmUOEyLurGVGCl31PNkTf9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO/5Ghq8qCq8FPG8rNCc/7q6EuQVPK4geH8PnA+EAar3UrXTWFBtfqKqKGu2jarAOegur4VfBxAc6zRoSZa6NFW6nac+0BGqTwM3/TFEhBxDq1n1dvG43tbadqEDEwnlDggWKrdIubtotg4zUIixVHLdSXRAgcQagAGGSi/Pi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EKS243Nz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53343652ec0so320138e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725294975; x=1725899775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TU2LEHLCwrpWezZ3IZxZU62qAYvX2zDAyjqmiugfN/g=;
        b=EKS243Nz4l6XhAdDmhWjpn0ICOtRXX7xA4FjDJM3VBdfsXAHrKU/TinMcPe2VV3Uja
         jR+n6KAMUnHLbMmiAYyQpawCKqHo6m4jhmVj82+ipS+1cL2oPOGfg9G+YwTltkimylHN
         7EM8DUolhQ8fD/T2Kty/MMgRQTTqFhTySXgzO533Ti85tP61zxCtxPlslOaWCXeu6V6P
         +6zMxf5+bZ4tZnOA1lK33/du0lUCxh87Hgv2R0+wSXICXIK89fbHn8cY4fto9aNFmf9J
         ty5vTy5TPg9ps+DtsM9NLfWYCEvyK9mYa3F8IQAtGa3HLURUq/YSv/7szd8MrJmU0qxe
         9kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725294975; x=1725899775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU2LEHLCwrpWezZ3IZxZU62qAYvX2zDAyjqmiugfN/g=;
        b=TlRZmpO3MhJYNZdemAxtJRxJubDreX1lfeWoQl2g6izPtoIu4psFe5NUaaj9xDISbU
         6jerKmJoE7+BSbVEXUSkdy20UCbtyFEK8WcQrTWrZALsFOJgzjeV/gLKM8N+FyjYngjZ
         loDs3s3eWxJ59i4YsiyPwYdu2eci3Wn1PiXPlLIi08NAkAmMHFnWLKNiSyNVYja2DiED
         Bo5KVq0pXyHnvHh1FvPOfwgeOSEhZiEcmvkcab8HQzLlxr2l9oRC6D0P5xeycPDXheY/
         HqZDuPQefF3GSzC3uEKGbf2A2d+a8X/Iy5cWk2O+QZ2CtSqE0CLhpQWo+AXrzEWXBjNk
         ReNA==
X-Forwarded-Encrypted: i=1; AJvYcCV5hi0fUdOe+Qg1a878vuKMPAPSRDAtyvsFzQfuLzzMc3+QdzVDMhbxv6RpLMTz6ua8yD/eouzcfD15a4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjSWaUoaiOt/DJ2VlpTXLXzgVqAMn1MltHS6ob8aATsFtGrzv
	HvNFF7zCfad5oMdq19z6EyyUdu1mR4zgsckZWbFIrafpWkVqCctBSwMhjD+DfUQ=
X-Google-Smtp-Source: AGHT+IGB1Go1LRTI0V901GHfqjQpvoLp+uw+N/JoNB7ELAzWZkx1eKEQJ+RwMMGT/z6IHlEfqA02UQ==
X-Received: by 2002:a05:6512:2387:b0:52e:ccf5:7c40 with SMTP id 2adb3069b0e04-53546ba477bmr3812796e87.9.1725294975103;
        Mon, 02 Sep 2024 09:36:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d7a2dsm586146866b.176.2024.09.02.09.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:36:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yang Ruibin <11162571@vivo.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] net: alacritech: Partially revert "net: alacritech: Switch to use dev_err_probe()"
Date: Mon,  2 Sep 2024 18:36:10 +0200
Message-ID: <20240902163610.17028-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit bf4d87f884fe8a4b6b61fe4d0e05f293d08df61c because it
introduced dev_err_probe() in non-probe path, which is not desired.

In general, calling dev_err_probe() after successful probe in case of
handling -EPROBE_DEFER error, will set deferred status on the device
already probed.  This is however not a problem here now, because
dev_err_probe() in affected places is used for handling errors from
request_firmware(), which does not return -EPROBE_DEFER.  Still usage of
dev_err_probe() in such case is not correct, because request_firmware()
could once return -EPROBE_DEFER.

Fixes: bf4d87f884fe ("net: alacritech: Switch to use dev_err_probe()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Update commit msg (Simon).
---
 drivers/net/ethernet/alacritech/slicoss.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index 7f0c07c20be3..f62851708d4f 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -1051,9 +1051,11 @@ static int slic_load_rcvseq_firmware(struct slic_device *sdev)
 	file = (sdev->model == SLIC_MODEL_OASIS) ?  SLIC_RCV_FIRMWARE_OASIS :
 						    SLIC_RCV_FIRMWARE_MOJAVE;
 	err = request_firmware(&fw, file, &sdev->pdev->dev);
-	if (err)
-		return dev_err_probe(&sdev->pdev->dev, err,
+	if (err) {
+		dev_err(&sdev->pdev->dev,
 			"failed to load receive sequencer firmware %s\n", file);
+		return err;
+	}
 	/* Do an initial sanity check concerning firmware size now. A further
 	 * check follows below.
 	 */
@@ -1124,9 +1126,10 @@ static int slic_load_firmware(struct slic_device *sdev)
 	file = (sdev->model == SLIC_MODEL_OASIS) ?  SLIC_FIRMWARE_OASIS :
 						    SLIC_FIRMWARE_MOJAVE;
 	err = request_firmware(&fw, file, &sdev->pdev->dev);
-	if (err)
-		return dev_err_probe(&sdev->pdev->dev, err,
-				"failed to load firmware %s\n", file);
+	if (err) {
+		dev_err(&sdev->pdev->dev, "failed to load firmware %s\n", file);
+		return err;
+	}
 	/* Do an initial sanity check concerning firmware size now. A further
 	 * check follows below.
 	 */
-- 
2.43.0


