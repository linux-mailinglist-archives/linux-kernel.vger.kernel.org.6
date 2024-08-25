Return-Path: <linux-kernel+bounces-300451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B038395E3CC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F021C20BB4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1F316C6A7;
	Sun, 25 Aug 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dlkb3zKB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C1156678
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595279; cv=none; b=gU/nnRNAU3JzyYVMBC+H5v2eYyJUCqBb4Qp5MiJCuUpYJYOmJeG8+EzGhvc02Mh88Omzcwri6Hl9pgcIyP3T2Py/tI5ztIFy+egtplHTxIJYWNBHc0VRsfc70st0UntBeDm8/MJW/lMrmGGvX1UgRatpVxThHirsTtLOjeeBbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595279; c=relaxed/simple;
	bh=Ytuccfgs9TsHyxm9hDxL6CEbdGnLEij+BN4ZXAevank=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efqne5IRBugQtjQnFG8T1Xg+8/FVQr4l5/eHKMDcYDV21eR0I+EGq/FTUPnliVeiGLMi9wyN8T2EJ4eNV0FQKfYFEbv+034IylpamnGdWT8yW11MYYW62/KuyQRJ/P3rXeeuTsg0PImlzE7A+epe90/vFEM6QyUqez5o6vnS1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dlkb3zKB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso5392105e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724595276; x=1725200076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgnZ6ZqZdmNcLaioI4ubaYNngOpE05oWSti+DXvBHck=;
        b=Dlkb3zKBBcbp/+D+dRvRXUHmwi0bnJ/HLHulGWx/2K8xO9Y3c7ZVbR55Y43Jyza+U+
         4rxcdEHnIVnX1ARHCPIyXOwgmKRBlyezRbSoEZswycTde3bUlPb3v7s048Nd5GrkOtTn
         r+04Fqv/6tnUpkUFB7ovF0sBuyw2ywRCpFyK78uSBB+ueUsE2dwIcUcTNnACI08eqzcZ
         OpWYC8Z6IssBO105TBseCaFnGS47htQ/4SJAiJB9PSHr4e2gFf505LqoljyNE7VanfBu
         bdXJdSm9C8DaUIayhCgipxgrguKMKlOyvokHvHk7687xUsewYeKx2WeceKQa1Q9XD3No
         K0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724595276; x=1725200076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgnZ6ZqZdmNcLaioI4ubaYNngOpE05oWSti+DXvBHck=;
        b=eDMa8/wBkGIre/tvAzEOix0S1mPTagMGDCmKKQAC5b3mHp1/FWs2TFRNBGsP5C4J3c
         t3/t8Aobg8ldtMA5fNvBbSeNK01DZVzQmHFw/TjDdkkyOQeiOC1ll/JmywVaX+Lerv+x
         T87hcSLqSuFZqYBhYba9ig0O8wsZThCrOTOL+u8DoY7ckjV06MDYF2kI+WHtRULpy0q8
         BUWmmYR1pu3tTgO0kPN6rfpPCr84ImYW9zDXnPoElf4pr/JLX6A9A81+3Mdcpv2xRMc1
         7oxBsCX+ZdSQyLTa4vQKDBQfrDvwUs2et1KlLyyqiQF+1MLAP9FjslVkJSqahO+paPia
         Yu/Q==
X-Gm-Message-State: AOJu0YweAvcyorGWX6lI7K5mO4wKQJmtRSi5my8VDwiEtc5pwjPKSaFp
	l/QOn40a8rtAD2Z/lp/ebkLkPM9X948nEJ/TYEiWfymWKHnrW1ht9/ZN3UxT9hs=
X-Google-Smtp-Source: AGHT+IFuxALm/fRk7IdAEl9tHnqRf3lkS/IQePpSj6npJhpr82rrpicyYF4ug/0SBMzTwrc8Ul4eLw==
X-Received: by 2002:a05:600c:46d4:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-42acca01063mr34147235e9.3.1724595276499;
        Sun, 25 Aug 2024 07:14:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162347sm122556045e9.23.2024.08.25.07.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:14:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 16:14:26 +0200
Subject: [PATCH 3/5] reset: simplify locking with guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-reset-cleanup-scoped-v1-3-03f6d834f8c0@linaro.org>
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
In-Reply-To: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Ytuccfgs9TsHyxm9hDxL6CEbdGnLEij+BN4ZXAevank=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyzxEEiERshJp4P/O36tRaMG3GnkMMvYxJ9g39
 bFAc2IS7BSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZss8RAAKCRDBN2bmhouD
 104EEACHYXj9r8WaYp2o9fRW7dCF85yE11j+zp1IjAWosumCqGUSVtaVcJW0o6mKFDOTGul1Wmo
 MGE7W1EzVXd2ZyZNNLAWa51uznABmwL5ZSkg+AyjwrZx1lfZXEzPZb+MKhf46k1xFZ9zoi0Onam
 AbtiaiV/t2b4em83210TuqxSqsc3eSpkq/AXPN82gw1cHeCNA2H46wvTQ8/rQnBB+nBvPwiaocj
 nmyC7d3OlrR/xjr7T1ulZN9Or0ze+vm1Y1EVBZ4j84sz/fwmxtFQBNmC6/81lInJ4OScRLCjQvp
 wlCsXhPQKhluGr0r2UOgtXk84h1kdik+M6u3yL5HNMK1QomVKwfFkFJaHe3UKbnedEJ1DhmJY6v
 /M1aagcB3QnKmvBfK4XUsgDMJldJs0jQgOxJp0dgd4oY4sK9hgojSs2m3lVpAe/YHT788A876/k
 C9gRgcuxs8Y2lK6ktL71UuVKnLQwHAOWimTwIDcp8rNJ6naGB5/iITiRkdBh1EC8VRiYrIK3CyS
 GXP0khpho7KVDnNld4Vu7c1kYdbGqm21HiJnuMCgPl/tX60dfG/NDMu0WxUNKYWnjz6Zd8OWvm4
 viMP4fPY4NQ+9emd1ZPd+/JbZEcBj3++KrIc7DKp/Ylzn1+ckWQHIdd/1yATfUUliOQ/kShZjZ3
 6L2Gi0ciWufsHyQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/reset/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index dba74e857be6..c9074810306c 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -916,20 +916,18 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
-	mutex_lock(&reset_gpio_lookup_mutex);
+	guard(mutex)(&reset_gpio_lookup_mutex);
 
 	list_for_each_entry(rgpio_dev, &reset_gpio_lookup_list, list) {
 		if (args->np == rgpio_dev->of_args.np) {
 			if (of_phandle_args_equal(args, &rgpio_dev->of_args))
-				goto out; /* Already on the list, done */
+				return 0; /* Already on the list, done */
 		}
 	}
 
 	id = ida_alloc(&reset_gpio_ida, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
-		goto err_unlock;
-	}
+	if (id < 0)
+		return id;
 
 	/* Not freed on success, because it is persisent subsystem data. */
 	rgpio_dev = kzalloc(sizeof(*rgpio_dev), GFP_KERNEL);
@@ -959,9 +957,6 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 
 	list_add(&rgpio_dev->list, &reset_gpio_lookup_list);
 
-out:
-	mutex_unlock(&reset_gpio_lookup_mutex);
-
 	return 0;
 
 err_put:
@@ -970,8 +965,6 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	kfree(rgpio_dev);
 err_ida_free:
 	ida_free(&reset_gpio_ida, id);
-err_unlock:
-	mutex_unlock(&reset_gpio_lookup_mutex);
 
 	return ret;
 }

-- 
2.43.0


