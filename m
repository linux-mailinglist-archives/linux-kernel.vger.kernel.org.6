Return-Path: <linux-kernel+bounces-255144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C1933CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94F11C23418
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5217F50A;
	Wed, 17 Jul 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JhLI8e9e"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9617E902
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721217567; cv=none; b=q4f7v/s82iaMZHHmlfUZ+07nybhwLuebk+pEVGkyUzz8H/KlMCkSkXe0Bji/kB0fcN1IeS7WDhgP/myOOVlJrz1KBqWJY+RiDEBYJqFv02/knR6capHoUz6ES6DA+LDvVLeJAG7S7WN/V8mIOHozKBrR3pa/wacHD63OVnqfcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721217567; c=relaxed/simple;
	bh=KH1+6eSbxrB1U64vYzIFihUaz/eu4frVte02WfURPuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEss3llm+ii33QATG+/UUtp6yNI4rw4O8Kk9iQ2vIkEiSOFQH0w5MNdciALZnl21NNgGCqkO5xlr9eeJ9bd3D/yPgmTG7+8TfJxO4PLGljfpptadzCdgEpreTKKWDzXB9XWuXiOiw/5qwNdLD2vsmwGxzWb2E2UUtVfC4fmhNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JhLI8e9e; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c95ca60719so4455738a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721217565; x=1721822365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcTlzdSbCPYBa7vAri6YqB9ZoXDHn//E8DaLgVTWQzY=;
        b=JhLI8e9emxYmzJRT/L5LOOMg+NVG9WDV2UPKhn5eID0f0GCPilxt5awOgwG7xIYvD6
         UbEONuCF4AEaI9yZfNs7A57eULJR5sLncCR2EDWlMLGtxFKzB5E762YPLFiY11e0DC0t
         45rIGPA4rkcgDxA6LeR2SgPnPwYolJ9/t5yVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721217565; x=1721822365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcTlzdSbCPYBa7vAri6YqB9ZoXDHn//E8DaLgVTWQzY=;
        b=EcEo8OseHH6bhk1L/G0YkUdipUt1dSo3UUvS5wZ5tobhe2SYILrk+ywTZ5qWVR27cl
         rnXuNWLDXqANpY4sWAzW6SlweMcDhJoTZYRU601jBgXywEWOR4gSMd0yz3l+51f8PMHB
         aVlNsdXnf8FDVgtxxqYjFMZYViEt69wZlx8jReqN2TX6q/4rZZ2gSJPIksn4+5XdaTLX
         kGNxG8FvrraRbhl6JHX64fdwFtUaqHYuNO4B0MCtoExNdbvEd2hM0IiwO1RC/MKp1CAC
         kkIOfqCNjvCkAZMFqJoeDGZ94we9wA8Gi3cN338lTzSh/uVL4S8LS72M6sbV2wfE7NPd
         h5GA==
X-Forwarded-Encrypted: i=1; AJvYcCU6C0CPEbSU8ZybdSK2Yx4tEghF/rDlSM1J7t6pUIppi1q31hvopszbXTZ5PeF0Jdx7IajvGlLnAiTkn8lTr6c65FIimrM4yPlgSz4Q
X-Gm-Message-State: AOJu0YxqKzfB6/vwyhaAlBZB/kfanSkSOpMDmLXisd1VcmQ3IG0aQnUu
	BVYjxqt2/m2CvWtWEYrfbFv5VIS9C3LbeaOtmLIaakzipa+i5D93AH24Qdgarw==
X-Google-Smtp-Source: AGHT+IE8xpZ5IZDUMHdNrgUQW2/WR8g1HkPeRhtTiLALcp2Xt/UQv21YSG9GEN31UQfbsAOI8lOinw==
X-Received: by 2002:a17:90a:c7d1:b0:2cb:5654:8367 with SMTP id 98e67ed59e1d1-2cb56548442mr722546a91.26.1721217565184;
        Wed, 17 Jul 2024 04:59:25 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:97dd:ecf:8796:54cd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd41a01asm10006858a91.32.2024.07.17.04.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 04:59:24 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: reset: Return regmap's error code
Date: Wed, 17 Jul 2024 19:58:52 +0800
Message-ID: <20240717115919.975474-1-fshao@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_node_to_regmap() can return different errors, and it's better
practice to pass them to callers.

Clean up the hardcoded -EINVAL and use PTR_ERR(regmap) instead.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/clk/mediatek/reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 290ceda84ce4..f8c0fd031512 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -138,7 +138,7 @@ int mtk_register_reset_controller(struct device_node *np,
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
-		return -EINVAL;
+		return PTR_ERR(regmap);
 	}
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -198,7 +198,7 @@ int mtk_register_reset_controller_with_dev(struct device *dev,
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "Cannot find regmap %pe\n", regmap);
-		return -EINVAL;
+		return PTR_ERR(regmap);
 	}
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-- 
2.45.2.993.g49e7a77208-goog


