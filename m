Return-Path: <linux-kernel+bounces-516998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE52A37ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EFD16BC92
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C4F18DB25;
	Mon, 17 Feb 2025 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDS8uaqh"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014618872A;
	Mon, 17 Feb 2025 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769089; cv=none; b=XJ2Vet1gg1pg9/7h2PkusYyR79v3+7rA9qtZWyJ2rVcKIegw+GWTmwSYxFo3Y1Ezgh2D6LZfF1KFMgbYatN1DpWPUJ/A5nO4STkHlDgV7f32fGoCHTYcMA74GoGtaTowfBT3tM8YVtPnlw4mm/55wHA7ea+53SRJuC8yE77Nn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769089; c=relaxed/simple;
	bh=bgnTcyfT5GS7CuKBUWPLESjyiP8WMrNY1oSZnqVtiXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOtDFvL/2oruxPeedd9yiCCVJpA8DpkUxuJlbgPgp2eVd+wJoiCAZePj4cRB7NcSI6jBuVQiQChyL9pKoIAScgslJcHkQsU2iv/FfU0eEXc7Hpc0SFRsE9bRsPwz/Cm5azXM20rrTQYq53bYflZu4zMEQTvBuOA85XClZuMIThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDS8uaqh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439685e14f1so16193885e9.3;
        Sun, 16 Feb 2025 21:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739769086; x=1740373886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtcHMHzsCPY8m2uh+Fm3smuT7g5v7qu+touota16XQU=;
        b=FDS8uaqh75vHUy5iLir4c/oR13I0yAAVpCTcNVyduyTRValh0FWUviZEjwy0wMOVSS
         crTiOWDWc03pw1e+QAdtJgLj+BvQkQC0pMOhWOAhlrsAucqRmmY4q+Yijp7Kx0OQd29m
         /dVC/4kfaGiuHIdpKsvxWGz7PYAwdjkIIFO7Otdo9zkS86IgKmFSC/phfnWcSqK84ur0
         ocI3QQcXtYOuhjv9hBS5EAmjw5fHzknNIsNeN5X9t/3gjIQdf/e4192DNr9D0ef9wYew
         8JotOISJYOC2HwDMXIb5R6QGyYZmQeeZrDHajDUn/LfCRurMBHMmQohXeudLKkcJVXJ4
         W7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739769086; x=1740373886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtcHMHzsCPY8m2uh+Fm3smuT7g5v7qu+touota16XQU=;
        b=hcZ8/uXIR35ZlzsDRWMdDmCFbNlJeGMBVB7hAM9q2KJZhECkTat0e62eSS5nHLbKyr
         OGxGcR/dI2JBYPtekuPiBnrsIB+2ibzcf93Q8f5vyXtEP0Jf03kM0SrH9taA0h1Vrmw8
         D5DJS+Yk74Po9gwFx7s8/9wcIFd41TBWjWHaYxXXwK8rTaWsEzDrVOJDa1Hdj5hI5rT7
         ZUG4UOuBpFj/i4Npk5xEf75px+6gIc70yloyn/nN5rQAk8mPBzNeyTjra5EB18noTP/c
         k8tGZpFxU4tofB3ZaSk2Zb9+57CyT5Szuj4rf/m2vLeaaATAum+X83EMnN/qYAtsWblO
         BDiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnsIdU0w9FwKA5/U32d0RwSoYvbfzeoL37RfwEkVsWXYVDBCNu50/IX921mUdwUka8kGx8yVxvFz/v@vger.kernel.org, AJvYcCWyhqtWQNLADhTvs2Z2g7pae1OUpWvmsioBfE3msAKqNyvTQVFDlLr4FC9nJVk8seVUvgSyLpaDR+jXup7w@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbz6pAb+9YNXMkcebTUq6HmLJW2DKDhNUC0wyXyithpufdswN
	CwPTxv3bDKrs2KkHofdt5CsnBBh7jztnpoPLaQ4o9pwsC6vjK0bx
X-Gm-Gg: ASbGncvpo2Jl3KQWrT8iwqJrBezqCNuORZOX02+t4Y01m9GMZs8kjYfRfSwh43xFW7O
	+cPGs8yreW2rHeMck0L3cgYP3vDwhyU6GvyjEhaxypZbuew8bhzde7Mfn7OAf7RNJ6P1a3VcQ8A
	SHgJfjVIWD/aS1y2YoHjsDdWuXzryLvmTTYjk/co0PuHn3YwKRiVhs+eVDIV+CIZEhc0+L/jd4D
	YfrwOpvXSVA5fx9wMoeLEhYw6SYShH6hkiXefaIXT2/a5GMNUFIFtAIPL1j0i7V9JFf9Ohswkww
	2UgfvOgPE2lXseU1IIjoSo2U/gPznlyWoGUoVf5RfV8oPkevjt0u5vlKM2oURaUgoGAUdCQg3Rl
	95HSQA/zp1bFzy2Sj8ywhvHuAFQBO2jy/HI9TsotaXg4o
X-Google-Smtp-Source: AGHT+IHETY9qyNtVtceV1JQVa3wR/xHExD1e32IE9QtuM/iiu4q6tQWk1Rk8t0ptiYjwBUxx60+I0A==
X-Received: by 2002:a05:600c:1c06:b0:439:63cb:ff89 with SMTP id 5b1f17b1804b1-4396e765f86mr53856895e9.25.1739769085823;
        Sun, 16 Feb 2025 21:11:25 -0800 (PST)
Received: from thinkpad-p52.telekom.ip (2a02-8388-e103-2700-a24c-4303-c631-1166.cable.dynamic.v6.surfer.at. [2a02:8388:e103:2700:a24c:4303:c631:1166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398a64febasm3988935e9.1.2025.02.16.21.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 21:11:25 -0800 (PST)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: linux@roeck-us.net,
	krzk@kernel.org,
	robh@kernel.org,
	christophe.jaillet@wanadoo.fr,
	jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	andrey.lalaev@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v3 2/2] dt-bindings: hwmon: Add description for sensor HTU31
Date: Mon, 17 Feb 2025 06:10:56 +0100
Message-ID: <20250217051110.46827-3-andrey.lalaev@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217051110.46827-1-andrey.lalaev@gmail.com>
References: <20250217051110.46827-1-andrey.lalaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trivial binding for HTU31 Temperature and Humidity sensor.

Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fadbd3c041c8..30e8f89fa032 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -189,6 +189,8 @@ properties:
           - mcube,mc3230
             # Measurement Specialities I2C temperature and humidity sensor
           - meas,htu21
+            # Measurement Specialities I2C temperature and humidity sensor
+          - meas,htu31
             # Measurement Specialities I2C pressure and temperature sensor
           - meas,ms5637
             # Measurement Specialities I2C pressure and temperature sensor
-- 
2.48.1


