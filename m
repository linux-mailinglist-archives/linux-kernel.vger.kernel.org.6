Return-Path: <linux-kernel+bounces-333587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8119597CB04
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B457E1C224E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37141A00EC;
	Thu, 19 Sep 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tGA0UHve"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01419E96D;
	Thu, 19 Sep 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756260; cv=none; b=VZd1AZ40a7xW/p+vCKPaftfOpRKVY4714itv/sRM50a1CPFqTxOsNvywLB3FVIk1dqV1KSxj8LE3LCVPcPXbdrf4ZsCjVZcdiDwfu9EiFdsqxHyR01PT+i4fg8rgTtcYVS+C6gdirJ0G54ysXi4ZRtg1IHiVMx5IvaQKlipOpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756260; c=relaxed/simple;
	bh=foWJGF9Syy/Vlth7lYEXcUrbgAZ2aX5QNh+VsxHNGQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CivW1S58xApxYS2t8bcVyUMZpVkqB5n5syNymlZvlj/Kl0joBSJAL6AFpYngQi6tpryJaBX00lwQEWG+3aYp0gR9d+9Lwe0+YXVSkl9/I21Is/15QWx5hguxg4F6HyD+TH1VAvA+22AhdSJ4SsyPrXdlnEx+5RMHG3ORJciQ7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tGA0UHve; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m1kKdtQcHJV23d4r0PzJxxLgP4SECr7H28gdaL/ivo8=; b=tGA0UHveyFNjTcySmyThcr+q3L
	mKPBKAzU2vvK6UgTV5y1lvRZmnI4bAgALqqUjEWDRxAxwpRKWqxpnPEuneJYOgceW+BRYOANgkMUZ
	RGl3Uzsa5iJY2+seBz9WyefH4EgHAHg6vWuOUWhDIeiU9dKOwU2UD1aONAd+U/oOz9XRQT/gy1hZ/
	zDg0UBEA7G0qEQ1R3FB7HtlUAVv0d7Pq82PPxIrATd07UuNI+JWUsfyMvPuSLfH5mVbk6TXyZkEXt
	swjvuVqpRM840gd1vtz+mEzTrOC+K77TCTx+r2kg4CN86hpPOPQo4F2upTEeUkcjx06sfEdSf8v/T
	Y0aAPmmA==;
Received: from ip092042140082.rev.nessus.at ([92.42.140.82] helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1srIB1-0003XD-KQ; Thu, 19 Sep 2024 16:30:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Maxime Ripard <mripard@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Kreimer <algonell@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: Fix a typo
Date: Thu, 19 Sep 2024 16:30:23 +0200
Message-ID: <172675621368.1213843.17065893095023530764.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240915123943.105118-1-algonell@gmail.com>
References: <20240915123943.105118-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 15 Sep 2024 15:39:43 +0300, Andrew Kreimer wrote:
> Fix a typo in comments.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: Fix a typo
      commit: 87d45979140e49611696e97e2b33df572bf4fa24

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

