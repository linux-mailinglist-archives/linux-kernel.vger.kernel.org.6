Return-Path: <linux-kernel+bounces-414704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9351D9D2D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79BDB2D73D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CE51D0F41;
	Tue, 19 Nov 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFkNmuFI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115414A639;
	Tue, 19 Nov 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036500; cv=none; b=OLBhyLJ2P6Z8EkBVznhYJq+S+7gO1I6tV2FNqQEyMMwAc3aVBw7zH1G8F2AbIKPdo/uz+udv1DCu5VxwM3vfXZ1NKQFxcLFydh2HVej+isaNT/AJr6YgPoa0mgJJuC46M6dnYZb2Tx7KVHUNlJ4M6C+SZBCt9CNdujsyykiyDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036500; c=relaxed/simple;
	bh=GN8+TZ7dF+OVIe4W1EKDcGDnhm2IukYPViQYE4iYxxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6X8c2LaLiifQVJa/itHWIfdIUv75o0dx+HPfXFtEjboYNRONbtHoMkBAQzV2/m3ZZm0ush6YUafw1R+Hj/pwO7PlKdj+6NTwq+i2wvTgwFEmhslVSWOPZuXZXj6HlaKmvEKgJvmM5mrh7QitJRV/sOxmZN+OLIbixwGaqg+ptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFkNmuFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A576AC4CECF;
	Tue, 19 Nov 2024 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732036499;
	bh=GN8+TZ7dF+OVIe4W1EKDcGDnhm2IukYPViQYE4iYxxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFkNmuFI0VPYtiVbAwXPrbGkTuTUbPU6g9oXTqPo6Unhg+izBDfYIR4zM3nkFGI1k
	 oOxQL0b5JS3pJjPUiOjTrjYWA2LhN6xCyZYG2TZVtBzk08qRTJM0kJhbVJFuLT+VW/
	 TbQmcC8SQGV4WUvDYF6C76olltJCaKuhUdRU6eyQk3iiOFpM4i+xYfMVLKPrr1JBk1
	 S6/0JvVCpvknj1HblDsNHhUpBKeWvNX/SUyXyROAFV6tuaA2b25rdu9Im3V+XdZ+xt
	 GSV3+QDX00RH+S8AdpGtW6W0XHTOBzM5+xJt7+kqMmhoHHX1k5Tkh3vfidy5b+PNTa
	 KhiQvZ+qcSIcA==
Date: Tue, 19 Nov 2024 11:14:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
	kernel@collabora.com, Sandy Huang <hjc@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/5] dt-bindings: display: vop2: Add optional PLL clock
 properties
Message-ID: <173203649757.1839089.16877007589155949446.robh@kernel.org>
References: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
 <20241116-vop2-hdmi0-disp-modes-v1-1-2bca51db4898@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116-vop2-hdmi0-disp-modes-v1-1-2bca51db4898@collabora.com>


On Sat, 16 Nov 2024 20:22:32 +0200, Cristian Ciocaltea wrote:
> On RK3588, HDMI PHY PLL can be used as an alternative and more accurate
> pixel clock source for VOP2 video ports 0, 1 and 2.
> 
> Document the optional PLL clock properties corresponding to the two HDMI
> PHYs available on the SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


