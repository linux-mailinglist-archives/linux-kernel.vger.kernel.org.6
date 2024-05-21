Return-Path: <linux-kernel+bounces-184723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EA18CAB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C8EB22647
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F474C04;
	Tue, 21 May 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6L9dSyJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAC6CDA5
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284732; cv=none; b=CECILiJzlagMUWC2ZVYxKdaQeIuEmN/kLEWxtQB1slnFF8oPAYNGbNELLPNu6Iqi0sScCvCjJarN5EaDqY1vLpsAplzvaJMCGuA4KGLWv41MhCbnhzJCjvqtMZzuMaWxfSwZIa4Y0gzQJtGjEGzfvyiOf5+oY/RD0e5wRguTM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284732; c=relaxed/simple;
	bh=cXnQhU7DTsaHUnDJalMnIg7XjAg9iNbwZVjIZgmeSpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2h6ls+T4uw+KlJn+BoWaZMjP+rRzEW5MDQWvoI9tCwY9nDD/xULw2YpPypZCCwfrql2HBrT/0SzZ/bAOWOJN6O+LCxheTk5VU489tZO+0J3l1zEU++Gqrgkd7PSw4GBHXyY35C9w8eWOGdS6wbT4JaMAdtz7QtUDYzYi9Yhnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c6L9dSyJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e576057c06so43958341fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716284728; x=1716889528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgcASYNTvkFLrMGDS2Eu8AcYhISRnJlaNxwD2bJ6AP0=;
        b=c6L9dSyJ0UDxhzPY2s7LGjyxjVKc6BcWwK6HFJjAcN1G5cKYLLPjdDFjqYUOWPO1T0
         aXyTYCCSGy1YQw/PSsBtir8M/sPenBPFD/bAGPZJDxLgWHvsf837Bqi3RKDVDmMBflTz
         f1mPgAi5c1jwoibA/oKPeThGvtXc4lWVR5VpFb0UMXir9EyteAelKsNYvFVxT7H3QWmY
         oD8gEHqpAlRxpDlxfYdW15cDaHmws6V1lFrlY2iyH6TLPse/AwBx2ekW8aut7nIWYYib
         ic4LH+VRzf6YZtH143hmUzPcYWDb6005vQN8ibnN/PoG0g+JarV9B7vFBOfc3qV5CON+
         a5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284728; x=1716889528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgcASYNTvkFLrMGDS2Eu8AcYhISRnJlaNxwD2bJ6AP0=;
        b=Cf7lXd8F9cFdPf8CRURTLY3AFURpuhZK37In5zzVj6LYqDMVlYLZ/3pyZPp4CrD0lD
         QwF3C4tC24BcDhRlN0/aW4zHTN0xhcHyT1VhIJvYl6X/7IVaGzU1enzrkLljTJno+Nr1
         AGXuUeOqPTRNCOIAdy5Y0wPLJNlnVdAvF6+1D6TFEO+Kdiv17R7Re2dbzY1ljdoJeQ0H
         6VaASM7FyIq/4k0lWH8KR04PJVJqNbCPcOx6vDq/Nqeu0+luewX7AOxq9aats6UJfHIG
         C+pMqNXRr99Wi9sYJPpnpd+vAnrpFCWojbybpjwA+6fvVVun99YQR6s6FvprLNqmtpKn
         AUCw==
X-Gm-Message-State: AOJu0YybBeLndpPDaKVJ2rTOUtIg5IH51oTwKJKG5wvhjjeyqaVIlz8u
	Zjp0WG7D/G3m2vv5Mom+tuDqEjH1WckEoRub/luePJIMCQTzCWs32FfjRaI+66g=
X-Google-Smtp-Source: AGHT+IH+yWZDlb8bLS8nPxgS1saOotk0gFOAEFagqvE8965Yk3oeS5tWeCYbJp5/QyV9ROS9rcHYXg==
X-Received: by 2002:a2e:7a19:0:b0:2e7:2a95:a735 with SMTP id 38308e7fff4ca-2e72a95b39emr30334991fa.0.1716284728093;
        Tue, 21 May 2024 02:45:28 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm13906261fa.112.2024.05.21.02.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:45:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 12:45:24 +0300
Subject: [PATCH 04/12] remoteproc: qcom_q6v5_mss: switch to mbn files by
 default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-qcom-firmware-name-v1-4-99a6d32b1e5e@linaro.org>
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
In-Reply-To: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=968;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=cXnQhU7DTsaHUnDJalMnIg7XjAg9iNbwZVjIZgmeSpk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTG0z325iTl+oMn1NQPrPRQ4Q6ZS6i5lCSsDT8
 POtLZsdzk6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZkxtMwAKCRCLPIo+Aiko
 1Qx4B/9aFjIwgs7dL0sZ1cXYFdsxgqusHx8lV3ee+k6wrcZ50Tk67GjspFGGFf+/SurH08Rlaor
 P1exT5p9sVRAW5FCra4CzBSV/8p4CoSitkEeo4b7DxhOWrXhN73ATE0JLeoqzTwvlsrIORsRyS5
 msC4jvfGmotWUr0mO/PbNY/cd4liaPOroxtECb2WF2eD7Dl91sYIonLL5f+I0NPJ0HL1/VXrShX
 cVLekJ/MtRuH8QjUxdC11CEpTNb8CWasj9+ltZbCjrNuQ5GOB3igW0r+MScMpyoIJQ8jNi+3onS
 DzH9oZmFQ4Fmx1ogoh9B0Ix2gxcm642ftyqgoPEQoOwegcvo
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

We have been pushing userspace to use mbn files by default for ages.
As a preparation for making the firmware-name optional, make the driver
use .mbn instead of .mdt files by default.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 1779fc890e10..eeaae2505352 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -2003,7 +2003,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc = rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
-	qproc->hexagon_mdt_image = "modem.mdt";
+	qproc->hexagon_mdt_image = "modem.mbn";
 	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
 					    1, &qproc->hexagon_mdt_image);
 	if (ret < 0 && ret != -EINVAL) {

-- 
2.39.2


