Return-Path: <linux-kernel+bounces-518055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76249A38932
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057E7169510
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4C2253A5;
	Mon, 17 Feb 2025 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqTvzjDc"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C6223703
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810007; cv=none; b=CqiHESu5Lw2juBvBa/DZSoQy0TtFCaoM0BB9erarGE7VvvArENyDcI/DIw4iXUQw5DDQNYmjZTvFrly8yx//HcqrYehcTpTts0ukrOe2cvyUFHuvXFHUoWK0hoou7CIR44T9YJeM7fuA+DavpfhUHnG9TGr4/S+vvrjnH6uf950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810007; c=relaxed/simple;
	bh=4qpDfRcDD8rpnDxbcaskjP+/WL6+Dtw2w1ZGPGG7i30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cGOfG2hoXfL3H+yn7PuzoVZEHIeMHsRYH0VGaJ1rALjRP7oBd5apnru/coS+TkETmiW7+Cd4Z2dVTj/ZLD2jK1RqHzTBMl2PzzQTr1jm3OTqp0vMx/bK6jAeDrFrYNeycdQnfDofN59uvUa8WpuDbtuGIj0oP7oYlY/DitrzSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xqTvzjDc; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30738a717ffso40367611fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810004; x=1740414804; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLOzMbRbvqHluJB1TavYrDE4kHT0ZcZQYTNvV1k0mqQ=;
        b=xqTvzjDcWnRTq/algWdr6nRHwoT093xJCu5zAUqylDVeuHLTClU5tEBB8sM8f/yQgB
         A5Eec5nv76SS5GSPTL3HwziGC0SMrTITwcAAHA4b6aHFToWBjSvWblo++TXlzTuSZxap
         TRMa3jhfNi6iSTjorcc/9FCFXVkKh8Yhz6DNzreBbNasC3nAQzNDy2KcEjk7akAKiH7d
         DYYia89CzUGIpK4M8YpkO/CH8zcBKx9E+l/qmGL2o0Lyh7NyYvIk7X/1Ta0CdxjFp4IU
         YzBKEc9KwA72cthMyypFY6sgmsZRHCxcpR8JHwmzJ7i4IcY7Wjajt/mbsbHT7xhQ9jQi
         8nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810004; x=1740414804;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLOzMbRbvqHluJB1TavYrDE4kHT0ZcZQYTNvV1k0mqQ=;
        b=QsBrOLaE+1Kf60kbXaCQm25/CJs9h9AW7eY3Z1U9MI36ryiviFdzJVkLdutt5PKqzI
         5heq67oafVUwbjC6HTHQ/JACeuGU5tqRBf0uVpcTUp8xSc3zrJJqxW9OUEWHNNTQv7Xq
         P2zYVgsi2fnSb6W31uohv96CYA7GLSC9/NEoKo1StWkhnsffdemGj8TYO2VgDzxNd2ju
         u5clNCh41vPYBFcnOFy9+bQ0Qd56pXeLSye6qOsVsgJPTPMrnx3yeYnhavP4FCg1lnZP
         NvwAKxGsEvMBNmV9awytwEgfWOsKF1FCfsxtZoK9biaCCGr7teeBjBKm62IuWM3Ag856
         95bw==
X-Forwarded-Encrypted: i=1; AJvYcCWpUKMM1OLnnyl1uIgGGTt1F6TmUfikbMFIHwsPoPkyOhsAfELknnHauRC5gB2l8mwEVEJWtE4uzqoeVJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmiwwbZvvt5bOXYCOGmRvGHVlq+eHNlXE2LA75OV3f2OZJVA+
	hXc75AyNhiK0yXD4/VGZ+6+in8u2JMGuLv9t2CMw0cC51TwaC4vrv+DCiwbSGjI=
X-Gm-Gg: ASbGncubULjwW/PD8oSOHLzrGoEsvvPWgNhLza/3as+9AfrzhJEmYTKRnRRpV1SpDp9
	++5w8JAKIUxqKNcYU6zJcD5rrqCSWWShGtl8AAGoKP+FVCAEv7PV9E/ZdPAHOGGCy04fzp6+WS2
	iuysPP83gFhBySNEDcs/X4p/yGUe9sKOpatMHTBXdMVWm52SEhqxk0Yc8rqQDk4fzYZU6TCx4Rf
	KvHRFtEXKdSFJvmTllcbJCnQftTPkLjPfeMqo7O6MBkSx6NVfyrJYJ+wYuf78K0MpB3d+tOTR6s
	IjO1AqAwgeFMD8sm+f3mS5Uvg9lMPM0SI5WSx7JEC/xFPycKjymspPU1G2s=
X-Google-Smtp-Source: AGHT+IG+0pmtp48iCr/EbOP92Rs4BjASg3/mObcBvYZ2tPeo7PxhFJQdbU7GaEfnUdcFKdzGgL5Jrw==
X-Received: by 2002:ac2:4e94:0:b0:545:3031:b4d7 with SMTP id 2adb3069b0e04-5453031b4efmr2234341e87.6.1739810003866;
        Mon, 17 Feb 2025 08:33:23 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2cef18d1sm5695991fa.76.2025.02.17.08.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:33:22 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 0/5] nvmem: qfprom: add Qualcomm SAR2130P support
