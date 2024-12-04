Return-Path: <linux-kernel+bounces-430583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E45A9E3333
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D282859DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1A6183CD6;
	Wed,  4 Dec 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdCMSw8j"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF32F22
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733290610; cv=none; b=KqarEcy9CZauTQk1HPjqAuJU2L11sOYKjTvJuQESGOkmNcUqsG7CBzGRrkbHUuJEW3ui+JgC2MkeNm4DW7LGv7dkiJIXiwvOXpTQEMqdXRrJirhDSl4F9PGzQPsQxyE3hJToNsKgHQSGhApTPfS200jsLOmFni8LItLvj/8JjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733290610; c=relaxed/simple;
	bh=cd99z2J96zN9LBlWdk5Edq8rr2/3EG0lw/wpVt1180I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxcQZHSXm6da8LhvSA6e7OtZ8tafLiJ3zMd1aiCSDGhDU89RpeFq2fPQVfb+Bx2G9kf3/gHzb4WFO1tfyVLLu6HfZ0j3hpj2UPuWAdUONi5QjBkA1ZWhgeabCECzFYZkS9RJKtrbqvHLHWGQrEKMTa9Fhh4iNtWt+N3ykipiJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GdCMSw8j; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215d92702feso2862855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 21:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733290608; x=1733895408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUTj5oOCJlKe/qGpHEm0TOrt8PkT5YpNK1Ubf0EJxrk=;
        b=GdCMSw8jzW8vGSYIegc5JTtE/LOA7DEI0emNOPKmo1cxK5hi04Ybw0BRc+PakDu8Hz
         sQWtcMmI/AEW3KIptllOZeNSiU5PSUrmZy+F6ytcBVBA/gFlZyF6ScHMfmi2xwmDVnF7
         qN2yXnQGf0ar6q7+nL35StdUxY+2tS+q9ZukU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733290608; x=1733895408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUTj5oOCJlKe/qGpHEm0TOrt8PkT5YpNK1Ubf0EJxrk=;
        b=mrd9YrSn+1pOKvMdyYteE5dI0prYKikFmwN3WZgqT/QT658u2fFG9cG1zyJDYPEacv
         iDV67DAULwnCKKgm9zhOpNr2sGjEMdYmknCKFMkQ3pjHhQQNe8dJlK7ZCKrdjp7XfB5A
         mVXy8Fw6fs0eRJWOcxayHnuM0hAhjh26LJUfPaK6fjjzCx+Iur7e2Wh6SiJVxmr6HSyJ
         /jx4km4EMLFIEFb1FijNK5WV7aJ7PrcOguiBuaNStnBuZ/Fkhsew2mQxAGp0wtrM0ghW
         HhTtWKcG4hby6EBk4rfKY3W3JIld7AUKbf0ebnCFU+sCCI9wdXshW3bIPXX1dQ94pVI7
         u8rw==
X-Forwarded-Encrypted: i=1; AJvYcCXiEogNNP84XZ+iAHtNL+L3q41cxKkvlAL7tnIiGV3Q4iEGhKGpKRRqEAESyQmQ8vA/hvK7j6u45eqWNJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1e5lnWScdELEta6PkIHVMjnibNMfyyN55inD/2LaZtLgb7TX
	z54iij8QCyTXGjjFsbAxtCzmL/BYtmmI6wKTFAn+L5seug+ytfRBqZD4nWthPQ==
X-Gm-Gg: ASbGncsxY0Fgv8APRSmU/8K1FUFwFEhm3tIdou3ogFEDPqR1/6t7ehIc6O/uAnao3/a
	LbSHDz349RcOP0apLcKFANIQB3tuz0c42u88y3bMNFEjNMHqMnb0SW6M2Hq7lDVSsAPmV2Du6J5
	C9vVzpGgLt8bxO7vLS+BYddh3jMm6H+C+kvxSaRq64LTtzj2BnexUuleagfri+00hiBKipDVo0S
	GsdgpgR5xX74W6DkXR5mTX/8EEOH3OBIuclu9onaPwSsRB8NYzKTt5BHx/DHz2KIjk=
X-Google-Smtp-Source: AGHT+IHCZpXeN9MLrmdZcAAHOnTGeoLcKfIjSMDNfOqrrypRTuT3gt40Zogb0oCb0B1u/35wvFZQbA==
X-Received: by 2002:a17:903:4094:b0:215:bc30:c961 with SMTP id d9443c01a7336-215bd161bbemr52091865ad.35.1733290608504;
        Tue, 03 Dec 2024 21:36:48 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:b764:8a78:a02:6e0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219672d1sm104304235ad.164.2024.12.03.21.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:36:47 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: dp: Support flexible length of DP calibration data
Date: Wed,  4 Dec 2024 13:32:33 +0800
Message-ID: <20241204053634.1365491-1-fshao@chromium.org>
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

There is no guarantee that the data is always a 4-length u32 buffer.
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

 drivers/gpu/drm/mediatek/mtk_dp.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 1cc916b16471..e9ff6fdfd6ee 100644
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
+				 "Out-of-bound efuse data access, fmt idx = %d, buf len = %lu\n",
+				 fmt->idx, len);
+			kfree(buf);
+			goto use_default_val;
+		}
+
 		cal_data[i] = (buf[fmt->idx] >> fmt->shift) & fmt->mask;
 
 		if (cal_data[i] < fmt->min_val || cal_data[i] > fmt->max_val) {
-- 
2.47.0.338.g60cca15819-goog


