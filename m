Return-Path: <linux-kernel+bounces-184182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C865F8CA3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D02C1F21EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF29139CEB;
	Mon, 20 May 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1Li+VzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0B1D531;
	Mon, 20 May 2024 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239133; cv=none; b=C8E4PgqKIGtLgneVlxxxGWuH4AJtTkYaHO3bstD7AmOH3WsZ61i5fvw3gAy8Dvb+f2F5jvAvh4K0eWdwEX0pn0Hlm7Px3JlfUZNE6AAzOKkLJrGqJbT2oIiTILd5kr9OG7JiovMOoJm+ZqvF/VWXeWvuGRlxeq/IJXmMo4PIxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239133; c=relaxed/simple;
	bh=wKrqbrbcLS0ty3ta4Fz+PTIydCfOBtp4hZWaaDhE8Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBelZ1MY/CY2T6C9Eulis6Bxlin2vOuIsGdkbJ3ogngalOTZg65Jm/vdpGKeXEdngGkwOhTwVNzatt73B35y2rbb/XbifWnC8pgelpAtvvQqjFvisJrT10SaXTG+FEuAxDrTamyYt/gLdMVZaUjczju+GXhIeQjV0CNzDUbqlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1Li+VzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCF3C2BD10;
	Mon, 20 May 2024 21:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716239133;
	bh=wKrqbrbcLS0ty3ta4Fz+PTIydCfOBtp4hZWaaDhE8Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1Li+VzIwBX4VZ6MRkqIGkMQu/mvlZ/THcYVm69WA7SSv0lqPRKKvkZFzqxT7/VZo
	 KwdW67iJoFR+WvztOXdRSiGPfVgc81pcPVJOSY9t+RDfLvAABfiYUxtDrmnljjZUdR
	 OcSDi99WueHO5ur1G6EYFAW8pSNRF9gdoSLaLpBdwkuANji/PWCwy7MMgiMRzI5Qyf
	 0pIpRyEabBrQTQBLnuXDCWZv4yJjYa/Fs6GVvH5d6NTKpJRtpXoYy2HQnttUfHJa68
	 8h37zpUPoK2Wnu1/38Qx2OpwQ7PZQlFJKawLMW8LW45srp5cBJajl9Rec/zte6TI5c
	 1A9tBqyj0EU+A==
Date: Mon, 20 May 2024 16:05:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Nishanth Menon <nm@ti.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Daniel Machon <daniel.machon@microchip.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 1/8] dt-bindings: mfd: syscon: Drop hwlocks
Message-ID: <171623912890.1499407.12141677897291152104.robh@kernel.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
 <20240519-dt-bindings-mfd-syscon-split-v1-1-aaf996e2313a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-1-aaf996e2313a@linaro.org>


On Sun, 19 May 2024 20:42:16 +0200, Krzysztof Kozlowski wrote:
> Apparently there is no in-tree DTS syscon node having hwlocks, so drop
> the property to simplify the binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 5 -----
>  1 file changed, 5 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


