Return-Path: <linux-kernel+bounces-352528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106699205C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC12AB20F60
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344B189BBF;
	Sun,  6 Oct 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev6zwM4x"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E42320B;
	Sun,  6 Oct 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238867; cv=none; b=mCUUvcDq6bbTqGBMgv+8xEt2bFZbZIh9gcfObXPjyzSmirJVFHX1fqIJTj8DL3TmNiphPT2KfVvb1NTTy0+hZ8oiJaWN0Gy3SdpmtIXNpMmuaEzJga8OIGd+9SBTc2qq/6TpySrhKS9sZESH/vPSLym0GBluPGAM+BmDe+1V4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238867; c=relaxed/simple;
	bh=vECLD/CXQIREz3jN3PkpOzpo7UsKkPVEAIX/Y6pK4QE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HDWrWUzX5QL/eYLNvJr0Huw1tNANEZkKy+QhPAkWYolMMygHEj7lZbokVECu6j48nK5xi+F3dkn3v7n95uBqQnyeVSDHyx5naiAusuZJROP9tkCkkIOgnGrHFMyvVDou0qG6bWN4Rq+Tda8kGyu/2lxG3CsGOcRFECf0VshTvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ev6zwM4x; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a993f6916daso163143366b.1;
        Sun, 06 Oct 2024 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728238864; x=1728843664; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PS4ett3l2EHxVZaMcuE7ULJZXssUAZ9snL0a9gceBMw=;
        b=ev6zwM4xTOPKSdM/Xw219RxoRclkw4sNtiOX/dX1vcez25DlVW1OyFj5vOdB/UfVhP
         6+6iJAe0//YWiKgvzEfbo/HTBNZecqhC94Lg8Vpz2dm33ZV5Y2Di7DMtTfFqRDl5FyU2
         nn2xUBX9j9WALN6QD3GZquENtqelVYjNKHoEhsmE1k77jl/e9d/hZEgqi1FUvKXh3kgL
         KG9IjjMUaH7qJRcwwNs2oIiTN6hPJ8Kt1eTCxhUhuJ6lobyL2mtOjskxgGeiA2oqT+UY
         +wRGS1tq7RXjAev6gKwh6U5qtQdJjN8CJgUARrsVc4fLNfB9WQDdnumNctJtT+d62Lh+
         N2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238864; x=1728843664;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS4ett3l2EHxVZaMcuE7ULJZXssUAZ9snL0a9gceBMw=;
        b=v2wnWHfqkJxC/qPA+3wwufo4pxs7NHnOtq8y1VOjhPJwrWWPEIP050UBtzlC5zuMiH
         uK2InlS7362aZFvJM58eh7/+aj8IGpdSwqLLjTNDsgBtP5nssYQO1mQTLrnr6AncyXD5
         BqnrOxAZRtQu40osqpLto2opmZX9YVPt1NVjb7f1TmK78NxjaH5701DoSUjKmODE+igR
         ltTeANadJKi/KMtWCHhKgENFZFQY/4Tyhc6vn3d2KDUKtnO08s7L3t8sfPPaj1aD4Kx0
         fIKbP8nszwD5AEftVdob8ptxiaiyE6Vz1cO9o1Xe6jZ0XD6V2VzQ1fGT1aUVD34W9spm
         /BjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU616YhJnuSlyCIw0pv7p0QyXOUB9YKpMNujbA6T8MVHLzGK5ZjaZMWBVLpUWTyMgF3IKjUR0g534rC@vger.kernel.org, AJvYcCXIeGF5lm8wh4oL2jP9wVezHqEDAUW3smntjAJZ8opoX3SkxRTaHgzTu/nMQZgy5p0ipLWDbZdyF50XdUJU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GBJZnIBCII4OFgV4wgubR6YmPsFnQkXGoMiy06aT2Hn4SFMu
	VoZVOjEFsmYIPq4tRvrLwXSnMwmkb+tHQNh4XKnUTOBseUkY6tbp
X-Google-Smtp-Source: AGHT+IGuSjKg3/X6gdYt9rPMCtuV/cAyywZeJU0HycE+dAIVBfs5TEzseaBOxUam0JjHnaS6J1WYEg==
X-Received: by 2002:a17:907:3f89:b0:a99:4879:ec2d with SMTP id a640c23a62f3a-a994879ed0dmr326507866b.5.1728238863442;
        Sun, 06 Oct 2024 11:21:03 -0700 (PDT)
Received: from [127.0.1.1] ([109.126.148.51])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e5ba407sm294080866b.14.2024.10.06.11.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:21:02 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v6 0/3] Add Samsung S6E3HA8 panel driver
Date: Sun, 06 Oct 2024 21:18:18 +0300
Message-Id: <20241006-starqltechn_integration_upstream-v6-0-8336b9cd6c34@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvUAmcC/43O0QrCIBQG4FcJrzOcTre66j0iQt1xEzZXaqOIv
 XunIIpu6vL/4Xz/uZEE0UMim8WNRJh88mPAoJYLYjsdWqC+wUw44yVTRUVT1vHUZ7BdOPiQoY0
 6483hfEw5gh6osbWqJTPcgSDIGJ2AmqiD7RAK577H8hjB+ctzd7fH3PmUx3h9vjGJR/tarH8vT
 oIyCsIppTgrKm237aB9v7LjQB74VL7BdSH+AEsEecPBNdLKuqq+QfkBcvUHKBEsrGFQClBcuE9
 wnuc72QlAbIcBAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728238859; l=1598;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=vECLD/CXQIREz3jN3PkpOzpo7UsKkPVEAIX/Y6pK4QE=;
 b=v3siVd7HJ2mwX/KJp7hwJYmu8D3x2Q16Qtb0S+zlGwj+Wg5De9/4+V8oCWKSlYZcrnbMYvjOl
 TIR38Ex7UrEARufeSN9SKYnXRUs4A5LwLtLzOUYyEn5Sut5/jPJ0Spp
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

The s6e3ha8 is a 1440x2960 DPI AMOLED display panel from Samsung Mobile
  Displays (SMD)

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v6:
- add new patch with mipi_dsi_compression_mode_multi function
- Link to v5: https://lore.kernel.org/r/20240926-starqltechn_integration_upstream-v5-0-1cb0e43e623f@gmail.com

Changes in v5:
- Split patchset per subsystem
- Link to v4: https://lore.kernel.org/r/20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com

---
Dzmitry Sankouski (3):
      drm/mipi-dsi: add mipi_dsi_compression_mode_multi
      dt-bindings: panel: add Samsung s6e3ha8
      drm/panel: Add support for S6E3HA8 panel driver

 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml |  75 +++++++++++++++++++++
 MAINTAINERS                                                          |   6 ++
 drivers/gpu/drm/drm_mipi_dsi.c                                       |  16 +++++
 drivers/gpu/drm/panel/Kconfig                                        |   7 ++
 drivers/gpu/drm/panel/Makefile                                       |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c                        | 342 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h                                           |   2 +
 7 files changed, 449 insertions(+)
---
base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


