Return-Path: <linux-kernel+bounces-390705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D809B7D93
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA451C210BA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5AD1BD01A;
	Thu, 31 Oct 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jG331kOG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB291B6555
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386850; cv=none; b=Rl3quiQiNk9vcnouScnf+eY7UMhxMfm//u6SwpUpT0YEqabVM1izQvuLOpfwynqF9Da580oIswkjxOJ7E2mfB8wBn0EAsZ1rozmt4yv8XFf8KRAXY96QMhpaioSGlu3eSj/b2+bQElGx+rho+FVXJD2qSn8niwWisWewIkZRQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386850; c=relaxed/simple;
	bh=FSTQzgStkDk9VUc+gsKO61mfM9QA+iMwJ9eF0K091kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5aOTt3cqmMp/kc9JiEeh1egQj655tjamoqQr34u3gXC14DvVJBNMIesDaZK7QyMnDOdRacxxwjhVn3PWUek92nhBwl1pEOLKjC4zIThA1LFEc1OTLCaGvIq02Fq/as4267wPafyLLqfUfy8vJ7+FXmn5hngRPHaY79jgXqsIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jG331kOG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431481433bdso9176445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730386845; x=1730991645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HABtOu8vBnUR430AFYIUSUDi3ELEcFC5jVUmm0tB11Y=;
        b=jG331kOGlx7cm18wCCreGTLG/dtm9oJFI6eVCYPVG6HfwIOB0dgY9XuOwICZBUJESS
         XWPUy2Y1XPRsz4qwRUAEnJOSMWe9Od7iC7ahbrD1PznW62WKmevBa+2MI6gtE/hRXiQr
         28z4/cpK65ienqBNxDwdXOARtcd+rprysMKvS4f43vX6l7c/EG9R+2Sj0upKinY+HmPN
         qDhmxXEQaOIy2faNFVVrZ5MufmxeEylrRn1Lu1S7vSK3EcJWqH6cqZCeIF3FHsd/uZz9
         WXSU+1q6ng8a008gLYDeW/3t8V01Z2m3c1xOhucW4R5NoHuvmRjPLNDJD0jUeUArn9FV
         CBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386845; x=1730991645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HABtOu8vBnUR430AFYIUSUDi3ELEcFC5jVUmm0tB11Y=;
        b=HwHyPXocEgKcxT07DmTVe0vjQSWGxngVL9fAGgAEHi1b5yJ728f4Nnv/6tVm2IyAca
         CQ4mEknlYt1eDM2Uh9XiyOJA9o/uqqFa7fcau6ePVFumngNfRGbJDGBvO/CjYFDo44lq
         9EH7X0+BJXCrohdFoD+fKozsN4macHMGtg3cjBtg9vV2xAQncmKK1Raf58FhjEUVaRal
         c5DKfan+FUbHDlFGfTjiMvRGWSImLF+F1GateQWEDUPXemJJGVtLt9XL41Qs3s3crfH5
         6OccSXiDSZPYgTYo73j/mFYQj1FA2SMvGl4Qg5yh35MB9lO7nyMV46bOybNZ8ygKmoEq
         Xrgw==
X-Forwarded-Encrypted: i=1; AJvYcCWozD6xXlIi4DSMB0aKnSUHGWD+Sro8hfYIUcU8M3ekUGbxkV8vyAlQPj3XJYwtqC/GgQ1+aNiFwvIzqSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1Iy0mJshofAu4vxuqCSK6AzKx5UGGqRY6hfxCCCOSwp9ubP3
	SCJrwhWqrgGk9SZ7LXKguttFrUioffnE/D+QB2z35/dyAFmqOr3PT9B49m6n0RQ=
X-Google-Smtp-Source: AGHT+IHrOUYyAxFC1VJUc6y5oX3ddkyV0eSXyUdqL+WEdAPlUpCNJwf8n2c1O5ZakYFeCDJkSDGQIQ==
X-Received: by 2002:a5d:64a1:0:b0:37d:4fe9:b6a7 with SMTP id ffacd0b85a97d-381bea1c1f4mr3210183f8f.36.1730386844715;
        Thu, 31 Oct 2024 08:00:44 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm59163225e9.5.2024.10.31.08.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:00:44 -0700 (PDT)
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
Subject: [PATCH v3 06/14] scsi: ufs: exynos: Add EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR check
Date: Thu, 31 Oct 2024 15:00:25 +0000
Message-ID: <20241031150033.3440894-7-peter.griffin@linaro.org>
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

The values calculated in exynos_ufs_specify_phy_time_attr() are only
used in exynos_ufs_config_phy_time_attr() which is only called if the
EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR flag is not set.

Add a check for this flag to exynos_ufs_specify_phy_time_attr() and
return for platforms that don't set it.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
v3: update commit message (Tudor)
---
 drivers/ufs/host/ufs-exynos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 2c2fed691b95..0ac940690a15 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -541,6 +541,9 @@ static void exynos_ufs_specify_phy_time_attr(struct exynos_ufs *ufs)
 	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
 	struct ufs_phy_time_cfg *t_cfg = &ufs->t_cfg;
 
+	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)
+		return;
+
 	t_cfg->tx_linereset_p =
 		exynos_ufs_calc_time_cntr(ufs, attr->tx_dif_p_nsec);
 	t_cfg->tx_linereset_n =
-- 
2.47.0.163.g1226f6d8fa-goog


