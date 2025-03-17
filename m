Return-Path: <linux-kernel+bounces-563209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E106A6390F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB493AE18B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113E15C15F;
	Mon, 17 Mar 2025 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwgW4dxD"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9E14AD02
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742171992; cv=none; b=nd+o1TsEBmwKNpP8EE783Mh2rTdMxymZ+fBS324spnN035/+RD4/x7TOg4NbKwwXNUEFMG0F7zQyp442cSskyz7ZgbWZAWmktd0xVGSUd4SKkvRfYQDyX9eQuZ09jTKBiHG0cRo4IUl8FFqWBkCpLAhpPNyY8G5384PXzmhtogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742171992; c=relaxed/simple;
	bh=xI8NEGU+/vOVowktJFplHlwmCPwO6Su0nn2Dpzy9ADE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ippUg/2IdYGPG17Ew5v7yY0UhL2WdjyQt7zRZZS75pLWpFOAhXrku+mWP1CbAYkfeF8w484+TBJrY4c2nKHpbDUjW8C4l9PbNEC3kctYmx2+geWfaUorauTxr4KXX42xeXtx6DDnnRuRfttsuqVJImn//Vq1Fegh/IrmYw031SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwgW4dxD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso2941987a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 17:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742171989; x=1742776789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTwjuKAVPDFwywDGvwuXvBGY8agm/8D4s3lYkbuf/68=;
        b=dwgW4dxDF+giCyGeXOSUDreZyh24J1wwO4BvjZifUPRO9VDJLse7s4ombFqDgswKgb
         8cKLPBvEohcHc9dui1TKnX7wgmHyqkOISp27ts87Ph5JeNBluC7RRWJ477Ty3+romS3G
         L4NMLXkDsTgT4FThjCQdgafoz/zdiEquVycZgNAq2ZI2JRMSRRv7+CeIge+cJSAiOCQ2
         bCSb74Mxulpf5kRVA2xVYxaqshgCGhyGrNHxpV7ZLzLsNZmY79DExvOKv2ot8oBnKc8B
         O18FSpej0eu5UZcNf6KKOlV0jnkdt805dF6bs6gr8YK0eK+hb/24E6TFxfcSnsFyF20E
         DQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742171989; x=1742776789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTwjuKAVPDFwywDGvwuXvBGY8agm/8D4s3lYkbuf/68=;
        b=s7d80MAfagiqm4FP2GmYSqjTjuKJRxtFMSGO2wqkeveXXcL7qS0GNX5slm+aLOxCHf
         YzDU8puZ4NjUvet0j8acHt847IkuonTXCtTCYTRz/PApKfXWOQ5NMM36EpsXS0hSim9R
         2voI0fY1xAV2wU2HPNtigIiTohQ+Vcrpl47vkNu9ai1A8+GyJswTgrHQ1/sj5xBaxjFD
         aK3vme+t/gjM74alizVDy5M69L3cQcRjlOwH8DMRt59cx6Z3uGUjCxQccPI5NI1BDZ+S
         ty2IXgkfs3qKtI9KV+0nYaEZGh6ZNNXy8bGz4kGbk1dszXFq2MV/1P9nh0sDqh8mlKjw
         PcOA==
X-Forwarded-Encrypted: i=1; AJvYcCVFJt7uaFUcqCkh08v1jOUA/LvplF/CnyLeisnu8C9vxfcUnTvC7HmPhkSwMRVVvKwktJr28nqau8goUD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKUF1STi2tKzNp6CnuF3KxsepnqAXtxX1osesXIG815GeBz2U
	wCbO0HCgcy74DqooQVUTwUe/BfvcllSNsRv9Jd18OxudRb4Q97+Kd2Q3uj4aT9g=
X-Gm-Gg: ASbGncv7O9uEdXrkUScdmIRlAtsOWkmp3XOeEfg4qsu6aVfRdw/nWNTWHJipTXCXl8d
	Zfwb19/HDV3OvIEYDO5g4FR9rPktMWi2KZKQ5m2MtCV7DKstT24bxTDDHhT5zHA8qBvS2hMaMW5
	SQ7rlFOf6ZQWP2h23uPZYFYNMYvl7eWDFYq4eydPDtbtQwYpY6+9sCPbaVXI76qD7i7saSIgaNH
	c9a4QBs39tzgGx2VXXW7AW68FPAll/8ctEdfRK5MEClnz94F52zirBsI9o6Vmnp2cPURJS8qZsj
	b0LkgjvRAtCVPCLpJBhswA8/KrT80/mUAxim9aR90MLdmVgiUL41sg7hMWj6c3K7STI9RL7supf
	IM4Y5LqBXUXnQLzyVU2u/tP9+fkWq/BPGC3ny14xLjzRDJuYvoJvtOD2mgpFQozeEM6+J
X-Google-Smtp-Source: AGHT+IHuPF9RmLSS+cmRMvKhsL6P3ptFy8EeFpnvckAhRdDHOi6nF7p0bB4TaCKF/ZRiT1JFMASrhA==
X-Received: by 2002:a17:907:960f:b0:ac3:1b00:e17d with SMTP id a640c23a62f3a-ac3303dc6dcmr1028421966b.54.1742171988774;
        Sun, 16 Mar 2025 17:39:48 -0700 (PDT)
Received: from [192.168.178.107] (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefadsm562407166b.8.2025.03.16.17.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 17:39:47 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 17 Mar 2025 00:39:38 +0000
Subject: [PATCH 6/8] media: i2c: ov02e10: Implement specification t3 and t5
 delays on power-up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-6-bd924634b889@linaro.org>
References: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
In-Reply-To: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jingjing Xiong <jingjing.xiong@intel.com>, Hao Yao <hao.yao@intel.com>, 
 Jim Lai <jim.lai@intel.com>, You-Sheng Yang <vicamo.yang@canonical.com>, 
 Alan Stern <stern@rowland.harvard.edu>, Hans de Goede <hdegoede@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2

The ov02e10 specification says for power-on:

t3 = the time between dvdd stable and XSHUTDOWN deassert
t5 = the time between XSHUTDOWN deassert and SCCB ready

The power-off path in the spec shows no required delays between XSHUTDONW
and power-rail shut off so power-off is left alone.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov02e10.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov02e10.c b/drivers/media/i2c/ov02e10.c
index 9ad70671a718ea0aaf80ad3adcc5738ee57a7ff6..40c4d3ee36e3e2a0bb8be3ff10d016e2bb9bbc9d 100644
--- a/drivers/media/i2c/ov02e10.c
+++ b/drivers/media/i2c/ov02e10.c
@@ -579,7 +579,11 @@ static int ov02e10_power_on(struct device *dev)
 		goto disable_clk;
 	}
 
-	gpiod_set_value_cansleep(ov02e10->reset, 0);
+	if (ov02e10->reset) {
+		usleep_range(5000, 5100);
+		gpiod_set_value_cansleep(ov02e10->reset, 0);
+		usleep_range(8000, 8100);
+	}
 
 	return 0;
 

-- 
2.48.1


