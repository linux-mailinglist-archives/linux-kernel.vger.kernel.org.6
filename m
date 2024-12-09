Return-Path: <linux-kernel+bounces-438010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E19E9B99
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A262281B49
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA38F145B1B;
	Mon,  9 Dec 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR2uAL3v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F53F13C81B;
	Mon,  9 Dec 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761589; cv=none; b=FEm5OOtUN3HLT1/rDrPW2p0jz5X9NTGMPt3LVTL2OJk1J22l3d7EN9fu7DySswLTEUwEAt8XVyIfcjaD5HN3LDUGHKltUPFsXjX7RHhh66fmnztyRJtiuQI1JsXCcRy3SnKTdu7VdUiJqtypWo/8OP+feWmbQhEULW2R987Fcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761589; c=relaxed/simple;
	bh=c998PD6ESRR3/DLixNhYcyamfLJruxkhcT6TYn31o3U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YC+xMAHj6NjR7dkZ7RklFQPfzLvWBKSmQG8NhF45uHHT2lw8wbGSfPo4VS/7Fooe6Jif4P3dZFlo9rMKiqU/smPmsYNUA4XQMVcLbB9k1FY4TLzHwQovKy2qrj5UAMHwK9t1WmA9wjH+mkqUR0P4e+7bRum96peLtfif+Ttn9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR2uAL3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D74C4CEDE;
	Mon,  9 Dec 2024 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733761588;
	bh=c998PD6ESRR3/DLixNhYcyamfLJruxkhcT6TYn31o3U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KR2uAL3vN4qNK3pLpfR5w3zIdQSJv+ZfIymCIWvKK/N0k3R0WJVO/WrBYVFijtVqo
	 HXdeyDkbCn3XYXjg92z2UQA6LfhX67QtxLjXuZef9sWobHn4m9H6Ivf0Ds/FvCKibq
	 KV9KH50DE4AESQ8Zu3g7ZW4OqMGvsfjzd2XdFjlpvf+qL+fy7ZssBfesNZOT7031c8
	 pcrRbiO0JT2+quqZtYvCJ0RdvORFNXOlnFPwn6RH8dlmD6qtk9ZqRRsz+XfZFDZ8YW
	 RkR39rExn9Ohqa0VhlHFsJDDtfhJl0eGlvmWDfoKDl9IfMXQbxUgry/0Hjj9RWGF1h
	 3Ry3xcxbTPMFw==
Date: Mon, 09 Dec 2024 10:26:26 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Conor Dooley <conor+dt@kernel.org>, Ayush Singh <ayush@beagleboard.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Saravana Kannan <saravanak@google.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Davis <afd@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
In-Reply-To: <20241209151830.95723-2-herve.codina@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
 <20241209151830.95723-2-herve.codina@bootlin.com>
Message-Id: <173376158687.562854.15324053122820075954.robh@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: Add support for export-symbols node


On Mon, 09 Dec 2024 16:18:19 +0100, Herve Codina wrote:
> An export-symbols node allows to export symbols for symbols resolution
> performed when applying a device tree overlay.
> 
> When a device tree overlay is applied on a node having an export-symbols
> node, symbols listed in the export-symbols node are used to resolve
> undefined symbols referenced from the overlay.
> 
> This allows:
>   - Referencing symbols from an device tree overlay without the need to
>     know the full base board. Only the connector definition is needed.
> 
>   - Using the exact same overlay on several connectors available on a given
>     board.
> 
> For instance, the following description is supported with the
> export-symbols node:
>  - Base device tree board A:
>     ...
>     foo_connector: connector1 {
>         export-symbols {
>            connector = <&foo_connector>;
>         };
>     };
> 
>     bar_connector: connector2 {
>         export-symbols {
>            connector = <&bar_connector>;
>         };
>     };
>     ...
> 
>  - Base device tree board B:
>     ...
>     front_connector: addon-connector {
>         export-symbols {
>            connector = <&front_connector>;
>         };
>     };
>     ...
> 
>  - Overlay describing an addon board the can be connected on connectors:
>     ...
>     node {
>         ...
>         connector = <&connector>;
>         ...
>     };
>     ...
> 
> Thanks to the export-symbols node, the overlay can be applied on
> connector1 or connector2 available on board A but also on
> addon-connector available on board B.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../devicetree/bindings/export-symbols.yaml   | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/export-symbols.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
compress: size (5) error for type phandle
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.example.dtb: uimage@100000: compress: b'lzma\x00' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241209151830.95723-2-herve.codina@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


