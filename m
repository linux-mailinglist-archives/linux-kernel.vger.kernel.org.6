Return-Path: <linux-kernel+bounces-447000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C339F2BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4977A1CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4394201264;
	Mon, 16 Dec 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSzErFPa"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967F2010E5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337664; cv=none; b=dlsW+ZovDsDkZ7gSOKBBQxkADKNSv86uGcS035Ym+6Guv6f1XS3vDYCm6FHZA0wFmhOJm/D9KtU2OdIsNHlDF/4O+YdTboewDIyDSjwvQ54N0gv9A9WQx+XHgIMVxfibOt1trj+qZnIQwUMZY07oIVzym5jHTw1+nyTrlFXDRug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337664; c=relaxed/simple;
	bh=3vj4siDBQO7f315YdNktE17SvgKgBr413yqy0N6ohvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5kSIO3KrbgIZWtYiqYuutBJpjyT3d16Punf7d4l7PXpOxaDt/6UQHWCLTB2rL87Jj+Vltk87tzQcU9QRbnlTV/u/PFW1jddsFzbtz8oQeN5Y0/ApNWTnEfQN1m+fAWYG31gG6YM2oOBCUaEStCHtG9XR8NUlnliKRWFLFCHsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSzErFPa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3003e203acaso36298711fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337661; x=1734942461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNvaBXD6rf3EQuRmCg70rZ7MEJhSs632gKbKOrH7Zm8=;
        b=eSzErFPaUw8Bfvy3qmfczhU2zl3e1Wn51TVf3WTKNRMgVmHvjiRk4tVariinOCnNfq
         X4jSbqTDIl0YdY74IfgQ1yl1PwM00dnF5Lt5Gl3/XbIjSmT8L0GRohNYSOMeu476SVx6
         seMkSmz4WkGT3B/6qhEk+JOnkfZjsFltEkh4zxecXsNBvQQ/R1FM15SjNZ7rvr9nSbXX
         k475Q9e2KN1A0U6AZNCxOgXZO03IYtxMf9ApiM07QvKlVFCrFLsD/14MmVDoc3pW02ye
         4gP6KG0+8LmoWVy6c1T044XASVytt2CAV8WzXNjEYxtVzOsbXZMjuyNyqPSzQrfNlM9c
         F/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337661; x=1734942461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNvaBXD6rf3EQuRmCg70rZ7MEJhSs632gKbKOrH7Zm8=;
        b=ZuZZL5CqU/SWKji7fsiFfZ17W/W6J/s23Z4toS6uOKF32xO7Kac47Zy0Y5fpvEBFgt
         /uCz5p19xCAPnTvSVDd968NEjb0r8qiF7wN1LWpcNXNu9j2VC16qFr8eSN+ke2pkxf5t
         DvqOTaORUozjcH83YG2z19plTQrDUoPuDXc8oSPn3gm/ONTAO2Y/+RF3wF0y12Y4Q69m
         xa9FdMYBEVtNPvEuC2Y8Yp6hXPxZ/eHDQKKIrKhofAqKiAVqDNJ7/+PjOllZa38yroSM
         vuw984kGxkk3de9Oo0o6bLoA9ANHL6t4GZBmQMFHsPivpHQfbt1s51/FG+keCIEQnbAr
         RJRg==
X-Forwarded-Encrypted: i=1; AJvYcCVYAdfoixvPpeo25SqreXJnu7Apdu+BOyPapQq+RCKgxoxzqxIwtGi9D43iX1qza/w+ShbxyxK9wn0QhgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoopZBAqM2jMgtk8MY13/RoqYqLH7wlxincQNWKcDS3cIcnClq
	Bap6tHeN/fsky8c/kzcelvHiC2lE7KTdskpIoX+Dsy3nkSJIB3zxeVA2BIExXq8=
X-Gm-Gg: ASbGncv8bndHklT5byNtqJxb0tdGW7U1G2exSuaMlp1wmu2rmj6bM1gD2VPF/TVXR3u
	dXjuZh0LTLlH5WB72mEBSSYjdJYGoth5kR0zKyWkmBGbrmiHP4xu2RmCRmW+U74rQJHLfB47oq9
	aSj8C6hvx1olc2jbDBnJ9Wr4Q+mGZtND8nLpRgHaE5ztIGlqGdymQR8rls0Jee+w2QQHZZUz2Br
	A6CmL+iiDTtKdGTM4iWJpkxQJKlH/2AwgAdKieVz0VmccQXV+2JprX3koicJqmz
X-Google-Smtp-Source: AGHT+IFPKDhcXSU0UCTh/igp+MQWxIINBR6P0+8IXDlL++c5r9BUnSmEl0bO6pvB1WZJK4q3wU3VCQ==
X-Received: by 2002:a2e:9d8f:0:b0:302:264e:29dd with SMTP id 38308e7fff4ca-302544d37bamr35796821fa.24.1734337660711;
        Mon, 16 Dec 2024 00:27:40 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045342sm8543371fa.33.2024.12.16.00.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:27:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 10:27:27 +0200
Subject: [PATCH 6/8] drm/msm/dpu: link DSPP_2/_3 blocks on SM8650
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-dpu-fix-catalog-v1-6-15bf0807dba1@linaro.org>
References: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
In-Reply-To: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Richard Acayan <mailingradian@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3vj4siDBQO7f315YdNktE17SvgKgBr413yqy0N6ohvc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX+RsvFTxBZ9VJCMmml3J0WOzPS0ojzqlE8FEK
 RhPWnm5aU2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1/kbAAKCRCLPIo+Aiko
 1QSpB/0RNWf+SOymu2pMymtdPsFsrkyWTVAOo8hqG3wKYgwYnA+cLkN1U3hjojOStIB0O5rx1Ub
 AA6ze5HSaUFrTXAqcbWPuo2MoyojkWNGiTi/E5RTl9aht/VafStHh3jWX2+FqW66sCl9cB6ZJy6
 XoroA0Iw6HouEimgf9nUHuN585Y9Yz4lfv/4ahiOdTXkIvhu2hQsFVu6D/HLu6h7X7RdbNro/wx
 g/sXvGBKaCoTITVZCQw/QPgldCKJbUKocpTNVwgHovUmo7e1vddHIGMqk8HPmvJ35cmEMs7gMA+
 fPoL5pkcF8tX1j+aT7DohRZCLMNyHKiJj0lbiQRxRH/B5pqB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Link DSPP_2 to the LM_2 and DSPP_3 to the LM_3 mixer blocks.

Fixes: b94747f7d8c7 ("drm/msm/dpu: add support for SM8650 DPU")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
index eb5dfff2ec4f48d793f9d83aafed592d0947f04b..e187e7b1cef1677261a5de7b01ea3fa8136723ac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
@@ -160,6 +160,7 @@ static const struct dpu_lm_cfg sm8650_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x400,
@@ -167,6 +168,7 @@ static const struct dpu_lm_cfg sm8650_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x400,

-- 
2.39.5


