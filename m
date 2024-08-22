Return-Path: <linux-kernel+bounces-297680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3E95BC68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A111F24B27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F21CDFA2;
	Thu, 22 Aug 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYm7BRAw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0738F9A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345340; cv=none; b=EgX9NHNeIdMp9J28gNddtH9BpaDp53FK3lAMiR+H7A7MaPO6KXYiIz/1TkE4Y46txMMk6IV4iN1sNOnqqkbCSl1DIQ2mVEr3f4pRMAwPGC82Kuv4w6pXB3FletQOKOOSUb7WUhB9q2lR+yWQ4mwLXtawZ2PyvaptgjVBiyyJ4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345340; c=relaxed/simple;
	bh=7ngHf1J/E6UZCdoJAqPhOYaHMASi62RNsv+4T02DVO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8QMZO+aglHs9XGE7doL13Qjv04fW+XEbOoC9IYeojRJR1qkMof0oQyBfiPUmvP4230q5xHRclXlSPQjLscBiLFqCv3NMWmGHszim473HW85wDakDx6polycxSU8kC7ODEq0qWYjrm1mRxJQF382nnGXcxIyjBMSVVAEXclbnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYm7BRAw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280692835dso1816445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724345337; x=1724950137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/uPrqpj9NK/aRR9ivkQ1oqXqgAV9rXCTBKB3mCN+LQ=;
        b=RYm7BRAwR5CkQB3l/m7hKFnJKN0nRlDe4RjH2DdwTRLMj1DyhrKySKRT4mkIpDKHFM
         I1fezT/ADd8gAztFO3MByqrwZzoiKN0RSadf0NnuHrGzOK7Rvr1Qxo/MMNN0J9rOMxZC
         bB2C+ftYBxJw8G3LnwlX2lD1nwWjjMfxK2Nz2NO//Nu8C+hljLA6K2UqR34LFp/cxjgC
         BY+JKHyxo3mOZyg2BqIrdEFH7vleZ/jJ+gpPqi3tzcGYFjCRoLlsj7/tuUxpQEj+IwRc
         wjXYqEOB7QrIvoTTV9fz5rEVwNm0xZPwdoUf49qXN1HJl+pM4/fiOWSUcT/i7V3beGnD
         4tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345337; x=1724950137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/uPrqpj9NK/aRR9ivkQ1oqXqgAV9rXCTBKB3mCN+LQ=;
        b=w3Qs+V3M7Cnj/TQbu2uR6btFmq4Oj/wDgkwXOpl9hpAASJ4bDUu0dcGZyme+sZ/0I/
         lX7N+s9g3nmJGSgZXkNUdTKouU7A3cciyJZJGAoxYMJZXuTSW8DW76LWckVz21tz0LGu
         w/7ZldHJo7Lu2E1iBo8cTOgvTKvdQTzjhznmJMvodZvW7qiS1YAQtYEoAe4VTUgQqf9S
         vy5DZz9nUfqaWqTBM9Z4tNHXd8P5W8M9Nnf8JhvzZzLXz2dn/HIXvGpsEFe1j0++q3Ty
         DqB2SqF3LA8ie3ZXVIExwi/thQd+D1G941nt77ea0A6QsxvRhdeP6FSu6qQ91EYAteFj
         6/4w==
X-Forwarded-Encrypted: i=1; AJvYcCUcLPnkMmBf65lozuCpMYJ6thtFpJ56aGN49WNOy5du5M54+YR0PQlbrjld8NzA/B4i4e4rM8mC76KmlIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvlzoEn+YkFZElvtmAD7CrywX0v+A/KErK4h/ku3/PIAOiiSQp
	8nm09TFNrbYNyAH3hvHvKhkYljtgioYQgcohEExw/52Y4HcfzDFMu+KDDooTP84=
X-Google-Smtp-Source: AGHT+IFUODpqlZ8UTaxs48M78/4DVqeVEA2pz7iAWCpAl+BVIKgEuEHkLXgg2dsPoJkUiatJ7UoLvQ==
X-Received: by 2002:a05:600c:4fd0:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-42abf0f7f81mr29841885e9.3.1724345336612;
        Thu, 22 Aug 2024 09:48:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc627asm68062765e9.34.2024.08.22.09.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:48:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] soc: qcom: pmic_glink_altmode: simplify locking with guard()
Date: Thu, 22 Aug 2024 18:48:50 +0200
Message-ID: <20240822164853.231087-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 463b1c528831..bd06ce161804 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -5,6 +5,7 @@
  */
 #include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -114,7 +115,7 @@ static int pmic_glink_altmode_request(struct pmic_glink_altmode *altmode, u32 cm
 	 * The USBC_CMD_WRITE_REQ ack doesn't identify the request, so wait for
 	 * one ack at a time.
 	 */
-	mutex_lock(&altmode->lock);
+	guard(mutex)(&altmode->lock);
 
 	req.hdr.owner = cpu_to_le32(altmode->owner_id);
 	req.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
@@ -125,18 +126,16 @@ static int pmic_glink_altmode_request(struct pmic_glink_altmode *altmode, u32 cm
 	ret = pmic_glink_send(altmode->client, &req, sizeof(req));
 	if (ret) {
 		dev_err(altmode->dev, "failed to send altmode request: %#x (%d)\n", cmd, ret);
-		goto out_unlock;
+		return ret;
 	}
 
 	left = wait_for_completion_timeout(&altmode->pan_ack, 5 * HZ);
 	if (!left) {
 		dev_err(altmode->dev, "timeout waiting for altmode request ack for: %#x\n", cmd);
-		ret = -ETIMEDOUT;
+		return -ETIMEDOUT;
 	}
 
-out_unlock:
-	mutex_unlock(&altmode->lock);
-	return ret;
+	return 0;
 }
 
 static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
-- 
2.43.0


