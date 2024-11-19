Return-Path: <linux-kernel+bounces-414338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9089D26B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A79B2BD66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA11CCEDD;
	Tue, 19 Nov 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRW/wFl/"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF61CBE89
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021836; cv=none; b=JNj6Xwg0vwXQuB8NJLv1uHea5H45fJVpjjfJB7jEhUtFg6VVYhfwDdIw817vBc8WssLeDBrK+3ToSjdFq9yhzKA1aupO7rkP9BWmaNo4UCHTJHHXnAt9VBBprLCZpbgtQrPIO+FfUGgws2Spb+Gc0mxrY3IkDU4CTuOI9pg9AJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021836; c=relaxed/simple;
	bh=4fXNyWptEUJ9NqiDYY4v5f2MA6FE8JIpt+fHVIuwt+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FTBttSJJb/KMMlcPUY5Rtbo30vg5O+9G7sw8TYPgYH/Q9pxJ+X2/WvRNKYQvWMqB4vQlXGbepDX2TuvKetvFTqIUqQCc29GLrDSA2PzJiCmVu2zpHxxfp0SD6naIzumXc9EAAJRmT7BnPaqEwRqQJrT2vAiOHeEq1ABpT6K4zwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uRW/wFl/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so38456855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732021833; x=1732626633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCd1XDFaDcI0eu/5aCsZjulpUPFQcIcFClGyDjhAXE4=;
        b=uRW/wFl/vKGPh88hCVHGj8Kc5Lbj/5byEinOJs5rYAPJNT4tezCpD+SuiMW+GdSRDJ
         TJw5+bMxIHSM6m0J8wQrE6obeYYTwNtaiLnnW5xpN4JdzDq+IZGLjbnrRERy7J+cGNtw
         AZJ8WNOVgC20p9u/qqqX5jB1RJF9smcyhqkR+NV/Sqxq4uQVz3wJQs3YyXzFzZicrtwU
         DhSnDzftLph7Pg7jkTGQY3MyspN1thpcBMSZbtg+oBGe+lCFyUDAcqlrfE+8X2gLwHC3
         3lNbxn6gJ4zkneyTArda2MGHlRa44tqy6y5x1rTa4UoIsJd/rynvldHMtxjp4zoZwgn6
         NrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732021833; x=1732626633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCd1XDFaDcI0eu/5aCsZjulpUPFQcIcFClGyDjhAXE4=;
        b=iVtqlEGqA6467VLFlHoGKHrWk4LFz803VWFX6o7lT8n9Ip+4V4keqnHMlUXO7lRftu
         sTHH3a3d72k9iy3pJ9btX+dW9EbljNF1vkcS6pOVEtFtNQ6cwwrL85gB1rl77cjkjgR3
         xRylfNwknqBSHIBaK1YDMQQmWUoazds5sJNI5sy66/AhTcBMsez93xoHzRafN6JP6avI
         O83N9Pp9fr+hZ2e0ANWTu80oNRwHqWMkEkXWYpTgaQaZXTlU0gxF7dl1j/EM20An6AVc
         FuysWk9gc3aVi/pCB2joTmX23qJCd5AvpiLe/yWPUGFr6NBFw1xjgtUosniU2mNO4/ov
         sGBw==
X-Forwarded-Encrypted: i=1; AJvYcCXU65kKDy/VusYet9qOVYJLIvER0INblZ0HmSh3QRP86iOzFttFlke+Xqf7lxpwuJsw8P00zCI3k7Px05g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pd4oduTBTapj4B4EFx/MaIr+QRFV8djD8fTSty9l/742VVwL
	s2vL8vWnL5JhYlpJU9EKlr7FYZN1EvaYLOtYxLDUA+HXz16NwJJqqw8gZbHQTuc=
X-Google-Smtp-Source: AGHT+IGusP/UzmZ0+YghK5T/t6qFJwR3QEG3Zd6a+CKh0Jg8Puhh2L5Y6iTO7QAmcU06sOzzeyBDEw==
X-Received: by 2002:a05:600c:3584:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-432df725532mr135846905e9.11.1732021833272;
        Tue, 19 Nov 2024 05:10:33 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab76dafsm192016185e9.10.2024.11.19.05.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 05:10:32 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/6] Add dt-bindings and dtsi changes for CAMSS on x1e80100
 silicon
Date: Tue, 19 Nov 2024 13:10:29 +0000
Message-Id: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWOPGcC/x3NQQrCMBBG4auUWftDJg1t9CrSRWxGHdAomSqB0
 rtbXH6b91YyqSpGp26lKl81fZUdfOhovqdyE2jeTd75wMxHXAIeWj4NRdoCH8AMjsiLKRpLdOw
 c5vQ0Q/Rp6Md+yG70tAffVa7a/rPztG0/dNJJzHwAAAA=
X-Change-ID: 20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-82a63736d072
To: Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

This series adds dt-bindings and dtsi for CAMSS on x1e80100.

The primary difference between x1e80100 and other platforms is a new VFE
and CSID pair at version 680.

Some minor driver churn will be required to support outside of the new VFE
and CSID blocks but nothing too major.

The CAMCC in this silicon requires two, not one power-domain requiring
either this fix I've proposed here or something similar:

https://lore.kernel.org/linux-arm-msm/bad60452-41b3-42fb-acba-5b7226226d2d@linaro.org/T/#t

That doesn't gate adoption of the binding description though.

A working tree in progress can be found here:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/x1e80100-6.12-rc7+camss?ref_type=heads

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (6):
      dt-bindings: i2c: qcom-cci: Document x1e80100 compatible
      dt-bindings: media: Add qcom,x1e80100-camss binding
      dt-bindings: clock: qcom: Add second power-domain to CAMCC
      arm64: dts: qcom: x1e80100: Add CAMCC block definition
      arm64: dts: qcom: x1e80100: Add CCI definitions
      arm64: dts: qcom: x1e80100: Add CAMSS block definition

 .../bindings/clock/qcom,sm8450-camcc.yaml          |   5 +-
 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/media/qcom,x1e80100-camss.yaml        | 354 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 359 +++++++++++++++++++++
 4 files changed, 718 insertions(+), 2 deletions(-)
---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-82a63736d072

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


