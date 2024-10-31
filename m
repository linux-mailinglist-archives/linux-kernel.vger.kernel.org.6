Return-Path: <linux-kernel+bounces-390704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88749B7D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B10B20E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E941BC06C;
	Thu, 31 Oct 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REi5PMzs"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DA1AED5C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386847; cv=none; b=bd139LdMOLcmqoSbXb2gpkKWaEQE7glaEE7b62sm59X+0XtRurppQNtAef8vkpEpapZsnZpBY2X+imB1VbzKAl4lJRy9KcaTJy/xJOQegMXHaeJAZYxPg5aFuhqPr9C6/8tg4vpa4Lt7dUDjG/t5s5zKUu5/qKIYsJY5Jtf1yLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386847; c=relaxed/simple;
	bh=XQ6lVdO/7PywiTR9Hdfz8GxGAKaSLgkznc4FBkJ+NM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCvJwJ5yAqvqSPgeFqNiyQ9daSBweJftTkPMQs2FYPvvU+ntwH+QBJGykaZw4c+QFCFhxKMNDMQ7kbFbzHiZqeKlRi7TpjDdJoH0MP1pKH5D1skoK+1n9h25KUWVILXYAZCE/UaicjgrU3zjxi3KaKoZCElR3Oz9EhJOMfqXBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=REi5PMzs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso8106075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730386844; x=1730991644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86sA0f6Os+pjSfGkaxQ4yImAusqnRJDENyNfYooIZr8=;
        b=REi5PMzsTUkrZruNOCMEGAHaD7oq5SZBFqZrNsRBv03+4M5H0BB5bpf9tG9G6iFcVU
         +zb44qfXNLfQrFUEumAJuhsD7buhlRyIBDsjPVD/x2Gs2N7IGKUUebwpjDuB2jA2Q8BN
         UTJQ+67GrBRZsNZpDXpn8tyMkooARiY/AwDi4ryzQF8SWx+z53ektiI29lQdDWN2K9qW
         6TtivJDuG2QEQTOW7WyxelOxwzubLCZC5s8QQ+FsZzvLVHgoqx1nN9VsGmJVSx9mui/q
         QPBdcc66v6xABxqTDGSsl+CpKGbme1ngNOZ6XsmFYAU0ZCCI2JDB434axeb82rNuVriv
         nPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386844; x=1730991644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86sA0f6Os+pjSfGkaxQ4yImAusqnRJDENyNfYooIZr8=;
        b=TzYI98ruSKH1k+VdaMEdp5O5mzjPqq8cZMmHVZIKSzw22804/tG/zz5Sn5uoNyyn49
         m8o+P1JnTecwidhMXGY7RGVn7he2/X6qpUwKW9Y32JThnNL4JofyfW1ZUF9Ep+8hKhUH
         RJX0MxjfHpESOdOjoO+xH0owuG55kIVtN8vd0nf0FbbSU1qA+579De6gn3SSwbj+6ukL
         yxVLLobjAc5N6UwvAUhPq7M1anhC1zMk3c9vkHOavvaUoyd3YoOAVdKqzchXYQn36y3V
         rp7cJU7Bh4KptybXcyRop9qi/+blriVmDRyF/+HRYYVaVaG4dIJTGuewbs8iDl6+5/ov
         SCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQsdOu4tTrUNWy9rlQJRnD6SLdiaP5SfRQGQt5VBhShxS1Ch6hlz44Aq5rYBLb6to2mWqiarRWcjzmsUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvlJln3llTjkP0jcr+69qf3sQ0ovS52VO5IMuCo/3agTDqQ7pk
	P2Nxiz63WQhglGX96hM0c8DbSdxrPhe0L/kcI4Ma3fcrplUO2lXP4Ql6AzQEOt8=
X-Google-Smtp-Source: AGHT+IHBzn01GkaFrVY+fjAehvpLRixtUxLHicSEaRnq3vqepb6mFx2FPf0yhN2kuBANtTE7+uHjZw==
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-4319ad049a8mr154531185e9.27.1730386843327;
        Thu, 31 Oct 2024 08:00:43 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm59163225e9.5.2024.10.31.08.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:00:43 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	krzk@kernel.org
Cc: tudor.ambarus@linaro.org,
	ebiggers@kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 05/14] scsi: ufs: exynos: gs101: remove EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL
Date: Thu, 31 Oct 2024 15:00:24 +0000
Message-ID: <20241031150033.3440894-6-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241031150033.3440894-1-peter.griffin@linaro.org>
References: <20241031150033.3440894-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Auto clk control works fine for gs101, so remove
EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL flag.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v3: Adjust commit message to use imperative (Tudor)
---
 drivers/ufs/host/ufs-exynos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index f4454e89040f..2c2fed691b95 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -2138,8 +2138,7 @@ static const struct exynos_ufs_drv_data gs101_ufs_drvs = {
 				  UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR |
 				  UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL |
 				  UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING,
-	.opts			= EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL |
-				  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
+	.opts			= EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
 				  EXYNOS_UFS_OPT_UFSPR_SECURE |
 				  EXYNOS_UFS_OPT_TIMER_TICK_SELECT,
 	.drv_init		= exynosauto_ufs_drv_init,
-- 
2.47.0.163.g1226f6d8fa-goog


