Return-Path: <linux-kernel+bounces-401785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0F29C1F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3088B2335C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9B51F426F;
	Fri,  8 Nov 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byVIt3pI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782D1401C;
	Fri,  8 Nov 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075960; cv=none; b=MH1fwUBEOvFZvGrVXafRAYLxGM4cXXTK6mxB2FeY74aT2yEu3AiDLGcbdA5ofytfEpDNluLPHe9ZZrHQpYyuBtfhDpx2nu+brz70S8rCsLWnSDOuqBYF9S+FYjjbhjlBsR3AtbLc9TQC8S1gCWvMz/eiFWoUH6jzvLlp9i3BhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075960; c=relaxed/simple;
	bh=RzTmieNK3A8R7874rWrc7RYSXN2l8cHqDRlpprZm/uk=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=MrsMG7ODAUNtnbUzsZDN8Js64Z/6B1K0FubkHwHmX0cTRSrQ2sGlKWpS71dlEfkt0ESFCy9zKInqDjFZZWfkRhg+kSQiU0ObmHm5f8y2eIWBWhpNQ9PHgYu85AxduZg1nMzYkc5pqJBeJC5Am7R1cxlZdz1qwVspbDgZSYeSOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byVIt3pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA91C4CECD;
	Fri,  8 Nov 2024 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731075960;
	bh=RzTmieNK3A8R7874rWrc7RYSXN2l8cHqDRlpprZm/uk=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=byVIt3pInLT7VLq9NCijhVkw/If6WBIR4RC0r5qiD9xyM4XkbQz538omIfMcgG71B
	 7PyWL4a/QIyF3RlBnE1NckQ7lDbGChZyr3p464SrkUrkCB58bzpqS9tHlnR3usMk9Y
	 L0brsGNY5JLOqxzm4fHbMTuPcFAet4aL7r3xMFCD0f3iIWD+HqOU401ZNHSTCs7AmX
	 VuT09lObE1HSYdC5B2hca7BBE4u/B3c5I+/eUwgc+WFSnJyJDJ5/CtJCLUWJaZwZ/w
	 /sTPkS8uK1PDbeNO5GiUfq7JyEZFsDtY62taFyK8I3K1fMaMvhTZVjRgOHgOfem1QP
	 7559zvymTNYTQ==
Message-ID: <785b15e68207eed61e5b7252788362a4@kernel.org>
Date: Fri, 08 Nov 2024 14:25:57 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 5/6] drm/bridge: lontium-lt9611: drop TMDS char rate
 check in mode_valid
In-Reply-To: <20241101-hdmi-mode-valid-v2-5-a6478fd20fa6@linaro.org>
References: <20241101-hdmi-mode-valid-v2-5-a6478fd20fa6@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Chen-Yu Tsai" <wens@csie.org>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Robert
 Foss" <rfoss@kernel.org>, "Samuel Holland" <samuel@sholland.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 1 Nov 2024 02:25:08 +0200, Dmitry Baryshkov wrote:
> Drop manual check of the TMDS char rate in the mode_valid callback. This
> check is now being performed by the core.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

