Return-Path: <linux-kernel+bounces-421125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DDF9D872B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469D8B2AE99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE9B1AE01B;
	Mon, 25 Nov 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UiOcUpXX"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5BB19258B;
	Mon, 25 Nov 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542614; cv=none; b=sac4vFY1QxJ4C1lXxZhQ65fHw399aW9w+XWJ0mpyPiZGp84+hZkmIi8xiDlNiq+1r1vo5R/ExcbNlcYSCRPfOY7hHjnZoV4fdQlnuqSDVbjeP5sHzkvkD8DpfmyZKFTwPgM8RQV5NQ7XCjbt8dEgPlklO24UjraVG0kXIdkkZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542614; c=relaxed/simple;
	bh=TK69xxVuc5VjdFJ4OvmWzdIWyRL4AoxZz9mdVsJGbIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MLD0h7TL8EYIHCWcjYWVo2dRKurf276pf/v35m10+t7ApBVkxXsxEzrpVtop+i9l7iwoMcqnI/aTeNZs0tGR+qCL2guvgTxyy57cjUrZ2MLQGoUGBZLTZrJJuKfdaQxJWNCSFQtfgkmDhVLFFxY0e08nEy+z0uh4i8p5uYkr42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=UiOcUpXX; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=QFkmN5/AIJVNMn/fY5/nPE6hxTuKJ8kdCgzvY8ANXv0=; b=Ui
	OcUpXXU5DoRQrTujmQVvo+gXQsDG8zxhh4Jw9cs7bgHLQfSQF29//1GlOfqsnITLAxDWKMmq5lCe4
	XEvHH3OpAfw5YMaPyBbSr6chLFJhOVZlsPepDhZ+T4ahEq2CVJgkQsvXih1aypuLkQEl6SwhVcxNZ
	TAFha6pmabINsQXjBMiisq8w883Gx2CzEDEgdc+3joRrtW+pNnAeY/hX7Tbw5RpXM2TV40lwFRaIH
	01nVIQEAGLq0hzRVVXTBGwfrPRncRNn27pQOdIBtoT1RFt6bo8VeWQE8wHL0p2hE0tPxMmpg6rqlm
	gf7tW8pMxXQzm3GmSBIS5rACM2V3UUzw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tFZTA-000CcV-R3; Mon, 25 Nov 2024 14:49:40 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tFZT9-000A3a-2Q;
	Mon, 25 Nov 2024 14:49:39 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 0/3] drm/stm: dsi: relax mode_valid clock tolerance
Date: Mon, 25 Nov 2024 14:49:25 +0100
Message-Id: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWARGcC/x2MQQqDMBBFryKzbiQzSRW66j3ERRpHHWi1JEVSJ
 Hdvms2H93m8EyIH4Qi35oTAh0TZtwJ0acCvbltYyVQYSJNFpKuaoqjAT5cUWrQPN3d+6i0U/x1
 4llRbw1h4lfjZw7emD/y/taINEWrbG2rJUK87rVBFdtt9KSOp9fsLxpzzD8aKpzGcAAAA
X-Change-ID: 20241125-dsi-relax-1414baf6cd74
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27468/Mon Nov 25 10:36:56 2024)

Introduce helper function to check if the pixel clock is within
tolerance.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- Introduce helper function drm_mode_validate_mode()
- drm/stm: use helper function for mode validation
- drm/sun4i: use helper function for mode validation
- Link to v1: https://lore.kernel.org/r/20240322104732.2327060-1-sean@geanix.com

---
Sean Nyekjaer (3):
      drm/modes: introduce drm_mode_validate_mode() helper function
      drm/sun4i: use drm_mode_validate_mode() helper function
      drm/stm: dsi: use drm_mode_validate_mode() helper function

 drivers/gpu/drm/drm_modes.c           | 34 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 12 +++++-------
 drivers/gpu/drm/sun4i/sun4i_rgb.c     | 22 ++++------------------
 include/drm/drm_modes.h               |  2 ++
 4 files changed, 45 insertions(+), 25 deletions(-)
---
base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
change-id: 20241125-dsi-relax-1414baf6cd74

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


