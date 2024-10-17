Return-Path: <linux-kernel+bounces-370351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2169A2B70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529BB1C258CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD3D1E00AA;
	Thu, 17 Oct 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZE2ZVD21"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553B1DFDA4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187569; cv=none; b=Un+SxpMkby8d6eR5Dc+haOYoIWLPS6z92/5FFNPiCmQM+6KsgxHAW+p11ePlrOgmhRsB2w/7z/lawIooOtsOQVBMX67qS6RGdof4svkMBOXVpNCISJoB5RuB++BxhrHehUAqv++7h5NUIPtSRQcmdKipAA1m336UojBkBnMBHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187569; c=relaxed/simple;
	bh=E6sSET5NTanEf8su5V13W3kLbMh4cgFTxZO6VeLZC/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1254NPFxYK2XX2fjPM2KyfvQUR6g0JvTEDQ+CD2PuQSzhejouP0Xo0mJNSWEdb79YIC1oD14M4ya2QfFKK5zjmI7FqWPM3lCE4qNoN68mxjrIe8t044IOERs+OnZ6ce7m8TdNCV/wNWY8WpFUtLb3YWWpnev2VTG1/KbrMmNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZE2ZVD21; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so1544263e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729187565; x=1729792365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGopXLJTzCLfhqUsTpJkqnxqFQeGkxJFucKx0VxQEO4=;
        b=ZE2ZVD21dWI6T2bK0f2+G2oa03al2DvKIw4Lx1fIJjnpUf/wUCCgGL+yZdufrKVd5U
         oBTOtFehedBX2hNwJiEA5d/RreDC/HabH6y5IIpdyrfgJUAQAwU5/kqJhxMUVNl6bZ2q
         C20AheVX1JOZNYWYYmvAitL1crhszGqxy8/+6oqMwXLf/VPXalR07WRpxZMkTak99hFU
         EAYlyNCjaglBUnHM3JnZBhBRwKavwpBG15gxzovyCPel3aF0qGlKhr8uq0TIknxRKlfU
         nCdh5l/tA2ILJ1XEOY8SHzJYo/vNRYAPxhJILJdjcy0iU+J1cKY+RqAgrTFsb/MsGyL7
         lF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187565; x=1729792365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGopXLJTzCLfhqUsTpJkqnxqFQeGkxJFucKx0VxQEO4=;
        b=MG1sK/PX2DKdHcQh+ONQwOliqZqqD3sff9FRQYSN1fuY9d6e+L6cv8dIeR5qstzUaT
         6a+BA3f8Trj/u9IO/s3m7uVsRIidENPFbUUJUVtfTg8MamI9ZeU8EnZf+KzcTIU/f95H
         YewMIrSgnGWF8G9gY5JGUfdEJpcOWEG0UfIoIkrOZju/YEa+i8kDF+hj3Z0V+7G6SG04
         lD+NLy9zd6MO+k/8+Ui3Yq28Do9oNq3FXaBxiO7usP9gMEsTgQIRrvI9QnssuWLXs6UU
         tS8bz5iNZu6ygQlvuEonjzKTOZba1g+fXjcfL3pxoQ+lfIIev2COuhezTeq3h8pU2VHW
         H+6A==
X-Forwarded-Encrypted: i=1; AJvYcCUNq5k7TumY/IVLAaNZlI/YlRJYJrmhwXiIdPkM43WkCa7c5ahWsfDSI3KrZN7d+0qYS5RsMSG6zZSPIvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dcY11FgVseC3Hume/brkeAVC8OlOc4IsjPsFkQpbMdU3gpE/
	Vbxjy50Fb6XnTFQRwuKNcXKX2QRxjdS/WQJy7H8HDqIOUIAU8Bebe03LQbsfcTEIbDi+fkj35Lk
	W/8E=
X-Google-Smtp-Source: AGHT+IH6+buk6yaAI9YJVrIAMsjfJtRGGoRZPI/6YbiUBaiUNOpD2lVTXPHL+siqaaTkG8jrqrmyAg==
X-Received: by 2002:a05:6512:3d17:b0:539:948a:aadb with SMTP id 2adb3069b0e04-53a03f81a5emr6415982e87.42.1729187565363;
        Thu, 17 Oct 2024 10:52:45 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00013f8bsm829557e87.286.2024.10.17.10.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:52:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 20:52:36 +0300
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: add support for SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-rpmhpd-v1-2-f4bf7f6fd12e@linaro.org>
References: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
In-Reply-To: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=E6sSET5NTanEf8su5V13W3kLbMh4cgFTxZO6VeLZC/s=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEU7oMWrzR66N2bIKoRCxtF+Wfk3UJKHC+yMm0
 Nf2dyxqYqSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFO6AAKCRAU23LtvoBl
 uOjvD/kBIY5uaOVx3oJnoec9/FanLeD3f5mDWUw1vZHIEhA/irTrfLYtoxNeUzw/zJV+oEALKV5
 NFVRSEUPLRGZwa5Fqjay1oiroZOLhOzUpeTaioGv6iU3WdYUHcNxVlFzXYY/cMr7cb90M26TD26
 fX1+/O/AwTRPCwfxyc/iwSFkz9Bajev4EXTwloe0eeVx+8CUlDuTg3HONFAIawH+QmvLWj5he42
 yiXWzB/4c1OPUVneGX/JBOGxl6f6B9RoVPI1wZvU3FX4R1ZMzn3k57ofITH5iQ0b4g8SrzokKXl
 uN2OMUTZkZFJorxCMk0S9FSu610TCxD0nKQOMTm8QvwQn7M7EIgxZ4bHNnEbX1ru7kKSpef5wop
 hpEJwe7C+vgH7yliVtK4jgCxwFcm71oaZtn49t/K6cq8JOr2+g7R7rSz6fZOJv7220fUXx60Kvq
 S+0tUnjXV1YoFOa+LQq2Yo8MnAn1/vTXZXJ+Rg37LL2Ovi8Qubj28m4WTuOzxttdIn+GoxKpQIC
 PQQELMoWowEaAf65JHb6dqW8tX/vIodP9Rzrk6ftV1lpDan9QWmv2QiHqcMxwnwxjP0/m8DKOxC
 2CnP7hJ5G7a1DEmG/IjFfMdAQPzz3h/Mh1b6GYxdk5YUsMQigp1GUGh0cxTb2YXBaepmtzq9R6E
 p+CmCqzR+k/o+RQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Define power domains as supported by the RPMh on the SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pmdomain/qcom/rpmhpd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 731feab9f17ddae699815332d193e9a298fff0e1..5c5f9542c3925045cc90872e81cae3e6c2936212 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -259,6 +259,30 @@ static const struct rpmhpd_desc sa8775p_desc = {
 	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
 };
 
+/* SAR2130P RPMH powerdomains */
+static struct rpmhpd *sar2130p_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_QPHY] = &qphy,
+};
+
+static const struct rpmhpd_desc sar2130p_desc = {
+	.rpmhpds = sar2130p_rpmhpds,
+	.num_pds = ARRAY_SIZE(sar2130p_rpmhpds),
+};
+
 /* SDM670 RPMH powerdomains */
 static struct rpmhpd *sdm670_rpmhpds[] = {
 	[SDM670_CX] = &cx_w_mx_parent,
@@ -665,6 +689,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
 	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
 	{ .compatible = "qcom,sa8775p-rpmhpd", .data = &sa8775p_desc },
+	{ .compatible = "qcom,sar2130p-rpmhpd", .data = &sar2130p_desc},
 	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
 	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
 	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },

-- 
2.39.5


