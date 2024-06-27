Return-Path: <linux-kernel+bounces-232132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1372291A3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CE11F22C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199514D6F5;
	Thu, 27 Jun 2024 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUVOiFSx"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83614AD10
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484373; cv=none; b=ockk61ROi8lCkJ/waC18lsA5McdxaCNZClQgkPcfR3HjBANS13MoeNToxTZnKNuOaUnJWag7HTF/SEWEHjJ4KCMEJeMCLjuCfZr4kLzw2HdI4VMg9aGxvLem4/9pWOTRJQbotIMtk1fuF54QWx7tt91YObtd2tK6jfM3kov5P+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484373; c=relaxed/simple;
	bh=eBkgDNh4pHGUWCoUfl/IlA17qsQPFNuKObA7QeUtfcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKqxh8f8lHD9BOHLeBv+RJ9oCL5RF5H67sDYu2HLUsK2CdMVwvCDAAiF51mx4WzK/LPG2CWFJC1FqWdg2Xak9wTfQf7PY4vwF3Jq4wNfCQnz6dc0OIB5FJ+UtWkuyEHIRGvCQ59+n+7pdeh2yCmLtlr6R8HZhlEMYTuphg7gipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XUVOiFSx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so10296795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719484370; x=1720089170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moMeCjYqhEN2XITayIt62CdfKAiqtD6Tk3XXyMm1xxs=;
        b=XUVOiFSxSKhZuh6qKj203CSmQIt8kq+cNdZUCiEO4LoNMbOtbLL0O+ggebGuodB74D
         f/V4YRUpfY5lHGBeS9zPPcHA5Pv1LXFfBGUIpyFcOiVOHHZvPY5N/s2il7hzYlXQl09O
         rs3fidbCMT45dLwaXvSauEd07nnkQqsM5nUCxtsv0T5Dy5Yj/itcvDmhfQHlWKX5iPrg
         8K3LRgfJqVJK/InAcDq6HkEkS6rUQf+pFCusc1cqvMaQd5M13/GdAkkCjwRHg5+VSwp3
         Qrdk6fI4nPG2MWdqF7CVpEZVuAC16rC4D6tfBGgEo8iS1Jv2W+ZySUashfMyx3+UJ7Nr
         9cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484370; x=1720089170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moMeCjYqhEN2XITayIt62CdfKAiqtD6Tk3XXyMm1xxs=;
        b=m8D0Do8bOOCe+ZsIzhiLV67coU66XVu+aE7ywGksN8Oc4PXs4jBv46z1sh7A7/Mo7v
         ZcCAEjgAN/iwA/qYTw/iExEDATpywM42bvMmi6AZpEf6HwvC8gbO+kItsQx+wuzmtfrx
         8tcvESFHHmi5g22RL9fk6Phbdv2KjGgfzdBqYg+1Zk4NBsfbsDrb6LSfGAgDJQC1oumk
         imrebDvBWGQ/vpna63+pV9guTxoHmB2j6sxAy0RDygFL3Zg5g8BsIHg4evqJVQAr3euO
         zXRRoxVrQPBbWhLYwKyPRlcTiD5Bzuht3jsd5tt0UVuU+XL3/KTtRezDVaLY6jJvcOUA
         BVlg==
X-Forwarded-Encrypted: i=1; AJvYcCUWviJ5OgAGi/dlXrJVT7uoY5MmCAk+hKEsbFPzhRAx/oT8j72S3RsixF1HO7aUnuvJtioVuyWz5DHKEDY620Yjz9+EGc0d9HYMmJr1
X-Gm-Message-State: AOJu0Yy5tayxjGuBN+BYjsqRI6WAxzqjfcY1NSiwervPTEyEvnpE3nvi
	2Y3tr/1aZjpX6H0WwFtaQ4ugHORtmG613H69VDHc0MtxKzFhKP6isfFPLEzrhl0=
X-Google-Smtp-Source: AGHT+IHfThQWcTK8yhGvLnXD3SYkW/snFLoh2VKnBj7XvwVZXHgftyUMlS4e8tS9d8NirOXboCgLnA==
X-Received: by 2002:a05:600c:692:b0:421:7ab8:59c with SMTP id 5b1f17b1804b1-425630fced7mr22138845e9.10.1719484370073;
        Thu, 27 Jun 2024 03:32:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367435852afsm1384352f8f.53.2024.06.27.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:32:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 27 Jun 2024 12:32:23 +0200
Subject: [PATCH v4 7/7] dt-bindings: mfd: syscon: Add APM poweroff mailbox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-dt-bindings-mfd-syscon-split-v4-7-dc6699a9f3e4@linaro.org>
References: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
In-Reply-To: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Rahul Tanwar <rtanwar@maxlinear.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=eBkgDNh4pHGUWCoUfl/IlA17qsQPFNuKObA7QeUtfcs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfT/AfKoJu5OgzBj46/nykZpwckUbMSiTIyPia
 OhyT1Qn0KiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn0/wAAKCRDBN2bmhouD
 1+onD/kBwIHKwA1zJIARnF0HNDBQtLZo6xmpXFjybHv3nlswlF607d+riKqd5L8Z0a6lezEa8J/
 keLOo7ycWmGTfvOT4KBybbdkVmkXrtYQzfb2ywDZDC2VBrE1k3rUAnJKj3m3lgJE9chNn5BSzMq
 CfegzIPkGnmRmS6MZ2wE0M5rIqJILvswpNvTId+kxuqJLbYyX6rN5XbzoydB4+Xw6zSSZ4TjkzL
 KM6T6Xo7fpBog1/OR1XdSGjq9IuSNJQqQadSRzcC725RErseufXcUMZmEkU3tS+ag7J2dMnW/SU
 hZU7jE9+oBq/j0ZWSC9wiFZR++CHVYADbc943gioqncA7mi3gyNi8/TlEPHj92Ij26wQcwlgmwD
 kU9KDWDDv8Nu/QgDZx29PnbFtPyGXyhlselpcMLtUuEee+KJLAhXkH6M+CtpscQHQyYsbffEOli
 Sp9K6FKb5byhaeMnNsT/HUmtAg+TiU0rVl+4o8lm24qBSCFCqDVOPpT9eF6MpBAti2z5DZvDkoT
 AkqxW8HC34j5nCq/5bQIRtIqxqREhJEc8piHjTAsnzRSO8G0rtYejVqtaDAreVz4OS8tN7ek7iy
 8fTiTjpfERDYq1oymiG+Mdb6zW3VQO/24sGwFTCsMe+ZypYPaEpSjV0flXX+sx2c7IhX0tZNZyV
 UvU+hFFU/j96kdA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add compatible for an already used syscon poweroff/mailbox block in APM.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index aa1c2608d326..9dc594ea3654 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -41,6 +41,8 @@ select:
           - amlogic,meson8b-analog-top
           - amlogic,meson8-pmu
           - amlogic,meson8b-pmu
+          - apm,merlin-poweroff-mailbox
+          - apm,mustang-poweroff-mailbox
           - apm,xgene-csw
           - apm,xgene-efuse
           - apm,xgene-mcb
@@ -134,6 +136,8 @@ properties:
           - amlogic,meson8b-analog-top
           - amlogic,meson8-pmu
           - amlogic,meson8b-pmu
+          - apm,merlin-poweroff-mailbox
+          - apm,mustang-poweroff-mailbox
           - apm,xgene-csw
           - apm,xgene-efuse
           - apm,xgene-mcb

-- 
2.43.0


