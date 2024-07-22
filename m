Return-Path: <linux-kernel+bounces-258711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B194F938C00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B3B211D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF4D16A938;
	Mon, 22 Jul 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="E76QfAfh"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62723168A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640284; cv=none; b=OsXNAg9rNTJWQ6Ph9MsTwaYjwxB/s5A9AmxXt0Bq3o+fDQb2XRdURIPRw2v0L55ZsUAPDGIdb+o6bw8sRXIFIh2SbfnEH8QVKFgyAn/sLjT8hNzyDoktZ7OOoO2Xo1RQ2aYrLqUGIQ5TxyyOP+NW9fe82aYZBtZ/IQ1cDOVHMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640284; c=relaxed/simple;
	bh=c4VO7E8slmAUwu7CrskMROEb37MSLfQX0amVK8s9KKE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CV4R2pOPoRBiwxSjvTnp6fL0XGhOD9t31ysNpe9GUYexdxsVTJbVJSG/ncq3FSENqWk+PeScR47ms8MgUNS2cacMLr8NReOsmZ1yzJIJOVzkE8DcvLTOzWOSTz7IeDyVTy3qOPhYPD0K6WH4tm3DKGMRCw3HFhMmgi3FcBHCX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=E76QfAfh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc66fc35f2so25701835ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721640283; x=1722245083; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VumjMZEwUWBgDMHY2K8ArTMwJEHcLMaWA0OatEGrAqY=;
        b=E76QfAfhpYaVpWAOOCAYSD3J/05eiclIGrQgSUzIcd7rYbY0MwIJ52ReYqdTb6vlbi
         OuHu0hSo9Ui6eKO8QVUKLvAMWrfm11pvMP+0eNdwBSBwqLHHm3f1AHMg/wFRmHMOpXF7
         vc4GbkYFyoTamldK0ja7+GEtZopGkV2npqgYj1ZSGS+09TriR9xZti83APCwynykr8X0
         3VKTClN/DQxh6+2jZfLjSHm3taRpVUQ9Zl+tAPMpkqQddk1a3vmxT81opVvRWr0xwgai
         64a7jKGND/IeFg4L60F+8ZHJBbtKF2E7eFarRm1wWN7iMYGHNH5sKRAaNYwgY7kpYKLH
         fjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721640283; x=1722245083;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VumjMZEwUWBgDMHY2K8ArTMwJEHcLMaWA0OatEGrAqY=;
        b=Wz15OcyRIeD+pVm40MraZqmImdMsFN8GuPJOAe2boX4sqWpMdi5tE97SdfSNuDa0q1
         jyvzAGd0hCXZbi2PnoRDPV7665jf1SSYQSYL9Z6vrRr/0ur7jGbVKsmSYxRxoHlo/JW6
         67DI+NriSlxkCOyB+4WW7Xq9zt2Uz6+iJVInQYXGtpaZ7mSnY5ac4TD9F3vQ4AvA+3Jw
         5oYlmOeTzL5UogMcqfoRrcuNTTAu/pclqOv3YLmLQBKl3JFSmVpO34WnLX8TGmNjFzGq
         +C3TXyI99X56WduUMqMGuLetiok7CY8rvahdH6YqFs7+cFa9x8NDlFuXi5ELU8sz3SW4
         feWw==
X-Forwarded-Encrypted: i=1; AJvYcCXzH2fEVS3nEtnRGinDDoSf1UBO5LTSIcS5M3V1u+6Ah9ffrp96Gi1ABkvdW72PeC0WAxUYclm3JQyq4ldzgTqbq6Vo2Ymvn6UuPWMX
X-Gm-Message-State: AOJu0YxfX2bMYy7vhVaVEgM9QoZ2dH4Un0bdRyiSc0DvV70nuNIkQPkq
	Oh2gwD3fjdkCMBmwVzwevub4mKsOk4eZupiIa8TLNRIC7uF3954Ep5CQvtPNfB8=
X-Google-Smtp-Source: AGHT+IGJ+uvD9+yLKvevm6ajJFqdrqJc1OpiqXZiUgLLrUs/hmPSnu+ZQsCsNmS7e+iL5Byj4jAfaw==
X-Received: by 2002:a17:903:234a:b0:1fd:7432:16c8 with SMTP id d9443c01a7336-1fd743219a7mr120075385ad.10.1721640282674;
        Mon, 22 Jul 2024 02:24:42 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d26efe61dsm1639901b3a.149.2024.07.22.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:24:42 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 0/2] Modify the method of obtaining porch parameters
Date: Mon, 22 Jul 2024 17:24:26 +0800
Message-Id: <20240722092428.24499-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The current driver can only obtain the porch parameters
of boe-th101mb31ig002. Modify it to obtain the porch
parameters of the panel currently being used.

Also switch to the drm_connector_helper_get_modes_fixed() function 
to get the porch parameters.

Changes between V3 and V2:
- PATCH 1/2: No changes.
- PATCH 2/2: Keep bpc settings and drm_connector_set_panel_orientation() function.
- Link to v2: https://lore.kernel.org/all/20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
- PATCH 1/2: No changes.
- PATCH 2/2: Switch to the drm_connector_helper_get_modes_fixed().
- Link to v1: https://lore.kernel.org/all/20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters
  drm/panel: boe-th101mb31ig002 : using
    drm_connector_helper_get_modes_fixed()

 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 20 +++----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

-- 
2.17.1


