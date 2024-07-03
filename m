Return-Path: <linux-kernel+bounces-239146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99792571F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F41C1C24A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D73142E8E;
	Wed,  3 Jul 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAeYcvXG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33BB1420BC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999783; cv=none; b=oGP2Mrt2O90AOKQSJ4eC98YTw0CrGu15zY6m7pBUB6ydx48HX++eA7fpaG5hebq0FVOL9zOuIxa1VP+8dqXs2FoeymCNe2gNgmV8t5CWUvnsjDWeEV+M5yA2lnXLIaLjxydjZMvBhnQFh7CXV0KOkHy1Z4jj8PYOod3oF6veV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999783; c=relaxed/simple;
	bh=qpxrmTREuNaHHrdQzgu1e/L+P9VsCpf8GWp7U06TfTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcVeqXqQtR3THCSU6SmJmj4L6JtKxnapSBh0aFTyXHoF9qYk077JIZACHs94ddQoS6SzVsVQN+SoKyzITkAKM9ie5v6pRJ+/3mt6Z7xw/fogUHHEhhXm9MNmeI61I/lDaXUn9b5xz7M7phcGJa4sH4hiT4HKCVQsqOAW4vXHlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fAeYcvXG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367940c57ddso250509f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719999780; x=1720604580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS5iVDe1obLhEwpLoT+EWyyGo/TPfbyIkExLZDp79p4=;
        b=fAeYcvXGdiruT1GG2fnhiqGzviJIfwruiv6Ie/rwTiSp/wWz+p4oJbULIrqLe1QFQe
         30Z5+5sc12KBjJOonNbgHsGMHbb0MjkNY9W08LGH8kcseO3mMQcebGp3Dt5/ZWYSIXP9
         YCg1hWcOgiT6Fkj0boC7at91fIeQla7n+cytwZW9N1V6YtysC6j69wz19zPdkbjBN0qD
         WktVsa3PI7MP3b8S+z6p2tz0CUhNBcEEMQ8qiawQezH+xdTSd0zMsdrNYpHJAx4C0meQ
         HcZeG2yVnrP1XnC6YIzaWuFebpW1w4Uv9BrGDOrvqG7yyuH5HzUt/2Hm6pZ+nN3pdnVB
         DMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999780; x=1720604580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS5iVDe1obLhEwpLoT+EWyyGo/TPfbyIkExLZDp79p4=;
        b=XNwHRG4sNhpka7O4jaYhq6Dp1Q39WIJ1va8p3xY7MayvSZ5+4jLHTLeByJSbwTGr7v
         8Yx6aFP09kCX5D3IP3fDAKT4zeJD5w4ggIkpfD7x/xLTNkZ0KBLc9Vib5oswLhyM/MvW
         DV58Q+AGR/vVqftjKT3bMXoOCNuXqzaH5oUSTW2WeFhzL78x/h6p7Ba0OGEx1PUIfO8N
         4ahPZj4Kr3VVjKYh9zo/bdW0bUstP9kHRtAIRW75buCWaLL2nCuOQXK7tkwwQtJbpvEo
         T3Tmhdxe42ky33FBaLr1EvjUs4BqDNpUa9MVGMVGNDCU3tD2MoX5C7Pn9mDE5Gx7uANm
         Xvvw==
X-Forwarded-Encrypted: i=1; AJvYcCVHvesVr0KWVp5v1ZaZfM2yIYvYn+1BvkQAQKSqyOR85hVRpw3vzpJLucByFeLCK2mIyG/H/NR+fYeX6OlBOJwCKxQVhu68pMogHddS
X-Gm-Message-State: AOJu0Yx/fXFZNKcGXpcle7kt1wjeiqc34LPJDNK427iXUk1IMwRcetO4
	muS0ilW41FmQQLRhmXlkp6YCEl4si5zzBObuHQJAoKlKmGem8Evjh7hJauJYz54Xg/PLtQLBZ1g
	VdHo=
