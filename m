Return-Path: <linux-kernel+bounces-256317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85D934C64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837CAB2357F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFD137776;
	Thu, 18 Jul 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR3u2hFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811F74429
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301870; cv=none; b=A+FvVlD1kFD7Mm1ecqFu8QKt4KLRqIYZNKJ5JHMZFfphOq2x/Y7ukDEdJDqSnLu38iegyLAXBmNtNEILfWYAGo4rhizdiMx7sZIxHixR9XZQnWOD33zHuJDbxYDhIs/ZjXxpltP20OPVMfnkltg2E8t8VJYEDSEZpplpAKXOvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301870; c=relaxed/simple;
	bh=KfFyubN8rXnyBy9yxrEzBz3oAiQBkGpvwEHAWprvlDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rLuxOHI8xSnEuKOosVb/juNM6Hi0WTNz5xwnzafzijhs0ohxAsevXXGnAjYGg9Q8fexXmst13Yy7KTBeGw99ogx3talc86BQ+Ojs2+dR3NG77Y3emrI9zuSReuDBXI8apv8vbnYO6+FWttfLhRAbuBVNWSQ5xIE1OvST3GAUIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR3u2hFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF11C116B1;
	Thu, 18 Jul 2024 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721301869;
	bh=KfFyubN8rXnyBy9yxrEzBz3oAiQBkGpvwEHAWprvlDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RR3u2hFPe99z1pCrlGGQwO40TMQPVFp3zE4eQgi3jnTiI5A30H2lTMAd2L7aNGiVp
	 zHvcWZ3DSBdw4/0B3PmqbOIz8MRus4AiJeMGPNLOiib+Y6uG392kK5Lbv20SEy9TdF
	 kN6h5WrCa0RZnA9sQ1kj7JdXRHcaLWd1HvO+217rMUH/sTsLObty9AzKBS2oRqzwzX
	 Sxs5Or/FMPDQbwxpcoGtBOfUBaj6ZIAhcYS/nPHNKp8j6PQB7pXwsVYPEkZE7RKNpI
	 TVvoja2NyYaFDNv1GOns6ohn/keZJzrNmAvUmHWPV6reY7hvxKn43uJY37aONJ+/wV
	 1s6jVk/djH5AQ==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240703122715.4004765-1-alexander.stein@ew.tq-group.com>
References: <20240703122715.4004765-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v5 1/1] drm/bridge: Silence error messages upon probe
 deferral
Message-Id: <172130186654.520314.13110263316783512332.b4-ty@kernel.org>
Date: Thu, 18 Jul 2024 13:24:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 03 Jul 2024 14:27:15 +0200, Alexander Stein wrote:
> When -EPROBE_DEFER is returned do not raise an error, but silently return
> this error instead. Fixes error like this:
> [drm:drm_bridge_attach] *ERROR* failed to attach bridge
>   /soc@0/bus@30800000/mipi-dsi@30a00000 to encoder None-34: -517
> [drm:drm_bridge_attach] *ERROR* failed to attach bridge
>   /soc@0/bus@30800000/mipi-dsi@30a00000 to encoder None-34: -517
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: Silence error messages upon probe deferral
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bc657615e10d



Rob



