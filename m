Return-Path: <linux-kernel+bounces-414842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73D39D2E70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA25DB3862D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC31D90DF;
	Tue, 19 Nov 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUJt1Odt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A111D90DB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041222; cv=none; b=XmOqECIr0zJJsuTGNv17jDq87hl/FX00Jxml7LkTWgkq/gtPZbc9mTWggfwAMVpHuP85hwGud3i4T6awGaNJCh1RB7oQf+WDpXI40MHVEXRBU2XwS8vnRnvenGEVCiHMRBm1LTTb6Dub24L9SbVd1imv6wb3gNNMQXhms1ThO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041222; c=relaxed/simple;
	bh=/16xZGK1B4eLSoXZt75MWgQkmhlzjbCUALoc2x5/66E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOTHXYpytk4JdCDZv1Q6UUUxwLylg24qWRgv25twN9SwsoFam1cK0e0mas0+osaf2Mjd7o2fO2eR1ndrfJUIX3tXAPZSsXGtCtSjmkofZ+RRdM4WspORt/rZb/A7sTLxu8SIqFTUtHgvyIRKlFH4fb9EUcs/anufgBsSxNQhcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jUJt1Odt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315855ec58so6464805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732041218; x=1732646018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ysh4eTWrTYIAWVaLPQ/SwS4fAOwEtQWE4oRj4GrDmYg=;
        b=jUJt1Odt2qbK5g3JrtC0I1UdYktoZ3lrm7evBeD3msqnNCWv5y6GT7B891U6Czwl0b
         Ys40HwpxcGRBWBiHpbn+lj7DTQHnnD9oILCB7a7GY3ZLec/dXNe/BY4mOli3YZPx9HQK
         /ogBqvOO2m5Qm2d70f4L64EUmFoIHEV3MD1rSTnSC2kGSHYvv+ngQahXsW5lEhdxLkDx
         VJPRC/LClK49hajwdTf2NPiF7wGMdI7qKLDgj3o6zYHJTgGmd/JK94fku6eTCLOVhPtW
         Jont1mgHWgL7H4gbIyZbrhbdHC7bC0ploiQdbTOd19CPTC9kN8px6QFMbuezHyYS7DSC
         /jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041218; x=1732646018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ysh4eTWrTYIAWVaLPQ/SwS4fAOwEtQWE4oRj4GrDmYg=;
        b=VJXXK1nng+3syXIW9hicAd76s/paDF3URB5qZnCVQX19vVLx4vEK6t9NFg9HEjastv
         /s0+XHDG0vO2XR76kpafrHeApMFUwTy57js40Mh0iD5fpFHyq0Syx8omGsPihWWQHqJk
         3nu8JCwL1lkWx/H4xNJOpY7QtSvsNetoF0/w0vhjTkGVxBi+67Edc6PAyK9VNyl7mDO0
         4kHBrhmodR86ZAk/YVULF3fS/QXkic++cUwGgz1FgFn8fvHHp9VnuzEO4693fJ3m42lG
         EukWnWTJjqNYcmdJges7JTJZqjmvdWkzEKAxqJFfIc2RbcwCBcEmXPkqeOulns4Vq3RG
         4q/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9oYxEoZlzFzVAqumGWk/HXYfCfHkE1OhlSWSFRmr2CKMGe8e4LsuCySXMGLHt1GbsyyAqs6/fCgttK28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1xPi6R8YpkxSS0bnuIYandffR58U1GYX9bigGo0af8ccPlc8
	6JFwkbHB2V8iDeq7ICe0uyyUhFh/TWP5necTs9Ap08z4uypd5jBmQU8275pvCIw=
X-Gm-Gg: ASbGncs8cErSp1PzQ0cJ0uuVOmpG5H2zd3dC3yLcwNwjGVWdKFBs0zcSiWsuBWEr0KH
	u5GN65drVHICWFnbfDVG788fqP33SA8+9fU1zPg7FHI7U88w06uYPXHlETFaiFSTIZdoMf6eRCE
	8IWMCHllCMu9ZHHtEzl7HyKE4OH0Ud5vZDKO9t7jaXIRhnNrDY94HfnvpQw7ErNfprfLaffK7kK
	6IJZnAi1T2yq0GFJveO8gqNTxWCnGWXKBg23Oick6wbFpbngI2ptXdmDhE5WRekiQ==
