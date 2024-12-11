Return-Path: <linux-kernel+bounces-441384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE19ECD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF8216A1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FF82368ED;
	Wed, 11 Dec 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oHUpMDpS"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6751BE238;
	Wed, 11 Dec 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924753; cv=none; b=qrsXWeW0oq34iN/c6umrDeSQAyfFVAkmasm9s+91xURyK4++H8oEeeC0WlzcHt8/adK6BbpJtbXPpE88+7NbN/yNVUGyamf+V96P6ZMHprjZioLBeO7Gwpm605fPgqbbwIlunu8OfMwnN6n+6GYtj/XzUYnM31mZj9Qf/AaeHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924753; c=relaxed/simple;
	bh=0U1VRPoACdi0jAnpo670BO5qJ6HBccQ97s6rfUtRIeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeOQzIjxAIdANcDLjKfcc6S5w1EnrEeCGXvd4m/03VFS81HRYOpNNIFKm59yAfr7BhVonhNbkPdllyrJCs+ErJprygdSAG8TTW3SamhJDUwmMvlB2UqegfCYBX5WaWFl6jlBAV5dTNJS11kb2zyaGPGBcyFp+l4OcTbVXRn9GuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oHUpMDpS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=970IYPSf/+JSlZzH0D0FgmfSU/u1z7o1WJTMRwGnFEE=; b=oHUpMDpSeptuYYndw5aK75LwhI
	rxAsOQKkfvbljRtAdBEsWAmL0NUV1hlzznUDEEQWb9jf7YD8wJ7EmrdEulGNm08Z/EpTzF7f0psJl
	4DG9WfSUS85tfAdVQ7qqE42bEXtetFTrsLMvTsMca5NTSLr8s037+/z4WBvqAfTqLaKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLN2A-0006Om-DP; Wed, 11 Dec 2024 14:45:46 +0100
Date: Wed, 11 Dec 2024 14:45:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 07/15] ARM: zynq: Add ethernet phy reset information to
 DT(zc702)
Message-ID: <8395fb6b-d7a5-4e2c-9eb3-4984b8c775c4@lunn.ch>
References: <cover.1733920873.git.michal.simek@amd.com>
 <9e18d59ca339804320d2a5e3c7362aefa3bb7c99.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e18d59ca339804320d2a5e3c7362aefa3bb7c99.1733920873.git.michal.simek@amd.com>

On Wed, Dec 11, 2024 at 01:41:26PM +0100, Michal Simek wrote:
> Added phy reset gpio information for gem0.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm/boot/dts/xilinx/zynq-zc702.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
> index 424e78f6c148..975385f4ac01 100644
> --- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
> @@ -79,6 +79,8 @@ &gem0 {
>  	phy-handle = <&ethernet_phy>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gem0_default>;
> +	phy-reset-gpio = <&gpio0 11 0>;
> +	phy-reset-active-low;

Hi Michal

Could you point me at code which actually implements these two
properties.

What is more normal is a reset-gpios property in the PHY node, or a
reset-gpios in the MDIO node.

	Andrew

