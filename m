Return-Path: <linux-kernel+bounces-442430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E439EDCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A94B1688C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D42AD21;
	Thu, 12 Dec 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JaR+0hBT"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7DE29CE5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964457; cv=none; b=dy+s0bun4OnePjCSvHV4aEOEFL4hnitA8FRTqzlD4Ho67BNu0QvbpLMlTmA+MuVTt2ZjbT+bbVibx7LrU5NSuvooMKNgSM2ug4tKuRCGyMN+amivpsDp2Bp8zGpp7LCmFlrz7F49HGAXh2ua/U3XiZQclIDV1SNMTYo7SyzO/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964457; c=relaxed/simple;
	bh=gI7279BFVBU24wfEPp4Je1wvSfa/qbfIzJF36p2a+iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re4OFblvhLO6bYI6u5wCJNIq+VlTuBawgwJEfOjM9Z7b4NNa8IBURMQrvq48ZvkogE1yJndmAsvYc6UYrLHEcp75jZzsqizW2kfBRrnPhCumHpqOM7FjiXzW6ufBQw6X4ar/QeYXhr8Sl1Pdhn86Qf71OABgGsbeVHG2QnSKeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JaR+0hBT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382610c7116so11106f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733964454; x=1734569254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mDzWrPswVqL2jIJMPNBr5jz29qiE8AhUOmE7OcegD8=;
        b=JaR+0hBTtMGmbIEsp+WxtNuDFrT8Kv9vNaNG9AwbBP6dYXDXZabiu4B5KFqzDTAgED
         /NnLUnDWHp5+dtbv067qMk9RuA3t3Ft2EljzBO846rJ+xTctrbA2hHOHpLN1vuf/pONX
         HR64ldA6sm9vI41rKCy44S6Vs31LCU5Gf177isG3XUDKny9b1eJbU8FGu0xIkc2X4Swf
         x4U69Rmj+J9cxogf/iU9mQ6P6JPpTL/JY5ICHJQcgKp5ZlCCt8SWHJKaUcQoGI9tzcpG
         8govD1HvrpuvkQ/biL2e3Qc0wrptgCLzMMZhSrGN+smg+UFXXj3hZX6P2dBNfrVAzWzY
         M2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964454; x=1734569254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mDzWrPswVqL2jIJMPNBr5jz29qiE8AhUOmE7OcegD8=;
        b=wddNFUfEZjNaHcsWol7N3nUzB+fTF6tfr+nZuUsfJWUIpZ3q50qehn6WRZpUq5Upi0
         Q4jNMyma0akwC93Ikrr9xZqhjIphe9uwvETvfVJHf+6B9IOzldAOD65bIIU8JLsb7PtU
         O5jnmFnyaMMWWU/4m5VVS3xhIn6uPlLxLUdcfu97QEAwlsNXod7/t1dVjOrfWR9LQFsU
         BWsO4sKnzYy/8AXVbwmAhCWsMCo5URkSq1tEVCYpUs1vlEwGVso6meVfu/VTEfoveQur
         lApcIIz9tMcqrLhu9/1AYupplAmJbg9x6xZQtA52ebcDzAVvJhQ81f8MOR43Tv7nxsgX
         rv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbYBpfEj6neOcsBs5oQ5/1ulRZR6Lg5po+xiEa100xETJNJHqPTQCQWaSRX7jjlxuYtOJ+908EVc2v/ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdcJMFWqtv9/qQJAAK2MWEiuYKTyMtIBxQqRncDwJBHoi3rDhG
	B6j3Wl05zoRJy63EfH4m5KgIplwUUMj/rpwvTXlaJNfHGp6ZkbROdI610rAOyZRjmOul7X0NnZS
	c
X-Gm-Gg: ASbGncvjdEnEejM/is85SHqT3vuiPrsrJuUUTa5uDInZuSKd+pzN4O+XfIQZgkN5fNA
	RepmbNoO+p3gAEAeyaKKy8ypChfTZXRkXyoCTuJRUFFnqCm4QGioDA1C899C5S6N1dAl4Epxw8+
	JQVRTaisT2VEhv2h0T/JsRS/4/HqiJ8oufi5o2onVsJA/y6xX22/buDpkhKB+2F0SibFngALn60
	ie76VEIzhRQzc+AZ+UxIK7bpSVByGydnTPRdFqYcM4xY2JacX+OlkkL4sCE1YQaJ6I9y/uN
X-Google-Smtp-Source: AGHT+IE7vuVokWsKA+OSg/kSc554NchXd8bbNr3lBMdwH/A0uq3kq3gqrXVPdiGpvQAMDioUQZG3+g==
X-Received: by 2002:a5d:584a:0:b0:386:4a0c:fe17 with SMTP id ffacd0b85a97d-3864ce602femr3957618f8f.27.1733964454139;
        Wed, 11 Dec 2024 16:47:34 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ef4sm2459660f8f.39.2024.12.11.16.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:47:33 -0800 (PST)
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
Subject: [PATCH v2 02/14] ASoC: codecs: va-macro: add sm6115 compatible
Date: Thu, 12 Dec 2024 00:47:15 +0000
Message-ID: <20241212004727.2903846-3-alexey.klimov@linaro.org>
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

Add vamacro compatible for sm6115.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index c781da476240..443dd4dd9b19 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1722,6 +1722,7 @@ static const struct dev_pm_ops va_macro_pm_ops = {
 
 static const struct of_device_id va_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-va-macro", .data = &sm8250_va_data },
+	{ .compatible = "qcom,sm6115-lpass-va-macro", .data = &sm8450_va_data },
 	{ .compatible = "qcom,sm8250-lpass-va-macro", .data = &sm8250_va_data },
 	{ .compatible = "qcom,sm8450-lpass-va-macro", .data = &sm8450_va_data },
 	{ .compatible = "qcom,sm8550-lpass-va-macro", .data = &sm8550_va_data },
-- 
2.45.2


