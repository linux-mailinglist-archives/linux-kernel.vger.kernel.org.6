Return-Path: <linux-kernel+bounces-425577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE589DE6F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA563164C17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA1156991;
	Fri, 29 Nov 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5IDfDI9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFABA19B5AC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885664; cv=none; b=FaY25Ap8Fjcyw2S3ua3JGkFAQlDHo3HMeqs/sQTshUVng50sOwHB4VP9xDSkqPFERiO17g8wFWekQP3yKF/q2uOoz57yxqkHSgokX6qTVJZLCa1Ectl0aoExDYdcv+QcFP7OjtrpCE/QGdsdbTeZwdSq9YYbmM66CcvxvlbTt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885664; c=relaxed/simple;
	bh=mQpHD0O/4DmVLloEpdEHgH89jVyxadWEyw/hKsvGyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHxkljaKOcJEJWD8CBHvCEffwJ1ylN/1j6Ubd0qa5fmIpphJIrRI2M+cZohce5bgIm/hOHa598W2z1413bibN4Wxspu4YmRQ1/35c7U8MWLRLjkjs8/cHYyAFvHerr0NWspXtSiT8O7jfsltPwq2emh84uRl0YDm7p4ikHDLQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5IDfDI9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43494a20379so16962475e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732885661; x=1733490461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=R5IDfDI9TKVnyj6lHw+l5l7gbB1ICpTZkx/K+V6gG4UQVmrLCb/iNc1ra4GaZE9txO
         csKf2OX0dDpsciUKr84zqwTicYwS/pbfjEoDaQXfYRqTzteX65+KG7IdYwpRAjaOe6Fr
         /nyEivv971MqrUE2DJcTPDSL+A7nUF8ihYRr+yEi5yWg7P3U/M1fI7ae4WvHYm6LR6Kq
         L3T1f8fCxlWJw7ktevq7r43ujVuo+gppeTqsml0rsY2k1wnmF9Ltae9ChjAJjKziqkjK
         1UD4MdXwlun1ujaOvCOdvJaXREGXpJs2vaylwQayUAPgQPQ3BkDIw7vb/KVMdQT49lem
         1agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885661; x=1733490461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=kH2EXXbO3cuCt1GGCX19XSlZ7skrdmJo69OBbD2X53ayzT8TqBR3Mw8XLmz+ArF9CM
         uguqUQtKbXRHYNp0isPAn4C133sQDA7GRBR+9n0v4KQTwYyGWxJUxzDx8ieE8muRNjYs
         js/KNKGH/6MGgJHTR6z0LT+RFDI62kSyE2zl3gxHB8Wg4FisU860bdCtMQ5GtZf325S0
         cLl/FEloa6eiUo07q2gR3hGuXObmXgabCHD533YsCqMaQ+1d5Q5NriRHXcrzyH1pSw//
         bjKKlTNUk6We30xdNtvXWxPn8S3ljiqKj2L2/+KBF2PAwYC5a0U9dPvKaQMwuW3iDGer
         VvFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe1usHG8Sk92Sclf9GspxP/zKRdqBfJeb/o6/Un67ldSBvlJWkF3yzTmWV9RQ54zMHTCDPbKGdKte2p2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIIlIpfAOxZDEQ5zguWgPRgUNv8N0HfBXc1Ae2qiNECgz7zJd
	wXTaWuO/MKXLSfFnt2/THzSnn8QWOGInglBViEH8Du9QHgzA3uglhv2El1bzQoE=
X-Gm-Gg: ASbGncvn2Sb2tnHhjdKG4B8FA+g7jZv2LSVGdgWoZWMKTy6arHt0Vjl5sZVAx+6Lq4O
	FpSSvOf8etmmxyuSqUt4R1DuvOYlIbEMzJJKO1wOQjQyC4oP/chsMhkTq5fDVwebTo6B+zJkjdF
	fNouzeAquI/trJoaaxbodTFe1kquFAOZEU7Igdf21k429OBZ8hRyvmt2vnBxQLUksnKKOQMZIK0
	+RXQJBKwzABvXmK3+HJVEhb/tgtNt6veo91Rdz4wBA1FGkYB/0MuNcR5e0=
X-Google-Smtp-Source: AGHT+IHhtPopN59nF0wT9aM0MO2ZUTkad4G2GioIMf1qnkxOPmpIkivwxwFk/94QpZ1tIVuayw0v5g==
X-Received: by 2002:a05:600c:1d18:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-434a9dbbcc7mr111429935e9.4.1732885642767;
        Fri, 29 Nov 2024 05:07:22 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa77d01esm86228395e9.22.2024.11.29.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:07:21 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 29 Nov 2024 13:06:47 +0000
Subject: [PATCH v6 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-1-24486a608b86@linaro.org>
References: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org>
In-Reply-To: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org>
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

pm_genpd_add_subdomain() returns an int and can fail. Capture that result
code and throw it up the call stack if something goes wrong.

Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Cc: stable@vger.kernel.org
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
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


