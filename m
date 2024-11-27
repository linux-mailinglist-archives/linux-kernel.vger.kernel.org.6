Return-Path: <linux-kernel+bounces-423666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4D9DAB15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB9F1644A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC5200B88;
	Wed, 27 Nov 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVuz2VU0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016E20011A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722842; cv=none; b=VtdgLHsbODyxnul7542/KE31zHJbvFnAoCLeD8aliYBQCiG2UZHtkD11Bx7sfDevaGOFfBMytsboVEH9slCNZin1DMs3ejreWhO5zf5FKNCdpT6mQdVu0Joznxksmd2RbY30sKw8M45W5WmjbAAQwBHRRP3VOKuLwEqnef5oOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722842; c=relaxed/simple;
	bh=mQpHD0O/4DmVLloEpdEHgH89jVyxadWEyw/hKsvGyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POjOHW5ZTH4uLT74RRiFqQEURA9chm6op4qRINg/yiMsikhMaGYwqswl9ysKJedwIpWcixW0nBtsC3IVwG2nphu6zK4B+in9qpRz0q6+1SR13rjYt9I6q129QHRozkigyiPq1ykXE00NSVy5b3tlctOp5RVwMwVOAymGt9yNy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVuz2VU0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so5986545e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732722839; x=1733327639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=iVuz2VU08c86+7CpdTHgmymTC9Xk5kQFrHI3Rm85MZzG4mMoFBbZjE894yrfX9Juju
         J6aPgdu2cuJbd8SjEAE5F8WKLlV71LoSiJsDXQoXKw9qxUEvv1+bybyD2oLHm/fvuARy
         lS9eaNc+9L+1NM2pYsvehxAjuuoZPzHNqTbvNfJUwJ1hiP+ncvfEZtKmj7WL2XiVC3zb
         ZLFCeeI9f6EOTO5XSG3Q61ppks8CMLfrHtTmo2UVAX+aOpieItKZbd7n9jGflbsppyi8
         P7prLo67uIlVdTxFa16h2useyzLybazkRJGUT5i7ZrzdgNd0q2bbzkX/v8SSOwYQuP36
         lotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722839; x=1733327639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=tQtKPlRaN4az10bmtQwep9Boy42eTLhsj0Nma2goHnovMQ8E1Q3RLj7KkiMhfCDgKJ
         aRsZlNWuueGvT37nMqpirUtcx0HBJFq6PoWyXE6NxLE40qVW4Ny/bOltsfypzsftVLza
         OUxdE2A2V5TdQSwBzruS/VVEGr+RVJOSfDGZNQrxGU6/ZDwi2RbWFgB7OqiRhaZqvUGc
         G7MiVZUE67vHYoauq/ZZaJVHrQ9M2A9bbGVeYZ6hVNgWfQssten+qPZ4V3gEfIhEIfHS
         lC7UPYLxj76+xaRlHRdPx3CjNowu2MWeOXDd1g/b+oskzJcFdO1xKJxRJBwUUMTPtbVj
         TX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8QDdovjAwkbF8k5DNH+3E26rTNUSA2HbFkUUiphQs6MhfGxERJqHD60s9kTWh1z1TWPQa3dV6U7IiFu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcyW/nrXz+kCjw8k3ix0HhesrgnZuO8+ofgK1LBXAWhEinkCl
	7B0Fpr35qUMI7GCVtyl5/OAzY3N0fp+QW9NLsEBrmYfZ8Jt2ySVP6Ewe6W3Cf+k=
X-Gm-Gg: ASbGnctxBmOdQjUhkZ+aP6d6IUzkQj/q3Nz6wSsuGzYpnnM6MF6932iv1kDQJuaWDuT
	LtFhh65UIyRTNBG7HnfgEo4xxzwOOsmBEHiV7UnZ4noNmtej3EmwkxC+NSh+w0A+F5g2jCosoqN
	6osQw7NN71YTwd3z1aFFEm8SLGKhmn+gBNkPWg92U8eB9OTVQTbwxy2vZe6Rb7fvViCZemN3P83
	4KJh596QzN4jx+DoaPmyZet6x+Hgv0JSFUQGLm64kM3hKSn6hSBFjhP3SE=
X-Google-Smtp-Source: AGHT+IGCi2IOz/AsR8JkzwtkPOnmB+mXyN8jzsNxSflDpZl/p5VLachhORnZ/NXQOdxT2X5iZEFsNQ==
X-Received: by 2002:a5d:588a:0:b0:382:4aab:eb9b with SMTP id ffacd0b85a97d-385bfb1e53cmr6558642f8f.27.1732722839393;
        Wed, 27 Nov 2024 07:53:59 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm24795235e9.32.2024.11.27.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:53:59 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 27 Nov 2024 15:53:54 +0000
Subject: [PATCH v4 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-1-4348d40cb635@linaro.org>
References: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
In-Reply-To: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
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


