Return-Path: <linux-kernel+bounces-297651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC7695BC04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6708B24698
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C4B1CDA01;
	Thu, 22 Aug 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+n4D59I"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A521CDA0E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344431; cv=none; b=thNha5ybmrDIrmGCHz5NyHWqFKdTH05RZlyyQYVlUnGTzK+IkHfoeElxxiYHSKXcyXzC+FBt/djWFN9D34uKzoOO0ErI9GEkzui+cptq8+WrsMaEsxzUKvgq/BV2reCIFZexb/Yx+rAsFqnpV67zmtZTB3uKqA1nzFydNUw8QpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344431; c=relaxed/simple;
	bh=naDm1RtTiN2zXIk2LJ0zsnhLTTN50E2lGQMRxqbBYAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlAxcY64DbWFMEuZ4Tq1lOTMaFk4Oe9rEp94SJwbzHxxSRCsHbI0sCGmES3fR+98Js0v0pnEDEc965bGZvsa+JTYHEmdHOKfEBo27QbtExAr7+lAUmtTnXFW2F3bkgkJ6JXIlN2fX75kY+HwmsZ/3547gPgFAAwszRhDbeALKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+n4D59I; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281e715904so1006035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724344428; x=1724949228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTFuV6stQx7CKFbcUpz4unCbxA3iNnf+lqvoGhhxAkM=;
        b=Y+n4D59I2HB+AV7hE/UHEWDaBT9lqkund6rGWosa3Bp2hO46mHtyUhBK/n8qahj/jJ
         m886iUhAS4IYH7b0CnEO/w9Yb8nVXHsId0c00Ipm9jb+Sp5IXcY/4prFWz46q4SC53Hi
         U49xaRGMARU27zQU4iqixAEyhrreAPP7v1jHA96tUzHDpLbBhRhEO4iaVF3Cav2ywI77
         85msSGArG0De5nBbixJP4v1ToKgcQOLzz1dprlCu9e2lnRHGdv6UXqSe6lyhJaPMeF9g
         1RdelEwOnx3uO0MG7IkwSHd0ISb8ppnekjBrVNw6ku1TIdSHFhDpXlcnEBcYj+muPgWe
         q/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344428; x=1724949228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTFuV6stQx7CKFbcUpz4unCbxA3iNnf+lqvoGhhxAkM=;
        b=RlaM+vgJ7ThPeamYauWqhqjTOGeH1xlioLvtKcdbRT5NiIYo/jJfk1SSc+g9l+8hsY
         mcUtkP3qQDTmO9Md3bUhzGSBJyU4tIhUKXvsNbFpZCJL8S9iY8qlCfUfQRLZdL3CNVQO
         rLOesGpRR1b+8EXsX32widVhkDxDz312wJ+gCs4xQ07rLXMjsSuLGf2mFvQEyjJjFKaz
         QW+EB3A8DkV6g0OOIIQSrFom0pa4uhIuO7s1/UnKMPdAy+iZPsK5JJIgHWogqSP6hCqG
         0dgEwwr+ZtWEm24RojNRKA4oLdksKEg+dQL8xSytqBJYure6N0atIWIcOb6oblxtuj2B
         FMuw==
X-Forwarded-Encrypted: i=1; AJvYcCXbSsgaI2G3OHopJEBWC4uLwX1wb2NbKf+bZTkWjwSfhCPD2K/Ojh/k8Ub/n/qhR41A0HyzEvttWuH1mYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBupG0qMFKq3SGAsoZlUefUkC8qVxZ9pE4/2iEaIKndvxBrVH
	gJhpEL0w5olgeH9lNSCylbOidJadyP7P2x/tz21a+dRRfiV4YYJOhVJ3uDNiUEU=
X-Google-Smtp-Source: AGHT+IGvJ/iD05Q3C/AsOQTJKor76DdYYeZaTHMvrsybklOWmJKd355kURal8Tjnr9MKo4Z1wI636Q==
X-Received: by 2002:a05:600c:3c85:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-42abd231427mr29419205e9.2.1724344428442;
        Thu, 22 Aug 2024 09:33:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813cdcfsm2069377f8f.29.2024.08.22.09.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:33:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: pmic_glink: fix scope of __pmic_glink_lock in pmic_glink_rpmsg_probe()
Date: Thu, 22 Aug 2024 18:33:44 +0200
Message-ID: <20240822163345.223787-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File-scope "__pmic_glink_lock" mutex protects the filke-scope
"__pmic_glink", thus reference to it should be obtained under the lock,
just like pmic_glink_rpmsg_remove() is doing.  Otherwise we have a race
during if PMIC GLINK device removal: the pmic_glink_rpmsg_probe()
function could store local reference before mutex in driver removal is
acquired.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 9606222993fd..452f30a9354d 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -217,10 +217,11 @@ static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
 
 static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
 {
-	struct pmic_glink *pg = __pmic_glink;
+	struct pmic_glink *pg;
 	int ret = 0;
 
 	mutex_lock(&__pmic_glink_lock);
+	pg = __pmic_glink;
 	if (!pg) {
 		ret = dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
 		goto out_unlock;
-- 
2.43.0


