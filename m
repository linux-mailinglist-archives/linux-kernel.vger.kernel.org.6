Return-Path: <linux-kernel+bounces-357306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA0996F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F09281A11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD291E25F8;
	Wed,  9 Oct 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYyU43Gf"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385BF1E230A;
	Wed,  9 Oct 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486554; cv=none; b=kQhR5aM7UaV9JXjlRiEq54I1KTasQYTL8BSRd8O2D8/AJpNQkUhioxwY07JG5H/OLjXUXLtopJrhGmriCAyoW+O+mnr2Gvb41hiL6TrsocwGBZ2j2rCzd9ItfYp1D0S1ZGUkTQ7309N20eFHshg2FcRx6BEfQwraE8cDkuKH7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486554; c=relaxed/simple;
	bh=I+WsgUKzSR0TDVGgB/Wo96lC4fF+rUpQR5yl1SaHv8g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XFBBUmY5hM89cR5IL5hbSTxoyW2Lt6oGackQOlyB092SBGTI6zc/aQWd5Wbfoi6dJms/47zUuv48773x5+rJIwOPiRrZ/BOapFtLQP0eSFXmgSlmLsIfCD7uMPehP24qSFGMfDxTOon77HsCAZyMPs0Fz3R9KBtDlCN+YTQqgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYyU43Gf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a995f56ea2dso479073766b.1;
        Wed, 09 Oct 2024 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728486552; x=1729091352; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQP4bXtAq110b5q+DlIMRj9A9FiDE9kHqNzGMoUSXjk=;
        b=kYyU43GfvLhlnzNh/xujjcNIRkbqSHmn32E26mX7EJovXnSDzlnBvX5hyVcfnZaZsS
         GcUyEwQVRXSY5EEaziCggRrotFPS2YeP9yU/QpVPYXEBVZxwZtYgQVbP+9JcW9c19JQ7
         t4hCaNTp36lqmTOb3rk9xhxydbAJgwtu2BFHPhGKjrrGBK5S959+5hnk2GwJvYkDt8qE
         YgCTyjLhLdNdfcED147r1zJ4+9/rdUrkOd+/oQyVrIzxriFmwnarKlEE/MO1sFpL+K+C
         VFPwJTiNG/ZohQHtKmoZsL3SiHKcd9oxvQg8X/0SSGjz4G6zt9EA+hwPF4SnDecBRCqw
         hgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486552; x=1729091352;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQP4bXtAq110b5q+DlIMRj9A9FiDE9kHqNzGMoUSXjk=;
        b=kbQ0s7ufwmXs8c+Y2BWse2+9E406NncfDwbh5KbQIAPuUHdtzVjy24U4Chv2PDmKhJ
         4hsRFuabnm6L9nxhteiKv1nIhCaEM7ciydqW3pE/pabN0ZfJyJgzJ1GAD9GqkxawYiY/
         A0xC5TbPpxI7f3FDd/x8NKCkOahanmYnqLf8AFOgPZuCAGcmeMWDnbIIk2tsSezgAOrI
         zfos7/kfI3+N9xMn68yyw/XZxTo2MUQwApJiUJ1hsfhLS7QT6W2ZQf+ZxyccgDbpiLv2
         A7HfrtlW7Jt3dsmUpr+GBVhj2FOYnEYveXZbELXeeUgiZvzfdmnUYFU8pnUOnk9jaPhH
         qcEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1Vv8Q08K+khRfS0jpd6tEM9oxs9URDmEumQvjNJKj3t3xED5+nUbtvDJGs0HRA6TkahpzATVMOTx9n+Q@vger.kernel.org, AJvYcCXNPikVvy8Qpwe5Ppe4qprUZu6E3x7KhB8K1OmyZqREZh1NUwRhgDQ5eu48tRbYm1+q71XYhEwLZ7v5@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZ93nchZPIQoRMyU7rj+CeJ+8Op+M9ZCWBpMWmrXCrzbgQBuk
	UgD/WnuLY0XLDi22yaJNpw6q0710lCui2TxhLqwzCcTh+tpyVVVa
X-Google-Smtp-Source: AGHT+IGuHAJ47CR9GiJkLEZhWahghIZ3BqZ+9vXKxjyRToKYctVTabsiExnAX6CeyRDQ2/zzVo+bSg==
X-Received: by 2002:a17:907:6d10:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a998d10e616mr248485966b.13.1728486551483;
        Wed, 09 Oct 2024 08:09:11 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-107.telecom.by. [46.53.189.107])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e7b19b8sm668861766b.154.2024.10.09.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:09:11 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v7 0/3] Add Samsung S6E3HA8 panel driver
Date: Wed, 09 Oct 2024 18:09:05 +0300
Message-Id: <20241009-starqltechn_integration_upstream-v7-0-9967bd15c7c5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJGcBmcC/43OTWrDMBAF4KsErauiH2ukdNV7lBAkeWwLbDmVF
 JMSfPcqgbYhm3r5Hsz35koypoCZvO2uJOEScphjDfplR/xgY480tDUTwUTDgGuai02fY0E/xGO
 IBftkS705nk+5JLQTdd6AUcyJDiWpjLMZqUs2+qFC8TyOtTwl7MLlvvtxqHkIuczp6/7GIm/tz
 6L5f3GRlFGUHQAIxrX17/1kw/jq54nc8KX5A/dcbgCbCopWYNcqr4zWz6B6AAVsAFUFuXcMG4k
 gZPcMwi/IGdsCQgWNlOD2vgUvm0dwXddvV+v0xtgBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728486550; l=1745;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=I+WsgUKzSR0TDVGgB/Wo96lC4fF+rUpQR5yl1SaHv8g=;
 b=yOVZmBTtbV56rqe40KXX5uPiGp7C4iqXQQmSlTVtO8Cebg9/Ntn5c+HM4KSeUf8jOLI5K8k4x
 5o3vEmQXznHAKNBeZeBxsiO48E3H6/DoRQni9Zesr64IagWYX8POrFI
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

The s6e3ha8 is a 1440x2960 DPI AMOLED display panel from Samsung Mobile
  Displays (SMD)

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v7:
- fix kernel doc
- Link to v6: https://lore.kernel.org/r/20241006-starqltechn_integration_upstream-v6-0-8336b9cd6c34@gmail.com

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


