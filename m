Return-Path: <linux-kernel+bounces-449401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78B9F4E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E652616FFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A821F8ADA;
	Tue, 17 Dec 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEhZB9r1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D501F8693
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447092; cv=none; b=u+9NIQVyfcdzOXfMV9sLbtbVWqYEH1Sm+JBta8yXEEARYOwYbPG17bfzz1yaKcKpxThgo2xCMKtP5QAHy6E2O4ekIQy7yeKXU3M9isW4yrSQTcSp2CfqUW34f7La29N9CdXUvOyxZLAUYjFGKqwSz6Z8A/lQdf8417DKFXGOelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447092; c=relaxed/simple;
	bh=HwDocDUkhgOfD1IlB5zGqmjPJaEeewUJn9MRE88hfiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lj3htnfHwi0hH+11Bfbsa99nmtI8XKjJEf30UuFlrRLxNGZcrWUUHGyDkyXK6Ark0i/Crx6W2oRWZum5deCAiSW22Q+m7u3lu3qJIAnJ7yq95MNpc7G5bRpo4Gkb0uAfSNkx069jZpMNGCum3RBS7Xat1bA7DOJnaBL2474dzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xEhZB9r1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436345cc17bso27625085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734447088; x=1735051888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=froNOEJ5fP4HPjSwjJSIEMf48laX07a0dnLFUTX+430=;
        b=xEhZB9r1wdpCeTnpomPpirHg1ZqQl4rxvYz0fEyTKN83Bntgi/90LdqPyEmiktf/T3
         MHBPHYGE+p76j67SlYXw3rrdR1HiKH9X57OVLmVNBBAY1QIXwagjY540RyCDyK6xD10k
         07SCT0ws2hlHOK/LseF6zShwmjRwucHc+8xcpv4j7xe0dHZkzSL/1ckNh+6ZfpLi4od9
         2y1kUQeZydSEDjtabtYpD9xwmUoJaMjs0xe6SDt+guxWTILfAuFYHMYh8N84g0/KRdUg
         86lNAebmNWXO6Zrb5bRJ7cYHdS9nRPZw6wE4NkxDBP7qR/W/nFMRAqU69YHEJ8hhbq6Q
         5wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734447088; x=1735051888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=froNOEJ5fP4HPjSwjJSIEMf48laX07a0dnLFUTX+430=;
        b=kXrKbIFPfojcAy+2gGSGZUqoVBaLTkk4edUp32UPUgX3aft4Fv0P24FsjnOf7kD045
         qlOFLfPWBnaR8ktAqI4tScJzozCH9WTqIkD9va1DMsYb3OMLAkxwXoLngWyxcKJCkGta
         jSkMuvCIln/vFBnpSU75hdwS1jQEXjTzdA1OCw6yeXMNKVVeMXTuI6jDdldCUKGaGXJJ
         0bJmOaX0R3VQ4oHS/C96w2UOAQUUQ6KErDMYqSTnutKXIRTM2FREVOCrpF1UczcFgEi7
         uAf3qWm0fKgDOoNjSY7qFjYGvay+rKLw8/W6BICrSxzCVrV6QasES9l6KPoQ1hqk4t0x
         X7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM3RCalJ5PMpr5RNAJUVbfYvhFe3TYWzHxt6CjSzENmVhj4wukFU+mttMJ0owkYpKGN+nSD7i/j6L+1jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8WHnNr2BiHxsdBe2jlvLCAkvtXFKMU4o00lsKO5lHsuFNVyv
	Itmi2w3RieRhMHH13XWezvk1KpqFodvv6cUb8eIT1WnHPfy1NPa56tTbc1xgBdw=
X-Gm-Gg: ASbGncvYGke8Ea7PQ/bQPDr9uSaPc1rpgxc3vvGZFWx+lwZJizdUdf5kAkqIfK7iks6
	szvbJUxrInB4FiwRbZEj9tQjKdhCu+FlwcU5lGJMFAWSlx7KHAYfQDczhS4f2sqJG4LvLGx9HE1
	CMMigasHEPUbyrBfoOdKDIwrh4qB7DUJEynGWm8mykT+S62EQucZ4uLuw3MWFSIkZijqMys2Tps
	8nNaXA6/DTOCq352yI0zromiA+/1QbAFyF8Pxze6qy4yTF43M9J21ykP0+V2WWCAx0YF4zhXw+h
	Og==
