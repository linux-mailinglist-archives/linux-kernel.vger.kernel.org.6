Return-Path: <linux-kernel+bounces-381738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3530B9B0394
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDFE2835AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834051F7568;
	Fri, 25 Oct 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjrK8CEF"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E11632F3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862092; cv=none; b=baC990ZdX985a7YUGCpxqHlPaJhc+P70UN60UiN7kAOElh/F9HFvCYled5EEkMYNFG7fk4Ci2EZyJ/XygdELpNUfzzwMp8gTZerulW4blcLb8gYrm7HC16knBDZTyTYW8BkY5TqZp/P4q9V+Jtt2Oa9BZKdA8N/XAsGD2XgllqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862092; c=relaxed/simple;
	bh=XQJlYvZ6vjn/TYO+WTDp4FMJOckllIU+bQgG44hsbCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F215NuWkMPfJ2yQi4wo94ruqPpsfmIqzBQlZFHR9INatgW9pLWotnKJtTTFcZeCQeEe+xOgDNvGhKDbddj8VU1zgPBLjZPaCQZ/PoLVrJ9lZlG4Qy8/gehRD4CNzZkDuZWzytdESz2q0xUYZBl8btHwRDmXKOfeNnQMHp7uNxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HjrK8CEF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431688d5127so20037975e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729862089; x=1730466889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mphjevL2wKBjhbt7qb95YXVF8X2HJNmvgdrJOySayeQ=;
        b=HjrK8CEFsT7+nAKDWnRBRB2T6DBSkrHLSjY/jqMzO3BzpbnjiWnfFjJYc8SerbXt8H
         BSP6bKWlOHvnOR8HHaRMYEDfJATtFBP9butVVIm6K/ASn0ta2qL6htUkAbyDvFmngLEy
         zVfhw2IRJog21N851OCsroQLPwUkqL14BUbE1ZpMZvPMES6VZ/jR4iqu/d/WJcoBAGEU
         UfS+MMQEdusjlNs9kdpf8VyZq55diapcuuJikVexH9R6sB2dya333DE955Zgx1P85nxC
         kyAfNtFSs6Mrp1ZaWa6pGex2mLx1FcsJCZg/LUED58WYlrlW4rNDCLkzlgfNObkjNfKF
         J3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862089; x=1730466889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mphjevL2wKBjhbt7qb95YXVF8X2HJNmvgdrJOySayeQ=;
        b=B74tdGELrKQH6Dzk+Yl71/IXd3DX7+brVDPgwjxKSyTYMQRmVYzeA/FsE6MCmuSiWM
         p1OO5MRl0O2EjpkRe35mXb8QTZsHJ4KZqvZGdK1jxa4uMxYPabT9gpJA19iAuXtegAG4
         gEM9A7+zcLyXZ/fNf/TZT8OZ38k9NFA1Td8ElVuTq69e/PLBix2y9y/X2Gm5VRIw9jo2
         LyXvQ5sJ8i0QBVBwakduJhZciZaYLEOtSGPAOyMEtI2xOqFi1mbdD6VECDBGw3Xos9Cx
         PQwsdAzewPTiiBxA7EPGFxJMKKZkVdlOQriWlFsxnNp0tG66i/+C/CKH0iOv6jfPdYpD
         uNwg==
X-Forwarded-Encrypted: i=1; AJvYcCXaY2hNWH3Hsi1fS7Io7MmO/p8LWwaxEx5UlXyEh3AkOrAUiZHezVxmo4umFR4lDgswdjh/q5bjQA7yX4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOKgdsYdOMGOjk4o/H/UGmS/aRfARMZfTlvd3Hq1WM1aiae8e
	vkWDP2MhaQ1sZrOX3tWdt22I67frdw9M8vY/ws2A64gI6+1Cf71GYCuQGdA1d8E=
X-Google-Smtp-Source: AGHT+IEoUmmF2a29+b6OYTb4dbCjEKsfEZfPzHCBO3Ytnq8YsVvh+s+5uHtHvSiBw8IREAZ9aiGHMw==
X-Received: by 2002:a05:600c:468f:b0:42c:a6da:a149 with SMTP id 5b1f17b1804b1-4318c73a46amr48990985e9.25.1729862089150;
        Fri, 25 Oct 2024 06:14:49 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.67.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b6bdsm47616685e9.45.2024.10.25.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:14:48 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	krzk@kernel.org
Cc: tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ebiggers@kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 01/11] scsi: ufs: exynos: Allow UFS Gear 4
Date: Fri, 25 Oct 2024 14:14:32 +0100
Message-ID: <20241025131442.112862-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025131442.112862-1-peter.griffin@linaro.org>
References: <20241025131442.112862-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UFS Gear 4 offers faster speeds, and better power usage so lets
enable it.

Currently ufshcd_init_host_params() sets UFS_HS_G3 as a default,
so even if the device supports G4 we end up negotiating down to
G3.

For SoCs like gs101 which have a UFS major controller version
of 3 or above advertise Gear 4. This then allows a Gear 4 link
on Pixel 6.

For earlier controller versions keep the current default behaviour
of reporting G3.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 9ec318ef52bf..e25de4b86ac0 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -771,6 +771,21 @@ static void exynos_ufs_config_sync_pattern_mask(struct exynos_ufs *ufs,
 	exynos_ufs_disable_ov_tm(hba);
 }
 
+#define UFS_HW_VER_MAJOR_MASK   GENMASK(15, 8)
+
+static u32 exynos_ufs_get_hs_gear(struct ufs_hba *hba)
+{
+	u8 major;
+
+	major = FIELD_GET(UFS_HW_VER_MAJOR_MASK, hba->ufs_version);
+
+	if (major >= 3)
+		return UFS_HS_G4;
+
+	/* Default is HS-G3 */
+	return UFS_HS_G3;
+}
+
 static int exynos_ufs_pre_pwr_mode(struct ufs_hba *hba,
 				struct ufs_pa_layer_attr *dev_max_params,
 				struct ufs_pa_layer_attr *dev_req_params)
@@ -787,6 +802,8 @@ static int exynos_ufs_pre_pwr_mode(struct ufs_hba *hba,
 	}
 
 	ufshcd_init_host_params(&host_params);
+	/* This driver only support symmetric gear setting e.g. hs_tx_gear == hs_rx_gear */
+	host_params.hs_tx_gear = host_params.hs_rx_gear = exynos_ufs_get_hs_gear(hba);
 
 	ret = ufshcd_negotiate_pwr_params(&host_params, dev_max_params, dev_req_params);
 	if (ret) {
-- 
2.47.0.163.g1226f6d8fa-goog


