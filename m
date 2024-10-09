Return-Path: <linux-kernel+bounces-356914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B99968A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8492C1F24019
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE086197548;
	Wed,  9 Oct 2024 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIvYHbmL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA823193432
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472923; cv=none; b=b6BA/kLY8oXISqXPF0/xtkvG11wbWHaRn0zsrsXPVQjWm9XKGqEdjcWX9ERRoxfjmd6Fu/5n06niI9rUC/vcTIi8xSOYjmWmWWZ0LrwYe6rwRggo82ygnTDTNYmKewbKzBKM7TPdDZ4k7fGf/S9Un2Ixpl6XwsqkQbb9XgGQnd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472923; c=relaxed/simple;
	bh=JxNG6eDRQStONM4tz52v0Ck91QG+AO2DWVUc9ANCsYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1McxOt4EiERakBTcbxCM7JC0GG+jK51qC/FXHbhSI24n8TaOILT9vC7Uvq/LmJ2dM1YGYpLYE5OGx1WhMaKvs55SPiQqjNFBHGifGrTm5G6q4eZCk7JFn2GCATqoGhny2Wn8d8Ybaz7uBJGVFTBWDfguL9PlsubOCDEf9sxjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nIvYHbmL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so5362285e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728472919; x=1729077719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DpEnA3YplEcQFI6shVCtQMIfbctSRU8+HvPgo32UcY=;
        b=nIvYHbmLfZgeRoYnHLkBTeImPy14vEevv0QP7RkkwhOXCB8s4qH18Fc39DtzEjNLBl
         I7NG22DlWetJq6E5CzfvPpstkCLGdLFSJ1JA1Yp27fWIi/wddvVUkClD/SovTnVsGzFG
         Iqlf5j2E2zZsojo3SkoNHr+AtK6PrfccKtDHAvsDvs/z8FEsVrYoJmbEJU5BORWduXB0
         9ZEkJbpFj+Uor+/+SKx3KK9UH+welIL4EhUo3vI6QHECtx+4i2LeF5NR9b/v8j5cYpiH
         w2Ii4tqJMQBv9I0O3h85MiD1YRcaY7zSe+kGczQn8AjOeEb98CdkbTGigikj++THgdaq
         +mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472919; x=1729077719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DpEnA3YplEcQFI6shVCtQMIfbctSRU8+HvPgo32UcY=;
        b=hzBGYPs4exeqC7uG31FH72geiVxiPz2uIQ0skzptH6ETLHtocwTI/KymqUxd3Ulxcs
         MxC68JH2sivwTdhzz0b57cSMAp6ZjItRPu/2hdquNIC+D6sciNDA/86VM/RqjQtXdrPW
         MWCt1dm5qTHphlu+kVVdG3fr7r289bL6gy1xcDTKt/aN0Z3sEOShUpTBAeIcTfZuiTnn
         Ky3k4ufR6ZkY67vHY4SE4vSD0/z/kFHQDjTME8eIMhZ9bXFcqGY2AeFU2rn7ii++mmRI
         UD3TGc631F/Uhlw6IJBwinEemwd0bZOk+91k+a37npM5Tx8kUZdgO/2FV8ZPgYtWL4z/
         4CBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6KTmaAY/I8t0mv7LKdSlZOAn16RTjucpd0vLh1/g48neY7j9YLiJiD3gCycQqR8FJF/hiwfeUEdP/Qjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws541cO15sw0BbRuVIxMtiBsPy371B2oYOt8UyUei60Cb7GQQs
	DK2mbQ7Z8+h4s/m+hMm8tCKsCQCT2peo5CMQBnDqCss2OgAOKOkfN+68jyy0Gac=
X-Google-Smtp-Source: AGHT+IGuNlqf0UjHLa+gCSHuJwmN6aEEWrwupvo8fc+pj3U1PFfl1qX4v/XDeaScMudS3KJA7vTNzg==
X-Received: by 2002:a05:600c:4f48:b0:42c:bae0:f065 with SMTP id 5b1f17b1804b1-430ccf041a5mr15501335e9.5.1728472919068;
        Wed, 09 Oct 2024 04:21:59 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4310c3dcdcbsm12331445e9.0.2024.10.09.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:21:58 -0700 (PDT)
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
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 6/7] scsi: ufs: exynos: remove tx_dif_p_nsec from exynosauto_ufs_drv_init()
Date: Wed,  9 Oct 2024 12:21:40 +0100
Message-ID: <20241009112141.1771087-7-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241009112141.1771087-1-peter.griffin@linaro.org>
References: <20241009112141.1771087-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firstly exynosauto sets EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR so setting
tx_dif_p_nsec has no effect.

Secondly this assignment can't get executed as samsung,sysreg dt property
is provided in for this platform. Meaning the execution flow will return on
regmap_update_bits call above.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 9d668d13fe94..d4e786afbbbc 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -205,8 +205,6 @@ static int exynos7_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 
 static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 {
-	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
-
 	/* IO Coherency setting */
 	if (ufs->sysreg) {
 		return regmap_update_bits(ufs->sysreg,
@@ -214,8 +212,6 @@ static int exynosauto_ufs_drv_init(struct device *dev, struct exynos_ufs *ufs)
 					  UFS_SHARABLE, UFS_SHARABLE);
 	}
 
-	attr->tx_dif_p_nsec = 3200000;
-
 	return 0;
 }
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


