Return-Path: <linux-kernel+bounces-180693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353688C71EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB2B1C21521
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE722C6A3;
	Thu, 16 May 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Dk1sja1J"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6BC8D1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844068; cv=none; b=PsaWAvrYvX41oxktyOWD3P+ywTR8/Bs0eeHEBx7wbD6ylpF3mYP9GxI6en76k35sFe3fYK1sCtIx52UhU6Kno/3sjq9Pf6NyGtUnhDsl3q1c0Pw9UxKouB2TgxwlzJZtC6RZ9vckeXjr35Fvc1lv6Zv6QdcL7csVMH/3PpWd0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844068; c=relaxed/simple;
	bh=kUumDROhfsR3afzSHkfjTBxrijudtRLJFt1YuMC6jU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AhY8KUs4PtXi2NL7fcZf3j6d8mrRysvQirjUP/wqhF7oItfliRkuodcHRnWnLvPFQKXUgum18rpFgHu7g/Au1yypyacfkbnWEnVrrZkOUIbWJTTnQ0YkwWLErzq2sqzwK02FLXTBGJA8uN4Tw+KpNTq6OlZE9DS06pSr0H4BdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Dk1sja1J; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so6479480a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715844066; x=1716448866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToSw8/xXq6HjfzbRr5t4Tk0/fieWO/pkI64Nv2v4KY4=;
        b=Dk1sja1JqvFsQy84N0ZRN2R5pV/AjUsqaewylf63uL2QSs44TME6yP2XA/nVsPhClb
         o/QoaNM0XD3axuPlHh7P+7iKQRHmMPtYA64q3TNTzvPPp2dsTv2IuEVqf2zsfJFc0GZc
         k5DPfRotzeglBxfoNYyzbe+NPjKjF/8RLIGBR6rjrLrPOjIMnHBq1fI/1iKNcLDyqGHN
         1kVBugiuvtPK/7vYjzjhc+HZhAUApS3/DeC/TjfXAsySNlihJOmPCt6o1lEEN6KgJLuW
         ALW/hjNaV7vyrZEbK5HwWqg82vQN6eWFY0KXTY+uNdnLQHhwhDGnnsK8WHiIczmZku73
         DKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715844066; x=1716448866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToSw8/xXq6HjfzbRr5t4Tk0/fieWO/pkI64Nv2v4KY4=;
        b=MrptN8JYQpqvpAvf1BjG3va+3n6NApwqCNa2wOnd4y4mow1Y4e3ucpWi6xcFTk0Lvb
         ALs/eGQtRIp217HFNoc4n7B3lNTvV9vT+nfT2YkLEWO+LT/t6PXYMjocQv7mADKYTS0m
         Y+wkAqf24aSzVXb2CnYC/YEjFQIHmIVFOqwNfaZX8hn5jDx2I/BH+UUGmf2n+UPK8021
         m3BrgbexXLkP1Hy+okDI3QL802z3j/N8aIlcKcqWxb0Udo99viBVEKyyWuF36rNZ/FEf
         E4uvSvDawROnOAqh0ueCHzpCAl6hqpkWQrEl/NTpZ+oSKkq1VUKr/tNzcL1v01iyjmP9
         n2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgWs7bzIYDeyzxP79ovWFJ5lXechx/afZ9QAXCNBZvqGJxfHXJJ1j7yPA2VrDEqNwX1ZoyF9n2MelXc1LbqJT3Ijj/VYDPLCyNyfk4
X-Gm-Message-State: AOJu0Ywo9BXaGYw3iFRMRDjyYBDWYFOEdfGBcRTGndAdKO0OBmrTK2u6
	6yarF0l9QY9karOHZ0Mk+wTzwCD8Ghv4moOqswMwL01Xv8fibe0Sjgcmkd/YVsQ=
X-Google-Smtp-Source: AGHT+IEAnol0Q9MPVD5URxRpCHiFamJ1XGv9zEh1AAJQVhTl/mUtFn8KoAsDgmlwRJtZqBIRf9l4Jg==
X-Received: by 2002:a05:6a20:d48c:b0:1b0:1c8d:5bd3 with SMTP id adf61e73a8af0-1b01c8d607amr6382388637.59.1715844066568;
        Thu, 16 May 2024 00:21:06 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a663a3sm12318724b3a.41.2024.05.16.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 00:21:06 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dmitry.baryshkov@linaro.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v8 0/6] Break out as separate driver and add BOE nv110wum-l60 IVO t109nw41 MIPI-DSI panel
Date: Thu, 16 May 2024 15:20:33 +0800
Message-Id: <20240516072039.1287065-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discussion with Doug and Linus in V1, we need a
separate driver to enable the hx83102 controller.

