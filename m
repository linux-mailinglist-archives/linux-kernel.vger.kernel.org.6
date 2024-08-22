Return-Path: <linux-kernel+bounces-297682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224EB95BC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513DA1C226B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76B51CE701;
	Thu, 22 Aug 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5mOcWZ4"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250631CDA35
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345342; cv=none; b=bq01ltoBcON9axcoZT8mSDImS2GRvlqZeb9ebfr+dVSmhsze3Oje5e/9xZHWY/FbQ4bPyCDcyrnZj9zifEyXUHLwYtZs4VF5TOd1dLtMGMX99DqraQ24TeO9JjU7XKozWLa1yANtOu1zXTHP1lX/UJpMsOwStIFfgeuhQ92F+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345342; c=relaxed/simple;
	bh=lgvrJ8aoF3ob8PNfM19iTWrPg0RJ64p0xDquFgIO/Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fD2oKHSKqiYhu0H7ZiS40qj6U1uMVVapHUnCScFsr8oTpA/fXREp4U/LZwLv+8XJgo9We51Q1dNCY2v5T5tiKrF3EnPlykiKKN0egBsOZo9mXF7Bgxhk+tLmqFqDvgIknLdpgEp9TXFHCRo9ychTjVSXSBvCglXbOir1NAlP6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r5mOcWZ4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280692835dso1816535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724345339; x=1724950139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MgKIFP5vj9lpxOte9EHXKK0r0k7d1Xhr99VIevfK64=;
        b=r5mOcWZ4v9eYg3gr3GJT5uDhgwhYDOMCxCbBtp/gG+XPKWoM4Qj+xtfFGq6UI8shPA
         Yc0VfeklFcCWOUc614tW8qRU4QeNPw62b/c/d6emBB7a6YV5nHeIZ5jV2zjL0kWv8+O3
         csk1zax+r4aQfLINB/wpR/6wO6NC2BcQRB0X4+t0y55ddUACV3Yx4D2r2xzbUoS5JdVz
         JZ66vRTqMZaw6JtoyujPOogV9shu3FYon+vm3Uu35j6k+PQFZ55BqH3JLIZHnSIN4yK7
         YcjjP4rBYQgGR0N9t8RfZPFBT8D+fn3ta/QSoK9NbdMK4CZRcSOy2b5GiOoowM3eqRhr
         4S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345339; x=1724950139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MgKIFP5vj9lpxOte9EHXKK0r0k7d1Xhr99VIevfK64=;
        b=bgRYyfsiQdR4wBhYZLys/lpHS1Yt6vhIqutduNHMnYNV4GWImH4NGafaylbJIk7iJy
         +KQr7WgO3euTk/eZXqU6406W9m7BNhPWp8ZLH31PAyqmGBfGqC9TwsDhVkLWxWp9WqYU
         ZSYwI3+PePjSf/h4/Mp/ysp2V+IrGIJohp3lf4hThbonw4QXwc3xrqtvyqaAEN3N8z2v
         ZK3ZJCS8lzFaDIkbtdetIau+h84lz2My9PTqpfFa1GbwwzG9fzc1N8vVx1QMHeRyNFws
         nK9IamKwiCb3Tq808OOZru5Oioz8of54bludW8471GJ0a95N8inLtdOX9gl3HuHVRvcM
         eUog==
X-Forwarded-Encrypted: i=1; AJvYcCWBgC6BXtkDUp4Ue8cDNYvgebUGZtAAvdadoiQFh9UpOffbvKobbGNNnuSx6rvw0KQl+LoFzX9B63WDAUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDc/DL3fEDzJeRaHw/5CqwGrQReGV6tZDjBKnGop5gFPZQmcD
	TavKH1rid+d+TLjrfZ1iVrtFfAOuZjrgoprfAUW4XQk7w9G5+VyHitdIvDNfzXM=
X-Google-Smtp-Source: AGHT+IGWgVVW8NGHzfRv3h4x5tYOjc7g3TUO+7XqUYxknVGhDDe78fw9e2Lh6zARIA6ofN88ls2hrg==
X-Received: by 2002:a05:6000:1fae:b0:36b:36aa:a14e with SMTP id ffacd0b85a97d-372fd8291b0mr2693229f8f.8.1724345339497;
        Thu, 22 Aug 2024 09:48:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc627asm68062765e9.34.2024.08.22.09.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:48:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] soc: qcom: pbs: simplify locking with guard()
Date: Thu, 22 Aug 2024 18:48:52 +0200
Message-ID: <20240822164853.231087-3-krzysztof.kozlowski@linaro.org>
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
 drivers/soc/qcom/qcom-pbs.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/qcom/qcom-pbs.c b/drivers/soc/qcom/qcom-pbs.c
index 77a70d3d0d0b..1cc5d045f9dd 100644
--- a/drivers/soc/qcom/qcom-pbs.c
+++ b/drivers/soc/qcom/qcom-pbs.c
@@ -84,16 +84,16 @@ int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
 	if (IS_ERR_OR_NULL(pbs))
 		return -EINVAL;
 
-	mutex_lock(&pbs->lock);
+	guard(mutex)(&pbs->lock);
 	ret = regmap_read(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, &val);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (val == PBS_CLIENT_SCRATCH2_ERROR) {
 		/* PBS error - clear SCRATCH2 register */
 		ret = regmap_write(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, 0);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	for (bit_pos = 0; bit_pos < 8; bit_pos++) {
@@ -104,37 +104,31 @@ int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
 		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2,
 					 BIT(bit_pos), 0);
 		if (ret < 0)
-			goto out_clear_scratch1;
+			break;
 
 		/* Set the PBS sequence bit position */
 		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1,
 					 BIT(bit_pos), BIT(bit_pos));
 		if (ret < 0)
-			goto out_clear_scratch1;
+			break;
 
 		/* Initiate the SW trigger */
 		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_TRIG_CTL,
 					 PBS_CLIENT_SW_TRIG_BIT, PBS_CLIENT_SW_TRIG_BIT);
 		if (ret < 0)
-			goto out_clear_scratch1;
+			break;
 
 		ret = qcom_pbs_wait_for_ack(pbs, bit_pos);
 		if (ret < 0)
-			goto out_clear_scratch1;
+			break;
 
 		/* Clear the PBS sequence bit position */
 		regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1, BIT(bit_pos), 0);
 		regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, BIT(bit_pos), 0);
 	}
 
-out_clear_scratch1:
 	/* Clear all the requested bitmap */
-	ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1, bitmap, 0);
-
-out:
-	mutex_unlock(&pbs->lock);
-
-	return ret;
+	return regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1, bitmap, 0);
 }
 EXPORT_SYMBOL_GPL(qcom_pbs_trigger_event);
 
-- 
2.43.0


