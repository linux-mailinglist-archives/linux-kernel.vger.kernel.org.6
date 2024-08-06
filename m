Return-Path: <linux-kernel+bounces-275646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FBC9487F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51ACB22965
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393F541AAC;
	Tue,  6 Aug 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="cKVo84iZ"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69C6BFA3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722915629; cv=none; b=RLnbblUZ+i7msrJCOVEXm31pKanLsxJYwGWZB4B3ksfF4PiMXPuOkNhekFJBJltNoFz+6vSVUQKgRTQVxIXvWGHyeE88arlJLMAAznCsAJvgdetx7U0JW4EkiHhf4/8OD/g0t6pWORezIY3g1bHKUo5F35F+y8NamUbY+zwy2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722915629; c=relaxed/simple;
	bh=WsQjKNqa5T7o9h4tmVK9b5oVa9s/iUl6rZ+w+Y2c4sI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ge21xli1QAjF9d2IZ78lgv4WtJ1YUmuMIYSvUjFDYZiVC+9RC5LCBssqK82Q4xT1xfmiV336tLJ7jba6sUzjwtNAVRT0mgaasjzL79CbtXQNxVoVBOVaZXe1ZXsm13Byw24t/buDVfn9yzqUkx3po/+I8WnQMr6Km7lc4jqDqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=cKVo84iZ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db1270da60so109338b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 20:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1722915627; x=1723520427; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUtLE+GRjq8+ez1aJNrMr18S+I/P61WDmzvbeDjFvn0=;
        b=cKVo84iZbjvkNU9zOPViUSldmPSx5hIx+IdF4mSi6CLi5b4YxqdKMueq2v/0XaE31y
         0OYrHu6Gf74vZP9/u4BAdW7UecB2PRMWnQaOSc5U5cnP0sObEYd3yO//mxvq8/MT+rUW
         r9FYQRnhbUdVJwNU7xbx8k8mPkYanglKt2+3HWDAtIMWNfgnQtYbd/g0Lw4jWvV8UZYt
         +/F9D+auOBejaAlM+Mb9KyYxCzsgrAgqAnEoML917j2terY1lkv+9EGzdMJIgPFAcw4B
         VlRjGro1BVR0esaNQZiXJbrzlcEatvQk/Nc0zSf4olTFOtl4IECDGUZH3YbnLlOLgOQs
         DgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722915627; x=1723520427;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUtLE+GRjq8+ez1aJNrMr18S+I/P61WDmzvbeDjFvn0=;
        b=A8oNNrVQX0C6wuhIKpuHbCWadYk2G78VZnReVXlb4E3hFU15R9hvMpPqG8kvV7pTSQ
         8bySRWDZrn+Iz/XC9Aa0iIt4irmL5iNwKmAyxLO9EmqXXfUXwY/mssjb09n13hRGJKqI
         5Lm4usiTiHMTNdXyp19gR4kkG12gZ8g4CZRRYqigVKBA/2DmVZfCVsHIIFfiP+/2Jhri
         JMJ/cwH+pP2/EjuM3f7u6uFFj5SADWZSMl2UqNigSrRzoLUr1rp1kR3A2u69MxJLJbKh
         /ZXjb2pbcrK3uazCBNoRL64+LvWhOdjAuwP6wN5EGPYDLwg8ADEMdcuugFSLp7oTe8Lb
         dH7g==
X-Forwarded-Encrypted: i=1; AJvYcCW4CjoR8QYw8o9l5Qubzdgt1/ocLkawfNK4hgHjaPI5Slw65lPUtr3GiBZQyU0mMOxG6Yo0fKjoaXTzatUGCPju7xMBZtN7ruIaH1R6
X-Gm-Message-State: AOJu0Yy25G043dv/B09XtnSp+JMsRB8By6Z/WVpTD8P/j65VvYtgsa54
	R/5Gu9GLkQEX0DbDGSbBvGossYCet2DsDv76mihTliaejZ85+sl19Hl8Rc+4pyQ=
X-Google-Smtp-Source: AGHT+IF4ObCPxoLMRKSfEYyb6QRkFWDV2npxxccZHFEYp9HPYvXbumPJc8dx4/W3Ek9myBwG1p+/Dg==
X-Received: by 2002:a05:6808:218f:b0:3da:a793:f111 with SMTP id 5614622812f47-3db557fca8emr19666426b6e.8.1722915626701;
        Mon, 05 Aug 2024 20:40:26 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec49486sm6134074b3a.55.2024.08.05.20.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 20:40:26 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Modify the method of sending "exit sleep
Date: Tue,  6 Aug 2024 11:40:13 +0800
Message-Id: <20240806034015.11884-1-lvzhaoxiong@huaqin.corp-partner.google.com>
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

Changes between V2 and V1:
- PATCH 1/2: Modify the commit message and subject.
- PATCH 2/2: No changes.
- Link to v1: https://lore.kernel.org/all/20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  drm/panel: jd9365da: Move the location of "exit sleep mode" and "set
    display on" commands
  drm/panel: jd9365da: Modify the init code of Melfas

 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 137 +++++++++---------
 1 file changed, 71 insertions(+), 66 deletions(-)

-- 
2.17.1


