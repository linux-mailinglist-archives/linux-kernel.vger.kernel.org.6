Return-Path: <linux-kernel+bounces-407012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C209C6769
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174031F21E19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040B1494DD;
	Wed, 13 Nov 2024 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gE7I88bB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06393154C0B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465638; cv=none; b=q1y759fq2EKbm5GFmc8VP0xS9/pM47klq68uDue95/qPMdR4ZU5fp7kQe4rdHcVHC6W1jHhuDCc0jCinyiWDsasNdtn9Sp+3jY6s4b3/pSB4Q1smC+zTUeLK0OOOAyu85PTVEiAPJHpmB+3nNWZwhygPvET7WHkDd/vrNDaozHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465638; c=relaxed/simple;
	bh=8lt7eykDFZw7fIigqij0E5lpK1ubBDThz9WowdmROho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsuMSgMv4BwLV3X9GKKFt4RpdPGE2P2goEIWSTp2mPzi2aUadzfM2TkfUvBduGTUX01D15z1VC0XVaJkgs34ohR0UWMursDxsPN7ewWhXlefhiKez1LEcYnEBXmkwrVHR/r+WsfqsdHnfnQMWK1QSGcbTqIt5C01p/aOvxjPIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gE7I88bB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb47387ceso66371315ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731465635; x=1732070435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vjvrd2avQzhgqp6lHzhNNlW4+aoD1gw3mVGy/cwxKNk=;
        b=gE7I88bBD0HdWSXQlYMBNj/ZD7ByCp6yeH/JxP8Ln1zfoJL/eypAhjCrZFiO54328r
         4vH1nXWQ4THu7TS0L4dRRWqukzyIbyQU0ec1sO3NwOWjZ3tN0/DjB+qTFcd5zfMZLr2p
         L8jenlp0k50FBeqqfWRzsxGWAn3Da5F5yU6Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731465635; x=1732070435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vjvrd2avQzhgqp6lHzhNNlW4+aoD1gw3mVGy/cwxKNk=;
        b=SxQhkEOfQ/bd2Rr8qjYP8iO1kzFZn9lP+6504FG5zuafhjpRxp/7DG72qpae6rRcFF
         6o5Mcjtj1QM3vWN8fuLyHm+IrS/XJGDDsUrGyBAp0Yo6HuDOkXf9c37MnJRucS/MNSfF
         Z0owkVnRMfjqrx7qYzjM+KgNvdvlZIe/UDFstyFBOtRYJUzIkfPYyfMY7KKL6fSrabhW
         XuYHjwvlOSC/d9QrZe9fnxdozlX1M72FsHNOCLFaZ59eF03ugpszVdS4qn1ZxRmdlYp9
         tJ/zYamTYMCW5eypHBKF0wA8ViAqG9OTY861ip5P9yMj+DtmK9g9Eo2EpNk7Nq7CJVW4
         Horw==
X-Forwarded-Encrypted: i=1; AJvYcCUor412pEwHZ079ituWrsYnXa82Bozwkxlqhh6gZ96Vuf6j8j+tr2KgCuNg8AetMY/ZdeZmd4c/ftWuBug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTe6cZW3U/IAOoz+8/Csp+ANF3YmCSN1gzqe+Hv0T6SPno+DT
	vOW7ypu5AIzSHmoWX2wtq8yLBLtHyuFz4Ln8idH2jJ75dagmVB1YdfSt+MV4Tg==
X-Google-Smtp-Source: AGHT+IHe721yXQHCRZeRjkW+n+uLrfYbkZjFfwy3XKSXli/Bjhg1eEXBQdFZlkHS9zXTLG7hxYMmCQ==
X-Received: by 2002:a17:903:1cb:b0:20c:bffe:e1e5 with SMTP id d9443c01a7336-21183521d84mr274072955ad.19.1731465635278;
        Tue, 12 Nov 2024 18:40:35 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:3dd4:86fa:9696:4236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e418d6sm101831325ad.142.2024.11.12.18.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:40:34 -0800 (PST)
From: "Sung-Chi, Li" <lschyi@chromium.org>
To: 
Cc: "Sung-Chi, Li" <lschyi@chromium.org>,
	Conor Dooley <conor.dooley@microchip.com>,
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
Subject: [PATCH v3 2/2] dt-bindings: mfd: Add properties for thermal sensor cells
Date: Wed, 13 Nov 2024 10:39:52 +0800
Message-ID: <20241113024000.3327161-2-lschyi@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241113024000.3327161-1-lschyi@chromium.org>
References: <20241111074904.1059268-1-lschyi@chromium.org>
 <20241113024000.3327161-1-lschyi@chromium.org>
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

Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Changes in v2:
   - Add changes for DTS binding.
 Changes in v3:
   - Remove unneeded Change-Id tag in commit message.
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
2.47.0.338.g60cca15819-goog


