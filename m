Return-Path: <linux-kernel+bounces-219644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674C490D5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC6E1F2063B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9AE15ADA5;
	Tue, 18 Jun 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0iOTl0e"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA215AD9E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721751; cv=none; b=i+fuq+HbMpFnsX29Lf940Wzpm7jR4jhR2mX+2sS49DcMRbuyZP8Xaf6ivbbFJZIHRj2lYkXLwHjJyXl/M2xYtAlUtBdYAMkGeHtDc3G4W+g6pzbgGCecnCxsWu1nE2imRouoJKFmrtKgXMgiisnrtVqwB2ltgP47g3iBl+6MHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721751; c=relaxed/simple;
	bh=WWxKwf/arpUungYPOcs5Jw+SlcDPaH/hTG9JTBj39dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TeiM1y/Fz53qBL108W3Bd7pGu1By4IAh3ON54kA57tN6TR/MVq1ejDuSEIfh2QFPvXwO+Xrs8uVVEJhQIWDBzSrD1AkL5mjeXJY4yL/ZaS1wHHFCDeF5TRJgzudHHEGAd5tLXDpBqIi5nWEeqnJQ6ASws9y0b9X02vrYsjrVOag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0iOTl0e; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso92778881fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718721747; x=1719326547; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRrjGPDAQCR13Q8F1953shfkW5IRb02NqVysm3ok23Q=;
        b=r0iOTl0efb/8y9vnaZbNwqWyGy31h/kUe0hn1YMzOI6P6h1tn5hQsrzBr08rCZoto7
         kqU4YyTJUY9IA06qXM+HUe1Cn+UGL9L2ogDy8lLhZMxh8VdGSJ1tXjPCX8Ec4NY69ZX7
         FP/OuSKMXLsva27owzG2uFNsISmSozVrzgwotUjec3UlOUXHO1LBRqYVnx3B84xG/NFB
         4yyTCbAL6yYoNFL78WksPmAexJxZBJTk+q2jkYqrTEPm+q3SRqyBDZvyu1sUcrm6yKfm
         /D20zdMCVL9BjuYq6NMpKIHpOzUJJ0uu1+vWi2ZKtz7J2BZ7QX92vdnx86R4B9HMghcP
         ABtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721747; x=1719326547;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRrjGPDAQCR13Q8F1953shfkW5IRb02NqVysm3ok23Q=;
        b=jI4u0nFiFgtbSXQgH2F2nXfEZ9Hsc+fBlA8qbzQ1TE5B3cmtkE7ZEklCueMlrVnohm
         nQrKLETDbc/EWx2xLTxXn78o3cECRUcplEDUQM2v53wFUXOk3OY1YIfV7toTmv/ZY7l5
         Q21MxUP5bv+QEwMRt9AYF5qvLmC4NUHZolJ57wu579P/ZiH6QBPSNgkX/UBpqL2OoDJw
         FD87jw/avQ/Qpj9e0DF0/65l3e2+oto+/AXEUDU4UMIvv3KLgw6IAtWbpaHe+rNpQTHV
         iLi/BykCBiagn33I6LlNEujB4tKa58iFSC4BYzyOGGL3uVfM7hnHxYKz8d00dtgdYuVq
         qxuw==
X-Forwarded-Encrypted: i=1; AJvYcCUM8Ecm1Zmz67ap9FF9uYAavNLtbN0dOVu/gojVmKals7yqa0tdykJdS6Neod7ANJHlQYLGAYEVQfH8nK+/MTlcnNff1rYZQVdKOVP+
X-Gm-Message-State: AOJu0YxkvXJkLVlnlyiRDspiHarP+Pd1kNgMv6oNA2b9+o+I+Gb5N34i
	UYzcFNT+7b/aDPgczhmCBbfJbWr/4XQjMcUcLZGxUlbrWdA3XOjbs23jFkMm0GA=
X-Google-Smtp-Source: AGHT+IH7o/2iW8adDQ1VcHtsTbecxJYYHAumInUcxMuFH9tZghs6xo247QAp1+jv1PlSXADfOnLe8A==
X-Received: by 2002:a05:6512:1056:b0:52c:ba7d:f032 with SMTP id 2adb3069b0e04-52cba7df104mr6159501e87.16.1718721747492;
        Tue, 18 Jun 2024 07:42:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cc477f19bsm263673e87.224.2024.06.18.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:42:27 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 18 Jun 2024 16:42:18 +0200
Subject: [PATCH] interconnect: qcom: qcm2290: Fix mas_snoc_bimc RPM master
 ID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-topic-2290_icc_2-v1-1-64446888a133@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMmccWYC/x2MQQqAIBAAvxJ7TtiWqOwrESK61V4yNCIQ/54Ec
 5nDTIbEUTjB3GSI/EiScFbp2gbcYc+dlfjqQEg9Dt2k7nCJU0QajThnSE3e6sqIjBZqdkXe5P2
 Xy1rKBxhALthiAAAA
To: Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

The value was wrong, resulting in misprogramming of the hardware.
Fix it.

Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Closes: https://lore.kernel.org/linux-arm-msm/ZgMs_xZVzWH5uK-v@gerhold.net/
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index ba4cc08684d6..ccbdc6202c07 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -166,7 +166,7 @@ static struct qcom_icc_node mas_snoc_bimc = {
 	.qos.ap_owned = true,
 	.qos.qos_port = 6,
 	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.mas_rpm_id = 164,
+	.mas_rpm_id = 3,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_links),
 	.links = mas_snoc_bimc_links,

---
base-commit: 76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc
change-id: 20240618-topic-2290_icc_2-8da9da970e0a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


