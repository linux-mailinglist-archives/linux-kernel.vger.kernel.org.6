Return-Path: <linux-kernel+bounces-538992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28EAA49F96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA03176146
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20D1F0993;
	Fri, 28 Feb 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EYpjfiEU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C431F098B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761910; cv=none; b=CGET0vr84M/W3QqyWZNgzUgpFlhMnjF7brQtVxeZJHpR1ey+ObvAEbLZ5lsMZ4YObzDYeGWzPDtGDbGlQMLalCxK+PXcka3k4X2TwcOyMeo8VwaeKabVsHmYZnutzJPiUqfhUNwAUF0z+QncR6p0/a9DVhPEcU76vjmGH6tWaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761910; c=relaxed/simple;
	bh=81IhTp+Nm9nvQp+ba03KMVjpioMtS/XYsbO4swq0ITk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbrJ6zjMYwHNp49LbaGGQLakqi1vU3myaFuNLynlmjXIAmhPigvOx8Dv/QkUX3iW6A47RZGNk3QBgT9ry3lDGQGxKzX3iox8b017BL1LreYntg7WJ2QN5LRQWjX+qwhhgtsaWzqc8lUucsV/neriXc3lQ0PNYqkjJFZNPAHHiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EYpjfiEU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E7/z05/BU1Ot4Goq15zsDNcp3gCxqZhQV/gnnMd27D4=; b=EYpjfiEUhuPorDZ9Z8iDd4iRO4
	Tyf2KtjoTHIo4JAszuhJI5mle5dTaVWG5qcCWGMcWsqRdsTPF6JQITZI6JjOsrXRq2LL7wOnDBITb
	sTksxrkUsqY2xWryMCQ1/2MYukJ8g9Ork6wAK5wg+NBS746cQlZfeC6ZwPr7X7cgl5iCRR4yGXajc
	V9BVvu9PPegbMSUMrwg/ukvTy57SitmArFR+hivsoYu7AT1JfbclzCB70Tmpp1GtG8oeQ3jKmT4WW
	DJC9sitKkwVFOc06dn2ASo5u4byDKTlAj1t4bZSXE0P4p6HS1Q3C1H+4MgXBu1LghQUVjZFWIo5NO
	5RNmn2Nw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1to3gg-00029i-Nz; Fri, 28 Feb 2025 17:58:10 +0100
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
Subject: [PATCH 0/2] drm/rockchip: lvds: probe logging improvements
Date: Fri, 28 Feb 2025 17:57:53 +0100
Message-ID: <20250228165755.405138-1-heiko@sntech.de>
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

Heiko Stuebner (2):
  drm/rockchip: lvds: move pclk preparation in with clk_get
  drm/rockchip: lvds: Hide scary error messages on probe deferral

 drivers/gpu/drm/rockchip/rockchip_lvds.c | 76 +++++++++---------------
 1 file changed, 28 insertions(+), 48 deletions(-)

-- 
2.47.2


