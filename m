Return-Path: <linux-kernel+bounces-195180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D938D4894
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193911F24019
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0FC6F314;
	Thu, 30 May 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B703VDg1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0166F18398F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061590; cv=none; b=qy9fIpy3/iYiZaBkVICYbDBOCTRlooMaXpwuNHmEs2RVQFkmCmz4bs9q80RC/mEgH/W6eYovpei11vWw6RTG+iVdGTtgZC+/2LcbttvZfZcBSP1s8YqjS0nvUx4G0xOqSpj+8BKTq3o7NoY+zCiTiL6ZIJ+Buzj8MOuCqOS2PnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061590; c=relaxed/simple;
	bh=2S6iC5KExp20+POdXp5zPyr1+sRk0Kr57MqCw6Lzqdg=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=klBFk2c2VT9uqw7zzv+6Rr8BiTxoRcERmhdi1bX9fzTDdebOYetqx9e/ki2ZnQiM9BMPACxvVZBMNn6KaNokSZNnSDe89kbNj6zB2i6Jix1l5ClqKjZl9XRd/1J4Q1hJ4nDKiubS+032M7pzqCmB5/7Wc1FSzozf373M0NeXP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B703VDg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BB0C2BBFC;
	Thu, 30 May 2024 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717061589;
	bh=2S6iC5KExp20+POdXp5zPyr1+sRk0Kr57MqCw6Lzqdg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=B703VDg1Kop5cQKRRm+lU6mMxMJHeoET2h0FnDPC1i6A617t34ZsMHc6F0VFcBn3T
	 GC7QaaxYerRFal9MchJ3grwC9T1U7TIfkXAsJU8Y+dESNj8KxHBcr8iZfWIsrevrZc
	 CCRxeR4ZDhWDorgYuTlcNnY4sd8WKTGDfX896Ga58JwxrvlsIJkEROnbMrcotCktfr
	 Prmjdfe9mw6miHBgYfrhWWTHLC3QNceX4ZVdLWA3LCE9mJFbd6b/D7duEbgN3Fw1qG
	 hANLZ8QzaatS0ooNQsP14315wY1xui2GmMD7WS0H48g9I3LLbWFjwHnA9MuNW9UsiF
	 FwL6jYe8vKahQ==
Message-ID: <69126b45d5c35e4835929b932ece9e25@kernel.org>
Date: Thu, 30 May 2024 09:33:07 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Jayesh Choudhary" <j-choudhary@ti.com>
Subject: Re: [PATCH v2] drm: bridge: cdns-mhdp8546: Move mode_valid hook to
 drm_bridge_funcs
In-Reply-To: <20240530091757.433106-1-j-choudhary@ti.com>
References: <20240530091757.433106-1-j-choudhary@ti.com>
Cc: Laurent.pinchart@ideasonboard.com, a-bhatia1@ti.com, airlied@gmail.com, andrzej.hajda@intel.com, daniel@ffwll.ch, dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, j-choudhary@ti.com, jani.nikula@intel.com, javierm@redhat.com, jernej.skrabec@gmail.com, jonas@kwiboo.se, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org, tzimmermann@suse.de, u.kleine-koenig@pengutronix.de, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 30 May 2024 14:47:57 +0530, Jayesh Choudhary wrote:
> With the support for the 'DRM_BRIDGE_ATTACH_NO_CONNECTOR' case,
> the connector_helper funcs are not initialized if the encoder has this
> flag in its bridge_attach call. Till now we had mode_valid hook only in
> the drm_connector_helper_funcs. Move this hook to drm_bridge_funcs to
> validate the modes.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

