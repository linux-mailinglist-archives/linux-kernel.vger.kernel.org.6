Return-Path: <linux-kernel+bounces-286268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3979C9518E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5772282F43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADADD1AE046;
	Wed, 14 Aug 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHvAlQCJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC683D552
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631758; cv=none; b=SvqeAKKgHYRljGrR0UUf3F6OTTTllX3oxMg32dRK1OzSTAIoyat4mRBOrfu2nOPxQLlLuM9VGKNWKwbbSCtdNpgnLJIj7SaOv5RGta0Gd6gHZqQR4/WdUe7XkjhtztzynwGMS6KbD1jIJdUBdmuCw75m9zPgqB8VJTS8eB8YHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631758; c=relaxed/simple;
	bh=uYJNJ/Lq7xLbdSs3WCTfozAzfV0PWPsoOHzzbIoIraY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wyoch1dhgBZwyrUv9KVxpK6sQ8A3LwbTdkTZItaYdD9dGQtq+x46TKKmCINqfwPqGc/lv61b7B7PXHIPkRm5FkGOG9eqMeBj4ZD2FOkwxk6XOZe5WRak3Hl+5x91rwb1JUcGp9u1WfJiCxCVm9E9pFmfLnup90JVUqyQGyG3dZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PHvAlQCJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso4162675e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723631755; x=1724236555; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIfn1yXxmrN46mLAefxPsa6hzoHxpKs5WpPt2Hr+8b8=;
        b=PHvAlQCJfyvbOC2gRuKQnj572AhGTw5ZQxiQFR9M46P1b7txLexOlwvSIr8KqSMHUh
         +Lkt2mdcPodgVqdLnDuKorrf63Nseu7wnC3KlzTEr4xiFfCOs+Mf3TcMM4QXUDn71HDq
         RV5xHjhwt9W5BpW+ygmsKN7RrCJZ5bWggMfEko+62GyRPnlL9QZmfDs6IOHg62jIf69W
         drLNVIiXdpGt6ES8L7SuCvzFA7Gt57v6Hhl0C7g+UN6BWXkMOvSYqgmnsd5UMupfAlr1
         rIwgKtDHfc3u37so6D799ZPkjYjiP9g7nxmLX4zqFtedhIRL+bYST0Ezwjz7HBYiVhZ8
         BasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631755; x=1724236555;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIfn1yXxmrN46mLAefxPsa6hzoHxpKs5WpPt2Hr+8b8=;
        b=iKjqBDkyZH7UkFyMl+JRuhd9Rat1zGbCsCxvr75PLKQrxCteIhKmM8mkStX93+u7FY
         SUMG5pr0PYnZjyUkewEA+uKXoD/56BHdncfXGR1wvuj18C3BlbUsZXh2u3XJvLFoGl/n
         BO7raTtcFnDsUU7Y0JMRCcr5FCLsbhBOyhzwKwK6XnLKEfngy5AT5d5oDq5dPfdcsVbo
         nELjYago2lRUc24gCaKw95d6LGOgTf+6kQOqUH5Cdsi1tC6rWR6am199oeMds80NJv1B
         bXtM/aNCeh0IHrJqBQm8j9LUKmSxm5+kMmSwc09Nu8YRG7+19bRuugKpRftDgcDmxJha
         iy0A==
X-Forwarded-Encrypted: i=1; AJvYcCUbMl1M2OXuGWlUJi0C6Ruhv9s8H9BrPWRZyz2kK27q8THWslmr+xT9TZCO4RJGCk50nPhB22fiSPIFeFPCKPQxsqyu+Xt/rJXKBQIv
X-Gm-Message-State: AOJu0Yxu5kzg34naS2ozkOKIovIYu3aHU6ZElVJs04exe3HZ3oAupVg/
	VGCKNxat63dgrITxvQDTWtfaEoH8oTNNR9Gvi0o5/AbkFNtlTSyPZolJ8StNwu0=
X-Google-Smtp-Source: AGHT+IFySYJCbfhEPkwCk8tbPpG+Q/vI8wWAns+br1MLGrpp6gsbqkztTS2yy1odzpfjzuGCQr1aDg==
X-Received: by 2002:a05:600c:4ec8:b0:428:9a1:f226 with SMTP id 5b1f17b1804b1-429d625a61amr41770265e9.1.1723631755222;
        Wed, 14 Aug 2024 03:35:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3dd4dsm15501835e9.29.2024.08.14.03.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:35:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/11] usb: dwc3: various cleanups
