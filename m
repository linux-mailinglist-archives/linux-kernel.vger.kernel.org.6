Return-Path: <linux-kernel+bounces-562281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B5A621DC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0876919C60A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B6F1F5849;
	Fri, 14 Mar 2025 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0HHRgFp"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58951F03E5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995363; cv=none; b=TPFMNvfxjyzy35dySWq7EG/zo4xvuSmNaQX0/N7sQCbbIRRUXRDvPQj4lZD7wRqqtMCiP35rNMcRewtEJWLICjezyMRlR1STQ8g7Mbbpsj3O3/xhJgfe5bIUs9UUCMRix0wBnICdnHi1i9XZbsY4VhFm/jsLzHC11EXmDxzwRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995363; c=relaxed/simple;
	bh=ukK58TSZD1mgx2a2RMEtx4bXeUeR9Zv1iJTR2sL5N+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7dhx8rX1nVYBvUQozFrcnbqSQ7QrWtPpYilJ6GHBOFbFKaTTFnhSNmfBIHs6k1iqDDsXfUDUFpXeGo0gSLGoHnhFwxUnV2rVQAG6gmrcvpMAVWk5tGLVfWLbNAe86lv0EK3YhsJGZ7bBWyOE3M7aUfhRhzuYT5Fj1x4gUAH85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0HHRgFp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso477360866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741995359; x=1742600159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgtbrNjg3RxK7lHji+uLlEjbRwxwoaENC7vutfrY5Ak=;
        b=y0HHRgFp9ITHESaB4ouBNW8Xfi/ZIiKkYQdNHFArfAXZzr6wL/vt5XlaE5U7Fwgrfu
         OajSvnTwrqfwDM1hraI4xpRhCW2VR2S6/pmSn8jxIqTSLfN/i3QoASB49Trz+oMlqJLi
         nftnRdzWrrYnOHYXhSAz4vzrRiKcsZEisPyGTyRT5ExLssmjvAGopMp2FMH+kcwTn+rf
         tlHvqxUgrPW9Z09JCtbubsqEDE3NUehuJnn5fKs0pnna+4cl+1F+81oT7oNwHpOOX+To
         VnBOzYmNIT4IEDp1i4CBiGOjUDAJ+6iifmqGGSHHvtmiL6lmXPfRMl+DPjT5+Fc7hACT
         Ftrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741995359; x=1742600159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgtbrNjg3RxK7lHji+uLlEjbRwxwoaENC7vutfrY5Ak=;
        b=J2pJlRhmAE8l4pTA6Y/0dtoP7K7bLuHJd4NDNj+1UVoJh+Rve/C6uMLl0wzgcNqwWz
         ktK0pfnM14Y5pHdutD8boQbMPrjNXo8odgjCjmOBIk2ztl14hDyQS436GL8TomDnc4TB
         MMp/j+c7y3lMBto2UT/KSARfO50MKhElHowlqcmXSpdKO9xj5Xla6KgujcMKlbIW9gO5
         7WwygLb7o7sPly6x/WR+z9XWPNJ0RuHit29UQDydqPsjgm5UgFvGF5vfTtnBJrCJXfYG
         hFQEx/lB+mEwxJQXR5FdktSCD2ppNoiUMb6EnABffvMLmwfS6UqGoNY6T78VqwVDoojF
         wiZw==
X-Forwarded-Encrypted: i=1; AJvYcCWiQOZ25rdxNNq7fT559uzv1MzOU9ry5N8s8AuLv1P0WMlmahhesTcr9hHwpICmWMigiSpssOpyJ1OUHdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+UHFBsdXEfmen7/FyGOGt0SFErnWD6fnO2awXhUr7JGA4eQZ
	FXcb8/QYO8ow3JKTokZjh7DPhO2f2t+l72iaPFwVtfY6sZHaL4aqvGeowhjKEYwAzbZ0Y/Kk0KL
	Lz9U/ag==
X-Gm-Gg: ASbGnctm3+JWPZNWV0uDWPMmD7zEwYBn04P2lPmR97DhVtREoa/9l5BliGSvWV1CfZ0
	/QtT2ci1Cm23Va5b8ROijhYvJGwGPn5a2RwPKlfpI6sSAFmLf8PMy2s1dd9gOwq68tZh2GmDvgK
	5q7bzDza0/Ckttq5yFQEgqAcIhoBAGqvHp2BdjtmauRvBRmdjbpVfvmw2GcO23VviM2BQTEi78b
	1hgFMCMvO6tkxWDDtd84KMYmFLz+e5snAfMX2MTwVbCpGZk5gH5QLqBqFtnvbkRIhxSHQVkLzT0
	cwhhofvHF8k7AMAAuib9Cj7uBRjU8ukvAgGK0Pmgoo0DauqKB+P9tPHrW3PHsWAUnfmbslkDvz7
	Gj08Ik+jlhcImf/TpVJ8AOJXZoMT9iXNUKzMk/bnwH+CusD7M2k94S65fXLgPFv4weycE
