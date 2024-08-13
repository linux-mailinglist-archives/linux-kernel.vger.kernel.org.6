Return-Path: <linux-kernel+bounces-285414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F4950D20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AC81F21793
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F91A4F1A;
	Tue, 13 Aug 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwn8Pdob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2122F11;
	Tue, 13 Aug 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577346; cv=none; b=mdkHUn0HDNU7F0WpTwu1+h2h6iOhzMk3SjCXzPzZh7krI+wgDfzmno7Ez28OiOW6TVEdjIB1cXeV3nM2QakdUTWKkwbz7UqvDrQVauwwpIRCWU6DyvHw67cnCGw4dJR+R9QaC8bHj6tToMGK3Jfg/e0enZFb+do6T/HgW8Ngz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577346; c=relaxed/simple;
	bh=qXiUz9rk9Z1eDSfcjvPfQIY0OVlSkMuZkPOqueyerGg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LAz2dtyvkvuIZJsnQMfdPs0dD/ZNN1iSJn54Yegxn7GhTdCt5lT96sprHyGxVq7wsFc7GTW9jEXpkOTk248QIj1KDNB0xhbOSJd/IXoOKuyAfk/gejG/7jh3zPBYB8bGPt03HdBd/DrBh7jzZTxUYH2yoTX0HLf0KhaonTvtuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwn8Pdob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B38C32782;
	Tue, 13 Aug 2024 19:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723577346;
	bh=qXiUz9rk9Z1eDSfcjvPfQIY0OVlSkMuZkPOqueyerGg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uwn8PdobnZbcg2tOwfa0buGw2WcFqu4sD9uq0EKIAZhaRISzXwgBbeAJfFULh3Pk+
	 /YOR4ubYB2tGlVHmUFgCz1krQV0/YNYx8FZW+Hw1ixTY7gkMZDTWU7iw1jc3J/EaKV
	 IWbfnrVZLBRxWCjv4v5zqlnrK3gNsaEEDjktRV7OW1AA/fU8rBv6tYFqTDixjIEkHj
	 BHGgg3FBzyspIBLcwgpJIPKW7oQJrl8EGg33Fvc5pWEnqdm7dYV1QyFdfjxMvoS5BX
	 HhosvbWzG6lerBlKKuAKZN9hH/aNAX9OkUCkpQ5WKoy42nChK51naGFClRc+6auzRX
	 bkyJzznGzmSPQ==
Date: Tue, 13 Aug 2024 13:29:04 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, arm-scmi@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, 
 justin.chen@broadcom.com, opendmb@gmail.com, kapil.hali@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org
In-Reply-To: <20240813180747.1439034-2-florian.fainelli@broadcom.com>
References: <20240813180747.1439034-1-florian.fainelli@broadcom.com>
 <20240813180747.1439034-2-florian.fainelli@broadcom.com>
Message-Id: <172357734438.1612221.15779792680136216420.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: sram: Document reg-io-width
 property


On Tue, 13 Aug 2024 11:07:46 -0700, Florian Fainelli wrote:
> Some SRAMs need to be accessed with a specific access width, define
> the 'reg-io-width' property specifying such access sizes.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/sram/sram.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sram/sram.yaml:106:12: [warning] wrong indentation: expected 10 but found 11 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240813180747.1439034-2-florian.fainelli@broadcom.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


