Return-Path: <linux-kernel+bounces-277706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6294A505
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5242B26798
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239A1D1F42;
	Wed,  7 Aug 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="XjFIVe77"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C211D0DE9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025084; cv=none; b=PyHIgJslHHEOXIct0FY/jWlwmUClABmSqvjRSGC7a79Uld8xQOPZKkksSCWuZ1deCisYa27agNJRGX7DXRN/GhMezvj9zgaYD5vJjVhm2iGN8VGz9Zz72lBImYIb3kx68QognpapE57Gxo31OF14iHv7thQ1z0XlEXRXORroACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025084; c=relaxed/simple;
	bh=J6qm3DrG39gvppiQ096gSYkLIREaQlXByjw7TGJNa0c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a5P4x9vHVJHzroG7sxuRK+HxxBf+QMTC9vsf+WYLFy+KHXOzTvtoB4w1u5Ts4DB0sMvckpcGQ57EkauR+INmnR+hQspHHbGJ9VvQmA0B781iZPZakUPq6bB+akWFoQZm3OdMUP3h0OJx6zheLdF6mkYUTA+TQBCqdFE+J/vN2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=XjFIVe77; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-710afd56c99so561414b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1723025082; x=1723629882; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgEGMdmx49wb7/1ddWfTMcTpQTAGqkrivezogTjL5Sw=;
        b=XjFIVe77rgi64w6/xwQ1k3/ZHhAOFUohDNzT5HblYHy9yG/ISJRRU1hWHsOmsBzpDK
         FkajAu2kny2kkZhFZ3c0fWFo4m4wCz4dkxhc0kIysjBSD5z85Imw3H60A9zHBKvjEVZH
         Wd5PnC+P0y+Go5wBPKzAU2Ni23YtUxpfBJ7W6y/iRWdMaRNDTk8KltPc/NjCLLbsFQ/d
         880oHfwCWkJ7LlBupeCj31pql6EQci/c7vyxOAkUPjpqQJjSMy2v5H9PNsm9bEwjjzvp
         PxiPXdzLYg8flITFQ6dRX4iDThByY/xebF2TqIz7fmLK82fqJV4GDQ9jhVosu4CBPtK1
         xvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723025082; x=1723629882;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgEGMdmx49wb7/1ddWfTMcTpQTAGqkrivezogTjL5Sw=;
        b=kKa9lXUiDzgKodk93cquuwLulVoRJqZpSQmZDjO5moOSCyH9xhKyTFxV7PAodtg2wg
         ecZtI/sEV9tLMQOHY5Sv1dWeRo2+XB7ul10kpprVYwV0y75rS42e2gCglSmwYGpVcVLa
         W7RiwfYbHlpoHg4H/D0sz8iPBUwOXHkHBc5lMr9vevTLGMbzGE/Yd19kJM3CLqwEMRms
         zzooruFbGGjCkLHGnDEnTGJlxS3NKTjtCoGTH4PNUb6TbUCeH47KNnDcCYNm1vYVEUeG
         HNiyWZ5L6xk+yyRkjamTtSpCHHj1bzQEp9qDXpQ3SusC5C98ktKiQ/qMCcDNpYLHWnNz
         Prew==
X-Forwarded-Encrypted: i=1; AJvYcCWPfwF35lNXAwVI8es7FhD07l+wtFbyYpnIc1f7mUaw4tSJE5/XYSLyx3y+iI6blEmjgZ/MFFG6667D0VMED0SmdgHKxAqWLb7wybYN
X-Gm-Message-State: AOJu0YwklYW5JBGbk4kckRlJw+O+gn5FV/j2uEqQJVV86OmYEMNz86+7
	uuKiAPSTp/TwV3LUnVanhRRkYjKotBy7fGV9MxAWQwJOE3l3S0ZXI22BhDdSu38=
X-Google-Smtp-Source: AGHT+IH6GVSkW+cm1e7rcncpZyCWMyA/YyxUgGYFYcAZHFnUAsi+fcpr5GbKvybufdDmOfR5fGnhnQ==
X-Received: by 2002:a05:6a00:6f12:b0:710:4e4c:a4ba with SMTP id d2e1a72fcca58-710bc916a6bmr2323815b3a.13.1723025082453;
        Wed, 07 Aug 2024 03:04:42 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdff89sm8119248b3a.103.2024.08.07.03.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:04:41 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jagan@edgeble.ai,
	dmitry.baryshkov@linaro.org,
	jani.nikula@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 0/2] Modify the method of sending "exit sleep
Date: Wed,  7 Aug 2024 18:04:27 +0800
Message-Id: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This "exit sleep mode" and "set display on" command needs to 
be sent in LP mode, so move "exit sleep mode" and "set display 
on" command to the init() function.

Modify the Melfas panel init code to satisfy the gamma value of 2.2.

Changes between V3 and V2:
- PATCH 1/2: Modify the commit message and subject.
- PATCH 2/2: No changes.
- Link to v2: https://lore.kernel.org/all/20240806034015.11884-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/2: Modify the commit message and subject.
- PATCH 2/2: No changes.
- Link to v1: https://lore.kernel.org/all/20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  drm/panel: jd9365da: Move "exit sleep mode" and "set display on" cmds
  drm/panel: jd9365da: Modify the init code of Melfas

 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 137 +++++++++---------
 1 file changed, 71 insertions(+), 66 deletions(-)

-- 
2.17.1


