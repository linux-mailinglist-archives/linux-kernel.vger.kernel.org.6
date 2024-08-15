Return-Path: <linux-kernel+bounces-287359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04979526F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6125DB218FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F34A07;
	Thu, 15 Aug 2024 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejLsYigD"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4415CB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682063; cv=none; b=mkE0XDPWOsw/tgyDfQhcfY2M5rQMtjpfdTbDEz0eRAcifvz5UpEqi3fifZszqSMaI6K7D47Zfs2N/PFDYkDqdgKlM1R/s7fqV0L6OfWssyPiyYVk31Y4kgM3I45lMDW5k2JJH2tvVVby7TyssINGlKeWPTV3DCJL972x0qeHyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682063; c=relaxed/simple;
	bh=DFPCRiDrYN9gMgynhNybIaf7YYqIrgvnTEdSjM1E6Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HObITj+3kwGV9JXy1w6txoOu2iF7qZ7/l3V7VTgNaFfGT6UBwz8buSweUekeBuJCBKi2tKfxsFQptDBvag5sw1/neP98Skx6jD2bVFQk86mQcx46f62QncxzFaBsqfWnv8LjPGJfp61cVOVPVMVi+up9ErgYMAhuE1XJFZAZHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ejLsYigD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201cd78c6a3so3558085ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723682061; x=1724286861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xjN9kIEu5wH5/2WbxCA/p/bZEADNVbfHtt+xxi3fKI=;
        b=ejLsYigD4Yyqwk5xxZVeVrxLuT12PmB+yRJRK+dAxcfeLa8AttbX0t0DT6iZ90tJJQ
         wX0RkKmh65ZiRtv5iYlXOGlAduXzAHfaMfBP8oM+w53HznB9AHP2BmZ2tZatcgdcqEOP
         f3sKZ5FS6MVXtNrxB2yeWTNXgSBf1Nr+b/Xzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723682061; x=1724286861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xjN9kIEu5wH5/2WbxCA/p/bZEADNVbfHtt+xxi3fKI=;
        b=VpaCYfX50hwBt9eFGimzgWxLK9P7yR5C3oKeNUwd8YPhVvxnIkuTpdESNf+DvKSmxu
         FngjEoU6I0TTRAYfBqwrh7pEp9rGgbgq89kav3OId/TaL+lRF+m+btjf7LY0bfgo/alW
         qQ2UVURrLSfaIXfLNsA4fhCHTfoTat9FWE8xlFdHlvj/17LbDE42YbIipeTM2b5T7+kL
         buf1eOa+iLKj1UnMi2OovF+XpeuMgsIvDGZ2+f8Ztm0TW64JYZCkMcBVuLlQqpFYcIjV
         FS1yxJPDZ2ouYgrXqSxmC4w215RQt1oslXTwwVdLWRhJYQSFt2OtDIkWUxlkS7D4IQvS
         23AA==
X-Gm-Message-State: AOJu0YzHUP8ijw7A3SQUrtu+oqAnCsLOhL/H7PDRjOxt3A9OstJts+Ek
	K7po7eBoDLQ8fR9ObsQcUpRjcWauwrluBrESeqkd3R1DP4DbkMkVahJ9BjcYCdKaQ461u37Jjz4
	=
X-Google-Smtp-Source: AGHT+IEjqvtfOX9G1jrFlNd9tSXOoFbJa4G48NKyJpa5AH9EMXwfrR+9p7yCc2aO3g9MrGDIaHGkdg==
X-Received: by 2002:a17:903:32d1:b0:201:e7e6:acb1 with SMTP id d9443c01a7336-201e7e6b02dmr31351645ad.59.1723682061223;
        Wed, 14 Aug 2024 17:34:21 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f038b4c1sm1983875ad.207.2024.08.14.17.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 17:34:20 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2 00/11] platform/chrome: Add DT USB/DP muxing/topology support
Date: Wed, 14 Aug 2024 17:34:05 -0700
Message-ID: <20240815003417.1175506-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for fully describing the USB/DP topology on
ChromeOS Trogdor devices in DT. Trogdor devices have a single DP phy in
the AP that is muxed to one of two usb type-c connectors depending on
which port asserts HPD first to the EC. We'd like to know which port is
connected to an external monitor to provide a better experience to the
user about things like which type-c port is displaying DP or which
type-c hub is acting up, etc. Describing the connection all the way from
the source to the connector will allow us to do this.

