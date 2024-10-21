Return-Path: <linux-kernel+bounces-374093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256DC9A631E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F111F210A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1E1E47A6;
	Mon, 21 Oct 2024 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/KfdiH3"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFB1E1A1C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506645; cv=none; b=Xt1X9e9kT5MFUR91nqiKxPTW0lC5SLgCtgQMjkj+Q5QrXn4Ez5X+o764h+GSZE78nSYQLFQOeQa15w8VSjFB4hMcZSwPJggSwLyz5IBu8QvUqyCqkIJz5JwUBDIpzjAuXECENl6fsOrfnc55eAeg7Z6Atg6bSqKcFcavZpEaogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506645; c=relaxed/simple;
	bh=+FD8i4VW6GLQ+8kCcEhzI155Je7Z5QpsCm7eSObmh04=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GN+UgaWK/PMjHIU3gxYHEzCEt2EGuYykzZ0TmSUbmPwifJEzH+oLgUyfSlX5x1iloWdexKVP79/m2sedv+ikEVHe/6WIQZ8M2VWA2H//caThRwhcvofHEj6AYvRn+EnELxr6NHTYYhVuSSMLnZpj8AiX5fmy02ON298SZVzCx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/KfdiH3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so41231691fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729506641; x=1730111441; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6U/cj5+Bf3pC9ihPSOxe6Ah/nkqDR4wfALNHrVs82Ms=;
        b=M/KfdiH3ceFvgMHaSMOvZGzI62cxNA+hLE4ZRrHg65R7lVMM4Gy3GZ3F3/+F9NHp+g
         zKZen61tCgVsq1WfZZAULHtUqyHp3F0RuKvlC431Hrpuki3oiO/IEobzxyYiitBL49o7
         IDJXOVulZ4MdoKaWEDGca1MAqZH5w06tlScP32pMOGdUW2OinkxxsMTYc7Tc67wtf3eB
         HbqcVsXS4c+cHt69JIenpPKNZbm0S7HnpxFFmu3BbYEfjXDDOD8zhuzLatPf0hyoUsrt
         oUZpmKREyVBRoC8RA9KbpyCvWNtgGH7biqPGqsKhOfMUzOzj2HPr17YoiEWii/OsLVNM
         MvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506641; x=1730111441;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6U/cj5+Bf3pC9ihPSOxe6Ah/nkqDR4wfALNHrVs82Ms=;
        b=KZYF1egxg+7mZQ/+9mttyc/zjHfm2VJ30LVMZbEqdUX1rrj0eKde5cwyranrYrKsed
         yT5af3nyeR9ZV6AnCcypJB6vB0kRYzonQNwiPiyggVPErcTwYiRDwXN+pT9dw77bowHx
         QI97Ft6sIjHwm8/fThTjzn930utq8n3oUIaqc9yOACIhEJB+aeYGdBloXprojNzbIMV7
         2jqypfE/1WNrdnMIfn4qV9G81vqGXGLwQKk8IXg0Xxr5g1L7W96BjS+Ris6K2aCB6aF+
         p14RYcFBiBUHx8uI60Rd9kj7GWRq4MXJm5rQkLZe2krqh6l8qZw1rWYQTL3CIYntmy2H
         TYlg==
X-Forwarded-Encrypted: i=1; AJvYcCW1asuyJHr61ttLbwKh3x3UK5owV3XIecq2Djxa3ChJI1yM/JJ5mi2S7t+gYZ7zilHWLt/1pBrONm07dlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLY3sxuNRXkI/Xt7zA/I5fLW+F0OahOp7vb+F98npy9LY7x8u1
	Rq+O3BkDeGWvaJEAnqL9ZUA58g0ue5FReu2T4BTBnKaGTztnXj/FRJmmHglQ4WzvNRwLhC9Wo9F
	TxDA=
X-Google-Smtp-Source: AGHT+IEOUI6TyliDkZqKChjvPQgoy+tW/qcExcRxKb7OqhjZs2iXvFBlW4eOBmOYvUo9Fk+bjSCzog==
X-Received: by 2002:a05:651c:547:b0:2fa:cd7e:3b40 with SMTP id 38308e7fff4ca-2fb82ea19damr39216021fa.11.1729506640878;
        Mon, 21 Oct 2024 03:30:40 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae1217bsm4522711fa.112.2024.10.21.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:30:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 00/11] clk: qcom: add support for clock controllers on
 the SAR2130P platform
Date: Mon, 21 Oct 2024 13:30:28 +0300
Message-Id: <20241021-sar2130p-clocks-v2-0-383e5eb123a2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQtFmcC/3WNQQ6CMBBFr0Jmbc20lqCuuIdhUegUJhJKpoZoS
 O9uZe/yveS/v0MiYUpwr3YQ2jhxXAqYUwXD5JaRFPvCYNBYjbpRyYnRF1zVMMfhmVQdeu9vfUB
 LBGW1CgV+H8VHV3ji9IryOQ42/bP/W5tWqEJTU2MxoLv6dubFSTxHGaHLOX8B7Z0lC68AAAA=
