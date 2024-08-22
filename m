Return-Path: <linux-kernel+bounces-297681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4899295BC72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4BBB2A5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4501CDA28;
	Thu, 22 Aug 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSSlvxd9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84941CDA23
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345341; cv=none; b=lMZPgrwEeAOiOOY+LkP/dkl1Or9ga7Y3e8p4QMMFduiOak2JzanvDR3wga8zF+eFzCRtb74fY1gyb6FO6ZldYbZbGPVB9YxoOIdbxVg3zDaNTJ0wRU2gV4JvrYGToEZ2CYEg69csvZRUelqT+e5Z+JE9nb3o3E6AC2ZqdABi32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345341; c=relaxed/simple;
	bh=WORizGtRIG3wQEd5cKsiYTz4nE4FIsBA2fCtRinTt8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+eIcCGPRuc3HkA1z9XGqCuwckhCZDeGP2kRNi073WgpZiiZfFShNHyHODLC0BbmYmdQ/QOS07Ivu+30g6RFqDliC94n6Iw2MIO3KZQvZFmiCsxHG+zOZqc2MPUp68pZUTqzgyOh6kvzIWbCsSazEn7UJl0rSvtuuezE0XIVps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSSlvxd9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280ac10b7cso411255e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724345338; x=1724950138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jn92E/Ky5nVM/5+Oud+V0WsM8/cEIOvqMjdYQHvInY=;
        b=lSSlvxd9gvCBQ9o5jxKp1+6YE5EnVRa/7fSO5DyDbPwlqMNbAB/4vA5i5juy1Je/0/
         LqPwKr/YMVijDsgt4f+9GmdpW8x6LbNEerAD9/sJ5b4yJ7YwomYkxm1HhdyDxkpQnoIr
         WwD4iIZ42jASxk6nGDIEyomf7gFWH9T7jGLmLwdczmQV0B+M4MZUQ4QhxzwF+QLHc6/w
         ApVcEGB8C7hhg1kl4u4PQpbQWHyCGZEvUXaRPwKLpbMrCii1q0yuRlGfydmaSMXzHD9X
         N0r1RGaH2AYIAg74qDIKJ606R/nB9j0JfrBsxvuo0IAD99IALoIthRwehLAv5Blf5wbZ
         DqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345338; x=1724950138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Jn92E/Ky5nVM/5+Oud+V0WsM8/cEIOvqMjdYQHvInY=;
        b=HUGPCpOnyTX70EfyECo2RT0dKEaA8wg/YOrWqwn3fTdM29K/epLQfisJhhKE/cCKKF
         PxeFncyFeNFtgJKpoiriVId0RthqANmiUOX8U/GhSckUWA632w95VOPxax0gltt6RxyM
         1hVOMxH2YVkB/4v45H1nm8f9OcqYmZCYQP0Xd1DOKys13/jXO5zRTNjm5Xwg4twWWtx4
         Gz5d5cWGw/BY1f52ZfI2xU3YQvicvtD/4rcLVU7rUbwCjCa6liCYeys7kSkz6gQ17t+y
         R9vL2Aj5YzkgXiJdHdZae44V5OSHK+eeXn6gJ9cRmcBDKihSdW2t8OcPP9s69LiqHJMi
         Z8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW0rX0ZCHxQNAlOmeadm0Y7CYC5Iyu4WNi/DP9DA/rPSisiQQd2BWF9UlmfmxKmUtdgoT6Kgx0YwwvfLSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIh749oLTblcrrfV7UVNutjLDgojmMQgWO6TCVdvRrnjcOWk/0
	GfcaDPu1630fnRApOa/bVzvQe9GNk5MrBrjaoV5DkiOn9N8XTj/hD6k5S0BkUwA=
X-Google-Smtp-Source: AGHT+IE13RldnzB73YXRgRbQeFB3CKCAvtoKwuPbT689RQiJ/f5BtqH6l2grgU6Nryf3J7W5S5rBmA==
X-Received: by 2002:a05:600c:1ca0:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-42abef82886mr30936915e9.0.1724345338115;
        Thu, 22 Aug 2024 09:48:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc627asm68062765e9.34.2024.08.22.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:48:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] soc: qcom: smem_state: fix missing of_node_put in error path
Date: Thu, 22 Aug 2024 18:48:51 +0200
Message-ID: <20240822164853.231087-2-krzysztof.kozlowski@linaro.org>
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

If of_parse_phandle_with_args() succeeds, the OF node reference should
be dropped, regardless of number of phandle arguments.

Cc: <stable@vger.kernel.org>
Fixes: 9460ae2ff308 ("soc: qcom: Introduce common SMEM state machine code")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/smem_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem_state.c b/drivers/soc/qcom/smem_state.c
index d9bfac6c54fb..cc5be8019b6a 100644
--- a/drivers/soc/qcom/smem_state.c
+++ b/drivers/soc/qcom/smem_state.c
@@ -112,7 +112,8 @@ struct qcom_smem_state *qcom_smem_state_get(struct device *dev,
 
 	if (args.args_count != 1) {
 		dev_err(dev, "invalid #qcom,smem-state-cells\n");
-		return ERR_PTR(-EINVAL);
+		state = ERR_PTR(-EINVAL);
+		goto put;
 	}
 
 	state = of_node_to_state(args.np);
-- 
2.43.0


