Return-Path: <linux-kernel+bounces-292189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C17956C34
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F901F22CED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC116B3B6;
	Mon, 19 Aug 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byE4dY67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFF165F10
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074408; cv=none; b=mXZpeAZ123msXWR65OPSR3AZolPx2G8S0+3e4wP1fyrux0GF9diUUGadxkN7l48QbMBCBuIshCrQoIugsH73lBtXU+IQnRlbWMhiEC0fQn8U4AUhn+73oCGZ/F8lzrj6PfwrUqCNy2O5vGWDnq6YXcbkXvhJCcd+9+dSmnEU56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074408; c=relaxed/simple;
	bh=5qvpBIw8uzv3nxKxx4KUdm+35UYTokqviRkRhaMimwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t6BH9AUHXgssn+t1ilmwoNI61qI90cl707fwUtbDeMCGGaRoIwYrHUD03UqWkwvwefvKNOP3JDUXz1EQOHCSuLcqnhy8li6tULJTbqQNLu+xkLZaNkCQlniyi5NUcmnWVCUFs8bJVeeZJCA5r7kxFN4FZ2mvfULwQTM05fdf2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byE4dY67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32B0C4AF0F;
	Mon, 19 Aug 2024 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724074407;
	bh=5qvpBIw8uzv3nxKxx4KUdm+35UYTokqviRkRhaMimwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=byE4dY67yrPNWy/u7DbowN6EI5QRrnaIeQALVFl13qv/VV96esQdazaXTRF+ZoxGA
	 2sLcXjXePGCEeRj9vaXeDoXRiM98RQhhrkIrcFrycHoSlFnX1JdfryY12/pRnX/kO4
	 ch5S7vPi8q29mL3I/dgB9fO6NdVaVMY8pGOA1O7Oj5kOVTaPqKHITVOE/II+collRl
	 jqBEtO8DlLQtGPFquk+97j19f8F0DT7bSndRGFYrkQmS2gdOCWV65/lhqd/Fr3xSRX
	 r/H3ULYg3dgU150bskMFVy9LQQG/WFhpiejPNf5h9TYfk7pnSFC5Y9YY5S/iMdvAn0
	 Ua2wXnBEkVoBg==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731201407.1838385-4-robh@kernel.org>
References: <20240731201407.1838385-4-robh@kernel.org>
Subject: Re: [PATCH] drm: bridge: anx7625: Use
 of_property_read_variable_u8_array()
Message-Id: <172407440450.1407402.570433127422255941.b4-ty@kernel.org>
Date: Mon, 19 Aug 2024 15:33:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Wed, 31 Jul 2024 14:13:59 -0600, Rob Herring (Arm) wrote:
> There's no need to get the length of an DT array property before
> parsing the array. of_property_read_variable_u8_array() takes a minimum
> and maximum length and returns the actual length (or error code).
> 
> This is part of a larger effort to remove callers of of_get_property()
> and similar functions. of_get_property() leaks the DT property data
> pointer which is a problem for dynamically allocated nodes which may
> be freed.
> 
> [...]

Applied, thanks!

[1/1] drm: bridge: anx7625: Use of_property_read_variable_u8_array()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/11c742bb5a26



Rob



