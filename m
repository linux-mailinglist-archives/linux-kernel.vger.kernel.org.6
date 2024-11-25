Return-Path: <linux-kernel+bounces-421029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84D9D85D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA711696BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5A1A76A4;
	Mon, 25 Nov 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+OBS5o0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7A18A6C1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539849; cv=none; b=qXBGpyZlG3Ewr/dtISyeZ4T8OXYH1D0TA0FXdTOVKLPtMxTYMasU2HKo/IKXIfkiyoBc8uzG05rgxtFqH9nFZipx9oayw4vluIBQcJoiv1qSc3J8uUic7P9eZoSzuLb/GwB1rlh97EEP8m4qTeoA7dIyk0OoKGcn6Y9UrMekbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539849; c=relaxed/simple;
	bh=KHvW4Onn19WYFMw2iYzTcZkbAoTI3RCvTBDCiMQzLB4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=FmktZUDOd+qUDLzxeSONn1RYavvbdwj+5TOIGHGLdLbE1LF6wflD0q1YEQuvMFnDNnnEyENzY6bzUs4lzhjo7yeInmSvXiy/nRcURc/4uwtISa1SgDlPqhGUTMfFcZYo2hU4t7QeeucaPru/dcjsLUOa/Jza8rOSY4fHPYxcZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+OBS5o0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B4AC4CECE;
	Mon, 25 Nov 2024 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732539849;
	bh=KHvW4Onn19WYFMw2iYzTcZkbAoTI3RCvTBDCiMQzLB4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=L+OBS5o0qFxjQi0Wv4YmbLOAscDUh0xzwRIjHxUZTGyJmolfYpRXPSwr1qLq8XZQw
	 AouBExp4obsp9u3wnyE7oN5dB9rSCIG+hRGOj1ztJ+FEnI74HDH7Eoc4EJYxnnApZb
	 3OmkWW/P4Iuylwz8ld8aLiiNTJKhVH6FpnsLlaZJ4kwRQE7Jkumj8CngZN66HYszEB
	 KL34/NcPT3FkcMVMgSDP6uyGBMO3XrKeif3HJ+wgKwA4KFypsPySDdttBCrmRH5x7c
	 V8vbtSF6EqiZzNgANJ2SRoji2ngxiUXNEQiIDIpBkdQSCcrGunzXu509trYVc+7Bdx
	 6s9hkXD8p4DKg==
Message-ID: <ebed01d2da63995dce745cf9a4a6e676@kernel.org>
Date: Mon, 25 Nov 2024 13:04:07 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v5 2/5] drm/vkms: Switch to managed for encoder
In-Reply-To: <20241122-google-vkms-managed-v5-2-1ab60403e960@bootlin.com>
References: <20241122-google-vkms-managed-v5-2-1ab60403e960@bootlin.com>
Cc: arthurgrillo@riseup.net, dri-devel@lists.freedesktop.org, jeremie.dautheribes@bootlin.com, linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com, nicolejadeyee@google.com, seanpaul@google.com, thomas.petazzoni@bootlin.com, "David
 Airlie" <airlied@gmail.com>, "Haneen Mohammed" <hamohammed.sa@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, "Melissa Wen" <melissa.srw@gmail.com>, "Rodrigo
 Siqueira" <rodrigosiqueiramelo@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 22 Nov 2024 17:27:57 +0100, Louis Chauvet wrote:
> The current VKMS driver uses non-managed function to create encoders. It
> is not an issue yet, but in order to support multiple devices easily,
> convert this code to use drm and device managed helpers.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