X-Change-ID: 20241017-sar2130p-clocks-5fbdd9bf04ee
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kalpak Kawadkar <quic_kkawadka@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2872;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+FD8i4VW6GLQ+8kCcEhzI155Je7Z5QpsCm7eSObmh04=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnFi1J3sbNoJuEo0OyMEAqxEbEG6iENQLiJFesL
 D4hZ4Y0AkGJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxYtSQAKCRAU23LtvoBl
 uGqDD/9N1rXjF5247C2hgwlQi0Ed8/wDtJ9N8HygswjvjGX2Dpw7g4NR9OAVySkJ6HqGuqyiEWu
 j0n9T/IQ4fDvTyhK7jD4pwTti/B/QoT79NvTWFAMbO5GaP4oeOFLcL5HU7PkqePvQ08E8XhyZua
 WSDN+e/zj0md3AIcfYenaM6/buq9rqM1jst+cv3rNVQAl2yhCmNqBq9C+deqIEBTqq5mz0eSky6
 nOuBUI/IivMRyJtFOtm60U3NXS/x1L21SAMGh3TpaJYy2gte+Z/OEWEDF71weJWJUhebuQ0uhqg
 2MSyF0RlFDT/9YH4cbOyGih1Ycht9RJL7yYwV+CDYOPlKYGzrupxRFMLXB/iM33ELLMYBB+bbfI
 PgoayuHMi6ScIi37JpJvBpg0MWUnCu/mW2npl59UlkraQX1KqFyxiyFhQJ9X97zawpex1nx/Ibw
 vW+Pi5WER4GlTvWIZIFY3DrJ8zqMujyGE67vJUncuQpoELAQZ7M17kPri+0gw0tkNLxMS0fFIaY
 k3GutUIdJfxdNHn69jE2lcOk0N1Xma6+Bc12Bc+czRYeWzapRvhf6aHrtVORaQnyaoLYnpkCLN0
 cLA3N8m7rRwRgza0Wn5Co75ksAhKqIfDw3Vj3a+UinqccDqJbPjVYfkxNKx97ND397gxrXWikVO
 q2c6YT+Cvw5+xJA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add support for the RPMh, TCSR, Global, Display and GPU clock
controllers as present on the Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Dropped gcc_camera_hf_axi_clk, gcc_camera_sf_axi_clk,
  gcc_qmip_camera_nrt_ahb_clk, gcc_qmip_camera_rt_ahb_clk,
  gcc_iris_ss_hf_axi1_sreg, gcc_iris_ss_spd_axi1_sreg,
  gcc_video_axi0_sreg and gcc_video_axi1_sreg clocks until corresponding
  subsytems bringup (Taniya)
- Program GDSC_SLEEP_ENA_VOTE directly from the probe function (Taniya)
- Dropped sreg, BRANCH_HALT_POLL and collapse_sleep_mask patches
  (Taniya)
- Dropped gcc_parent_data_4, gcc_parent_map_4, gcc_parent_data_5,
  gcc_parent_map_5 (LKP)
- Link to v1: https://lore.kernel.org/r/20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org

---
Dmitry Baryshkov (9):
      dt-bindings: clock: qcom,rpmhcc: Add SAR2130P compatible
      dt-bindings: clock: qcom: document SAR2130P Global Clock Controller
      dt-bindings: clock: qcom,sm8550-tcsr: Add SAR2130P compatible
      dt-bindings: clock: qcom,sm8550-dispcc: Add SAR2130P compatible
      clk: qcom: rcg2: add clk_rcg2_shared_floor_ops
      clk: qcom: rpmh: add support for SAR2130P
      clk: qcom: add support for GCC on SAR2130P
      clk: qcom: tcsrcc-sm8550: add SAR2130P support
      clk: qcom: dispcc-sm8550: enable support for SAR2130P

Konrad Dybcio (2):
      dt-bindings: clk: qcom,sm8450-gpucc: add SAR2130P compatibles
      clk: qcom: add SAR2130P GPU Clock Controller support

 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sar2130p-gcc.yaml          |   65 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    2 +
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
 drivers/clk/qcom/Kconfig                           |   22 +-
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clk-rcg.h                         |    1 +
 drivers/clk/qcom/clk-rcg2.c                        |   48 +-
 drivers/clk/qcom/clk-rpmh.c                        |   11 +
 drivers/clk/qcom/dispcc-sm8550.c                   |   18 +-
 drivers/clk/qcom/gcc-sar2130p.c                    | 2326 ++++++++++++++++++++
 drivers/clk/qcom/gpucc-sar2130p.c                  |  507 +++++
 drivers/clk/qcom/tcsrcc-sm8550.c                   |   18 +-
 include/dt-bindings/clock/qcom,sar2130p-gcc.h      |  181 ++
 include/dt-bindings/clock/qcom,sar2130p-gpucc.h    |   33 +
 include/dt-bindings/reset/qcom,sar2130p-gpucc.h    |   14 +
 17 files changed, 3240 insertions(+), 11 deletions(-)
---
base-commit: 27e373c583871ca992837ab918709b67e27d1e3d
change-id: 20241017-sar2130p-clocks-5fbdd9bf04ee

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


