Return-Path: <linux-kernel+bounces-300158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F395DFAA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDEA1C20DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1084E18;
	Sat, 24 Aug 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KdIHZuLI"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCF40849;
	Sat, 24 Aug 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724524480; cv=none; b=PHWqXRfZfeHzLbBFKpsLpZj1G+Q+Z62ApOezi1WOT9MFbfmh5S2qE7rIvuawph3rBydNeQwzf81Jw4sM7bFJtSOc557jqCRJGJUMgtGRyWj2+DVepNXg4sEQuhDIokEUBylewy0SBMDWPrk97U6zjtwwEI+huA1lemd023+ya4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724524480; c=relaxed/simple;
	bh=OnZOWHCKoYxDgjmxX5wXRk3HqlrotqXB5UqTjCWSGCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cs9AXmuf1cT4aGWEyXWaAywReCM0740WtVGg2oO0304g0SdazytE82h5B38wA6UWNHvBspQoBE8FQ6T5lIZL1kUHejxx7hK9kr9ptSjNAvj3dvsiDk0rTaGdF+5vRqhQtkcfkLaQUBkYCdWxa6Fr8bufSl9pkx08R5UAfcNlvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KdIHZuLI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724524474;
	bh=OnZOWHCKoYxDgjmxX5wXRk3HqlrotqXB5UqTjCWSGCc=;
	h=From:Subject:Date:To:Cc:From;
	b=KdIHZuLIr6W/5MbMdSySR8UUMhxtwegzJQqmo45DgR6+1edML0GoOAOHbBvqtnWoY
	 9kUupKfjt7nnVr2pLeaWfzWJjHAkbjl98olQ2OIzqHonWJo1lL4Zzcjkgo1ZfVwANm
	 uVYqGlTHTdUs/YFh+H2m6YT5p+qtiPY6ubvRryes=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v6 0/4] drm: Minimum backlight overrides and implementation
 for amdgpu
Date: Sat, 24 Aug 2024 20:33:53 +0200
Message-Id: <20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJEnymYC/43NS07DMBSF4a1UHmPktx1G7AN14Md1bJWmxU5SU
 JW943bSSkQRw/8MvnNFFUqGit52V1RgzjWfhhbqZYd8skMPOIfWiBEmiKIE22PozxM+5gE76w+
 fuU8j/ppyOWAjCIvBgObKogacC8T8fcc/9q1TruOp/Ny/Znpb/8XOFNNmy8500krH7PsFcq3Vp
 ym9DjCimz2zJ4/xTY9hgj34qKPogu3cqscfnuZ00+PNEyoI4hyjVrFVTzw8Q9mmJ5onlVU8RtN
 pp1c9+eyZTU82zylPwAbiNQ9/vGVZfgEc0Fh+CQIAAA==
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724524474; l=2655;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OnZOWHCKoYxDgjmxX5wXRk3HqlrotqXB5UqTjCWSGCc=;
 b=Fv+S8yXkdtgd3svJ3HscCxbYgzuZCqM3RL40fBuNCFbI8e9ER39Oi2d9+Kljttrnc54l2/bd5
 dmd0RMLXzF+C++jDyYeBBQm81J26vVZbfgnCN3i+kgrveNYj3nxsnKn
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The value of "min_input_signal" returned from ATIF on a Framework AMD 13
is "12". This leads to a fairly bright minimum display backlight.

Introduce a quirk to override "min_input_signal" to "0" which leads to a
much lower minimum brightness, which is still readable even in daylight.

One solution would be a fixed firmware version, which was announced but
has no timeline.

---
Changes in v6:
- Clean up cover letter and commit messages
- Add my S-o-b to patch from Dustin
- Mention testing in combination with "panel_power_savings"
- Link to v5: https://lore.kernel.org/r/20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net

Changes in v5:
- Forward-declare struct drm_edid
- Reorder patches, quirk entries are last
- Add patch from Dustin for additional quirk entries
- Link to v4: https://lore.kernel.org/r/20240812-amdgpu-min-backlight-quirk-v4-0-56a63ff897b7@weissschuh.net

Changes in v4:
- Switch back to v2 implementation
- Add MODULE_DESCRIPTION()
- Simplify quirk infrastructure to only handle min backlight quirks.
  It can be extended if necessary.
- Expand documentation.
- Link to v3: https://lore.kernel.org/r/20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net

Changes in v3:
- Switch to cmdline override parameter
- Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net

Changes in v2:
- Introduce proper drm backlight quirk infrastructure
- Quirk by EDID and DMI instead of only DMI
- Limit quirk to only single Framework 13 matte panel
- Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net

---
Dustin L. Howett (1):
      drm: panel-backlight-quirks: Add Framework 13 glossy and 2.8k panels

Thomas Weißschuh (3):
      drm: Add panel backlight quirks
      drm/amd/display: Add support for minimum backlight quirk
      drm: panel-backlight-quirks: Add Framework 13 matte panel

 Documentation/gpu/drm-kms-helpers.rst             |  3 +
 drivers/gpu/drm/Kconfig                           |  4 +
 drivers/gpu/drm/Makefile                          |  1 +
 drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++
 drivers/gpu/drm/drm_panel_backlight_quirks.c      | 94 +++++++++++++++++++++++
 include/drm/drm_utils.h                           |  4 +
 7 files changed, 117 insertions(+)
---
base-commit: d2bafcf224f3911b183113b2fcb536c9e90684a3
change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


