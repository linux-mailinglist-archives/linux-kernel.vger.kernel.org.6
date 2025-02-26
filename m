Return-Path: <linux-kernel+bounces-534044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2BA46208
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB3A175133
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858622173C;
	Wed, 26 Feb 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KP+ssduJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5483209;
	Wed, 26 Feb 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579279; cv=none; b=jHEgW3IYPsAZvJ9IlZEJjff5S1URqhl72UYG54LgA+PRzuPk2mFoYASnwhKZtjHaEHTf3wkHkN516iJkgBpHyw3JLGJy/0e8H34ZwFqiqMCpyipHXBwvBHL3w6iJRIlj+HlNx/P1SYNNNGPXHKmZO1tBR9TjM6tIIA5R7mrVPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579279; c=relaxed/simple;
	bh=WnGKDVToiFp5+OKsdNZhHHiF3rAkYqZFvkZOqStCEdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o68h7BL9ldFRNrjIp8Wmq59qCb/NChi6ikBVCfPNsYYFidqjsTe+kx7Itn9IfqKvURFi3z1wdX73PfXD5YnPSpO3yk+Z9QtFF79qmuSsjRZZ0qS+VBUBbiyLqOVOjMCGPwdk1u7c+OHGFzP5R7Ika/64ncXrjNyMt6sKUMVilKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KP+ssduJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KvJGAbyWkcvedoLLc4FaW3JqrKOaqT7oAs2HApM74cQ=; b=KP+ssduJCcCljk3HCk1xztnkk3
	zS+GF9pbhbYxs31tkIc2o1qgOvBu73G6nQzg79jNujH4QtrV/x03B5kel06GZxwVlF4zqtsEz59p4
	ru+ycq0C3F+HcU8HRvffn8jqfbXLhQYlB/evrA589kvVMPsgnBKDNt5w82GcGfGRkMy8PdsroOFSz
	636143j44zLKs98WFAY6XFV11DqeZmGi/Z8eYumMznOW+xAbNtzwH0fzumWX2A8TB+ZXJi5AIUW14
	0UawrXNqsHTNcbdTLvHAIJ0D5AOQF89jh8mWGN1MckA15++rkbSjCzJ4fntz5Op3XSfGPuwfEgOUO
	oRwePrdA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnIBH-0000Xq-P2; Wed, 26 Feb 2025 15:14:35 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@cherry.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, dse@thaumatec.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH v3 3/3] arm64: dts: rockchip: add overlay for tiger-haikou
 video-demo adapter
Date: Wed, 26 Feb 2025 15:14:35 +0100
Message-ID: <12349849.zAa99ISigo@diego>
In-Reply-To: <20250226140942.3825223-4-heiko@sntech.de>
References:
 <20250226140942.3825223-1-heiko@sntech.de>
 <20250226140942.3825223-4-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 26. Februar 2025, 15:09:42 MEZ schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> This adds support for the video-demo-adapter DEVKIT ADDON CAM-TS-A01
> (https://embedded.cherry.de/product/development-kit/) for the Haikou
> devkit with Tiger RK3588 SoM.
> 
> The Video Demo adapter is an adapter connected to the fake PCIe slot
> labeled "Video Connector" on the Haikou devkit.
> 
> It's main feature is a Leadtek DSI-display with touchscreen and a camera
> (that is not supported yet). To drive these components a number of
> additional regulators are grouped on the adapter as well as a PCA9670
> gpio-expander to provide the needed additional gpio-lines.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

in v2 Quentin commented with a (which I forgot to add)

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>


> +	vcc1v8_video: regulator-vcc1v8-video {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8-video";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_baseboard>;
> +	};
> +
> +	vcc2v8_video: regulator-vcc2v8-video {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc2v8-video";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&vcc3v3_baseboard>;
> +	};

and suggested to add the additional regulators on that board, that are used
for the camera part that is unsupported right now.

If there is a v4, I'll probably add those.



