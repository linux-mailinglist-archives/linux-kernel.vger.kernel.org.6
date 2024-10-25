Return-Path: <linux-kernel+bounces-381517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99339B006D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B4A1C22184
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459E1FE0EA;
	Fri, 25 Oct 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PYkZ8vRu"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4D1FC7C7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853170; cv=none; b=XHPSWBYnHeGtq8b0Kuwz3WtO2iu8U+Vq2lrnATtirP8nSTRqpkLRG5z1mPHJEGphQzgH1Lmk3Os7UTgbUS0rs0Vcwb5/mRtLxycDHrp9+rSxtR6wQ6yd7DU5/O4H/Xa9X7xwMaWq6zkYv/RubG8J5loJhMXI5KGo3q26EBg2+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853170; c=relaxed/simple;
	bh=LEnPFvnyQ5b9D3+6su2thKqg/1KZlfYf9MBK8xIMzjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lpz6JZEDySPbWU2h7XYFeBxG3kAKYqSg9IW8XqEAzGGVHNRtkN16Vqp5/cdpUffl/77DR9O5V5T2uh6seUljidog4bnPGDpwlUDs5u3NbBSjdcPUIHI4IBe6Fc8I40TFBotmbz3VY6ZLooYpS0r60wy/wR3EWcKF3ATyZ+K/6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PYkZ8vRu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1366654b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729853168; x=1730457968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwvSraMLJg1mpGTC+YokyY9uCOj8ssrQMVVeDpVPQnU=;
        b=PYkZ8vRup9aQmrkGH9O0gdHOlpu0ji7XoMrxmziA5VnWSrf4wuIwh7aaU3aUJRS7ra
         ks0WaoCL1YtkqWD71JCKs2z2nkrAS7fittxSptawhZTkxkgucWiIvOQzK7hBnWR+0Uxu
         Uukq6FmVtTYZUmFucVyLhXBIp2LL63x0IEHpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853168; x=1730457968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwvSraMLJg1mpGTC+YokyY9uCOj8ssrQMVVeDpVPQnU=;
        b=ZDb/4twoRTVBXs2i7y/2pSh8IJsDbmhcNToLumr475nUGlj3QPSLkRnpYE0uk2FKcH
         iyUQuIfGKdT/dJzuZULif/e3czAcwA8EuNA2nExUlMa4Nydsg8V0/3C18c+8HVTuY7IQ
         Acxp6TlMO8R4qKZ5bCAV7D0CGLnPRQqkBJnBThIeDyWNxAjyM6LxE7uHEaUnpHDuUD9z
         mGu9EIKjgDsaoTO55VADwZBLDvbOO5KMYa/L2+vSUBW2jsE8ptXLO19R2wZJqfBIPAdN
         NHtyWGJFpLzh0laZs3j3tZR/GIDI7XtdROXCbbkJ5U9kCzdDwEImBcpAWA5I5VV1kZ2K
         QNIw==
X-Forwarded-Encrypted: i=1; AJvYcCWSTD6xXWhTkFLh8yDFw+/xyajCkYk3Xb9x+auY5QvM7gfCibc4nKsxW8iV/WU6o3bd7YycCFDWiu4vXs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydunYXFTaU87EdhXmLFMOZfGIocX4R6GX+vPy5xGAH5f4WG7bq
	Ji7h7St9quRsek2qgHULzxo2VMhpYQgacOqwoTDAqbCgDi3RMvzw21D7Y50/0A==
X-Google-Smtp-Source: AGHT+IFZb7u6MhTnx0Cd0nGORaHx/jx1aDgSW1ziWHfbhnILcm9MDtQdpUvmawCumLhb1VWKs1mJwA==
X-Received: by 2002:a05:6a00:3c94:b0:71e:7a56:3eaf with SMTP id d2e1a72fcca58-72030bba11fmr12544536b3a.24.1729853167589;
        Fri, 25 Oct 2024 03:46:07 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ebe1:dd63:343d:8a4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d089sm829548b3a.99.2024.10.25.03.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:46:07 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Steve Lee <steves.lee@maximintegrated.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 3/4] ASoC: dt-bindings: maxim,max98390: Refernce common DAI properties
Date: Fri, 25 Oct 2024 18:44:43 +0800
Message-ID: <20241025104548.1220076-4-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025104548.1220076-1-fshao@chromium.org>
References: <20241025104548.1220076-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reference dai-common.yaml schema to support '#sound-dai-cells' and
'sound-name-prefix' properties.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
index deaa6886c42f..5bd235cf15e6 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
@@ -9,6 +9,9 @@ title: Maxim Integrated MAX98390 Speaker Amplifier with Integrated Dynamic Speak
 maintainers:
   - Steve Lee <steves.lee@maximintegrated.com>
 
+allOf:
+  - $ref: dai-common.yaml#
+
 properties:
   compatible:
     const: maxim,max98390
@@ -36,7 +39,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.47.0.163.g1226f6d8fa-goog


