Return-Path: <linux-kernel+bounces-538752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9CA49CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BC0189A9CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BCE276047;
	Fri, 28 Feb 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOSdOl42"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2051EF380
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754796; cv=none; b=kEBMJuPqijbdYf/yJJYbLkKWDECdFh2UkJ1vR5kBxGCj/SkTOlBjQ2jsuSCJ4Z0Tm6YzPCeAhXDUg7UzRmsbkl4URF9uy3DwA97RVsTHd1Wj/r4fxgAc8sif5q22iVw8WDclpRP9OeIgK3LiPAfgahKSLj7cSL/S8IMicktlSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754796; c=relaxed/simple;
	bh=mmPe3aCjukV4SZKaaVCK7w1EvExowJECHnSClOjtWdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTJHbjK/TKbl96OMZu9Y4NL2WNMJT9IwjIKwZJZXJ/q+7aOJlt7WpiMGooks+YLSi7ryYDOQ0pGkny0vINLMThCkZG7vsF19wZMhJxTabjEQltNabVgWLBMj76YZW2ozPj6vCb+1jcfHDvdUBAbqMWxIpevJt3tkAGFYE6P+E80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOSdOl42; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43989d2afe1so1997845e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740754792; x=1741359592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlIXu+UpPuRA9Tf0Xf+l3/tNb7e0Fm8P8chbEI4QvHE=;
        b=AOSdOl42eUybyWiLDbf4dLe87kp5FmKeT0ljiD6tngfREfRv8moil+SmVXBEPUJw5P
         +r8L/ZaLxlQbkRQFv9cB93Zkf8cWPm7+K8jXYOHa+b8yOeNYBGitdE7YhT333KRDiwg4
         HeYv5r38YSxSCW/PTWfkD9lvcoYV7pv7eV2SQnRVdxLVIM0ns8zBgFcH0rI5/FVCB6n+
         BQ81xn/qXA1Vq4IzmLjVCpUsDFvip+LSA1O/b5+f1LByGaRGLGrqRzmbsRl6BQAXxUkq
         vndbkDmGrrWPAUQguW0VIKOHq/NqVdyRHMqJpAbtho8mqVv0k7YyK2JFk1ee5z983Z9A
         KWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754792; x=1741359592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlIXu+UpPuRA9Tf0Xf+l3/tNb7e0Fm8P8chbEI4QvHE=;
        b=OI4x+YqqRa3TDCb8pmWWnP6RQdkAL5pCiLaeSWd46GR2+uwOvc9Wh3mEeMOa0Uql5k
         ESZa7fJYp7eC1Ok+jrrARyxa6Re96wl+JVomqqggolIaRlnmCebS2kDyzWbSD+uByh7T
         zzzv3+vqfskw5BK+6TDJvx4awri8UepZ4A3/GCbTDxpCe4vqPQ7V7PQ1hENwcR6GwF1C
         QH1zKrjvdiW6jqOcBwhd00/F+LgcZkMpjhdqMXkbUOmQNC79ryAiHc1Q8/1f6QRfy1Lw
         BTSbdBKFaMw99ci918DIPSXTfJ02prn4TMnMZPlWpNgVU1RrQWBzkg2XkCKNq+K4J2cm
         kbug==
X-Forwarded-Encrypted: i=1; AJvYcCVa+Vd9VmHb87CGFbDoQp78wlBMCvJeWpVjnVcdT0kU3aLFuH9e4yuZDultm6nbiTyUIAlSSD1B2TNNHnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlIiBRYq/7DswqSlgIvlSAftWrXDljqUAIv5PVaoL/fgifxs6
	XzgFzzXOKQNkly9t1XgZtUWL+2+Wno1fbiHpScw24PWsEMgGRQTjvpIMXpEBBkDcE2F6rT9P3UH
	MroQ=
X-Gm-Gg: ASbGncsQF35zkRR9eXPbH7JTM6bDvEuyQP6Ie/PYcB8ObdGg0VysnSqQUD21UnuHdIs
	fB5OB6xnv4AB43g7KT4hNd/np8j7ow9mV88025iiDGMJwntV74NR+e69mE5TehvZPwt9BvKAhoP
	KoUyjYaTe/OhwEbUF9+hilpQNBH8GX9RpP4+E0jf8lvrnpFCCt2wxRs4Q89rPyd7WrE8cOIHr2O
	IppUyAOruzsXDOm9N3FE+lhZjylzIJPBvhSfouuBEfxKF5NkjB61EaysuVE3EbxFr8nQgozBwT6
	njQ++0waLT3qQ7e823cJrBv7lW79JN9oTzg2yKAMYA==
