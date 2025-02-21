Return-Path: <linux-kernel+bounces-525226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9FAA3ECBB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF7D175A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8301FC0FC;
	Fri, 21 Feb 2025 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVifSG+f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635F1F4262
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740118515; cv=none; b=mruISmU286Sus4VcyGfZ9SxyTjXI92hvCtZ0Cjc5Ai1IN2vYcZ4b0ZFDDYavvcOrBmYZVV4JcDNtKUJ/7rBi6/qlRtO+C5To0MEY8LM9vOPLwOD5e33wAy+ju2k5hUn/7aY+8X8KPzldpk5JqfTaBwRTpFOC5p6E2tyrdfjfmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740118515; c=relaxed/simple;
	bh=TNEPPBEWgJ1Kqz7U9WT5DXUrTiqsvq3N42p4JeVhfvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib8pRynAOpQtSFPzlmkirBYyaGoGw3bbCim052MmYjmUHnOw+Y2ZTk5vA0lD1yU3SL0S0CCUDgPDxjn6nLP3awkYGDKR32ZKTkpo/2tEz7GjSKkYWzuv68wEINMTWQcNNa7F2YNl2yBucAxh91I8eMMz5/l2Whfi/febq8EUgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gVifSG+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD440C4CEE2;
	Fri, 21 Feb 2025 06:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740118514;
	bh=TNEPPBEWgJ1Kqz7U9WT5DXUrTiqsvq3N42p4JeVhfvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVifSG+f0bxi6tkq9WGtsxqoZkGLInTFdg5jmOduZAx8ebkuCQdysZekvfztvFCm3
	 QB02DbBzyg2CPIaIg1SK04s/BUyG/Cj/reO6qE+B+WHJqYimvryS3TjuxutXp08Nnw
	 +eePKs2csULAR6GdtygHf6F5aUAjxUkVuqL7aoAE=
Date: Fri, 21 Feb 2025 07:14:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: rafael@kernel.org, dakr@kernel.org, hjc@rock-chips.com,
	andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de
Subject: Re: [PATCH 1/2] drivers: base: component: add function to query the
 bound status
Message-ID: <2025022153-outdoors-snugly-3967@gregkh>
References: <20250220234141.2788785-1-heiko@sntech.de>
 <20250220234141.2788785-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220234141.2788785-2-heiko@sntech.de>

On Fri, Feb 21, 2025 at 12:41:40AM +0100, Heiko Stuebner wrote:
> The component helpers already expose the bound status in debugfs, but at
> times it might be necessary to also check that state in the kernel and
> act differently depending on the result.
> 
> For example the shutdown handler of a drm-driver might need to stop
> a whole output pipeline if the drm device is up and running, but may
> run into problems if that drm-device has never been set up before,
> for example because the binding deferred.
> 
> So add a little helper that returns the bound status for a componet
> device.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/base/component.c  | 14 ++++++++++++++
>  include/linux/component.h |  4 +++-
>  2 files changed, 17 insertions(+), 1 deletion(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

