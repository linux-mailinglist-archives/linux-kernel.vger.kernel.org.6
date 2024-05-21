Return-Path: <linux-kernel+bounces-184724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BF58CAB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1F21C21AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7C757E4;
	Tue, 21 May 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xvx6a4lH"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68292657A7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284732; cv=none; b=fl+zX/OCcyR6Xor6asHF/fQkAiwR0SZ/nYcx1YyK0yvw1wWsd1tqAVDUicZfoYrt7TayvVTcgGCVU7yEvPl3OLSMnmweorMoBdZoXAsE4ykm6VykbJjYAAuA7p+5xMCt06ICf6CSPfDjK7PH1ugcC+oE1SK3/ewpb8TIR1smIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284732; c=relaxed/simple;
	bh=93C6VdWrKA3F4L2pbTvmlVsMwuAb+l57jMfHeI9flc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tmODL2lxrGgYl1JpseLQCrU87E55CHmoQJteUsyO+KNTbpRzFyLp0p2FSZvpK0VNBM+f4GjSX2k6MFDEDJRT/GJ4GePfW/fBTodF3dz1byeGmoaZUiProOeE1hnT2eTvHjR6XpoyVBVU/pkkStmJ84fjn55qxE+Xyf0ZEHYH+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xvx6a4lH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so22802761fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716284726; x=1716889526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A25lOkPAYIem0QXdhyIts7q0LCcqMUXPkolw5JT6tE8=;
        b=Xvx6a4lH314okQqJ9pylwxi4TIrQKSzwBTkck4zwg4T41DQWbw9IDxwzmA75eoVE2E
         5RmiAF4uhOnxx2/OpQcDNenWfx8cwBNxwZTLMTRunMlvnK16MlQzaJsq/g2jSgiIbKul
         ylRbCznYVyTwou2m6XCce7y+o/MauvIUr6vlRb6XleH5rJvhf7vAbc8AYRu5BV2jqp64
         SsSw2rBm5XqukLia+jqMG3NLaV3inaKhxslpFInB/mhsKSFs9S5iabrJ2/SxGlfQ4ENW
         DfEzyzpftRYCynI96Ce/O/2JygDHA7aRl/P631s/h7X49NMLra0OAW5makMYpUu+NJsN
         XjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284726; x=1716889526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A25lOkPAYIem0QXdhyIts7q0LCcqMUXPkolw5JT6tE8=;
        b=vVa60t3EjTsbfFrZAFsEwHJx9gyaXRUsv7uP2/YeDXe2S5AK4KyHGiMlihf0eKEk6Y
         QbRx47Mai95YU1FTXu1naJVFVaSSFZbfA2l6iFHRWbS0IXEnJeJdJUNHixyRiulNUL0b
         Vsg4y6og9c0mRkPt9MBOU7lf5fy6xtkXvzXu4/Kp3beCKXzl2UsKIgBLgSuuQSEZToZ9
         M24fodKBVbCkjpvx0x/PvQs71xyu3p+A9lAu/8w4aDLKaOV+TXf2BvmJgXAMpeTZkVE+
         wHus+/lfVS5q/9dJbmsqxs5EGCHVI/AjxRi4Vlw6tQo6gHCTatImjsToT2eF4jhFK4UJ
         BVeA==
X-Gm-Message-State: AOJu0YwO7psuh13bJc/2MsdOXJd4Cqob7+UcxR3O98B8F6kF93A2Le+f
	ib0QpdQaxGKRUX7JgD5MA5JzVGR2XUd6TBqCh7VAN2yYgwnWA6L/gugKsbv2v5w=
X-Google-Smtp-Source: AGHT+IEAWe28pTg85AhhLUeeo7JJ7lfVb04BZMvFFnep7DU1veqKcLN+AogT8YrMcOrIFXgcishk6Q==
X-Received: by 2002:a2e:9053:0:b0:2e7:bc7:b6ea with SMTP id 38308e7fff4ca-2e70bc7b72fmr75487961fa.14.1716284726753;
        Tue, 21 May 2024 02:45:26 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm13906261fa.112.2024.05.21.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:45:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 12:45:22 +0300
Subject: [PATCH 02/12] wifi: wcn36xx: make use of QCOM_FW_HELPER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-qcom-firmware-name-v1-2-99a6d32b1e5e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=93C6VdWrKA3F4L2pbTvmlVsMwuAb+l57jMfHeI9flc8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5pPrhGrlNQyruXtrrrFAV5mO7lzjzx0qWr/6p8ZZcok6
 9XmGN3JaMzCwMjFICumyOJT0DI1ZlNy2IcdU+thBrEygUxh4OIUgIkkX2b/w3lVbFHDvhj1dTx5
 zJ9idwhd+1Gr82OL/L5D4j5l77dIbV+ktCJm2Xx91oh63TtRWqrV1pV3kitkelPOGvdudGI1fP5
 mR6/o3Aie5c9Kt3XPl8j6b7NDzlbveJsmb+5kX+X/vo7XLIR1d12X+e9Q3L9tsoTMlAuqnya+N2
 1uiK8+Hsaq0prWs4E/drVY9hTRnamP9gV/npM+W2bHBYVFl3O6E6Yd6zqx0Smq+9a+D9+Fjfc//
 rhqzrzm559yZu/esGfzwj3iOsusG2WtDRSFGR6r68v8jfhW5HPWNquGhVlQycyZwWv//Uu+Rha3
 TPJEthr4K2r21UfUvO7tMjqmdKX7h/V2vSOWq9V5mp0B
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make the driver use qcom_fw_helper to autodetect the path to the
calibration data file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/Kconfig | 1 +
 drivers/net/wireless/ath/wcn36xx/main.c  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/Kconfig b/drivers/net/wireless/ath/wcn36xx/Kconfig
index 5832c7ef9352..90239c89676a 100644
--- a/drivers/net/wireless/ath/wcn36xx/Kconfig
+++ b/drivers/net/wireless/ath/wcn36xx/Kconfig
@@ -4,6 +4,7 @@ config WCN36XX
 	depends on MAC80211 && HAS_DMA
 	depends on QCOM_WCNSS_CTRL || QCOM_WCNSS_CTRL=n
 	depends on RPMSG || RPMSG=n
+	select QCOM_FW_HELPER
 	help
 	  This module adds support for wireless adapters based on
 	  Qualcomm Atheros WCN3660 and WCN3680 mobile chipsets.
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index e760d8002e09..8d25db81c1d0 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/rpmsg.h>
+#include <linux/soc/qcom/fw_helper.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/soc/qcom/wcnss_ctrl.h>
 #include <net/ipv6.h>
@@ -1609,6 +1610,10 @@ static int wcn36xx_probe(struct platform_device *pdev)
 		goto out_wq;
 	}
 
+	wcn->nv_file = devm_qcom_get_board_fw(wcn->dev, wcn->nv_file);
+	if (!wcn->nv_file)
+		return -ENOMEM;
+
 	wcn->smd_channel = qcom_wcnss_open_channel(wcnss, "WLAN_CTRL", wcn36xx_smd_rsp_process, hw);
 	if (IS_ERR(wcn->smd_channel)) {
 		wcn36xx_err("failed to open WLAN_CTRL channel\n");

-- 
2.39.2