X-Google-Smtp-Source: AGHT+IEsa7OopANQ+TcZ/BU8Moko7GjMoOfSstkT7tSHJJOmpufmGxe/C/UYAhhi+wnliz5mcpwabA==
X-Received: by 2002:a05:600c:a01:b0:439:9a40:aa1a with SMTP id 5b1f17b1804b1-43ba675b15amr13190865e9.6.1740754792196;
        Fri, 28 Feb 2025 06:59:52 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d785sm5450770f8f.83.2025.02.28.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:59:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 28 Feb 2025 15:59:39 +0100
Subject: [PATCH 2/4] clk: qcom: dispcc: Constify 'struct qcom_cc_desc'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-clk-qcom-const-v1-2-611ab80d45e4@linaro.org>
References: <20250228-clk-qcom-const-v1-0-611ab80d45e4@linaro.org>
In-Reply-To: <20250228-clk-qcom-const-v1-0-611ab80d45e4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5381;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=mmPe3aCjukV4SZKaaVCK7w1EvExowJECHnSClOjtWdk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnwc9gzSmCl5LcCKNLr4Jw3QBuBnkomWGDMuczT
 AGNX8oZUA2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8HPYAAKCRDBN2bmhouD
 11dpD/9T0LFVOvLFDwjKXRK2qi1NCU5sC1rhPEvHS/JrMcK5kcXQTw64AX4phK67DLt6qxXLIxp
 ll2m/VzFN4w/AcUtq969C5MreAMActqx9q5Z/l2eCIRYxZR5iIrM3n/YdXJTno6qXaQPQZYy6wK
 Ok/7TGunIDp5wCpCYMvKOMKOThXzMaq7TRCYMR4yDGw/frkt3+WSOTb/eGA7z8Z+deuNocbbYY6
 DLsG8y+rJexlN586boLPqx4Wlfk+dA11FRryGHhbZdpuUQ8IuBDvwbB3ZXInBpkI+o7iYyGLXS0
 lkNGWU3gAczV89JQkJ3DsMlKJkQmzfhBQHgXwVDG1DHexopmk7Re+q2rsDQNs1yjqtr8DXPcm0a
 LcsJ5JHLepZAWnxIvc3RwQolbYWACOPUB9oMwrj3J8M8NNBk25CdXS25YMDglLZUAIweVb+xDy5
 WD5nD4LC6VGiTOQDIHwfa1FQ8E82yIrxs/FcPbuL3cCN1SbHCkHfUtCclzfIWBv+RpPNSA4Vdyx
 2/BJymxxchpwJeNCRprxMPdqDx5o59Xx+qnc30j/R6VORn4NIvPpjsCCNjrPtUhlpEva5sueMux
 U5MkqcFNIurdJo6YN2bsPDeV9Ratn/I7hdamjyp8tdSClUf9guxudGIu8tVB5t7Fh5NMnUvnYsz
 lzrg2TjoIfjQhfA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct qcom_cc_desc' is passed to qcom_cc_map() and