X-Google-Smtp-Source: AGHT+IFioEfRk4etvKLgUi95Is5Nk227xfOzVnVRdw09cGLrCdUKOtOpJZvahOiRQ8jdUpxMj7pcgw==
X-Received: by 2002:a17:907:2ce2:b0:ac2:d5d3:2b77 with SMTP id a640c23a62f3a-ac331304749mr433254266b.8.1741995358560;
        Fri, 14 Mar 2025 16:35:58 -0700 (PDT)
Received: from [192.168.178.107] (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeadbsm284246966b.29.2025.03.14.16.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 16:35:57 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 14 Mar 2025 23:35:54 +0000
Subject: [PATCH v2 1/7] media: qcom: camss: Add an id property to struct
 resources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-b4-media-comitters-next-25-03-13-x1e80100-camss-driver-v2-1-d163d66fcc0d@linaro.org>
References: <20250314-b4-media-comitters-next-25-03-13-x1e80100-camss-driver-v2-0-d163d66fcc0d@linaro.org>
In-Reply-To: <20250314-b4-media-comitters-next-25-03-13-x1e80100-camss-driver-v2-0-d163d66fcc0d@linaro.org>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
X-Mailer: b4 0.14.2

In various places in CAMSS we assume a linear set of declared devices
{csiphy0, csiphy1, csiphy2} which currently works for upstream SoCs but for
upcoming SoCs some of the SoC resources will result in a set such as
{csiphy0, csiphy2} which will break the naive for() loops we have.

Introduce an identity property which resource declarations can populate
hence facilitating non-linear resource naming.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csiphy.h |  1 +
 drivers/media/platform/qcom/camss/camss.c        | 41 +++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
index 86b98b37838e11d43d642c3f24e9a66acddabd03..ab91273303b9e3c67c4bcefe1e3a67e1a47bf14f 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.h
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -81,6 +81,7 @@ struct csiphy_hw_ops {
 };
 
 struct csiphy_subdev_resources {
+	u8 id;
 	const struct csiphy_hw_ops *hw_ops;
 	const struct csiphy_formats *formats;
 };
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 6791dfea91b13d584694a26599e24ca088dfc1ab..9da74da679a28070b101df06a8412e85efdcffcc 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -46,6 +46,7 @@ static const struct camss_subdev_resources csiphy_res_8x16[] = {
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_2ph_1_0,
 			.formats = &csiphy_formats_8x16
 		}
@@ -62,6 +63,7 @@ static const struct camss_subdev_resources csiphy_res_8x16[] = {
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_2ph_1_0,
 			.formats = &csiphy_formats_8x16
 		}
@@ -318,6 +320,7 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_8x96
 		}
@@ -334,6 +337,7 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_8x96
 		}
