Return-Path: <linux-kernel+bounces-510270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE8A31A89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3780D3A6E32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E37679FD;
	Wed, 12 Feb 2025 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KaFcib7l"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC60271807
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320514; cv=none; b=XKWdVqDf3zYje5xFpJUAxNz9fwuBPnd22htWLmRTQhWpooqM3DP3ntjgE8oWp1r3oMb8a96rq4yx31Lt06ZsB0DXJecvavogNe7jztqX7XqX4LgzgT0b0HbGxLY8K4nj3jFYwaECg1itc9X1fj6WuQw5ozKQXQuhgAxjJvPZbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320514; c=relaxed/simple;
	bh=/zoYSnZhploCCxHOu5+795pfizcOWqSCa+DKwvVdtE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=laBJtT6laz/K5w171cZIAJWORhlf9MiVetsnWe9t1VdtDfI5xOH8g3zoVON6w/YXc9Wh1tahEBtcuuqqGrQTkEyrWQDxMzy+V3v3oXTc+9sc5ZlOR5EeAQcKdF2AQuzi6WLDqbeSX4Qf3gvJOCMtinQYrUj+64LlOwSEznJ3Lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KaFcib7l; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso474495a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739320512; x=1739925312; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZNbqOyLMkR4zYGETdYI1Ds8jvtDMMy7KcjMP1dhBIk=;
        b=KaFcib7l3JP1dFKeUUGOXPV0NZQML1/16GFWQin+WN7dR/afG92y4BIzoXFC8L1M03
         D+jLpEqcnN6AZQLgO7kUzWeS5Oxi4FJ5V6QF+qXZgrERUcZNQ88BpLNz05I8DH2RHfi6
         5BSw5ffKEipoJHoEsBNLig+p8FncEsIXGQv+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739320512; x=1739925312;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZNbqOyLMkR4zYGETdYI1Ds8jvtDMMy7KcjMP1dhBIk=;
        b=Q5h2+JSCtsZyPiviG5OZNo2BJon/rDa6ZBAGZ7AYq43gxJoFgZ80jvtsXctCZthsEA
         6VeNHYFvvb+SHciQzTvh43XKaZPU9BhHqtee6vxTwJRng95MiyHOLgcp8Mu2V7Y7JVLs
         +/d3/82Oyl2I/4Y1KtpiYFwZkoKIlDcHfeCrsZhn1Utvi0iFxsCP49aaRVJ0Oa4Cpyba
         K4n8J/gzZq1hxWD0KB7dEpB+ej4T5XCGxlGRCmhC1wLx1tHcqBssKlJWnvkjWPQ5AXQB
         zUVOdmnsLERQEXpqyWtHUhbOSmhr9ZtI1Zf2GBXWWLBlWU3VKRWsYHzcZoJTu4YNFqLd
         eZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQH81Ot9/w0Xj9GcpbfjEXpOvlAqqIr6BfaTBNn8oApE23MXts6yialR7exoIjoJiPnhVe1spCNLUdNpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDdW1Dz/paizxz6bBOACCzmcYrWa8f6hDFGVSUxjrQ5ARenv5
	DWA4SfWE/3NgOs25Iuag2XnY/BiQP75XTgu8hdVhQaSDuKrp1yd05dCtN508Yw==
X-Gm-Gg: ASbGncvPUA2dWN2SShD9tZwtqnjnN6Ds/GDK8yq4Dhry2Ct/3xUvFwXZQJw1xaEhdVJ
	NT0DoyTettRY7qgcw87LqMlGjmn2QgXnnseFZytHnavkLPPZIcBQBhKr2CScnT80AUJab1UAcEl
	UjvIgH3ZiK/bFE9SDREQsXHECYqRcSo5Cj/GfzgKoHyJiv+jWUczXYyOjZKmIrZsWknKlUrSrQM
	bZomaTvnPVZL9ik5C13bRmsE2dCdc0Gfg9nlnudlSczF4X9UwCsR/KXqI2oe9TW4kAcbggksAh/
	zc38rNzoK+gCXDqErcwMFTZXTJNtixO2ihRkCtwBWy4t96nKeoKaU3vRQ86cbVv2/PdeIm51
X-Google-Smtp-Source: AGHT+IGU2vBf6I17uMlZ6vPzIppLSPDMm3Mc2t33rkKE8ywv2pPmz0SDcC2eFj6qRDS96L9Z49Rppg==
X-Received: by 2002:a17:90b:510a:b0:2fa:2c61:3e5a with SMTP id 98e67ed59e1d1-2faa0913af0mr8652088a91.10.1739320512530;
        Tue, 11 Feb 2025 16:35:12 -0800 (PST)
Received: from nhebert9.pdx.corp.google.com ([2a00:79e0:2e13:6:34c2:323:b5a8:3074])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b639sm165958a91.38.2025.02.11.16.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:35:12 -0800 (PST)
From: Nathan Hebert <nhebert@chromium.org>
Date: Tue, 11 Feb 2025 16:34:51 -0800
Subject: [PATCH] media: mediatek: vcodec: Enable HEVC main still picture
 decode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-enable_hevc_still_picture-v1-1-0c06c0c9add2@chromium.org>
X-B4-Tracking: v=1; b=H4sIAKrsq2cC/x3MWwqDMBBG4a3IPDeQjHihWxEJJv7qQEglsVIQ9
 27o4/dwzkUZSZDpXV2UcEqWTywwr4r8NsUVSuZiYs2NZmMU4uQC7IbT23xICHYXf3wTFLeubuB
 0z52m0u8Ji/z+72G87wcNGPdLawAAAA==
To: Yunfei Dong <yunfei.dong@mediatek.com>, 
 Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Nathan Hebert <nhebert@chromium.org>
X-Mailer: b4 0.13.0

Mediatek devices that support HEVC also support the main still picture
profile, but today, the main still picture profile is excluded.

This removes the skip mask for HEVC, and enables the main still
picture profile decoding.

Signed-off-by: Nathan Hebert <nhebert@chromium.org>
---
On Mediatek devices that support HEVC decoding, HEVC Main Still Picture
profile is also supported by the SOC and firmware. However, this
capability is turned off in the vcodec driver.

This removes the code that disables HEVC Main Still Picture profile
decoding. Validation of the decoder has been done via V4L2-backed
Android CTS tests on an MT8196 device.
---
 .../media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c   | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index afa224da0f41..d873159b9b30 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -152,8 +152,6 @@ static const struct mtk_stateless_control mtk_stateless_controls[] = {
 			.id = V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
 			.def = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
 			.max = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
-			.menu_skip_mask =
-				BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE),
 		},
 		.codec_type = V4L2_PIX_FMT_HEVC_SLICE,
 	},

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250211-enable_hevc_still_picture-26b35eb08270

Best regards,
-- 
Nathan Hebert <nhebert@chromium.org>


