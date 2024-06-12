Return-Path: <linux-kernel+bounces-211879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE29905846
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1CC1F21A41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F121DFF0;
	Wed, 12 Jun 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wiCYv2x2"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE522F0A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208945; cv=none; b=pw9SP0yIJHQYAoktEQit630jUMB2M/CG6XY0CQW56KBtR26nTdrpg3oKX9ylE7EqRYBX5SxsCFGvfZGPBsv3RFJqbAQzicj4L8doMB1BrHsGkIGRoY2S552VrlPFgZkPto29IPAZfOjLfLBO+1TOsna7t4JGkP2Nt/Z6ZNNk2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208945; c=relaxed/simple;
	bh=S8W7K+CbTCWOVMiwjDUJ4bB3I7rUO/YpjtJH+mZNADs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PJuCo7d7i3STS400r+4DMHM1ZJ8gNaEp232DOQr6IzBRR03K1QnXUEs8yYcq/9UIbO73fep096ZNmJkwU3BZeTiUJAcDM+lQ3wkk//h9jxhwF+sENYP8LWnuuvfjGCo22g9yKOGgcclfB25/qywbY5ZrwevfbLkfnm+kE0PqVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wiCYv2x2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f04afcce1so7706166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208942; x=1718813742; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoI+mpU13JCyzG8g8jngPvrXKHq/j3BN7+6DsbOktX8=;
        b=wiCYv2x2bxwA09pUtBbj01RoXXKpk4C5nrQFrdgpyyLtnflAzbSClP29vuGa09jS2I
         z4NTkmOaMODPZ+yhBCBeHEKk6a0/YJ6Fe5MO9PoltnsB1lpPYP3gwsqoMwcigS+c1zSA
         7YIli4aAcpqzkNEPzEaEf2Z0cBzRFH7xWDkJbt4wmA5cHlaapj8c2mcKyDtZtmZH6Ffw
         VGyhgWK3jMkBqwm8zp2RHDw761P4pCV0iLCyc+FR0R36EfgrLGzf0PPW1yMU9hzYzYTh
         rKA+GYk6qjOWK01AtLQ20na+aUY9iPvOIRubJIPsLwDPoB990XSBaYa/H0ZkNrR4WN5W
         ffHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208942; x=1718813742;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoI+mpU13JCyzG8g8jngPvrXKHq/j3BN7+6DsbOktX8=;
        b=urrIEYCkpCQ+3zHPYnd9/wnIuPmyZSkOqy3a9AhX/pKGCfvIlLfhJgxFipODg8gJWY
         fK4OYIHiDrh8Nh3ZrU95mEKiKkz1a3ov+Nz6ucEXnXOKd803PKh2AgpTNMPYggpM2OuT
         c+4qAI4CTI199qHurXn5R/wIWdtDXC2xtG2lpeG3+cl+IUY+WIwDsYY72AtdHxlexcZ2
         8p2YNhspvz3kI4UIxkL6K6mIIrET631hmEhbgxqZlBatLdlhnqiz7TwTRxt5eJzMr12/
         ynZUFb56eRo43rixhTK1qU1pwUyLwPq7lsOTgMMoMzWLnMk8F75uBs7vfMmUgJXkAXPT
         k6dA==
X-Forwarded-Encrypted: i=1; AJvYcCWAaSTR+CCONpnq1W35GRWeZD0+7NzeRXIfbD1H7YLDUNY3+y9AK9S6CoFrbH1M+iS2KyJnSl+0L97v+4zFnK8EQonq735UxFCKSIma
X-Gm-Message-State: AOJu0Ywrfbwu8NiFuldNUdStHasGGSJpH8/yfq8WIYwrqC8m9pJmFlOl
	ArlWgAyqmchhlIKpfD7Q43zHXRjdbcHFf/7jZvIaQ/OVQTZH3Yf/N6ElItHOnIM=
X-Google-Smtp-Source: AGHT+IG86zbnTALGEKGr5DGUHm7Yun4FREYBEDclFkXp1ilvu4L3gPQ5D8xASxCJCIUVoRly0RH4MA==
X-Received: by 2002:a17:906:b18:b0:a6f:529b:9f26 with SMTP id a640c23a62f3a-a6f529bb0d5mr682366b.5.1718208941896;
        Wed, 12 Jun 2024 09:15:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/23] ASoC: codecs: wcd family: cleanups
