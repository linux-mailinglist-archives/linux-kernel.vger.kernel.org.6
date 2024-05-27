Return-Path: <linux-kernel+bounces-190636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E798D00C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DD51F2500C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED810161B7C;
	Mon, 27 May 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1KQuqiVa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C3160862
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814619; cv=none; b=hV4u+i42C+XUglmwwcG5PQNbrkzPFBFVC2pnNd2X6Og4YTII50m7rGUCsUj/zCT0nhdHtDJ8wn9l/USrtcBSX94K3VMxlzhFDp1yyys1C0WwR62xEpCWmxwm44Xrv9nbPrIwin8MgQEBRX86DKu95xdtQ3cHpRuq7AghMV5y+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814619; c=relaxed/simple;
	bh=UOdIhFOHCXnUmcMtfQR4ydaH425IMo8UKMJZN8P4dVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDAbW6eUsdn8b2gZD3oHeNcpXItpWmVQKlCoRMGpa4qYao+wGs5WEBD5Aepq5SSpxTl28tvwsCB4ltU6ZqenfxIXKZNjnotKWzCnweJusYNHcHS2j1E+qnvTB4tV9dzmwG4ychicmBrzDQe6GYDA5ciXxNd02HHr616AqrYwuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1KQuqiVa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4211a86f124so1290575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716814616; x=1717419416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMIsc88QGA/raXBhAJ8HOYxrV9zWs4VQkkcV3jWwTEM=;
        b=1KQuqiVaGs7yxbzis67l+k98QQP709nelbKGKzy+4F908M9rB6naGiM5y6aIRV/HSH
         sYom86Nx08ubcMwMOdY7+s3eOdvrVVV8/D/ZAZOEi2Sc0WKCUlwhs993LxGKyt/OX45m
         GkNFCXrFHKUCIbwmpwl9bfWb8ywjzIoZZgZx6Ve7d3oR54TX8XyI6KCkspsBbOthOKRa
         f2dkAFADR8ORaMhpkAVnrd0hHuePeu/7HGs8Bh1ONDPGaHGJFXgLkuzDDaO7x3am8eQ6
         TwjgGTprgllDE5N5n7tXtcLDrvhLSbObLJ0urKxthjjrkn8rWLfP7Q5xP7CgsMJTtG/p
         syMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814616; x=1717419416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMIsc88QGA/raXBhAJ8HOYxrV9zWs4VQkkcV3jWwTEM=;
        b=hNeT1+6HwWrNFkNh1FrWFl/DpxB7uLwqNMEH1fMwPTkZBmoPhEQkhmIaKdKAqZ0R2H
         tpGK0cosfwKqd0bdg5F71Y1KrVitzTRVj/G9Fih9/irV9odh8SQYcliAuBLm8qrQCNmz
         BIaRr3mYapIxDCMq05jjBBMB+1vRGQ6vjKWKtN2tSk451cFP3CyMG8vgBpZYQp409JDF
         FNQ46IaE/W/EAnEE21iuJEKmzcjQFNMxv6wBq7FhA0KboPez/gBcVr9aM2BexeVZQLvE
         MEDPzQLgQHxk2ClUxwA+8CFn1jOaHNAOblBQLr6KcAU420xRy70WyB/MlhMWjUn1gNn3
         ISMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTTZtE0bgyALHrxZk6o1+hBXw5UFcbtI5S2AehKvgpkzc0FPOsbosgzDRZnKDLla8KS/ygaPKe5LCIc/Fl0VCdFK1HomzK6+iI7np3
X-Gm-Message-State: AOJu0Yw7+GtJyguz7MR4Ge3E9F5f9epl9zdDsk8zW9nDorgHWoibiIuY
	VAkuk+XG0cb/oihRZyJhmrPsLFgFcAmALc+s27mIPPfedJVErBYpNWsvjJwEJA4=
X-Google-Smtp-Source: AGHT+IGHS2hqyOI9qx7SWsYsNRrw1KZtMzYDBIfKzpavK9BFQA+8Qj7BEEyV1gjd7nfY1kxjXzWdhg==
X-Received: by 2002:a05:600c:b57:b0:420:11c1:b240 with SMTP id 5b1f17b1804b1-421089fa31dmr75205545e9.24.1716814616420;
        Mon, 27 May 2024 05:56:56 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:c322:131e:ff9d:ef41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f64f98sm138753635e9.24.2024.05.27.05.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 05:56:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 May 2024 14:55:02 +0200
Subject: [PATCH v10 12/15] firmware: qcom: scm: add support for SHM bridge
 memory carveout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-shm-bridge-v10-12-ce7afaa58d3a@linaro.org>
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
In-Reply-To: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Elliot Berman <quic_eberman@quicinc.com>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@quicinc.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ssj56Ix1KLezlyyOGeC/8+DTWmkSbhleOtHWewaii4A=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmVIMKC/c22Md4Uz3vbA/APLMpim25HRO37hokt
 wXXRAQw5JWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlSDCgAKCRARpy6gFHHX
 csuCD/4mOsn+XF+f6w+IEn9bDOU8ZPnSFEaKbDF5hsaUpYm9yN7YUE/dnt28Y01dVliV3UNnOj9
 njtcycp5gwRuOckGQmQFdlEc64TWGKAhG37NR9n80CSpV/6eSnaMF3oON70hljgYi2YhceQHD6A
 feDbHTXCwhrtstW5pJCcDEY9Kh2ktEns4IK/tq8mSqTIk5ThKUu7aeWMoWyLOGfsPl6qFlsK6F0
 49fwgVA8bQU6GCSe2lBOchXyu9vHKi/iuJEy+BEV5QNiyiQ+/VjuquGwkflJzx6LBrwD+StwHrQ
 u5tExvLp+TV1SFSsf507iM9xCfspBwA4VPzGkdJCMdhwlIb0aARxhqSdq/4CzIM3q6vUUu1uLul
 VFmg6bI22cvN/tFaJw+bk+ZjlvbsQy5FWJgZ8vVzxU6P4Ec6vt0c4r/eAKW1q7tKksovmB4zk2T
 4Z5ACKAPnTazOfboNG9z35YFR0SWgW06mtzHiJUskBOQzva/dMTgPu3YEyW8a5oRR4O49HKDWp6
 KsA//9kmM5/4V5uQKQqxd4/0nURFOtLvZLcLvtafh3VFVN7eD6ZU/Zm0yHlslEzJBMjIjmPigkV
 3EFvp71GWEIJH+J7mkOZPcRMQ0Eekqdw5NUguCfJHO3xW8gL7+H4ALxhs5RcOCHC+lg9OXGxqh0
 AVp9TLyR5clsUjg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Parse the "memory-region" property and - if present - use it to assign
the dedicated reserved memory to the underlying DMA callbacks which will
then allocate memory for the SCM calls from it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 94c34cde8179..c82957727650 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -23,6 +23,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/sizes.h>
@@ -1942,6 +1943,11 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
 		qcom_scm_disable_sdi();
 
+	ret = of_reserved_mem_device_init(__scm->dev);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(__scm->dev, ret,
+				     "Failed to setup the reserved memory region for TZ mem\n");
+
 	ret = qcom_tzmem_enable(__scm->dev);
 	if (ret)
 		return dev_err_probe(__scm->dev, ret,

-- 
2.43.0