So this series this series mainly Break out as separate driver
for Starry-himax83102-j02 panels from boe tv101wum driver.

Then add BOE nv110wum-l60 and IVO t109nw41 in himax-hx83102 driver.

Add compatible for BOE nv110wum-l60 and IVO t109nw41
in dt-bindings

Note:this series depend Dous'series [1]
[1]: https://lore.kernel.org/all/20240501154251.3302887-1-dianders@chromium.org/

Changes in v8:
- Neil think need sent separately to ARM SoC maintainer with "arm64: defconfig: Enable HIMAX_HX83102 panel patch ", so remove it.  
- PATCH 1/6: No change.
- PATCH 2/6: Fix Doug comment "return ret" change to "goto poweroff".
- PATCH 3/6: No change.
- PATCH 4/6: No change.
- PATCH 5/6: No change.
- PATCH 6/6: No change.
- Link to v7:https://lore.kernel.org/all/20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com/


Changes in v7:
- PATCH 1/7: No change.
- PATCH 2/7: Fix Doug comment "return ret" change to "goto poweroff".
- PATCH 3/7: No change.
- PATCH 4/7: No change.
- PATCH 5/7: Fine tune HFP/HBP/CLK to increase the frame rate to 60.01Hz.
- PATCH 6/7: No change.
- PATCH 7/7: Fine tune HFP/HBP/CLK to increase the frame rate to 60.01Hz.
- Link to v6:https://lore.kernel.org/all/20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v6:
- PATCH 1/7: No change.
- PATCH 2/7: Modify Move mipi_dsi_dcs_exit_sleep_mode and  mipi_dsi_dcs_set_display_on from enable() to prepare().
- PATCH 3/7: No change.
- PATCH 4/7: No change.
- PATCH 5/7: No change.
- PATCH 6/7: No change.
- PATCH 7/7: - Adjust inital cmds indentation and check accum_err before calling mdelay in init().
-Adjust somes inital cmds to Optimize gamma.
- Link to v5:https://lore.kernel.org/all/20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v5:
- PATCH 1/7: Modify compatible format.
- PATCH 2/7: Modify hx83102_enable_extended_cmds function and adjust inital cmds indentation.update commit message.
- PATCH 3/7: No change.
- PATCH 4/7: No change.
- PATCH 5/7: Adjust inital cmds indentation and check accum_err before calling mdelay in init().
- PATCH 6/7: No change.
- PATCH 7/7: Adjust inital cmds indentation and check accum_err before calling mdelay in init().
- Link to v4:https://lore.kernel.org/all/20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com

Changes in v4:
- PATCH 1/7: Update commit message and add fallback compatible.
- PATCH 2/7: Add hx83102_enable_extended_cmds function, rename UNKNOWN CMDS and depend Dous'series [1].
- PATCH 3/7: No change.
- PATCH 4/7: No change.
- PATCH 5/7: Depend Dous'series [1].
- PATCH 6/7: No change.
- PATCH 7/7: Depend Dous'series [1].
- Link to v3:https://lore.kernel.org/all/20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/7: Update commit message.
- PATCH 2/7: Drop excess flags and function, inital cmds use lowercasehex.
- PATCH 4/7: Update commit message.
- PATCH 5/7: inital cmds use lowercasehex.
- PATCH 6/7: Update commit message.
- PATCH 7/7: inital cmds use lowercasehex..
- Link to v2: https://lore.kernel.org/all/20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/7: Delete Starry-himax83102-j02 from boe,tv101wum-nl6.yaml, add a new bindings file.
- PATCH 2/7: Break out as separate driver with Starry-himax83102-j02 panels.
- PATCH 3/7: Enable HIMAX_HX83102 panel.
- PATCH 4/7: Add compatible for BOE nv110wum-l60 in dt-bindings.
- PATCH 5/7: Support for BOE nv110wum-l60 MIPI-DSI panel.
- PATCH 6/7: Add compatible for IVO t109nw41 in dt-bindings..
- PATCH 7/7: Support for IVO t109nw41 MIPI-DSI panel.
- Link to v1: https://lore.kernel.org/all/20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com/
Cong Yang (6):
  dt-bindings: display: panel: Add himax hx83102 panel bindings
  drm/panel: himax-hx83102: Break out as separate driver
  dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
  drm/panel: himax-hx83102: Support for BOE nv110wum-l60 MIPI-DSI panel
  dt-bindings: display: panel: Add compatible for IVO t109nw41
  drm/panel: himax-hx83102: Support for IVO t109nw41 MIPI-DSI panel

 .../display/panel/boe,tv101wum-nl6.yaml       |   2 -
 .../bindings/display/panel/himax,hx83102.yaml |  77 ++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 133 ----
 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 738 ++++++++++++++++++
 6 files changed, 825 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83102.c

-- 
2.25.1


