Return-Path: <linux-kernel+bounces-403033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574419C2FD5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 23:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB227B20F7E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF01A0B05;
	Sat,  9 Nov 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xPjXkOJt"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB414EC4E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192755; cv=none; b=q1WeyHX0elPwt1NSOwGo3vqw+Jap2aKYaTKx16vwDbcCv/kAx8lFbpU8ufZ6J12KTQMKktSu2ESFyXruDjGKNPHTh56CXk58Iccmawy2Lrn+47FLRH3/wRwWDu/+MBClIgfZpkVlJ/tpFXgLmy4HtC9R08bTbX/UKssTq92w3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192755; c=relaxed/simple;
	bh=uzmAdNiAzawcTzPxYe+ddBgClEZmnLWaq9Gr7a+9B5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqgpx3O3GGfxEdmYtXX3KZWQ4+R70Guyz6OR0qY2lRI+S+osv2jWA8fM9RrRaEzCiZxbNTZvxlbEY9RZSbZQz7tQHkP3tYVZqQX15N+1oQp3Zqy7fjqBJpn8MGRkT/heZwIw1/SV/+pSPBab5cStXOUvErRZmTv3at7SqTWRuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xPjXkOJt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xKSRMiOUcm6WD8u8BC8dWSf2cMiJUWHKxDSv2viQmW8=; b=xPjXkOJtxqvG76fVuVNp5QubWb
	bQ0iI5yrwfAuEASUpIVWgtuMSVgQyuv66vDW774RBFsdR8ZiDlFVoofuhSxPJtG6jLnSf6ajXzDl9
	xK3xe+vi0ed0tl5t08dmKy5Qfq4HZWHbSJJwndZ9XvMNqBdasvMgnIc83x+4laGZ7jLOuEQDzTGq0
	YERZBfpp4KgNx9TPeyM3Xc+STaPipzugGrjpzwqsoyhJXSwsTawRPDpLKtZirXn3ue8FXpjTHuJE+
	FvNoEtwDkA7Xj+FYKK3kNtc6/PYR/dHvwpXu65IPkXoKoJVKH4Dl6OGRW2PZrO0gaYwYCHz8ySp4b
	J8TJi0hg==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9uJO-0000NE-FH; Sat, 09 Nov 2024 23:52:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: tzimmermann@suse.de,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	mripard@kernel.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Piotr Zalewski <pZ010001011111@proton.me>,
	linux-kernel@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Dragan Simic <dsimic@manjaro.org>,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v7] rockchip/drm: vop2: add support for gamma LUT
Date: Sat,  9 Nov 2024 23:51:57 +0100
Message-ID: <173119266841.1201296.14807724034242534977.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101185545.559090-3-pZ010001011111@proton.me>
References: <20241101185545.559090-3-pZ010001011111@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 01 Nov 2024 19:01:17 +0000, Piotr Zalewski wrote:
> Add support for gamma LUT in VOP2 driver. The implementation was inspired
> by one found in VOP1 driver. Blue and red channels in gamma LUT register
> write were swapped with respect to how gamma LUT values are written in
> VOP1. Gamma LUT port selection was added before the write of new gamma LUT
> table.
> 
> If the current SoC is rk356x, check if no other CRTC has gamma LUT enabled
> in atomic_check (only one video port can use gamma LUT at a time) and
> disable gamma LUT before the LUT table write.
> 
> [...]

Applied, thanks!

[1/1] rockchip/drm: vop2: add support for gamma LUT
      commit: 4f537776340dab2b680a4d8554567f6884240d0b

I've fixed a number of smaller styling nits that
checkpatch --strict found.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

