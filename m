Return-Path: <linux-kernel+bounces-340399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ECF9872CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C043286AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583818DF79;
	Thu, 26 Sep 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHbi9cvZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EB18C931;
	Thu, 26 Sep 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350187; cv=none; b=oyU2RJfORtFzz6Q08gORpemTo+tWfk8dcVgFpRcviq55ibt4srm7XSpDPPIG3yuCUfh2oR/wW1X0qdeeu/C/MlzivpvMZ2xhHaL+ttGCe5mbLuBdchY/cm2OC0xHx+oahGJB9ALop+JOxF2JgVD+0SXl7OLevIom7HZB373w9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350187; c=relaxed/simple;
	bh=zUo6dL4FkvKfEQbRtfTjRGBerEKQpvR45DHVdVIcmmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YO4DyGoL4/QO9McxUwqfcdQteiqQe8JfAujcIxZCQx5W8m9OoxGPAinsP1NcFUcmp2kKJcVjGMhm5DL7JydE0N+1i6FaeyeFisKKkOYEKvdLqe5clUtCnYmv2aKoy+lWc5Pf7VmUCeusCw3+alMJ2YtJrf5vpCJMbP1GZOOeyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHbi9cvZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5389917ef34so806813e87.2;
        Thu, 26 Sep 2024 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727350184; x=1727954984; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnLiEF0tTzux1Tq9ZDOIhqIZJG6KKmpYuSlxKSzCAJI=;
        b=lHbi9cvZBx5qDrmMkOg3UdxSEpY01rjoFBUT/Y55K8Reu6gblqNDsTTC6W7pPz/BmK
         zxGlvYA8X+xzHN6UC2HbESeR2r7Gicj/xhbZapDtjLnTpIu4SmUjtQfZCineQ6HVEFcE
         GuFJaV9qkR44sRFPwHoPTaF4AHbnD3wu7XykwZ/pf2siOQYNaSKd2ZJPZ9XdZapjOaOY
         HjywmKskmdghszxT94b2/HwZAmENOOc87NjY6EiPmmfiPgujtYVnH08oyjNsHOYksWhh
         IQphYp9PkBzYZjLWZ8ljkI46RAv53uc3HudQHN+Dwkf9UksgwIGAs/Hb1i3O4L35wgtq
         c0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727350184; x=1727954984;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnLiEF0tTzux1Tq9ZDOIhqIZJG6KKmpYuSlxKSzCAJI=;
        b=m/OU99XUjcGB6fwbwxsUuT4oUaTH/yXj43w8DG11dlDe4zhDc5khRI0C4RSXqw7qm2
         JTl1HvlgQ6jSFtosHQd3S4xAK39WZJe+1Ws2l2GaHru8N7/7D7eYPClfo9kPhin/jixV
         9balZdQyC8gz5J+eg/VNgS78ds1ara/93WV6TdX0WVgKLDQ9c4o7wxRR/aSrgbX9TJzG
         i0UA943Y/psSDI/7XkD2MoCXd6560HBpvnFfyFTENFk4I0K94Dfj6bzCWh1DJbB58bxH
         6JCX4YEKHD+bEmwdSCyvAuT2ycd76Y30Ur+tx+eFRGw8r1C5mew6S8vZwNY30r9jkngc
         TcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8qQ+aQ/Kbs9DoCZjNB5U3Jy5CxoMqqFSQtABkqX7WvqKDWIEqyo6r0LgYQJvVb1G3PNudJeVk4m2YFFx2@vger.kernel.org, AJvYcCURcijnQF0DdovE/3Q5e+y/PRI41TaRVFZw70nIwHzP0PxO1ropltcipDIjGwsZX+bGwRFWxdbdhEGD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/q6hha3jktMkZ8q7NQdCb1LKx+pqv/U0EnJ1hTJFZWuT/ewm
	uF9goNYsgVvNsxd7DwTHjRx0f6zB+D3zPwZXmAvCCwljO3BvC+Hd
X-Google-Smtp-Source: AGHT+IFa60QpaRuVDkPl1B1Ca5ZW+L3INLkEdB4Ea1cxVSe9xhECC6bwAgHKgZ/tnAKPMSiPqDvqgA==
X-Received: by 2002:a05:6512:3995:b0:536:a695:942c with SMTP id 2adb3069b0e04-5387048ce9dmr4147664e87.7.1727350183740;
        Thu, 26 Sep 2024 04:29:43 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee5fbsm786495e87.74.2024.09.26.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 04:29:43 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v5 0/2] Add Samsung S6E3HA8 panel driver
Date: Thu, 26 Sep 2024 14:29:25 +0300
Message-Id: <20240926-starqltechn_integration_upstream-v5-0-1cb0e43e623f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJVF9WYC/43O0Q6CIBQG4FdxXEdDULCueo/WHOJR2RQNkNWc7
 x66tbqry//fzvefBTmwGhw6JwuyELTTo4khPyRIddK0gHUdM6KEZoSnAjsv7b33oDpTauOhtdL
 Hm3KenLcgB1ypghc5qWgDDEWmkg5wZaVRXYTM3PexnCw0+rHvXm8xd9r50T73NwLb2vdi8XsxM
 EwwsIZzTkkqpLq0g9T9UY0D2vCQfcBTyv4AswjSmkJT5yovhPgG13V9Ad5rAaM2AQAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727350181; l=1141;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=zUo6dL4FkvKfEQbRtfTjRGBerEKQpvR45DHVdVIcmmo=;
 b=hNdLzZPZh4isMed8mlnrr7+NXpFNDPqkUhKauPPfc+muT48QklkJNtTqyQvYYy4/brtiQTXlv
 mejn92cF9yXBbVsm8uU4I97MmZESB9dP/MIW5RcBHv0cA+BdkXy3lia
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

The s6e3ha8 is a 1440x2960 DPI AMOLED display panel from Samsung Mobile
  Displays (SMD)

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v5:
- Split patchset per subsystem
- Link to v4: https://lore.kernel.org/r/20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com

---
Dzmitry Sankouski (2):
      dt-bindings: panel: add Samsung s6e3ha8
      drm/panel: Add support for S6E3HA8 panel driver

 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml |  75 +++++++++++++
 MAINTAINERS                                                          |   6 +
 drivers/gpu/drm/panel/Kconfig                                        |   7 ++
 drivers/gpu/drm/panel/Makefile                                       |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c                        | 344 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 433 insertions(+)
---
base-commit: 3469b89bd13f10d679d1b1f5b47fb71953e96349
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


