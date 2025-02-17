Return-Path: <linux-kernel+bounces-517792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8BDA385AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910B5176E69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34A21CFEA;
	Mon, 17 Feb 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAM6ewMG"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B821D00E;
	Mon, 17 Feb 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801366; cv=none; b=iY9vZj/Avxhacf851binG9BBKf4324D4MVhAw4wkjp1TuWjqipzHX9DHqQ82sIFZjw74x/Ul3dCU5EAJoTHjcs4nAD3nFCwRS/mN7QIIfB7Xya690drlXThLPffAqVXO/aI+M4aYWUXuajB11dISfwrT5HX8ykJjMuAR+Kaafb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801366; c=relaxed/simple;
	bh=nOJg3jv6zfj7JmSk10pt4tyo8GHRyE7Wu5YmDLUZMi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=guXUxsbnQf1efRZsy/k/LBLYbqOL283gygPPyTWNNAaASxofnEJGwUAReh5tKGEKXkZnAun08OqiHC1PYbA1qVtt19B5n/9wlwQRS9NUrmIYueviGRAMUhUZbOZJXG6II7oAUdJZEO9mEE9dR2+NeO1J9kdYBnqP+CShxqN0NUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAM6ewMG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-546202d633dso1104612e87.2;
        Mon, 17 Feb 2025 06:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739801363; x=1740406163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfPSU2/dGADStin2gRTv/ZeULko+bgLPt/Ljxki/I/8=;
        b=LAM6ewMGBtuUkQB9YpeKQD1a9K9/UJl3Mziqj3cmPrq/StBRuQzwsQgY1wUrD5AyI+
         v1d7/RexQ4jB7sZ19QiQVnYcLALOaVrqyN6EBAI4eNmPMFtrdNIyjJ6xtf+QpurY1qJr
         BmlSND0ucAOcrJ4chz6kzg2jpokgEov7vtxzGs7+E9q3dFSlRKk+CXCjPFm4Jvfhp4Fm
         nO3Tp+UE3FkLYRVJ77WSA96CxBEjVz3qkzGoueo3Aj8lvRFUIHsQLwmGglo/dRqyd6Iv
         sI2Jeh/gGXsqOwnKioWu/fg0R71/A0jlFCecuOp3bq+ByeHbYGV0N+1OFZyzl91naGor
         JRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801363; x=1740406163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfPSU2/dGADStin2gRTv/ZeULko+bgLPt/Ljxki/I/8=;
        b=jlnvkY3KD8SIhlorK2V6kaYeiTxRViujnwAJjDMGpjBX6p2hV6zMo5T89dB22VnYCJ
         EgG2ZR84C9d5GTIh1w5Df9qfnaP7YKRdCZNyV4Mso4ubTatat4RgKE9I9Qpe5xGZFWje
         YmxV2SOIXugJd2pWcH9HZ4Cf/kx1ugLrpRbJ3ALWy0fMr+4BMUfAF7EtCP4HyNg8BaMs
         JQDqxhfuCWYeoYISmhKFAidG0yMpW8a51J3Bbxk6a4I34Id6KAFvLLA7f/fquoBRpa7O
         gHi3z2yviUJwoqtXu+Yhm6gvxA0xDA73Db0okGzADiHHzmobv4C1SNOFq6D8gE4hXDBD
         +TEg==
X-Forwarded-Encrypted: i=1; AJvYcCU9rFsHthXeW2MA5yoetEksT79XAkP2EgrY425ZJDW8ssrM3jn+sritVoBXAIRETAS9jnAD/cm9Z6dkoUuu@vger.kernel.org, AJvYcCVjmg7DCdiP7jgjmbFjkR+gDrR+tvXHx3J/2FRuUOPljU3+lx5gT7d68sk4FoWUbvJv5duOqVdX/baP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/E87fK0hpXDS+8E3ZafHx/UIEalLdAZuRHMPIO50V2tv9617
	e05ThTKyXLNKxnzWbU1FG4dvUS1vhQj7vK/61Qs+sNWjmNQwM2N/
X-Gm-Gg: ASbGncvlBuk2hV8MZI3+kbKydlWLdhrw1vFz2en+HXGhBQ1Xh8r2LkJcivioZsS/Qzk
	gxFq37ao81EHMusJ5jlgPOzNQldTu9z444hUiDy245EtslIjIY20W4LTEpYy/iHOtY2H/W/zTHU
	mz96itYRWGhAaYr/aOHf8/u2xKg5I6PBUp4twtn1dRzophg/vjhZTmEt9vocS94FKi2xVrDzI9n
	SuqVgj+wbKkbxKL51c5SdwXFjh5H9iV5TeM6NEzTzUpz36wufHyWflMsRkNXAWLDPOthiJ98321
	qMmh8Q==
X-Google-Smtp-Source: AGHT+IHL20D/CRUyYe102zJ1QvdnfFZmYUOKh8czKdL3I1ESZ5y16nOXd+G+C3R9LKY3ImUEKcm6lw==
X-Received: by 2002:a05:6512:4020:b0:545:2fa9:8cf5 with SMTP id 2adb3069b0e04-5452fe93333mr3398912e87.49.1739801362598;
        Mon, 17 Feb 2025 06:09:22 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54531b8ac1dsm866855e87.75.2025.02.17.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:09:21 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
Date: Mon, 17 Feb 2025 16:09:08 +0200
Message-ID: <20250217140910.108175-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
and LG Optimus Vu P895

---
Changes on switching from v1 to v2:
- added description for clock
- removed clock-names
- added boundries for hs-zero-delay-ns and hs-prep-delay-ns
- added mutex lock for host transfers
- converted to atomic ops
- get drm_display_mode mode with atomic helpers
- parameterized INTERFACE_CTRL_REG_6 configuration
- added video mode validation and fixup
- removed clock name
- switched to devm_regulator_bulk_get_const
- added default timings
---

Svyatoslav Ryhel (2):
  dt-bindings: display: bridge: Document Solomon SSD2825
  drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge

 .../display/bridge/solomon,ssd2825.yaml       | 141 +++
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/ssd2825.c              | 824 ++++++++++++++++++
 4 files changed, 980 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
 create mode 100644 drivers/gpu/drm/bridge/ssd2825.c

-- 
2.43.0


