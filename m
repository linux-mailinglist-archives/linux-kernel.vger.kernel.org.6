Return-Path: <linux-kernel+bounces-346667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A198C74C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D762863F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222531CDA08;
	Tue,  1 Oct 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Bz3cdzE8"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA11CEE91
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816707; cv=none; b=jma0k3WCp2kuJukf0HdbkLBoilleOcDLqz/aAIizNkol5Ea+E5XHrnwFpUakeBkOg3cJGz0Hq+NhoFim12jBJm8o8v3kUR8WVE1ze3Do4iHrRcrB/l85KoTcoMKrcBDeauThnYY9fgXh5Hbm9q0a2MviVsYe4Z2qPlPp772diyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816707; c=relaxed/simple;
	bh=s1+/LBMYV7QYPCqFRgi/eI/p0qajjacXZ54eovBVtVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhzitSeVpqtsbPPGEwsO8VRiIt3mfDGcSna9clPkX7+olju1knTGT1ik/IetQwJkyZDOdphJ2KTrIsvuXZeOkcpV0ALXarIrL1LaRSFG2dnK++TcN5t2IV1gMD/jCaPBv+48Uz+mBv10SrxiAJkhH8OfJ/m/kRJYiDSJ9WfJiM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Bz3cdzE8; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6A56223D76;
	Tue,  1 Oct 2024 23:05:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P24qPAbfXRd7; Tue,  1 Oct 2024 23:05:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727816701; bh=s1+/LBMYV7QYPCqFRgi/eI/p0qajjacXZ54eovBVtVM=;
	h=From:To:Cc:Subject:Date;
	b=Bz3cdzE8L4s2bPAL61a66NC+HsvVdXN0wUZHKIqryH8GL/ZkQV2YiWgtTALRNhuTq
	 EgN4oY1bGCiTXo9j8sOdh/2SsAkEUF4wiLQhT52cuxJzP6/CdNsepj7rSBWib2aNm3
	 4lJIAas4DQUeP8iXC8ktFbMwcub7/Ml1do0FmbvutAtL7IHBEmWzia0hNYWUwFLpU+
	 y+YGeKNFSrP6J+Zj6A4Wb56UnNzlrpJBouMS1u2yTvloNMAhDrvfxpzN+xLXVEaFIt
	 sAoHnLvRSAQ8odwc7AICTlnfcUhrXhwqpoabvl+EZecKvg+U/G28EOkZjADKqmLKuH
	 p4PU7r2kWuyAw==
From: Yao Zi <ziyao@disroot.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [RFC PATCH 0/1] meson/drm: Support drm_panic
Date: Tue,  1 Oct 2024 21:04:03 +0000
Message-ID: <20241001210403.43535-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds drm_panic support for meson-drm, has been tested on
A311D with both TTY and Wayland session.

It is an RFC since I am not sure whether AFBC enabled case is handled
properly and don't find a good test case. Thanks for your time and
advice.

Yao Zi (1):
  drm/meson: Support drm_panic

 drivers/gpu/drm/meson/meson_plane.c | 47 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

-- 
2.46.0