Date: Wed, 12 Jun 2024 18:15:13 +0200
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJHJaWYC/x3MQQqEMAwAwK9Izga0iuB+ZfEQ06gBqdKgFsS/W
 zzOZW4wiSoGv+KGKKeabiGjLgvghcIsqD4bXOXaqqsdkm2MF/s+pYSXekFehcKxG1JDNPXcete
 MkIM9yqTpy//D87wOgz1qbAAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=S8W7K+CbTCWOVMiwjDUJ4bB3I7rUO/YpjtJH+mZNADs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmUy4ZhwcsNN5ef9fwEeimbTsFh1cX36leb0
 edlF44HmoeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJlAAKCRDBN2bmhouD
 18KgD/sF5nD4+A9CLX+ovRafBVJ2AwWU/TBGB8tRnijFMArMGx6iW3XEp+04nhYitHj5rzrOwaZ
 4c9h44wtD7SNq3eMEJjU6+lWwIRzxBEWen9f1Y3/4NBCjElKCiPIumYQXNX3r0tbap6toreRriL
 DA3TGRPGGg5CwJdBVGeX+o5TE4B59tio2pAKtUnNnfrLtx359JwUEiU0z2anrXQkn7cQmkzM437
 hm2VSnMKPqqK1e2vWg0wEGthtbCtxOp0MEMYQwjf2SOqpE31n0/Un2aho0ZH8kzVFcO0Fz4S2Vh
 N7NEf9FNGBPBbYaFFw1HM+qQemv8eMtEf2OzArThkHX7buCjICSl4voR6TPT1O1g7lt+93Ovhxx
 Fu+5CU/eIR8gRxCOWQcWgm0d7lWi3IpfvwAVRiYkNE82sl7ldsspPaFbYlUd+VcRWt07anJnpJP
 9C0VK+L1/0rA1QBcE3vlozHXlYuCGdPVq1iLVdcrK8pUzOC0QwfoCxFsPQG4G85ZzFahe5teDCV
 tjianYWqGQRt9sHIFfVD0vhYOjeI5LGkK3wRDlbtC6xkPk/qfh2XmWRCUc5ZM5HwpdG8ohxYC+H
 q0lthtbajyArVWYaDFYcOeXR+9Ze/zg6Q+9Et8I9EkgGo1n12RA/luDSceOLb7z5nl4qI2aElhL
 BO8JGWefrTvVLxA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Set of simple cleanups from similar issues in all Qualcomm WCD93xx
codecs.

The first patch "ASoC: codecs: wcd-mbhc: Constify passed MBHC reg
fields" is a requirement for few others, but except this they are
independent.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (23):
      ASoC: codecs: wcd-mbhc: Constify passed MBHC reg fields
      ASoC: codecs: wcd9335: Drop unused state container fields
      ASoC: codecs: wcd9335: Constify static data
      ASoC: codecs: wcd9335: Handle nicer probe deferral and simplify with dev_err_probe()
      ASoC: codecs: wcd9335: Drop unneeded error message
      ASoC: codecs: wcd9335: Drop unused dmic rate handling
      ASoC: codecs: wcd934x: Drop unused interp path enum
      ASoC: codecs: wcd934x: Constify static data
      ASoC: codecs: wcd934x: Drop unused mic bias voltage fields
      ASoC: codecs: wcd934x: Handle nicer probe deferral and simplify with dev_err_probe()
      ASoC: codecs: wcd937x: Constify static data
      ASoC: codecs: wcd937x: Constify wcd937x_sdw_ch_info
      ASoC: codecs: wcd937x: Drop unused enums, defines and types
      ASoC: codecs: wcd937x: Drop unused state container fields
      ASoC: codecs: wcd937x: Drop unused chipid member
      ASoC: codecs: wcd938x: Constify static data
      ASoC: codecs: wcd938x: Constify wcd938x_sdw_ch_info
      ASoC: codecs: wcd938x: Drop unused RX/TX direction enum
      ASoC: codecs: wcd938x: Drop unused num_ports field
      ASoC: codecs: wcd939x: Constify static data
      ASoC: codecs: wcd939x: Constify wcd939x_sdw_ch_info
      ASoC: codecs: wcd939x: Drop unused RX/TX direction enum
      ASoC: codecs: wcd939x: Drop unused num_ports field

 sound/soc/codecs/wcd-mbhc-v2.c |  4 +-
 sound/soc/codecs/wcd-mbhc-v2.h |  4 +-
 sound/soc/codecs/wcd9335.c     | 98 ++++++++----------------------------------
 sound/soc/codecs/wcd934x.c     | 42 ++++++------------
 sound/soc/codecs/wcd937x-sdw.c |  4 +-
 sound/soc/codecs/wcd937x.c     | 25 +++++------
 sound/soc/codecs/wcd937x.h     | 31 +------------
 sound/soc/codecs/wcd938x-sdw.c |  4 +-
 sound/soc/codecs/wcd938x.c     |  6 +--
 sound/soc/codecs/wcd938x.h     |  7 +--
 sound/soc/codecs/wcd939x-sdw.c |  4 +-
 sound/soc/codecs/wcd939x.c     |  8 ++--
 sound/soc/codecs/wcd939x.h     |  8 +---
 13 files changed, 60 insertions(+), 185 deletions(-)
---
base-commit: f453294266a3f90f72b91c30b76ca67c5dbf6019
change-id: 20240612-asoc-wcd9xxx-wide-cleanups-a3aaf9c4d23b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


