Return-Path: <linux-kernel+bounces-518986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F4A396C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1647188D3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22EF22C356;
	Tue, 18 Feb 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hChNyeH9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C51B87FD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870181; cv=none; b=sKQKp4DiKjBAzN6Oywt1+fZ+mcZpvklOgb5cc3dqJ92XyHNfIKJnEdbGT3aazmMJ3vC6nbTc8wUnvFZXq91fartbARcZExKEbBI2Lnh99T5xo44XSH5lc2+96z3bOXQ1ZPGKD6OTmUUxBAgL3gF+3oKUPrqNCrWqiZnsdsgIjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870181; c=relaxed/simple;
	bh=SM0tMdeumZj6AQd5w41sZm2dTMTE+7buMAzeBPDtq20=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t4z+vXt8KX1wyyW0LRozsbH6dM/RMvbu1qdi62VyDJbTmtkLeLMO4PHeG8TkqeHQjKtsFAGYSOH7AcGPSrv1WCBanV89OnH8PZaaDrlUJVfMXzokFrw71Y2eQt/0UqoCuEqUu9radlQbDJOIcXBeyXdwwSt9bcS2Ojqwo/U68wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hChNyeH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F72C4CEE2;
	Tue, 18 Feb 2025 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739870180;
	bh=SM0tMdeumZj6AQd5w41sZm2dTMTE+7buMAzeBPDtq20=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hChNyeH9nWUdkJPLiXRMiNLxjxdBk5mK41mOqPKj9Xt9Ff6h/Vc23KKHLFXxRa9R8
	 f8hplOnVubqAPmGrzKqUeq15pxxCNUNkY5PJzb61XFUfZxSYxCU7nEgxKtfXAxMyLJ
	 grSIdeLuFl8GDA5WhLfgTt7+QpNj3FApUS8igKE62TCwFil+az/pQ6xbnzKRR8an3r
	 326dTaHjEjpP5GpMK0Et7TKONrcMancFnC9TPwLiNflZf1udmlCArvmG6SbtW+5u0n
	 ivRgY6tvoDbUZIGRH5sRbMME8ECF6WC2ygqpOv09mg7Kya9IJx2k/p6ih5VWlLShxp
	 dMiMOx/+EeBvg==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250120132135.554391-1-alexander.stein@ew.tq-group.com>
References: <20250120132135.554391-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/2] drm/bridge: ti-sn65dsi83: Set bridge type
Message-Id: <173987017056.847779.15480441062069554205.b4-ty@kernel.org>
Date: Tue, 18 Feb 2025 10:16:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 20 Jan 2025 14:21:34 +0100, Alexander Stein wrote:
> This is a DSI to LVDS bridge, so set the bridge type accordingly.
> 
> 

Applied, thanks!

[1/2] drm/bridge: ti-sn65dsi83: Set bridge type
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/272f17229e47
[2/2] drm/bridge: nwl-dsi: Set bridge type
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9b6c03cb96b9



Rob



