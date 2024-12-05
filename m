Return-Path: <linux-kernel+bounces-433492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF089E5938
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F8D1885E93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADB8221477;
	Thu,  5 Dec 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6qWLzIl"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8F21D589
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410887; cv=none; b=kLEsF6Zmt5yjfkdbOTMMhkE3pHk4qlktnbcPvVO7ORoLQ3FSmn/1Z8a4OPM5Y9DuaEWGOXM8mL8BPrQoRt3bdY29vxvZmgiCt1cLlaLd5qiXBY+QJpAe0c2G3EgGEDgnWX2np+aubdwappIPjkb0Ka50F3jiCh425KDz+IDXXBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410887; c=relaxed/simple;
	bh=xjNH0ZqzPNeRyAGL1QAVeh9hZcwP2oOm7fBqheYEiRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2GNiMN6MoYgmn6A9lohf6+4pjTOpfcvVIes55MW0GQqenOoSbO5DCcei+U+k+C7QmYo/mZZucMjGVIOpSA6DiFdbZwShEtot90M67gCZdJsjtoI1dBkwJyRax6dKCcpjmSMVU0vrC+dGFMnJfrTJLxLvHlIYoZL9Nz5I4SNqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6qWLzIl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a10588f3so7074655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733410883; x=1734015683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVmiCOyrS2ecuSLMnmZgZ6KHsHdqqKLAjno5SAELDnw=;
        b=V6qWLzIldJNkGhPdS9/LZVUgCDLErzm2l+n6kdkiAR6HX3MILXsmwd9Hn5SdJSdd+B
         tOI4K2CFNbrolW3+M8simKsu6EdTzbmXSdFvMcl1E+44w9fmQwoU6sT6pwtI24EAJjBd
         R8TJWbZJiXR8vuiTR+ASta0mnDaB7o1M8WW//+9kbkIyfN8jUfzKf+v4gm9/yKzwwGxq
         CtlckjwzWYbWSbCj69k2drtR86Nbh5eU0mv2SV2sgAN2Lacb8hM0Afv3oDI97RcJW0nW
         OmAccun3qy228xowvUkoYpAuTNeW0m2AyUCHbF5QUtIPuW3CkTh21XcJUbrFiF9hL2o3
         9Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410883; x=1734015683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVmiCOyrS2ecuSLMnmZgZ6KHsHdqqKLAjno5SAELDnw=;
        b=aytpPFtosny3WRIMSx+yKy5iYkRitS9LpU/TvYBqeZJ8wm6gUuXCISc1DBtzCNmbwD
         TZ8hVZpSHEdc58uLTn+mzDWRuWJrjFFO49maTWWW7SNhSJ2rpqToVDyqufrRVpNVzvRR
         4depeXJfHy9EhsLNbXY+4kPGBm4GWyGd/VDTMUgwqtuEBCEXoh0FFVKQia06adhKwHYj
         cizXk9T/qAOXEnZkYNcdBCIq1mp6uADIFOxmNJz9FRgnvRq+/Y/B3rUAqmcL3lZUQWzB
         Tnr5tM3OvN6AfawJ8pX/rjD2p1dpJrAI2VMVX7Q4+WI2TPMqCS6U9lcG2LGPrmHufK5U
         APIw==
X-Forwarded-Encrypted: i=1; AJvYcCVsDAandEJL8mJj6i6qUpHFzp+mu8da9759qkWVh4r6lgZ1LDCfo2HCPEkEdcWpT5ccJFjdL7SxDZe3mxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64Fw69PrmfXByIsIA4iMrsy2uHwJF5+9qULAZENyQ4TGP24Bk
	VOPTEVjwNAeZ+QXlUbAca9zHwKS3f3XgVAZUQguudvZiM6UZ/cNXdpaqZyTFI3A=
X-Gm-Gg: ASbGnctJcCzwZCeBzGTEMwH19/o44uJoA/d1474XGtH9rbG+UH9cdTm8Awo2FCAQ+Os
	3BNdJlAR0m5IIg8Dd32ZlE/O4k0ztXlgiOC7JbhAjoaw1tdOulQcFk8iILfI3N+EljOwueNwJfC
	fH6+YF4+C9Dc35ILJm9hw+dZ9Gie7GJkDIu4NSmz8VKaUZdDEMKQUYhPb+qMFncMlVCSVThTZFW
	F7m+3l7R32ddEe5ZszbY3ANCzFH9BJ7mx7Fw9cI6/zoLuMvC1vgP8wQFKE3i8HD0ApEZt0=
X-Google-Smtp-Source: AGHT+IF+fI+rBDjJrU+kXFKlTf8czZ3q3nJgnXFs4n0YVqpgD8vtKzBieMa6idDq1qW4Q72VL2TB+g==
X-Received: by 2002:a05:600c:4ed0:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-434d3fae263mr79609215e9.18.1733410882347;
        Thu, 05 Dec 2024 07:01:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm62830795e9.35.2024.12.05.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:01:21 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 05 Dec 2024 16:01:09 +0100
Subject: [PATCH v4 5/7] drm/msm: adreno: enable GMU bandwidth for A740 and
 A750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-topic-sm8x50-gpu-bw-vote-v4-5-9650d15dd435@linaro.org>
References: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
In-Reply-To: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xjNH0ZqzPNeRyAGL1QAVeh9hZcwP2oOm7fBqheYEiRE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUcA5gbDK8obKvAzOZxReVLFxhmvbSIw3RBNwoTYb
 eBXV/3aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1HAOQAKCRB33NvayMhJ0eGJD/
 0Ynhh+/HQyy6sZPO3LnIuwJeGY8Y9+4S/9eTmNUJg8YyWb1a7x2k+zPRMNePAZ+vh7K3ZMgpUCv466
 phicYP82gtIjbUWAExMW6zvz8s4p2I8B9+Kz/HKP7yNmLRcvuv+RIPvQv0R7uG0bE8+iJzqTwJmZi+
 ihWfnRAWR14OlgLlIGBsdl6gm1yugEwVciJb/07uqykcCjWyC9Yz1m9S9D6F4QbTBoV9bhftD+Jlth
 PfMixhetpukrzlqJHJEo7HncfbRBErWSM5sE4ZbXsHwJ4BK1rXWvcv0sOJGcU5OB6cNywp07XQqiX+
 R3x+PIPZ8iHwM2VJ+u/4PjsXI0hO2ghoCId5VX99LkiPjsfHbjNw9p6toXfcbW8PwA+hjjE8rxtr8G
 pWlqAD/5pVobtJ12Wg1htaG8w9iN/ooTpKPnGuodATyDRsj4mOIvd5ku+ixCqpmY3hTLG4+Ca4Vh5B
 JvYQVXl/nlDZLraEQ5SJVg4JJv7uICi2XLJTgxDe6PGfpawpOWC8JWSq8UsTuL7BErY/ZYzzFqDGtf
 7Q8n3hQnvcTBuK8AjzaiaNO+IC/YodtKY5NczOnSpZb7V6V8lzcexDZJfDp/2nv4rFERjNFdvbwnDb
 B6cuycE0gxG5Cjltc2Sjljy7eaQATxwtbzJia0u9Ywx3tfSqdHl9q3kWPolg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
is in place, declare the Bus Control Modules (BCMs) and the
corresponding parameters in the GPU info struct.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


