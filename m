Return-Path: <linux-kernel+bounces-400834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB99C1305
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EB128429F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4271BD9EE;
	Fri,  8 Nov 2024 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJ9G7SV9"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D821FDD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025305; cv=none; b=uLJsnYFJjmA+2hnuG+I6E3tGuKkTzQRZPGD5PK03ESZ7vPnzFFSa7Amw17Uuun5gjLmUevJmEsWXCePqoVtDPEcetvzO9pzsHOA5EGcFR4H2e8z8oSu68BVgI6DYLt/4y94OgLHui4L9j+fD2WuuB5NJGmEKV/c8Sh5hR2CGxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025305; c=relaxed/simple;
	bh=abn+V/VW2R04+ivG5L+16aCpi+lS1tSzUvuSfrCga00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6z96WShU9Xm6jRsw2ku9Sw3Q+xIdAifytYcIGKneTj6eQj5kq3zndHFZkoblPLK5GNQFj7BVE3h9gfDi7RVDusEAQD/PZqOLCerRImelMxk3pQ3vWCUuYsXeU7tcvA9JA+YyVxLnt6J06VcJj1fQu5nbUl79YN7dZi1GMZcD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JJ9G7SV9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso23387311fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731025302; x=1731630102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY822JqISKSBvZvj0s20BCeD1NcNyIjNyABXPzWHxOc=;
        b=JJ9G7SV990NJxjx0lxK6m2Lacoau/XDcAeTDN/WvO2o8ysJwv22aGkUOcsJ4a0tjl5
         uzV3Mc+9qcS22a3iFMxYQSZRynPs9XuEqP3gpx1ElHjygVpVsijKA3d3g1/3RCEwvnpk
         XYYWCah7H4NEspXG+2XDy0yIZ5lS7WSwa0FydPnbVyS5RxPJTb9ma/Yfprdizc2bGm7y
         0TfDYnTFQ7KF6KdxIKM+tP7BStRbOa+6VOFOQEUgAmAh0AJTbPySUizz/CnNsdBwNhwT
         LyYcscVKT+0V7xENC21r5oYnmSgyQquaCWTM2ct7CNQZnDx/PXP5lFHE7oeWn7QknP6K
         ONfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025302; x=1731630102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY822JqISKSBvZvj0s20BCeD1NcNyIjNyABXPzWHxOc=;
        b=CWPOhEfJ9R7IoxnuUFz3Hr7sh93jONir74CVhxrMP6BlUf2zBQe2q0Efh68Ginq32s
         dpo6vlzO/SwxThnVGGLUwpdZsEXe5tDH0E7hy7wxdHlCOweQVnmrEcjmKf7jBS0ZYzoO
         8PWjTSkA1t2K/SDnaBjFzr1BQTc6+FtdAFc6wqKxJyBoiwNEwuQkAAopzguA8AXtezZX
         fpbUQv75s4m21fL0mqz2Zg55YaztJ3nmb90p77SVJreAuFWsg9FfX/Ue+JDHFrxv/tAN
         yvbLhT15GwhWCc5vytROtlMADMw9ousRBw3vuyvUC6oPTZGhMT/P+Zm4wYflPD2k7BTh
         tUOA==
X-Forwarded-Encrypted: i=1; AJvYcCUoatgb3LzV+rw5hxNSGbbaIJcLHXrAgWrgZirQKO+LEbc7zWzfx/uKHWzVEEsVsOMy5EQM+BO2IyumTIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg23eMPpDySQkxMo8krTVm4k4U5wIHZYV+qImFvil0ieWlL8op
	p9qzyf6SPu60iFwMNFiCm7BhHiXaU6Xl6+nT30x8qAPXDzsob2KvuyBwx7i8QYM=
X-Google-Smtp-Source: AGHT+IEq6ivfN+wJwzSVr2+2EsfSbjnKIpmoB5DdUoek2Tpc2v2YqRfcEYVZeYyjXtOgbLpQYY7sVQ==
X-Received: by 2002:a2e:a803:0:b0:2f7:6653:8053 with SMTP id 38308e7fff4ca-2ff201c7cc0mr7133511fa.18.1731025302111;
        Thu, 07 Nov 2024 16:21:42 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17900a63sm4195191fa.47.2024.11.07.16.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:21:40 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 08 Nov 2024 02:21:32 +0200
