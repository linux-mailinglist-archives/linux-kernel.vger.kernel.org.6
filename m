Return-Path: <linux-kernel+bounces-401784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED79C1F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3E5285A80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732EE1F4700;
	Fri,  8 Nov 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S95ecE1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82EF1F4274;
	Fri,  8 Nov 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075947; cv=none; b=sFDeKE0whp2IW5FHIOXD5EQLnlhR+GpJ70TU/4Te00U6dQO2Eqj9aYZqP/7CXQHwkaK6P/33hz899Ttz0hSlhOBgz0KnfyxtnLHFf1Jd9YV0GmH6SfIc+yX7DVTJ0qa79d2yYpiNVHHoca9d0KkOP9TLK5qldbngPhiMtKWHQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075947; c=relaxed/simple;
	bh=kdDEJrQtUo9c/wbCOUyoETQ4cdcbxfzJWY3L1MDsYT8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=fD1yA9N6jUHeXdr4tiB5fdE7YzmA9gvLTEpjYyHVn2nraV77yuv8ldbuMsGQNze/oOBp+6E5yD367jGKqIxv6ODv5Z+3qK11eCIXgYyKqPIVAXNGzuin1+zdFJKoJAtXOG94CkTb8a58TDq5v5qum6srt7qMzhGD9iN3HnlUH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S95ecE1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50A4C4CECD;
	Fri,  8 Nov 2024 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731075947;
	bh=kdDEJrQtUo9c/wbCOUyoETQ4cdcbxfzJWY3L1MDsYT8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=S95ecE1/5KUJlp1FAkDoMUxLDz1JyeQNjTNmZjJcbuDcL4yCxI0mljk10Ka49jiX/
	 aUZ6CAK3MjT+VZ57N/1PoD3WuOMKO5DUMUdPyQh0kmKQbrK5s3Y+/ajPDJepFq9mxS
	 L/ATMvmniafRUJGxviLLfTL2DnzCPa8gmkjxnR3HdemmMr1CdEPsAGP5FERL1TfIfA
	 k7SW+bNuASnRqooFFvqpzu5zseBbePUBUV9twIHxDRhInxXPblGUGbrw56rmpjGcKz
	 Va2pBWFCIoRIf2rCsoUM+t3krP08x8FND5HKF58JyW3QXbITRPHVPwkOalRSk6s1uT
	 SkoAf72GhqXjA==
Message-ID: <80b6fd96bdfb085271128f5bb3b5f515@kernel.org>
Date: Fri, 08 Nov 2024 14:25:44 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 4/6] drm/display: bridge_connector: use
 drm_bridge_connector_mode_valid()
In-Reply-To: <20241101-hdmi-mode-valid-v2-4-a6478fd20fa6@linaro.org>
References: <20241101-hdmi-mode-valid-v2-4-a6478fd20fa6@linaro.org>
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

On Fri, 1 Nov 2024 02:25:07 +0200, Dmitry Baryshkov wrote:
> Use new drm_bridge_connector_mode_valid() helper if there is a HDMI
> bridge in the bridge chain. This removes the need to perform TMDS char
> rate check manually in the bridge driver.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

