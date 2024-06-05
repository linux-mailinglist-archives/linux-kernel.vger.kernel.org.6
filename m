Return-Path: <linux-kernel+bounces-202940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9988FD352
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F2A1C22DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C81922CA;
	Wed,  5 Jun 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hOT4tCxk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8118F2CD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606636; cv=none; b=QcMAs5XWrVg6qd1fB+oAVzPbLApyzMQkhvlkYGgNCTv/Z2IchW+vy1CH5jeaV5cPwvYcTQyB72fBdoetXXt96MI6puwj8b6R+zL99cdZbMlMeBQsvv/td1+rfhGBStwHvXTSSE+DZiYdtNnO1wtGRHWmuwA2b7qQd4y4pIB5Oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606636; c=relaxed/simple;
	bh=dACpeN5rm7AHMWY75GC80Jc6/6kkaazWTf0vL0Ep9SI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XIffTxypEmK3C/ABw9Lmv6NEnSxbU9eBQSRtSaq9QmXQH49pqxbXvXqemLhKyjgIX3YSdZt9o5tHfCk5BuROzVASx66cz+nt705z9D1WAMKKxtO+NeAYD66wgBhV4gfwl0vuVJe2Dx5ML7pAi4v7rhDDBEqhoGeJvO8+WpKuNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hOT4tCxk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421578c546eso745695e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717606632; x=1718211432; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkXEU+KFaUrWA5bqXDVbyrzi9+yH6HtfyPLuvHY8v0I=;
        b=hOT4tCxk6lK2X/kgEqyYQwFxniXs5ImmZGgKLg81e08ZRvWN+kiLzKi3QTcw29ECkJ
         sY5Ojed+J9mjlESYheN6P8evY25pw0J37NOlNw0tTcUWVyyDs6gNYYbmjuT0RRuPx3/8
         d9woQgL+uYo9M3iiStolCNA9BfQ9IUxPGFFm4B/IcsDn7vb8AkLfE2o7DtF3BohZfP0L
         yJt/qxStbclihf1mxBtyIQ+BcX6a+6cc2cw1B/VBUlTtgR3o4oKVyaCEtX5VlbCJ+/Gl
         mK19V1Ya1rj3xtUeb020utKNDF5v6cr4h46QSNClb9Ypm+v7Ok9DeSYixw2XEdCNwl0C
         SKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717606632; x=1718211432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkXEU+KFaUrWA5bqXDVbyrzi9+yH6HtfyPLuvHY8v0I=;
        b=PslzzBO4XBgBhU0C/GSrTmQVmKQisfZjZPSHWUvhn0FnUd1aMJ4fxJ7uZ8BshZ2yit
         JVv42uEr//yBJ81Y0BIRPwU+9tAsIwzuB2/eJqFl1n90YgCE2d0UNaXtcatnEThFBtFs
         wkAGgj/r2Kc9MY+o6VU8qi9ZRmQml7jkL2YLu6g2SufxaNOQ0kxVUC+27nHKhLxtqkDn
         UDiLiEX9JfxoHV8NXN6GMZsFjK3G7+lYMAbRTLGKaDLFgIlu0XBrPzNX4n4JxdFtFtHQ
         coS2ch3MvaFyp1QAlScZySXiHbIjAOy6rcfJN/eYt3C2+QtcLG97RyiDrw4zziM0uTom
         c6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVn6jbodFd/Pc39GXgmpupP+TQB+kzwq0PhIc9X8T6DgPM3Vo3iurMRMCoizkTYEW1bhn6ZcQkNFd6doBwoo12jBYiiAWov/o71tGCP
X-Gm-Message-State: AOJu0YytyOQqiht5TJ+cnS0By3qzI2KaLIkuB0cZAUf7dwPz26Cz4AhF
	9Tjat6BYUqN2qp6gIIP/cPasRlQY/brg7FJPdTAApROs82u8cI1y7Os+qC5VoTuHFWmujzRNveH
	s
X-Google-Smtp-Source: AGHT+IEPD/nyGIub9sQDASkOE2Z5yeFROOIHA2Jy58JImAQhVFjI4lxE3zRjeFBC42PQBcQ0ydGGEw==
X-Received: by 2002:a05:600c:1d0f:b0:421:5329:227 with SMTP id 5b1f17b1804b1-42156351adfmr24282375e9.26.1717606632120;
        Wed, 05 Jun 2024 09:57:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe343sm29099175e9.6.2024.06.05.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:57:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/5] arm64: qcom: sa8775p: enable remoteprocs - ADSP,
 CDSP and GPDSP
