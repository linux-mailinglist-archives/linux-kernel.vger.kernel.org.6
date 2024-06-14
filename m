Return-Path: <linux-kernel+bounces-215061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF9908E00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446AF28A2C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4220B20;
	Fri, 14 Jun 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="DkCCCk9u"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062D15B99D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376999; cv=none; b=NBckRLM0LsrYRtR6BTlgTrmK+/mmKJk080QogbrTzAudSrsfCfGjuGKH1eZ3I77PVCVpUt2jiqwXSNBhJL2B4yKPMfBzIY2uZ4XqByhu8Z3/3iUEbo/g+2NnJJdp7FlIAQCgHvjwkXV/jzFAD5adeinfSt4g7EUEhFG4Mc3VrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376999; c=relaxed/simple;
	bh=aGppeyuNsaOvw+VIPUqT0+KoR8BYjLO52v3ZXx67G30=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Jm+gT/7RktLI3rfTN4vo0W0k7+JlTS4SvPdIh3K2EQGpT7VSsbNWMnKsVtLyzngXLR9TJAZti2TPdvXw+fwdR1cQaNJudV8cXMHZmravzDE5p8V080spEruP8yArAL4KVJzI6yimdca2mpUG+RCavJhCfTQvs7rsJjGoNj8Tcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=DkCCCk9u; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6570bd6c3d7so1528707a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718376983; x=1718981783; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGygWhumk+tcqwp5GMYArhejKx0AliClordD1s0bXAA=;
        b=DkCCCk9u3HwiMDbI7Pl8xC3niDLmXBNkK0u7y76ZEueJ2w2vWQr3LpHtYq/0JYiktk
         2TejGHdsq44bDkqr7wnxOd2CzOff4yxg/jMXsBIJrma4U2cRfsDHyQgC3nwHMNSM2+mk
         Znz4i0iUc1LJ48tBI5SVY/5B9VbEGHVaFY9f1zE2Ts6HKrV1GIjJ4I6IGr4MjjWikdmq
         jv2ZnWQ16yQWg4xICiCS6F65gwNYYXxjcy9AhwlhedmnDDDdT+qGFkQIr1H/KxydxrvK
         Qea/FnizdBSvHkQ5XxWZYd5GH2Ncw3QOKU3jnvHzlNcV55XPhROenslP+SCRUiTzwIgl
         hINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718376983; x=1718981783;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGygWhumk+tcqwp5GMYArhejKx0AliClordD1s0bXAA=;
        b=KS6ojAmQvJLyqtfiyKIM0XydvdYPBrBo0i2ScGu/PuyibNoJKdh0sm7nL1rdCpHWVo
         S7aYvyiYjd2So+pzpQB0u+28WdG+Vk+zHVadSK3KPLPdBCxvmGYfAx6b9lc3WuVSD5/W
         otqPjPd3hjPihJg2oBR9pj9KUt+nvb7PFcwsLA9EHhAFohLYHSnbG0YTNC8liZjSnCjy
         c6BEEoax3Y7WwxyJsKPyxQuhsT+pNqU+NLdNBZkbHQR2XT4+oB7KXHVJPmj+t8mUHHoB
         tFxTML8CynAiloU8HD/qvo8K+58eFZy7IdNuhkrx3k4ipKG63J1NJ1ljWZ7t+ZXUmLou
         aY3g==
X-Forwarded-Encrypted: i=1; AJvYcCWrhBjjKonDe+lDI585LFkNaef6DWdA4FhFHatiqDT7jfan/kRhDO7iiA8UQlM1fuw9yDsz1S7I5qhNqXHY+rfKTBUc6Spl2BV81GLJ
X-Gm-Message-State: AOJu0YxGE0p1etgAtu0g2FNW+CfOzkwKS5yWMEayvpzFdNs9peM+2s84
	BxMjg6WkncDuTqzCxOWOTMtwoV4I0c6zC5i3+m1r4R44g0kSq61jYyK+iKIyEvM=
X-Google-Smtp-Source: AGHT+IFF8YyHtiWKRfgYbPogRWZMDRHsWrrRNIRMzbrYy6fGxcj5I4OrroNKrSwkZwkeuKPImyd0Sg==
X-Received: by 2002:a17:90a:1542:b0:2c0:f62:7b88 with SMTP id 98e67ed59e1d1-2c4db44b9dfmr2912524a91.25.1718376983559;
        Fri, 14 Jun 2024 07:56:23 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c467c60fsm3985913a91.53.2024.06.14.07.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:56:23 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 0/2] Support Starry er88577 MIPI-DSI panel
Date: Fri, 14 Jun 2024 22:56:07 +0800
Message-Id: <20240614145609.25432-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Starry is a 10.1" WXGA TFT LCD panel with er88577 controller
Because Starry-er88577 and kingdisplay-kd101ne3 are not the same IC, 
separate Starry-er88577 from the panel-kingdisplay-kd101ne3 driver.

Changes in v3:
- PATCH 1/2: This add the bindings to panel-simple-dsi.
- PATCH 2/2: Add a separate driver for Starry-er88577, and Use the new mipi_dsi_dcs_write_seq_multi() function.
- Link to v2: https://lore.kernel.org/all/20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/4: Delete some unnecessary information.
- PATCH 2/4: Use the new mipi_dsi_dcs_write_seq_multi() function, deleted some unnecessary functions.
- PATCH 3/4: Add compatible for Starry-er88577.
- PATCH 4/4: Add starry panel configuration in panel-kingdisplay-kd101ne3 driver.
- Link to v1: https://lore.kernel.org/all/20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  dt-bindings: display: panel-simple-dsi: add Starry-er88577 DSI panel
    bindings
  drm/panel: starry-er88577: add new panel driver

 .../display/panel/panel-simple-dsi.yaml       |   2 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-starry-er88577.c  | 343 ++++++++++++++++++
 4 files changed, 355 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-starry-er88577.c

-- 
2.17.1


