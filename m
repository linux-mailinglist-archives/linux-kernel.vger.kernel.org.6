Return-Path: <linux-kernel+bounces-317408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5C96DDB9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706B71F24166
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85217C9AE;
	Thu,  5 Sep 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4hurzOO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE97FBAC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549402; cv=none; b=d4DULeaVfiJhvBSdED9c+cqhTQS5Oi1KS/Emk9mubIPk7tMPvPuZz9ys2Mwb2ZI/DiEdPSGVJgfFhih/BpEW8e8AL1IhPZSrBrV6kR2LrLyM47dFaUbEj2AHxkTp1mTpJQwL2TqKzyO+CXMH1KLpCH/FbpiPUe+JdZl0U8A2xtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549402; c=relaxed/simple;
	bh=ekPdpG7oyzJtXPp+xFvsL02Ww7Tof9pw8p/Ac8jNKvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9VVM8lLfGdmwcS6knScQIxDrQZjjRTNGwKSF51FOCPll/te2+ZwTEJjY6PgCvf/X2muYf7sPbvZWx6mXw7AVuy4zfMgR+CElKQ9Aq1FiKartIOZ9kyhXx9epGsu9ZYazrFdqJ5DitcWWJDgcW0WsE3W6bQL1ngWlWq/aNkBfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4hurzOO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb9a23ea7so1185465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725549399; x=1726154199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbqQMJHY0wP1Gv+M3FnecbwVctkR8rJv1ZT1Z1xP6vc=;
        b=V4hurzOOG0jmrI3N7imHNPugDOKpqWArtBgEqnWVjGRC8w1tcTaEbjfXMrLxgdnjMv
         clHxMGkjY7BnuW9W6b3VRsf09yaMJHsWkcX/oTSbDe3hxw4c5hH1aagf2BhbV64dyhoS
         jgbQOn7iHYywxxfrzR9O4uoSXUeEA5M8WdKYJPHOZfCRJRZaogntbAbHGGi35o9fZYKm
         bzgDzVb78RlTqkCTSyibQF7hHTRh7B8nhkwuC+oi6d/3eyi0p1FwVCRzFqzY9LLHf1UF
         NZ3rWHWYvYRvXZKLbRXW2YLzuROWMy7k5KdRPZatIe4WteGVl9bu+VjTGxOdEjlNOZA2
         5o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549399; x=1726154199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbqQMJHY0wP1Gv+M3FnecbwVctkR8rJv1ZT1Z1xP6vc=;
        b=A26u2eiD2olOzw5LfWa7VsggRkf3C84+Wmt3sd493aaBg5tU6yo3z3qBA5gCGieU2b
         p2T0gll7ByHLItSIN46c3X7azZ+uAeAUhcUXLoLkvto33cKQPYHUyFyBdwSEfVzGhJYu
         ej1W4Gna32dBdgj1t/SNyKcLXiqO1LengsX4ue3Djihnyx2TOdG/EiFIdPHzgvcY9Tvg
         8F5kiZ23JBZHAsHEmFOk4CKzKxAsY+HXkNoUNbC9FwetOHbaNqKhAcV0xVDDsJNdhn5S
         9LdHmSz0XwPXoijPJ27tk8qsvUgjRbTYDY7RQqvkB/oHEwOLxGBI59RFefAyuDuisMUV
         NIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXybrd0OLURV6dQeP/tls+2M82hlVy6vjNb8dFUEIz7ooRL+YEwxgqVa2XZ7q2e0XZBA4VQ1JD2dnVwacQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeO92Z8yaoby3oi394WPEolJ9aflzLQ1SXNXbFVQM4FzWW7SAR
	lyIA2F0GF3cBWZEwlprSTwvjKP2hGI2WVah0gLgnkuZeaEjtyNcWf27P8ekl3+o=
X-Google-Smtp-Source: AGHT+IGrqnC4Fav20HZ0B43mlW3Q7hCc6eUOmNpGzWD39vmPmtHqiCHTNhSqc6PSx7LNERIQuu47nw==
X-Received: by 2002:a05:600c:3b21:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-42bbb0a2ed9mr82336185e9.0.1725549398958;
        Thu, 05 Sep 2024 08:16:38 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbf15b9b1sm195072195e9.10.2024.09.05.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:16:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] interconnect: qcom: msm8937: constify pointer to qcom_icc_node
Date: Thu,  5 Sep 2024 17:16:36 +0200
Message-ID: <20240905151636.280065-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointers to struct qcom_icc_node are const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/msm8937.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8937.c b/drivers/interconnect/qcom/msm8937.c
index 052b14c28ef8..d9f8ba69b329 100644
--- a/drivers/interconnect/qcom/msm8937.c
+++ b/drivers/interconnect/qcom/msm8937.c
@@ -1175,7 +1175,7 @@ static struct qcom_icc_node slv_lpass = {
 	.qos.qos_mode = NOC_QOS_MODE_INVALID,
 };
 
-static struct qcom_icc_node *msm8937_bimc_nodes[] = {
+static struct qcom_icc_node * const msm8937_bimc_nodes[] = {
 	[MAS_APPS_PROC] = &mas_apps_proc,
 	[MAS_OXILI] = &mas_oxili,
 	[MAS_SNOC_BIMC_0] = &mas_snoc_bimc_0,
@@ -1204,7 +1204,7 @@ static const struct qcom_icc_desc msm8937_bimc = {
 	.ab_coeff = 154,
 };
 
-static struct qcom_icc_node *msm8937_pcnoc_nodes[] = {
+static struct qcom_icc_node * const msm8937_pcnoc_nodes[] = {
 	[MAS_SPDM] = &mas_spdm,
 	[MAS_BLSP_1] = &mas_blsp_1,
 	[MAS_BLSP_2] = &mas_blsp_2,
@@ -1268,7 +1268,7 @@ static const struct qcom_icc_desc msm8937_pcnoc = {
 	.regmap_cfg = &msm8937_pcnoc_regmap_config,
 };
 
-static struct qcom_icc_node *msm8937_snoc_nodes[] = {
+static struct qcom_icc_node * const msm8937_snoc_nodes[] = {
 	[MAS_QDSS_BAM] = &mas_qdss_bam,
 	[MAS_BIMC_SNOC] = &mas_bimc_snoc,
 	[MAS_PCNOC_SNOC] = &mas_pcnoc_snoc,
@@ -1304,7 +1304,7 @@ static const struct qcom_icc_desc msm8937_snoc = {
 	.qos_offset = 0x7000,
 };
 
-static struct qcom_icc_node *msm8937_snoc_mm_nodes[] = {
+static struct qcom_icc_node * const msm8937_snoc_mm_nodes[] = {
 	[MAS_JPEG] = &mas_jpeg,
 	[MAS_MDP] = &mas_mdp,
 	[MAS_VENUS] = &mas_venus,
-- 
2.43.0


