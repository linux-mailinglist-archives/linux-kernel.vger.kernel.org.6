Return-Path: <linux-kernel+bounces-553688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5DA58D83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34ECE16691A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4336222591;
	Mon, 10 Mar 2025 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtWd4NZP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE93D3B3;
	Mon, 10 Mar 2025 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593702; cv=none; b=SJoWXhjpXGvK+mswMxN4YrIZCb8KFqwyoH0tn9Fuq6ZZGUHK3Ha543QZetZ33CS3PwxxqQHc1t4NsuWBL110TTu4BCyVvCheORaSA/NcKxi6qjD5V8Re/KVCnqjHSELe9mOn5pAliCW9F4kxOexaASxWY122+Rgg50FGZKIeh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593702; c=relaxed/simple;
	bh=SgbV9vkf5gWdeet1ixM7l/2JY/O0uXS4dGet0e+/f8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCfz+8BWEk/kkBlTc682t68/Cn8O513Ow+jVRkUpPxQif/B5VRwCmvOWmE/S2xptpS2uzP3/ZUuAHIysmVgDpKugCDGZpSMPY98XZhZim2dJsFFJ+bgC+PBfgwYZFxRLH1jQnN0F9gFSQqFKoGnUElLpngrUAY9Goqms7XJU+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtWd4NZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46415C4CEE5;
	Mon, 10 Mar 2025 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741593702;
	bh=SgbV9vkf5gWdeet1ixM7l/2JY/O0uXS4dGet0e+/f8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtWd4NZPf+ZQCKHgSKtdnYwA9r6lQF/EG0VXxntkjUKRXlqji0VpZ295K8bBUYAc9
	 HJaHYQE5SI9Xv2mGnM/z6WgOzhMydd7bKUkSBMtXBHc7xji6ZPMDAuLgLd6TQSlsD8
	 d9Lk6PJCHaSIXC9wKosIeE3v5ejpPqa7gZmm38Dv7+pszKhyus6HIgsIQ3QaB/if8a
	 c35uXlM60THUXS2738WqQdsnyEr5YYpkvfmQIScGsJRmystjNVnh4bFhX/2p+cbfnO
	 c4s+vzP4x2Ibc++SrxvoPNZTuDJJsi1ndEFVF6Vw8S3/r4MncBB4yqi9YxhCz3GmmY
	 CT4AzO2dOi9Jw==
Date: Mon, 10 Mar 2025 09:01:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 05/13] dt-bindings: mfd: add Documentation for Airoha
 EN7581 SCU
Message-ID: <20250310-excellent-quokka-of-abracadabra-15ad69@krzk-bin>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309132959.19045-6-ansuelsmth@gmail.com>

On Sun, Mar 09, 2025 at 02:29:36PM +0100, Christian Marangi wrote:
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/airoha,scu-ssr.h>
> +
> +    system-controller@1fb00000 {
> +        compatible = "airoha,en7581-scu-sysctl", "syscon", "simple-mfd";
> +        reg = <0x1fb00000 0x970>;
> +
> +        clock-controller {
> +            compatible = "airoha,en7581-scu";
> +

No resources here, so this is part of the parent.

> +            #clock-cells = <1>;
> +            #reset-cells = <1>;
> +        };
> +
> +        system-controller {
> +            compatible = "airoha,an7581-scu-ssr";

No, this was told many times - you do not have resources here, so no
chhild.

Best regards,
Krzysztof