DRM core patches: These are used to implement lane assignment for DP
altmode configurations through the drm_bridge code. The typec code will
use this to tell the DP phy how many lanes of DP to drive and which
lanes to drive out to the USB type-c connector. Adding support for lane
assignment allows us to implement DP muxing as well, physically
splitting the DP lanes on the DP phy so that hardware doesn't have to
use an analog mux to steer two DP lanes to one or the other type-c port.

DRM aux hpd patches: These implement an auxiliary device for USB type-c
DP alternate mode. I took Dmitry's suggestion and moved the code that
does the remapping into this driver. The existing hpd bridge is wrapped
so as to avoid changing the current users.

Cros EC typec patches: This ties together everything that comes before it in
this series. The EC typec driver registers the drm_dp_typec_bridge that
can signal HPD from the type-c connector through the bridge chain, mux
the DP phy in software so that we don't have to use an analog mux, and
implement orientation control for boards like Kukui that directly
connect the DP phy to the type-c port, necessitating lane assignment to
flip the lanes to match the cable orientation.

I'm thinking of working in changes so that the drm_dp_typec_bridge
registers a 'struct typec_mux_dev' as well. If that is done then we can
register a drm_dp_typec_bridge from the port manager and let the type-c
framework drive the pin assignment and orientation directly instead of
calling it from the port manager layer. To get there I need to add the
ability for a 'struct typec_mux_dev' to associate with more than one
typec_port (technically already done) and then make sure that the
cros_ec_typec driver doesn't try to enable DP altmode on the type-c port
that isn't muxed for DP. I'm working on this now but I'm sending this
out to get some feedback because I've reached a good stopping place.

Changes from v1: https://lore.kernel.org/r/20240210070934.2549994-1-swboyd@chromium.org
 * Too many to count!
 * Split out the DRM bits into this series
 * Moved the logic into dp-aux-hpd bridge driver
 * Drive the bridge from cros_ec_typec driver instead of globbing onto
   the ACPI centric cros-typec-switch driver
 * During that process drop a lot of patches that aren't needed anymore
 * Move the DT graph and other properties to the cros-ec-typec binding
 * Skip mode-switch/orientation-switch properties because we're not
   registering typec structs anymore

Stephen Boyd (11):
  drm/atomic-helper: Introduce lane remapping support to bridges
  drm/bridge: Verify lane assignment is going to work during
    atomic_check
  drm/bridge: aux-hpd: Support USB Type-C DP altmodes via DRM lane
    assignment
  drm/bridge: dp_typec: Support USB Type-C orientation
  drm/bridge: dp_typec: Add "no-hpd" support
  drm/bridge: dp_typec: Allow users to hook hpd notify path
  dt-bindings: chrome: Add ports to google,cros-ec-typec for DP altmode
  platform/chrome: cros_ec_typec: Add support for signaling DP HPD via
    drm_bridge
  platform/chrome: cros_ec_typec: Support DP muxing via DRM lane
    assignment
  platform/chrome: cros_ec_typec: Support DP orientation
  platform/chrome: cros_ec_typec: Handle lack of HPD information

 .../bindings/chrome/google,cros-ec-typec.yaml | 260 +++++++++++++
 .../bindings/mfd/google,cros-ec.yaml          |   7 +-
 drivers/gpu/drm/bridge/aux-hpd-bridge.c       | 368 +++++++++++++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c     |   2 +
 drivers/gpu/drm/drm_bridge.c                  |  50 +++
 drivers/platform/chrome/Kconfig               |   1 +
 drivers/platform/chrome/cros_ec_typec.c       | 208 +++++++++-
 drivers/platform/chrome/cros_ec_typec.h       |   8 +-
 include/drm/bridge/aux-bridge.h               |  62 +++
 include/drm/drm_atomic.h                      |  31 ++
 include/drm/drm_bridge.h                      |   4 +
 11 files changed, 983 insertions(+), 18 deletions(-)


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
https://chromeos.dev


