Return-Path: <linux-kernel+bounces-297683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 568AD95BC74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44646B2ADEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7401E1CE6FA;
	Thu, 22 Aug 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTMttrZ/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCD1CDFC8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345344; cv=none; b=fR8Toyapxa6RHt26CWJJniudyedWQbQKE7ajhQ0HLmCWrsfO1AqUji0fli3TUDsaL4hemjQbR3Gf2hXuvKhx2FSfb6P7xALkCgBR4/6JCZBrlhd608quRhD3TjOjazbdnVn1t36u+f+G0oIZTor2s0bwxvFcOtwGZV8TNYo0fCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345344; c=relaxed/simple;
	bh=MevB+qQ6YIteof+ZP702/oPm06OBrbHOvjn8I+MZjr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8nAz6kR1ba9ybomBA0AY5Gn25ZtMY9VE28FB3KiSEJqw4WUziT4vfvbBz9NwZeo1ob+nSEbJLyOsWr5jXNmljhwbxyKuqYOTVSoOMQFAzL+a0QYpTRaGVSo5UL8OEu/0CoYhZ+T4ynCljqv7HJDCifjhT7+FZz+hYxoZqpJ+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tTMttrZ/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42802e90140so436635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724345341; x=1724950141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCSOOQBbc65Crx+eDy1f4bPe3yYik0noPUdHPZ2Q4cc=;
        b=tTMttrZ/W5ty+piNhJ+14ng9o0l8v9hkbFNXCoKxxiA+St3P2TMduGL7JrsTy/b3zb
         UxoMRf8i1MMu+kY4/SUoYc5pmtxMrqntljQQoMJ5jiIm95h+RCX3IwOjwM8JrPZgL2e1
         yD1nZAYc/KnDIbp6wFYbPMDqfx601d1srqXl5lDLxLAhBfnArw/W6fmhPB8Jmx6onp2w
         OiJtYyIVwUosNp7uBqZT6OFNLdgNimd36ab3xqMKlqPYyrNGEQ83Ow/OVJxw0Ys8IrdC
         b0o6Vzldc2tdSm2YDdZR/88Vu3ZLuGdATQmFepmCuuiiNE0Atj30fBJQFzrh9Myjq7Qq
         8h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345341; x=1724950141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCSOOQBbc65Crx+eDy1f4bPe3yYik0noPUdHPZ2Q4cc=;
        b=dIeNPumzWazb0Y9hCGiSCdCMReipY4Huy85+UUP80Nrm3fJoX3Seqac7gx+Hk3so/z
         p7GLwx2u5X2iy87zCGHfxvLEcKwTDS6b8OSY1OQhyzItBY8PFlkc69Zm2R4x14/XZuc+
         lH7JPXy4vE6ky8goMk07ZnXVcu9xSNnuNrKEJzPtGXHhifmsTwibJuRjH22VHeRsAUwh
         YJawKTeXgFfV1FsLsZpXyvjfnQE/rgAwrWDcwr+hdKzsomGJ7FijGT1wWa0tdXT+vhME
         34VNdsWcgq78JZA+qo4gacY5SN8uwlXfJqoieJQbrX6A8Fo3a63Cwnn6TLXRmBqN1SlX
         HQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU38vNM9ScWpXj1FRNgISAtEdrVONMG5ReuLlK5RPws6pImDqT5qeV3AA10K05vaADCv2zCuzpAJJVBfhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWJSR/kjHwAqC3YBU+is0veVsi2zoK/hlHfI5dg5x4FPuG9oO
	J5LX1EbmWQrgzzz9PXNsjYPp68PgMpNUPQlLVuefBCP8/uJlcAtI4cmi8L0/0G0=
X-Google-Smtp-Source: AGHT+IG+ji4y5pZk4uMPiZTqYIDcHBKI/EfdhUcrz2Rs+u3IueHjNPuHQ/B1l2iHyGoeSDwdbzApqw==
X-Received: by 2002:a05:600c:1ca0:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-42abef82886mr30937365e9.0.1724345340783;
        Thu, 22 Aug 2024 09:49:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc627asm68062765e9.34.2024.08.22.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:49:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] soc: qcom: smem_state: simplify locking with guard()
Date: Thu, 22 Aug 2024 18:48:53 +0200
Message-ID: <20240822164853.231087-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822164853.231087-1-krzysztof.kozlowski@linaro.org>
References: <20240822164853.231087-1-krzysztof.kozlowski@linaro.org>
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
 drivers/soc/qcom/smem_state.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/smem_state.c b/drivers/soc/qcom/smem_state.c
index a8be3a2f3382..cc5be8019b6a 100644
--- a/drivers/soc/qcom/smem_state.c
+++ b/drivers/soc/qcom/smem_state.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, Sony Mobile Communications Inc.
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
  */
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -60,20 +61,15 @@ static struct qcom_smem_state *of_node_to_state(struct device_node *np)
 {
 	struct qcom_smem_state *state;
 
-	mutex_lock(&list_lock);
+	guard(mutex)(&list_lock);
 
 	list_for_each_entry(state, &smem_states, list) {
 		if (state->of_node == np) {
 			kref_get(&state->refcount);
-			goto unlock;
+			return state;
 		}
 	}
-	state = ERR_PTR(-EPROBE_DEFER);
-
-unlock:
-	mutex_unlock(&list_lock);
-
-	return state;
+	return ERR_PTR(-EPROBE_DEFER);
 }
 
 /**
-- 
2.43.0


