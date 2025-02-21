Return-Path: <linux-kernel+bounces-525125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5CA3EB1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2F07A76AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304F1D7E42;
	Fri, 21 Feb 2025 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fugaD4P9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353361C174A;
	Fri, 21 Feb 2025 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107511; cv=none; b=n487a40WxF0FYowR5krGQ7ifeCGIPcT0kxJxzqQSj7jnWNzn1vwJEqVrPqxv5HYtGba8tiZFt9qoX2miBY2rj47FtImEhZk32hMCy2Ir2cQsLA8YPlh7O548bCNAPP3h07PfYmALqq5BSTwPqkmEZzxAzAyY6jBpybrv+ciWUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107511; c=relaxed/simple;
	bh=cWhiygrePoEholasW4NiNmJa4UxvRJ1E334B+HxDlG0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=L9nKDskPzx4VcFy8OsncrW+9I0KNod4u0ntFPz42b4krQU6dIu0SDS7W8p7MUpHk0F7nmYRKA9088xezpD91ag3+GQc39ZTqMd6xaw8ArW2llwBjt+hukSsx7TkuNzzarIUlTkevwRb4eaDzVHXuCxEbf/SkyddTGn1MuoR71hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fugaD4P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5036BC4CEE2;
	Fri, 21 Feb 2025 03:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740107510;
	bh=cWhiygrePoEholasW4NiNmJa4UxvRJ1E334B+HxDlG0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=fugaD4P9PLi9X77E+EI59RH1iDkhGTd8RZGXa52LXicMbBXKLLu6cC+ZpzZikJMV3
	 AHfG+ARK744DejIatOfQVKtuOlF9x4I7cSLesHsqkPBw+y9EUwCkuc9zYtFNiyWwHe
	 uv9Te8SR/Q2R7dsVSOHKY7Cr8vzbRXEscnWdwpHHwXDijhWgbwW0FYVBkgq5vBwfhE
	 jKL3XAP4kILa2dcArS34L/YZfBspswOQ3Op67w/XuZyVhwBPN+SISJJY6EWx3SpoGC
	 Z1rNjko6eBjXU3JgI3Mia8MpkLXUXgMQReMPPvK44Vv96mLnEa8EZ21XuAjfON+Ejs
	 PmUCm7LpDiu1A==
Date: Thu, 20 Feb 2025 21:11:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, andrew@lunn.ch, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, gakula@marvell.com, 
 devicetree@vger.kernel.org, sebastian.hesselbarth@gmail.com, 
 p.zabel@pengutronix.de, salee@marvell.com, 
 linux-arm-kernel@lists.infradead.org, gregory.clement@bootlin.com
To: Wilson Ding <dingwei@marvell.com>
In-Reply-To: <20250220232527.882888-2-dingwei@marvell.com>
References: <20250220232527.882888-1-dingwei@marvell.com>
 <20250220232527.882888-2-dingwei@marvell.com>
Message-Id: <174010750791.4160970.11701879696918181174.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: reset: Add Armada8K reset
 controller


On Thu, 20 Feb 2025 15:25:24 -0800, Wilson Ding wrote:
> Add device-tree binding documentation for the Armada8K reset driver.
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> ---
>  .../reset/marvell,armada8k-reset.yaml         | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reset/marvell,armada8k-reset.example.dts:22.46-26.15: Warning (unit_address_vs_reg): /example-0/system-controller@440000/reset-controller@268: node has a unit name, but no reg or ranges property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.example.dtb: system-controller@440000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250220232527.882888-2-dingwei@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


