Return-Path: <linux-kernel+bounces-445368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110169F151D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF427A0F85
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A79D1EC4D4;
	Fri, 13 Dec 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdCOd66d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8B1DA5F;
	Fri, 13 Dec 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115302; cv=none; b=UbGXghe6LFyHofESg0cKmg0T+Jh9kCdy1HMqZvTMXYNrK3+n9XxfU8X7u4iWc0VAtWpwUDgX4w5jXWl9+wK3nAPbfyl9Se7GQuGLWR8QxzyNVtOUpcqrgIw/lzhcBjLBYmPXCx4AiyU6JHtRirNkC+XDg12jlrY0cIo5M0mxWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115302; c=relaxed/simple;
	bh=glyiHlka/T+7KoYjjtQjbtYMTy9HElX+R5YtfVxKSx0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SyNaIVZIhlFdzoCgiTvzscQukVBJHoZmCVNpTXLnSMWHE7hSeBiYecDoy0sshM62wxkoDUmOohl6/Q7evCzoUQcW2PvV7cb0jD5Lj3pHUWt33SO54Aa0X6jnFSmXtQZNKOHMqe3qYNv2/+6U0C8a7/ZVgInp2NutxpgIibHk10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdCOd66d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF12C4CED1;
	Fri, 13 Dec 2024 18:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115302;
	bh=glyiHlka/T+7KoYjjtQjbtYMTy9HElX+R5YtfVxKSx0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=SdCOd66d43pS6ViGuNfWzOkWlsJHcjMy/0F4+Uj29WEjLz1rh87KQGJOr6A2fVsBE
	 oJzQxjFGrRwQxO8+H9CHe+Rd0g/EmzoOIoTE28ogtZCHjGW4iCRtHQEOnFFluYbmMe
	 5GGTLSPoljzykDskw3ablP+2yiRLhKBt5XILYPBEua1rNIOyErNlecL/w37HNqeDOX
	 gqjwgG61W+5YmUKRJpvIacEP3wbWiBR9ZBJ+BguBiy8y2LIY+k3Wx5Cf2sdT82qQpB
	 nS2CmM4/sCnN9TA0JIkzotJ0tVB7WJRMPCgvZKtQ3zIjL25R6vnZ/ZzkFD7p/wplk0
	 1P1tgx6lQGNqQ==
Date: Fri, 13 Dec 2024 12:41:40 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20241213165240.3652961-4-vincenzo.frascino@arm.com>
References: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
 <20241213165240.3652961-4-vincenzo.frascino@arm.com>
Message-Id: <173411529693.1996544.10315799423274402409.robh@kernel.org>
Subject: Re: [PATCH 3/3] xlnx: dt-bindings: xlnx,spdif: Convert to
 json-schema


On Fri, 13 Dec 2024 16:52:40 +0000, Vincenzo Frascino wrote:
> Convert the Xilinx SPDIF 2.0 device tree binding documentation to
> json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../devicetree/bindings/sound/xlnx,spdif.txt  |  28 -----
>  .../devicetree/bindings/sound/xlnx,spdif.yaml | 100 ++++++++++++++++++
>  2 files changed, 100 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml: xlnx,aud_clk_i: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml: properties:xlnx,spdif-mode: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml: properties:xlnx,spdif-mode: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml: properties:xlnx,spdif-mode:maxItems: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml: title: 'Device-Tree bindings for Xilinx SPDIF IP' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,spdif.example.dtb: spdif@80010000: reg: [[0, 2147549184], [0, 65536]] is too long
	from schema $id: http://devicetree.org/schemas/sound/xlnx,spdif.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241213165240.3652961-4-vincenzo.frascino@arm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


