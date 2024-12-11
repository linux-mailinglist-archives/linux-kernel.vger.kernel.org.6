Return-Path: <linux-kernel+bounces-442297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E69EDA56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A881F282F27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAA1F0E22;
	Wed, 11 Dec 2024 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rxk48gwt"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D72594A0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957167; cv=none; b=oiuS0MUK0KaG0ocB3kBDYaOY1UOqC6cEqVq4ANrb3x6BQnZryRg2zeoZZ8nC6KePlL0XB7znS5M5Uo1qjt3Bjke7HSDNEF/QdHBKZmJEuSYEemZUcTv8WhVXXzDC1lIhTxpzixQvSDO4F2Nm7umY1MMraqkfNBcD3rSjPC3gSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957167; c=relaxed/simple;
	bh=cE27Nk5cmH4butM+9uY8zJsEUsYtbbcH45KG7WReNZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sF+Ugkjc89IJMxs2r8RcIeDeyR7pBfjJGDPLVmLGUpvygrr1nnSdGByPpBdlli6BxVzF6kC/cz9o/4+F/uZUzklbdmExFFp6sId3CxuKozcRcbbUWVahEzGPKMwr9c/h8Wo6MrPi4DdMDRHbYntOdhHG0qTtY6pLHxKVDnbPyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rxk48gwt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hTTJ7OXYyAx1ZfgndTqE4h/ckOFQ/YcOcAae/xgQEag=; b=rxk48gwtwxdly6V7kB9jzrpiHP
	MHVGl65qKQC+teywOmweE8tYOCUobbt6HUZXL/4IBedWNWsIhmmdYWNioXllEWuH0HDWaCHKAP3C/
	XvvR1DhmrKg+EJ7MZXHxQO6epJgNCk5Kg1OvGIZA1gPiC3jm0apA5YCoRiYXpRy7E+bTBMI+bxIva
	tfUMM3WSfVeQV+MnBlEgSz039UVtbHKuELZczrjjcbHvmMrakp1uKkvQ6Cev/CVw0y3nsKx5Acoy6
	OuPHNGQYFskLSOdc2yC2gEHRyrgqNv01AAefVYe3mFCXIedNyTlsob1yJJ+NBuq0it3elEty/1VAm
	MwtRSJWg==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tLVSj-0000ON-3w; Wed, 11 Dec 2024 23:45:45 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Piotr Zalewski <pZ010001011111@proton.me>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH drm-misc-next] rockchip/drm: vop2: don't check color_mgmt_changed in atomic_enable
Date: Wed, 11 Dec 2024 23:45:41 +0100
Message-ID: <173395708760.2509957.1013367330408721282.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206192013.342692-3-pZ010001011111@proton.me>
References: <20241206192013.342692-3-pZ010001011111@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 06 Dec 2024 19:26:10 +0000, Piotr Zalewski wrote:
> Remove color_mgmt_changed check from vop2_crtc_atomic_try_set_gamma to
> allow gamma LUT rewrite during modeset when coming out of suspend. Add
> a check for color_mgmt_changed directly in vop2_crtc_atomic_flush.
> 
> This patch fixes the patch adding gamma LUT support for vop2 [1].
> 
> [1] https://lore.kernel.org/linux-rockchip/20241101185545.559090-3-pZ010001011111@proton.me/
> 
> [...]

Applied, thanks!

[1/1] rockchip/drm: vop2: don't check color_mgmt_changed in atomic_enable
      commit: 9c22b6ece2e5c2308f41ba4bec27cfa158397fa7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