Subject: [PATCH 01/14] drm/msm/dp: fix msm_dp_utils_pack_sdp_header
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-fd-dp-audio-fixup-v1-1-40c8eeb60cf5@linaro.org>
References: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
In-Reply-To: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2535;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=abn+V/VW2R04+ivG5L+16aCpi+lS1tSzUvuSfrCga00=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnLVmOlTL82Q+yU+jTYQJ2nDrxLnq8YKm4nBQrW
 XWQ3vKXdO6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy1ZjgAKCRCLPIo+Aiko
 1aVAB/wMp1GUIzKR0e0Z7EmL6OhYO8pzNKgXmJzLpBJHGsb3lAkcVB8stTyd7yx4NyeObcSp0dN
 FEXTHPvI4cEqqpzxMjTMzvERHuhHalCM/N4bmNMEg9aBigDEDFFeyVoIOgrOVrYPe1PsFL6ibG7
 BxcCRw1Xe4T0Dzdcj5708UB0Ejd54RFOjX7lfeC+JAryOMN05sG3b+S2NJsOHi4fq/Dhk6HGu5T
 wLyg+ob9chEYbWjZvDgaixAMyFsah9l5WnBj4IFCcWOlbJ1H9d3cTnpnv+W7PG7VxzJFk3b+kNn
 tUJRuMx5kL6Wa/PvEsa2clV8XVeqacZ/osSRe8CjnyW1wkLD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The msm_dp_utils_pack_sdp_header() accepts an unlimited-size u32 pointer
for the header output, while it expects a two-element array. It performs
a sizeof check which is always true on 64-bit platforms (since
sizeof(u32*) is 8) and is always falce on 32-bit platforms. It returns
an error code which nobody actually checks.

Fix the function interface to accept u32[2] and return void, skipping
all the checks.

Fixes: 55fb8ffc1802 ("drm/msm/dp: add VSC SDP support for YUV420 over DP")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_utils.c | 10 +---------
 drivers/gpu/drm/msm/dp/dp_utils.h |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/dp_utils.c
index 2a40f07fe2d5e20114a7692d1269bb8fd5bddbbd..4a5ebb0c33b85e3d55eb974d74c1f54591301b35 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.c
+++ b/drivers/gpu/drm/msm/dp/dp_utils.c
@@ -74,14 +74,8 @@ u8 msm_dp_utils_calculate_parity(u32 data)
 	return parity_byte;
 }
 
-ssize_t msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 *header_buff)
+void msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 header_buff[2])
 {
-	size_t length;
-
-	length = sizeof(header_buff);
-	if (length < DP_SDP_HEADER_SIZE)
-		return -ENOSPC;
-
 	header_buff[0] = FIELD_PREP(HEADER_0_MASK, sdp_header->HB0) |
 		FIELD_PREP(PARITY_0_MASK, msm_dp_utils_calculate_parity(sdp_header->HB0)) |
 		FIELD_PREP(HEADER_1_MASK, sdp_header->HB1) |
@@ -91,6 +85,4 @@ ssize_t msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 *head
 		FIELD_PREP(PARITY_2_MASK, msm_dp_utils_calculate_parity(sdp_header->HB2)) |
 		FIELD_PREP(HEADER_3_MASK, sdp_header->HB3) |
 		FIELD_PREP(PARITY_3_MASK, msm_dp_utils_calculate_parity(sdp_header->HB3));
-
-	return length;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_utils.h b/drivers/gpu/drm/msm/dp/dp_utils.h
index 88d53157f5b59e352a29075e4e8deb044a6de3bd..2e4f98a863c4cb971e621ac24b8b58f035236e73 100644
--- a/drivers/gpu/drm/msm/dp/dp_utils.h
+++ b/drivers/gpu/drm/msm/dp/dp_utils.h
@@ -31,6 +31,6 @@
 u8 msm_dp_utils_get_g0_value(u8 data);
 u8 msm_dp_utils_get_g1_value(u8 data);
 u8 msm_dp_utils_calculate_parity(u32 data);
-ssize_t msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 *header_buff);
+void msm_dp_utils_pack_sdp_header(struct dp_sdp_header *sdp_header, u32 header_buff[2]);
 
 #endif /* _DP_UTILS_H_ */

-- 
2.39.5


