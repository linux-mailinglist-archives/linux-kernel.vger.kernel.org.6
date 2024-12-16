Return-Path: <linux-kernel+bounces-447168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2303C9F2E52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4BC1624EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D86203D4D;
	Mon, 16 Dec 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF8Va7/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEB1C07D1;
	Mon, 16 Dec 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345699; cv=none; b=MeoBQFjHXF462Lhp7abNTTPAr1t3z7ZKxzhFBX24T9uHmV7AwWyPpu+Se9X6IHtR5HFc84cggnJ9m8dSc7wWczvIxei9rfgNXOroyQWAp6Fi3Hfe+rtf3zlQ5QX7yp2YlYPBq6F+ckSvR4qlm99HVKS/+M4kq0wsDcsqrNy6xsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345699; c=relaxed/simple;
	bh=MIPDG5npvjgPw5aSOixMDI/+/nDxKCP/5TlsORkHAgg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Zl1heyuxY3APkmIKJ4MKhvi4yLzb54PvytuZdGe+W4CmUJjquM3hzYFibizfiFNWzVp9154q5huwiLveF1mGoUK/PKUbTaP2KnMEZj934tlzCquUugKnyGlaLX0+JtOZFopJFT53wx2QPFISqEis7tf8laCWClMWFo8708RMVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF8Va7/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E198BC4CED0;
	Mon, 16 Dec 2024 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734345699;
	bh=MIPDG5npvjgPw5aSOixMDI/+/nDxKCP/5TlsORkHAgg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=hF8Va7/ygXZ1JIiTm/K1veoHrxpUTxozypjdhoXuP+pwIGqPABP7jTiexBrUpI8AI
	 j6N7ocpCYDxuhj+nyC07iJy74/rW5K/cvmXoukJdZv6vduDaKEL/TdUnvlMM8eh4JA
	 jxXiUcOm3C0rb/nhLfayykitTPERt+QB6CZ7+u9qvB3+UxW+hN0On0EJEKdKWUHyy+
	 a7rAzKIt7NSFc4Kl+pwDemshgIUtVV7/tcOCSrqw3ZqBumVASLMcEg3tyuFlHcBHxP
	 iFvs3fZtry/pQjPK8ZGtO9n5Qspg40bUngF7j0ECGGGgoZ9KOuZoDhPzq/8kmQIGfc
	 QEMHKEBf7AglQ==
Date: Mon, 16 Dec 2024 04:41:37 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>, 
 linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, 
 Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
 Atish Patra <atishp@atishpatra.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Rahul Pathak <rpathak@ventanamicro.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Anup Patel <anup@brainfault.org>
To: Anup Patel <apatel@ventanamicro.com>
In-Reply-To: <20241216084817.373131-3-apatel@ventanamicro.com>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
 <20241216084817.373131-3-apatel@ventanamicro.com>
Message-Id: <173434569485.3760664.8535166298614044761.robh@kernel.org>
Subject: Re: [RFC PATCH 2/8] dt-bindings: mailbox: Add bindings for RPMI
 shared memory transport


On Mon, 16 Dec 2024 14:18:11 +0530, Anup Patel wrote:
> Add device tree bindings for the common RISC-V Platform Management
> Interface (RPMI) shared memory transport as a mailbox controller.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../mailbox/riscv,rpmi-shmem-mbox.yaml        | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml:33:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml:39:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml:46:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml:52:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml: properties:interrupts: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.example.dtb: mailbox@10080000: reg: 'oneOf' conditional failed, one must be fixed:
	[[0, 268959744], [0, 65536], [0, 269025280], [0, 65536], [0, 269090816], [0, 4]] is too long
	from schema $id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.example.dtb: mailbox@10001000: reg: 'oneOf' conditional failed, one must be fixed:
	[[0, 268439552], [0, 2048], [0, 268441600], [0, 2048], [0, 268443648], [0, 2048], [0, 268445696], [0, 2048], [0, 268447744], [0, 4]] is too long
	from schema $id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241216084817.373131-3-apatel@ventanamicro.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


