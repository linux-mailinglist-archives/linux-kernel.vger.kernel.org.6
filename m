Return-Path: <linux-kernel+bounces-293715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA7B95837B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AC5287BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CD818C904;
	Tue, 20 Aug 2024 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VGvCfN+v"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A118C932
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148085; cv=none; b=AJn0dsQRaZVRrmq4bvEP5FqW+JEsCPkYH2BqU+KQhyzmEfuA/O1vrux5cJEIpL+WpfLzQoD/qqg4J0Q6EGls1WPsXjeM82Pvtf2djyhr0XLc2r2pFP1HhfmQtreeh2Sm8SbCR5aqEwhZNC7yfXfRVfht3GJmo9kcRS7+YsWIynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148085; c=relaxed/simple;
	bh=ZY+2LmGq7kSsDU4/bgcmGnxVdIgzfJLp0UtF3d9Jboo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ey92rexFlWrQRZzChBiTJrZxYnH2qrmoluJYimLSD6P/BwMQavKgMbeN7Lb9ibeaREnJCRK1QeSiQydqaUfVksOvdtc7RRZuMYpOvPcIDSOKRRY7ln7FsndQxF3IL36nJo9p3bhdORJ5Pap0Y7Hx5kI7neU4qcYNzcouFJx46hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VGvCfN+v; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yHeSzm7/HHCH2jDaxOZ9inBw36886zNHiUb2ixdrSZE=; b=VGvCfN+vRQgkiRyJfQl2ec5B6v
	dc5TNo8fOgYHiJA/07D5L5owqToc/eMtF9m69QgtZAldyeoaYTd6uP4OoIk5DAU4bs+ZKZgzsYPyT
	yKaDzlaiqvQazEX3RPTu9ooud7HiH+ud6xkyNuhZIt66jU2EgR0Z59S8YYdxtdK7gkO28EABhmNrp
	PCLdUivx8knLTGFij8QQfiMuHl5aCgBiqk9H1B1aFNe9CxxtHf1+EDqXYwtxHMVRd2ApR5AyIaVhY
	HukcMXeXyuIQpo2MujbnaojIftu5skGBtIWW9+PbR0CZtLAPu8foyk+beecR8iBrBjnYaoLrgHi8H
	ZI9eq5kA==;
Received: from i53875aca.versanet.de ([83.135.90.202] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sgLg1-000717-2I; Tue, 20 Aug 2024 12:01:21 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Mary Guillemard <mary.guillemard@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Mary Guillemard <mary.guillemard@collabora.com>
Subject:
 Re: [PATCH v3 1/2] drm/panfrost: Add SYSTEM_TIMESTAMP and
 SYSTEM_TIMESTAMP_FREQUENCY parameters
Date: Tue, 20 Aug 2024 12:01:42 +0200
Message-ID: <7068759.18pcnM708K@diego>
In-Reply-To: <20240819080224.24914-2-mary.guillemard@collabora.com>
References:
 <20240819080224.24914-1-mary.guillemard@collabora.com>
 <20240819080224.24914-2-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 19. August 2024, 10:02:22 CEST schrieb Mary Guillemard:
> Expose system timestamp and frequency supported by the GPU.
> 
> Mali uses an external timer as GPU system time. On ARM, this is wired to
> the generic arch timer so we wire cntfrq_el0 as device frequency.
> 
> This new uAPI will be used in Mesa to implement timestamp queries and
> VK_KHR_calibrated_timestamps.
> 
> v2:
> - Rewrote to use GPU timestamp register
> - Add missing include for arch_timer_get_cntfrq
> - Rework commit message
> 
> v3:
> - Move panfrost_cycle_counter_get and panfrost_cycle_counter_put to
>   panfrost_ioctl_query_timestamp
> - Handle possible overflow in panfrost_timestamp_read
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>


On a rk3588-tiger with matching MESA build and 
"RUSTICL_ENABLE=panfrost clpeak"

Tested-by: Heiko Stuebner <heiko@sntech.de>

Without this change, clpeak fails with
	clCreateCommandQueue (-35)



