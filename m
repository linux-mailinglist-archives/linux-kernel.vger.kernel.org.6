Return-Path: <linux-kernel+bounces-421344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC59D89E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F4286E08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0A1B4143;
	Mon, 25 Nov 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frwUvWjA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78B2500D2;
	Mon, 25 Nov 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550483; cv=none; b=dnHZNzkV7hvZVFq7vhO3odsHwIf/LtLEgOBCFsx89OxHTcSisJSKM/ucR+ZMEHsloB7uU3gcytsc/vpiZ3yKsR4e4hzn+AOvEUZG3SWASIW/4M84TkzSYb730gVG6MOvkkSMjxIyOw8kKYSJIxokyUHysKA9eTcthB02vtbNzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550483; c=relaxed/simple;
	bh=nOc3Xy7mhkWTw8qDkGMCJ3rROD2LNWSCNirVNpiwODg=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=PHQnNhQo2hhCv+fl420Uk7y/NlEINbGO+3qHCGSMKYu9YkCrWoiebyo/+I5cEJ9EGhQao4foPfV1tXLeRCO9BEmCdocQ3VdifBPN38xXVvsZ7Di8MCDV2hkVLlYqoqTkNx2WbzaLIfoiP7J4znlDLdhGF7MP+lz2mxsQxKV/OvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frwUvWjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C71C4CECE;
	Mon, 25 Nov 2024 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732550482;
	bh=nOc3Xy7mhkWTw8qDkGMCJ3rROD2LNWSCNirVNpiwODg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=frwUvWjAT86MGYDE31mxgujfkohr2ef3K4nhK2HbJuEEMJjrBbhwlO8jDeCeKBr+h
	 C2hzW+jG/wlwKgJ2s7UIhxhWAWykVR4hNVemAuy2gBl1kXoUbjDTsPwpzomUIhZdLC
	 eh2vMbpMyNeUbxSJWLX/tGjNTuSwFMyAT10TpsrRV/sYMSuNeqZ2e2iHcDGjYvkOgs
	 K3rfy1A6NPtU0CO//OjJ59wRRitpAxEHDAcdAeMLwnlxQzUPfAZrqOkonRz41u0zU6
	 oXVv78t0UQsZZMydobXwafUq03sY/4SG7BxHadCaevt9YMMDVpoLB2CKCu15OAsz04
	 dcOi1kLNnMMJw==
Message-ID: <08f3944d0330d17984641bb2cb94fb88@kernel.org>
Date: Mon, 25 Nov 2024 16:01:20 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Sean Nyekjaer" <sean@geanix.com>
Subject: Re: [PATCH v2 2/3] drm/sun4i: use drm_mode_validate_mode() helper
 function
In-Reply-To: <20241125-dsi-relax-v2-2-9113419f4a40@geanix.com>
References: <20241125-dsi-relax-v2-2-9113419f4a40@geanix.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, "Chen-Yu Tsai" <wens@csie.org>, "David
 Airlie" <airlied@gmail.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Philippe Cornu" <philippe.cornu@foss.st.com>, "Raphael
 Gallais-Pou" <raphael.gallais-pou@foss.st.com>, "Samuel Holland" <samuel@sholland.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Yannick
 Fertre" <yannick.fertre@foss.st.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 25 Nov 2024 14:49:27 +0100, Sean Nyekjaer wrote:
> Use new helper function for HDMI mode validation
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

