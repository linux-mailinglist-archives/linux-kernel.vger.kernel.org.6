Return-Path: <linux-kernel+bounces-380625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09D9AF3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1AB1C2206B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779332141D0;
	Thu, 24 Oct 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBZVXSmQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837BB658;
	Thu, 24 Oct 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802438; cv=none; b=PKdAwIh2Z76GCx4CbKWoBisAYTDgcHnzYPyMpjFHoD6q6yaCCz21dB0Ywgtiv0t1iofXGxrRy9aqApq9YTHWUK6JBCf/OKn0e1V0hyipzuzZGDUPojG3ul4m8wLhNrUpHuJ9rwVmmvRVFVsW6ojQGbBGUn1KCxh//bXJxEe8jsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802438; c=relaxed/simple;
	bh=X5N77Rrxi4T/tH4H721m+E/6JRcxmNxBwaisxQYuV0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2sq24o21m3yQUQbxANcu9a5ZsZi6OLKTtBZlbDB7gEKi8zBBrk6eo90DPyPa2AErhVztIDc3ugq7ynXE/G9PVou1oY9AUYVYoeR7a1w4o52ZCDUjH3XfAy5pe9+V7999cQDni5YxFx8nv4q4C618oIhY8E8fsORs7vsjzKr49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBZVXSmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EFBC4CEC7;
	Thu, 24 Oct 2024 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729802438;
	bh=X5N77Rrxi4T/tH4H721m+E/6JRcxmNxBwaisxQYuV0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBZVXSmQecnpNoesTgGk48A0ZJBBDRZnqtcfGptGRPQUL5PoNy+Z/W5XIYVQIViys
	 GMIUOs3CIht4iQBKxF9qvuN40GrPbrRaewQdib1IE7H+lVyAlO6OFHi0kTxA7GjHSl
	 hwoN81yXgLgorvQj34+XffNfAOoo/e2+WAj6OwkMWwpFmnip9r+mQbH6XZypFHhme2
	 ZVa2DCcWLsPoHxKJRYoa6cUwYCx1iZV92pbcBlbciHuuvHrj68D28bfUaYMH2WTpDM
	 Z8PQUZER5Dqdf+2+8slEF80cZRllolc1HZ8ku6kTvP0eusDr6QBido6DH1QaGvdrxn
	 ohwdWQ1/yVz0Q==
Date: Thu, 24 Oct 2024 15:40:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
	linux-clk@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Will Deacon <will@kernel.org>, linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 05/37] dt-bindings: display: Add BCM2712 HVS bindings
Message-ID: <172980243679.1012695.11368075486894894542.robh@kernel.org>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <20241023-drm-vc4-2712-support-v1-5-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-5-1cc2d5594907@raspberrypi.com>


On Wed, 23 Oct 2024 17:50:02 +0100, Dave Stevenson wrote:
> From: Maxime Ripard <mripard@kernel.org>
> 
> The BCM2712 has a completely different HVS than the previous
> generations, so let's add a new compatible for it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


