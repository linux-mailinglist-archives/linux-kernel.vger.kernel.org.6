Return-Path: <linux-kernel+bounces-446401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C769F23E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381701885BF6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC231865E9;
	Sun, 15 Dec 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtPCKDL9"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD901E871;
	Sun, 15 Dec 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266817; cv=none; b=sVgAFclJBwMYwQRxbMK+lAZxnDRLBnRjrfvvC8Bi89FjWUgr3D7hxxK9+sPX12kMU9dRTNU7foDZQG2Q1YETz5VR/U+100hJdwZR5sxokEfeygbk2e2tyfdUs9fsg66dar2YkcK2oVUb6Wk/p12S+/g6Cf5Eddlfa+6ypxDcPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266817; c=relaxed/simple;
	bh=+I511b+b+vwNhO6JeznuVo4Xu6HcmHb9VvSDWCZP1KQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sSd5zjPHgp0PCEQftTWgy3wdO0JBVQ/BrJvgapxYMIwaTM6PDHxkAHdKK7Q43nw2ziHLQWifaqJetemz/aw5WHkwvqLXpurFpDTzyA1qpMDalkUrMgr0rRGzDQoroVwJbbdvjAqUu40r7N5QAdR378gRnE/GnSXVDqK6CerIDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtPCKDL9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21683192bf9so29965195ad.3;
        Sun, 15 Dec 2024 04:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734266815; x=1734871615; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtiXrhlLULhmcmYD7/J70YHVMioWnzIVKEMBp1SpeEc=;
        b=dtPCKDL9clVKcq0dIsg/WDPQMFZ+LNzlLaN2ULpJ/flr6dSgaBv/YHJqkovXx3F+dm
         YNTFC+nsLa2/pDSE4ESEjLdeE22t65Zk26XcT2HPjdUJwlUQyu+QL6fCJS0hbYeTqKnk
         +u74oXV6vj6veKdB+5GiDTj2IZPywS5cshgiRVFiv9wjHXIDNqow1z5fY7W0wXIl251o
         s/z7tG2PIK1H/BdqzNtCVhz6JnLW2rsif+rBp+898Rv19FD0eVFsjfqr1C+EdX6x67Fh
         Wxa8YdYBxc3KgKi0HxC/sqqHhlMsnsT5tJCji1NQf0NshsmNy2fjI7P8MKiJPv9+4OKI
         gkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734266815; x=1734871615;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtiXrhlLULhmcmYD7/J70YHVMioWnzIVKEMBp1SpeEc=;
        b=EFDpsVHaw2MkGT2Hdor4gTNV1YGXfijqheI/9QA6Z9FBCoemWVxNODAuHDyX3C1bzT
         cfcuti+hErBHtxncC8iPaghHq0t6MsXef5pnwq935oVR5OAo6btXlTE/Zl1K26u6FCwI
         1JS23khvSMsf5rQl9IYgT5/kiPGpwnSkptMpht9ulzMGnDdcQ5JlF7ScVRjTTVPJ2g2h
         /JBbQL4F8hePSY8KM944vxR6tKk7tHj56WC0+uM2iEJOw0lE7fyrP26vsYOgiN7KqsFU
         ZxsNaF9ItnbOEh5d6ouWZbVAMQzBtMVbgQ/D8tKVorABGusPywNkQvRJn0M+VGnifSWa
         4AEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKs2RKb1U4Ma6CeFVJtB9/GxIAD4feGi278EF6AqIAsR+RTj6++95WSp/PK/5bjPrM1y+xaChpZjfVOInr@vger.kernel.org, AJvYcCWMnlt5CHVqUU83rGhxsYEf7FG1rOcYcHkRsGHXQIAmrctuvSdra55Je6YskVTOV6ZrGw51KZ7rkbZ/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Nx522o+CZi4bPdnxnY/3NjhrP5lWCpZiRIE/olfdm26M+Sp6
	H6/sLM7FS4Q93ah2l981UjU34a6lx2qqvFqvC0nMwyz+oy2heUst/+fPiZJT
X-Gm-Gg: ASbGncsQyFGksUqA99WjLX1AksZqNWhFb4cSyctPSC/bQ8dO8wElZ8saZ2RgeQju9lQ
	sI6/zJA/z36/LiIIlGx7K7WH7EQvUdU+h7Uw39yCnu6grVD2alvgpswocQuKfOicu1YrSb+Ks4Z
	p1Bh1U9xCQKYjleBNEFyVKNHFkWxUfqqJZlE4gJprM2SSjRMBg76OO4usXoqG3qp+H7a1S/gBxW
	YVTvk5DkpdKh0BrNn4zFxfyQ9Lyj7GY9O8AVf7z6hcOr7gr8rpgnRcK/wTwQaTrXw==
X-Google-Smtp-Source: AGHT+IGBw3Ak9JZg78wP4qokuJz69rQ9vPtcZmHcQY7f0i4Ako2nJam/OWxJdVyjDdoako8K1O+wIQ==
X-Received: by 2002:a17:903:22c7:b0:212:67a5:ab2d with SMTP id d9443c01a7336-21892a3fdf8mr136561135ad.44.1734266814930;
        Sun, 15 Dec 2024 04:46:54 -0800 (PST)
Received: from localhost ([36.45.249.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d07sm6214608a91.3.2024.12.15.04.46.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2024 04:46:54 -0800 (PST)
From: joswang <joswang1221@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	amitsd@google.com,
	dmitry.baryshkov@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH 1/2] dt-bindings: connector: Add time property for sender response
Date: Sun, 15 Dec 2024 20:46:27 +0800
Message-Id: <20241215124627.70525-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Jos Wang <joswang@lenovo.com>

This commit adds the following properties:
  * pd2-sender-response-time-ms
  * pd3-sender-response-time-ms

This is to enable setting of platform/board specific timer values as
these timers have a range of acceptable values.

Signed-off-by: Jos Wang <joswang@lenovo.com>
---
 .../bindings/connector/usb-connector.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 67700440e23b..83be66f6d406 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -293,6 +293,26 @@ properties:
       PD negotiation till BC1.2 detection completes.
     default: 0
 
+  pd2-sender-response-time-ms:
+    description: Represents the PD20 max time in ms that port started from
+      the time the last bit of the GoodCRC Message EOP has been received by
+      the Physical Layer, it shall be stopped when the last bit of the expected
+      response Message EOP has been received by the Physical Layer. A timeout
+      leads to a hard reset message by the port.
+    minimum: 24
+    maximum: 30
+    default: 27
+
+  pd3-sender-response-time-ms:
+    description: Represents the PD30 max time in ms that port started from
+      the time the last bit of the GoodCRC Message EOP has been received by
+      the Physical Layer, it shall be stopped when the last bit of the expected
+      response Message EOP has been received by the Physical Layer. A timeout
+      leads to a hard reset message by the port.
+    minimum: 27
+    maximum: 33
+    default: 30
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
-- 
2.17.1


