Return-Path: <linux-kernel+bounces-390104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583959B7589
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711F71C21B55
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D361814D44D;
	Thu, 31 Oct 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJiKM/1Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F81494D9;
	Thu, 31 Oct 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360583; cv=none; b=iMYGKtAclnNKGS6kEpROPdx0WE5WVZBBU2RYlzzLHVFyaykh+JRI2mxB8ndVLCieUQ3RFasHiJaebTicKzR0RvRxbbY9Qcu0Pxfk8dUEX75ufIqpMmreP9bn1Wz2c4qbVXFWS1qenD8rZs6X3dR3G9aw6fLl+WZOYS328yRJSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360583; c=relaxed/simple;
	bh=/fr/RCOTKkcjP8HRjhrvpenBY16uNK8okKks2lbsVx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+Iio72AHCqTMV0Vw3X4rdxioNM7KPCtW/00tcaw/KHD04R+rEVc2aqewgGnt5Fdi8pPAuMcKIhAPuh/JXZzgP51iKk1UQ1qoGR8P+SUaqxWyklMl6cKTVAFI+5j2CTETdLFP5zblt8BUYf8FWaIi6f0JJexhqmxyPmguWRVkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJiKM/1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1B2C4CEC3;
	Thu, 31 Oct 2024 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730360582;
	bh=/fr/RCOTKkcjP8HRjhrvpenBY16uNK8okKks2lbsVx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJiKM/1ZuU7wUrF0b140ekCe6P8inR6SEttAgNdjQ/Y2TdaGO8h+Vo+EPNMIZn0g/
	 3JZXPapVjfGRpXMmnyQ1Y6bemsf41w2Ke3Vblxdohycx+ezw9w5Aog6RPbIAT06VMF
	 0M/d3i1Vrf2GbqTpF3UX3zzpf2CaDpQZgguoUeI3EDfDYnmueQJYsxhotfdrr3Dh4n
	 gekaZEdpKvZ2tHXi44OBDPcguBygCIw/PtH03OdnicdnF1TYeaJ+cgfFKzuPcICWq8
	 L+fV0iF66Y25OnH5te0omnmQdCqKzMjpT5tiU3Y3vUP/j+fVDOZTSMT5EOS34mUycM
	 RjvhmMbca4uTw==
Date: Thu, 31 Oct 2024 08:42:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Yangtao Li <tiny.windzz@gmail.com>, Parthiban <parthiban@linumiz.com>, 
	Andre Przywara <andre.przywara@arm.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] dt-bindings: usb: sunxi-musb: Add A100
 compatible string
Message-ID: <a7dbx4ujgv2taovnycdy4sn2mggrwtkwhkxoyrilcns5qxepzh@szw4nv2y6tbk>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-6-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031070232.1793078-6-masterr3c0rd@epochal.quest>

On Thu, Oct 31, 2024 at 04:02:18AM -0300, Cody Eksal wrote:
> The A100 MUSB peripheral has 10 endpoints, and thus is compatible with
> the A33 version.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


