Return-Path: <linux-kernel+bounces-557712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F2A5DCCA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7C13B333E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5124292B;
	Wed, 12 Mar 2025 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg3zgQDi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A821E489;
	Wed, 12 Mar 2025 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783040; cv=none; b=j8Q0kCQkL7bGzFuxmkF0Zs5p7JwAKFOnqqa83Fhjk7O2/Cr/eAPrIkYlMfIykiZM+n6bqcvKqVKkT92jkJ95kdWvjxIfYuBO5FoA+LkxsJgV26VdSWd0qpxEYbHjuWfM5/JErxtt5sATdkfd4vLzS3ulnHse5vaxDGiPHDr6WR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783040; c=relaxed/simple;
	bh=vvNzffstuwygGjee35zDwvBmfUgaXFHHwZ2Xz1A5mtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9Uh2K32Mtu0tfd2YXt/CHsFyqQRRnPiG2Sl0fUazgvtzaGBb0aqcrIUMvPaJRh7Bj1gOjNVBbcbnMmawjWFQisi/NRJeJgC18HoZivnbZNtCDCaU/EJGOuBfxUuUyCbch4D53frko08b5935L6mxEmY3ZqKPEMTGMZnoabi0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg3zgQDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C7CC4CEE3;
	Wed, 12 Mar 2025 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741783039;
	bh=vvNzffstuwygGjee35zDwvBmfUgaXFHHwZ2Xz1A5mtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dg3zgQDimqxkZGwQ+jX0wY/gkyMSZMYLM/f2OtJd2EkKo0LQ2Ol/Khgl5K5GaQgAZ
	 84tP38YE4v8MWusDPAeOqRLDVOYcfUVh5ld8w+jBXYK39u3hLdyLTi3P9ajw/VWRuc
	 WRu9xUHstvcJIDArziIPANizCLNsdM5h3ngqQ8zBo7nB1L6C392F+HxqcwCvKA9tI2
	 /P7Pl9QLsxbPPy/NfW8yUdfeo37T5Tx2z+k+4ags1cW4mjRSaWQ8F8EoBuhY1axAp0
	 o9BOJHPQ/lBBcXPU0fZLTMTpGntEuK5pR+Y1IZZRQQsFFu91Ip6fv3mDT1UGx+BOGw
	 +83kRBHdPVxsQ==
Date: Wed, 12 Mar 2025 14:37:13 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, mripard@kernel.org, 
	cristian.ciocaltea@collabora.com, neil.armstrong@linaro.org, yubing.zhang@rock-chips.com, 
	krzk+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org, sebastian.reichel@collabora.com, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 3/7] drm/rockchip: Add RK3588 DPTX output support
Message-ID: <m2376n5bdptphdbyxxqvgeouspn7vslucprgzu25shoajzndy3@gfxh3b2poiic>
References: <20250312104214.525242-1-andyshrk@163.com>
 <20250312104214.525242-4-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312104214.525242-4-andyshrk@163.com>

On Wed, Mar 12, 2025 at 06:42:04PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add driver extension for Synopsys DesignWare DPTX IP used
> on Rockchip RK3588 SoC.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - no include uapi path
> - switch to drmm_encoder_init

Acked-by: Dmitry Baryshkov <lumag@kernel.org>
> 
-- 
With best wishes
Dmitry

