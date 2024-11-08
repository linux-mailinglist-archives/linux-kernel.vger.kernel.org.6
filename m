Return-Path: <linux-kernel+bounces-401743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C49C1E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59EF1F232B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140D31EF0AE;
	Fri,  8 Nov 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bujVIQcH"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A41137E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074045; cv=none; b=EF+wORevqJ6k6YYoXBcf5rkx7iwNVm7GKtD2FZHGQ7I5BNJOnpsSYQiyMY7Xg1e7ixDJHTdeGuQWNHozjWMWX8APKSsXNvFHoHssvocZYPib59rGRlIDD3FKm6zs/Gwtl144OESVA1OW3xh1GknEMzrcecBKuRovs8H4vnXgxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074045; c=relaxed/simple;
	bh=DxbW+i+dDe1NGkU9AQR0sdVd6xh3BLzv06b/cf/5nCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZUkZrA/gnEytkPjN/dsOLU55OVwBH6xVqQoTLXUKpITvFumV1lW6RerAyrFDPOMUYppElZ+ewo+/YDoWea3wFP3bbk4Ey0QUgD0+hWHwulLRXz+Cm7tCOFiKDFd7gbgdkSaBMmKMFcNm0udyE4WlgvC9F4hEiwdGk4NxkA1XK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bujVIQcH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731074041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k3Zn2bpSYjx0KdspBHLAyKP2HSBrvqQHEj0Q/hMzoJk=;
	b=bujVIQcH927mV5DqCLvbMvlG8Kcc1rhDUr244chfKffchmcgQJebhKtH6f5ajEukZ+1Z1X
	YpwG/j3iMCdCP5SF+TRY6GnVUVrZZPDG0XknzDLPgcOmF4MJ4xj6Dd4paLXjonnUGZUz3q
	ikmqsue3HJE8p5RnZSpuunABSwsn+gDnLmaxAeEJS/E131J3Q8eG8zuD3QQJLqecymiDPt
	iQztHpdQlrTw46doO+npJDfzRCY4zDabzIaxtF2h0rUwfizhBOVWdzeJT1tC/K7yc1VZtn
	KIGSHnN75JxuVtov0StSPDS18Pj+RW2+XxCaImwuoKNK6egIjMVVH+XljlXI5Q==
To: linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] No longer produce error messages when dphy is deferred
Date: Fri,  8 Nov 2024 14:53:56 +0100
Message-Id: <cover.1731073565.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This is a small series that makes the deferred dphy no longer emit error
messages to the kernel log, which may even be repeated multiple times, to
avoid possible false impression of some issues.

This series also performs a few small, rather trivial code cleanups, to
make the code a bit easier to read and a bit more consistent.

Dragan Simic (2):
  drm/rockchip: dsi: Perform trivial code cleanups
  drm/rockchip: dsi: Don't log errors on deferred dphy

 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)


