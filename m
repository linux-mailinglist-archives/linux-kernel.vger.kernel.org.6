Return-Path: <linux-kernel+bounces-534537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CDFA4683B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874DA16F940
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C552253F2;
	Wed, 26 Feb 2025 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM3Fkvev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9018DB2E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591591; cv=none; b=OQXli7u5bltMsDqPRxwo9LEnFaoLNH75H1fGWFGk76QqHu50l/xbkFXSZb5lGTrpXZbBAsg9Wu8Mh0zb3cTDMuJgsYWCs29SxdaWiE7FEwTxcnEn8HGFuRMO9UWn59Nzhlv0PC4oFzg+Pc1Zh9CVaOa80p5n2XQ2c7EKZkJa5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591591; c=relaxed/simple;
	bh=9hZ2kWScNTHgC+16YX2niQ0hHv6Xdqe9OGxTNoOcim4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lyJWyF5XFXLw2Ezy5b3GsZiwwEVcTORNH8mKHENi46y+X3y3AY3yOUUL8AcMxilCdu/1klkoNZkJ7btWyOFqW9Bse2mqfLfOqlPutdpE+1QHA7dmyGVn04BWRaiVpDiUOkogNn2vJ9l8UOTC3PBpeXy6ppCwokfBWsTS0T2YMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM3Fkvev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E874BC4CED6;
	Wed, 26 Feb 2025 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740591590;
	bh=9hZ2kWScNTHgC+16YX2niQ0hHv6Xdqe9OGxTNoOcim4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vM3FkvevmWxoVsILaG2oNwL6w6Va5+oXVxEkZL1vpRRUZoa9umKUo+HKi78Rvs6rO
	 bAxW3DTqm214qm04VMZMtoDK5+PGYE0HUrKUiYFmpD0Hzi/SfUlEsRLscKE6pnCzH4
	 1B3D5ruqTVBlzTkJyHN3kbx9LcAbtj7FvbOnuem9YV7NKOvvlhn10YuGvjvNCKjVPs
	 AFJUQIPOSvF+iH8oqa7w4Ddrg3HJNR0+8OugEXIFYZoU5/PQLy4oF9XoLaQygyurIg
	 iQ6Ng24ZEiwhtdUEwWkecFgE4L5PN9AGqCHe4UIE0vxutchu/HwiBJncej8Ysa6Hzd
	 hMH6x0aq3ZkhA==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Herve Codina <herve.codina@bootlin.com>
In-Reply-To: <20250225135114.801884-1-alexander.stein@ew.tq-group.com>
References: <20250225135114.801884-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] drm/bridge: ti-sn65dsi83: Support negative DE
 polarity
Message-Id: <174059158754.973942.5009954425785928833.b4-ty@kernel.org>
Date: Wed, 26 Feb 2025 18:39:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 25 Feb 2025 14:51:13 +0100, Alexander Stein wrote:
> Polarity for DE is stored in bridge state. Use this flag for setting
> the DE polarity in the bridge.
> 
> 

Applied, thanks!

[1/1] drm/bridge: ti-sn65dsi83: Support negative DE polarity
      (no commit info)



Rob



