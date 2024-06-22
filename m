Return-Path: <linux-kernel+bounces-225767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442E913518
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A321C2100F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C7170835;
	Sat, 22 Jun 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL8gc5+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E916FF3D;
	Sat, 22 Jun 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719074160; cv=none; b=dK0OB4QagvIbQUCPmQu6L6oEX6Y7IMtEHcuisUvTpUZiXQArjUWK64zhQsS1o5mQVwT/xE+cwIUyiEreWcfzkX4p88IkX5NOr3r4YUXG2S4us4GHyZQL0xF+MA9dyZ7x4qsnlhtu28eRhwD3FvQVPFAbtzeaQzSj0y/TPIR78tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719074160; c=relaxed/simple;
	bh=IqRPpntD7uRExF49cR8LxazBx/7ElPwSoGve1XYwmlQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=s7mDnjMZs+nC+4jbXWVqEMqmFJ4DmJvPyGyZ0tebUETGF27PV8US1Z+AAG2n4jCqj4sptQImrfl5JK61vyji6I3nd7E4zaryhnTfAQMnPpuG3jH9Ma2HEzOoCGve0dU6pBnlVhh8wxX7vHS+b7YFUPsjz1lrpp6d6jLX+weydRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL8gc5+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08074C32786;
	Sat, 22 Jun 2024 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719074160;
	bh=IqRPpntD7uRExF49cR8LxazBx/7ElPwSoGve1XYwmlQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kL8gc5+F+tJ530e3bK4OWPC/UkU6cQ7BVF2hgkPs4EtDctm6vcSmZ9k24R+wPr8AO
	 umlQI1t5gyL8O5xZzaYpGNp1XP6haEn7yhYoIZGJpp9eR++AM7v4eWXadmECjAe1h9
	 SC+M/dWoNJrBDD3CG7h+YaE1Q6mewxhkPkcC9lKh8hgUwuX4iRaO15JpBpDet0RZuP
	 5PiBhs/F+cJ3Q323HbTsMf0EiJr4z9Yzja7OYhd0zdEN4+mLVw/RaDCTDDPdr7Kl2Y
	 NagRR4l/8dXa0tpfZaLs7n3Pjbe14/QtwPRGIxphb0u5BM3/6YheQW4n8DSh9jTxk8
	 weA/M1DhcRYTQ==
Date: Sat, 22 Jun 2024 10:35:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240622150731.1105901-2-wens@kernel.org>
References: <20240622150731.1105901-1-wens@kernel.org>
 <20240622150731.1105901-2-wens@kernel.org>
Message-Id: <171907415897.1042829.2907756455868106157.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: sram: sunxi-sram: Add regulators
 child


On Sat, 22 Jun 2024 23:07:29 +0800, Chen-Yu Tsai wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> Some sunxi SoCs have in-package regulators controlled by a register in
> the system control MMIO block. Allow a child node for this regulator
> device in addition to SRAM child nodes.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../allwinner,sun4i-a10-system-control.yaml   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.example.dtb: syscon@3000000: regulators@3000150: False schema does not allow {'compatible': ['allwinner,sun20i-d1-system-ldos'], 'reg': [[50331984, 4]], 'ldoa': {'regulator-min-microvolt': [[1800000]], 'regulator-max-microvolt': [[1800000]]}, 'ldob': {'regulator-name': ['vcc-dram'], 'regulator-min-microvolt': [[1500000]], 'regulator-max-microvolt': [[1500000]]}}
	from schema $id: http://devicetree.org/schemas/sram/allwinner,sun4i-a10-system-control.yaml#
Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.example.dtb: /example-1/syscon@3000000/regulators@3000150: failed to match any schema with compatible: ['allwinner,sun20i-d1-system-ldos']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240622150731.1105901-2-wens@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


