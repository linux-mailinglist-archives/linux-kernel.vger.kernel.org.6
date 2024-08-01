Return-Path: <linux-kernel+bounces-271525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F9944F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2574B1F227DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE281B1500;
	Thu,  1 Aug 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a56O/DBL"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B521A0B;
	Thu,  1 Aug 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526595; cv=none; b=q+jMkrr/1dsfIDPMkwpyv9edxOakOv/G9rTjC8xq8wC9Rf4/jC4L0YiRrlC/BX0GQ00q0mBXC3GkHRTkWJTGAwI7bDOEEfK0gOuCsExeEjp/sS4ZsQzDns8o61yQGjEHlycgy3/VcIBv4H4S9XgvBp3oeGYpPTdYDAydaPNi3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526595; c=relaxed/simple;
	bh=Bh04zkUoUkR+Bpdw7Xxl27Vv1Al+y4yZ3LKJUjKUIiY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XmH1cTBR6IuV3SUc7tETc7x1y+X85q7dZIZyAd0SiHL/yJ/lqhmoHOfw0JQ5Jxzw8fZxT84VrA/8KD/dh2XbUO8n/9lc9mYXGjUjyqeVPvmQ49f5bO4GyQMQ5homIxFP13m8LuPNl5gJ8XK0sftGZCzBevbTCNQOdR/wD4EvKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a56O/DBL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fec34f94abso55847545ad.2;
        Thu, 01 Aug 2024 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722526593; x=1723131393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1i1/5Afa7Io3WkMvQUO0SKDT8T2L7XQxbEH0MVs8m7U=;
        b=a56O/DBLuVUYLs9xkcrpPzsiPUw4fNZ+Am65J08eBQZoPPShNDgEDxN1qVVoLFoqsF
         jaO4SMORmEJXPW+ke45WYgoE1Z9TR+AzAs8iJ6AFSr1vOYrLHlxfWru6qM4/1PcRV3Oz
         l5UB60I78lkj2nypuq/gB6bMYlWuq2FtqokURmi1AoxWf6J4gjJiIkPlPmR2V5dF5/IJ
         yRi1b7w/DUAuF3aHKeg/D0H6r65lq5GZBiez+z0OEK5ttZTEjLYAKHwE7B8wgxgSnrKi
         zHe0gQ41MTuiUTNcU38euCGS3+Pn654FKDmggHSE9rRtfdDfbX2uDLUZbzVjYXZAeHc1
         HybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722526593; x=1723131393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1i1/5Afa7Io3WkMvQUO0SKDT8T2L7XQxbEH0MVs8m7U=;
        b=LjPaJ9JO+CE72+qe1RF4/8D5YrZVhYCQqGpN12/kpNghYP5m1b+mbZK6qorzHB9x4L
         XXpzDNzCAtJsWVHKe+//6KIteJghrnZmas3SzUS/dRnudTSx/SxOAp0W/DsRWROtDz9r
         a/WGYrMmQYZfCvmi9MUWticcqUAq2M1ZxvZmSEyOOeGNohj9ZrTc9Vqnhq8QP1hZFqJg
         3SmsrNjbOnRy4TGC+B0D2vWoIyjr1amjMD/kC2MqwcP8ZEtOm/JM8tNAtA/iOxMfeZbc
         PZT3va2hLKiVDc7tI4hX5e6z2KEmw67slP4P6MRqU4y/LD/c06Nh8pCVVKqJprs1FAFb
         BzAg==
X-Forwarded-Encrypted: i=1; AJvYcCXRo+Wj9NDwjzVxgZrY8/GlBBWM2ysZAzHQPe5N+N5CiUQt+rP2jSsaOlqU7WyKL7mgK+yc3ZIwgmjc/HC0A0snYU3MMBFAvPN+2pwcfzIUqnedPc7yK/YDihb8SUag3s9q6QTgcigwag==
X-Gm-Message-State: AOJu0YwG/ExHI0U6WMPRsOZCcGfHU+9Ap256SxHOmHSEd9nmoQYuH35W
	RPc7afknOWs7JgwBNxw9iSiJ1+ZIlH/0c2pSPFHBP+JqGOCwLJcd4wpIVw==
X-Google-Smtp-Source: AGHT+IGVt4tmSDLcrcaKqUAU3jYK85egdUEbqNwx+aZGQJ1Mv5d9gvuEJs50bkVcvd7CF3anqMkErg==
X-Received: by 2002:a17:903:22d1:b0:1fc:5eac:9873 with SMTP id d9443c01a7336-1ff572b9dd9mr6963705ad.30.1722526593098;
        Thu, 01 Aug 2024 08:36:33 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f56febsm28015ad.88.2024.08.01.08.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:36:32 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: Add ISL69260 voltage regulator device
Date: Thu,  1 Aug 2024 23:34:27 +0800
Message-Id: <20240801153429.1277378-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISL69260 is a digital dual output multiphase
with Intel VR13, VR13.HC, and VR14 specifications.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7913ca9b6b54..6ec8b4cc9e56 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -164,6 +164,8 @@ properties:
           - isil,isl29030
             # Intersil ISL68137 Digital Output Configurable PWM Controller
           - isil,isl68137
+            # Intersil ISL69260 PMBus Voltage Regulator
+          - isil,isl69260
             # Intersil ISL69269 PMBus Voltage Regulator
           - isil,isl69269
             # Intersil ISL76682 Ambient Light Sensor
-- 
2.25.1


