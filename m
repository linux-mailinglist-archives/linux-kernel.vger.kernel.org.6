Return-Path: <linux-kernel+bounces-222540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11437910371
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176C01C20F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE51ABCD1;
	Thu, 20 Jun 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="bjCqDR6k"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A08A1AB35F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884380; cv=none; b=Li1KmvcEzBtwmmXwMReVVe/FSjrOS3wOPraeB4RlVL/o9wUu/nT69fL9/nzSiOPoThzaKBMUJfipSCYw5veGZ14mEitHO37gC1JA4erGREK2ayJiwqe+Jwd1YNlOJVO2brjM99sAVsViCCANHzBtGQRYcijjshDVjwA4BSady8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884380; c=relaxed/simple;
	bh=lB89n7gi5PnAdnhdIwHUJW4IXvlWg8YRpkta5rSUHKc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=t+sDBDJ0yF1Zd0eDX7URwm1VRaBjHHtvWhn1z3JVuM2poFSmQBAX1MDQaDVp7P9JwOn3SQGSyazfrptKDf/H9E9ZnU2eD2JMYzOu2/GoUH8G54GezOJ3BUtiYLrC6mV+FGAJFBp1u3BJSjYZdbmzpRHHWOAHV26UBz1T0NNUNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=bjCqDR6k; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70436048c25so809671b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718884378; x=1719489178; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxshfbiYtk1odTxX03f+kq7uhvGyIninyQ/wy7iz3xQ=;
        b=bjCqDR6k0+MGemFRU6ykq+lWxUYLL3Iqy0iN5XnZtMDeUOiF4wXE7jdfNJtCufEvZg
         yxCIkZ/3eQ5jTcyABK4ZJlytDeR+1zw1T562RoNXrQRLxS6gIjr4nEMxxZ1ninud8tgs
         rIwRkoIQdJni2M+6cYj8ZqXKhSyO7MrKEEjmwEbO9D4Nd2uiwBymqpRhPSuyeMrIKAdt
         xFzf1AQI5XhEFBc9N1oS18FUEeYhyN1xHCJXAW2OwPt6Z4WYHyjv4o+uRWyyJpCWi6sG
         FqyOOcOr6tUZqwffJUF4YKmda6NG8OPKPbHdE+1HzNHB8/ACCvNHR0sfQGcYnEqz+/fs
         IdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884378; x=1719489178;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxshfbiYtk1odTxX03f+kq7uhvGyIninyQ/wy7iz3xQ=;
        b=lRyScGv7e2Pe/eJ3E3E8NvhMFrthLFfP42dhgBT4PTnM9Sdj111T7lwH3Knzqb91qQ
         0HfrIiEjRW+H9R+6TEzADYJ16B0kfAT9vVYs7ee9wesX1GOYNaducMZrXrYa2GmKuhw6
         LPQ/uj4+WRZ/+QGACfHsLBrb9DNsxGxJ01Nr3S3rV4zwr03MPXTBxm0QWJpwLggppnbe
         yUisJ2wPdjHiVo/37Jx9/PJhAwT84WbOpxs5FIcA6GdYLVQE/T3PTwIl15XOQjt7goX1
         70ZyCpasnsZxpohKWpIoQHa6ARLvOvc0v/hy8csNTzSAgQvG7EBcjMJ3xGXg1mArVDdh
         TExA==
X-Forwarded-Encrypted: i=1; AJvYcCXqr7MSNkqPYB9kn5ssEp3mQvcCee26LFjkfFs+ztYQZujmitS44ro6u7BxE9SI9e9gpej3aah3OadFSQUhWN8Rvk8HnppYY312uaic
X-Gm-Message-State: AOJu0YwYXMdXn9VDMFyaamMvlB6ER+rzJgbnyoPLHwfR41cm4vvYWQ28
	+qvE5jjiqGLZ370uJ39i4VbWvOQXipo0ei28ere2L0mSo2n6oIFMKvsD0AO3/38=
X-Google-Smtp-Source: AGHT+IHWVuA9ptbleuNtiiQwSC0s7v5qEfJr+4Yzd7+QkHCwMzolv8Kc1rfPAEj837awwHSzsEBFXQ==
X-Received: by 2002:a05:6a20:1b18:b0:1b7:1ede:ce57 with SMTP id adf61e73a8af0-1bcbb626642mr4846670637.59.1718884377880;
        Thu, 20 Jun 2024 04:52:57 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e64a1da9sm1486316a91.53.2024.06.20.04.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:52:57 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Support Starry er88577 MIPI-DSI panel
Date: Thu, 20 Jun 2024 19:52:43 +0800
Message-Id: <20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Starry is a 10.1" WXGA TFT LCD panel with er88577 controller
Because Starry-er88577 and kingdisplay-kd101ne3 are not the same IC, 
separate Starry-er88577 from the panel-kingdisplay-kd101ne3 driver.

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


