Return-Path: <linux-kernel+bounces-420367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83AF9D7996
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4769016293F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C9810A1F;
	Mon, 25 Nov 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOtyzUt/"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934ABE40
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496418; cv=none; b=RAsTHcLnYRB2nO6B/39KzBHWZ6YBg3mmDdFAEzmDPbayC0Jhkiw38xanqhRBYr8rfzck7tuIE1k9XzgXnptANYcUT9/1qx9i+1krpzOrBpnL64PhB3jtyBW5VmiTWYLH6eFsIGK9QppdUglKg8kReRnDSnNTFcOcjLUVV5tdCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496418; c=relaxed/simple;
	bh=CdkYU+QJ7VGTHMAgD+J6/KS8Mhb64oBSKmpBnvb/LZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bq2Xu568yowDXGck6fdNAyisTXTMyETeSqR7CHgbDyqeNblCofROiwLFgjbIGHDUDRh+S+zHMHN5PpWY5N4dcsWH2OX8cT3CbUZqvYnp2r57O0HiTctuUXw5JJEUf1gY8j5yETsx32fSqHctele9D6TDC2MmfAuJAcX9pf+m11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOtyzUt/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43152b79d25so35132825e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732496415; x=1733101215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+O0H/HlytTMZjW4JWV/layUzk6y2v65D7CAbQ2KVEWY=;
        b=TOtyzUt/rXyh125kPo6iV5EkKKLnH+vdwcuwgZOGTYl3sFk8kq3Nyxq6W3WbhZ0jp1
         IniqdNyAbZjX3lmefFs61zWNmonVzGjus11MxR2lWC0DuBtErcvibYk2LQk4Y7NljEoR
         OGSHsLDi7ojrR3LIeysbTfuybrxBiWJLo0e4HRd1WRyNl+F/m0lBQiEtSvSJLzzu5L9A
         lK7L3OnhorHrdcLNwWel47fufCoxqe0KPqzIKIIw0gQYaNbBC334fGGOwkKwRju141o9
         GuXl34H2M0MNG+JerHZMSBQQ3PqWwMvBg2coPz8r84pFHGIAXgwZ3E8pIVEHShOEQuDJ
         pG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496415; x=1733101215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O0H/HlytTMZjW4JWV/layUzk6y2v65D7CAbQ2KVEWY=;
        b=Vbcut+qVw0IUDxMU98blHXwrMWTilL7I31WV0I6Rg4yXyIq85KbpPZOC5EIWNianxN
         x+e/+q6i9EIja7ndwxqopJMhznSdlp3adTS6jTw7LX/M0AC68P5lPn1NY7MlHOAQaOFJ
         KDyLWD5aQWmBfvp3X+xo3rTWS6GDtn63nYJmbCEZlGPODNP1fNKoxOwd9QOIFCFiNkwR
         5DMNWwS+BUyUBlDn8P3/SS8lB7WnG30f0POYhzrnYiYiWO4H/a//B+kFpdNPuhRcVyt8
         i7B9bpkUkljaYoqEFb3eZ8570CaDtK3OzOMsa8TpjqBM7bDEhjYuDCSyreJf1GIUiet3
         HEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyxqMn4THpad2Yoem2xmS4okuB6zBZdbQS76hL8qEnG8kRK8XB2+Q3HaOBegS7hs7+HcoPEqy7dPHJCUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgWjzHQud+OGnCzUcRHrF0n0Ky3emKc6ldhMjoXV2PLYf0Tyqh
	T1K1Plojr1NKUbsTYgSaCqT/KYNzuJ2AuF9LOUgKRfOuTXzxHWLoWe+YQee7xSM=
X-Gm-Gg: ASbGncuP/VAb3cSmqgnEg744S52bTjtAoxd2E7wyGR+PUKryEJNiFZIaXQSZQ4wAn3d
	BmgVGbpvoRUMsFommPkGJHT0eRR/X75f0pkduadqC/p85u/BfhkyZVzyQk1To8mEtpgTQ4JyroZ
	kwBMPiZ2Cqt94X1BlLT6h/oyQsxSiOd7HexEssxDmFsW0QzWWakS9HqoalfmSRy7OaD3JOkiVuY
	loYKthtofp4wOoMp76vd3jL8GdqxRNpKg49XPyDLBhbg+AY+K4EUW/3x2Q=
X-Google-Smtp-Source: AGHT+IHMErZ6fryz2Oc3MCpFRq83v9PpLk8yzbEoM1+JFIaFwdXjct61irdWGrNB++dDxJOSlfOu8w==
X-Received: by 2002:a05:600c:3ca2:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-433ce4b2f20mr107512995e9.31.1732496415157;
        Sun, 24 Nov 2024 17:00:15 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349f0ba652sm24125125e9.40.2024.11.24.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 17:00:14 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 25 Nov 2024 01:00:12 +0000
Subject: [PATCH v2 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-1-a5e7554d7e45@linaro.org>
References: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org>
In-Reply-To: <20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-355e8

Adding a new clause to this if/else I noticed the existing usage of
pm_genpd_add_subdomain() wasn't capturing and returning the result code.

pm_genpd_add_subdomain() returns and int and can fail. Capture that result
code and throw it up the call stack if something goes wrong.

Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index fa5fe4c2a2ee7786c2e8858f3e41301f639e5d59..4fc6f957d0b846cc90e50ef243f23a7a27e66899 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -555,9 +555,11 @@ int gdsc_register(struct gdsc_desc *desc,
 		if (!scs[i])
 			continue;
 		if (scs[i]->parent)
-			pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
 		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		if (ret)
+			return ret;
 	}
 
 	return of_genpd_add_provider_onecell(dev->of_node, data);

-- 
2.45.2


