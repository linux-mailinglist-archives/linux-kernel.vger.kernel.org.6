Return-Path: <linux-kernel+bounces-284195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F1194FE30
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247A0284C90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EBD44393;
	Tue, 13 Aug 2024 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sntech.de header.i=@sntech.de header.b="XE9kD1V6"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D175446D2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532432; cv=none; b=e/1C5r8+J5P/3HpH/dfjrPLCcL1lGjphEu0hwRTojZA/w46YS9XlLeAWoJ5Dquk7n/ub+2/iZFqC7SodRum8cs4MKDSw88L3E6dTvbUOVjekf06RPrxi+2qJ5Nzn7vcrDBMGJbjVS/vjm9vyxIvPuxYwGkWMRKlHyV89h80EIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532432; c=relaxed/simple;
	bh=LSxHZ07rtjUyo8ONisjEbwmYO71EcBK9cftWxGowucw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMeVlky6XH2eeaRjGN83MczXEiJ2IYwmiNq2ok/qw/+P+wYP/lbhXYEjFQOuBcougnYY0Q1sEoB2XVPmH6qIHCHdDXxJD4kVt9/0gTi0NaaP0A9ML5VBlF9O7sBjjbZM1PU3WQb53Mc+rUOWoGlENxXReQK2Nk1424BOEVbJXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=fail (0-bit key) header.d=sntech.de header.i=@sntech.de header.b=XE9kD1V6 reason="key not found in DNS"; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HXz7qGN0/o3zPJNVxlpTDW7BW/yyxunHThT/lBkN8VA=; b=XE9kD1V63K1TBa4/I6elX/cU7K
	70RqYBcc6QbOm2dxc73h+bmeJQNgQLOajUFd3UdUndSMR8c5Fbz21bQA5c/DTO4+VOzxyrSInM9Ms
	yn0nVEApM0X7z9SLrVFGTVUMmCJo5BFf00XPVlADk63Y3+Oqeg6HFNpNPjHaeZbmqeRpwn7QqVjVp
	XQo7kknttetcjH5z+BJcpv5PF1uoYR/I7w0ACoh4Xhx63hPAeU8c0GIN39vxDxgL0QvbSJGhilDnA
	IbGt4j9fx80x70QqhczyIlu/omyO5hOfpg/tcyZQyxTYj0+P5xXYnhNgcmJl31Fv6txyC6p0yfZY7
	demfF+sg==;
Received: from i53875b02.versanet.de ([83.135.91.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sdlVx-0008QV-Hq; Tue, 13 Aug 2024 09:00:17 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Christopher Healy <healych@amazon.com>,
 Mary Guillemard <mary.guillemard@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Mary Guillemard <mary.guillemard@collabora.com>
Subject: Re: [PATCH v2] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Date: Tue, 13 Aug 2024 09:00:14 +0200
Message-ID: <2629633.VnKG3xVv5R@diego>
In-Reply-To: <20240812122814.177544-2-mary.guillemard@collabora.com>
References: <20240812122814.177544-2-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Montag, 12. August 2024, 14:28:15 CEST schrieb Mary Guillemard:
> Expose timestamp information supported by the GPU with a new device
> query.
> 
> Mali uses an external timer as GPU system time. On ARM, this is wired to
> the generic arch timer so we wire cntfrq_el0 as device frequency.
> 
> This new uAPI will be used in Mesa to implement timestamp queries and
> VK_KHR_calibrated_timestamps.
> 
> Since this extends the uAPI and because userland needs a way to advertise
> those features conditionally, this also bumps the driver minor version.
> 
> v2:
> - Rewrote to use GPU timestamp register
> - Added timestamp_offset to drm_panthor_timestamp_info
> - Add missing include for arch_timer_get_cntfrq
> - Rework commit message
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>

I can't say much to the change itself, though did not see anything
obviously wrong with it. But I gave it a spin on one of my rk3588 boards
and together with the mesa change, it makes clpeak much more happy.

Where it originally failed to start at all due to not being able to create
its command-qeue and I had to resort to doing

        cl::CommandQueue queue = cl::CommandQueue(ctx, devices[d], 0/*CL_QUEUE_PROFILING_ENABLE*/);

the added profiling support from the timestamping is much appreciated.

Tested-by: Heiko Stuebner <heiko@sntech.de>


Thanks a lot
Heiko



