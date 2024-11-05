Return-Path: <linux-kernel+bounces-396347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDC9BCBF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFC3282B60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416F1D4612;
	Tue,  5 Nov 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyH7SbKj"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFB1D4159
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806675; cv=none; b=DFMep0OusAp2msKVIWw1vFG4lVBziqt57MYDGAIBsUYjJy1hkm64hNbBFigeMp5VNil785b7/BgcZqozdvqZ+CktvqlNTodFAOL4N3sybO6eSB5nHaHlJPrM6sOXSSTdUULXQ0dLoot07LLthAmvut8QGzNk32F+K6tz9Ronwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806675; c=relaxed/simple;
	bh=Tc/LxNisPnqK3ZVg2tEmFDAtA7VsSiFfNLHtH6+TUXE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ag7DWnKV/P04KVGX6Ds/jPLSCv7YTPsIqKw1tuyxwQAxUJnSHbBeLISFCg80hNfnaMww8pHVvULsDM9jGCcxIBqeiY/5ys/oGNlupEeYyf1Q75JG6rrCgEerkxwkNpTOxaQWtG5jBr7N11U7D7ppY6Cf8oZ9YNF5GI+btqDd/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SyH7SbKj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314c452180so39248335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730806672; x=1731411472; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTS2gc6y8g4HzgDHldHc1Tpj6obVtULX5AtTPFs+r9I=;
        b=SyH7SbKj/NcJwCsrRWj2utABB2KNzoo8oGvsdxe7EFDXiHng9L3IVMaG/2VJa0HFxb
         GtIoAoFnMgsMh4dVJGOGVA6eRFJkhqviq0xY0harsf586ZZFCwGZ0y17A0DaWP7Q9rXZ
         LYh25xUIXvwKvSTS1kQU3w8tRAghFGfVQUw9fdnx07/T5ctkC3EF2wq8CxtRxqR9tMCF
         Ej0+4mi6pXYT2Xv/n/nQr6UbH5SCuh1jZxyAc2kSAsVGv1Gv+fl5m8qj9xNSAmKwMehY
         aiwJAVMNpMjfkZ0wAnDDaU2EROlhqnYKufL2qIjyM3ftAZg30BEvphFvf7KyjQhbZGNx
         6skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730806672; x=1731411472;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTS2gc6y8g4HzgDHldHc1Tpj6obVtULX5AtTPFs+r9I=;
        b=TBbD/2XyYW4R8HLm1EEjcjDML2HhNgqO45QrNNhAsnarPK07KjR8UZnfE2RURipAPB
         V9SJl0AE/XPuAoUr9zSI3sAD4o2w24ib+usYI04Oc3e1q3SWmr7yd5hr+tc8Lj3FSQiw
         VKf4j0b/sYyc8ZMnD60o56cdNCmn0qIQ5JxqhzTN0X6PcFYTmren6qkq/nsIXqpi4osS
         K+ulAI5WztwHFMFmBClZE43Lv5fUtc2OP/rwTvkRx3iqkDSp1GnB2Ga8MxBuyY1ak/nG
         n2klHWzEPlCbhsOZFgaHhXlyIZHsIl1ej5aKBXMh7wYJ0fy3wATAXX7p1ZH/CmaH0RZc
         ct2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX28x9a/Jr0X1gHgskbr07TmIu+4VBoEYRSv7CTA23YOP+QL12X/ntDU8wGGfkUGCWwKzwVAx4PTrGuwn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVrvrN2haJe8eVuREe8scAS3RZjyT7DbmZprAWkmVT6XIzUygb
	FpYyKu4vdlSSguNXIWlVWd8ms19xGuqeyvWRGFYCb4E2SpJZigbMDrkfY4m9dhg=
X-Google-Smtp-Source: AGHT+IGQBWlVbsPT1/HCnsTXquuyZb5k48mecL3QSTS47+KllfjCs+uwEVRroLM4suPvXKPcb4MsqA==
X-Received: by 2002:a05:600c:3b93:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-43282ffedf3mr135719425e9.9.1730806672029;
        Tue, 05 Nov 2024 03:37:52 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm181816845e9.12.2024.11.05.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:37:51 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: x1e80100: qcp/t14s: Enable USB
 multi-port controller related ports
Date: Tue, 05 Nov 2024 13:37:31 +0200
Message-Id: <20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-v1-0-b4386def91d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHwDKmcC/x3NQQrDIBBA0auEWXdgxiiUXqV0oWaaDBRj1ZSUk
 LtXunyb/w+oUlQq3IYDiny06po6+DJAXHyaBXXqBkPGMpPDneVKTITvmLGxRUk+vAS3GrB9s6D
 HvJZW0TkTZRqDtSNBz+UiT93/q/vjPH/qMv+hegAAAA==
X-Change-ID: 20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-552ced3b4430
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Tc/LxNisPnqK3ZVg2tEmFDAtA7VsSiFfNLHtH6+TUXE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnKgOE0DiN1WpOCAP0auG8sTYtmVpW+8jaP+Xly
 m42UJEGRtyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZyoDhAAKCRAbX0TJAJUV
 Vk8mEACea0pgHeeQhuzqhQH1Te982Ap/E+9YZ02kQRDRuL+puE4khUSqIXIi8eS2qDToU//5yyd
 fe4ZhR6XDJfBu3xPS2fvRdOSIMOtpz28CrhxrGdVD2QjqUG1C1u2uokuOGsmOCuPz+q9dIeTypp
 gwFsbbaWDPEevjJdxAkO2B/VIQMOFPDUXhoAnJhjZbk39mG47Q4Gl01KqXDgIHdpIK7KM1Ija1G
 SKubPAus/8OCrdvOhxLX1kCg9nqxck8wYiEgL2T3/sqdSOsIsQ8+SGzZsWwSzDvwcsN/nDhoqsX
 lvQpQDRwon2k1BaABt2R7iKeUBXWjju0BHh/2UXWN0R2i3aG9KOy4Vf+WhM2SaWnKhL+Z6YBt89
 tVohyIG4QZs1oFvLmJdLLUI/OfVjqFgaJSAmgZEl9qdaMWC6QTdUKWE950dkhOQLGDjLbHmkTsy
 ysbXdIuQC6QWtSQoO7AwN9YuERKQ8TGh2QRiwAFsPEEpRqsWVJ1kBIUgDo4hnHVnRXDvkdUpW0a
 90ip6uOVwIXReUownXg3gi9DJ7xZk+9JzGeFVEfuXwcxwI6506J+ob2xjR/TH5D5Irb498M6+dL
 BCEJBwW7qlE8TkcHxAtCOXmBL4On7N5RuArgq+EC/9g6Ask5fq4jz9MKSlQJRe5Uwygu3TjLkW4
 HklzKKXLc3Ed6/g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Both QCP and T14s have 2 NXP PTN3222 eUSB-to-USB2 redrivers used to level-shift
between the USB multi-port controller High-Speed PHY eUSB2 and the USB
Type-A ports connected to it. The QCP has a 3rd instance of this
redriver but is connected to the USB2S controller.

Describe the redrivers used for the USB multi-port and enable each pair
of PHYS and controller in order to enable USB support on those 2 Type-A ports
on each board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      arm64: dts: qcom: x1e78100-t14s: Enable support for both Type-A USB ports
      arm64: dts: qcom: x1e78100-qcp: Enable Type-A USB ports labeled 3 and 4/6

 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 86 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          | 86 ++++++++++++++++++++++
 2 files changed, 172 insertions(+)
---
base-commit: 850f22c42f4b0a14a015aecc26f46f9948ded6dd
change-id: 20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-552ced3b4430

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


