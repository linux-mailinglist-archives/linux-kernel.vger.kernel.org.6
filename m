Return-Path: <linux-kernel+bounces-292176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDE3956C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9715D286401
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099317AE18;
	Mon, 19 Aug 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv4G4Q8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764B16CD3B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073947; cv=none; b=pVn0ilcvRMDB52ZeVfk/O7+Zm9Lw8iAYBR0OP9E1WXKy1hnvLmrQIRi5r6Q8lYSBpD/UwwQiycL2aQcgMThkwyqu+IgYOQRVxraqRpXuJEj9pgLgZDhbHQAoXnC0vmuoA5f5/BksoH7/C1rbN1NdddZnOeuav8ONAmjlF3cHQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073947; c=relaxed/simple;
	bh=nVi0MFOHh0oHapJVb1x3xrZyc535Kwym8cv2KbMkFU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u+6iq0bd+dZaU1BSONbf6CWOjSGce96Un0paKaRGH7viVCrCMtijcPpPm3fcxd9rH+XpePElMChsLOaOOEzrrvUhbkezEJ0qhvPc4zfSdZUQlvCgeckA/ra/Wg4c+pwMrF38P1jFyt+cW4X506q3wUf9dU5czoAuqW+RkRJIIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv4G4Q8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F39C32782;
	Mon, 19 Aug 2024 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724073947;
	bh=nVi0MFOHh0oHapJVb1x3xrZyc535Kwym8cv2KbMkFU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dv4G4Q8eoIOdD/kJ82Oo4daqKc22bf8ZNdElU3nXLEOVtKIch1o3l2kdaZFAyY1b3
	 BWcza/eEW1SyjyFDdBnCB8TAc2VvbwjnUjTKorTaz6wdrrjlXMPAOGSWPL3/6sXKY5
	 4Rw+WSetzYUsldYkfSg3uM/+ZPxK9Cee9zwgFSdVBf/NIhnLEHDZnlPjMo9TKyeUa1
	 7rA3755nKQzONPpOaoeWv3kuidTL5sXLwQlaWd0GqAu2s/R3ljlgBYU4raZvpZzHPb
	 gIkn+8soWgNf/vW8mDW8Ly55GtBNvLW5EmiX/bIBxjqx/q3GAQc+6DSRL0HnT3XheF
	 w7U/cR4Q+Vc4w==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813-dw-hdmi-simple-clk-v1-1-78d45cef02a9@collabora.com>
References: <20240813-dw-hdmi-simple-clk-v1-1-78d45cef02a9@collabora.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Simplify clock handling
Message-Id: <172407394373.1400799.11053153831131515135.b4-ty@kernel.org>
Date: Mon, 19 Aug 2024 15:25:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Tue, 13 Aug 2024 00:23:21 +0300, Cristian Ciocaltea wrote:
> Make use of devm_clk_get_enabled() to replace devm_clk_get() and
> clk_prepare_enable() for isfr and iahb clocks, and drop the now
> unnecessary calls to clk_disable_unprepare().
> 
> Similarly, use devm_clk_get_optional_enabled() helper for cec clock,
> which additionally allows to remove the -ENOENT test.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: dw-hdmi: Simplify clock handling
      (no commit info)



Rob



