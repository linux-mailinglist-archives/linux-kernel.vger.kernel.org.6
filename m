Return-Path: <linux-kernel+bounces-533637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE046A45CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CAD164D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296C215076;
	Wed, 26 Feb 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex8EFZaM"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E918BC3F;
	Wed, 26 Feb 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569184; cv=none; b=eNsKcda1HzBujbLr1tIfiKrRdtv37p5b6SqKUHd7n844Mu2qdXfqNm7QiSlzGtQXgAwPQXoz5bla3n2INzYqPlVO4SnqJaBvIJH5O9yAMiSkjXMrJZ0YGPIZpemHXxY9wGrDTOZxwehn1fdJ1vFfxE5EcbzLqu46SlpgRH+X5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569184; c=relaxed/simple;
	bh=zEOpAQ3TNh8wIrOQOfZKYRWgEu46E5vBMN0WAf+fpGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hM3M8xhN31TkJrAj56OiWRKPqB7LondHn+Eh84+83CJ3wBxg/FThzVFhHaTQOb+oRf4kc3MGuO411x1hrENVuS/yXZEp9rw/SRi2SxjkpGiUJKXJaVY/toNtKvhkWMF9Q/jSWTyNcH63ec0gO0xM1odNvw+F2aJgykChFDWqEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex8EFZaM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22339936bbfso2817575ad.1;
        Wed, 26 Feb 2025 03:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740569182; x=1741173982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMvhFmeWiiJ59MbWRJ0xc+vmIBHwrNScSowo75dvzJU=;
        b=Ex8EFZaMVWbqd4bJs8lhEgwGDlA45t94ELExhl6gSdGV3P1LyK8RrcjktjYRztWSS8
         PQegF0y5t3qSzqPKLEucHe8aDtFcX5ZMFnAXLHZwHAWzJGoU8VGNlMgCH5X68VN98V/P
         BG6zzkZ9sY0kFD5QC3FDC5WB1oTt46fkI00QX7z4yf4PRk/KSCPiqeyHQ2iBtvWGYjaH
         c5gySIXnCAk/CBYW/Gsv8shbK83SpsBRCus/IjrPgnKCOuwpget+rBO7+N8R2hJ2LzUu
         i6aJERU+wJQ4Q7ZpnmRrLZBaM9jh2bjqyM3Mb7zTEluNUUy2W6tJwwTxD/6N9ZsN9oaG
         OIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569182; x=1741173982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMvhFmeWiiJ59MbWRJ0xc+vmIBHwrNScSowo75dvzJU=;
        b=fQGpwKVAOELLA9bhf9jte94YvsMtQkfWm8Vjxk/wMKJ0gTxh3ivQv7GI2ol+IaGUFc
         qC9XFMD9XNabF1cLbi1Ns8T7vUSyt40ySvlWEqVxRfh/SeYa/+3puURXf02GCIj10rhX
         slJ9K37ZZKkJTify1qalYDk3KpZhQJSX/YNsK3Egyn9m+JH49egzcFRJsE6iN1QWZ5Dk
         SQ22iwSoNWn2BQtqu17YQiMUDvtkrEgiZF25uB7xwuhFDwG2u5udPvVykzdbUCvlBzIe
         HnpXpmSGrAqet4xtdqete8aYkMfzt85wwpQXFbzINrN6aLIDFeVF3xe61xJO6pWuBUiS
         J5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0K2XGfK8+4roRg2lHZZVWaQmYFzaSpEykQca+IvAP04+ajumxyPRDVEj9VQcL6rk+Rja1TnOE9/DI@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhHYqEWLw3cpkZPGZlkVGQrxpLZSAjNhs2/Y1V2EfO/WnDrgt
	b9idDNdc3b9+SXvrwTmp6wK4qEtJNno403L/2KaEgh32nubLTAwyXFFJonS7
