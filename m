Return-Path: <linux-kernel+bounces-424925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860439DBB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3863163E56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EAB1C1F06;
	Thu, 28 Nov 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpk1cOwp"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1651C07EC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811891; cv=none; b=O667sP6D9LJVndjLOOZwYvpiCiVXWpjq3wjeGSy4Nje/TNsiz72sa8Fm+6CIf+uBwJrTm/fS+CyEpKMHJh3UeVn4Faxnc80ZrBoHtYdYJPF8uF5aDBstinw72kvCZmyfMvuyXyjDxXpQPfPD1ZB0nsDN+/Sv6EfRh4Jx4riH1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811891; c=relaxed/simple;
	bh=mQpHD0O/4DmVLloEpdEHgH89jVyxadWEyw/hKsvGyhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHJwXHi8oLykbKn/y7YXT/63PAphd0vvi+GW0IIkr4U5c4N5RKnA3YjkzyZsvTTEcl8kG79jjDp9vF3yxWKBr4cXQF+VRBl8fQN8Uzfq+gnWM+Ryaw4igvON3Qae+RfsAX2DWzluT6S7hVYrt/6UoFAPI6VDhUndUWNXTEHot2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lpk1cOwp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38248b810ffso802374f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732811888; x=1733416688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=lpk1cOwpdxBjD1Ktil27Zxp5XzPBNhpj8hVSXIvfzY3+10ziCMv0Ec3lRuXkXEhSo5
         6ygS6H5j5fa0eaK09VlZFODDYfGKemCrnFrUjjhrJVqQwjgmuk/u1jcmlduUOIFjCeW2
         hL3MuR4TkBtoVd/jim/oNe6IUKWuIa7rNIGV9IYQeozqicZ+YTkvaUl2P4bhWPIWykGY
         Nezt6ZQLTIGLmbL6gpObPbnxs/plSjhhGAVNyQcs7ReH3NTX9sxZyoWt9Xm24RXhylb4
         N4/OsDxDTnTYN6kwFTxpVtd3jbMnBVztzDms3VmiCQbA2vQ+ntCXne092nkptm377D6Y
         auag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732811888; x=1733416688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aPv1A/6lNNGm3pKHhjnN5K2Ej+6bunOS3nenFEWG4Q=;
        b=LFeYb9/41xWlJQ/O7rqnN4akKaHUOIsDNYrSDxra0PgFbDIZH68UEoVoD4K2bnv0IL
         MW4M52nUcB4+Uy3k74wtYzCpanvTsOlkDjexfTqJLuwl28uvVW7ttHsSjLgUbkxv4f0M
         GNWj1yrdsXLAXwpx4SGMMUtKTKDGV/YlY7+rza1vwoECI8I7tZwZepjm9nr56E4aEtfc
         dLrvvi5I1F81K2xjLOx19dMqOAxZot5cI59c980HO9JfSl81Myog6oyjDnAeedUOKVSi
         xNzfNhjcyBW0dDJuwQswTt/UbGD0FCdotBggyU0Tj6jc6P/KtlMnP6zh8fn0N9Gib3Z5
         gKew==
X-Forwarded-Encrypted: i=1; AJvYcCVTuCytNHIU119+R11Fxqt17bLMRBSor4x9MgjX9iV7g37+JSKIdk79uGp8bv6s6jktort5bCgMj4Fx0BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9axj6EP7Lw89O8PGrg8KuRCDOQ+qr+rvS/H5M9TtpmXx/XWh
	JgV2/1W48rCkIjLrpITEXumEm9MFuXxZYLkxry6pNXajoac/ZtVNB7+y1001EfNrpq0eoSEHhsb
	q7S4=
X-Gm-Gg: ASbGnctBS3wVvNZpoT9fSCs0W3cS00z37kttN9KG3fXGEMt4C+ZcQXYRmnL44QZUGgY
	Rb1pUKaT3MlVyl6EC4JOJvd8gKPgTnEJqihN9aGtf4O11XLDSkPmZKkyooHREtc6hM4mV0Si83f
	kBKAi9j2I27BQd7rvrud/o+4BhWZ6mJkl19T/BzjVDjW9BQVBMlWkNC/cWDJc1C87IxfScMZm2D
	HJmLfiRU5Offtmil0oU7EOdUvxBiH6/TUkrWHmpfwkbcW9+jXZZcNvD4ys=
X-Google-Smtp-Source: AGHT+IFubuteqggyPtPqePz0DzUO88xCM2UujedDVDd3qIVP0OzH3a8fKyNdLCe9TkJ43xBopue/pQ==
X-Received: by 2002:a05:6000:2ce:b0:385:c8d2:efde with SMTP id ffacd0b85a97d-385c8d2f096mr5146870f8f.48.1732811883199;
        Thu, 28 Nov 2024 08:38:03 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78c202sm57990155e9.26.2024.11.28.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:38:02 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 28 Nov 2024 16:38:00 +0000
Subject: [PATCH v5 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-1-ca2826c46814@linaro.org>
References: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org>
In-Reply-To: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org>
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


