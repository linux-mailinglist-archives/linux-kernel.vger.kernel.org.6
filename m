Return-Path: <linux-kernel+bounces-204310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5519D8FE70E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05512285848
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810BD195F14;
	Thu,  6 Jun 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mg3dRO4F"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB019598A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679052; cv=none; b=cw4HyIe2zIMh9pdvQjF1wNyngArAO1I8rpu3FAAbKdOXK5X7muMLZXt6nibqU5jv5ah1Fkdyz+K6bcerqsVWEn6imkmLZZ7pSScufdgZ6AUaLVhLQiSkxF1c4nmBak/60m9UV+Ic1pl1l5W6YoaICzbIQSMuMZKQGcaKycWjvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679052; c=relaxed/simple;
	bh=vzrrnrsPs++w+wuxgBiG4lQEuVgC7hadEd1CorTRM5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDJjeCGGojQC9MsNc6iISzZFzd8gJY7RK5l0NPtJMYMg6DPaIY12plmXlYym7d8T8UIhjEbn9U8iyfbg56pj/vYCio+dSNU4w4aRAQBk/hJnSmE7XoRrY12vudpf68zlEyEjyg1eAQJXTh049ukjhvCqriF96qLaMdqqD70mRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mg3dRO4F; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b7c82e39eso1029258e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679049; x=1718283849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKOctS8wR+JRhxMzTY3nM1CjlScan5iuXQc5lzoQeM0=;
        b=Mg3dRO4FPQluNULhn0l8oeSoEw5r2xCbD254BzRv5u4Zhym5HtUkYfT0pCEa/DyazP
         enTpm1lMBUtKiOeQo40sb/+1eBwRl+JxrBjjdcJPznOwmce1tvTGtOUg74A+NTSdXSD7
         r6ficCVtQZNaaXd9WWGHeOKVpi1BQ2igSerCaMYGZGfgKDKcyWpryXUNIl9TKC2dK0Mr
         vr7FS6GkLfz3I/5qJclX4UouD3kP0LtEZa907lx7xe2gB3RCrtGWW03WjQFdHidRjlWz
         MOkQJ17AgZfzeN8vqnWkaaL83mXQQ8jAG3mR+fnH1pweeTez30UKSROj+d5feHwmamcF
         aPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679049; x=1718283849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKOctS8wR+JRhxMzTY3nM1CjlScan5iuXQc5lzoQeM0=;
        b=jiDnuSkE5Nr0fnzYCyakCVD/sIGQQnrXXB/4SJz41FpPcw527zFiQYjwoSdaCGvZ1i
         yZtqetBfBtoorvdCLEsb5BUDhD4W3ZiQwPltAsV+KmI5hqYX/p4l9GWwdFACuudEZ3rz
         oRXoTTY2KqQkJY/6EkXs8I+qVJ46T2KR4hXubgoz6kq5+kKihxTKiCRnvQdGHYfrc2lQ
         iTocM2CqSjrsWHoFld4PeyoyS90cd8MctPayFdz9NNlRUPiaxhel2dgo2zvChlMRkQBx
         Rkyf5zPcHlZXFknlfmoDJBHO4nsHu05wqg+F9/p8wOTpNdvHILp+gpUdO0ABd6N669rg
         9Iug==
X-Forwarded-Encrypted: i=1; AJvYcCVDupvu6gm0iBqheG9nqRa/ZCtzzug+4NByJ0Zi9OlBMZHtjmUq3r4fAv4QCLtIblzX5NX2tLO5lbzFUmv6n3T0VCw402BSnxen0Us7
X-Gm-Message-State: AOJu0YysxK5WS8/LwWCbQgwrn1OQjYnXJWENIz9aeSOWwQQDAeAKyPqe
	d6/JD7xSBlTvvPFQK+AJBRowMtAtXTclrJ57pOeuTrcJ4M75njRBmZIkvHRH2w0=
X-Google-Smtp-Source: AGHT+IHAkM82zSzTg7E23bIybOGdXK2SBfH/dbKc5oL32jns+PWFQHQwA/GQ3GcMHsqZEYS5Y1oAow==
X-Received: by 2002:a05:6512:3b8b:b0:529:46e:b2a5 with SMTP id 2adb3069b0e04-52bab4ce9d6mr5269249e87.2.1717679049193;
        Thu, 06 Jun 2024 06:04:09 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d49dfcsm1505286f8f.39.2024.06.06.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:04:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: andersson@kernel.org,
	linus.walleij@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org,
	inux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pinctrl: qcom: add sm4250 lpi pinctrl
Date: Thu,  6 Jun 2024 14:03:21 +0100
Message-Id: <20240606130323.138970-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add support for sm4250 lpi pinctrl.

Alexey tested this on RB2 with HDMI Audio.

Srinivas Kandagatla (2):
  dt-bindings: pinctrl: qcom: Add SM4250 pinctrl
  pinctrl: qcom: Introduce SM4250 LPI pinctrl driver

 .../qcom,sm4250-lpass-lpi-pinctrl.yaml        | 119 +++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   9 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 .../pinctrl/qcom/pinctrl-sm4250-lpass-lpi.c   | 191 ++++++++++++++++++
 4 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4250-lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm4250-lpass-lpi.c

-- 
2.25.1


