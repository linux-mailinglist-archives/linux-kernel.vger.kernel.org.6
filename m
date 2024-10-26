Return-Path: <linux-kernel+bounces-383018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386FC9B163D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA331C21447
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892C71D0E3A;
	Sat, 26 Oct 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3Ss08Ix"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308731D017C;
	Sat, 26 Oct 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929957; cv=none; b=EAeSIDNxGtRat4ftSTwVi89ebgbhJ6XtzAAGI4ae1fbJ8WRGtZEdOfkBRDl5yrb2tUhpc4o98IQrV0YRLJS15wRdrooufQ1tYDZEGKtdlFXtbw6ic2GQ9/pwaJhn+8gedJ/z2/M+Dn/uxcWwu3ZbAk5QxUNl/FwoL+1lVhhjxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929957; c=relaxed/simple;
	bh=NxdHChZpaxMvrQZp5izJA5Wszc6rJQNIcts2Lnowl1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYVnzSXo7A0CUrZIiccaLgfyVg0bveHQeZSL56YV0zitdtbD32zzUmvl21sYVNstWeISAE2NsKAeCDbUGtscqncXHALIwMIo2c35jCO5coURaTcNRkCmX7l8Jxb8IDAUqC8S7EbihH8I270aagA+j/lYvVx67nofM0f+UvxsLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3Ss08Ix; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1952550a12.0;
        Sat, 26 Oct 2024 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729929954; x=1730534754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS++5JF7RgkdCtoajXZbGFhvxGfG+eo22CWm24y1teY=;
        b=Z3Ss08IxynpevHj6kZDbU6SGbOcG9K3GPMLIP/kx5dLBexaUrA/UgLU9M4x1qhC9hH
         +SngUgTogyGElZngv+1GiUHtihn6zYuekGA26MqDkAN95nhq/mowdvxp8TMFnApWsVt/
         ChBWl3T5uTxJ6rW0zfWduDje6xgFVb2xYQf4Rf0yagBkkZeSngBSqz+UCKYTVj21pj9I
         ydlkPFYD6Q8nyKHN4QhJgERfTKZg2YFutEmK+fpvS5s+231OwrdUbLDslkQQaQYJMQav
         ehH0CzgbGmAZMcXMBjGsLmA/rvVlc4yZyln+I31XTQQGcVA7PqLOAIQ1iB/hL2SM43f/
         ccLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729929954; x=1730534754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS++5JF7RgkdCtoajXZbGFhvxGfG+eo22CWm24y1teY=;
        b=WRzNepYRPAmetJN+aYIh2nsuwNlnAR1pq6VvLqcvw0VPKTmL0BmajKi9esHMTUSqi2
         UhK6B53jEJyiMl4nxJrhhorlrOIntU4O5yfwX7bALIgwN/5n8Av5KPK0mh5Q1AEYHyCa
         dzp4Gm8tnheyl3V9/981D2xtfArpcl6qX5M94Vxc83xn+yg43DDIHmEFSPhGu3+BsBiH
         AwbxJJEz5DldEsQC/arwXIRWe2ExHq4WjkZE5vRA+weaK3vYPHYA/iVpv5Hem6wtWpni
         L1wwB8ks+wJMc/PIkZi0YUd0mY2QEdq0ftXzN03xl+7YVHArgH9RFxk3CoPOg3yNNS9Z
         tYJA==
X-Forwarded-Encrypted: i=1; AJvYcCUmRr1+mvQCWc/NVax4iKIN3hhWIyte21evuI8cfkLONLFqG3CIkkri0EpH4/7KQmxkX2iPLioZPVDU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0L2y/eIu6O9sHxJ7lu2IMs/hpGjo3tLQ5i0OMDYtVOsis9qv5
	0UH2RUGSr+L8R7FRrd/qvOFjQa5mkKSbG+ma55FFrhuoaXg+Ojk926rO1g==
X-Google-Smtp-Source: AGHT+IGQrl20bh5ZTQUueT1jvS2kpWHro/MS438xRanv0t6t5Uvlt6KaxCmDrL1AcSJXudxgZbRo7A==
X-Received: by 2002:a05:6a21:394a:b0:1d8:b060:37c6 with SMTP id adf61e73a8af0-1d9a81db7edmr3148071637.0.1729929954211;
        Sat, 26 Oct 2024 01:05:54 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:4618:4c6a:7feb:e53b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a46f68sm2288666a12.89.2024.10.26.01.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 01:05:53 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	akinobu.mita@gmail.com,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add retain-state-shutdown property
Date: Sat, 26 Oct 2024 17:05:35 +0900
Message-Id: <20241026080535.444903-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241026080535.444903-1-akinobu.mita@gmail.com>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document new retain-state-shutdown property.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
index 4e5abf7580cc..86a069969e29 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
@@ -40,6 +40,10 @@ properties:
     maximum: 4
     default: 2
 
+  retain-state-shutdown:
+    description: Retain the state of the PWM on shutdown.
+    $ref: /schemas/types.yaml#/definitions/flag
+
   pwms:
     description: The PWM that is used to control the fan.
     maxItems: 1
-- 
2.34.1


