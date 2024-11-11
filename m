Return-Path: <linux-kernel+bounces-403834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B419C3B63
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004701C21648
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8316726E;
	Mon, 11 Nov 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="odeVkTyJ"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDA157A46
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318686; cv=none; b=XE5+tM4yMn+XPyv+qjjSNk2XIoaI/eqoqA15kCPzfN88oXhoeQ1u7/UFKWCeShl0nLwLoEpb7Pz4VIOeGwSEtqbhOQlw5qoC0MDykqsl4XVSWoB7zP8TpXKWmSMj71R1u68g5ghPSzKBQ6xB1GqqHCt2m3RRWtTomk6TyM9DmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318686; c=relaxed/simple;
	bh=FAFR0+tSOv4I8gRENdRAuULdCjfZHDr1M0BGBxx8hmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9kg6oOJVNhyGL+5PLB5K2Whk1bxcOzlmmC1M163vGyKPvxDAzCVD135JBx1lLpcVBREFBIM+DgiUlpsumGxDIlvCj3cB6GYLpNO68Fkio93WjU1m/AyJrsYAdP+AzCBZZ+a4lGMvPeLsUK8tHCmqWcWFQG7NObjVMczZvmteYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=odeVkTyJ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5ffbc6acbso2544451b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731318683; x=1731923483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guSru76DQNk4jTAiYkWrlXoJU1Cr/ZCthqHp1IjuiWw=;
        b=odeVkTyJv1v2P0UX/0OcEwDEvehyj4DRJKNr8/0dAvf6PVUx3iCPfW5Xq99Jghuczv
         /A04CRdkwaHSKwWcc/5JC5+a+JBiU4KpCne5vKThi2gDfJRWHZw68x2W9MxccmjLqdUt
         t8uKL1BDdNUH3DoVkU/H4+kNIAK6+U/lKca0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318683; x=1731923483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guSru76DQNk4jTAiYkWrlXoJU1Cr/ZCthqHp1IjuiWw=;
        b=LmBE+m9H69KLfL5DYnCvihTDNmDQg6wwkyEkxNQVuQJtJV8s0qPeLaAQ5tIrsAU18B
         2b3SxV4yvy5cgnryJguTgYyoO0zTpWxX4T1bpHgB8NwJycSPZO5d54kHOxdQOx5fARV7
         yt998DedUeUEZUnSDNbmEnZf2iqi4Gtq7/+Ju+g5j48ex/6pytrh6+QG6tnYMMZZ4a+9
         ki2QQSciTrr/MgpPUSeZivMHd5nX9AOq2kskvE6ckYbSTplfLgJGOGV4cNhOKoAMCYRY
         KJ4PG8Vy4U3wr1axx7kFBFCxD2+88bJaOEBoxqRG35MdoBFBP0gwS5IjKKo0+dpu12+Y
         zHKw==
X-Forwarded-Encrypted: i=1; AJvYcCVyrJecHw+BJnC7rvdO30hGvnmCJDHwjl7BOP0IMelnb+vPFR2XJt6w2NiGlnsu9yOPJgzpsAf9btyKU84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwm/quAuy+3UqcFpkBjtUAMsO/LGVRJFYnkP1v1roAZr5ao6sn
	FI5NkqyVGoCRyxePsCZvOJbJerW7HSaWYz6/Vp7z3xd+0tD5C1bE0QfqXXHSRw==
X-Google-Smtp-Source: AGHT+IG0E+pWn2Nhc1Tx7OrG49FBDcEDXCgNq4jPe83YpmSRM4g+0j589dM2a8bt6edqHtXly6EVuA==
X-Received: by 2002:a05:6808:1a01:b0:3e6:5908:1776 with SMTP id 5614622812f47-3e7946952camr11345320b6e.15.1731318682973;
        Mon, 11 Nov 2024 01:51:22 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:ec9f:d26:733c:7acf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5b48c6sm8075164a12.18.2024.11.11.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:51:22 -0800 (PST)
From: Sung-Chi <lschyi@chromium.org>
To: 
Cc: Sung-Chi <lschyi@chromium.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>,
	devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: mfd: Add properties for thermal sensor cells
Date: Mon, 11 Nov 2024 17:50:31 +0800
Message-ID: <20241111095045.1218986-2-lschyi@chromium.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241111095045.1218986-1-lschyi@chromium.org>
References: <20241111074904.1059268-1-lschyi@chromium.org>
 <20241111095045.1218986-1-lschyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros_ec supports reading thermal values from thermal sensors
connect to it. Add the property '#thermal-sensor-cells' bindings, such
that thermal framework can recognize cros_ec as a valid thermal device.

Change-Id: I95a22c0f1a69de547fede5f0f9c43cbd60820789
Signed-off-by: Sung-Chi <lschyi@chromium.org>
---
 Changes in v2:
   - Add changes for DTS binding.
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index aac8819bd00b..c7d63e3aacd2 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -96,6 +96,9 @@ properties:
   '#gpio-cells':
     const: 2
 
+  '#thermal-sensor-cells':
+    const: 1
+
   gpio-controller: true
 
   typec:
-- 
2.47.0.277.g8800431eea-goog