X-Google-Smtp-Source: AGHT+IGxe93V1JY+FgRSUXokHtoTw1Cnd90wqvUvteioTByC5F3kobDqHNkUL6qu4wdsVi0h/tayjA==
X-Received: by 2002:a5d:47af:0:b0:367:434f:caa2 with SMTP id ffacd0b85a97d-36775627d4dmr9358064f8f.0.1719999779823;
        Wed, 03 Jul 2024 02:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a1030dfsm15341394f8f.100.2024.07.03.02.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:42:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 11:42:39 +0200
Subject: [PATCH 4/5] soc: qcom: pdr: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-thermal-const-v1-4-6e59e139c65d@linaro.org>
References: <20240703-thermal-const-v1-0-6e59e139c65d@linaro.org>
In-Reply-To: <20240703-thermal-const-v1-0-6e59e139c65d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4629;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qpxrmTREuNaHHrdQzgu1e/L+P9VsCpf8GWp7U06TfTg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhR0agPr2ydUI703BLOJm92MpT5P4Ug9p19B4/
 V2j5arr6aCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUdGgAKCRDBN2bmhouD
 15HkD/4mPJtxbfduWCVlQ2Ud2+O/dfZBP1x5bFZbyQ1RIm01TwvHVpLPmzGTZPrwLaUcY/5CTIG
 t6x/P/bfHbewKwehMh+SPSydHRLs3eW4V/4HFx11hl2tOL8q7n+uzzfdp2ENOAWRrH4ZCt89BlD
 3LgSjqt+lvljDUh/Y1+Mn4DV3SJi8CmNPLparB899ityH6K45PNkipxKAAH6/s7H/78o4U+hdY7
 ulSNfkZBDbKEGrwwpFRMAfxzOebedteO14WgirJZf/wdOGFFEda5WmxlL1R0FDWg60S5omxi3iM
 bjf6rGVsE0hzeSP1S6c4JXQWrZI56rrNLsLQ7MWyqaRSaIf8JIGm5hi40q2Ltp6Syz+/cMSjQnu
 DOFH+cSTryBenzx+KHFrux+IQ8Mlo39jADLjGrAQBur4Hy6BmXbZbp5iRIEeuTSZla4ogjVrUQW
 wlajOYWXQkcv4/lzklWA7jAplf16b7Zkna6TpIC2z0XL8/N8wO99IQZV2khEsqGTixdxKBS2bVq
 LsoM+tPR3Uwxa216shRoNjAs64sgqEJKT3kij947i5vpCI1OlfsR/spQpcjHwpGkr2t8+ZR1Usn
 +d4l61vzAdn84/6/BlSnHiLcAOvtDqPCsRKp9r7XqY5P5F+zQ50bNHI0oo1T14aaFLf6LdzOIOH
 Wkx+gT6U9DC4gwA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling (less
error paths) and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/pdr_interface.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 216166e98fae..328b6153b2be 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -396,13 +397,13 @@ static int pdr_get_domain_list(struct servreg_get_domain_list_req *req,
 
 static int pdr_locate_service(struct pdr_handle *pdr, struct pdr_service *pds)
 {
-	struct servreg_get_domain_list_resp *resp;
 	struct servreg_get_domain_list_req req;
 	struct servreg_location_entry *entry;
 	int domains_read = 0;
 	int ret, i;
 
-	resp = kzalloc(sizeof(*resp), GFP_KERNEL);
+	struct servreg_get_domain_list_resp *resp __free(kfree) = kzalloc(sizeof(*resp),
+									  GFP_KERNEL);
 	if (!resp)
 		return -ENOMEM;
 
@@ -415,7 +416,7 @@ static int pdr_locate_service(struct pdr_handle *pdr, struct pdr_service *pds)
 		req.domain_offset = domains_read;
 		ret = pdr_get_domain_list(&req, resp, pdr);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		for (i = 0; i < resp->domain_list_len; i++) {
 			entry = &resp->domain_list[i];
@@ -427,7 +428,7 @@ static int pdr_locate_service(struct pdr_handle *pdr, struct pdr_service *pds)
 				pds->service_data_valid = entry->service_data_valid;
 				pds->service_data = entry->service_data;
 				pds->instance = entry->instance;
-				goto out;
+				return 0;
 			}
 		}
 
@@ -440,8 +441,7 @@ static int pdr_locate_service(struct pdr_handle *pdr, struct pdr_service *pds)
 
 		domains_read += resp->domain_list_len;
 	} while (domains_read < resp->total_domains);
