Return-Path: <linux-kernel+bounces-536059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C2A47B10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BEA2165B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBFB2253EB;
	Thu, 27 Feb 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y+ylQJK6"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9EB1662EF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654010; cv=none; b=iI//ic8RwSssoobnqP0IyTas9rFSq3K1YXJJrC2qB2E0o0tSR9kDqm1cFN+LHFReFKvhzExQrwTKnJEg0lmaEPFaaRzDnR6tXtyE30c/Qo6oFxyW8A6x8C7gjaMLPy5j31Dsbww8J2uAWAsPK+bHnWdWICpYdgv/btEgTxJ3ZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654010; c=relaxed/simple;
	bh=ElcnDMnhszFbY6xjLcePGTz2bntjpg6oNDRnwXoXtXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1cbvxenycSUGyPN2T4m6Q7oCTqGmegRowxaIbidrdfjfFmfHEik3zFuTwyA9ZY9JBrX3ZYVr173gsCDVyfMGN318BTzty1UIoZ7T2eYK6Y6ZgB2/qtmTI2iOCVCpU8NyKAU+gntH0dUIJAlzUHdkqXMsJDx04XeL9EURgc4W90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y+ylQJK6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43EB44429A;
	Thu, 27 Feb 2025 11:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740654006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRtGr3AFG7KYIerjmFHKE39XTlw5yCSP9o9cNC/e55o=;
	b=Y+ylQJK6jEUYgk4HhJZ+aDr4x08e3Nzao/YHmoxpwPs3Ut59XOsUE1JoF5A22Y49jrZ+wN
	qygMytWr2FoeYEEifwnMkIqKquvZLDyDIRbpxKFEQXTXafRgoc1dRXgTNIKPv6klFcYIL/
	tXxrA2FRBpbSXYJRspnNBrVP1BoR//ifTzBAuaS4vC5NII8LxPY0EkQuYdzBmZvLQFxG2+
	MY1WqwE9UDwRorQoMnckswzMFfeIQqIX4m2qgiGk4m6v8H2A8CntuBvgJFge5bsn+EyfmW
	RT4kz+DgEcsdRQYsX3kmjcF1yzanU/w0Y1afIH0JlMHMvKKBCxKHV6HTNQ7WnQ==
Date: Thu, 27 Feb 2025 12:00:04 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas
 Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v4 00/15] drm/bridge: Various quality of life
 improvements
Message-ID: <20250227120004.77814e09@bootlin.com>
In-Reply-To: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvu
 gesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: herve.codina@bootlin.com

Hi Maxime,

On Tue, 25 Feb 2025 17:43:48 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> Hi,
> 
> Here's a series of changes after to the KMS helpers and bridge API
> following a bunch of reviews I did.
> 
> It's mostly centered across providing an easier time to deal with bridge
> states, and a somewhat consistent with the other entities API.
> 
> It's build tested only, with arm64 allmodconfig.
> 
> Maxime
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

I Tried to test this series on my system but I've got a compilation issue.
     depmod: ERROR: Cycle detected: drm -> drm_kms_helper -> drm
     depmod: ERROR: Found 2 modules in dependency cycles!

CONFIG_DRM=m in my configuration.

Tested to move to CONFIG_DRM=y but in that case, I've got
     aarch64-buildroot-linux-gnu-ld: Unexpected GOT/PLT entries detected!
     aarch64-buildroot-linux-gnu-ld: Unexpected run-time procedure linkages detected!
     aarch64-buildroot-linux-gnu-ld: drivers/gpu/drm/drm_bridge.o: in function `drm_bridge_reset_crtc':
     drivers/gpu/drm/drm_bridge.c:1413: undefined reference to `drm_atomic_helper_reset_crtc'

Best regards,
Hervé

