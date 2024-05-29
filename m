Return-Path: <linux-kernel+bounces-193240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337F88D28EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D121C24322
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6913FD6C;
	Tue, 28 May 2024 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfNrSZt8"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB169224FD
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940379; cv=none; b=ZAbK58btJCctSKUGqlV2iNFndpvtZ9u/88NDHzykVSXnEoSGSJtXZMAxD5HDjgDGsDd4qi4U/qV+yJJz58Yt4ZKLMcya6KIBR9/fT7p5ztOLCcxsGgW5kqGjqppuyoZhOWbmGcubJ0E+VwP/0mB4RN7+VTjXfE5i0pTZigglShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940379; c=relaxed/simple;
	bh=zhBAUb36pf48/N0Xpw1fsuiV05YaoZWCcFJTlPimKO4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=amobLAqwP+ScA1iAHNkibtYkH/LS0V2uv+E/VC4mp8g3V5Jx8Lr8XlV9w+ofp0E2Jvdd+uWugI5jYZg1HU5A4soYsF7HIgFWOXBkp7YidNkVbi2IzGtnUBJhHyprIf1CreQZTOwYcX4aDAbDZWNALZQNHTaYWOaPT95aZYRzL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfNrSZt8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ab11ecdbaso209653e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716940376; x=1717545176; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHZNDUUbr3q7e6NPW2DwrC8X2CnNixkR9Oi+CBBYDV0=;
        b=MfNrSZt8WuFy1ZBjt3hDNn4Q8kcjaB0RIqrrTRRRb6CISQ1/REn5O6Jf5eBGT2+5nz
         XFksHFIM7XViwu+MAj85VwIpMPtJWZwgNvtem1u97PEx7M8/7vxzeX1x9GS0MtCmH/BR
         RljvWpVnWrk3m8FHcfeYEq5g379/IjALgwZtFnoT3qVeu9KQ4AVnp/Dk7fRWM/v17ibd
         NtjyYC9OIXkEA5DZ+B2A65hN6w4RoHdb5vtdsYr89A5M7pnh4br8Msk7+sRRRP6p1FeR
         otB9K7EizMk5vib6G7x3zBs+F9R02tsGthq0qYnvCn7CVG4fIwDUpEZLWWKp60cW5miG
         oFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716940376; x=1717545176;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHZNDUUbr3q7e6NPW2DwrC8X2CnNixkR9Oi+CBBYDV0=;
        b=oRZrcczPbABN/dO0jrqy2O536r2sKPEaWmah6lcr9u999hbkn7jb7fyk5zXx1Qoyp3
         WbCVdrFkudx6chvZi503yiEzn/NBSuNkcHER4TUd46R2bnCGKJq5iHk5MspCjhvuPz6F
         koO16xrYrS7GTQGbyiF0v/Zrjn6vYnQ6Z82rliWbmLxqI0mygf8MIo7vSw5odHwxCENa
         SkWltvEL73NBLroWb018J8tEqPnsJO+c/Nbfp6K49CZdRt1TMoXV7NyZ6sxHQYKUZvyw
         D+yfDeTI2d4YmOtnlaXREzl01Saq+y958u9eCKgBQn3gDgqPRyPbjWB4d25Yzydoo/7+
         msew==
X-Forwarded-Encrypted: i=1; AJvYcCU2Z0N6G85SWIzDAxPO2DYh87WISHKcitW8ZAiN5DmLExHyIR5d877EjDLnil3zOL7RSlQuw88XaDn02M16C6Izoxz87X5CJEu7t4r5
X-Gm-Message-State: AOJu0YwV/Ym/JcVUDH7TDLtN2tA0PKjmVw4IkdK3u5PFEqUeuef7OAxQ
	zERCR4kXadb0vIawNKy9l6A9oXvYYVhtnLGxfJ5k3mszbKbf2pNViADclVsgIB9Lq6qn7VlmKaO
	3
X-Google-Smtp-Source: AGHT+IGqLAv4OZyUcAM8naoZFj20K0vlp1pzotZb6OElrE2WNXGbtTQKAWxUzgWmE+4EwKspTa0x6g==
X-Received: by 2002:a05:6512:3f03:b0:529:b717:2a18 with SMTP id 2adb3069b0e04-529b7172fc6mr3374561e87.47.1716940375739;
        Tue, 28 May 2024 16:52:55 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066bd0bsm1099869e87.165.2024.05.28.16.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:52:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/3] drm/panel-edp: remove several legacy compatibles
 used by the driver
Date: Wed, 29 May 2024 02:52:53 +0300
Message-Id: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVuVmYC/3XMQQqDMBCF4avIrDsliUawq96juIhmqgOShEkJL
 eLdm7rv8n/wvh0yCVOGW7ODUOHMMdQwlwbm1YWFkH1tMMp0ypoWySdMLtCGXmJCpZwz7TC1cz9
 BPSWhJ79P8DHWXjm/onxOv+jf+pcqGjWqzvreWK29Gu4bByfxGmWB8TiOL/RuDAatAAAA
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=zhBAUb36pf48/N0Xpw1fsuiV05YaoZWCcFJTlPimKO4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVm5Wc00pr7mhb8XYoTjTxYcuglgy5D4WYfsxu
 Exxp3CTvNCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlZuVgAKCRCLPIo+Aiko
 1VkOB/0RzePb01tIc+8MNPG8I8IItb4ymjg3U/xVHeE3+VeY/roCzspzKY5EMESQQJix/QZ9B6s
 vEnDGqxakmpkq6IrhIq1BapWaN9pQ/u2noeLdQDV/kCHn9uMIeU8/4NxnQ+hiIYkI03V79VSGuL
 qysgRYWrHj3quiJuG8OBnpbw2Hi4h/a3shraRnZhBOTocXAiHY6H3pHdrkC9ScUHoSSQFx+mBAT
 +SBMVYXuCKwgmrlVnDqnWsf0cT9g+Py+kpe8BF+p8HhdSO0TRudREkan+re9J7dv9YgpusN3Wa3
 kA0xNPSJIlGlba0JZgAGAh1Ws5DhKPDx6d0Gruavnt83GXDi
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There are two ways to describe an eDP panel in device tree. The
recommended way is to add a device on the AUX bus, ideally using the
edp-panel compatible. The legacy way is to define a top-level platform
device for the panel.

Document that adding support for eDP panels in a legacy way is strongly
discouraged (if not forbidden at all).

While we are at it, also drop legacy compatible strings and bindings for
five panels. These compatible strings were never used by a DT file
present in Linux kernel and most likely were never used with the
upstream Linux kernel.

The following compatibles were never used by the devices supported by
the upstream kernel and are a subject to possible removal:

- lg,lp097qx1-spa1
- samsung,lsn122dl01-c01
- sharp,ld-d5116z01b

I'm considering dropping them later, unless there is a good reason not
to do so.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Actually drop support for five panels acked by Doug Andersson
- Link to v1: https://lore.kernel.org/r/20240523-edp-panel-drop-v1-1-045d62511d09@linaro.org

---
Dmitry Baryshkov (3):
      drm/panel-edp: add fat warning against adding new panel compatibles
      dt-bindings: display: panel-simple: drop several eDP panels
      drm/panel-edp: drop several legacy panels

 .../bindings/display/panel/panel-simple.yaml       |  10 --
 drivers/gpu/drm/panel/panel-edp.c                  | 191 +++------------------
 2 files changed, 24 insertions(+), 177 deletions(-)
---
base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
change-id: 20240523-edp-panel-drop-00aa239b3c6b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


