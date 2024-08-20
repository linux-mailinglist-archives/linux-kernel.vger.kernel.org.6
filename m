Return-Path: <linux-kernel+bounces-293851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6149585BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF2428393F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8B718E023;
	Tue, 20 Aug 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EArfsFLY"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6CEEA5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153083; cv=none; b=IKXMA7gOUlh14zg7xP5QZrKOjGbW3RdYY5LZplRO6icQD3lAY7CquCVdpIJQqT67yS8rObC4bpdvq+uFWTsCpNZqKreGog15eUIdAkcT3sO7sOOhLbQmNeohBh71Nm+6uRbmB3RhIvWMIn2+vqfuJXrzHoD1YSkHAnFBqZsvyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153083; c=relaxed/simple;
	bh=NttOc7eczXOtQ0KVx7t0Zvy0JsxDTFF40ADG9Ulw65c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3sfg0u1pPdzri05jkFOHmxG13m7xzftRO8TrjadKxfteowYgcl/euzIP76zk22kGYKa1XZS4bnZrxPB8W2hp25KZnrhM9IU6o4BssAQ7BNFtNs9fjD2W0oZDh+Aylv6/8WAFm5GdtHaGeau7gjXrHGS6nOaDnUmSqCDLwwLAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EArfsFLY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=50Coae5NR6FU87cPfowgVZGEde0sMWR7eCYkKTyNr38=; b=EArfsFLYn9Y3zmLBwGWAOPr/UX
	hB+Ku2xynsxZhBJX6gVNmS7Mu/Rb2a0dDlh/s7pi6PZyJyDfQxTPQAUt5cHnCVaw9p7wAkk6N5+sU
	8RQIlA1FbN/IPnPEQX+jD4y0nuQjpY4ExwmDercWEsp5m2KDdH8WsaGbNaaFR5sfMboPQcOfoz0xs
	LixujdvcQiCq808Ils5Mmd7V52Z10NCfrB5Qq0vOLuWriFpWbyrvyYE7gNvrSNS/Uo/bqAbTyDuKq
	yslY01GPsLNLDxHe6DBqcGKDBf3r9vjub5/NDCt+FVYSySDFO/Cn3c/fKYoRgRJXmR+ZV9ffS0BjR
	CMmPPHDQ==;
Received: from i53875aca.versanet.de ([83.135.90.202] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sgMyb-0007No-FO; Tue, 20 Aug 2024 13:24:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Mary Guillemard <mary.guillemard@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Mary Guillemard <mary.guillemard@collabora.com>
Subject: Re: [PATCH v3 2/2] drm/panfrost: Add cycle counter job requirement
Date: Tue, 20 Aug 2024 13:24:59 +0200
Message-ID: <2939807.SvYEEZNnvj@diego>
In-Reply-To: <20240819080224.24914-3-mary.guillemard@collabora.com>
References:
 <20240819080224.24914-1-mary.guillemard@collabora.com>
 <20240819080224.24914-3-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 19. August 2024, 10:02:23 CEST schrieb Mary Guillemard:
> Extend the uAPI with a new job requirement flag for cycle
> counters. This requirement is used by userland to indicate that a job
> requires cycle counters or system timestamp to be propagated. (for use
> with write value timestamp jobs)
> 
> We cannot enable cycle counters unconditionally as this would result in
> an increase of GPU power consumption. As a result, they should be left
> off unless required by the application.
> 
> If a job requires cycle counters or system timestamps propagation, we
> must enable cycle counting before issuing a job and disable it right
> after the job completes.
> 
> Since this extends the uAPI and because userland needs a way to advertise
> features like VK_KHR_shader_clock conditionally, we bumps the driver
> minor version.
> 
> v2:
> - Rework commit message
> - Squash uAPI changes and implementation in this commit
> - Simplify changes based on Steven Price comments
> 
> v3:
> - Add Steven Price r-b
> - Fix a codestyle issue
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
On a rk3588-tiger with matching MESA build and 
"RUSTICL_ENABLE=panfrost clpeak"

Tested-by: Heiko Stuebner <heiko@sntech.de>

Without this change, clpeak fails with
        clCreateCommandQueue (-35)

I guess this is mainly applicable to the timestamp part, but that is
partially in this commit too.


Heiko



