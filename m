Return-Path: <linux-kernel+bounces-544172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3BA4DE36
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D257A44B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842EF2040A8;
	Tue,  4 Mar 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hcpTmM9z"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18F2036FB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092291; cv=none; b=H3esATQy/LIXbAlzpRhDFx0lIDNzpaf1hlWe1D7PhrGiU+1eTPZm3+uwF3e4Dgpdv9ULvyKvYD4UPywESUcDDsG9lSai6KSRHj4htbaV2j8msktToAf/tsxloaT7eXgnaifuoRrIOw8UZSSToyFD92n2kfQANLee3TEjgN5slfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092291; c=relaxed/simple;
	bh=rWWpAZgc175k+0pXOa23OLzHBHdWaNu4Clo0Oq4U0S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HN/FA5WUgCB8UUTMjVt9u083FFu1zTTH315tGJNkjI61tnOl4oWQp3pMHzzLohzmNqwhuTJXjQMP2UvelEONmwOx5RKWK13vjK2jtxtQxAAFfF/ghp36EVlv+f1Z8UmWV6uPVpYxsaJZo/sKz3WCMURa3Y61Jur6GVfsRMVwzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hcpTmM9z; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Uq//8R4KcceSoF42PN1qalpKcxAauo2AUVr954FoHRQ=; b=hcpTmM9zVPfmgzXsBYELu0LEpG
	ZVmbssxcvFtAuGWTGfMbERbFQNbwoDGgMO0yP2Oe3sMDpXfUFUP56Nfhm7P0cqAkjkC2xquLqZOg2
	aMOklcw/At4+SlWBsggvCr2PWSJ034x82Hh+dv5XpuUh5lQXUP5RkJQEo5DBNZ+VqSxB1a2jdnz5z
	f8oyh09r1F4RYk70xa4x4BuTWfsSlu2vL5/MxayUoKMPYkYFBwBLyj1hzFOGOX13Qxg/N0LkCjXt/
	l5p1SjWdwxrUEU5Pu90ks7XXbxKVKfxj0wkqSooxvkVnXccXQ3QvkFraGDCFLD0PKlmQqnICGW52g
	b82OoMJQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpRdR-0003B0-6Y; Tue, 04 Mar 2025 13:44:33 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de
Subject: [PATCH v3 0/3] drm/rockchip: lvds: probe logging improvements
Date: Tue,  4 Mar 2025 13:44:15 +0100
Message-ID: <20250304124418.111061-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Getting the panel already uses dev_err_probe to stay silent, when
the panel just probes later, and the lvds defers.

But the phy needed on px30, also has the capability to probe after
the lvds. So make the rest of the lvds probe/bind logic also use
more modern logging than DRM_DEV_ERR, that is deprecated anyway.

changes in v3:
- add patch to lower warning level on missing pinctrl (Quentin)
- one more dev_err_probe (Quentin)

changes in v2:
- reword the messages about getting (and preparing) pclk (Quentin)
- use a ret = dev_err_probe(dev, -EINVAL, ...) pattern
  in some (additional) places (Quentin)

Heiko Stuebner (3):
  drm/rockchip: lvds: move pclk preparation in with clk_get
  drm/rockchip: lvds: Hide scary error messages on probe deferral
  drm/rockchip: lvds: lower log severity for missing pinctrl settings

 drivers/gpu/drm/rockchip/rockchip_lvds.c | 80 +++++++++---------------
 1 file changed, 29 insertions(+), 51 deletions(-)

-- 
2.47.2


