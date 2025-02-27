Return-Path: <linux-kernel+bounces-537265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A411A489CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DD03B1885
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297D26FDB9;
	Thu, 27 Feb 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcY4i8zt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD226E97A;
	Thu, 27 Feb 2025 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687868; cv=none; b=QEX2dTqqEkBV1gJcY+4ToxDaSMaBAldpbm1GWdUAX2Rw5qrvnzVUHdByVl6VR2aYQTvYA506f169PE/D4JTMIw4LBMISXvhc4AUrIKLUXrAIPX2cXHMU+ZkJ0ywZYbUgy2PPwGcrcjxTce0jBklvYNjPlkdAUtm4Bxr9YT9fzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687868; c=relaxed/simple;
	bh=vKEFN02TyY7ZwOZN17NJzRX12EebHAeazOra1CnCquo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tKMpst0xUKM2ZXUYFfPzFRt3/32PPnbcTj/uWYh5fCQ+UiPYa6lF2Rw2NEYhddumliJZboIRWIq5ml84gDjmqhVOmUO88RwalzMrgwZXDEvHHFTbL50Salg6tHoGVTaG1XnvKMlGp1BgEYVD7un6K2p8daIrP8A5M6fnIPqRtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcY4i8zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDFDC4CEDD;
	Thu, 27 Feb 2025 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740687867;
	bh=vKEFN02TyY7ZwOZN17NJzRX12EebHAeazOra1CnCquo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jcY4i8ztzsfWPDQTm5DOUGAh6zBmlu/yzbBczZEzBczuoo7YYCXt/nByGPvJMJjvQ
	 +z2EWIvbPDUq3NZmzeKKCEbbGovcEdgAcNAxEsQDNQKBqclJXJLQpzib4xekxujQFQ
	 yTHrVyEL3Oyr7xsBwtLWyS4rym4nVt2Zk69yg+I82GjMwYej3PX1W1DZESVjUg/3xZ
	 LBjSgwI25CtDJVf/OKE2NcXTFlcRl5Fu0XWLI99v29DaHGS/S5Rd5+/qFQe1m96mUJ
	 L79zzbBqgG9UZrs7Egr8iswrwZ4w/Ue0uPdfoscJwb89WWrRAhsfiCSnmEeEK1+rK7
	 I/8m7blhsrCgw==
Date: Thu, 27 Feb 2025 14:24:25 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, salee@marvell.com, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 gregory.clement@bootlin.com, p.zabel@pengutronix.de, gakula@marvell.com, 
 devicetree@vger.kernel.org, andrew@lunn.ch, krzk+dt@kernel.org, 
 sebastian.hesselbarth@gmail.com
To: Wilson Ding <dingwei@marvell.com>
In-Reply-To: <20250227192536.2426490-2-dingwei@marvell.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-2-dingwei@marvell.com>
Message-Id: <174068786548.161165.4348563654300627455.robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K reset
 controller


On Thu, 27 Feb 2025 11:25:34 -0800, Wilson Ding wrote:
> Add device-tree binding documentation for the Armada8K reset driver and
> create the new head file for the reset line index definitions.
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> ---
>  .../reset/marvell,armada8k-reset.yaml         | 48 +++++++++++++++++++
>  .../reset/marvell,armada8k-reset.h            | 27 +++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
>  create mode 100644 include/dt-bindings/reset/marvell,armada8k-reset.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.example.dtb: system-controller@440000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250227192536.2426490-2-dingwei@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


