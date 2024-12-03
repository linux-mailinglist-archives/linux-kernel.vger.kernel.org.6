Return-Path: <linux-kernel+bounces-428728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5369E12A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C116AB22E16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226017C230;
	Tue,  3 Dec 2024 05:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5fHJvd2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF417084F;
	Tue,  3 Dec 2024 05:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202440; cv=none; b=KhU2ir2xRBj3M3LlKFbihx1fWfhuy+93HkKrJDnlWGQlOiJxiRzaY0oF7Xmm83S0NiCdwMcTljP1DPLvJp5C/VyLTSC66SD5pNcom4SN1xYplq21TVHOk1SPaQR8PrrLEnE4iETzR2rPWyBfePpnZ1P7VBUFxeFmLKE0QYr6dnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202440; c=relaxed/simple;
	bh=99+pLF1VvDcoovFOPcNeSVJ7IG/4gdQK3UKOnT6V4Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJUFYvRZQ40BLemu3eB7+vJ0YpCihDafSUD/C2nzJz3yZ1FeN5hYrdLci8gUhdnPwasOyM76i4atM9K4vSgVtf3Y2rbz+jTeWM5sZRQtJNH7kVYXeS4WQw9AKri/8Bal6yCvvzoyp1i+zdJ/wLG2sb29Vj40gIqGwVprhjp4s+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5fHJvd2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215936688aeso17104245ad.1;
        Mon, 02 Dec 2024 21:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733202438; x=1733807238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyr6yNUD2cI7FDLN2P5orlGmGipVdT5OT8foTnjmml8=;
        b=I5fHJvd2T67lpixu66DY57kRt4lBubLjC9OvqHff5D1NYd0ngOedX1iUGHNa3UI4OS
         lCXR5Y6i7ULhe0mJdoS9WE44cOoSMQ+MQ0vWnRcAsLfXq4zUpnvD/aqiZW3ihsY19VqI
         WM75rQZ1trKpnnRpAWQM/c4+MafIjMZTFXh+HYSPDu+SD7+tBNvErpWucPA+2D31SeoE
         dtrA3823VBOnTa34Fp9MUw3V/IC2rXvhW7QSuCviar4NqmQGmCbABDB87w1N3CQUUnI8
         HjUdeTopL6y3/t3vOQhdp4ZnN+s5oI1LwbjZFLa5eW+UsXlCVZECE1+iY2KQL9efAmuA
         vzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202438; x=1733807238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyr6yNUD2cI7FDLN2P5orlGmGipVdT5OT8foTnjmml8=;
        b=Q27RCUYRZ3NIz0sfTWw5B47JcUKyvKH2cJeTNJ7Afm5005kP4JxbecdkPO13cY2w3J
         cjrY1my7+7RGiBRPmFAGaJOsGCRPtG1ADT56rwIwXdkFL7RFmMvU/JSIk5YCnTqsVZSS
         P1tQg+qsFXXbrPtd3fbDuinb1RIL5W5qzzc+JlUYgNcaNMQaomblv+UNWMVrNrF1si9v
         MWYF+RQZCWCyLO2kN/rWru1DYhmpAVzl4sxB/0yU7sEjfHZgxxKGqTxzGPM9KEZhwUtH
         BC5d2vk+o6I7EwbVMI9URxzE3AtFv//Z3kRXkqWuvzn4cOYqqsT5GHxoZRWs17XiHmlG
         sxPA==
X-Forwarded-Encrypted: i=1; AJvYcCVFBj/gIU2bUN/vRWmjocqzBpt7AKOptS0296avv84syjJeElulvpUohQ5ZA/dh2JStZdWA9aFf/b2vWe+5@vger.kernel.org, AJvYcCXW41G3MKYN9wFyW14wjjWVs345XKxN4BkI+gO7dHadVNwmmiq30ZfTMW7dbAIfi6yHVa9b7Ls4GCxu@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDyOQ44F+8gu3t3mIrg9vft5Zgg7Awju8zDDWGTziG20lP7XA
	upZbcKSsrTNvfcIYUKjVNJHNWqamN9FukdxL4OokK15h3u8tp8jf
X-Gm-Gg: ASbGncuYfKAe6VZ7ZzC3dPDEeVfK3BDdFCvAhuAUe3PaUxECqWsdSmf/Rf5pGA6HgM9
	UU9oYQ9yubzzho/0YVdTohdixYPdWgiJWV5upUCHiBVWDJ5ncGcwTAf/bqoHmlM5uZuyRIS2crD
	W5qvmNHkFS2ojW7KUYoTNluPuMDYJQO9JVRXefxdF4qpWOkXdgnZBxsky1hMIsxpfPiRUICfROA
	zkMl7/kxBog8a32Ol3eSbPLI+dq5/ukpgny7fGVzn1s1ucx0oCugFP6eXwHKuDS3w==
X-Google-Smtp-Source: AGHT+IElMVKx4Nxypl81WAMWqHN+sikDERzQLkt8r2zBkiZ8BQoWhKpWu6v4bc6zILe9UH8q6vfqsw==
X-Received: by 2002:a17:902:e548:b0:215:b9a7:526c with SMTP id d9443c01a7336-215bcfbc21cmr19308075ad.25.1733202437604;
        Mon, 02 Dec 2024 21:07:17 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21586d40afasm33242385ad.270.2024.12.02.21.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:07:17 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neal Gompa <neal@gompa.dev>
Subject: [PATCH v5 01/10] dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
Date: Tue,  3 Dec 2024 13:05:31 +0800
Message-ID: <20241203050640.109378-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203050640.109378-1-towinchenmi@gmail.com>
References: <20241203050640.109378-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks found on Apple A7-A11 SoCs are compatible with the existing
driver so add their per-SoC compatibles.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hector Martin <marcan@marcan.st>
Acked-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index 673277a7a224..5001f4d5a0dc 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -22,6 +22,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pmgr
+          - apple,t7000-pmgr
+          - apple,s8000-pmgr
+          - apple,t8010-pmgr
+          - apple,t8015-pmgr
           - apple,t8103-pmgr
           - apple,t8112-pmgr
           - apple,t6000-pmgr
-- 
2.47.1


