Return-Path: <linux-kernel+bounces-246263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E792BFAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2762818BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C381A0724;
	Tue,  9 Jul 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRIbztU0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE671A01A5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542035; cv=none; b=TdFEl8kUeYk53orS4T/yvAMu12Eadd8o2fgm3uAefP8DKlBJo86A/gJ69LFAgPW8lhawn5K4Cwl6aYZ3ALiCyx7FyQEXKXu9lnoZvdSV8N1HHT00oNO3Qqd7wguAttPPpEyQJCmqluzfUPJ1VeDYb4vmhFlWMTMPLFRdxvPatD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542035; c=relaxed/simple;
	bh=5st73kOX6niI7dZR/91fmwwqnxTqrZu6i3fehCAZ5zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUL2fhrZg9lWzNZFoP/ii3tN9UDmV5GEFFskzcA4LwM5MwfidLqN3n9gTEkYoH5AlKMMYpr/9Lr80c4k6iUOWgpC+2dDss+j27heSk3U4bOWQ6PMhBdkOKzehtkfassq1JqariMmWoWYloL4LKn/wsVTyeKNBhTlv5mLbYcJCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PRIbztU0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-426526d30aaso29715875e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720542031; x=1721146831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9DRYaK086JGmwgg9/og5NAl7NqfChxitmX14BDZNew=;
        b=PRIbztU0tbMxRl0zaoaTw4hCPAio8NOqfA4bAJSk+TyP85VQ8AO2syit4mQ+qQ5O/C
         Ddq1NPYlvt83LODkPD5PpJB1+w1477Ql9nwQIV28Dj+DHvDi3yMA3BuJ6Tnj1rgXRVWx
         gTNKSaF/seXjYPNrQrBcFqL8it8TPMoMEK/EPzBSfHmU3tS6SbBVHg1DB+Ez+EQioKXC
         Sb13pzknsUGJMqGYH4p8Neo1PzNYU8QcxbKFZR0qYYKHvKxYgUYiB72PsuqezrbYyTnd
         3DXThzKXRjo0sNWM7JLfN3sk+RiNjRfrQRXyloK8paif8fEI7lhNndHIG6GOp7/XO8+x
         YKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542031; x=1721146831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9DRYaK086JGmwgg9/og5NAl7NqfChxitmX14BDZNew=;
        b=fYfeb4BOAApgPhphZ6SZBHxZRwnVMQ6Fhh4umeWoNeF2hRiIKXGkeYdPKPkm5xzrQY
         RDL7UHnFbpGxiXjDsFyyCFC9GO0Ak6sJx92MBHPtwkFdTTCKzbRw/NBRr41sVoKVA0SA
         CrG1SwT6SbAeMWSAhw8mhm0YY3HaNuJ3c0NKr7B/1RRXFu5xOPHd5dIs8B8tIQJZneyu
         3GLegEj+8/IYnPb/L3qiD/D81H5sQQk0wLRFR545uPi2tIXdi9Pmhb08Rj18D4Xgzu0p
         BM8BzHIaK3FmaTGfsuUjhD7uOBLbQ8UiBI+nl7XVptZAhtt2DpvGjpz2WBnjhYf6RG0r
         ju6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUSwPiI+3n6CH2Dq6IVCIcHL71lJgRskdshvSEoG3rS50QCSHkzoAIJSaUtzpaJsys9XRitG9u8eMV1RbbFLr9iqzS+fnb1Y5aZf7E
X-Gm-Message-State: AOJu0YxL0GTBDb8+V3ZWjFgvYEShM3PcHzLM9UUVqzx1ge/5lGUz9U1T
	WjPefg4fFa9KZgF3FvJmGq2eRqEmRIheETX8meBz7yQyjkWJj0KX6U8oj1/6aqw=
X-Google-Smtp-Source: AGHT+IH20yAq+roBl8gRs1fFr53+7Ufp7oIBFU8tJB9uf/asNe3YYKfGca9kCcuwlS3kQ8aidhWhUg==
X-Received: by 2002:a5d:51d2:0:b0:367:8f29:f7ae with SMTP id ffacd0b85a97d-367ceacb46amr1892463f8f.49.1720542031527;
        Tue, 09 Jul 2024 09:20:31 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e07fsm2966955f8f.17.2024.07.09.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:20:31 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/4] dt-bindings: pinctrl: convert remaining qcom bindings to yaml
Date: Tue,  9 Jul 2024 17:17:52 +0100
Message-ID: <20240709162009.5166-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The following patches convert all remaining old text bindings for
Qualcomm pinctrl to yaml, so device trees can be validated against the
schema.

Thanks,
Rayyan

Rayyan Ansari (4):
  dt-bindings: pinctrl: qcom,apq8064-pinctrl: convert to dtschema
  dt-bindings: pinctrl: qcom,ipq8064-pinctrl: convert to dtschema
  dt-bindings: pinctrl: qcom,ipq4019-pinctrl: convert to dtschema
  dt-bindings: pinctrl: qcom,apq8084-pinctrl: convert to dtschema

 .../bindings/pinctrl/qcom,apq8064-pinctrl.txt |  95 ---------
 .../pinctrl/qcom,apq8064-pinctrl.yaml         | 110 ++++++++++
 .../bindings/pinctrl/qcom,apq8084-pinctrl.txt | 188 ------------------
 .../pinctrl/qcom,apq8084-pinctrl.yaml         | 129 ++++++++++++
 .../bindings/pinctrl/qcom,ipq4019-pinctrl.txt |  85 --------
 .../pinctrl/qcom,ipq4019-pinctrl.yaml         | 102 ++++++++++
 .../bindings/pinctrl/qcom,ipq8064-pinctrl.txt | 101 ----------
 .../pinctrl/qcom,ipq8064-pinctrl.yaml         | 108 ++++++++++
 8 files changed, 449 insertions(+), 469 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.yaml

-- 
2.45.2


