Return-Path: <linux-kernel+bounces-573631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD297A6D9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3052016B91A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696A25E81C;
	Mon, 24 Mar 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="rDbmyv6v";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="WKaMpdNi"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9D25C71A;
	Mon, 24 Mar 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818879; cv=none; b=N6IOCfX3WFpaNRt2DJrqIM4bYwv1Yvcp6LAvqX3+BwPDwQQyAUfiDGatYv+WzUAcKJkIEkg2yC++rqzFWZQ2aWCuDuLkUFOeialKrU8fGLL6jMVdXXQBpMRpm4ImRkXmdYjMSPcaiK3oCYaH6gFHEnJUoiywx3aMcKmBtLVZ3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818879; c=relaxed/simple;
	bh=9gpFd8EFx60nBxNFMoV0usv+BAC3zxeWfcnDeFxbqxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQhubFdBeacUp73R60WjnnBA1v/GRkhizmKOtPiTchOgymwWD8O6YM7Tv5g8vppIbwixN1TS40s5CVYV7kZmv8614RX9bSIL7l72ljJ4vcVNJCPG0iduq5e/vfnYnQZ6FIAiSdVoNv1mpmmrFafy3D7syr1jKT/NwIC213DYZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=rDbmyv6v; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=WKaMpdNi; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id B3637EC59FA;
	Mon, 24 Mar 2025 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1742818874; bh=9gpFd8EFx60nBxNFMoV0usv+BAC3zxeWfcnDeFxbqxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDbmyv6vIYVR4mO3RtZFWbK2+WP/H3WVLmsa5FJ9uNKgtGEb+SL3kMQo4Fnv4nVHf
	 wmOyvW81EIWY2wwa6lRqcnC7SrSFjU8+56R2qa9PNSGBE9GUAGJp7bfUKbsSiuezMM
	 +HGX90qUPKmNEsaoMroHF+qzA8ksiYt0pfdGVmNyKX9Sm6oDI87CCQsF3cPE7P8Cci
	 SdMlddqRc9LMcXW76hxh02VTKMw2QtXC7mKPxC1GsGzmmL/yNK77y5a6h8yep5Nvvb
	 K7+oISqlEPE2XiUFtAo73s/ej8k5uNvtKueS+OraDQK/7XwtAbBk5gC2jQe6jd7KnV
	 svZwHSRWFsyRQ==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSqTSPtA-cE2; Mon, 24 Mar 2025 05:21:13 -0700 (PDT)
Received: from ketchup (unknown [183.217.80.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id A56AEEC59F0;
	Mon, 24 Mar 2025 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1742818865; bh=9gpFd8EFx60nBxNFMoV0usv+BAC3zxeWfcnDeFxbqxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKaMpdNisRVneY5YjfL44Z9h1qM+1S/RZ/juY/PjwDLMi8svonxhF8S65hOXoZT4n
	 Yeh7TYUS5Bgl/2Q6CBHJ09DUIZhAjsfRKEG1jCTNwqzTC+AWoYWmZHOiXdsPzhSEnr
	 3aAPSl+cZ6eEz8SZoopFeidMCnwhq24C85M9qyy1FT/qt9wEYxJaWzXHB/762GkWkH
	 OOK4riQLivvaYP+ECV2jv9AT0iiaDPwwTINBtsSCyncm5081eJL+SdciOvReu9hXj9
	 pvvtu5hQQVQHcKS8GHN7Rlkod1B8eyr4/Anmn3uXRK+nKHivgiYlhn+v4ZOGBMBfvp
	 wSYqGy8b5Osng==
Date: Mon, 24 Mar 2025 12:20:52 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Alex Elder <elder@riscstar.com>, p.zabel@pengutronix.de,
	mturquette@baylibre.com, sboyd@kernel.org, dlan@gentoo.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	guodong@riscstar.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/7] clk: spacemit: add reset controller support
Message-ID: <Z-FOJFHOsU_dLkmS@ketchup>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321151831.623575-4-elder@riscstar.com>

On Fri, Mar 21, 2025 at 10:18:26AM -0500, Alex Elder wrote:
> Define ccu_reset_data as a structure that contains the constant
> register offset and bitmasks used to assert and deassert a reset
> control on a SpacemiT K1 CCU. Define ccu_reset_controller_data as
> a structure that contains the address of an array of those structures
> and a count of the number of elements in the array.
> 
> Add a pointer to a ccu_reset_controller_data structure to the
> k1_ccu_data structure.  Reset support is optional for SpacemiT CCUs;
> the new pointer field will be null for CCUs without any resets.
> 
> Finally, define a new ccu_reset_controller structure, which (for
> a CCU with resets) contains a pointer to the constant reset data,
> the regmap to be used for the controller, and an embedded a reset
> controller structure.
> 
> Each reset control is asserted or deasserted by updating bits in
> a register.  The bits used are defined by an assert mask and a
> deassert mask.  In some cases, one (non-zero) mask asserts reset
> and a different (non-zero) mask deasserts it.  Otherwise one mask
> is nonzero, and the other is zero.  Either way, the bits in
> both masks are cleared, then either the assert mask or the deassert
> mask is set in a register to affect the state of a reset control.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/clk/spacemit/ccu-k1.c | 93 +++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index f7367271396a0..6d879411c6c05 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c

...

> +static int
> +k1_rst_update(struct reset_controller_dev *rcdev, unsigned long id, bool assert)
> +{
> +	struct ccu_reset_controller *controller = rcdev_to_controller(rcdev);
> +	struct regmap *regmap = controller->regmap;
> +	const struct ccu_reset_data *data;
> +	u32 val;
> +	int ret;
> +
> +	data = &controller->data->data[id];
> +
> +	ret = regmap_read(regmap, data->offset, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~(data->assert_mask | data->deassert_mask);
> +	val |= assert ? data->assert_mask : data->deassert_mask;
> +
> +	return regmap_write(regmap, data->offset, val);
> +}

I don't think it's safe to write the regmap based on a value read
earlier without the regmap's inner lock held: it's totally fine for the
clock part to issue an update of the register at the same time. Without
knowledge on it, reset code may rollback the clock bits written by clock
code earlier to the original value. That's why I keep using ccu_update()
everywhere and dropped ccu_write().

Thanks,
Haylen Chu