X-Google-Smtp-Source: AGHT+IE3dVFrS2lPHOBld+jhbNLM/KaCd2kFSGdOZmmMuYrxfdTmB2x698gYQPGsOdKqkO0ViNS+qw==
X-Received: by 2002:a05:600c:138d:b0:435:136:75f6 with SMTP id 5b1f17b1804b1-436475969ccmr39766125e9.0.1734447087774;
        Tue, 17 Dec 2024 06:51:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43636066f51sm118417375e9.22.2024.12.17.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:51:27 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Dec 2024 15:51:18 +0100
Subject: [PATCH v6 5/7] drm/msm: adreno: enable GMU bandwidth for A740 and
 A750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-topic-sm8x50-gpu-bw-vote-v6-5-1adaf97e7310@linaro.org>
References: <20241217-topic-sm8x50-gpu-bw-vote-v6-0-1adaf97e7310@linaro.org>
In-Reply-To: <20241217-topic-sm8x50-gpu-bw-vote-v6-0-1adaf97e7310@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HwDocDUkhgOfD1IlB5zGqmjPJaEeewUJn9MRE88hfiw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnYY/nYInfr5ilSEBZTNT2vb5iKlNQMAiVwhU2rxM+
 pVcYLluJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ2GP5wAKCRB33NvayMhJ0fhMD/
 4hgyzTGhrI/agedqwYfWa42TDdBvFrGXLuo6tlAup8DPYh3Jd6os2SnBAfx5l4gz3qJdpc4U/V9hD+
 pNCEtpun+rPukeP8L9zNvgQxEvCWLxnSKdDGgvY3YiLeQOWXT9t5BuGGPlOuo+FwYj1l8gL7dsE0rW
 qtTCql0QRQ2xb7K9sDBuifto/hQxmwTHZBCwTQzPUPgYu/cMpE5DIM0veZkxoSFEMAuIkXm1raz6OE
 RZq+bXu3LmtzKONFBCHKJhK/jwKyV7KzaMwCbrpjd1vFsuvXX0leQnNBXaTA01pGYj7i6wRNArJBJQ
 ydv9+BAOp3HwXOnNmB5caK/KWtlzCFJXhTWMvYIvTrZM1xBsVJ/ajiMCqaWRYDUWnY/YgzBpRJZfeE
 4txlhXv1PcC9wxSqrRYPhmqYXKu6YHrmnz+l/Lr7CXRjwU/0l1sUdNIomWmXsT59XuSnbVEL+2wSdn
 5FE0myD+ktpxN4WRYzxLbVeHxt4/uqImrB3V+CYIYfVPDmUZK+5V7PVGt+yDdmlHd0+wi+PybSRZ/S
 v3Mp5x2Na6S//QyJSM8+sf6FHeDcFrT9gqc4DMFu+Po8uAtB4ukrsgVebJFdObPQK9Gx+BL8iaJ3eY
 lf0yddo8DanZoSxCqvVALoM27n9yvY+PIbmbLLiZDIfYA0r4GBYhYy03u/bg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
is in place, declare the Bus Control Modules (BCMs) and the
corresponding parameters in the GPU info struct.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..edffb7737a97b268bb2986d557969e651988a344 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1388,6 +1388,17 @@ static const struct adreno_info a7xx_gpus[] = {
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.gmu_chipid = 0x7020100,
 			.gmu_cgc_mode = 0x00020202,
+			.bcms = (const struct a6xx_bcm[]) {
+				{ .name = "SH0", .buswidth = 16 },
+				{ .name = "MC0", .buswidth = 4 },
+				{
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(3),
+					.perfmode_bw = 16500000,
+				},
+				{ /* sentinel */ },
+			},
 		},
 		.address_space_size = SZ_16G,
 		.preempt_record_size = 4192 * SZ_1K,
@@ -1432,6 +1443,17 @@ static const struct adreno_info a7xx_gpus[] = {
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.gmu_chipid = 0x7090100,
 			.gmu_cgc_mode = 0x00020202,
+			.bcms = (const struct a6xx_bcm[]) {
+				{ .name = "SH0", .buswidth = 16 },
+				{ .name = "MC0", .buswidth = 4 },
+				{
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(2),
+					.perfmode_bw = 10687500,
+				},
+				{ /* sentinel */ },
+			},
 		},
 		.address_space_size = SZ_16G,
 		.preempt_record_size = 3572 * SZ_1K,

-- 
2.34.1


