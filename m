Return-Path: <linux-kernel+bounces-309206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A9F96677B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E5228708E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD631B9B29;
	Fri, 30 Aug 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9sObTAs"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D71B581C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037222; cv=none; b=eRPyMbd+xUbp+C8SINIsNIz0gYoBvGv0g6k/ZjhEMuTNMPTqMGtK+vWfOtgv1bXeoun171b/rk//qK2PZKZ+/Dtfdp1UH6+Pn6YSWy44IFmKVZDvxvriJS9QVNnLNtyZObqd+IL93jx0Tu9dE3tftIu6RgE4iRkcbZvM/b13tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037222; c=relaxed/simple;
	bh=syZ/Tm9jkxDxUsEQs0iKiuotS1AE1XVlUL77mpLa1CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Md+dc8oyFE71+UV6kscR68suO3fq+97jZ5XPg8t60jzMXUs9vu+Ko5VWd3uchje0/CRac2N7qhbR7WCIREExss6h1j27eyErcRIlTC91jiDE/rC0K1dwm9hssMjJy0Qms9u4q8lobCPA3TnWycWMVbn9m/ZELxeThXoXxDE8G1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K9sObTAs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334b61b6beso354336e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725037219; x=1725642019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZI3O6IjmxNtmcb2+iun40d+CO7lE7JxFs1f7Lc04So=;
        b=K9sObTAsamHo74TAqhu8vvmkyb2+fMu3mmui271FVBWIEsZ1N7EExZP9Nv4/99p5Ku
         5j9ouH+Rwc6/RUvONueuPWdSDRVw66mo4Iet6o05PT49G04yY6xSb66hvDsFstwLwONp
         uoFL0DsFFz04eI0hbPS4cF6AkCrzrBeJUhp+3Cre5NHE6FVrMpjk5ITPCYbaQkS8jZlb
         6amsoXD7FuGeDDNYhi/RKPBt125DgO02BfvOhIPPt0aqYkaoVURPI7wa1yLMJZfyjkuz
         gvQyTunUbOfb7sJOTxABl7yEK0Q2Fa6NF7CZ+NDRhQHqAWcIgT+OZACHIBMd5S8iI/4W
         XsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725037219; x=1725642019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZI3O6IjmxNtmcb2+iun40d+CO7lE7JxFs1f7Lc04So=;
        b=iIZt+hkqQ148IYO8w/Sk3qo65WWV0RqExvv/v4/w3i/PO95OR09eFR9zWiieDUgW1U
         EI3UW+ay3EuEzw3/hTqk/ImR1v4CjoatPjkdqffHpsWOfaH1O6KxVyuLgRsN1qik5YGy
         749uvaTgFRVRyy+TjWDIVm2cWUI1eae0HigRiCBYrg/kd/iXr4zjBUovWsCRp68umvZy
         dPHqxsrXB5vaMUvMT1FbzwIDavRAp4eK6KJdLHztmzZy89n62YTZByj02tK6G/YKDId5
         Y1p824K+ObcxOsNMVUmYhhhirIfQXHlyXqpVnGwrckxbY3OFNNHceSy54lVV/KXov4Fa
         K6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8DpRtuKM8X3dLO7b55LsZ58Y5+T2io0VYLlDDHMCZ03yQ56D3omyMblcxzI1E26mpMtMlgX8/hIk/4DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVts01C+N4n7S9W2Ea6hYRhErSEpSOpcdNdF0YTZJuyHfC07L
	eiLAxAm33R47TphGhRTVQfPpZ/xpQURKmdReuO8JUmg4cuuy6oMy5h4rgh6zsCM=
X-Google-Smtp-Source: AGHT+IF28D1RiDiU6WveBwrIhsnCfGlqrRQ1zHbivXRXaQfq4VRcCVOmj+X0dohBYiyYRUJ0Svic7Q==
X-Received: by 2002:a05:6512:b1a:b0:532:f06d:b12a with SMTP id 2adb3069b0e04-53546afcdabmr1072854e87.3.1725037218586;
        Fri, 30 Aug 2024 10:00:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891966dasm234226066b.122.2024.08.30.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:00:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yang Ruibin <11162571@vivo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] net: alacritech: Partially revert "net: alacritech: Switch to use dev_err_probe()"
Date: Fri, 30 Aug 2024 19:00:14 +0200
Message-ID: <20240830170014.15389-1-krzysztof.kozlowski@linaro.org>
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
Calling it after successful probe, dev_err_probe() will set deferred
status on the device already probed. See also documentation of
dev_err_probe().

Fixes: bf4d87f884fe ("net: alacritech: Switch to use dev_err_probe()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


