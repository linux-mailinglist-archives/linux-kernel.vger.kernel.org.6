Return-Path: <linux-kernel+bounces-210447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A381D9043C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3AF1C23E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E5249E5;
	Tue, 11 Jun 2024 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6/UHIJG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390559167;
	Tue, 11 Jun 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130788; cv=none; b=aivXMMwxwZF+MIeKvhnMu/JggAvlCwMETYK1nVcmOzWh+5mYgxsYnx1TH6Cr/cnch5XGaHzkzNCbtQWBKb8Pb+XNuBrJW+yXuxljo8cP+iHMLre6wOLcN/Fsko6X4aW4HXrvDg+aqngzvk9K6q4FKtUTTXFUjIyiTV6aHw4L+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130788; c=relaxed/simple;
	bh=zCreM3Z3hAQ/UnimTiSe9eKgPn9+Y6iFAPR6H5PRr94=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=n7eQzDrvbV7tNIv/ehnpxaIK3T27zkkC9qanzAkGblImQy8pzS1HpcFI+66CYRDCS+gZNPPMxGJdQzeyYdnmYZ3D6cnKy28GFKxcA3AYMaSHbEkjANAzNdiIPbh2+PuRVhqCp707ANi0ihDHWlG2BSq4n3UjpPPR/+tOy1gcqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6/UHIJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72049C2BD10;
	Tue, 11 Jun 2024 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130787;
	bh=zCreM3Z3hAQ/UnimTiSe9eKgPn9+Y6iFAPR6H5PRr94=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=R6/UHIJGRA/bSIGUouGJezFRj+6CUB1yK7Ajec6CreZSu2nH3LeJ92YB9uW5ZFEjf
	 Ssvm6JGjEQK4beHTrlZns7Q3q945FOZR2zEWYY1pCU8j2nBlvOyP5Sn4Il4wP/bSPz
	 kNTM349+L9bYtn0OOWYHeE4EvojP9sQiap5nEIhKqk68tsMojTWsbiSXOgXUCtw+9e
	 lyq4pD0HEOF543slqGYszst7LzX8XVx9o05BB4y0KGZkUSmDVmqLymmRwj4qgSFQ8m
	 y5Lf8IO8lgrtFB0Z9FN1gdBkmtAd8UzXVZTs6yvFYZf7B9wzneyV9K+riJbKDn015J
	 d9IyFs/cnd/OQ==
Date: Tue, 11 Jun 2024 12:33:06 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aniket <aniketmaurya@google.com>
Cc: Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20240611171600.1105124-2-aniketmaurya@google.com>
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240611171600.1105124-2-aniketmaurya@google.com>
Message-Id: <171813078603.2869501.4487165052485708159.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i3c: dw: Add clock binding


On Tue, 11 Jun 2024 17:15:59 +0000, Aniket wrote:
> Add dt binding for optional apb clock.
> Core clock is mandatory. Also add
> an example.
> 
> Signed-off-by: Aniket <aniketmaurya@google.com>
> ---
>  .../bindings/i3c/snps,dw-i3c-master.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.example.dtb: i3c@10400: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/snps,dw-i3c-master.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.example.dtb: i3c@10400: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/snps,dw-i3c-master.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.example.dtb: i3c@10400: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.example.dtb: i3c@10400: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/i3c/i3c.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240611171600.1105124-2-aniketmaurya@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


