Return-Path: <linux-kernel+bounces-215056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47328908DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DFEB22A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1030317557;
	Fri, 14 Jun 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="ZNJb/WNc"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478D39FC5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376924; cv=none; b=FKCqn8UNuQS9jyZ8QYeAD+5BzuOzXalFxOcP1ZbDWAOmr+1QkvBl5Th8t07ReVgSVGrtw1pT8yBtfCVu39GZTiAZ9DhU5DJ3faabkiu2BoQmKo+viVWzaVpH4+KfVDv47CwehQDSpltVDHnon/UkVmE/pa0XDZYT52mqZAEMsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376924; c=relaxed/simple;
	bh=T+wKV4LCthScZ2wufVHBjE/1e1Y/4lRE0V348NNf+qk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Az3/aCBymQ4eFEu/F1sJ8B016t41+kodQhquu43S8PLJhKRjc4izcAHgtveFcWrrIwsuxF1+NZ169J9fqfn6CE+otbeI1BHb8VGzT6049FmJgQV+0KCyYYo11iFVUWXAbbxdqMQAsYDAbY3XXP7sY4C0zegS4RuwGeJb41Iqdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=ZNJb/WNc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso1907568a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718376921; x=1718981721; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKrtvuv9e+28adQDYfi4Q1PiGt6oFDueFE0cEpVrccw=;
        b=ZNJb/WNc7a9gWrQVnVQpS9Xf/6c5kcM6NTnm4fuMIEQFV6A4WQr1wIIFN7fXPWZr9Y
         qDWJhTP3CrDjaQxGgJYhzA5tqcQjky3MJXXSouVOHDDtdt7Mmpd0SnAj0Sd1wNLn3cl4
         FwcGEcPkzEbsT5UfoXui6/3QmMyI2Ax+0vCA2HgYkpJZ3XAIzG72BlFlCkkqlD9HCukJ
         QOCAisvRlTHor4HLPcCK3dS2gfPU6LFXctsddJ64eDZd4I5i5yAfZVFajyeTLMDFYt2R
         2cmipAsHBPdFIImdAjvjpeFv60SAbUDWVXYrI4dNGXUZ7d6J+DA6BZNDyYetB4O4gBRg
         njHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718376921; x=1718981721;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKrtvuv9e+28adQDYfi4Q1PiGt6oFDueFE0cEpVrccw=;
        b=tUE6tLQWKJr9v8dBasfmI8WjSAFv3Cb58MH8Jhts8WPHFjL+TMiI0+PxwZKl1cEKDn
         gbHLnrBdeNkDRqhPzhMYYEXmklqlk7RzkvHYE5wYEzBsKJ0Ic3aD12VFK8lE6pq4a2Ar
         Zx68QybkPR80aEYB4/EhQ1FNYoS6YpsShm5k+3kutQOk6dvBsRn19Teth5fRfjnfuMS1
         aPhXYNshxJCzJkLvMa0fNCGfW94DZp18MNCjZXntMZ3PJJnUINlUc5RwKDvJtaw90uvb
         Mox/6S6NpRuuV/NpKO8GihGxzIiWZLvvW0RAjm+39ZkeWkJH1GEAL8lvjeKe38CaLVE0
         oQrw==
X-Forwarded-Encrypted: i=1; AJvYcCUb0H5YFn0Y+W19dXqVnplTcbmQ3LEFi2NOk4iAMrFQn99A+5xugJH0hZCZNu4NgCWATyoovZGZaGJ6oCKnI/E4a5HKWxNDESLpkD4q
X-Gm-Message-State: AOJu0YwKVdhrBdpp/SKPK8L0N4UBcdAnUOCrwQcWROp+F0HBM4fAGKpJ
	RGHzqCvzRAhWNoVOUqyCsWUXir92oG2eEyThJfynNYa7teupPTMecK2qEa5gp74=
X-Google-Smtp-Source: AGHT+IFQ8ZXvrcwtOwwSeet7NZay5/89+E/ZuDuorUcB7AyNnAMPyC8n3GvHLsC6maBmoHPyAQS7rg==
X-Received: by 2002:a17:902:ec91:b0:1f6:fbc2:526f with SMTP id d9443c01a7336-1f8627c7d21mr34144975ad.32.1718376920964;
        Fri, 14 Jun 2024 07:55:20 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e739b7sm32914495ad.93.2024.06.14.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:55:20 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Add kd101ne3-40ti configuration in driver jd9365da
Date: Fri, 14 Jun 2024 22:55:06 +0800
Message-Id: <20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This kingdisplay panel uses the jd9365da controller, so add it to 
panel-jadard-jd9365da-h3.c driver, but because the init_code and timing 
are different, some variables are added in struct jadard_panel_des to 
control it.

In addition, since sending init_code in the enable() function takes a long time, 
it is moved to the prepare() function.

Changes in v3:
- PATCH 1/4: Modify the init_code sending method
- PATCH 2/4: Add binding for kingdisplay-kd101ne3 in jadard,jd9365da-h3.yaml
- PATCH 3/4: Add compatibility for kingdisplay-kd101ne3 in panel-jadard-jd9365da-h3.c driver,
-            and add some variables to control timing.
- PATCH 4/4: Add the function of adjusting orientation.
- Link to v2: https://lore.kernel.org/all/20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/4: Delete some unnecessary information.
- PATCH 2/4: Use the new mipi_dsi_dcs_write_seq_multi() function, deleted some unnecessary functions.
- PATCH 3/4: Add compatible for Starry-er88577.
- PATCH 4/4: Add starry panel configuration in panel-kingdisplay-kd101ne3 driver.
- Link to v1: https://lore.kernel.org/all/20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (4):
  drm/panel: jd9365da: Modify the method of sending commands
  dt-bindings: display: panel: Add compatible for kingdisplay-kd101ne3
  drm/panel: jd9365da: Support for kd101ne3-40ti MIPI-DSI panel.
  drm/panel: jd9365da: Add the function of adjusting orientation

 .../display/panel/jadard,jd9365da-h3.yaml     |    1 +
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 1081 +++++++++++------
 2 files changed, 693 insertions(+), 389 deletions(-)

-- 
2.17.1


