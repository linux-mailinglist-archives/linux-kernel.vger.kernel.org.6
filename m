Return-Path: <linux-kernel+bounces-425578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53DC9DE6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A860D2813F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066C19D8BE;
	Fri, 29 Nov 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jprYZFwh"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871019D8A2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885679; cv=none; b=JLpreguEnoCcvDqNoP6LpRuTYIluvks1ZGnvsV+UIBmt1beqPt574Z/tqBdmWKnz6s4FXvPfpBPL7X/PnCmd7PiEsepv//tj3hxix6+1DavXdgwRXO6bE9QKDIXQoVerRBgf/XJgeqa4ojtPe4dV12djti/7Q7lKYD4wi6PUedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885679; c=relaxed/simple;
	bh=BCcVhjXqM/11poMT/N4HvI5IzpguMzkE/XgunRZ0xcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2mH3o7SU+8M6S1A/e1Yt3XkjITuh3fI6cGzZFpo6rbZFcwQWBklzDvBPqZWDkyRdhOyY4/MuAfcVVar+SVlKEhTtlI+c2eW5norck3VSQbTM2W5jDeg/2FhySIeXRM9Vy3B2EEswl4iQGaT3G676BRkVkHnAclb1IsY2zUCenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jprYZFwh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso16879065e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732885676; x=1733490476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3Aq0nsQUak92jzQ+dzMHRTGJEDpjujxd82cAU7SdLo=;
        b=jprYZFwhnJqyckqOskpGO7CG5Sghfpah2uSOWzQ82l8SDHTbkUQ0ZWLx+lQJAzR12q
         jdj7/TVADr4wNrJ6gRN21PuvYORVwmKloFEuh/n1cbg5wTLVxc8WtsTeUX4A6R9F/prp
         FHcy46F3vDcXdo0fR6aAUUB2omnOpvLEk75VAZwO1RKmmCZyZ6g5FLNvDVN06Ia8rLsu
         inNg8+xQJshgbhvupRGuBTnzqkMF5+1JA8ygMx3a0tWreSX4SHCywrsOIF6rI0T3xMch
         PpVIdx3ZuRtsGnENfrLIuyVF+ZV9QHsjMTIYqUktbxdD3Zv84ympFe7Q+M7gLqNwPYPl
         KxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885676; x=1733490476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3Aq0nsQUak92jzQ+dzMHRTGJEDpjujxd82cAU7SdLo=;
        b=PBDtNnJ3Vk2iMeDuuBELX2UXebL1oFYXEvAaaxz85GWeHS0vQjiUn4Ov4qn/wYLZz2
         TResrOwOqjfxgKUNmGRV4q4g4f+s7ZHFHCpNJhAcbS3D0lghqdVZH3SsZDQlJgcJQ+45
         WmVg+Ajzk93mNhYVfix2/k5kJWamg0Wpotmu+G0n0R/Be68waYejE2KDl7NMK7Zi4Ty9
         TYd3n1Ca6S6MxilFeQl9O7tZObNWwtbeqKe5qQwHHrcaOrd/vq7U+y3sNi65ULVwcGSy
         uKdGxKk5NAHOO7NcVG/6wIzPIYqF9O66tCv9YpK5ds4NR3G/Maqtmk31gYNAAbC5z2XH
         fxsw==
X-Forwarded-Encrypted: i=1; AJvYcCWRgJ/rfnnM8tL5+21iBhM6nfAlsnHVzQEi9xHWEPf2t94TVXheYNsz6TvERIs5Qz7ETqb3osLf/5xnXOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsE60hT6zuCQdoACDx0BFdOBrufHB6Ilsl5OyrvBmoLRrrO2yA
	NgbNgPOkIDwuhvz7zcaSlk0QpSyvUeRWTb4N8BJRHvv32UXbY3v/PLPW5+wWpCM=
X-Gm-Gg: ASbGncsiEkioORL0Qt5zDq2B8Qqn+0ETg7TKS6neVzv0M8p5oC+KaEFrJPVIZBm1ae3
	JWxSwGJX2VIrHOgzuJuYE8WrpO+KK8e8QXy0/QZKdkOm0IW2T1iKEO02LBrcADzcG3qntjNz++Z
	VleYou9OSDsUJeZVEcMFnVI/PksGbVO2wcMk5hGCYl4n6wY8CeRqYd+sOmVE6pXQEA/MqLXhDIo
	jXXGpO5Ql2VPcK63GuXB0EUjpp516kEM5Z02jEy4Iy1nw8CPeIq2LykMOo=
X-Google-Smtp-Source: AGHT+IEPEkoTPvIO2wDF7R7vcKE+vmysjyb1Ux8gO6F0UH8ZweTsBFFeO3yV0dgiqmcp49wUdMKE/Q==
X-Received: by 2002:a05:600c:314a:b0:434:9f0d:3839 with SMTP id 5b1f17b1804b1-434a9dc3d2emr103688195e9.8.1732885662133;
        Fri, 29 Nov 2024 05:07:42 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa77d01esm86228395e9.22.2024.11.29.05.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:07:41 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 29 Nov 2024 13:06:48 +0000
Subject: [PATCH v6 2/3] clk: qcom: common: Add support for power-domain
 attachment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-2-24486a608b86@linaro.org>
References: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org>
In-Reply-To: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

Right now we support one power-domain per clock controller.
These single power-domains are switched on by the driver platform logic.

However when we have multiple power-domains attached to a clock-controller
that list of power-domains must be handled outside of driver platform
logic.

Use devm_pm_domain_attach_list() to automatically hook the list of given
power-domains in the dtsi for the clock-controller driver.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 33cc1f73c69d1f875a193aea0552902268dc8716..b79e6a73b53a4113ca324d102d7be5504a9fe85e 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -22,6 +22,7 @@ struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_regmap **rclks;
 	size_t num_rclks;
+	struct dev_pm_domain_list *pd_list;
 };
 
 const
@@ -299,6 +300,10 @@ int qcom_cc_really_probe(struct device *dev,
 	if (!cc)
 		return -ENOMEM;
 
+	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
+	if (ret < 0 && ret != -EEXIST)
+		return ret;
+
 	reset = &cc->reset;
 	reset->rcdev.of_node = dev->of_node;
 	reset->rcdev.ops = &qcom_reset_ops;

-- 
2.45.2