qcom_cc_really_probe() only as pointer to const, so make the memory
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/dispcc-sc8280xp.c | 4 ++--
 drivers/clk/qcom/dispcc-sm4450.c   | 2 +-
 drivers/clk/qcom/dispcc-sm8450.c   | 2 +-
 drivers/clk/qcom/dispcc-sm8550.c   | 2 +-
 drivers/clk/qcom/dispcc-sm8750.c   | 2 +-
 drivers/clk/qcom/dispcc0-sa8775p.c | 2 +-
 drivers/clk/qcom/dispcc1-sa8775p.c | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 34fae823423a9035bdd39517ef7ac429140a43b5..5903a759d4af4979843499a45406d0eafc5eb108 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3113,7 +3113,7 @@ static const struct regmap_config disp_cc_sc8280xp_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc disp0_cc_sc8280xp_desc = {
+static const struct qcom_cc_desc disp0_cc_sc8280xp_desc = {
 	.config = &disp_cc_sc8280xp_regmap_config,
 	.clks = disp0_cc_sc8280xp_clocks,
 	.num_clks = ARRAY_SIZE(disp0_cc_sc8280xp_clocks),
@@ -3123,7 +3123,7 @@ static struct qcom_cc_desc disp0_cc_sc8280xp_desc = {
 	.num_gdscs = ARRAY_SIZE(disp0_cc_sc8280xp_gdscs),
 };
 
-static struct qcom_cc_desc disp1_cc_sc8280xp_desc = {
+static const struct qcom_cc_desc disp1_cc_sc8280xp_desc = {
 	.config = &disp_cc_sc8280xp_regmap_config,
 	.clks = disp1_cc_sc8280xp_clocks,
 	.num_clks = ARRAY_SIZE(disp1_cc_sc8280xp_clocks),
diff --git a/drivers/clk/qcom/dispcc-sm4450.c b/drivers/clk/qcom/dispcc-sm4450.c
index 465725f9bfeb774a147a0f5a5452255ec1b422ec..e8752d01c8e629a1daaefe66e5d24bba0c61e2ca 100644
--- a/drivers/clk/qcom/dispcc-sm4450.c
+++ b/drivers/clk/qcom/dispcc-sm4450.c
@@ -721,7 +721,7 @@ static const struct regmap_config disp_cc_sm4450_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc disp_cc_sm4450_desc = {
+static const struct qcom_cc_desc disp_cc_sm4450_desc = {
 	.config = &disp_cc_sm4450_regmap_config,
 	.clks = disp_cc_sm4450_clocks,
 	.num_clks = ARRAY_SIZE(disp_cc_sm4450_clocks),
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index 0b76cddbeb940bcae5f37f4a226a204a6c608f47..9ce9fd28e55b234d23b7a610d419a305725f9668 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -1779,7 +1779,7 @@ static const struct regmap_config disp_cc_sm8450_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc disp_cc_sm8450_desc = {
+static const struct qcom_cc_desc disp_cc_sm8450_desc = {
 	.config = &disp_cc_sm8450_regmap_config,
 	.clks = disp_cc_sm8450_clocks,
 	.num_clks = ARRAY_SIZE(disp_cc_sm8450_clocks),
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index a373c92a10aaff78172bdb44cafda82f564ea19d..f27140c649f5531ea358a3de5d93241ed756e594 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1745,7 +1745,7 @@ static const struct regmap_config disp_cc_sm8550_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc disp_cc_sm8550_desc = {
+static const struct qcom_cc_desc disp_cc_sm8550_desc = {
 	.config = &disp_cc_sm8550_regmap_config,
 	.clks = disp_cc_sm8550_clocks,
 	.num_clks = ARRAY_SIZE(disp_cc_sm8550_clocks),
diff --git a/drivers/clk/qcom/dispcc-sm8750.c b/drivers/clk/qcom/dispcc-sm8750.c
index a532d9ad9dd369121123486ff026715b948f351e..b46836ae6ae7e642bea5ddd1f99052daac1b6239 100644
--- a/drivers/clk/qcom/dispcc-sm8750.c
+++ b/drivers/clk/qcom/dispcc-sm8750.c
@@ -1887,7 +1887,7 @@ static const struct regmap_config disp_cc_sm8750_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc disp_cc_sm8750_desc = {
+static const struct qcom_cc_desc disp_cc_sm8750_desc = {
 	.config = &disp_cc_sm8750_regmap_config,
 	.clks = disp_cc_sm8750_clocks,
 	.num_clks = ARRAY_SIZE(disp_cc_sm8750_clocks),
diff --git a/drivers/clk/qcom/dispcc0-sa8775p.c b/drivers/clk/qcom/dispcc0-sa8775p.c
index bf9de92a5dd24108c8bd41dea200ab8aa5aa5e58..aeda9cf4bfee8934659a8a5440d48f52b6f69fdb 100644
--- a/drivers/clk/qcom/dispcc0-sa8775p.c
+++ b/drivers/clk/qcom/dispcc0-sa8775p.c
@@ -1417,7 +1417,7 @@ static const struct regmap_config disp_cc_0_sa8775p_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc disp_cc_0_sa8775p_desc = {
+static const struct qcom_cc_desc disp_cc_0_sa8775p_desc = {
 	.config = &disp_cc_0_sa8775p_regmap_config,
 	.clks = disp_cc_0_sa8775p_clocks,
 	.num_clks = ARRAY_SIZE(disp_cc_0_sa8775p_clocks),
diff --git a/drivers/clk/qcom/dispcc1-sa8775p.c b/drivers/clk/qcom/dispcc1-sa8775p.c
index cd2f2eb7ffb4f073386a5754aecf22ddb603e22f..cd55d1c11902417eb78e3507d757b20382e8bab5 100644
--- a/drivers/clk/qcom/dispcc1-sa8775p.c
+++ b/drivers/clk/qcom/dispcc1-sa8775p.c
@@ -1417,7 +1417,7 @@ static const struct regmap_config disp_cc_1_sa8775p_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc disp_cc_1_sa8775p_desc = {
+static const struct qcom_cc_desc disp_cc_1_sa8775p_desc = {
 	.config = &disp_cc_1_sa8775p_regmap_config,
 	.clks = disp_cc_1_sa8775p_clocks,
 	.num_clks = ARRAY_SIZE(disp_cc_1_sa8775p_clocks),

-- 
2.43.0


