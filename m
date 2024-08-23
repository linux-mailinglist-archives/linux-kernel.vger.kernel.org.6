Return-Path: <linux-kernel+bounces-298900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D035095CCF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C561F22462
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A2188907;
	Fri, 23 Aug 2024 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFJg2L89"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E7188928
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417503; cv=none; b=S8gqusFUjiHuXgdb4sVkZKrTcdOWiGMncx3MQD2mksZugGJLUs5KtvscJCkiDx+wCBZIvZcSZsRSH8LHhUJpgBjKWLugekXWDRmlJVtg5EBqW5agjspZ3zHB+x9WCDmjaxNNxn/v9bFDj2DEbLEU3JTUsisi6y71DNzZHMdAp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417503; c=relaxed/simple;
	bh=y0QBIaJnf0/fSVbWVB0Xkg+ZYq4xy8XVXKh8rGpZrnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJxkLXYrjI1O50Nju8XXiyZFlqD0OBIQYDsT8osCSjpfI0RHtTFPJy/rfcNHqzG4i7zNRkVz+oiiTjgk/F+Q97Rm4VbjWhFCq24QQDZ/mCMuCKXYGreh3gyNhkAWB2vM2gYGoELuMjc9bu2EXZDW2BL7LsZLc8o6imUgvGw4aR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LFJg2L89; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53345676179so392101e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724417500; x=1725022300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPH0zYeEKEXW0yb0C0QcNli7uy5nXQcT3Asm3cghOnA=;
        b=LFJg2L89T2yzhyrSQIoObccQYH1RCmuCK5GRHwgKKPZXoQ5mL7RLL99bp6eJ6aZ4Xe
         OjlOJLkUrBEeyx8kbzrWUwOf9EymQ9j+8ugmkPj1WrFgLFUgoLdi9OW9BSCOELmEM9NZ
         1jat9MdIPBTBOqEZAYNYuWYDs1oRZMAOMKbQ6LkNgrjVjMT+gJVMN66Ll0aXjfq13MUb
         mtbUnB1zr266xv0CG7cLaZtsZjMvQ68M/W59zpdejl2/gJTHvWFXsC04CeqiDnImOFa5
         w8l3QPsbNgtWvSZvyc1m+lte+QdujeSLB6CHwypvGF33AVj3QBepEM2gn0sdiNmz5F/6
         2iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417500; x=1725022300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPH0zYeEKEXW0yb0C0QcNli7uy5nXQcT3Asm3cghOnA=;
        b=mJUKcajlz+YYYp9Vgp9PxXBjJTkfswK/OkYGQEuxLwmpFUvqQ8eR5TMHYA1MLXIVDc
         Qew6Spscqtvg16pVPSpUOgCX0Ul50O3TJwyQEWER+W5ePhh/mGYlTq5wb1VAlEkzWgte
         tpGnIPZmWW7AyiXsbuA4hJVqPSxcmuq4piflv/zUC8c4xUmbOYP/oeVHLBgWKjuuoh6q
         VghOykWyFyhvGPuMOjYFqRa7Aw73Zd2EmbLWsJC4dSDcuzJ4u0mol0hY+/umr0GSh/KY
         HqpZO/GRB0E3U+j29q6HdqD67REvFZ30vhkPhL1wdsBlL0Zs/9TFIhkub1mAO0aTiQSv
         3VfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1ciyKFXvwR5BRKf/MSogyiFmoZYMHh19A9hN3QNvryCW/V0vQgwEHojyqIQF0Pmq8WkivtyJZwL+KJtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjXJUsMLbwAsGXJA9+4lK0u5vupHjmBB30PX4j+u/2Czg3XTG
	6arKdumtkGXM8Hg0QjjXgE5jYaH+aFqDA3kvhxmLpaSIaN3ZJ0osSkBu+fXlPN4=
X-Google-Smtp-Source: AGHT+IEx9QTBZ6Ig4dC6hFm6sSZWyp2NrZPz8Q5OQ6LiyVq1B5Hos95uvD5/wXcqZMFiFAQUCs44Kw==
X-Received: by 2002:a05:6512:ea8:b0:52f:cf7e:b1bc with SMTP id 2adb3069b0e04-5343876c2a6mr830569e87.1.1724417499775;
        Fri, 23 Aug 2024 05:51:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f384bsm255931666b.192.2024.08.23.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:51:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 23 Aug 2024 14:51:11 +0200
Subject: [PATCH 07/10] pmdomain: qcom: rpmhpd: Simplify locking with
 guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-cleanup-h-guard-pm-domain-v1-7-8320722eaf39@linaro.org>
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=y0QBIaJnf0/fSVbWVB0Xkg+ZYq4xy8XVXKh8rGpZrnE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyIXK0zZ4ZGoxkalISx0Oa0HQbALLrTngWax7j
 L5WXrBsTjyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsiFygAKCRDBN2bmhouD
 1xawD/4+ne9u+0w9Ge4yGMtpLBPqws51qJWUNwZocPNFdFCwDtnWIBM/MFNMy6G7mVaitbYRu8S
 NufmqYkj3DXtJ2sKLwHYQ+wbGJkH2CKegDUkrberoehE5ecSQYeq+L8IeWTDwZ9t/8rORPyEAn3
 0x+pkG6t7Pup4fVh2PrYBqNBLimMVjnwPz/u3f9Da+qwY2cQzBoPcqDso2D9mBwsquclFCwEpQR
 RWeucQ/vUYJtFQqNxObOMA/GEDW+JSHCT4mD2CN1z1T2ASa0Co/ordw0ZJc4WuU4KjCZk9xq9Dj
 5GPBqEWzwt5f9DxLtaELBbhsyGQLEa13QryylbpEhT4Ax9ArnWkugphkF+OWJ5ewm8g5uB5xEqR
 KoLcKhf8VO506EI2bhmXkAW8+vnZmUMVyHnFQzvkDEeI7IjHYozxMcG8iYb+/3HEhwyZOL68qBx
 32uk1Gw5Yu5BWFddNZeihHUePRt4KK8NHdUfvtPQiHYylFkpEFwViCU4s3Gwuz1A8vDyFBVWvfZ
 KzAVDDXyVLMfYt/VO5iVeN4dwHtmPf9xQzkIIwd0gDwPKgC062VVJVqdTysn95/R+LPN6zp8qej
 cO2gtpfnk+e8mUL7UlFd3ZonuKOUmlacOqS2E1+zGdH5umSfmjMv+B2cyoGRXy7d/2Gac7Miz36
 HqfXODj1mLYdYeA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/qcom/rpmhpd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index d2cb4271a1ca..65505e1e2219 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018, The Linux Foundation. All rights reserved.*/
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -775,9 +776,9 @@ static int rpmhpd_set_performance_state(struct generic_pm_domain *domain,
 					unsigned int level)
 {
 	struct rpmhpd *pd = domain_to_rpmhpd(domain);
-	int ret = 0, i;
+	int ret, i;
 
-	mutex_lock(&rpmhpd_lock);
+	guard(mutex)(&rpmhpd_lock);
 
 	for (i = 0; i < pd->level_count; i++)
 		if (level <= pd->level[i])
@@ -797,14 +798,12 @@ static int rpmhpd_set_performance_state(struct generic_pm_domain *domain,
 
 		ret = rpmhpd_aggregate_corner(pd, i);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	pd->corner = i;
-out:
-	mutex_unlock(&rpmhpd_lock);
 
-	return ret;
+	return 0;
 }
 
 static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)

-- 
2.43.0


