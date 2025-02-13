Return-Path: <linux-kernel+bounces-512459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E5A33991
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54343A5688
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB020B209;
	Thu, 13 Feb 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiyrcJo7"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086520B1F3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433828; cv=none; b=T4EmHXzKKm7u/We7IpyQxkjHjgXkLAopll988N7TyCwN92xTdHSrEx7LeATFbRofPsRBEJmW3M5S6Uquc7jbhvAaMOWKmx45cuajfNx7wS+Y+aduwJnr68ncnrED+bGVEsa0y4v775dNXt7XG9wkedqoQ+qwMwbdpdVmikDacdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433828; c=relaxed/simple;
	bh=+cpwtn6ft5Mp1NhR7zmBNBss1tR3VCn4bdRQWVgKgxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Na48dVDN1kidQ8l6uzGDD8uTfBpDQBZw4+3Ln/HmBE31PkT4YfE5/9/KpWfwtl63NWgndqlECI5n+N65i3MWFCLyL6aRYxr7HB/SjXBGlme0FZRoESDsqU3Lt7RI/YB5xhof96blkCQcd5uI4F45ecWJDjuMrnSS6cTvZMTP9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiyrcJo7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4395a06cf43so3204845e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739433823; x=1740038623; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGK3HdKnBHt0qxrB+06GFcGxYYwUkBzqpNHrEbv5UZU=;
        b=XiyrcJo7CS8HZPkF0topJHiuw29adWu8qIJnNevPhfODeclsmsV9Oq2S3wuGusQuFN
         HAXqGLRZxv8p6nAYSSD9htN22fbue+bWTHvroG3ucDIEXCEInRZNotr5GwvNbHxuz7fl
         kX2dVrxF1o8CrnFBv0rijcAaouzNMfa5BVpKXYDLh7jIksbSn1D/R5TfoQK+DR5xpa4C
         gE12VrY1V/SsOY372JEgOuWg7m2Qk2tFeM7ewF0KoPHmSLZ1BnBJpIZUlN54hkBSuaRb
         aOi3MZMhZpTiS6o/XOm5mfrD1I5UVdQ0f5Dcz6AxNmTqEur+OsFpzr5jp/5eNi9idOv4
         Z0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739433823; x=1740038623;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGK3HdKnBHt0qxrB+06GFcGxYYwUkBzqpNHrEbv5UZU=;
        b=mE9IPTIB+PNFs6gHkEgLb+89CKocd+vcCfpw+HvEvqUenRFA0tPQ4uLJvQGHIxnU8n
         jSZcYR3vxsVh/i+LuDTN+FVZ8Nd8RhLtQ0GoHS8mO1vECT91WKt3GDackRkB+4yVg19e
         WM1fpVsL/FdCs7oRbMOt6uOrJqZqVY295G6aeF0zPEuxwaoDFAbGwjJvTmVfpNplJbG2
         jafUh0O6ifCZGaWKTIT9kCMZuDsPwL4ldOGZEV1hFcbu5AF8mqZ9zdjKVRphYCjjlJUx
         2CGDZ1wVI1AhnkXVwqmTPvL4k5mfDaK995tAspy6X6yT041y+PfIzgdQGmNYuQ5sdmfA
         2zMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5iipTvw7NGbFP9e1RFwS5hcIpoWBNPkIGUWNULZ7WmlkV4StApwQ8qs38aDT4JTyJ2TacDLAdNAx3sAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsdzsGWUNroZ4EsKBJqYmtXIb67R7q48vkAqaDMrJuNY8p3yo6
	9O5TAEVumE34DEsQ9ZnTSKcn+Tw34dsOlhIeyDWNE1mGZWSI2CD33HJjuh/unPXEoRMeUushp99
	4PZE=
X-Gm-Gg: ASbGncsJd4ZTUlc58Rh4SCnBWZrkVEPjQUu9TKsViCLujLKDDpDu/lT8xUBx35eu7sW
	RI9Uv9XimW83Hnop2gYDysyuIZl4uzmQTzJ3AHa8bqgfnJVwuSUSSH8sqf9PpCvGpmmFDBQtU7F
	wPyofvjqg89T1MKschhu8zVhHpGNxB9+KdI4bpmg/1V3HzmLPMTaxo1NzKSNn/XAzGm5Y/fq/yA
	i6dzvRz5iga5qWJVJWTNmvoOSXj07CVG7IrGd1K73nWqibWPbBkyMFW0eRF6z1AQ29uRBcqE8pM
	uvazwnQEO3PwzMykXvXTEshnRaY49HjAxarWQzFMgIBEOhXvbOXu+yF9JbpqML9qX04r/oA=
X-Google-Smtp-Source: AGHT+IGZkzm+ZCs9+jSrDpnGJaY+GxRIoci0mFIiMpdQIHQKUikeFgRtM+1vP6tmyadIVBpcdlOFPA==
X-Received: by 2002:a5d:5a4f:0:b0:38d:db7b:5d90 with SMTP id ffacd0b85a97d-38f24511f69mr1969873f8f.41.1739433822766;
        Thu, 13 Feb 2025 00:03:42 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7987sm1090185f8f.87.2025.02.13.00.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 00:03:42 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 13 Feb 2025 08:03:41 +0000
Subject: [PATCH] MAINTAINERS: add tambarus as R for Samsung SPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-gs101-spi-r-v1-1-1e3ab8096873@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF2nrWcC/x3MMQqAMAxA0auUzAaa2g56FXEQjTVLLQ2IUHp3i
 +Mb/q+gXIQVZlOh8CMqd+qgwcB+bSkyytENzrpgHY0YlSyhZsGCZ+CJePT+IIJe5MKnvP9tWVv
 7AMY86kldAAAA
To: Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739433822; l=819;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=+cpwtn6ft5Mp1NhR7zmBNBss1tR3VCn4bdRQWVgKgxI=;
 b=V0TVNrZONVF18PgyIPUrkSg+90Fdb4bF3PkyGBIktk0EIp1w5MP6VNcK7zk8EtNvkz2lo1yC6
 zFjjtdA4YjkBEr3saIxrOIi37Mw/0N599Jc7/WhVBLRDKVMceEK7emT
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

I'm currently working on a Samsung SoC which includes SPI.
I'd like to be Cc'ed to further contributions and help on reviewing
them. Add me as reviewer.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..254175fbe34f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21030,6 +21030,7 @@ F:	include/linux/clk/samsung.h
 
 SAMSUNG SPI DRIVERS
 M:	Andi Shyti <andi.shyti@kernel.org>
+R:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250213-gs101-spi-r-f5e91e344d11

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


