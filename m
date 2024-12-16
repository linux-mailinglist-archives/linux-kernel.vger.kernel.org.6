Return-Path: <linux-kernel+bounces-447169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A49F2E55
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22361885A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC63204085;
	Mon, 16 Dec 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6yJclhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C25203D60;
	Mon, 16 Dec 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345702; cv=none; b=llLFqouIPEgHedyxrHjwFE7+guUZo5tiasPgpeH0KlXH+iORroRTxtEZBrkzTnn9CV4WoF0D6Wzv/Gg3+FRX+FAS/0zES4hzfPQsVeazjmt+qFGaJaE+vHEQeNVfOjnjdUaK+Omvkn7VX6/BXFAThAwBdSBjvs1BbNzEDiqWkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345702; c=relaxed/simple;
	bh=+Gt7sln311MYYO7UyQ53nZUhFgOQuw/rcPUpZqaXzDo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dEugOwUttMfkSTJegZ7WR7TmAkyZEQXFS08V4GsA6iN1CceplN99gstVZNiJmHXNRN9EBmm7a0JujF1A3GpKYmLKbtp3PEIZpXibBWUVIos51Dn7zg9Vkg403SPrpT2jADMH6Y5q0SUYstfwXixdA5TMctDuTCkD+6XmFZXoRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6yJclhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954EBC4CED0;
	Mon, 16 Dec 2024 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734345700;
	bh=+Gt7sln311MYYO7UyQ53nZUhFgOQuw/rcPUpZqaXzDo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=S6yJclheYtv1mrwMkQ6DazZgNxA/kcRY27xDiCz5vrdl+3QLj4Yls4G8CwpKj7wG5
	 yTlhCgAXwiD2ZdRG+fB07++l8ztGhOwONeWKRRGdes2UiJfuRw0anR93FG1O19vEtF
	 +FfGSUTulmf18Duxf5jCB1AFP14NYzOZl8Z+EcnqnOgtqt/s0HtvF12ptjjZRjbvlK
	 LrOmxSNL97cpBtwCb2VjjAjJ1SFoJaRLj8/6y/iMyiw39+o/QmsEW0offSyULE6/rC
	 32N4FInv2CxChtec22ICcd6qihMYfbKY0USFC2tVFJmgC1R5IGuZyl2IQWbLHrazXS
	 n7kxRe0UfAhvA==
Date: Mon, 16 Dec 2024 04:41:39 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
 Rahul Pathak <rpathak@ventanamicro.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Sunil V L <sunilvl@ventanamicro.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atishp@atishpatra.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Anup Patel <anup@brainfault.org>
To: Anup Patel <apatel@ventanamicro.com>
In-Reply-To: <20241216084817.373131-4-apatel@ventanamicro.com>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
 <20241216084817.373131-4-apatel@ventanamicro.com>
Message-Id: <173434569620.3760706.9963658064899025443.robh@kernel.org>
Subject: Re: [RFC PATCH 3/8] dt-bindings: mailbox: Add bindings for RISC-V
 SBI MPXY extension


On Mon, 16 Dec 2024 14:18:12 +0530, Anup Patel wrote:
> Add device tree bindings for the RISC-V SBI Message Proxy (MPXY)
> extension as a mailbox controller.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml: warning: ignoring duplicate '$id' value 'http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#'
Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.example.dtb: /example-0/mailbox@10080000: failed to match any schema with compatible: ['riscv,rpmi-shmem-mbox']
Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.example.dtb: /example-1/mailbox@10001000: failed to match any schema with compatible: ['riscv,rpmi-shmem-mbox']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241216084817.373131-4-apatel@ventanamicro.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


