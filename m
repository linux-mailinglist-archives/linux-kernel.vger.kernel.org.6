Return-Path: <linux-kernel+bounces-553677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B458EA58D52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9233D188DA65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4442222AC;
	Mon, 10 Mar 2025 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQkIKmyF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3511CBA;
	Mon, 10 Mar 2025 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593259; cv=none; b=TINwbhj9NG315INH1x7/FvNBdBEuFVRAx9Srl/3TaZ1AnRIDDQqO5vVFgIRFhH5WuReLd3q05mt1tsnnkR0tQQQB+jKpeupth40jqq+sS4hvSsxmXBT2siKMI5Jbynvv/IJvO72eEXcFRuh1D0uuvUpCw4GyFK59pwQx+CgpqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593259; c=relaxed/simple;
	bh=IxPWphu3F+xLc4GiSypSOK76zaVHnRzhR45Z6VPd2NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svMgKm6Z5uedgPsTHBnPCiurYszvqf8oRUeRMrTnrjCvU+gQjWocZ+pmbukeaF8EeXLo05nBjZs39SCOD9zfRjrfojKvKECww95zHyDmbPciv4Xei4vzdefwJ9hXSButBn9BJMDaxd/lb5M+fqR+CFir9AeDj5pkyv5J9opmreU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQkIKmyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0263C4CEE5;
	Mon, 10 Mar 2025 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741593257;
	bh=IxPWphu3F+xLc4GiSypSOK76zaVHnRzhR45Z6VPd2NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQkIKmyFW93JJq+SgIA7Kse9XO9YgQMLKEKIqMmNnJSQgaZQ3nXDievCakMRQjSg4
	 z3hShvH+sQJGvYnAmuIrM1a3q6k2kop5itpDaYBvhABLaKfd4LXUaGU6UEiZf8uWIn
	 18W+/DjHirhmrCHl6zXDOZpoRmWfC1Tx4bgobW2s9J+04wO6DR6aztFTpOxOyTMpVf
	 KP2OQLwmA8Flik0e5pfZZj/QkkZ+v4XkeHamrJJupxPXofgO1Kkt0IRTnXpk4pZUUF
	 Ti4HK/VcgbT9uKGsxiFGRrwIRmzxZetqXTWEKsDBQatp+DDi4SNgEssK5pJf8FTZ+D
	 Vx+Zxv1IOq4rw==
Date: Mon, 10 Mar 2025 08:54:14 +0100
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
Subject: Re: [PATCH 03/13] dt-bindings: soc: airoha: add SCU SSR Serdes port
 binding
Message-ID: <20250310-ultraviolet-earthworm-of-honor-df114b@krzk-bin>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309132959.19045-4-ansuelsmth@gmail.com>

On Sun, Mar 09, 2025 at 02:29:34PM +0100, Christian Marangi wrote:
> Add Airoha AN7581 SCU SSR Serdes port binding to define what mode is
> supported by each Serdes port. These special binding are needed to
> identify and provide the port mode from any user driver.
> 
> These modes are mutually exclusive and driver needs to correctly
> validate the current mode for the Serdes port in use.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  MAINTAINERS                              |  6 ++++++
>  include/dt-bindings/soc/airoha,scu-ssr.h | 24 ++++++++++++++++++++++++

This should be squashed with the binding for the device.

Best regards,
Krzysztof


