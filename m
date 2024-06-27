Return-Path: <linux-kernel+bounces-232578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D591AB30
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FEC1C20AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780171991A9;
	Thu, 27 Jun 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GT6Rx21a"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF1198E89
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501832; cv=none; b=qdFM1z4VLbrtwFZ1/iDiA8M6gVh+LQ0NapZ/7yqjvqrn0xl2kIizMxIkD/9DTWfPtfCpYHNscWUvtKlYEoTIKHZse9VSPh2S2vCZrN5Wdrpg+oBmRGPO7XMow/idcT9QceSpyx2o6A0tutrwkoUT+DGrxPZ3k8oMnCbotIpjP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501832; c=relaxed/simple;
	bh=q5e0BwtxSUJcwFevbMIiLhtV0bDtLk1JVUBFWPJRci4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FrbFJKpJN09MOpJ0OYtXhokGNPgWrRv7Hig8bukaQYypePsj4VvaVOvaXNKG9Iy5hzWvXYXJ8GDAN9Nzr0qexH2ORquJJFSUcdHAcQrjckmc8UKTCx0lgNabEreTWKkeLVOduX/woVniEAB/G1tT8mDGQSHxIUkNdyDd1Mg4rEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GT6Rx21a; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso24153085e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719501829; x=1720106629; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBnWRzOVrE39LA/BtdLJYz0EF2Ov+NcNWuXEh5DU/2E=;
        b=GT6Rx21akVrMn+CyxVpR7TheVWjZrHKDdRZgRrXcDC9Ck3UqmiYPs7HNPQGDdgcw+P
         55/m9QaEtrJX3qFXDTz1UAHVih/xceztSchH90ideebaJIDp4J8zn0pOjpbGn3j4+OdE
         IDG2SlQqkiPGaGmatXBDO0MmwjqFwjj4jgFj/Ldpcv7/7zzaEbkERgs2QbTnSu2Nn5Up
         83lVjYmDOUe9O0UbRWuqAqmWFZHlOeOUEVUAVB4HXCf+c3iRD7ZwrH5ECUeZH6xjhXuF
         zs3fWEQbDJE8NDU8IxfStM9E6Jn6caR0H+8u7GQiBICglMpOKAWzyrv0FN4hW6wYVrog
         7Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501829; x=1720106629;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBnWRzOVrE39LA/BtdLJYz0EF2Ov+NcNWuXEh5DU/2E=;
        b=qglkB7rtCZ7lnFoCvVy9LVv2zQopljOmC38KIpLj+c03nw5BL6DElqP8BhhZEyTzCC
         lEoH4OMnCvWwAAXwlZxoHGOW/OAjhE5ntx5n0AKPc5nxT8jXnPVxCGqu5x9pgbcTsKGm
         vPTEPyoq+KUCwTEm53yCRCErG0CjfvoQ5PZ0hKXo/N7VpQgngbvGVNPXMzEN04AdQS6c
         Fz3Bm4GYAVnvavtv615e7OLLNg8B4MSUKfhcUYmOFUqhLzHgpAp1ZmHIkiZngy9wouVG
         LPauxr02QijXtyefWMVxYe3RQPd3FM7cAOiX8a3AMBwBMsUCiuBpRjNm7GjPDZEWpmW/
         IaJA==
X-Forwarded-Encrypted: i=1; AJvYcCVjZgAAKPlSZxnk/492F+Xgo9O3Vk0my2FpEKQahKxUrkrlXhWO9oAXuoek8Mvr5hcLqN83eUi+hEQJCgHbqPp1xFoCjLuOV0hnT9pz
X-Gm-Message-State: AOJu0YxUbcp1w7V2JBcu8dvfNFHoy5OPrZSJYWklzjZPhnkXnvaJhCyj
	CKf5nHKI4f1WiNzDYAJDTqHC1XdZtCtHSU6DC1Umf2wfs6rj0QpWVyxOmsgVC2Y=
