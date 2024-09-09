Return-Path: <linux-kernel+bounces-321521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B8971BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EF41C22DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941B1B9B5E;
	Mon,  9 Sep 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDV+0XBT"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1561B86E3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889901; cv=none; b=RMrNxT3AZ2jt9B+lrcmEAOrb9ow7hAK31suxwVdFWf2mw1VvIbGWAP1A+CXTsdJKuQUyVpW8QrQKgHnYOEeiQBM/i5fatRQ3xSg0YTDPnjZW6zrnOP5+/wtR41uuI0PCxUKAE+MD+mZSanApzFedjNXACYtXVNS/B1iM+oyh9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889901; c=relaxed/simple;
	bh=zUHhg/UyzRf/dZcnGmfWPB4ecX+Ntlv/UdMU1qsMFhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g56yv4ikJqiR7J6E/WfF5ydgdPxERsKyQiwyvZUYt5EIZNFfYvFZeetPhUObjXs3eUKwqQfINilRjZr8z9G3+beFnLTpJ8oBNQS+xLY8KDidF/wQ1XAlztoK9E+/SvnPiRzSn8IJrzLvzGOMvPuciQwtjxQEGehNO5jgsjF86Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDV+0XBT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8713b00219so23251066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889898; x=1726494698; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIf1wAbIzj4CuxkxfofvazjN5/qDj/bgJx/cWPTX0TU=;
        b=BDV+0XBTUxkG7bC0jqKPU5sDkWVjJvr01NMnpn2FXLKd1uUEyUpd8OVdOL4WH1CjJn
         Mrr00+BMXiE66R0mALv6kXHSIYnb7h8JDiKGoHOmqkqXAmtMMRGOzPFnq9wM9F+d3diF
         XIH3ybP19IGza21+oG7G5DqjwNFHtbj/+PqMRq5YxKvW1AP1Gn1x/HK1+HdsnNMID9bm
         NMS94OiU2RhCBxII7Canvro2w+C+wIbZvgztygGXXkGr8/yJWUTZPKom2AZxnyQoYbiB
         t79B8Xz7F5tvVQTOz5va+XzGuNwFSO3d8SFCESPQk2o+5LrFXOoao1BVwY9+D+mtpfIs
         Hzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889898; x=1726494698;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIf1wAbIzj4CuxkxfofvazjN5/qDj/bgJx/cWPTX0TU=;
        b=XXBaLfowtk3f8KmfsJ+vo6HX4BlqKXJWFKVg5RUEa9qqhfS3jHw2lat1CHEmO+KLmU
         TnBwwnjz/Ci2vv7gP+ENnVd09t8VM1SQhZ+vYRKCv0lCLA+eNseBDO0v2DTMDmVPrU5Q
         i0at0Mwi2DYLi6fpaDn5yu7JfmXOSjoR220o7FvDFK/TS4k6D9klbo1gGvz3bbRK30bP
         6lGmMMjzN5yGPBPkwKjXi4nEMeLG0/h1BSZanaV4hA6w9+DQkULfKGHbBLQrxvFMge2Z
         4LajgyKJJIriV6IOPd2jf41+on94y3GozcshyxtzW8cqwdmGP9CbrN1CLxPisaQP8RPK
         9r9w==
X-Gm-Message-State: AOJu0YxGJB4AY8mo/1yPMZCWtA/XnWMs3aUI8w6vIK5pi1p8iFIZGXzc
	ffLd4haBbb714GLkNBL3rW6bhQCppdUnmQFwKUWV2rVkxQ6AWc15X3a+CslLhUM=
X-Google-Smtp-Source: AGHT+IF9Mh+MgE0b3Jf7kgDpkQxsvludlLfJmIJC1bDwVRLgk1OMrtfUfpR0kKiqTATr3BREdjGX6A==
X-Received: by 2002:a17:906:c148:b0:a86:a4cf:a197 with SMTP id a640c23a62f3a-a8a887fcbe0mr296077966b.5.1725889897492;
        Mon, 09 Sep 2024 06:51:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/17] regulator: Few constifications of static data
