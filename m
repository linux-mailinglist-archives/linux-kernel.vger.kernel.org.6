Return-Path: <linux-kernel+bounces-432629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1579E4DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1878018815D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9D194C92;
	Thu,  5 Dec 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="SrjA26UE"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA52F56
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382298; cv=none; b=ok1uO18CN0/ZenPsUsg2HKS4l0jfx8Ffg9R1pb0gXGtfgcxSSK+TvEiw2LbWXgVMw13dLf7gyh2cqAWHspvyThdXO4VLKGDcLevv/i9jL5n5DsLRvR0qQPVUaMQHdP7HlzwuCDjl8qpDPZFiJmQnTNIt3C/7avtps056oJ2J3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382298; c=relaxed/simple;
	bh=m/f97ERBBpFa/UpLrOvmJtyOnLOGKKbi6oDbmxStgPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXKI5RK0hv8z0HhzeZDgFkTkvorA4pLfMFiNCUATMh5L31duXUQWfHTHQ9yjSocdiI3+txy6BBAp63v9bmxBcCru73NUjpeF7PNObbrjgma19MRE/o2KUeIDpo++QElgqV8s1X7j/sez+ohQ3MXosWx8av6Jx11S/9S+W/gPOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=SrjA26UE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215bd2c32a6so4153795ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1733382296; x=1733987096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7j/UgtFrcoMY8m73es7ngDsr08IcsBqItBi0rKEaWA=;
        b=SrjA26UEEzN7JGlWw5gmzRji3XMcGWY334DY3YgW39po/YevXPFBXDJtoJAT/aJmXd
         wycS1COlCD7nGA0zBBMw6yEWlOAiHSGnlyVkfTGIVFsqjYhlsc1avPE7CblAyV6UEbIw
         AjlW2TR5V+7V8/fC4F+EHip9DNjMxHS09I2Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382296; x=1733987096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7j/UgtFrcoMY8m73es7ngDsr08IcsBqItBi0rKEaWA=;
        b=pQAp55ZqzPCc4wf7p6oy4ukC4OBK1WuPYthr4XpeE/8EoyCckvFJArOL4zEviSkdql
         saAy/BcBrgdNZF6drK0wU9WNpyEQTGkf567uw7N5Ywt1kWd5cSt/pCSX0m+8bs5uwEMG
         B02HGxyn8TwI4ZU1oHCq2yBGv1MmeoLuFtBKoJlxQgxoXnzURWd6BLto0F2NxuzV937A
         kKttv3+ainXoseWXNeLDN9Vjs/5LpmuMt9n5k20T+235SISphkfaRHDP9/lyxy2Gp0lV
         NBCBbOQWLUdZFjYT28FQC1wTTEdJDtS4PgMWmUHteDBna9PyqCM22ZMX2pMJwCLiLidp
         ZzFA==
X-Forwarded-Encrypted: i=1; AJvYcCWkbVUJ7JJh2/ZoLdnHIttXGXxhIObe6hu8zHr1Lo7wOIkQUfHxmadGEQFfpwlsnJdhiKuPWn+3/QTEd04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCZlEfyIm05wKiJwvrjYtgg5VUcrLCM+hzXmMyF0zqhhSUJaz
	fdrgKkha0uoMoFIhvkUfrkzk5dcBD6ippGDpgSvDcPubEwAfSRGk+EKax0GPONc=
X-Gm-Gg: ASbGnctsJOUkkUl/hGyEL2+cMG6kt7m2gmlZULCxEswhB5dOtYsxt4OZwj6310dHxSp
	nToNKVvz2zUxFkhMoLnJi8yULIPKQriWyLW/PAQikfZkg6QSNPJaxa9+Umc0UFXpBggrDVzoP+n
	DJNDxxC2bLnx0AiQY3VgIm4o1wZcO20Jd+sadAJ4HB9WY1zmP8anH6NI4UpjfJ/HSbRT/YFkYm8
	8ujKWpVJftp6/spEfEdhiPko//4ovseQJ7roGNOSZe+bwFWSD0zq43T8LBSvQ==
X-Google-Smtp-Source: AGHT+IHKQ2i58trsh6LYFt/mJ/5n7Fwldry0srZBO/tlpGmiCU2xAa7w9UmZh3pU7B5cm7H3BIQ8pA==
X-Received: by 2002:a17:903:41c8:b0:215:f0c6:4dc2 with SMTP id d9443c01a7336-215f0c650cemr42892755ad.34.1733382296304;
        Wed, 04 Dec 2024 23:04:56 -0800 (PST)
Received: from MVIN00023.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f27189sm6099975ad.237.2024.12.04.23.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:04:55 -0800 (PST)
From: psiddaiah@mvista.com
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cminyard@mvista.com,
	Purushothama Siddaiah <psiddaiah@mvista.com>
Subject: [PATCH] spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()
Date: Thu,  5 Dec 2024 12:34:26 +0530
Message-ID: <20241205070426.1861048-1-psiddaiah@mvista.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Purushothama Siddaiah <psiddaiah@mvista.com>

The devm_clk_get_optional_enabled() function returns error
pointers(PTR_ERR()). So use IS_ERR() to check it.

Verified on K3-J7200 EVM board, without clock node mentioned
in the device tree.

Signed-off-by: Purushothama Siddaiah <psiddaiah@mvista.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/spi/spi-omap2-mcspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e2400a067a95..add6247d3481 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1561,10 +1561,10 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	if (mcspi->ref_clk)
-		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
-	else
+	if (IS_ERR(mcspi->ref_clk))
 		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
+	else
+		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
 	ctlr->max_speed_hz = mcspi->ref_clk_hz;
 	ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;
 
-- 
2.47.1


