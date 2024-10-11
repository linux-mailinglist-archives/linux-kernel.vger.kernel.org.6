Return-Path: <linux-kernel+bounces-361169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89A99A48C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B97C1C22E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CB621A70C;
	Fri, 11 Oct 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QP26Lct/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D5219CBA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652182; cv=none; b=l1CAcdI8wkSkjNXk3nEKsip8gxrPQ15kr9RPVXwDGXzAv6AG9jDxYxvixMH5iPcVV8I0mQThKXu8v4IVd+lVTNbbdjWpu+lezdhbElw0TGPm9/1vM8T528Wm/u2j0yB8wVEuOJ4Dm7HA56utEDhqL5HRO9Ny1zV0D59Q5Qbja5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652182; c=relaxed/simple;
	bh=bvaks1hkBdB6mLkHtBE9WICW75Nlrwxy9QIEZHf5SV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUib0C6DendRPYbwRYa4N+YSdoRKIDYgqPQbE3bBE9yz10ypYOOTuEJntfiKQASAnKalJ8srB/bEX2/Sal/kOC6dWBAbquOT4ZjGbP4x5ANyKJkhA8o1zGqoRqqkRzzB1+SkUzTQord6WxNjYa2BOTvXi8o4kTImwurmrJ4XTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QP26Lct/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43112524af7so3535025e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728652179; x=1729256979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Olg8vobPLxKKVdM2AmGN1izI2HRaSwEbsq5chGiY2mE=;
        b=QP26Lct/78CVddHfVjdz55twkuFSGCOLGYJPOQj79HOkW4TIXTan3bejj014MFzKO9
         s/ub+4pAUzTBGqDK+kH4k4eZpgLGWr8FbC7At7N3Qa4DUwMvLDYQqc8prmYS182Bf+SC
         WOeV06sICe5rEAO9B1E4gOGcDeeuO5dyoWyjGndNyUEGEQJ9rbXtArbRBEZheVrO7IeI
         kNm0MQUj2EUoDGjFZOUFP0I+Vc+qKCIyqmVHI0FHiIOgDXqyHE9D/EoSC+26q9CAtU+T
         w0RRoZuk5rm6WcYPfa1ZkepoXfRE66nVjVQLhZ9CmavN3Z2KlV4t6gQ/cKWzS9ws56NC
         qlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652179; x=1729256979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Olg8vobPLxKKVdM2AmGN1izI2HRaSwEbsq5chGiY2mE=;
        b=dc2TAAKaTmVPUOFOxlwjPaoKyNi1a8WJMRGZ7oFPnapRQ047qr2Nqo9KLqIcwAdpCy
         /v94iohsdua6YJMTqgX6LGfMnXthFi0mXMyfRJKN3rP7vunRjzH22ZszhL/px/Wtx1jX
         CzVJqL111AroN+4g+YJLDP0In20BLWtJyvdsjwzh2VGg0KASHRsvNvoDQ6EvYxUfB655
         xcXY5+kE0Al3TLY0ACtOLNxjZFkI+YLRk91K54mANthjhA/97Ya/vW6m4sBuip9RZR+K
         /FPGnIn67yEg0HfcR2zPV9hDbo50PptQTcw6lBs1Xq1lrASQeZWGyfBCzzmWiMjuJg9F
         MVsw==
X-Forwarded-Encrypted: i=1; AJvYcCUAmZ/mo9ARyJ9+cqRZHZiQiMagDYae9U7SH/9HNjZ1zj019/N1+xF7cA1OxyZ17P2WqB7m0JWrpvbGzoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiXLPt7WGfl9aae7M+d4qtArQzaA4oNthyOmf5NiVu5H1Qnoct
	aYqhELXasgD8Hbj8lizU/US8RkoM4DyGknJCOty1kyJSmuXG+gMiLOKuSQbJCROlGOYuYdEyfkK
	5
X-Google-Smtp-Source: AGHT+IFpNFWEOyFUWKDSkiNlm3PuRHh6l2nekkNPS86zLVNOkzKgF0XXWQYiHg7H/r+Qxem8WLu3kQ==
X-Received: by 2002:a05:600c:1c18:b0:42c:ba61:d20b with SMTP id 5b1f17b1804b1-4311ded5e0emr9831245e9.3.1728652178690;
        Fri, 11 Oct 2024 06:09:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm41621835e9.12.2024.10.11.06.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:09:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 11 Oct 2024 15:09:14 +0200
