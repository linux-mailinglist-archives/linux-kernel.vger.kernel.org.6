Return-Path: <linux-kernel+bounces-203155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E618FD741
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A78C1C22916
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A415885C;
	Wed,  5 Jun 2024 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fek29ZGz"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0015D5DB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618234; cv=none; b=cFnjsxH5VYE8tNkr5pzk6sdkpc2IJC00/3VZgqQSk/SjWlLyAzSVaq8lL8Wx4hw8WeOUi6NMdT2QfP/3wjZvZ0nvXq2lLDP2FnQ85xmGmQqNk4oalFu6abxNK8XB2lEzh2BR0HRf7Gy6zglgtn9SbGEyfsckPOit+KdScICjYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618234; c=relaxed/simple;
	bh=yp94P6EXcUfh6tf1gijxaCCHni62kacsqABiqdfOJMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsqcYrAWLHIfm2mOuQpHXHHM+/0W71tevOo7xQQkjkMNA3g8njLmRjv5W8dxCw7kK1qxEM/GdCWfQNX/0e7KyRXKPSwOZA2ctk4Jp7UMwN/iXwfhheAWM0dUIwjS/5xwtzYDW3ka/2i4eeS9aMwxNN3LxSA2GWqu6+F1kplo6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fek29ZGz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b90038cf7so475026e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717618230; x=1718223030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAbdSxwRmKncrPynMCBXXpukCSmqzvxbpgxPB115kMQ=;
        b=fek29ZGzRxqhin3CvqlxME5VcgNP4YY4PvjYszlQLmH8wgf46EzdbSEh0HVt8nuqLt
         p7VXG2G/hNslirl0x00NtDQgCuyzrF2g21cj831aDjVTy3MrKDZemLORjrIzwegatRYK
         8VyIv4sHhPc0u0w2VkTw9hmBuiv7hXnknyK9ufUXQwrLyT6UigTyG6T8TxDEiNIZ1Nyp
         Udu4isNCvZJsCoTZRoLOrkhyvxpPE+ViRsgnpisRLRPgSRZsdJ1wmDQWbhAn0O2UdqoK
         xWHxBEjAEdYcLZBJP6Pzfbop+0ZajdLi/kawTJ5vQjeQZ5Ppu0SvUoLbeRRctq8ILOsM
         aDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717618230; x=1718223030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAbdSxwRmKncrPynMCBXXpukCSmqzvxbpgxPB115kMQ=;
        b=RZ/Gj8nnV9NMCZ5uhGfNKas3AnTWMf0P1papp5KIBzkJZ0k2mLERt+2oKQHb0I+qcz
         a8uc6p0Ac+CP5T0RtceOn7MHHdA5t/h7x8Kar3JVHLeyvy2TZ8avfoySgydif6ytZpxd
         MMNT5n+GDOuPxxDz7qwRX3bnDEVQKfXkn4UMn9JqCrIehaYdSdkc7q5GFNwolNvd73Q5
         FAwaNnIPohKST57l1zfMJBvhBzSgAG9dlM6/MAEShTnAgTJVyyPgz7MXzBOYFBZwCTMc
         GK+zM6+hPBRXtB7UfCx2LKzBy9JTFkYkesWWbYLI/4EOMbZPqmPh2qIhdAc2BPLoD/MR
         p+sg==
X-Forwarded-Encrypted: i=1; AJvYcCWCv36OeTV5rOP90e9LBQeEvPYsfGrGAnKw2SmmHXvvB52u3byTA+3MTdBeuFT6hO7Ff/3r/ayqkuBpdEITAcjV94GBi6GTshh3uiXa
X-Gm-Message-State: AOJu0YzFI1QGGm6GLqN51q7XO4WUk0T38D+mLnDQ0Tf2xLUKWJThJHLS
	ehNCFAT3PhexeXkq/cehKEtuxzHRWKkJdNQB/Rfvm33pf5BEI/EofjxwF/YxI0A=
X-Google-Smtp-Source: AGHT+IGmE9OokaTql4LLWxH8WUk7Bm6os+aJLAvG1X8lHm2C2s5wY34QXKPicExRZInMxGNV/wgPkA==
X-Received: by 2002:ac2:5322:0:b0:522:80d:5dc5 with SMTP id 2adb3069b0e04-52bab4bd036mr2102755e87.27.1717618230691;
        Wed, 05 Jun 2024 13:10:30 -0700 (PDT)
Received: from [127.0.1.1] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31be4e36sm9717473a12.53.2024.06.05.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:10:30 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 05 Jun 2024 22:10:18 +0200
Subject: [PATCH v2 5/7] drm/msm/adreno: Define A530 speed bins explicitly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-topic-smem_speedbin-v2-5-8989d7e3d176@linaro.org>
References: <20240605-topic-smem_speedbin-v2-0-8989d7e3d176@linaro.org>
In-Reply-To: <20240605-topic-smem_speedbin-v2-0-8989d7e3d176@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

In preparation for commonizing the speedbin handling code.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index e00eef8099ae..66f7868ff476 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -258,6 +258,12 @@ static const struct adreno_info gpulist[] = {
 			ADRENO_QUIRK_FAULT_DETECT_MASK,
 		.init = a5xx_gpu_init,
 		.zapfw = "a530_zap.mdt",
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0, 0 },
+			{ 1, 1 },
+			{ 2, 2 },
+			{ 3, 3 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x05040001),
 		.family = ADRENO_5XX,

-- 
2.43.0


