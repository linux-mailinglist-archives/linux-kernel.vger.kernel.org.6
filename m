Return-Path: <linux-kernel+bounces-555914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD555A5BE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C603AF6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF2250C0E;
	Tue, 11 Mar 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rav6C5HJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A822422E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690682; cv=none; b=DJpmmCnXGsy5gs5vMjDmxky8iA4F3656cCeOYdS4wJjwFkgoi/62LvCthV0YS753gkRN0M9Inwm57uWFiOxXRmtOIT4eE/ESG3T1tjnEtdR7C78gnjk3zF0/sdOtfcQ/UXYzeizOwL1BSXMXA+Z0fVYLgNC+2C/jW7siQFhG6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690682; c=relaxed/simple;
	bh=+mKgffAaxj4n9s5N2ZleDY350EAzzSm1xnGJ5jxB6K8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eYMXp/sjFDKOfsSxYXUPo1uOdPbiEwd8H0TCypTwnfcehobVZKWYS5Y8zdJtw3xKJXUpPLYtWXXkpy4ETHdq+MidTgIVG6vKGzVwaFQ6cU+xuUI5j76h2N90vMakoaO5/PuvUV1yVAV0Uq9iOTTnO5efO7U+u8CAIB2Akcx7QzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rav6C5HJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741690679;
	bh=+mKgffAaxj4n9s5N2ZleDY350EAzzSm1xnGJ5jxB6K8=;
	h=From:Subject:Date:To:Cc:From;
	b=Rav6C5HJkLMcIp7aZrtxIBy/ultfremmSpwpDzX7WUN/Cj0adE3qc+ELUYGtj+kO7
	 VgQrT6Lb0cPQ3AsVT60rAOqpMo9rpS4prYiINTGV3uY/3lys1RocXieVfCoUDLFbvb
	 BZpHuf4jR2HV6OJc3FKDjYapGns6PdFzHonfPVnwtkAUrmy+zgPgHQTnk3aYHDMjBR
	 OoH0ZHSvqCaxjgDDlRY7r/OjKjI0z9ENzWpAX03gbPQy4YK70gjkwxhC2zGztJU+BA
	 oFK16ePb67xF50IPaF3l81T0rFUsQNsf7Z94zXAn7+xfzFY4VEBhErQJtNlfnloGyz
	 ZsF0TkaQ3z2Gg==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id BD7F117E0B25;
	Tue, 11 Mar 2025 11:57:58 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/7] drm/connector: hdmi: Allow using the YUV420 output
 format
Date: Tue, 11 Mar 2025 12:57:32 +0200
Message-Id: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwX0GcC/3XMQQ6DIBCF4auYWXcaoIraVe/RuKAIdRIFAy2pM
 dy91H2X/0vet0M0gUyEa7VDMIkieVdCnCrQk3JPgzSWBsFEzfmF4TQuhNo7h9s7oeFWNb0cbSs
 7KJ81GEufw7sPpSeKLx+2g0/8t/6TEkeGoqlF2yvWyZbftJ9n9fBBnbVfYMg5fwFzzbckrgAAA
 A==
X-Change-ID: 20241130-hdmi-conn-yuv-e1fa596df768
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Provide the basic support to enable using YUV420 as an RGB fallback when
computing the best output format and color depth.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Provided the missing Fixes tag on first patch (Dmitry)
- Added patch "drm/connector: hdmi: Improve debug message for supported
  format"
- Reworked "drm/connector: hdmi: Use YUV420 output format as an RGB
  fallback" so that the fallback to YUV420 will be attempted only when
  RGB cannot be supported for any of the available color depths (Maxime)
- Added a patch to simplify EDID setup in KUnit cases
- Added two patches extending KUnit coverage for YUV420 by providing
  tests for limited range and max TMDS rate fallback
- Rebased series onto drm-misc-next-2025-03-06
- Link to v1: https://lore.kernel.org/r/20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com

---
Cristian Ciocaltea (7):
      drm/connector: hdmi: Evaluate limited range after computing format
      drm/connector: hdmi: Add support for YUV420 format verification
      drm/connector: hdmi: Improve debug message for supported format
      drm/connector: hdmi: Use YUV420 output format as an RGB fallback
      drm/tests: hdmi: Add macros to simplify EDID setup
      drm/tests: hdmi: Add limited range tests for YUV420 mode
      drm/tests: hdmi: Add max TMDS rate fallback tests for YUV420 mode

 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 115 +++--
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 479 ++++++++++++++-------
 drivers/gpu/drm/tests/drm_kunit_edid.h             | 222 ++++++++++
 3 files changed, 615 insertions(+), 201 deletions(-)
---
base-commit: 4423e607ff50157aaf088854b145936cbab4d560
change-id: 20241130-hdmi-conn-yuv-e1fa596df768


