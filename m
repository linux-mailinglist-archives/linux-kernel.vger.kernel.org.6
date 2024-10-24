Return-Path: <linux-kernel+bounces-380629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCCD9AF3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35320282A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C32170C4;
	Thu, 24 Oct 2024 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8vXDmco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40B1AF0B4;
	Thu, 24 Oct 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802496; cv=none; b=M7uCeGS/hkBY9zH7HR2raXyrLBY160Gx6F5tTKmMVLsP1bPs+r1KnA8KMrNlGJTzY9H6xwNDDu7MPZquPyFeStxJGWzyEXWEJKSZ+dRuVl2Met/Bcx9t8sT6Nyt1wRqXPmYbt7udlTtHw3vDLjPmHflv73IQ+LV3e+zFBB0FZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802496; c=relaxed/simple;
	bh=2DFjeejvSg1/g8YEFkWGIl9SUrFAuPI0K/9R2+B0tbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj9al66QboCeQym/gxrHXE9+pxzbdDim/14A8ylIHMKn0afB+XnNv1OdayVkMB83mhNFC3CUjC6Bw8oEX1Zm23WzTVsDDsQzwAngFLhClQfMTVEHMOT/xz7cR1InHyM/dtEhauR/C2lkNkjNDT7Ra/1miknzuFio2MKspN3Gz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8vXDmco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08A8C4CEC7;
	Thu, 24 Oct 2024 20:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729802495;
	bh=2DFjeejvSg1/g8YEFkWGIl9SUrFAuPI0K/9R2+B0tbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8vXDmcopDAg+E6IfwWfxt1SIi2OTrV+p57757L56J6DkFbVeASNzKsKhgbKtVMR+
	 m4FKkc6IoNmfyY4eoY830QK2WvC/1QV4hHcVfH++XYiy3yIsslT3e3VpANdo8YoyEr
	 gd5OnOjtpOGjEQy1akqGvger/7vuEbbFGryxT/8uikHxKosd9V1f28Yc/EF3wf4r4K
	 pTWRIjm8aynFXwoszlvKl81h+ii9bGjFQc509GWr5VCMYT8uMc9P0TfIyeorO0WKkK
	 LE5FxJ4J+9E3cnmu5qK8vOfsaVYyDtqyUYcgdpGGvzcmWglnHHI0R6i8/PNqGWvFLX
	 aRdDlFd3jc+jw==
Date: Thu, 24 Oct 2024 15:41:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	Ray Jui <rjui@broadcom.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	linux-rpi-kernel@lists.infradead.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 08/37] dt-bindings: display: Add BCM2712 MOPLET bindings
Message-ID: <172980249374.1014064.8269086234792348096.robh@kernel.org>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <20241023-drm-vc4-2712-support-v1-8-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-8-1cc2d5594907@raspberrypi.com>


On Wed, 23 Oct 2024 17:50:05 +0100, Dave Stevenson wrote:
> From: Maxime Ripard <mripard@kernel.org>
> 
> The BCM2712 has a MOPLET controller which is basically a TXP without the
> transpose feature.
> 
> Express that by adding a new compatible for it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