X-Google-Smtp-Source: AGHT+IGYCW73/Wi3BjocNSQs20lNIiT/tHi0fQubojntSw+RXjyxB5epjn3pJ6Y+leKtNvGu1KiIQg==
X-Received: by 2002:a05:6000:1acd:b0:382:4e71:1a12 with SMTP id ffacd0b85a97d-3824e711bf1mr1316633f8f.1.1732041218534;
        Tue, 19 Nov 2024 10:33:38 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fb7asm201566805e9.42.2024.11.19.10.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:33:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Nov 2024 19:33:18 +0100
Subject: [PATCH 2/6] firmware: qcom: scm: Fix missing read barrier in
 qcom_scm_get_tzmem_pool()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-2-7056127007a7@linaro.org>
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Kuldeep Singh <quic_kuldsing@quicinc.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, 
 Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/16xZGK1B4eLSoXZt75MWgQkmhlzjbCUALoc2x5/66E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnPNn5lMI//tlzXyB+RRWLAKe8iMjfIaa/xwb5v
 HV9Ygf+24uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZzzZ+QAKCRDBN2bmhouD
 1yl+D/9apEhYDtrWMlqfvOyzmxRwalcPLrXknm09drQTCFNRSomEq2G8y25kevpGbyg3V8yPcWh
 6SSd8Fc+9MDI0kLOYdm2ub+GbaSg1dhwgM7W3ph64mDuXEHhhEN0X0Fi+m5csFSBVGIYpIadqdf
 8fu/oZ9X6j04yoYUP79iA6Kphk3caJvfIUq7OZ0sDHvDOPuH90YmNommaRm+s0qltR+3cUuZdOm
 nyc66EL+OkkAxbYNPau1R52G69eXbgrN6NBQ6CHO2ZWZ74vm+YQf6n58PK+sMP1DAeGmKkal3RT
 8nVnn9OgHCmB2/IRxeo2yz/UjcQ7fZJboiezZ6NeXKf92obFN+28qBI8I235tejGk0zS+X49hxq
 sbYQ3PypmnFZSTbaDb89ueHTKLvRVYwkrQlplw/N1gzYw7peKzabnOBCzdPqcgpM0ru4wS1Ujh/
 jPeFp+JbULkGMUGx5Uvc8x5O8jaY5Gh5PBYlIUBQynfemKmLQrkVFLG9/+ZIsIesUMikAr999nS
 7nrVKJHd4YAXYq/lUJJeeen7di7PuEgfptsDhWWht/WZjYtAGF0G2pkD2keG+Zv3C/RwbUbrqlL
 ZycHj3Lrt07MGuNjeBc8g6CJxAvgT4Yne6te50UGcfA90xW5lg+KUg43yGy/Lcg7XHKCOabr3m4
 YJQpKRtTH7UkYTg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 2e4955167ec5 ("firmware: qcom: scm: Fix __scm and waitq
completion variable initialization") introduced a write barrier in probe
function to store global '__scm' variable.  We all known barriers are
paired (see memory-barriers.txt: "Note that write barriers should
normally be paired with read or address-dependency barriers"), therefore
accessing it from concurrent contexts requires read barrier.  Previous
commit added such barrier in qcom_scm_is_available(), so let's use that
directly.

Lack of this read barrier can result in fetching stale '__scm' variable
value, NULL, and dereferencing it.

Fixes: ca61d6836e6f ("firmware: qcom: scm: fix a NULL-pointer dereference")
Fixes: 449d0d84bcd8 ("firmware: qcom: scm: smc: switch to using the SCM allocator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 246d672e8f7f0e2a326a03a5af40cd434a665e67..5d91b8e22844608f35432f1ba9c08d477d4ff762 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -217,7 +217,10 @@ static DEFINE_SPINLOCK(scm_query_lock);
 
 struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void)
 {
-	return __scm ? __scm->mempool : NULL;
+	if (!qcom_scm_is_available())
+		return NULL;
+
+	return __scm->mempool;
 }
 
 static enum qcom_scm_convention __get_convention(void)

-- 
2.43.0


