Return-Path: <linux-kernel+bounces-429428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6DC9E1E2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C707CB45BD3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5B41E7658;
	Tue,  3 Dec 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ES/XGxI1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64A1E5005
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228267; cv=none; b=TATkGItKeC+zY0VufGlFfgAWImxmK1LJBR9DbXbsQPZiUmoYFprXU5cM5Lwx5tVR3SegzUSAy8OZ9dKsmHkLDyY4vrUGSZ6w43laLJvcbxv+3TJPhBw7fsvinTrHJDhc5Ka3V9RGqTK9a4k7zmBgD3v2PnFdgNF1+vlMiwya2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228267; c=relaxed/simple;
	bh=M49V6RgMFX9yBEfjwwyJSmpJ/ZrX7Mn6P9h37XiEDzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XD9UZGxugps0KXtb9AErHyv88nqFDnETg5qLSqWTezL8AaifcJ2jsD2pZbdkWQv+SOZ0mA3b8/FeEdvuOFgM0JzZlg27rPX65SlIdzeaY0WJ1hGG/OGfi2xhcTo8LemiuoJFMhCPfAVfr7xkR4AfQuOgb1kcRYbCR80yikGvR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ES/XGxI1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so977279766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733228264; x=1733833064; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2UfI3tNP6hp450YILSsuMQQhfugKH625KrlazXf/FU=;
        b=ES/XGxI1RowTnEOgPR+/WKiEZbwzok4NLJKXaySo/A+4ClcFYBftjJ2Tt202iJ5Mhk
         ZnEBcxwSkCVXK9JU6geyaPSXkyVOLWBEDlMPLy4M8KtfQ0EVekcaXQ5K22vyZKHxBVBp
         +LevHQo9x7gvfNTvIGcCgpty7BfWYpEsSAqc1Mn2FmzDNJ4jriDk3h7WRqsFunqLnYYq
         Daqfi6BTo2zZwJ2QclL8QL7gk/C8Suy7NST2KAIs37RI5xYXaDh2wWCC5q47tAKloykI
         HTjNLy5EYahad7klgH0wpl5qT+ds7MxtvyZRiOYFE31WIh0RNEjkGU65m/xF4I3ebbo5
         FVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228264; x=1733833064;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2UfI3tNP6hp450YILSsuMQQhfugKH625KrlazXf/FU=;
        b=O94peSX/3Nb5AMkrHOiUxPz+ZcTmC3o+hSB/N60wyBEjG/KkOFmrGGUmdWz//e6Vi5
         +eWfJRMFstHu7vjXHbdqdtt0XH+36GDJMw1adyyAIsbPjRkWGfvgfBAOmL51Oiji0T3p
         pDELlIZTpz2/zZGzGn7N5QCiZw16/+U/KHC69+NucJ/8AgotZh/mdHDMFV7uQ1hzDKfI
         UtUfSMfShOIM1mSKkv20ek7zr/KXDGI2rwCSbWvRQHjcZSl1kpLPhAp65W6ARIPsV4n/
         QnvsB5SpSGtnXjz0vGplL3fmhbA/9HP/qzWcJBi1S2aUj2jdqrOCIVVuaoEirPSPH0Vq
         91WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUbJNJAM68YaDAr/4FFra4x7b7pg3uebz9ohKeOpzaSejHp5No6DeaLXfIWvEzb4IS8tQWS2gw/KQ8MFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpH4b0aXplyTBYhNp80amnstcw7ixkIkGiGetStvjVHfa67PPS
	r+laoU5OooWgfrn7Znozn9jeLO47tNKZT87Jx2uOFqatSrLA8I35Fy/KbTJuVFiXwUPOGaYK4Rs
	wlbc=
X-Gm-Gg: ASbGncu39P0Yh2pvHK1JXkx9O8Bk9JEfrIAYV5PxOPheasu4Y/Mv0cuW+C0Kn+mBI4/
	zMk92bR76aAFOeSD15j0vMY2imowLAOio5T1ErSrGkG2qgc8IlxUYpA6wIyvdThpjOXuYVCf4Xu
	QmNNRD5SNFWjMJfHvZhZyibvVR52GX55OcA7JoLkVFvCc+VnOR3R1hqCLprtSZqvMrzqv8tcXNl
	4fRR77f+tONvEDlyi6uTRvh3+ONJSfzxpXJ5HaCgyIxCGAUq+xM26hHr8c20cvsDs5GkZH0fQmn
	hEyP5h+bqe4MWg9+XMOXyzqqYuJw4ttY2Q==
X-Google-Smtp-Source: AGHT+IFuDfNoLsR+aGkqAxGMjkMHHCufm2JdaFXPMbn11SwOi0SEY0sCF5NfPxV3s0eUPciCzqcP2Q==
X-Received: by 2002:a17:906:3d2a:b0:a9a:616c:459e with SMTP id a640c23a62f3a-aa5f742699amr195441766b.27.1733228264338;
        Tue, 03 Dec 2024 04:17:44 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996df797sm616652266b.68.2024.12.03.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:17:44 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Dec 2024 12:17:35 +0000
Subject: [PATCH v3] dt-bindings: usb: max33359: add max77759-tcpci flavor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-dtbinding-max77759-v3-1-e1a1d86aca8e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAN72TmcC/6XNQQ7CIBCF4as0sxZTBirVlfcwLqBgO4mCgYbUN
 Nxd2gO4cfm/ZL5ZIblILsGlWSG6TImCryEODQyT9qNjZGsDtig5x57Z2ZC35Ef20otSqjszI6w
 1Fk+ykxLq4Tu6By07ervXnijNIX72H5lv608uc8aZEmJwKIe2b/H6JK9jOIY4wuZl/NMopXwBt
 mcw5fkAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Maxim's MAX77759 is a companion PMIC for USB Type-C applications. It
comprises the following in one package:
* top (including GPIO)
* charger
* fuel gauge
* TCPCi

While in the same package, TCPCi and Fuel Gauge have separate I2C
addresses, interrupt lines and interrupt status registers and can be
treated independently.

While the TCPCi part appears identical to max33359 on the surface, it
should still have a dedicated compatible, though, as it is a different
implementation. This will allow for handling differences in case they
are discovered in the future.

max77759 is used on Google Pixel 6 and Pixel 6 Pro.

Add a dedicated compatible, maxim,max77759-tcpci, to allow for
potential differences in the future.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v3:
- change compatible from maxim,max77759 to maxim,max77759-tcpci - the
  former should be reserved for a top-level MFD device for the
  remaining components
- drop Acked-by tags due to compatible change
- Link to v2: https://lore.kernel.org/r/20241128-dtbinding-max77759-v1-1-733ce24c0802@linaro.org

Changes in v2:
- collect tags
- split out from original series (Krzysztof)
- link to original series:
  https://lore.kernel.org/all/20241127-gs101-phy-lanes-orientation-dts-v1-2-5222d8508b71@linaro.org/
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 20b62228371b..a31e00e6b967 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -13,8 +13,12 @@ description: Maxim TCPCI Type-C PD controller
 
 properties:
   compatible:
-    enum:
-      - maxim,max33359
+    oneOf:
+      - enum:
+          - maxim,max33359
+      - items:
+          - const: maxim,max77759-tcpci
+          - const: maxim,max33359
 
   reg:
     maxItems: 1

---
base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
change-id: 20241128-dtbinding-max77759-b3ddbd264544

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