Date: Mon, 09 Sep 2024 15:51:11 +0200
Message-Id: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/93mYC/x3MMQqAMAxA0atIZgOxVESvIg5aowaklVRFkN7d4
 viG/1+IrMIRuuIF5VuiBJ9RlQW4bfQro8zZYMhYaqlF5fXaxzMouuDjiVNDszPG1jQR5OpQXuT
 5j/2Q0gf6uJlQYQAAAA==
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=zUHhg/UyzRf/dZcnGmfWPB4ecX+Ntlv/UdMU1qsMFhE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1VgRQNlylPub6yNjTD+zg1dZZuybYlU3O5P
 dYuhnlzbSCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79VQAKCRDBN2bmhouD
 18H6EACQOmd1uI3uaTvI5UKYLHpsmpK02EBrdx7JfUDu7mYQKIwkyaQ7/NZTXgYa3NeSubtpWqS
 CYbu3d4cN9X5LRMnP/JfMWvN5nPjCJ9yezEZ1IlOJtorpsV4QDmQzpx7jhK4TVWVOT3H2EFdHf+
 Qhsg7Ra3zq3eQbpakhFmlWTVpiCXjAQ8ewaszVTwD2mhmqP8rn8IQCPWY0GBz1/zrFdwRMUSc1N
 VDt/txtsgO+LhT06oBFGSgqoMmEc+hzbAHhKWP/lqErty136Vq+GXJqRfmFwtbIDq/W6PI9lVj9
 LrZGJI/T7x7FhrH5V2t2MvvXERnKJMd1yscboisw+JYX/L6PMT0uqXRxF2Oiok92GZXua7D3gpQ
 KG/LN6HH0YYWc+KVxGaikAADasjgiO10L9qOwEONgUsBx8z44TncZMgPRAqUuuadqj91gi448lM
 xC2+L5ablOxm7cUiGaKaPgeSaZQK7MtJPbpuBhFq7jDN3It20DFo90EF0+qwO8a+S3Y0jLfYnuX
 lLJASJvsh5c7KTi54zRhQY5H6elWKfnkvjsM6jtWVrI/DbJSF/wsoIke4n0rYXEDmg1UG+7NU7t
 WQLd1Dr6580QziSbr9Z1VjK64AdhO5rmijvUVs3Bc6dwmjGCb1No0vYDv664QDCk8T0v5mVFnt2
 wSjVdO9X45kDo+A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Few cleanups (safer code), built tested.  Last two patches should
probably be tested.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (17):
      regulator: da9052: Constify static data
      regulator: da9055: Constify static data
      regulator: da9063: Constify static data
      regulator: da9121: Constify static data
      regulator: da9211: Constify static data
      regulator: hi6421: Constify static data
      regulator: hi6421v600: Constify static data
      regulator: tps65023: Constify static data
      regulator: max77826: Drop unused 'rdesc' in 'struct max77826_regulator_info'
      regulator: max77826: Constify static data
      regulator: mtk-dvfsrc: Constify static data
      regulator: pcap: Constify static data
      regulator: pfuze100: Constify static data
      regulator: qcom-refgen: Constify static data
      regulator: hi6421v530: Drop unused 'eco_microamp'
      regulator: hi6421v530: Use container_of and constify static data
      regulator: max77650: Use container_of and constify static data

 drivers/regulator/da9052-regulator.c      | 22 +++++++++++-----------
 drivers/regulator/da9055-regulator.c      | 28 ++++++++++++++--------------
 drivers/regulator/da9063-regulator.c      |  2 +-
 drivers/regulator/da9121-regulator.c      | 20 ++++++++++----------
 drivers/regulator/da9211-regulator.c      |  2 +-
 drivers/regulator/hi6421-regulator.c      | 14 +++++++-------
 drivers/regulator/hi6421v530-regulator.c  | 27 +++++++++++----------------
 drivers/regulator/hi6421v600-regulator.c  | 10 +++++-----
 drivers/regulator/max77650-regulator.c    | 31 ++++++++++++++-----------------
 drivers/regulator/max77826-regulator.c    |  4 +---
 drivers/regulator/mtk-dvfsrc-regulator.c  | 10 +++++-----
 drivers/regulator/pcap-regulator.c        | 12 ++++++------
 drivers/regulator/pfuze100-regulator.c    | 10 +++++-----
 drivers/regulator/qcom-refgen-regulator.c |  4 ++--
 drivers/regulator/tps65023-regulator.c    |  6 +++---
 15 files changed, 96 insertions(+), 106 deletions(-)
---
base-commit: fd9058d56c6de25c2d3215db4e2e950a7965ffd2
change-id: 20240909-regulator-const-b70dc22450b0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


