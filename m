Return-Path: <linux-kernel+bounces-447170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119349F2E58
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCDC162D42
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14624204087;
	Mon, 16 Dec 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGvVKPCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C8203D6D;
	Mon, 16 Dec 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345702; cv=none; b=a5V1BjcIBAknkHZXLEmbaYJ9b72DHJpBBMx60r2yQJHSa7seGhHHP6YLPHdgQEaDlV9I90dHJccvRs2vw3EluM4sSQu8kWXrER2i41SW370dEg/oOsZfUgS7i6OToam7jWmpXGhP/9yrjK+jRg1puk7LU/EUDAJlojgvFhARCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345702; c=relaxed/simple;
	bh=mljov7sKFphAAju6hgObLkzU6ii6fcbdLfyoYgfipWs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Jt5B8akycH2/bpZ3zB8v5kE+5X11M3TxM8WrpW6XOTfceshbNKfRDtp3imsFqXqf9k5PUY2HyFLMrtVpRa4PItj1Sy3UYSofF4yEesX6gPRd40xkXOM+TwoLxKR4PWKXM0K09qZDBhPwP/X4mQQN2cJ9VezBQLgLkcuidq4lUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGvVKPCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BBFC4CEDF;
	Mon, 16 Dec 2024 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734345702;
	bh=mljov7sKFphAAju6hgObLkzU6ii6fcbdLfyoYgfipWs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=TGvVKPCXjpQnWXD3XCgdSYz0796+AqWhjBQsUuDnagoHds/uWQGaUKHxZfVLQ8iXs
	 rDVmTTtdVRT2rLgKhKauILmwbz2RtwwVvY7Z0kWfgQbcX5OGhCQRheVQvDaeY0ak/z
	 Pbl3FdZBeGiK3aBQIPCPt/5Q6ma9UpSQXl9/kjlpDKfT8M/Xx8hVbe+8ACTy10n/z7
	 I5dddbyWIOgg57zGySccXn/dxkTTsNmUSV9HeplQs+iObD4+9fDfEe2cXuzEVf46nV
	 jUbsi6kblzap9CC4cHZW+XCO1MtTURTQICo7u8zDxGcNcOFClT15wcJFFU35y8+/4t
	 XupaM2tOmxNwA==
Date: Mon, 16 Dec 2024 04:41:40 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rahul Pathak <rpathak@ventanamicro.com>, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Jassi Brar <jassisinghbrar@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Anup Patel <anup@brainfault.org>, Sunil V L <sunilvl@ventanamicro.com>, 
 Andrew Jones <ajones@ventanamicro.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Atish Patra <atishp@atishpatra.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
In-Reply-To: <20241216084817.373131-8-apatel@ventanamicro.com>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
 <20241216084817.373131-8-apatel@ventanamicro.com>
Message-Id: <173434569718.3760744.3925940874684255534.robh@kernel.org>
Subject: Re: [RFC PATCH 7/8] dt-bindings: clock: Add bindings for RISC-V
 RPMI clock service group


On Mon, 16 Dec 2024 14:18:16 +0530, Anup Patel wrote:
> Add device tree bindings for the clock service group defined by the
> RISC-V platform management interface (RPMI) specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../bindings/clock/riscv,rpmi-clock.yaml      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml: properties:mboxes: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/mailbox.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml: properties:mboxes: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/mailbox.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241216084817.373131-8-apatel@ventanamicro.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