-out:
-	kfree(resp);
+
 	return ret;
 }
 
@@ -517,8 +517,7 @@ struct pdr_service *pdr_add_lookup(struct pdr_handle *pdr,
 				   const char *service_name,
 				   const char *service_path)
 {
-	struct pdr_service *pds, *tmp;
-	int ret;
+	struct pdr_service *tmp;
 
 	if (IS_ERR_OR_NULL(pdr))
 		return ERR_PTR(-EINVAL);
@@ -527,7 +526,7 @@ struct pdr_service *pdr_add_lookup(struct pdr_handle *pdr,
 	    !service_path || strlen(service_path) > SERVREG_NAME_LENGTH)
 		return ERR_PTR(-EINVAL);
 
-	pds = kzalloc(sizeof(*pds), GFP_KERNEL);
+	struct pdr_service *pds __free(kfree) = kzalloc(sizeof(*pds), GFP_KERNEL);
 	if (!pds)
 		return ERR_PTR(-ENOMEM);
 
@@ -542,8 +541,7 @@ struct pdr_service *pdr_add_lookup(struct pdr_handle *pdr,
 			continue;
 
 		mutex_unlock(&pdr->list_lock);
-		ret = -EALREADY;
-		goto err;
+		return ERR_PTR(-EALREADY);
 	}
 
 	list_add(&pds->node, &pdr->lookups);
@@ -551,10 +549,7 @@ struct pdr_service *pdr_add_lookup(struct pdr_handle *pdr,
 
 	schedule_work(&pdr->locator_work);
 
-	return pds;
-err:
-	kfree(pds);
-	return ERR_PTR(ret);
+	return_ptr(pds);
 }
 EXPORT_SYMBOL_GPL(pdr_add_lookup);
 
@@ -651,13 +646,12 @@ struct pdr_handle *pdr_handle_alloc(void (*status)(int state,
 						   char *service_path,
 						   void *priv), void *priv)
 {
-	struct pdr_handle *pdr;
 	int ret;
 
 	if (!status)
 		return ERR_PTR(-EINVAL);
 
-	pdr = kzalloc(sizeof(*pdr), GFP_KERNEL);
+	struct pdr_handle *pdr __free(kfree) = kzalloc(sizeof(*pdr), GFP_KERNEL);
 	if (!pdr)
 		return ERR_PTR(-ENOMEM);
 
@@ -676,10 +670,8 @@ struct pdr_handle *pdr_handle_alloc(void (*status)(int state,
 	INIT_WORK(&pdr->indack_work, pdr_indack_work);
 
 	pdr->notifier_wq = create_singlethread_workqueue("pdr_notifier_wq");
-	if (!pdr->notifier_wq) {
-		ret = -ENOMEM;
-		goto free_pdr_handle;
-	}
+	if (!pdr->notifier_wq)
+		return ERR_PTR(-ENOMEM);
 
 	pdr->indack_wq = alloc_ordered_workqueue("pdr_indack_wq", WQ_HIGHPRI);
 	if (!pdr->indack_wq) {
@@ -704,7 +696,7 @@ struct pdr_handle *pdr_handle_alloc(void (*status)(int state,
 	if (ret < 0)
 		goto release_qmi_handle;
 
-	return pdr;
+	return_ptr(pdr);
 
 release_qmi_handle:
 	qmi_handle_release(&pdr->locator_hdl);
@@ -712,8 +704,6 @@ struct pdr_handle *pdr_handle_alloc(void (*status)(int state,
 	destroy_workqueue(pdr->indack_wq);
 destroy_notifier:
 	destroy_workqueue(pdr->notifier_wq);
-free_pdr_handle:
-	kfree(pdr);
 
 	return ERR_PTR(ret);
 }

-- 
2.43.0


