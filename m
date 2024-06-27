Return-Path: <linux-kernel+bounces-231891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C589A919FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B5E280F62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EAF44C76;
	Thu, 27 Jun 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgDl+wO0"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB71CFB9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471920; cv=none; b=ied411GKseKBfTjS6rYrJpxh1+zo+9Hs4LK3MLpnGzJZSQWoGjfuHEaxkXjmHwvKK0w2QIj4ckB3deGJeiK8vkyl+bOiNeZKEATJo3+NZ/vSb3cQ7LO9o3wayZmSyb/vvDWrqjTakrsOToI2Jjgt5ViIegk+yW+akjHAK0cu0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471920; c=relaxed/simple;
	bh=SfGPplS57WScGXBN40BeXsqibzVwnphT1MKGE65OULo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3ClgBy56dfLvC0TN4kk4XfhfQ4tp8YRvkUZv6vk14d9APW2IQwZyjGPoSUQ+a0nlKy3xvmkco+agQJXwb6Hdgxm0nTtyX0C2U4Ucycy5bd58bliCaJxxYy8GqyhuGfcIXU2xsa0hhaZNWKw1Blu9++45GQgjmAV4HlGUyeLJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VgDl+wO0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-366df217347so4384459f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719471917; x=1720076717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pj2osXrnixhyuo9N3L5LtfI/DN1t+YPtQJ0C1hVfcfo=;
        b=VgDl+wO0PRborvoWvKL1zOIxVB9Z4x22KxDUgnf78Q36qLQoDn0eb1xMOm6FCJHq6/
         vhpHZAsDfWAk5jmoyo0Fmy7zzRT2tgWoucE5sLqUOOpD4om9Az3LLwf+3Cue56UjzqyZ
         eEqrrf3Ba37dhtkTTgb5zwRbSKbrkrJvsdriUe3DZeha06YAqJYTF3dcuyFHO1K8SA79
         sAk2u+gsCcLRmSSRIwelzESbB2nEES1tz0RgFnm6tLhas0dFbAH374nW+mOXnPrB4bzp
         DPUl4Q37dFW6rO/7SmTwd0O3RRYTWX2CFXCeXFAlko/nKxi31OM2oWSoYT8RrC/KpMd8
         FH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471917; x=1720076717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pj2osXrnixhyuo9N3L5LtfI/DN1t+YPtQJ0C1hVfcfo=;
        b=Bs9kCLAPsg8WoEmISX38tlH0A13HBU4/YlhfADuxJFa6j3xpMYQ6iXFHPlGU33yxiE
         Fw+Z4+YqB2XAjjNY2YXanIYZS+wMUcth1c69QXtfSwnfIJYdciv8aS9+LpzIl/EVCAxh
         qbMfNoKE0bAMSu6gy779cvwuWhDy73c/KJbv24aBoRonZ909wnTXqp8il150FUHwKI1d
         DZiI3HaQILVqGi/Rm+bk0sjQW3JfqsdQUJJs8wf6w6mV6vntpItl39Jf0kJGFzJtm8YX
         UuEXhsge2Cx5RL5JKbRUseMO7Qr06wfd0bhIZLQc76VI3tbUx0ZlZ7of+HlTPdMk1c6H
         5BMw==
X-Forwarded-Encrypted: i=1; AJvYcCWa4949J8chUqXelbnq6JP/61YCrVyY0HmApBhRttELJZx1pFhFXjdeljW7FYkkOR+wbM4gLthrriimJNfnrj0CU9oM5Xr0DPt3YLii
X-Gm-Message-State: AOJu0YwBG8FOW34AvBUobbdpWJVOIom7Wploy3xfaWry+6T4CPZuhaIv
	5t0u8BQ4YLrmzE58ZoD9oOWkGlEQ3dcsNKuKxefEZAopr1nYNUtCOeq2cE/gztM=
X-Google-Smtp-Source: AGHT+IFkE2qRmgXJmAGSrvTQ3RdwQ8OYe+TP2dMaPtIWsmzevgxn5sR40qAYbG1trnJE5WKwLjTryQ==
X-Received: by 2002:a5d:58d2:0:b0:367:437f:1774 with SMTP id ffacd0b85a97d-367437f1ae7mr602082f8f.14.1719471916938;
        Thu, 27 Jun 2024 00:05:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357fe1bsm901028f8f.33.2024.06.27.00.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:05:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nuno Sa <nuno.sa@analog.com>,
	Peter Rosin <peda@axentia.se>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] mux: MAINTAINERS: change ADGS1408 maintainer to Nuno Sa
Date: Thu, 27 Jun 2024 09:05:12 +0200
Message-ID: <20240627070512.6577-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to Mircea Caprioru bounce:

  Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'

and Nuno Sa offered to keep maintenance of this driver.

Link: https://lore.kernel.org/all/8a3ac03fcdc5c2c6401d0a990af5d6e9f6c6670d.camel@gmail.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c675fc296b19..b72c4676846d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1291,7 +1291,7 @@ F:	Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
 F:	drivers/iio/frequency/adf4377.c
 
 ANALOG DEVICES INC ADGS1408 DRIVER
-M:	Mircea Caprioru <mircea.caprioru@analog.com>
+M:	Nuno Sa <nuno.sa@analog.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
 F:	drivers/mux/adgs1408.c
-- 
2.43.0