@@ -350,6 +354,7 @@ static const struct camss_subdev_resources csiphy_res_8x96[] = {
 		.reg = { "csiphy2", "csiphy2_clk_mux" },
 		.interrupt = { "csiphy2" },
 		.csiphy = {
+			.id = 2,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_8x96
 		}
@@ -524,6 +529,7 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 		.reg = { "csiphy0", "csiphy0_clk_mux" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_8x96
 		}
@@ -542,6 +548,7 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 		.reg = { "csiphy1", "csiphy1_clk_mux" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_8x96
 		}
@@ -560,6 +567,7 @@ static const struct camss_subdev_resources csiphy_res_660[] = {
 		.reg = { "csiphy2", "csiphy2_clk_mux" },
 		.interrupt = { "csiphy2" },
 		.csiphy = {
+			.id = 2,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_8x96
 		}
@@ -751,6 +759,7 @@ static const struct camss_subdev_resources csiphy_res_670[] = {
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -768,6 +777,7 @@ static const struct camss_subdev_resources csiphy_res_670[] = {
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -785,6 +795,7 @@ static const struct camss_subdev_resources csiphy_res_670[] = {
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
 		.csiphy = {
+			.id = 2,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -935,6 +946,7 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -957,6 +969,7 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -979,6 +992,7 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
 		.csiphy = {
+			.id = 2,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1001,6 +1015,7 @@ static const struct camss_subdev_resources csiphy_res_845[] = {
 		.reg = { "csiphy3" },
 		.interrupt = { "csiphy3" },
 		.csiphy = {
+			.id = 3,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1179,6 +1194,7 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1192,6 +1208,7 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1205,6 +1222,7 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
 		.csiphy = {
+			.id = 2,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1218,6 +1236,7 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.reg = { "csiphy3" },
 		.interrupt = { "csiphy3" },
 		.csiphy = {
+			.id = 3,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1231,6 +1250,7 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.reg = { "csiphy4" },
 		.interrupt = { "csiphy4" },
 		.csiphy = {
+			.id = 4,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1244,6 +1264,7 @@ static const struct camss_subdev_resources csiphy_res_8250[] = {
 		.reg = { "csiphy5" },
 		.interrupt = { "csiphy5" },
 		.csiphy = {
+			.id = 5,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1458,6 +1479,7 @@ static const struct camss_subdev_resources csiphy_res_7280[] = {
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sc7280
 		}
@@ -1472,6 +1494,7 @@ static const struct camss_subdev_resources csiphy_res_7280[] = {
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sc7280
 		}
@@ -1486,6 +1509,7 @@ static const struct camss_subdev_resources csiphy_res_7280[] = {
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
 		.csiphy = {
+			.id = 2,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sc7280
 		}
@@ -1500,6 +1524,7 @@ static const struct camss_subdev_resources csiphy_res_7280[] = {
 		.reg = { "csiphy3" },
 		.interrupt = { "csiphy3" },
 		.csiphy = {
+			.id = 3,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sc7280
 		}
@@ -1514,6 +1539,7 @@ static const struct camss_subdev_resources csiphy_res_7280[] = {
 		.reg = { "csiphy4" },
 		.interrupt = { "csiphy4" },
 		.csiphy = {
+			.id = 4,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sc7280
 		}
@@ -1766,6 +1792,7 @@ static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1779,6 +1806,7 @@ static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1792,6 +1820,7 @@ static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
 		.csiphy = {
+			.id = 2,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -1805,6 +1834,7 @@ static const struct camss_subdev_resources csiphy_res_sc8280xp[] = {
 		.reg = { "csiphy3" },
 		.interrupt = { "csiphy3" },
 		.csiphy = {
+			.id = 3,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2134,6 +2164,7 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
 		.reg = { "csiphy0" },
 		.interrupt = { "csiphy0" },
 		.csiphy = {
+			.id = 0,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2147,6 +2178,7 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
 		.reg = { "csiphy1" },
 		.interrupt = { "csiphy1" },
 		.csiphy = {
+			.id = 1,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2160,6 +2192,7 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
 		.reg = { "csiphy2" },
 		.interrupt = { "csiphy2" },
 		.csiphy = {
+			.id = 2,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2173,6 +2206,7 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
 		.reg = { "csiphy3" },
 		.interrupt = { "csiphy3" },
 		.csiphy = {
+			.id = 3,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2186,6 +2220,7 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
 		.reg = { "csiphy4" },
 		.interrupt = { "csiphy4" },
 		.csiphy = {
+			.id = 4,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2199,6 +2234,7 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
 		.reg = { "csiphy5" },
 		.interrupt = { "csiphy5" },
 		.csiphy = {
+			.id = 5,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2212,6 +2248,7 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
 		.reg = { "csiphy6" },
 		.interrupt = { "csiphy6" },
 		.csiphy = {
+			.id = 6,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2225,6 +2262,7 @@ static const struct camss_subdev_resources csiphy_res_8550[] = {
 		.reg = { "csiphy7" },
 		.interrupt = { "csiphy7" },
 		.csiphy = {
+			.id = 7,
 			.hw_ops = &csiphy_ops_3ph_1_0,
 			.formats = &csiphy_formats_sdm845
 		}
@@ -2749,7 +2787,8 @@ static int camss_init_subdevices(struct camss *camss)
 
 	for (i = 0; i < camss->res->csiphy_num; i++) {
 		ret = msm_csiphy_subdev_init(camss, &camss->csiphy[i],
-					     &res->csiphy_res[i], i);
+					     &res->csiphy_res[i],
+					     res->csiphy_res[i].csiphy.id);
 		if (ret < 0) {
 			dev_err(camss->dev,
 				"Failed to init csiphy%d sub-device: %d\n",

-- 
2.48.1