Date: Mon, 17 Feb 2025 18:33:17 +0200
Message-Id: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1ks2cC/3XMwWoDIRSF4VcJrmvxXnWMXfU9QhbqXBOhmQkaJ
 CHMu8cZKKRIl+fA9z9ZoZyosK/dk2WqqaR5akN/7Fg4u+lEPI1tMxSoQIDhxWUEKa58qhe6cB3
 3ehit9d4b1tA1U0z3LXg4tn1O5Tbnx9avsL7/pipw4EMIEs3euhiG7580uTx/zvnE1lbFN4+9R
 y64UTIAGvARx87LX68FCNV52byzioQ3I2F0nVfv3nZeNT9IaaSNpCPAH78sywsy5F6hbQEAAA=
 =
X-Change-ID: 20241017-sar2130p-nvmem-5f856d99bbb7
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=4qpDfRcDD8rpnDxbcaskjP+/WL6+Dtw2w1ZGPGG7i30=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns2TQawH2nAp/nSh6nOUrWAqp/WHYv4Ng5MZFZ
 ccIr2pYTuiJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7Nk0AAKCRAU23LtvoBl
 uB3tEADFABwNctrtW/gV4OgRQiF0KPoexGdrPC4Z+mjcM0/QVKaNgC/BlJ0yYKJoqKrUNrRwno/
 WFNxCsYlS31SibJ/VxwxVcq3a/wW7YCVn6xmjGb7P820RMuxAbIueGSuvmTn+xORlg7ws2YahQ1
 Q+/jH7TKa89U/bsX/jeKJl+Oc4sfWc0dApkkHwI0qsqXq7JPGLrlg/WlBhShDMFu36rDRfzVZel
 8KFJGMT14IiLVhEMwqsoEd1zjcnaMEeG5rm3ACnFCIi5CNcVYWt7qRS0z3iQFmKXnLZqx5RmX0R
 Cjym8zB/ei6JqGdzAyHLYi9qlKXdiMtPmL3cIUaxkZv5b/TS8vNq6i4pwWMs67imD0jGAOYOiPn
 4Juw+RtBRb88n9SeqUzpofTiqdurzD81ZfvVqfipUNxUHi2yd70hhFTi1ernPMCPwk3CO6YonEn
 JYlEMpvH702g6D8MSBsb8RQhYy2Bg77dJkpuZ1T1al7ws2TJHb+BqyWMmgRN3nAk9X6TIL8Uzy/
 c+C+QimwPrSyWQCdhef+pUGRwIXPEaaoDFgEELKWkWnDUvrYe9aeuyWFiny2e4IHZQTinD74KRg
 cLKY3DRdQ1/RTflC15v5Z3Va4t70RheeRttJfj57dOjCWjA+CD/B60yK73TEfWbNSu5r2kXS1B1
 ZeqKkRXm+ain5Lw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Qualcomm SAR2130P is one of the platforms which require 4-byte reads
when accessing the QFPROM data. Fix several omission in the NVMEM core,
rework the QFPROM driver to use readl() instead of readb() and finally
add compatible string for the QFPROM as present on the Qualcomm
SAR2130P.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v5:
- Expanded fixed-cell schema to allow starting bit greater than 7
  (Srini)
- Dropped the applied schema patch (Rob)
- Link to v4: https://lore.kernel.org/r/20250109-sar2130p-nvmem-v4-0-633739fe5f11@linaro.org

Changes in v4:
- Fix conition for bits vs bytes overflow (Akhil)
- Link to v3: https://lore.kernel.org/r/20250104-sar2130p-nvmem-v3-0-a94e0b7de2fa@linaro.org

Changes in v3:
- Reworked the qfprom driver to specify stride and word size (Srinivas)
- Link to v2: https://lore.kernel.org/r/20241027-sar2130p-nvmem-v2-0-743c1271bf2d@linaro.org

Changes in v2:
- Picked up required patch from QCLinux.
- Link to v1: https://lore.kernel.org/r/20241017-sar2130p-nvmem-v1-1-6cc32789afc6@linaro.org

---
Dmitry Baryshkov (5):
      dt-bindings: nvmem: fixed-cell: increase bits start value to 31
      nvmem: core: fix bit offsets of more than one byte
      nvmem: core: verify cell's raw_len
      nvmem: core: update raw_len if the bit reading is required
      nvmem: qfprom: switch to 4-byte aligned reads

 .../bindings/nvmem/layouts/fixed-cell.yaml         |  2 +-
 drivers/nvmem/core.c                               | 36 +++++++++++++++++-----
 drivers/nvmem/qfprom.c                             | 26 ++++++++++++----
 3 files changed, 49 insertions(+), 15 deletions(-)
---
base-commit: 253c82b3a2cec22bf9db65645f934fbe095899a3
change-id: 20241017-sar2130p-nvmem-5f856d99bbb7

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


