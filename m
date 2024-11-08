Return-Path: <linux-kernel+bounces-401595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184489C1CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D20B23A9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBCF1E573F;
	Fri,  8 Nov 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6bE0Jvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F697B3E1;
	Fri,  8 Nov 2024 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068165; cv=none; b=o0b3vvkc5LwUUfWKs9LO9bjh47O+NxJkOMmGFsv0F+NlzTz/xf1KdNyT4/1hWuff3iKJ0wzalzR8XFD/5MLzw5srjlt+QUpcjaClh4y1zXQyQxq3QTKuZFgzZDOM6E0yVuAA9usH62rsn3qqcHHjica+m8op8VnfvpiI3NqFZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068165; c=relaxed/simple;
	bh=zumeqdnWgfVudDgu2Wto+bNBu1U0drSMP3Z251G3Lyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RePFCaxLpqfCpOTDZ0Buipe72u5u/fYQ6jhOrp3nz1dbnGwGJgDAUgygYLt1/L+k3ciGI+d0kfUeZk70pzDJFvWMMgrpw5aE4OWRG7EA2bUvg6y1ZtVbmWvnFjfov/DyeMDejKDWIGssAjF5n0dXHBTiMDvGkx2vKiDX3BmtswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6bE0Jvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDD2C4CECE;
	Fri,  8 Nov 2024 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731068164;
	bh=zumeqdnWgfVudDgu2Wto+bNBu1U0drSMP3Z251G3Lyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6bE0Jvtry2SCdFKfLNO4drwuBYhL1WXlgfOnUqw+fHd8rIHKFinzksgVuS20W7YF
	 FZaEr/LnpYUoNKzbgfpY/AuL2Dh7xGN4lIno1HYQLmvs/HIXxfF1bd3I6dfHJAJXJy
	 9TEfvMfy7dZs+sAjDY9aTPhTUX8tbHtVOySriWmU0Z48H+AEj5E5YdEBkAR7Ur110h
	 bVGBtBpptEfKNZdm5b7qd5/CBm7xoOvHLTjRvw5pI0H6l6G/b/5C1GF6cFnzTxVU+7
	 D4XvFUGvQQ0j2LXK1RllPn7z489iLi8xaWqA/KFzr7S9zFib3eddNsgFixmO5RoKaY
	 MXv6vPt45NLSQ==
Date: Fri, 8 Nov 2024 13:16:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: clock: actions,owl-cmu: convert to YAML
Message-ID: <a4begcrmbtotl2imd3eaxpdveagvwridy6ev5zmwzvjqt3ovfq@wyj2dj73xe3e>
References: <20241107143431.728669-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107143431.728669-1-ivo.ivanov.ivanov1@gmail.com>

On Thu, Nov 07, 2024 at 04:34:31PM +0200, Ivaylo Ivanov wrote:
> Convert the Actions Semi Owl CMU bindings to DT schema.
> 
> Changes during conversion:
>  - Since all Actions Semi Owl SoCs utilize the internal low frequency
>    oscillator as a parent for some clocks, require it.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

I cannot add other people's tags - toolsets ignore it.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

...

> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description: |
> +  The Actions Semi Owl Clock Management Unit generates and supplies clock
> +  to various controllers within the SoC.
> +
> +  See also::

Single ':'.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


