Return-Path: <linux-kernel+bounces-197774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162178D6EF7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 10:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476AD1C21F78
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8121364;
	Sat,  1 Jun 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="r6aF4C94"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777311BC49
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717231572; cv=none; b=UIVAEt/ia9aiHZZfxd+2EqKACE0QWUDHqTn98jaWMR5WpXgoHatfn5kZMe00UirFpZ2bmArPhu2XGacFiAopPDRz+MyX8Vnnx4qZ0wC6VCKMcDkDQCmOHaJ/cJ6WHmIRwvbBMcfjvcsx/9e7pymlmmpm/ZOdPJlxwCxpnpN7aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717231572; c=relaxed/simple;
	bh=j+G3sJ3EZg3XxZAvXVoFaY2rZtsC0Iflhza67llFZxY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=vEiUi6KuGtbw2p8QWFOXI21Dm60Nt2d6fOvBVntqhy6TL3OinYiwOeaSGoqdVh2/eESE01i1nbFnUDctiIaLPze9MI3ibWT1jhaisQkeIIvHLQSYCXpfkhecxpgrPwvZU/h1uTgtNSgqhujgvnFqd+lgICIB7R79Ine0B+LexrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=r6aF4C94; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-70109d34a16so2606964b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1717231569; x=1717836369; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W/njC8us0KW9wHmKF1n4OA9SOaALdpb4Qdax8q7WYs=;
        b=r6aF4C94qH81sX0jUibLUp6H+13sBFmqjsK0W0/eLZEHXqdZVrT+cmWcDHJpzoyp8D
         q6R50pBfuzlW9QmaDA9N4ysvUABZDH6i2359XzvRp0JndkCOjSQsR+mfchTE+FqY28Vx
         WwiRYMYjNTXK1fIyy9WJddUDr2wD5cHvUaJDu245qGGdrFAIGT2MMUxLlIRvW1ae7Oae
         3g607quI/1sgLpVrMtQ0EwtS8WUrBZZNaFnw9Sdn+dd3Ai8Wf1DRRvlTQIaovMGHRMxS
         tdBKplmbYcmsYvxtlOehvO2yzjfsDWnOtmrbOS2Hrk9OlXd8VopuTGn8gEUfAEds9qnL
         6DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717231569; x=1717836369;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W/njC8us0KW9wHmKF1n4OA9SOaALdpb4Qdax8q7WYs=;
        b=XUAOmV+izw3+uuhnytVzqaZI6C/pcy5gwBNbWvbLGnnaN90X0E8KKFOYDy76BOuII4
         hnUh02ue+uRD1n7ogfPflNfGKia/PcV9vu9rpU3qhWFWbHl2x4n9QV9CTvOkMg47w08Y
         TbXtsSLVu7kgd8vwmOKwoo2erLyH690Nu4dootWn1h6izbQGLfudBdELty7SVEC5KtOI
         MyKnDNpvwVlrHSVpgr3GQeITR+JQlYZwOGQ3dottkE/yzzJJ25WGByUQZxeYK0oOXw1f
         nV0Vc/KQlNkHDh/R7VRfvLnskKqp+/K57f9ZPnKD3+foWDE6P5PHdKLYNLxyxDyBluSe
         cq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDcV3L6c3yBE2B8yofKq9tHSHUIZzT8WJVCbvdF6CNmjieTmqHOLEJpXBn0WSWqIRNWjptnz403Alb3gyYyJ/9d/KOjVecJbBhScDd
X-Gm-Message-State: AOJu0YxXLKYRj6zbS2RLd9/HT1qj5imv2AB/umZS+GJq4VwyY0nGyNQb
	Dhe/GgM+ONpsLbQQqLfjWQ5719KjSRPxXG5AiGRt5WJqMlDYWSMQrG5aaPA3yIE=
X-Google-Smtp-Source: AGHT+IFmDV3Jqwu0YGOOnlIeAfrrik6DTGBn2D+eeZPZ5jFdR+A2cJFQgPvdZghdlvohqml57qK3bw==
X-Received: by 2002:a05:6a20:100e:b0:1b1:ed95:6191 with SMTP id adf61e73a8af0-1b26f3059d4mr3641718637.52.1717231568693;
        Sat, 01 Jun 2024 01:46:08 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423c7b49sm2512044b3a.37.2024.06.01.01.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:46:08 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Support Kingdisplay kd101ne3 and Starry er88577 MIPI-DSI panel
Date: Sat,  1 Jun 2024 16:45:24 +0800
Message-Id: <20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Kingdisplay kd101ne3 and Starry er88577 both 10.1" WXGA TFT LCD panel,
And the two panels have the same timing, so add compatible for Kingdisplay 
kd101ne3 and Starry er88577 in dt-bindings and drivers.

Changes in v2:
- PATCH 1/4: Delete some unnecessary information.
- PATCH 2/4: Use the new mipi_dsi_dcs_write_seq_multi() function, deleted some unnecessary functions.
- PATCH 3/4: Add compatible for Starry-er88577.
- PATCH 4/4: Add starry panel configuration in panel-kingdisplay-kd101ne3 driver.
- Link to v1: https://lore.kernel.org/all/20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (4):
  dt-bindings: display: panel: Add KD101NE3-40TI support
  drm/panel: kd101ne3: add new panel driver
  dt-bindings: display: panel: Add compatible for Starry-er88577
  drm/panel: starry: add new panel driver

 .../panel/kingdisplay,kd101ne3-40ti.yaml      |  60 ++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-kingdisplay-kd101ne3.c    | 625 ++++++++++++++++++
 4 files changed, 695 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c

-- 
2.17.1


