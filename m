Return-Path: <linux-kernel+bounces-237801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2EF923E53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B82829DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544916D4CE;
	Tue,  2 Jul 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="NO6ekn7W"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B1156F53
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925324; cv=none; b=VKMaCAuiZBbjUl2bywnLWB/hLCFb3pSTI/qLMjfrDvZSE7ih3VYO5qN4H41TaENc3hB/RiLsoHHFfaRtnoEmzBe5tm9zxVpFfEwf1rkE2XSc3HALj4APiBsDYpyYcorBVUysXoU3BV0eOlomWIzIwA3gudYth8Xvf+AzOyS3qJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925324; c=relaxed/simple;
	bh=Jdui+jlwq/em1v1SDdy3Tz5tDhSWrS0+WZkZ5BBsWOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OtTa6zfBL2GBNQ+JraF1PjXg8K7mh1VAZahH2yrlVmj9bqDVlkBeI71RksXDObHb/e6oySqUAHqyLTd57pH1Rp+IRRq1umBtAYVL4lxQ6vZSubeg4YEmVmDI3iUjS7hkGfeMC1EvBbOAQMRSfUFAVeSf7IcAFHn/RKULJtRwyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=NO6ekn7W; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706b539fcaeso3695320b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719925323; x=1720530123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZtrnZ09n95IC/BfvYp8Bv1QvGg6hzmuOXjgAkx8r4U=;
        b=NO6ekn7WnFJkYgtjaR5fHEE5gBYjzrqhTD/SxJaXmYjDY+T0ORyhKfk7WeKMmREV0/
         CqB9kZG0mfCdM25sJYHq907woeYpGzV26DcjnzYM53wdqH3oEcS34qAr+boop+498sau
         Z4zsZKQickgYftUli83nTtQsWIi/1ZPIx4oN1LTOBoBsgVuYEvSgf7O3qSUD7GVO5sKg
         u1axJ8GcxxCJebvSflE/lY76SYgDGcy4XFLH9z8OtW4uUv81Sj5wVJlk7FFgyFYCfdXg
         XSpXPxMt0qPAU0POU7sYA2MDo4h8Tmm1vSzWi0cGEP1oe6x+ljFHhIkBbtxU+M3scJa/
         qBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719925323; x=1720530123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZtrnZ09n95IC/BfvYp8Bv1QvGg6hzmuOXjgAkx8r4U=;
        b=E9Na4JPrtK5CrvtSmA7lxawTkggr7N3tb6YnZuRS59I5AVC8U7VM/GY72W/Qqbx1Kh
         p+vF1XvS31BdraWzR30AXNcwM9cOfpmKm9KrD7ZkZw7qTzg6PaikS4adKSvzRx53x5cr
         nGwxQzC+40ECjw51cU7vggj/FgE7oG57q1IJp6uAGnRj8koz8RNt6nV169oSRsz8yQRG
         0f0Luxv8zmvQR4xw9Ux5/UClFNsvcTV3LKAwy8JWpJtsL3Gyniv8mD1tGbM1yGhymiiu
         bziRBhMvNU6t1tcfhxou/93oYdBuwVCiXt4vf7HIQVejes0JgAwpIW0NE4J2UfvguEcZ
         A0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV/vtUoaRRwi3ewwJEtJ7sF7Hb0BUEn565hYSeTv6HB58elzmwpXBNVpSQIp8LvlBXht4MBLvON6mF+gqyPHklG7T/2wyGvJo+6g+2A
X-Gm-Message-State: AOJu0Yycw4OSxXXCIOHd19/DpRZQR2ayqf00kRsfiua7CowYfbGfy61F
	t5Bwt6PVbHbG+xbCw3+OGQy/Lp2/RwNPxV4kfiICewIzKsUZU2mMQ8NeKMsokGA=
X-Google-Smtp-Source: AGHT+IHHwOYQGp6vYM2oRjMRQI8gLSDsunWGnK1uML0DYGFvbUO9k1Pbtg8uL4+EUK2Pgm+LWhCk4Q==
X-Received: by 2002:a05:6a21:339a:b0:1bc:e9ad:e736 with SMTP id adf61e73a8af0-1bef610ce49mr13461970637.3.1719925321416;
        Tue, 02 Jul 2024 06:02:01 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c8ec50csm6233111a12.59.2024.07.02.06.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:01:58 -0700 (PDT)
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
Subject: [PATCH v1 0/2] Support for Melfas lmfbx101117480 MIPI-DSI panel
Date: Tue,  2 Jul 2024 21:01:36 +0800
Message-Id: <20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Melfas lmfbx101117480 is a 10.1" WXGA TFT LCD panel with jadard-jd9365da
controller, which fits in nicely with the existing panel-jadard-jd9365da-h3
driver. Add compatible for melfas lmfbx101117480 in dt-bindings.

Cong Yang (2):
  dt-bindings: display: panel: Add compatible for melfas lmfbx101117480
  drm/panel: jd9365da: Support for Melfas lmfbx101117480 MIPI-DSI panel

 .../display/panel/jadard,jd9365da-h3.yaml     |   1 +
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 246 ++++++++++++++++++
 2 files changed, 247 insertions(+)

-- 
2.25.1


