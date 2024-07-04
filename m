Return-Path: <linux-kernel+bounces-240540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1854926E91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C89AB2356F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2C928689;
	Thu,  4 Jul 2024 04:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="qPOw05FG"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0EC3B79F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720068629; cv=none; b=SH+krhZbzl7iiVUe+GEBUN90jG9aj0h8tyDv1GycFDjHMF2D0/iCOEYEqiGmTYjQMinxUEmirakePIbmwuDU0scbG3x1reexzYT4iK6XskBdVq9Y2c+1zRxClfao6i6hlBNFAAraSnWLwcYbyI1zkSqZBhbGFDQyc5YPDrpEWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720068629; c=relaxed/simple;
	bh=KI0sbC/qjQOfd4Mgki4NlkFE9DmvgqINKLcY3VtZFXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kPby9Cxi2j/Gbj6MbNU1mXsaVXtaqQ3xRopvXLtwFYY8SmLxygW+1z4+XB2brXgEzvU01+JjMRmVhHIU5KoBlK6QhhRBZRpHCYnUIiVszJuODVpTFORdKQpCOjjw8GU4tbqrQso1V7kBPXKr0epDkpANjZhOrh1DGp9WiVg7CpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=qPOw05FG; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70224a923fcso154191a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720068627; x=1720673427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3gOQ/pcPbb3LfkKeHQWEv2OM2Ynwqz5rb6saZsnn9M=;
        b=qPOw05FGxtNrnA0ErB6YGtSx1FkPppiQHT8wU4/2k/oUMqK+VAY8EXoC3trP5Arlfe
         dkc1MbbFSFZcPHSTto0JpItyg0NGgn+lmap20j+WDdsk5U+B3B2Lz+FB49CDdav50YnH
         /JZzGb7rANfk5/a/cNe5uh7pWOONA8QmTPjoTwEawQj5Cr4OOOSN8wAYeJlAWNQf9sW3
         KJ1MVBM5lrCC4ofTDBbkRccGsmKI6kqisyNRubqDmVJ3lW8yk49fW05uRUAy2fdC7eiV
         Yur22gnIrljOk//HGshSoyocWo229RtaB4ZEynxnMPH3Ws44qPRmOpZTRsSvwpM43GHw
         nDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720068627; x=1720673427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3gOQ/pcPbb3LfkKeHQWEv2OM2Ynwqz5rb6saZsnn9M=;
        b=OtRd63PIwMWYh/YDEhaXa1vx24ZYYae7eSdp1XvyIbSzpOdncEU9A0CiRLCwufOzDL
         Xh+2afQYsi24NwFhi8qEoah1v5AEoOqlMKusVr/LPtyfsdARNoQhd9VroLa+QTOl3sg4
         AAKQMRwopm4TXhLcpmgou7k5PH+O6vn9iWJruig/Yu5FXYyQMNjn0sqcjU2DlfSKvi+j
         ncviy3JWSmLwh3gQMoxSi9ozwtz2d2Jnnl4lJ2nSEAl07VmJA4K5BQR5sLta9pfgjXuz
         suX43caNz+p8x5y2DKplvVXqm8HfUM3KN8tn6lPXHCyxQwmsZLyqIOgZ/YTEVg4K9+bX
         Tc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxDF4kiq+IKZWXNXD1y1TjUCpKeb01rLTk7N5zVyfmwSeXEIXr2U84YnHLB9SYrJbad+la/ICbOpI+Xaqt6uWhyUNob9OKfdH3nQoJ
X-Gm-Message-State: AOJu0Yx60/Z1J2JW51F9jaubaYv9HjeR+E53UUF6yOyCO6+/66mrHCo7
	lYLnYtrYWjqy8rf2LrtxxSroE3IQvmMxtNBHhk05t34frFHsSKrrFiqj0+InBRw=
X-Google-Smtp-Source: AGHT+IFh3qW3mPVxpPZd9G4TjfK5nxFYTDAaYwjcRaRtPMbxGNm18LvdwCp9WL+YLZdj8BA4+9h2Ug==
X-Received: by 2002:a05:6808:8f4:b0:3d5:5d95:fb0 with SMTP id 5614622812f47-3d914c5e376mr465253b6e.20.1720068627347;
        Wed, 03 Jul 2024 21:50:27 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a8ec1asm11291826b3a.188.2024.07.03.21.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 21:50:26 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	swboyd@chromium.org,
	airlied@gmail.com,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v2 0/3] Support for Melfas lmfbx101117480 MIPI-DSI panel
Date: Thu,  4 Jul 2024 12:50:14 +0800
Message-Id: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series support for Melfas lmfbx101117480 MIPI-DSI panel with
jadard-jd9365da controller.
Add compatible for melfas lmfbx101117480 in dt-bindings.
Break some CMDS into helper functions.

Changes in v2:
- PATCH 1/3: No change.
- PATCH 2/3: No change..
- PATCH 3/7: Break some CMDS into helper functions.
- Link to v1: https://lore.kernel.org/dri-devel/20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com/

Cong Yang (3):
  dt-bindings: display: panel: Add compatible for melfas lmfbx101117480
  drm/panel: jd9365da: Support for Melfas lmfbx101117480 MIPI-DSI panel
  drm/panel: jd9365da: Break some CMDS into helper functions

 .../display/panel/jadard,jd9365da-h3.yaml     |   1 +
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 317 ++++++++++++++++--
 2 files changed, 291 insertions(+), 27 deletions(-)

-- 
2.25.1


