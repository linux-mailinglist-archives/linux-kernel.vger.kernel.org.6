Return-Path: <linux-kernel+bounces-211123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A1904D73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A40E1F233BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1F16D4CF;
	Wed, 12 Jun 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZbydQMKl"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAEF16C87F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179341; cv=none; b=bbOPc19JkPtsV50WWutTv6PrzYq5IoKY6RMv74JiQsbY7chCnmdtQPOln+qATs7Ps+8XS+Lm5gc01u/dVoPCfCmmHqFzNia7bGzXuvWnw91mQeZR0g+OiZFcF3ftylZOWJYtDfUa8IkerLWVenzrnHRmIgkgX71xFaxbfeIKxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179341; c=relaxed/simple;
	bh=NKlZ7znjFHh+kj7hZiP670pYmYfW2icvu+cpn3PRARE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9BfVrRlRtYAxR05daVFgq4TxMd7IE+emYutxvnN7dUcFc3+XRisUlIUWIXqRSBW+Ynt00fUYmtaaouwCpKfjsg8s1Y+ursM14aj0oKqpMbN3AzXSyLWKNx8rDJXHddoEFLzrv6WwOcAPMT94+WCsCFtJQW8gbMRZfJ4+cV44X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZbydQMKl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso2580080e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718179338; x=1718784138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EExZjKlwbakC4pb4Joyu49FltOd+HMKyD/NJobKwfUk=;
        b=ZbydQMKlYajZZ5ZzDwdvOAUB8BNtXoF9pfHI5AQ+oKAzoiB2FPs+fMxzVoeistWhdT
         ZT65q1uEsqJDJ4O4Le3oMroF9d8tWZ/wvPYAuQ5HmGk4etgWTcVqlrZdRo0qwZcjX4l4
         6i3x9JfWfRhMbsgHIhcexZ+D6NVSDJFmh6H8jRArV0TuTknbnDe2iSubpZSMfXAOSgov
         oL3hsikGIMGWV/Ljy9aRWY5IQ4fGq5V/kosK4+fRbLm3zraMosolT0AZPR80mVUG5Mi3
         leXN4Dbh826JUrFlLtTIATf4gplSH6TlRs0vz8CTiIYkFDb8zey3dWqI5GvZR1pMlKav
         +qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179338; x=1718784138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EExZjKlwbakC4pb4Joyu49FltOd+HMKyD/NJobKwfUk=;
        b=lp7NNLwT+pH024mjtpTW5QJrRvluH49CjLsVK7ER2s5R0eEdP6PV7wkyKqzq+hxn6C
         5dRCpMF5lLVVpl1jGPk+oCSKr0yDAhFRTNFnJygwJ1RXoNJD6b+AXiYNqxTXpO9fP06O
         URoVF1hajAOpEPH9EY9x5100f+h583DvvN2A7Cg87PMzQj8vLiw7w8dOBCkNvMmD7oKA
         YV2wTVYnwYlmhbsOoi4zcNNTMWEq9gtsLBMvYnBfPRKh17uqa/Au883D2ZUelRmyMkhg
         jdLRsyCMBLQLE9Dh5mkvfdGA3H6Zk8Ducf8OFYJdi8dhp5N66DaV5ddRCjeLZMMRQG44
         njAw==
X-Forwarded-Encrypted: i=1; AJvYcCULdb+PIosZzXHijgUQ+anHhWsWwQtgR7ZdlLxTGOWWmYy7J/1AWYI8I8kaV3sRVR0T+2oQfg6T7FINSj4+J/aX28nG284xrwVs6aGg
X-Gm-Message-State: AOJu0Yx5tfb1b/aqTSbixyF8D7bCqyVCRvLx6iSLv1Ngd182OZlHPR0v
	ZDuVtxFnANmcK4kra/JTR2sswEj26K0kGik5IVy7TkYZ+gG+ohu8iEGTJCPOwGY=
X-Google-Smtp-Source: AGHT+IEgAbrQVBQiKJ71IEveyfbvtyPuXwEPEyWvlRttT8Lh/Z6rGvLVvLng/ZsGetGxVt5Zz32doA==
X-Received: by 2002:a05:6512:114c:b0:52c:823f:2a0a with SMTP id 2adb3069b0e04-52c9a3b9722mr1031025e87.10.1718179337870;
        Wed, 12 Jun 2024 01:02:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f24c7a9c8sm7452585f8f.78.2024.06.12.01.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:02:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
Date: Wed, 12 Jun 2024 10:01:49 +0200
Message-ID: <20240612080150.18375-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612080150.18375-1-brgl@bgdev.pl>
References: <20240612080150.18375-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

QCA6390 has a compatible listed in the bindings but is missing the
regulators description. Add the missing supply property and list the
required ones in the allOf section.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/bluetooth/qualcomm-bluetooth.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 055a3351880b..48ac9f10ef05 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -62,6 +62,9 @@ properties:
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
+  vddbtcmx-supply:
+    description: VDD_BT_CMX supply regulator handle
+
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
@@ -184,6 +187,20 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p9-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qca6390-bt
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddbtcmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
 
 examples:
   - |
-- 
2.40.1


