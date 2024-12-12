Return-Path: <linux-kernel+bounces-443983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A84E9EFE98
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA3B2863F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF081DA60F;
	Thu, 12 Dec 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VkQlO6tm"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32CB19995A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039890; cv=none; b=kJbZusDia84YWY0Xyh3HkyDGNxKB0IBwMXF+iPs23mMh4T+eGiSCbM/eUorVj+1S2g92Bp6TcCEeJb/BSQL0S/TdH7i5NcXPXX8gkcls/sEWKXhY0bOn8M9YBBQHoITJ6KxPWxQsepgIS0ge1OZ38dPcDhCOVLyYQU9Cctrg7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039890; c=relaxed/simple;
	bh=UlHzjt5XqlnLG109qvAxfN/sqPZY9O/xBm8dalBOFes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kgq6Yjmpgy8WX1NKHPHVpXq0LBKhe655qJ76vdDtAXJRmbhp0WEWlNDTtkN5/8Vt6LXWXp4j28fVEeodPj+GU+2xBOYTvH5sMd26OkJh5156B4jQwglfMC94CnHE8HyjXmfQlZ4kqnUzHWbypuZ8+zma9KkBSftuIcyw7Cc/sY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VkQlO6tm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6c375b4f0so103515785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734039887; x=1734644687; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nUbD1JwsRkblN7Almh3bMISRay2N2f9G2ZCbjGzrs4=;
        b=VkQlO6tmwHzmDGyIL58zxAAkwqunBApkd8+iiqf8uhJj2hm08/0d8uFkTL6eb7STDb
         2dAJOTgW2gbWx2UAFhitP7hWXYHP7r7AColY5UMyKf6m73NwsLoou7od9TULAs3zGGcy
         aUIrkm84NLAs8ufNybRDUjx8a2NoDijSil8Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734039887; x=1734644687;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nUbD1JwsRkblN7Almh3bMISRay2N2f9G2ZCbjGzrs4=;
        b=qYU5W6aIsEYEDJZJV0oQCFlyKhk+kf4Fc/30H/y8QaaVY3gLEkzOW5U2QUNT+kV5T6
         hs1nPs8TO3rPw6rBlroYcCefgG477AZi/PRIhtInEnqm1OwBe5qLiugugwAvGPKYypFo
         4zuVcXFq4+MHxRup75enEGvukW2aFTX/2GZGoIgRnWUdFagY5LAJJVYPfpkyFFsUgm1y
         eikwYTXqtIsd40tJHspdPGWheLwAAohrLuc6+SLYt4kclFZk/xvmM8yNQMZkw5PwUJ0c
         bKdPM3x+wuHeEBNBVoukMBOx8aTBvfn3iGLlS/SVfctp1k46JThX4BmNoCMwCNCAUpjn
         klFg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7rfmvasOAVUcVJf4YBbqmoXrna0XmT0Xuz3173TI9f6Q1XE+no3XDY5VtBAhBQaIwZgAxxqHnmCPmIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAusGjKirBWbXteR6M1omeyD107+P+uz4D0lcjo1N5mZK0x5r
	vfTpkrOx0uAiCIwwRqv9de+xoB+lBbr6WCz3vNFQCiii/e+Ahp1SGuoRxo3NRg==
X-Gm-Gg: ASbGncv4BcTHZcaqsI89byFUYoQx2WFa6XTbXq8y5K3EnQBW3dvakxgoRlc6hk9wJhn
	rw5cuSlgEbrdUvsRBYa4xiTSyiKWpURszcMHZIVpAVOktHE2l1MX40vufOi80jW3jazx+XnDZMP
	7nF1HEaPBzipaOEnzgDTmH2nTGakK+6lbK3KKOAtJ9PPC9xnyGxArZ+s71udWk9z2qSQOx/qG1e
	VnVeessqJnYPU3U4ZqJ9CEztjli7TNSHyrXlrGvtPGdmU0Ekm6fG56ZIEluq2eq2T1UgKknmjZi
	mw6nTnOanLqmYKiIOcwuJNQVq9zoPXQ=
X-Google-Smtp-Source: AGHT+IHvdlp9WmWec4jyjGHYEjbhEJReTIiwO+D5oPna4oGbIvZB1nRqpaRHFzTit+pQlCj49roNUg==
X-Received: by 2002:a05:620a:1925:b0:7b6:d5cb:43b0 with SMTP id af79cd13be357-7b6fbf3b8bdmr7344785a.39.1734039887616;
        Thu, 12 Dec 2024 13:44:47 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f4f7b34dsm83368485a.1.2024.12.12.13.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 13:44:46 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 12 Dec 2024 21:44:37 +0000
Subject: [PATCH] dt-bindings: usb: usb-device: Add panel-location
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-usb-orientation-v1-1-0b69adf05f37@chromium.org>
X-B4-Tracking: v=1; b=H4sIAERZW2cC/x2MQQqAIBAAvyJ7TtAtMPpKdNDaai8WWhGIf2/pO
 DAzBTIlpgyDKpDo4cxHFLCNgnn3cSPNizCgwc6iRX3noA9J4uUvcXVPrbOOQjDoQaoz0crvfxy
 nWj9HmCL8YQAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

For some devices like cameras the system needs to know where they are
mounted.

ACPI has a property for this purpose, which is parsed by
acpi_get_physical_device_location():
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#pld-physical-location-of-device

In DT we have similar property for video-interface-devices called
orientation, but it is limited to the requirements of video devices:
Documentation/devicetree/bindings/media/video-interface-devices.yaml

Add a new property for usb-devices that matches the behavior of
ACPI's _PLD.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/devicetree/bindings/usb/usb-device.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
index da890ee60ce6..1ce79c1c3b31 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-device.yaml
@@ -42,6 +42,20 @@ properties:
       port to which this device is attached. The range is 1-255.
     maxItems: 1
 
+  panel-location:
+    description: Describes which panel surface of the system's housing the USB
+      device resides on. It has the same meaning as the `ACPI`'s `_PLD` Panel
+      object.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # Top.
+      - 1 # Bottom.
+      - 2 # Left.
+      - 3 # Right.
+      - 4 # Front (aka as User Facing).
+      - 5 # Back (aka as World Facing).
+      - 6 # Unknown.
+
   "#address-cells":
     description: should be 1 for hub nodes with device nodes,
       should be 2 for device nodes with interface nodes.

---
base-commit: eefa7a9c069908412f8f5d15833901d1b46ae1b2
change-id: 20241212-usb-orientation-8e3717ebb02a

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