X-Google-Smtp-Source: AGHT+IGz4RFVCbxrSnzyiZWinUPxSefZKCrCIlIhIcYbR4ADu79IBzwSrxjnJD9KzdgtU4iOvyRIFQ==
X-Received: by 2002:a05:600c:9a6:b0:424:a31d:a046 with SMTP id 5b1f17b1804b1-424a31da1eamr71772985e9.15.1719501829317;
        Thu, 27 Jun 2024 08:23:49 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564bb59b7sm32783185e9.34.2024.06.27.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:23:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] ASoC: codecs: lpass-rx-macro: Few code cleanups
Date: Thu, 27 Jun 2024 17:23:42 +0200
Message-Id: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-0-ede31891d238@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6DfWYC/x3NQQrDIBBA0auEWXdAJYm0Vyld2HFsB1K1DgmFk
 LtHunyb/3dQbsIKt2GHxpuolNxhLwPQO+QXo8RucMaNZnYenyN+qXwwrFEKLjWoIpXIhLRwyGt
 VdN76Kdlo5muCHqqNk/z+k/vjOE7dO1p1dAAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=q5e0BwtxSUJcwFevbMIiLhtV0bDtLk1JVUBFWPJRci4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfYP/EtpuKpXFrpXU8aGEeX8e7rsZWx79JF/PG
 f1oa4SAEn2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn2D/wAKCRDBN2bmhouD
 17pYD/sESwJpcYRXVf8DHMWNHdhNf9Y3i6N6wtGjkdSXczWRJlm629OhFVRWJ0NDXhzP+QD0IwJ
 I2TDiCFdbyeKZZd1C26Ux9JgZgDb/NB1qqIP4SqmFcbb+zPE1BysZ/e7Oa2urPN9edCN2cO0j0b
 STisS6u18f/gWPuBkRW/DF80vhY4sJenFRm/HI+0Ud190zMlSBJws30Ewf+VUQDvzmZOlu4d+al
 +Bu0/m5JylJOc3JMFlIYuTif3T7WXeSJcs1fTH1+JAnEJ2S/a83JHURmBIqrO8/YZxyXsgoFU/s
 UgF46V3P83fK1gOVEFUUXX0Mdo5ffvvgPlyW7KBp+HD/2QxT9wEH6yWgBJTpVvIa69xzSAqXU+b
 6tW94bkmWwjis99DQZSdcT1zYqvkDAM6MZZAQ95B58SkOZghfaw+Q1GfnidByDJtkqnybgQ9/AS
 Bs0wSkJI8Q7F69IHR72sEIOfUEKmPw6YBLETNNAPBTT5AW7a1K2RziXcVEuxj1k/umLEPgRa3UW
 a7v3Y36UUjOZtSwI0kcPpNWMKT3FOMNhZ3v+XCv14D/i8x/MOS9Nr40HAibmbbcAJQ5HENbSrih
 u5t+v+N1XX7tQi8IX1e2M6YlPgrUvSesPTFFDgPKcEvaW3OrHkRhTK59FlLz9M7pGVbaW0zkyuC
 h5PFDnKVPwBwbdw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Improve a bit the Qualcomm LPASS RX macro driver and align similar parts
of code with LPASS WSA macro driver for consistency.

No external dependencies.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      ASoC: codecs: lpass-rx-macro: Simplify with devm allocations
      ASoC: codecs: lpass-rx-macro: Keep static regmap_config as const
      ASoC: dapm: Use unsigned for number of widgets in snd_soc_dapm_new_controls()
      ASoC: codecs: lpass-rx-macro: Use unsigned for number of widgets

 include/sound/soc-dapm.h          |  2 +-
 sound/soc/codecs/lpass-rx-macro.c | 37 ++++++++++++++++++++++++-------------
 sound/soc/soc-dapm.c              |  2 +-
 3 files changed, 26 insertions(+), 15 deletions(-)
---
base-commit: 47ec7f026f5db6a0fe26c6215554d043d04368eb
change-id: 20240627-b4-qcom-audio-lpass-codec-cleanups-27175f1d069f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


