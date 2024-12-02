Return-Path: <linux-kernel+bounces-427910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F639E075A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C75E285AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B492F209F55;
	Mon,  2 Dec 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBLmPfEu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902B200B9B;
	Mon,  2 Dec 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154296; cv=none; b=tjbEzNaTk81+Nt4kW3/NFtO+nV5LbnNLQRHzZCEos0xvKtZ/16JJuAZ6O8mQ+ONFamF8IKZQjnCCG1lQDyNUQs0Q3hkZMOQrMb1lGSx95ZaNBSvjcVQ0QdZQNvr8G9euI7aA62pboYltk7OYZgRtiVzYkaXWO5qebLYnZiMiqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154296; c=relaxed/simple;
	bh=J/q1xWj4DxCp6IzU7uPb7iTssY8YnrBnsl5MtdaRI/Q=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=oRA+QjgwBtcCnQuejNojb+JTzB4Sb23uiv+vwPaykbn92FDKMs7DoVJ1OXVcz8C6ycVuNf4n+EkMHuHtndLBwzdEViqsuYkwKhLk96C+4bM9UWoy8K8aHr6zXdzLn2mRyq7ulaOUhVgQSfxlbMeWcZX8OVlhEfX0QoX4I5Omhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBLmPfEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF5C4CED1;
	Mon,  2 Dec 2024 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733154295;
	bh=J/q1xWj4DxCp6IzU7uPb7iTssY8YnrBnsl5MtdaRI/Q=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=bBLmPfEuiTfRJnp+ZnwgaRqb9cxXz0K6fMMlUyvDEsusKLVmzaRUkMK6epO8opKEs
	 PwmmSAPf9vdTpehrIfen0th26tLjWFetjQq2vFJs315alQa0XFABW5BAVfcJy5vH3D
	 qCnqbb0sbSC8lSZB9WwLsOaDr4ykQgEM6fQUspxdClGm1c1NZI0O9ThDWxAH9A4id7
	 hIwTG55au1gkzWkIt3zOPFTeeNy8K6nea7RTJUvG/AkLDeFtDbKtDjcZq8Tq7a1zQ5
	 jOfEqNrBFhY8oDlt835VUwvXntb8rAhmkDL0P1EWn8PrpBBLQVNpG3mQzMwHuhfP1x
	 DYAxZ855ED4dg==
Message-ID: <f7d5a7e084f01661572b2608c9a73db2@kernel.org>
Date: Mon, 02 Dec 2024 15:44:53 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v5 04/10] drm/display: hdmi: add generic mode_valid
 helper
In-Reply-To: <20241130-hdmi-mode-valid-v5-4-742644ec3b1f@linaro.org>
References: <20241130-hdmi-mode-valid-v5-4-742644ec3b1f@linaro.org>
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

On Sat, 30 Nov 2024 03:52:29 +0200, Dmitry Baryshkov wrote:
> Add drm_hdmi_connector_mode_valid(), generic helper for HDMI connectors.
> It can be either used directly or as a part of the .mode_valid callback.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

