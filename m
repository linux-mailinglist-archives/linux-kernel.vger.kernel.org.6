Return-Path: <linux-kernel+bounces-381285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8759AFD20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BA6285637
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867B1D31A9;
	Fri, 25 Oct 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMpf72f9"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A41D4156
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846183; cv=none; b=ZfLbrbPDnwfsN3kb94PdAB1mcZIRY2tVm27XWrzhyfVyPMrwn9kTriorjrR0R3LcuogHblHrcZ8xtVQalEZ5jbjzkwHxB+8TE0T7j/q6nQJ/Cn6qEgwpffS1ZA+Bj3pXR5DKvgVbXw36A37LS5KFVhhrrFaiF4t9HoqbNd9v4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846183; c=relaxed/simple;
	bh=aau9tHQdt9wZfJyHUEPe1kivtOWbrfV8zNWTFTcZKWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+VZ2SvE/NdQPT4WW/dWuoD52lNX1wOKbyYI1+kDWJtYfAA1xJwuUs2FeFHekIbImYFZEzvYCqKJxn2+pNCubMRZKUOXSUeAduQe3GhwIdCbSDxWVlp2Hgnjk4KH4kseCAk159sz5uBMsHgFDh+MCNQfVgSBynCp+pnahgvyxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RMpf72f9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso241347266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729846178; x=1730450978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XRSl2o55vfrb48RETkbbqxxh5qcFIzkT/BgKsAMc+pQ=;
        b=RMpf72f9JutizRtLwkpsxhqx77JEdt/egoolKNSKwI4xtvLvQzIWMuQWQqX01ZScUk
         pG7QPwsQJmq5FYxW2e99tW1o3kRcSwMEoLklcuWfPAfXHlhHhSoUJPoXMqpA2HRWwwhv
         S38C8NX5wXdwODMWB3/VHiYEHC99AvHNpWFfviUY0ldU08i+AyxuKe+IihFxTLGtW9Hk
         ojpb3hUkPF8cX/JK4mn6BHQ/zSis+HOg0aFzFJWL+bTrvY6KWmAH5WHRYAsIItSyXgcP
         0MswGKM+tS/o7MW3oT7buDvIgv5OVaobzOSour530t43j0JnNF2Box0m3ZmydBarDrmQ
         q5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729846178; x=1730450978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRSl2o55vfrb48RETkbbqxxh5qcFIzkT/BgKsAMc+pQ=;
        b=fC3O8o81tSUpiDHpMc/ccU8Hc9ZfEkGdCbAfdQ3fUhDfPrWzJmaQBUz8FlR3jkBOUK
         uPzbd8Q6k9jrRJUMvtZEANy/xeG3MOj7nkH8LfZq/EYd0glKMDrdcR8uqBPxY7xGSKpI
         9w6/OPXnQv8d8Nk2Or6CJsdwaHhxHI+5N8gxXYemaLTCD/0Z3+Ni+2l982cOUshAnYTq
         6+sizYgS9zRaQjuJi5pBBb/KBIMQb0XNnirjCDrqvvItIICaQBu6OALDK0jkrVmLri4M
         Sj1ZhwhphhvYa9qN2UZF1ib9DOMjWageB+GPzL+IJY+nsZsu4RU/mQ8hgCdtnnhKC+Yr
         mUQg==
X-Forwarded-Encrypted: i=1; AJvYcCWA04h74dW9/f8lMLja2mio+d0XQnyiyhtQDDunX+z4jQzKbgGmzHW59ja0iYXFfhPKZHcH8/9sP5jSSNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfVoMtcSHwmTOpy45ThUL21GrEJhRGHnDcf6RcvsR3y5Y3qAE
	9P+Ykt7flCTTWX7HFuwvIAC1V07jUJq2UUEplxv5rKZIE+b6IqdpS50xzkb+lsU=
X-Google-Smtp-Source: AGHT+IH9ZdtLJ5fZe1Y5a4P61GN5i+jcRaNICf0HquXA+YJ3XftacRglhmQflo/dufsfVPRQdzlZRQ==
X-Received: by 2002:a17:907:7f15:b0:a9a:7f84:940b with SMTP id a640c23a62f3a-a9abf8458f3mr868712066b.10.1729846177765;
        Fri, 25 Oct 2024 01:49:37 -0700 (PDT)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b343d2652sm44066666b.181.2024.10.25.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:49:37 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org,
	konradybcio@kernel.org,
	linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] soc: qcom: Rework BCM_TCS_CMD macro
Date: Fri, 25 Oct 2024 11:48:23 +0300
Message-ID: <20241025084823.475199-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reworked BCM_TCS_CMD macro in order to fix warnings from sparse:

drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer

While at it, used u32_encode_bits which made the code easier to
follow and removed unnecessary shift definitions.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 include/soc/qcom/tcs.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
index 3acca067c72b..130ed2582f37 100644
--- a/include/soc/qcom/tcs.h
+++ b/include/soc/qcom/tcs.h
@@ -60,22 +60,19 @@ struct tcs_request {
 	struct tcs_cmd *cmds;
 };
 
-#define BCM_TCS_CMD_COMMIT_SHFT		30
 #define BCM_TCS_CMD_COMMIT_MASK		0x40000000
-#define BCM_TCS_CMD_VALID_SHFT		29
 #define BCM_TCS_CMD_VALID_MASK		0x20000000
-#define BCM_TCS_CMD_VOTE_X_SHFT		14
 #define BCM_TCS_CMD_VOTE_MASK		0x3fff
-#define BCM_TCS_CMD_VOTE_Y_SHFT		0
-#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
+#define BCM_TCS_CMD_VOTE_Y_MASK		0x3fff
+#define BCM_TCS_CMD_VOTE_X_MASK		0xfffc000
 
 /* Construct a Bus Clock Manager (BCM) specific TCS command */
 #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
-	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
-	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
-	((cpu_to_le32(vote_x) &					\
-	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
-	((cpu_to_le32(vote_y) &					\
-	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
+	(u32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |	\
+	u32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |	\
+	u32_encode_bits((__force u32)cpu_to_le32(vote_x),	\
+			BCM_TCS_CMD_VOTE_X_MASK) |		\
+	u32_encode_bits((__force u32)cpu_to_le32(vote_y),	\
+			BCM_TCS_CMD_VOTE_Y_MASK))
 
 #endif /* __SOC_QCOM_TCS_H__ */
-- 
2.43.0


