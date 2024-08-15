Return-Path: <linux-kernel+bounces-287813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 380CD952D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE7B266F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7656819DF8C;
	Thu, 15 Aug 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KnZffoTb"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAE1AC8AD;
	Thu, 15 Aug 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718459; cv=none; b=Qmuq+NxDe5jyYBRrlb9NkZCfkpPCLt3Y8yhShWc75pOZsxJn4fPtsJDZJcPFNf5en0KpfKPBxkObRnPO0D8mHAxjA8DS9lRs6QEQrQfy9UozTLU5L/yxhrujobVHkejj768+FxjspYWlaZEtAe+9nyyz/aRiXKY+na4y+9qTVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718459; c=relaxed/simple;
	bh=VZ9cTNHZpkO3l6Y2yfF3tTY4MRCPr2pj+l0Y2SBdlow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpVhtyNAKIRUfT1f92g4LAWu1xJwqmH5uKT9NStKlW2/mPqlm3ob8xWaI44LuTqqKv3ZWUooxjkX8YODWFLGLfXdekMHAPlv3ka3IhlqGoTSniUQM06KmIdFlmEn8AYxfmUzKc+9d3L22HuArT1FaqBbAsI9D301qff5HgtJeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KnZffoTb; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a9GBbYPkeTfUE5fCEbTb5Vw8tBG93HmtU9gtgrmT2E4=; b=KnZffoTboGeiLJ31fWWRKFDwo8
	gj8Ve/5+yxpOV6um7lLHc8KK4lyjkpPHARerdBEoi1xe4aupb2DWRJZF41FaR/zyzb/maEN6EKJBS
	ozdIBQerQM9CUW5TBcCzcbUWqSf2UpF6/W33zSHPR0wIsVDTJlqrJ49qMipD5oyMhiE/hxr9G95eR
	qVSd0IBduLgAnKu5pqnj69AN3uX3LoaN4Y8qexV1+B9BcNrpZdYzfAP8PGhtqQ9gKLHicaQeSsviZ
	g7UBWPcr6yZqIClmLcrctpZDlu6i2aZySE0DB6T8mGy9aviB36/8Sx+n3BGIqjwM+kcrRCQeInA42
	/Oa88cIg==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seXuE-0000nZ-US; Thu, 15 Aug 2024 12:40:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Daniel Vetter <daniel@ffwll.ch>,
	Andy Yan <andy.yan@rock-chips.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	David Airlie <airlied@gmail.com>,
	Sandy Huang <hjc@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: Constify struct drm_encoder_helper_funcs
Date: Thu, 15 Aug 2024 12:40:28 +0200
Message-Id: <172371788341.684432.4454726624748844330.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <128f9941aab3b1367eb7abca4ac26e2e5dd6ad21.1720903899.git.christophe.jaillet@wanadoo.fr>
References: <128f9941aab3b1367eb7abca4ac26e2e5dd6ad21.1720903899.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 13 Jul 2024 22:52:05 +0200, Christophe JAILLET wrote:
> 'struct drm_encoder_helper_funcs' is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    7458	    552	      0	   8010	   1f4a	drivers/gpu/drm/rockchip/analogix_dp-rockchip.o
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: Constify struct drm_encoder_helper_funcs
      commit: 7af62003181f8589b3b597ef96b147d4303771c4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

