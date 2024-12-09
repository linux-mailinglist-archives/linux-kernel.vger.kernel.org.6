Return-Path: <linux-kernel+bounces-437421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B289E9309
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98111885CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3A224884;
	Mon,  9 Dec 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ml5HkllS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40F22258E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745392; cv=none; b=GVBhQTQ/cY66jy+N8Dv63K3DE5x/iyNn2Jz6QgYVLe6Ur1yDKwm3rFDoB7zyR7pepQqP4dwSLvmFfH8jekv9u3u1/Kv0xb8QoFkjg1HBlRWDPsDiudGbByDkrQXdUJDDHvgkQaJh5DSvvOHqPWWEnvTyeLmAbZdcWI7Hkdwfdi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745392; c=relaxed/simple;
	bh=ysL6WTjrVc7FAA8tQN5UDR36z9EBcMk7yq8nQKkF4tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEZAtIoKdRSaAr2eiQhh6+9O62fbfWXudfMpRq42E0xsw7tPPlkB04WnhdfSmdsBFBsNUDUeXUlQ09DeQP1Kzy6K6CKDfEHJvVt6pPmQMvN+P3Jo5mXAMdgND+bzFgT/8RtDMFI24CKLIK5zz+UiFE8uz7eVVIu3bt6iEtSOOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ml5HkllS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6647a7556so35161466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745389; x=1734350189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8AVtYyZc/IWaDoxx47aL1vyovDYySo46TxvDoofEG0=;
        b=Ml5HkllSsKML3UxIRbTk4t0xHlRkRt13oMa0SYnOCcdDcNEw48N6rKOGaGBmESGfl2
         MXwk0RznV+JG3tp0J0ExxBG4OEHbYXMkIw6lFSAtF9QBNpAms4ss6G2GHOYo+QEvWWdN
         vFFMZ+vgX0+5yKONr9P+ATEA5cLnUJiimvqeo0TWko4l34sO1I89bDelrbM7/4p2yZ2a
         Dvggz71W/2I2PA5FMfiXcTVtr2BCnGnEn2Rbpm9q9prSOE7TgHZup66xIQxCiIptk2rl
         m0N+hd96yyEaVzyWm+js7NkTo2NdZ2Sbs7a8Zrt25IdGWykNwHmgEmV/zkVjhRNUL8tm
         fj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745389; x=1734350189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8AVtYyZc/IWaDoxx47aL1vyovDYySo46TxvDoofEG0=;
        b=Yn/v4zTFToyhA3i+XVHnUXXCAQu+LnXvhQPwBb7AuE3OAwVzfP2nCE6zygWWTZ4Ap0
         ubLhSseT+jCLeRoTxlawDMQGHOz1GZMREqwCkAAMv47s9frHrmW6TdTnC+zIDzbc4qaA
         JCd7D/xvaY+Dyt2MlrXwIshhcZ8fJB0uL4SXGDZViQKWlLA5v74apQ3tlQ2uswTfH5LG
         C33i5S6AMgr9MpQblYHYqsQXCYtazPqdeRzpZspLRo3vg1uYt0eVMRmvBr4RDQktfGKL
         eeJUGWJqvKptf4dO+KzvAOC1gNlAlpAPZ4wm/qzNB7/GS9KyNAUKdp2sRM6SAS3vpDZB
         jqew==
X-Forwarded-Encrypted: i=1; AJvYcCXcVJ5OonejEc/e5ChlQSxYEIdWtKEJxwFodZSAxiJUT/vOC3sZ4XkYJEo4iqjOqya+j2n55Dm26GElQHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgyLKNtPC7hlKWAW1UrtVr9ob97AY+11UOTrbHwOUPMUJcZrXz
	zSw0fJaZfEUXuPDyRRmINeSfKzACkGSB5LlXBtHZ17cBVFQlfuKlU/mAO0UzaJQ=
X-Gm-Gg: ASbGncvx21+gfTFe/aSwKjX3g7AtZs2ykJCuU2eg+AlkxfovHhybonJ+1N91uAjMUzf
	bXBw9OU1RsumIWVDkAIBLFn/5lKtoIMTIWD4YlneMocEj/WwCnZCcNCS0HI86PAoO+RDxh3sfLc
	rtBmlGqDDMEiWg/sXj/jJWP1UNtnMNXgjXMxv49t0+6bUgaobJAmxot1mSEMUTFoDWqIL/8v3/L
	DKyfP/M/VyAwTlXQ59xCI5VDM/en0BxkBz7ojk54mk/LS/4TG/yHVkBlLoftizp
X-Google-Smtp-Source: AGHT+IFbt50n/X6rA/A5IzwmfbG39lpIfZK4JXG7TIUfY7QQd4Ox9JNG3Mk49+rANy/9rD2YAGFw6w==
X-Received: by 2002:a17:907:2d27:b0:aa6:2d35:243b with SMTP id a640c23a62f3a-aa63a025088mr531709466b.3.1733745388194;
        Mon, 09 Dec 2024 03:56:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6651c01c5sm343333766b.23.2024.12.09.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:56:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/4] soc: qcom: pmic_glink_altmode: simplify locking with guard()
Date: Mon,  9 Dec 2024 12:56:13 +0100
Message-ID: <20241209115613.83675-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
References: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
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

Changes in v3:
1. None, previously here:
https://lore.kernel.org/all/20240822164853.231087-1-krzysztof.kozlowski@linaro.org/
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