Subject: [PATCH 06/10] remoteproc: qcom_q6v5_mss: Simplify with
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-remote-proc-dev-err-probe-v1-6-5abb4fc61eca@linaro.org>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bvaks1hkBdB6mLkHtBE9WICW75Nlrwxy9QIEZHf5SV4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnCSODbabTLS0pgHoToJ7VcKLDStZd9nrPVUHY0
 riYkvXG1AGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZwkjgwAKCRDBN2bmhouD
 13b3D/9DytQwg/ro7GHg8SA//whmufixWNVrMMzZ5TDG8MQbnVYgfVahpwYfOm2aZB003Kxg7jw
 lQ1qU3jncUebqCAVSwgdyarXu60+mvJMPfKSTEuPYKtFdDPiZGkCH2ORCAsrumq9B/Knybf4a4l
 x6d1C7l/Zy6c4q3t3WY/RgEhgKNaVGoUi0WAWdxDe3hSGEvwDOL9dzC04ohPxq4ftd6hl3wWphy
 vL1I8OagpVsQQLe0af18gN9rKEeMQgeFdlHGTLSR/utNw8Iz256u6LrVPRqL/NpLJZOx/D9yyo/
 IEcvLvmIsLXsdxjZZtNscc/4JE0vBdEXbkkSDR2GKkx4+4OCYud5oOxyMhdWe/moo2HohhSePSK
 srcgoEmoOuzT2Fvl5FxQLXGNXCDitLy9qghJVeK/ONv9IFCFJJU2KC9374TPi+srKsQIwRi3lqN
 6JjGR00TdhfumQ7Kb6GF9o7EQ1qgb76vV+DCYdRr8QivQxm4g4ePzCp5AR48yZxJcotPqXP5+Kx
 l2xZJa+ur5gb7XYstfUMyMe5mp2B2khe4EbRYaM0q+Ns7NZiSfngSyiXZa5nvb0qRJi8ENDymss
 bsQIK2+dSNu9LsYbtLeq3RWYN/JVsODNNmhdfCq4qxEyJ5Cmb4ZVQfFzn7tIUihJ0Em8HqqrBFz
 o/gWveKt1t+v7IA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make error and defer code handling simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 2a42215ce8e07b25cb45e708aa62f9ebe83bb88c..92212892a53ea4843da62642c39413c33b4c962a 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -261,7 +261,6 @@ enum {
 static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
 			       const struct qcom_mss_reg_res *reg_res)
 {
-	int rc;
 	int i;
 
 	if (!reg_res)
@@ -269,13 +268,10 @@ static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
 
 	for (i = 0; reg_res[i].supply; i++) {
 		regs[i].reg = devm_regulator_get(dev, reg_res[i].supply);
-		if (IS_ERR(regs[i].reg)) {
-			rc = PTR_ERR(regs[i].reg);
-			if (rc != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get %s\n regulator",
-					reg_res[i].supply);
-			return rc;
-		}
+		if (IS_ERR(regs[i].reg))
+			return dev_err_probe(dev, PTR_ERR(regs[i].reg),
+					     "Failed to get %s\n regulator",
+					     reg_res[i].supply);
 
 		regs[i].uV = reg_res[i].uV;
 		regs[i].uA = reg_res[i].uA;
@@ -1813,14 +1809,10 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
 
 	for (i = 0; clk_names[i]; i++) {
 		clks[i] = devm_clk_get(dev, clk_names[i]);
-		if (IS_ERR(clks[i])) {
-			int rc = PTR_ERR(clks[i]);
-
-			if (rc != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get %s clock\n",
-					clk_names[i]);
-			return rc;
-		}
+		if (IS_ERR(clks[i]))
+			return dev_err_probe(dev, PTR_ERR(clks[i]),
+					     "Failed to get %s clock\n",
+					     clk_names[i]);
 	}
 
 	return i;

-- 
2.43.0


