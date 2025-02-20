Return-Path: <linux-kernel+bounces-524916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C83A3E8B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523CB7A82C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB034267B00;
	Thu, 20 Feb 2025 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zCqaZdRK"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662126463B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094929; cv=none; b=MmovJvmpfvmrJvtvs8otLjjtZMBIIoHBmyNHBBr9+MjTKh8HWzUySAC7/sHZUkoM4a2sZEY2CC7nuqtuI73SVSeP6zN9g9FNgYJp5gGjY9mhOWw4QcBvhpRboFHhNqEd7V9fd9ItrFCCxd8fuAcg6BRQvDZslOZLx7IHnoDTa30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094929; c=relaxed/simple;
	bh=qPDCRiRCdLgzwF3SVM1KmIYhyrBw+j3fZ25iP43Io6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p30E6UGFs3pXL2kpOv6APsKHL7ooqVMG3VQrUL61iggC00meduSOwqB06JS6VQscgXxhfsSLH9MJZQaxKE50SASwdTp22cJ6D1S4OeoNwgqfW7D9qjMbZgJzjVSMLZ0LvPRENZQy9ffyibaLKOsvpfhSoYnTeOF9TaHRmxHSWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zCqaZdRK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pAp6aTU3MDvbZXbMddmb4brUtJ96X0DNMEe6D505W3o=; b=zCqaZdRKtbRWquJ7RUr0725Q8Z
	I/iBTPCptWUcH5wEXytEHhz2afiedCNckgIwT9zaXryJoyr6p5yqlkSKt6t7ZaPjLao9BP51innAv
	KfCeUfpKW77sGdUEAkra71ijEsmWnLUeMtbDOBZGIKDHokiS4v9zSuTaGwly0JC2Z71j8wk8wPXTN
	Ov/jv/6j1h6jje4W6XGmZnoXwgI/oSXjaziHOAs1o03piA/GsPqRHhhEqHU3TN43AUEF/ZPDpSWt6
	KwojoeoLXNvEVPucII/ufJtPBqkD41ArbWRd7O4ovDSm4+oRpbay9AIX/1QBwsCuPJfCfv2dIF0Hk
	ktE/4Vlw==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlGAx-0004Wc-Q9; Fri, 21 Feb 2025 00:41:51 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: gregkh@linuxfoundation.org,
	heiko@sntech.de
Cc: rafael@kernel.org,
	dakr@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de
Subject: [PATCH 0/2] Fix the shutdown callback of a drm component device
Date: Fri, 21 Feb 2025 00:41:39 +0100
Message-ID: <20250220234141.2788785-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe deferral can cause the platform-data we access to be freed already
causing ugly splats on system shutdown.

Fix this via a small component-helper and adapting the rockchip-drm
shutdown handler.

Heiko Stuebner (2):
  drivers: base: component: add function to query the bound status
  drm/rockchip: Fix shutdown when no drm-device is set up

 drivers/base/component.c                    | 14 ++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  6 ++++--
 include/linux/component.h                   |  4 +++-
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.47.2


