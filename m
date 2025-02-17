Return-Path: <linux-kernel+bounces-517705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD3A38486
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E045188AB88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCD821C9F9;
	Mon, 17 Feb 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUdldsRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A221C9EA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798598; cv=none; b=Tw1G0s5G/0Z/n2sX/PR9drq0xrr1SSey3ftf5PGdEuYYngUTH2QOnEZJ6W13iw9keEf+f7yyUHbAGVpBdk4zpNRWwk3rINcfuRwf+s20KX6HBv2bARVUS42/X4K/gSSLKCtezEr4QIym1mc5qCburOW7K2OTUZa4qUzmbHUljDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798598; c=relaxed/simple;
	bh=aclQdcwtWEymwa3JymB/vRVU50riI1PPEXXl5xwIVW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fvRVB2S13vaRW5/HKFR0ez2pxFbnEAlKGTyBZEmHL+0bZ3z+UPCFFIsBWWLcccJQkvSIvXPPSuptgMADswZuMn1sKd7w8VvG2jTisY8qDSM8jYo+d5hZ7JebTAuyBi+ErV8erkTHVHx+GM3jWmqOVNmlf88A7Z0VszxzHbkqnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUdldsRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83DDC4CEE4;
	Mon, 17 Feb 2025 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739798597;
	bh=aclQdcwtWEymwa3JymB/vRVU50riI1PPEXXl5xwIVW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kUdldsRNmYdIe91OYvCI+anteaEdcRxo7YFXtpaNVmA5H5ngmuG74JOn70px/1DoF
	 EEhmVBnn2a+1IYpXZCM2h0etA/QUX2cZGfokF77dxasqgVCsy4+92kaMbqG/R54lXl
	 PLjuYx+wwR6VbTxfGJzyim0TAJAqK39QVsOyXCuO+EZddpvay+kTSYglJ5275A6izH
	 gc68O21W9NHG9ZJ6m93kurh5GXBMeJM3C1tydpoL3c0a5ndrRfv/wPQCvf8vGMKT7p
	 tk04iCQpEtTqLmys4zzUMbcXc2/CwVu1CBeF6hxGnJ2LnI9SN4sFgN7lOdiyKeSKhd
	 nDnDG7p60uVmQ==
From: Robert Foss <rfoss@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250214-drm-assorted-cleanups-v7-0-88ca5827d7af@bootlin.com>
References: <20250214-drm-assorted-cleanups-v7-0-88ca5827d7af@bootlin.com>
Subject: Re: [PATCH v7 0/5] drm: small cleanups and improvements
Message-Id: <173979858540.712245.13173359514923904651.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 14:23:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 14 Feb 2025 13:57:39 +0100, Luca Ceresoli wrote:
> This series collects some minor improvements and fixes previously part of
> [0], hence the "v7" version number.
> 
> All of these patches already have some Review/Ack tags.
> 
> [0] https://lore.kernel.org/dri-devel/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/
> 
> [...]

Applied, thanks!

[1/5] drm/debugfs: fix printk format for bridge index
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/72443c730b7a
[2/5] drm: of: drm_of_find_panel_or_bridge: move misplaced comment
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9d60cf4e8cf7
[3/5] drm/bridge: panel: use drm_bridge_is_panel() instead of open code
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/cc46371e3d32
[4/5] drm/bridge: panel: drm_panel_bridge_remove: warn when called on non-panel bridge
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/77053ef7207a
[5/5] drm/bridge: panel: forbid initializing a panel with unknown connector type
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b296955b3a74



Rob