X-Gm-Gg: ASbGncvjcfFCe9j7hUWzIpEvdznXafFU42VlQ0GQOTOSrkOAve7j1yb+prTw49ST1GM
	Hx3aoehBoYwJZIR0E5S+t9l625cKeseVG0snnt56zv26jloDsMXo+uHHW302Sk3WWIWIExHd6Kd
	08QkXgSwqz2+f4KgEnYWvrRekHMasTp9dYzjxFoto7BgqCICodHdDHgzAnJZoi1EXVtbUX55Dt5
	CGjMnJbxQ7ZcZ3xRrlqNvWCo7j1Y16Cq+P3Xxdna8WBLTsvkBxpz6TKFFR924ZnwovctYo7HXCQ
	MG0DuKhDewnpCjUjJiZY4o+k0fnJpWfGbVrwA/D83h4Oxf8nPJIyd+7uVV4ekrshrIVl9w==
X-Google-Smtp-Source: AGHT+IEMiq2YU5RKJm3D770WMo6TL1/47tghAXdIVx19pY6j2yorw9+JiO//+tAGrvPkBGyhZtqsCQ==
X-Received: by 2002:a17:903:1a86:b0:223:225a:7e4d with SMTP id d9443c01a7336-223225a80c2mr37478285ad.26.1740569182523;
        Wed, 26 Feb 2025 03:26:22 -0800 (PST)
Received: from localhost.localdomain (221x255x40x66.ap221.ftth.ucom.ne.jp. [221.255.40.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0009a0sm29800345ad.27.2025.02.26.03.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:26:22 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] drm: panel: Add Generic MIPI Panel Driver
Date: Wed, 26 Feb 2025 20:25:47 +0900
Message-ID: <20250226112552.52494-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a Generic MIPI-DSI / DPI(+SPI) dual stack panel driver.

Although the MIPI specifications define how to communicate with a panel
to display an image, some panels still require a panel-specific
initialization sequence to be sent.

While there are many dedicated drivers for such panels, they are very
similar to each other, except for the configuration parameters, including
the initialization sequence for each panel.
Since there are numerous panels in the wild, adding parameters to
the driver for each panel every time is a pain.

Instead, this driver offers more generic and convenient method.

Its fundamental approach is similar to the `panel-mipi-dbi` driver,
which sends an initialization sequence stored in a firmware file.

Moreover, this driver allows display modes, timings, and panel
configuration parameters to be stored in the same file.

I've also come up with a firmware generator [1].
It helps to create or configure the panel parameters on the web.

As a reference, similar generic drivers currently exist:
  * drivers/gpu/drm/panel/panel-simple.c
    - Supports wide variety of panels, but no init-sequence support
  * drivers/gpu/drm/tiny/panel-mipi-dbi.c
    - Supports init-sequence, but only supports DBI panels
  * drivers/gpu/drm/panel/panel-dsi-cm.c
    - Supports DSI Command Mode, but no init-sequence support

[1]: https://kikuchan.github.io/panel-firmware-generator/

v2:
  - Drop redundant properties from the DT binding
  - Fix the compatible property and examples in the DT binding
  - Drop support for the redundant DT properties from the driver
  - Fix minor issue in the driver
  - Add panels to the DT binding

Regards,
kikuchan.

Hironori KIKUCHI (3):
  dt-bindings: vendor-prefixes: Add hothmi vendor prefix
  dt-bindings: display: panel: Add some generic MIPI-DSI/DPI panels
  drm: panel: Add a driver for Generic MIPI-DSI/DPI(+SPI) panels

 .../bindings/display/panel/panel-mipi.yaml    |  121 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/gpu/drm/panel/Kconfig                 |   10 +
 drivers/gpu/drm/panel/Makefile                |    1 +
 drivers/gpu/drm/panel/panel-mipi.c            | 1181 +++++++++++++++++
 5 files changed, 1315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-mipi.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-mipi.c

-- 
2.48.1


