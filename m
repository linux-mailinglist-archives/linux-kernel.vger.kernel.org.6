Return-Path: <linux-kernel+bounces-512592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB90A33B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CAD3A2202
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E6620D513;
	Thu, 13 Feb 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydj57Rjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124620C469;
	Thu, 13 Feb 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439346; cv=none; b=ch61MO6KV4ahhBE9TSoJ3n38kD8IyjcilQVf0CIvEkk6I5TtyysZKsSDS4HzoI2C4L+4KYnDVjgaQlkTpYhV5DHO+I1mJjAZ1SZniy1QcYsxcLOo971Xo06a3mTh77ZvwgYaxEKt0BgUba05azhA2cVQqDmfbOQBfKNGkoO1lGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439346; c=relaxed/simple;
	bh=jXd6q8MdvVTJsbxDcyPyBVc+ukySTPmELhYgRQ1zVLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FieO/6D/TniIpSB6AQSewwslzYaLz27B00gNVybo8FQzSoDJiP1uzNUUX/52ZAy1iy25dobHdYvDJX3dkEwR/8kcyOlaNaNk7PjRF+Kjh3mhMwX70shnCtotrESZ9BzQEkYwrbXpKu4LR6XcrM/3yQjZM14L01CQzryHlOTxJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydj57Rjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD55C4CED1;
	Thu, 13 Feb 2025 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739439345;
	bh=jXd6q8MdvVTJsbxDcyPyBVc+ukySTPmELhYgRQ1zVLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ydj57RjjLQGej3cV3egCohLYw64CmAREuReZ5ZSKdyHlAP7wp6SnwxEW0C92IhAOh
	 tzyVpKqdVZsaNCSrngFrVmfA0q6d98S0JiNUIxlOBzmtBxdQSPM7W3GCNBWy7xw/Zq
	 rOABdNsSRtNE9FehSGDxIa0IK/LB4pFQrG5ACsVgHf3ExUVN1G4QXEm6uep0MNEEXi
	 UnKmrQBpbPatxyuS0eGWcw9EooABxJTB2s+w4RN5ER2riaNlBzCD9yZIbZVhpgJ7Gr
	 BWYhKaTv6Tv0bgsnmxlKpTd6BLnuBngZaADQknPxssItLk/4shJsWcVpHyQDWKFB0S
	 jsMKrKdVp2qpA==
Date: Thu, 13 Feb 2025 10:35:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: reset: add generic bit reset controller
Message-ID: <20250213-cordial-elated-grebe-57aaae@krzk-bin>
References: <20250213020900.745551-1-inochiama@gmail.com>
 <20250213020900.745551-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213020900.745551-2-inochiama@gmail.com>

On Thu, Feb 13, 2025 at 10:08:54AM +0800, Inochi Amaoto wrote:
> Some SoCs from Aspeed, Allwinner, Sophgo and Synopsys have
> a simple reset controller by toggling bit. It is a hard time
> for each device to add its own compatible to the driver.
> Since this device share a common design, it is possible to
> add a common device to reduce these unnecessary change.

SoC components are rarely that simple and even if it is just a bit,
usually it is part of one or few registers.

Anyway, there are already bindings for reset-simple and I do not
understand why this has to be duplicated.

> 
> Add common binding for these kind generic reset controller.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/reset/reset-simple.yaml          | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/reset-simple.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/reset-simple.yaml b/Documentation/devicetree/bindings/reset/reset-simple.yaml
> new file mode 100644
> index 000000000000..77584e23e8e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/reset-simple.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/reset-simple.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic BIT Reset Controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +description:
> +  Some reset controller devices uses a simple method to perform
> +  assert/deassert by toggling bit. Some SoCs from Aspeed, Allwinner,
> +  Sophgo and Synopsys have this kind of reset controller instances.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - reset-simple-high
> +      - reset-simple-low

It would be one compatible and set of properties describing resets.

Best regards,
Krzysztof


