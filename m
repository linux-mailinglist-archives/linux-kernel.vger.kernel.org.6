Return-Path: <linux-kernel+bounces-261845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94093BCDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE915B21336
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1916F286;
	Thu, 25 Jul 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o86NrIe6"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34316EB7A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891165; cv=none; b=qpSIozzRKuubYFIQr3pbCf721/+jKvvttxVZuJaNG1tPK+npcVruUlc81x+oKVLqj6i1qlqEUEe1cH42xNeoirEsqNdwnfjZ0RT7mqqXBk+KIQIlXRllQEtoN+VSoy4QF9jtf3f1Ndv31eVf4q80AVXzKpBpv9dwjdE2C+NEY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891165; c=relaxed/simple;
	bh=pwyW/t0VOGGP3wo86mCW/jK4skkWTtXSxnSGh1yUi08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GosxF/ktER+CfJWj6IDDMeOD+ila6ZdI4w0q1dcnjPdSc/I3B4xc0VWyJBAiEsiiX6MoLyKJkqZAsSP9l2rjUy+RHvY1ZhVCf45FRXo47S6Dsdd8uOiKy4A5pPM5xZTWmoXsvxKg0uwq85jLfAhabhPT8Ou8u7PsLXWtnSnVpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o86NrIe6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso745522a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721891161; x=1722495961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKIyRKDttBq62+3aIK/Qv77GSa3JtrN5O6QG3j0bRsc=;
        b=o86NrIe6VWWYNO1OAIfEWFEFb/MbD5jAwW0OsAUZfHFK+4tbyqSegjq2W4fZieq5pL
         A2VkpFCakDi3dAUqQcyMagVNoW+h9/hUYcIVPmGRnvQZ/tifiVfSfNSqjC9XXSpxIcl7
         7oBZw0Pnh1lBWBd6fX8GqVYhzMOcEAuQsvbwFsJq2pOSf/9N+zL2RCxeQR7f1/P0LO4B
         RT9PBeW0UzDO2wwxRRF+1n4Fxtykdnei+ZYD3gLf03icRCmfkOztVHLf0y+b6neY54RH
         UdeM81GK7/4NFPhsqICLFNe6++ap/5IuyzxwTFvQefG6uBAarHrsWBmMOJJclGVmm6kP
         wrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721891161; x=1722495961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKIyRKDttBq62+3aIK/Qv77GSa3JtrN5O6QG3j0bRsc=;
        b=FRt8S667UWjVR6+jUbrhORmOkuSOckX24Fd8x1c6ruif+gYi4h/6aJ1SW4jjdu+nTh
         rAyeZHwI9NX0k6mLKOO+ZsrQ8fibu9jWqTkYPnNXPIu20TlqkMlcoEVtU/2+xgKimoyL
         chYZZ3Ewi/opQp/jFFWoyAX1GTdWz1afxTNTplvBV1SHF9Q3O22hSEblTv40PnBHLMUh
         M6E15VcvDPfQtSxxdEIlPbhgdIM61nDX9vRH9qzygc9DR+Hcu6GJHMdcvqkRJG4xmEsm
         TsLjF1J45KRTvOuq9HlFiIF+kM7W4vKP5Baysomrivng/eRa8FxHoSeEjDQ0PZCSxJ52
         BCMg==
X-Forwarded-Encrypted: i=1; AJvYcCX8NEaMccvJcEBFojybgdrFnd5JAr1Y71+NxTaRKHlVvVnZxkzo8jMVHLOTqyHVrHkQXsHGwjDrN5llvDAACP4lflFVAxHXGRYLECpo
X-Gm-Message-State: AOJu0YytF46X3N3tjqcN/52UFMdLcEmz/sLKslX9XXbgRhO4tcjMRBK+
	pONhHAF3+VGMfunnXLInW513SpaiZNhfLH281pSGJuwJDGx1UNQhe5ZA9rSZ2HE=
X-Google-Smtp-Source: AGHT+IE1TFDsRViZ1DT9xXmyddGT2lImWR2Wczy7X/4uREdXSDrl1OYJLzwMHmDnSuHNiGfgnotNLw==
X-Received: by 2002:a17:907:7f86:b0:a7a:9d74:21c3 with SMTP id a640c23a62f3a-a7ac4f40df2mr136665366b.35.1721891161617;
        Thu, 25 Jul 2024 00:06:01 -0700 (PDT)
Received: from puffmais.c.googlers.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm40253566b.18.2024.07.25.00.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:06:01 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 25 Jul 2024 08:05:59 +0100
Subject: [PATCH v5 2/2] dt-bindings: serial: samsung: fix maxItems for
 gs101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240725-gs101-uart-binding-v5-2-e237be8253a9@linaro.org>
References: <20240725-gs101-uart-binding-v5-0-e237be8253a9@linaro.org>
In-Reply-To: <20240725-gs101-uart-binding-v5-0-e237be8253a9@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

While gs101 needs exactly two clocks for the UART, the schema doesn't
currently limit the maximum number to this and instead the default of
five from this schema is applied.

Update the schema accordingly.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v5:
* collect tags

v4:
* drop description from clocks:, it was Linux-specific and a we'll
  implement something that makes it obsolete anyway
* no need to duplicate clock-names anymore
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 0075712e7be8..788c80e47831 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -166,6 +166,12 @@ allOf:
       properties:
         reg-io-width: false
 
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
 unevaluatedProperties: false
 
 examples:

-- 
2.45.2.1089.g2a221341d9-goog