Date: Wed, 14 Aug 2024 12:35:36 +0200
Message-Id: <20240814-b4-cleanup-h-of-node-put-usb-v1-0-95481b9682bc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiIvGYC/x3MQQqDMBAF0KvIrPtBTcC2V5EuYjKpAyUJiRFBv
 Luhy7d5JxXOwoXe3UmZdykSQ8Pw6MiuJnwZ4ppp7EfdPweNRcP+2ISasCJ6hOgYqW6oZcFLeeO
 8nSanFLUiZfZy/Pv5c103BpHSf24AAAA=
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uYJNJ/Lq7xLbdSs3WCTfozAzfV0PWPsoOHzzbIoIraY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvIh7j2wXb8IRSjayFQLu9kQ0RjqW1dpsXav5p
 jogbyksGwaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZryIewAKCRDBN2bmhouD
 1z4JD/0ZLzy3oMfUHF+i0Jrf/I9J/ggzgTBbZIDeBh1fMIHwXI4UV3f4ZzFi4+MAeq52bwcKi/Q
 4ZWjuR2Drm0x2yj1lNXUZSrUA8muBeTX0u7g3TCJolxsUXZ4jhC6zo+Ss2xueXo8LUfBH6f+1Ao
 NsP370WTlUa6fkWu02lC7JKBkB2VaCEvCwJQjVP6HRCh0lH754h3pNL74PjjsI5BFihWRyBqB6d
 xMQUW0oNEdGfUW65/cdsR5wEzZpt+DA1bSIV+a2gkjYpsHbkNd6Knf2KGb0SfoKSjWatb3UHVFN
 hWUzTk3vk+Z+rRKEhifVho8skSOgm/0DdWjoCxwFydVQO+jwNsr/7Q7ze/cElZrzFi3MKf3gbIV
 5A5vJaNmUSMsKfdKUIV3rCAVXRNiSCRl8gzqNChQYNjDUnaP2Uiy7Bxon7TrJt2JgRjjhWUbu8q
 smr11srqf1lzIC+YFOr3q4H1lQdliToGwFCCx5SnhkYcN4MhyOC4Ks/Kqn/LvNYvvHQ2tpqs2iF
 crEZHvh79p0ROlfgzNYFuQuuwG+q7VBz8rJxlaz0dzOru5Hoza8zCcbI3LjqORtCq6DyWq9WhJR
 pLJHkoVqFyJmyqZtke+/BYT/wPyombZcEt/ulivdPeiB0eJIqMB7YEZpY/g9R61eiMqhNwQGfYi
 b+SwC+Apdc39TUg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

The first ST patch depends on my fix:
https://lore.kernel.org/all/20240814093957.37940-2-krzysztof.kozlowski@linaro.org/

Series makes some code simplifications and cleanups.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      usb: dwc3: st: use scoped device node handling to simplify error paths
      usb: dwc3: st: simplify with dev_err_probe
      usb: dwc3: st: simplify pdev->dev usage
      usb: dwc3: imx8mp: simplify with devm_clk_get_enabled
      usb: dwc3: imx8mp: simplify with dev_err_probe
      usb: dwc3: imx8mp: use scoped device node handling to simplify error paths
      usb: dwc3: qcom: use scoped device node handling to simplify error paths
      usb: dwc3: qcom: simplify with devm_platform_ioremap_resource
      usb: dwc3: rtk: use scoped device node handling to simplify error paths
      usb: dwc3: rtk: return directly and simplify with devm_platform_ioremap_resource
      usb: dwc3: xilinx: simplify with dev_err_probe

 drivers/usb/dwc3/dwc3-imx8mp.c | 66 ++++++++++++------------------------------
 drivers/usb/dwc3/dwc3-qcom.c   | 16 ++++------
 drivers/usb/dwc3/dwc3-rtk.c    | 52 ++++++++++-----------------------
 drivers/usb/dwc3/dwc3-st.c     | 38 +++++++++++-------------
 drivers/usb/dwc3/dwc3-xilinx.c |  7 ++---
 5 files changed, 58 insertions(+), 121 deletions(-)
---
base-commit: 64b429eaf21be888cc83e9013e25897d5fb03a75
change-id: 20240814-b4-cleanup-h-of-node-put-usb-93fadfc77d33

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


