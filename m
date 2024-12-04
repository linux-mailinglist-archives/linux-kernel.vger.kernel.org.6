Return-Path: <linux-kernel+bounces-431388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B69E3CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0061672C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA01FF5EF;
	Wed,  4 Dec 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OlBvW6EB"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1B1FECCD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322413; cv=none; b=LH7bZFk2V2X6GMBIwBvE9fnVZ8TihcOtGXUAaE0ez0xxZ8g33m8XBSit4ZKNwAFZ8779RdbnsIzXbXzTE8xUx3t6UiZFk+QYn5c/JM+mQ/h81jqJ4UBO5vQz4Neab06G1pBB1r2GtVSr1pfUPvUXWLB4FLZ/sE7xX6DfTMdd+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322413; c=relaxed/simple;
	bh=qCu9A/y2OyMs7h56cxNRqbX/XeYEdvmyAnkDk2O1u9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSQAVuTtbojvMgu6lSD5UKGVwaz2Cnm7W78Aab6P2Hbekh/R+xPn0TWVnLh97x0cY4cT/lv3POXyetuhB8eXaio2AAk7Wz/0jWgfFBRvhx2eeUCB7OwfvTa0peXwqx+3VSQj5zDiMwmt5hAcdEyezXkRRUJNnXlxVF+PTviXVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OlBvW6EB; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc1f1748a3so4602707a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733322411; x=1733927211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Zm/pDEZ2wWuq6CLhWp8fdFsf6yo2FBchkfiY2ICjk=;
        b=OlBvW6EBmQW/+fkuecbC4vvBnggvmEvXNCp3wRb8qASqWmCaFxKgxgcTtcaLMvrdju
         aviaPfKLqLQnnpJspeIDuiu03OY9s92daiww2Sd0tBfRv3aUneA1vyqzvM/MhYrYRgFo
         j7yV7h9WvslkqZ/oH/kSMT49y3LATsRMjRDww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322411; x=1733927211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6Zm/pDEZ2wWuq6CLhWp8fdFsf6yo2FBchkfiY2ICjk=;
        b=jOkVMogUVj720jxqmhrJJOSCzRYwKcke3jn6ymGvoWzOWRhud3azEkspHQ4QedokPW
         sR7dhn1Ez4hnm11Nr2pbCjEu/2d4H5WdPULd7jvr05MZ2AuBFna3y+dxlg2QloKzNlfp
         9MW8dYFXqxeuFx/Py+FRzaVVK7/Nse1MxVdOJpUGXruegSZEeeKxcN0yFcs5mYw18tCd
         jb6amY4yY21A3OS+EepgrORZHYwZDmFfEykn/W96lLNjjW76IJFkNqbzFA2k/bRJM1Lr
         icYiGysOfB6eB9g9YJTXu8Pic/pqlx262ra9kZtI00IN4f054Js6vKNM10NPwHfMmHC/
         RInA==
X-Forwarded-Encrypted: i=1; AJvYcCWtLAPgGWeL+ciAcPTjXVtD6zMJsQ2Z3o3EwcNnUY6hbVo7FvIKaR6dKalTYN+k2b1/kfxHQEdJ2wqvrYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVG6z6Gagpr9qpgxHZx1JRnkPtH/FdMoyGXWy9d9kTZHILDtQ
	RPBvx9OAl6tlKnEU96wfqYYhnptkUKS97MK9pbhAAVW/DtxlLDbBJcT88au2fsl9rkOD6/qlAqo
	=
X-Gm-Gg: ASbGncvrsFNXXpAiYR/T/iRj01DRF0aWIL8qbXaBd83p6hBM11BOeZ6x/z7EE/NjxXA
	VhHi2FDu76Hd90x4X5ggRRbQmmKF2U+nhMBFlirdpepKoxyDLlzgdGIl6Qu91LSHFYkdy/MybtT
	DrqWRdPIgQ7fFr/4Gxp73WHnVZ/fXgjmKd+kDzecle9LLAWGkEGR2p2r8pEJvjfZo7VVdnDcCWj
	B9ikwsKETrUt81lvN2bXuknWJtST83xPA3NLhqbchkudvh3INhA+SEpNl6m/NsI5YM=
X-Google-Smtp-Source: AGHT+IF0dNNNk83kN4LRrd8AEGyz62WUomCygJPIZPBTF7uW7lrdAcSow02U1nyM8E/b/c2B1GaPog==
X-Received: by 2002:a05:6a20:cfa6:b0:1dc:bdbd:9017 with SMTP id adf61e73a8af0-1e165412f33mr9668165637.40.1733322410642;
        Wed, 04 Dec 2024 06:26:50 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:b764:8a78:a02:6e0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a2a5asm11416510a12.80.2024.12.04.06.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:26:50 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] drm/mediatek: dp: Support flexible length of DP calibration data
Date: Wed,  4 Dec 2024 22:25:38 +0800
Message-ID: <20241204142626.158395-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DP calibration data is stored in nvmem cells, and the data layout is
described in the `mtk_dp_efuse_fmt` arrays for each platform.

There is no guarantee that the data is always a 4-length u32 cell array.
For example, MT8188 has a data length of 3, preventing it from passing
the preliminary check and undergoing calibration.

Update the logic to support flexible data lengths. Specifically, we
validate the length returned from `nvmem_cell_read()` against the
platform-specific efuse format. If out-of-bound access is detected, fall
back to the default calibration values. This likely indicates an error
in either the efuse data length described in DT or the efuse format
within the driver.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- use %zu identifier for size_t in dev_warn()

 drivers/gpu/drm/mediatek/mtk_dp.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 36713c176cfc..55671701459a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1165,17 +1165,25 @@ static void mtk_dp_get_calibration_data(struct mtk_dp *mtk_dp)
 	buf = (u32 *)nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(buf) || ((len / sizeof(u32)) != 4)) {
+	if (IS_ERR(buf)) {
 		dev_warn(dev, "Failed to read nvmem_cell_read\n");
-
-		if (!IS_ERR(buf))
-			kfree(buf);
-
 		goto use_default_val;
 	}
 
+	/* The cell length is in bytes. Convert it to be compatible with u32 buffer. */
+	len /= sizeof(u32);
+
 	for (i = 0; i < MTK_DP_CAL_MAX; i++) {
 		fmt = &mtk_dp->data->efuse_fmt[i];
+
+		if (fmt->idx >= len) {
+			dev_warn(mtk_dp->dev,
+				 "Out-of-bound efuse data access, fmt idx = %d, buf len = %zu\n",
+				 fmt->idx, len);
+			kfree(buf);
+			goto use_default_val;
+		}
+
 		cal_data[i] = (buf[fmt->idx] >> fmt->shift) & fmt->mask;
 
 		if (cal_data[i] < fmt->min_val || cal_data[i] > fmt->max_val) {
-- 
2.47.0.338.g60cca15819-goog


