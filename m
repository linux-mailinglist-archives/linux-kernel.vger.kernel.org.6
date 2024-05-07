Return-Path: <linux-kernel+bounces-171473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE778BE4D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537A61F217F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3E215E5C1;
	Tue,  7 May 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="LXc8VvyY"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC3E15E1E6
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089981; cv=none; b=KJOkyuyMLkewhRP1IWei8DMzwfqrYqoNc5SQ/lVfcm8T4L5kdN3hoCvWWptk1MisMhwJLqxKuXDDmmfiubC1ndlohHwIlV9GMQD72xM+6CrIvIh6c1elYPDx3ZBHHEt1I/hJBjC+8HRjooKEvM9WT2eBurUfnXNsLmNjrdkBrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089981; c=relaxed/simple;
	bh=qPrMZjWO5HVjnBR29tCYiWMSAFUHZ/gOaIW5YSmrBiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E6rb13zRu6mLezOn61HLCH8d2A6G4MKeWvsvZ9nfMV2rCdAWh2tLqpjDMeQz4AO9vh7K0yBVzsridToT2dZoxeWY+cwESKLvE5XL0Flu+m4rMhuvQ6zVL0yu3EfTyYKwZ1ccAggfUdT6J+kFB7L+UslFdSHtSQv4NRHYMSejyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=LXc8VvyY; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36c703d13e6so13605665ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715089978; x=1715694778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5+qhtemQuDetUKDZ0kkjHy0frQuoB2GgS1mbo9cFfg=;
        b=LXc8VvyYtEj6pL/44MV2dDfHX/xi0jgF/GA1Yl9ai4L//iJflZiPHuCWznAdbS3aX+
         7LBBp502MK2jMi3lqlnRGG9bTVuFPP4vkqluabrfmOg3W4o6fow4Zjqbfd3b3m2jrXyH
         68Qz7wT+a7sMiVo7KYhrhCohkcjqNtuywsTVl50xc8bzxcSlgdCAeUVn9lbuN6yExcOq
         +Wr5KtaFCqgI+8znOxybQeOpCxCSqKh/4uEjmOcWtT3jIE6nJb7jzzckF8xxwfFgb35P
         u2qwiCKSvGKMuMjfv1hfespZAc7ik8JWIAKzVvGgTL26fyyGjmASFlCs+2brhoLMaglY
         xYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089978; x=1715694778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5+qhtemQuDetUKDZ0kkjHy0frQuoB2GgS1mbo9cFfg=;
        b=S7ByrHQfTcxm4c3n6jiLsORYK+M61Aq89HvXksIW4iU0BZZhW9BAMUsScJKQQE7Hdt
         xHIEFdFh2V2tE0m6RJ5YpREty60h6GhZNWgyNvJf8kTFn3936kIZfgDEZ8coj4nKMex/
         KjimDvcXuwXgDkOnnQEoNjn/P5UC/LVKeXema6wFNa6Lp624BZbGTfpTOfq9OlGrm65g
         z+8DJ+Bk7mDSz4WSG3pIACR/hFnlattMeq2WGhko/nd1qi4QqmXVTHtVkeU37S2U9M8s
         t494tnZkVGFMnDy8ClmVQEqNepP7SJPDPczlku3Asni9jJ1haOb7rWp5exXeY3HgUzIT
         nBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoUDBtCyeZ3SNA5ChhflFLWHVCRoFHYhQi+cw4uhL8Q9XxVvJj8QFS5bn/l1kxyg8PCMXE9Jj1iWeN4Gr1jNUKI5RRyqlE2gRw+W8s
X-Gm-Message-State: AOJu0YyHbUlVc4XKYHY/iZqr4NiR8NTS4Jqh4Hu1h0zjeER2BKi3IC4I
	OWO7sjHLaj5RGrEHIcgrjH+TC+UVK+yoPVNnkeB1NBdXvq7O5i55fEzD0lopinQ=
X-Google-Smtp-Source: AGHT+IFUIGk90awM+hDKTzEkI00KDIi3N4ht72BCJWbyJgi7KmKbd5CwDa8bL4YmPb1PbjhZ2gCxKw==
X-Received: by 2002:a05:6e02:1c4a:b0:36c:c8f:893 with SMTP id d10-20020a056e021c4a00b0036c0c8f0893mr18930433ilg.14.1715089977787;
        Tue, 07 May 2024 06:52:57 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id e7-20020a63e007000000b005dc8702f0a9sm9850542pgh.1.2024.05.07.06.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:52:57 -0700 (PDT)
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
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v4 0/7] Break out as separate driver and add BOE nv110wum-l60 IVO t109nw41 MIPI-DSI panel
Date: Tue,  7 May 2024 21:52:27 +0800
Message-Id: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
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

Cong Yang (7):
  dt-bindings: display: panel: Add himax hx83102 panel bindings
  drm/panel: himax-hx83102: Break out as separate driver
  arm64: defconfig: Enable HIMAX_HX83102 panel
  dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
  drm/panel: himax-hx83102: Support for BOE nv110wum-l60 MIPI-DSI panel
  dt-bindings: display: panel: Add compatible for IVO t109nw41
  drm/panel: himax-hx83102: Support for IVO t109nw41 MIPI-DSI panel

 .../display/panel/boe,tv101wum-nl6.yaml       |   2 -
 .../bindings/display/panel/himax,hx83102.yaml |  77 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 133 ----
 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 730 ++++++++++++++++++
 7 files changed, 818 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83102.c

-- 
2.25.1