Date: Wed, 05 Jun 2024 18:56:50 +0200
Message-Id: <20240605-topic-sa8775p-iot-remoteproc-v3-0-a437355b8c7f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKYYGYC/33NsQ6CMBSF4Vchna0pl0LRyfcwDgVu4SZASdsQD
 eHdLYRBHRz/M3xnYR4doWfXZGEOZ/JkxxjZKWF1p8cWOTWxGQiQIheKBztRzb0ulconTjZwh4M
 NODlb86KQqsoFlCkCi8Tk0NBz5++P2B35YN1rf5vTbT1ggAPucdCj/3XnlAuuzcXoSlWgjLj1N
 Gpnz9a1bINn+MTUfwwiVjYgMZPi0mjzha3r+gYyYdNlFQEAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=dACpeN5rm7AHMWY75GC80Jc6/6kkaazWTf0vL0Ep9SI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmYJjiul/Yqy8VMGsIy6dvzNBRj3SS5iWEzwoEF
 tGAJpBf/DKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZmCY4gAKCRARpy6gFHHX
 cmCaD/9hoSq9+RQbemBO2DPWlQk/oa7N1JU6s+SFnseiDUAWygic1HWmM32wyABMuEt/XyD9jOJ
 ADbLq6jLSjc/ky4nBeARLKZohoynMTH4Xx43BJbRoPKz3YbyMoUGtQG8P2pvKIG3HbqNCVP6GSq
 XCLJPKRD73erZE7Condqhw3dMBVvP2j0Hgeq7KgiAHVYsgsI0VYABFSiO8+U0h3O/JG70KJiIU9
 f/9uzz0jLci4B7nkiuuw6JkgHqMHBU1ITGDn7DcWlZTUbdm801AX2JeR/K0yC5CXLuJpsXN146f
 ir6LnIHv2xrvcvaAOElrd/u8iLohNeemw/AXFB1MhN94Gd38gNOKelvCFkVsLTCY5Dto/25s8OQ
 NZ1TzY6eKtgiybmx1yWSNUv2EPmk7c/hZEX8o49Xcqj9AwMDjHUMAHkutPIvNehiHn7kAA8mLYp
 SbII0W70qrt3Ff0+vbhIa1pn778MAhCG0Bo4C6gHNNIcNvXcpupY/2Gqvj09UJTifYDSbhvIEly
 AayfIOZWqMH1nNGpd6PyP3Aumf63p2JIBaiiNGPRMf/MzFoN2wzzCkLyiK7SIvGQYibnoQEWjG/
 J4rfH7i1tFvYbAWy27gAsE5LZ61YxHvm0awKuRJ01hGMQe5VGdT+xpjB9IpXwScGRB9eECAvJrf
 ZDaS5ocnMFwgmnQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Add DT bindings, relevant DT defines, DTS nodes and driver changes
required to enable the remoteprocs on sa8775p.

To: Bjorn Andersson <andersson@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Changes in v3:
- Unify the nsp power domain names across both CDSPs
- Sort out SoB tags
- Fix firmware names in the PAS driver
- Fix cdsp0 name in bindings
- Link to v2: https://lore.kernel.org/r/20240527-topic-lemans-iot-remoteproc-v2-0-8d24e3409daf@linaro.org

Changes in v2:
- Move the DT bindings for sa8775p-pas into a separate file
- Link to v1: https://lore.kernel.org/r/20240522-topic-lemans-iot-remoteproc-v1-0-af9fab7b27f0@linaro.org

---
Bartosz Golaszewski (2):
      dt-bindings: remoteproc: qcom,sa8775p-pas: Document the SA8775p ADSP, CDSP and GPDSP
      arm64: dts: qcom: sa8775p-ride: enable remoteprocs

Tengfei Fan (3):
      dt-bindings: mailbox: qcom-ipcc: Add GPDSP0 and GPDSP1 clients
      remoteproc: qcom_q6v5_pas: Add support for SA8775p ADSP, CDSP and GPDSP
      arm64: dts: qcom: sa8775p: add ADSP, CDSP and GPDSP nodes

 .../bindings/remoteproc/qcom,sa8775p-pas.yaml      | 160 ++++++++++
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts          |  25 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 332 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 |  92 ++++++
 include/dt-bindings/mailbox/qcom-ipcc.h            |   2 +
 5 files changed, 611 insertions(+)
---
base-commit: 234cb065ad82915ff8d06ce01e01c3e640b674d2
change-id: 20240507-topic-sa8775p-iot-remoteproc-6647b50281e2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


