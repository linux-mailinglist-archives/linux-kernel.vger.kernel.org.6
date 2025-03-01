Return-Path: <linux-kernel+bounces-540061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B588A4AD21
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EA7170956
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFD1E3DC9;
	Sat,  1 Mar 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="N9DbZbbT"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C41E5732
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740850588; cv=none; b=AgCNpp7YmDMZnu++9UBVNzi8O/rnxr2mOI5OJtjY+VcKmLHLPdkA8tHsgdu3LBmB+KqyF7Z9mF8YcBfjS/dSzdpBmCLGcdLQuDpX9z+BUddeEBMsnS4g+rlphM+iQfOWgCl2HfctPsrhPbvMzcqGY9ctTCCUMVQ9aVnwtuYE2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740850588; c=relaxed/simple;
	bh=wGghpP1WpIrER/EIFuosxPmFJBzKB89aLm9k5MU7f4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Evcuu34nHjAUup7jwx+MNp9ubhge7Ad1hM3SrW9EpDLjS4Dg+Zfr3SpY4529UkVARVKYXeoT2mvAPVAcPfEI4jc89faPpa7fIGC948WTBNLn4gxsEtyXKa0aplxfPLV3pVz173ys4IVf0ihvN3Y1bcMJ9n0naL+8DmNB+Gu2syI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=N9DbZbbT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J+kBD+umUXykiUBc/ZHW2mNCyBvtMKWKtE2BZjjUQ0o=; b=N9DbZbbTYYICbIZiQ55tMUXqI9
	tECi3pylY1Wp+SFH18VXjRsHeO3dqQIpyowHARVS5pE5q3nz+o2CA20WqWuWtZZkWKB3WC5iuKZuQ
	1/rrijQg0CpjhdEle/8XjvtgmGzGSyr74NKKGcLGI2iUR3mVyZYp6Iizx0cgKLoR5hYKn9eBV2400
	7KRcaWtfxcDs7vVs+/ML5LzA9Mt6+oyQUFjvELhCTYNFVhGakE48bZo+VnH6pxzZdungB3OcZyYJE
	FgOGISHNLIzolmgVEqXUfoagWVesWl3c+C8/Aj/uXco9VJEmjrFQTqDxaLjck+/8j+OhR2zY23Yan
	XvlEtlQw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1toQkn-0001Tm-6l; Sat, 01 Mar 2025 18:35:57 +0100
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
Subject: [PATCH v2 0/2] drm/rockchip: lvds: probe logging improvements
Date: Sat,  1 Mar 2025 18:35:45 +0100
Message-ID: <20250301173547.710245-1-heiko@sntech.de>
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

changes in v2:
- reword the messages about getting (and preparing) pclk (Quentin)
- use a ret = dev_err_probe(dev, -EINVAL, ...) pattern
  in some (additional) places (Quentin)

Heiko Stuebner (2):
  drm/rockchip: lvds: move pclk preparation in with clk_get
  drm/rockchip: lvds: Hide scary error messages on probe deferral

 drivers/gpu/drm/rockchip/rockchip_lvds.c | 78 +++++++++---------------
 1 file changed, 28 insertions(+), 50 deletions(-)

-- 
2.47.2


