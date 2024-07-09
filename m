Return-Path: <linux-kernel+bounces-245947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFF92BBB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D8D283A95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2524C15F3E6;
	Tue,  9 Jul 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="gxsJ06lu"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF1158D92
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532888; cv=none; b=FFHEW3CcFcX/hGaYyB+jz+8OB8RS75Vlms00fUdNiIxdrVASMugBQVwBS5kwk9qqO74/+L4DDF/xhgwC9Pxmi/A42I+dchIIcMN7VxgQykTlNxgjht1YB2vhlY39gHOpwcqi2ovWb+nJD4CvmvGRVsTkec6Kzl93PS3sYgTQArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532888; c=relaxed/simple;
	bh=p6vgAX5u010C/grGylOQ6jhewZC6S25BmWB230HdiU8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B9JxMLuPS+UX9+EByvdwFSgGdm6QlANRWWpKGOt3+6BFFUMe69aVISzA+WLtKP7qqGiHQBZfQT9uAFom/JBNbTi8iy6Ny8OVjVvBTex210ydxoi0dcGvYynGA8AkvO+GvgiOOEBao4s0yPr3uTaDlHKXlJt6zFP+0oDifTnXIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=gxsJ06lu; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2833511a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720532886; x=1721137686; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twhm5JhqawxLSrtm/hP6nNR4BfXjcByvCQnSymdx3U8=;
        b=gxsJ06luDkKwt28oXys+8/DS1c3nJGVK2PEtEnTrTqI+hWjtuuN1PWLC8/iDwx6l8b
         5sxI9bpgei6euRou+Vg4+oPF24WGyRmyMnku9OQZpztN8nNm8M88YD7swia1ES3yFvBI
         ssBX5+PMnhYYfdSPWuFwCQLVptUbkF8Q3/2f+m9jPm/J0OLVk9DEVibA+ocwKcUt7rmB
         ydPmrpk1aoaGSLzxRiUhEApZ6Mz3GHGuvz1LJLDelrEiIYzpEpE8qwYnQ9xKq6fzdOrW
         ABzq87dRHymPd5X4bY8TC6ci1NmFMEaVdxo32O881m51Cejy/2NLDIPgb/jo84nsoZ43
         A61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532886; x=1721137686;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twhm5JhqawxLSrtm/hP6nNR4BfXjcByvCQnSymdx3U8=;
        b=tAgws8XPDkehSb4kqlgdmdSwwvKtYHhLs/s2mHAaoXIVsm0/2lPRjiYNwbcAm788n2
         0jWyyuithac60gUgfOafW6u9o/6UsG+HEl7l+S8pGQVpJmsYslVoBTxU3WJ7zk3HQDuw
         czDGPtmzXRdw39Tg7R8/jgZPKYJwwfZmg+m44eyDITjeJVpXssQ5cw0fYoUS+Dp476/j
         3CoqNKlowqF9V7dK5c8u0L6rlJ10pkWNkBaG6QPWAu6HEeWuonvod9mbrbg/az3yhCK9
         Itrp3+yDyDWQbwcTG+oeORuDj86H7w+ROuh/xJo4se2C8maDR+TfyR5S4g8UOizdlZAo
         m37g==
X-Forwarded-Encrypted: i=1; AJvYcCU4Gyi/lmR1ydIGnoIV/qtJTyxFVYuszu99vd8/hq2iI6XMtYaehaEiy7Cn5wdeIpsNhiSEEqZgt/XHFWEdlfTwydbt0NfUxg5jFsWN
X-Gm-Message-State: AOJu0Yw8kTPFHQb1NcBrLA6w+3yL+TOHkz1wZKTp7oxjU6f69I0A6OaX
	MUjO7sFqxgGCurjesaMmp2GdLC8XQjR4CIRw+f2zpvZgPdCePJH95YWqa5Pqa5Y=
X-Google-Smtp-Source: AGHT+IFKbx+aySEWXrw9l6mO6v2Qj5MAZYg+fkIy6r/nddJ2H4+OlIRSpHezE5qwyR7Sturj8RgDEg==
X-Received: by 2002:a05:6a20:244e:b0:1c0:bf35:ef42 with SMTP id adf61e73a8af0-1c2981fbfdemr2877962637.3.1720532886039;
        Tue, 09 Jul 2024 06:48:06 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6b9fsm16211685ad.138.2024.07.09.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:05 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v6 0/5] Support Starry er88577 MIPI-DSI panel
Date: Tue,  9 Jul 2024 21:47:49 +0800
Message-Id: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Starry is a 10.1" WXGA TFT LCD panel. Because Starry-er88577 
and boe-th101mb31ig002 have very similar inti_code, after 
discussing with Dmitry Baryshkov, We will modify it based on the 
panel-boe-th101mb31ig002-28a.c driver instead of using a separate 
driver.

Changes between V6 and V5:
- PATCH 1/5: Corrected the use of "->init" in struct panel_desc, and modify indentation
- PATCH 2/5: No changes.
- PATCH 3/5: No changes.
- PATCH 4/5: Modify the commit information and "reset gpio" binding.
- PATCH 5/5: Add two lines of init_code (D1 and D3) to modify the internal resistance of the mipi channel.
- Link to v5: https://lore.kernel.org/all/20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V5 and V4:
- PATCH 1/5: Add a new patch, make it compatible with more panels.
- PATCH 2/5: Add a new patch, change devm_gpiod_get() to devm_gpiod_get_optional() in the Probe() function.
- PATCH 3/5: Add a new patch, use wrapped MIPI DCS functions.
- PATCH 4/5: Add it to the "boe,th101mb31ig002-28a.yaml.
- PATCH 5/5: Compatible with starry-er88577 panel in panel-boe-th101mb31ig002-28a.c driver.
- Link to v4: https://lore.kernel.org/all/20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
- PATCH 1/2: Move positions to keep the list sorted.
- PATCH 2/2: Adjust the ".clock" assignment format.
- Link to v3: https://lore.kernel.org/all/20240614145609.25432-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
- PATCH 1/2: This add the bindings to panel-simple-dsi.
- PATCH 2/2: Add a separate driver for Starry-er88577, and Use the new mipi_dsi_dcs_write_seq_multi() function.
- Link to v2: https://lore.kernel.org/all/20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/4: Delete some unnecessary information.
- PATCH 2/4: Use the new mipi_dsi_dcs_write_seq_multi() function, deleted some unnecessary functions.
- PATCH 3/4: Add compatible for Starry-er88577.
- PATCH 4/4: Add starry panel configuration in panel-kingdisplay-kd101ne3 driver.
- Link to v1: https://lore.kernel.org/all/20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (5):
  drm/panel: boe-th101mb31ig002 : Make it compatible with other panel.
  drm/panel: boe-th101mb31ig002: switch to devm_gpiod_get_optional() for
    reset_gpio
  drm/panel: boe-th101mb31ig002: use wrapped MIPI DCS functions
  dt-bindings: display: panel: Add compatible for starry-er88577
  drm/panel: boe-th101mb31ig002: Support for starry-er88577 MIPI-DSI
    panel

 .../display/panel/boe,th101mb31ig002-28a.yaml |  21 +-
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 303 +++++++++++++-----
 2 files changed, 236 insertions(+), 88 deletions(-)

-- 
2.17.1


