Return-Path: <linux-kernel+bounces-442431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10189EDCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E3C283739
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3167912B94;
	Thu, 12 Dec 2024 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjRDvb1F"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B55288DA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964459; cv=none; b=Ut9zsKaswV3vXnwh8xPo7FQqe+sY42UF23sBdkxqvTikXkTMyTbg43D9WqXfmel7oV0mWD19Mz11FFxUl9S/tZlj0/nAJY41WFNRZ2Gd6B10B/7ohphKZHTea24MrHnW5rtzGfnASn83KmACuIh2IjtF0ECUuKXz1BRkOksi8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964459; c=relaxed/simple;
	bh=Jmxl411WFIZqWVvYYq3LtnoW5zZ2OdPhG9ySRHWVXfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edJHaBFpMry8flmCPFwryFmIGMeV5CTrSKRUj6XJFT+dPTlLeJMSpVMKiG9WIs8U9BKwGoVo4CwMizhTpvXKISaystaJcbrquIBSqLW031fR21DroZpEx+zyezwYIXZ8QmpOjwIM4KbGoMupL7t4AFb1VIRN8YKsIAM7pL5HNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjRDvb1F; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e87b25f0so785288f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733964456; x=1734569256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6kZLHzerZib3Tom9bwdP4TG475dJUZl/s7CFHt6iaE=;
        b=tjRDvb1F88wUHJ/B1IYOwB7PvHy/mJkMgF2zsbeUhIUU3nsIvflb8rzNEJUmc6P5/i
         1EIKwIk++vOrkhfXbb6aHgEa7+HKCcLHpKVW4ulVs+KW2z/xbXKi9jvBj2sIC+c8kPQW
         eXRSoT9zPjZ99r5shf8XVPDl+3KubEYtp7zZwugn+ZA6Zj5mgpyJNJlDBZ1M4cOMy+n4
         Xwqq9XoUVrs7jkk25L0FkfOv+lJaGULT1TSsEKBrVEmj8yIFiMOLVNzDqBw16A7ktTI/
         OcVYw0P6B79UGAs542zrBaIfoBPiUcjruhOnvcGMDB6AyAqYVIejxJz+/neu7c7i5fUv
         ugkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964456; x=1734569256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6kZLHzerZib3Tom9bwdP4TG475dJUZl/s7CFHt6iaE=;
        b=Y25rYcSdKm02n+wtwiuvvGW/dCvnAAtMcgoqy27ZeNehK2pTthKbquSFt9/MtGkj1+
         1lH3P/P3cEY24JMGkA0wmloGoDyq+aH5YudhgGNcLOOoNeq3TnIMJDPn3Wqia+sAzorr
         JjgKDQU17se6PMP3EeQSC/d6/K1jUts/ndyyb9RC/tuHxV3vqDKz0S/y7+WngbYfLRGh
         /yzV/gywgI6ywS76IDVC4pQQJIxoJyt+ktE5ZE+Oco/e/FRIiXIlil1OjBFsmbeJVeaw
         YiJez00QKwL8/nWbKxo/OU3YjriY413Hc7+OaubPNHTMQxAclCAx0prn5euimRDMkTe1
         zOSg==
X-Forwarded-Encrypted: i=1; AJvYcCUtQEz3aZ+uGCGW7K8A7H9l9kt47GPl2K2kHnpDkszgpOrx+e1TW8bH9RjDZKu7h5R9guD4t3G04aI0jLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCxmmuTs04PyJswmFLuOScxRiNL0MdhcfORc+gYmF10hNzSNb
	x+ce8Z1a1xKOjY3+dJ+iZYwHEu5ReMivyG3ltbZEHAcCpPerHpJdz0ByJ26J2Ow=
X-Gm-Gg: ASbGncsgKYjMp2lq1nnzQQRhtoHRTx+YP9tJOXJ9Mo0zNfGyyTid/Y/QZn0dPjj/56o
	ae0EtdWgmV33FUk2j3jAnpAImipAZWJucKXzJVy7RkZWkrpWbb9hkpmb8XY88KhGa8GZ8z9LR/x
	q132RmIT3NDDLDc0CXqq8d3FJzIJYo0gD5Sa5l6fDCAdE/mAkDVgaK8jIHb/mCwWXjmq7fn88bN
	VjQvrpNVJZAaYOf+XKj0oTJfTNFaac2H/q86FNHORKYvCRQS16wR/zPH0Rv0EcNQnDe+oh6
X-Google-Smtp-Source: AGHT+IEi1kamexVrbGthx4QEBUCr69JkP9/Hp4vgbpEuhKuOMH1s/oYcZgmQpyQA1HV0TbxjEV4tZw==
X-Received: by 2002:a05:6000:a07:b0:385:e10a:4d97 with SMTP id ffacd0b85a97d-38788825765mr825870f8f.21.1733964456279;
        Wed, 11 Dec 2024 16:47:36 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ef4sm2459660f8f.39.2024.12.11.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:47:35 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] ASoC: codecs: lpass-rx-macro: add sm6115 compatible
Date: Thu, 12 Dec 2024 00:47:16 +0000
Message-ID: <20241212004727.2903846-4-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212004727.2903846-1-alexey.klimov@linaro.org>
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rxmacro compatible for sm6115.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index febbbe073962..61c321e0f753 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3946,7 +3946,9 @@ static const struct of_device_id rx_macro_dt_match[] = {
 	{
 		.compatible = "qcom,sc7280-lpass-rx-macro",
 		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
-
+	}, {
+		.compatible = "qcom,sm6115-lpass-rx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
 	}, {
 		.compatible = "qcom,sm8250-lpass-rx-macro",
 		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
-- 
2.45.2


