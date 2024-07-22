Return-Path: <linux-kernel+bounces-259299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37599393B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE4228245F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4BB171E58;
	Mon, 22 Jul 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYM+4JNL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CE17167D;
	Mon, 22 Jul 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673698; cv=none; b=o1LOiNRGQAic6DSmUR2ElgjgXXKHW5sS9w8YFqyAxGQOfYnEwMCCSWZg2r0+qzlphW/olx4Iwl7ffjENKlJ2uU9poZLD2HVU6JU04YuY1UNb71+MMtofINAFa7UMVcus+8dxqeXzTaWvRwItxUuGEXWIFHNBdYGSpG3X+ABEY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673698; c=relaxed/simple;
	bh=y0hQXaXm1Z0bh43rHFaXY9FdtGud+/3abXgd5MUoEGY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=OAY/qzqwzp/37C1F0B2BRciLJhdWFRs5gUxcbzwCYYT/jm2cH1kAi4W63j5rDqoZN0DISaa0eM7o4BWeOHrU/Zn7lCDjsZrHvWlJ/2owG1w4DoUBxsrsb0pUZ8sO6oLPzMxsjhhYqr/q7LAWjGB8MyjODAH1wCFp6BD+R26UhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYM+4JNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939DBC4AF12;
	Mon, 22 Jul 2024 18:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673698;
	bh=y0hQXaXm1Z0bh43rHFaXY9FdtGud+/3abXgd5MUoEGY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uYM+4JNLuUOk6ptJugSUV/s4M9C7dDeutUWYnG+MxwodfnsofLQr1oOn5+YAWxLHx
	 G74yGTGO/OKImDGurRO0+ta7/j4RXZ9Zo/irTfhzuMj2O8Cd2zUbWo6oUQmINpz6yN
	 1E7pINoeXI7kiPA4KHrydxJfLGHJ/v+hBsjUEZnzwwxZyoq0GVefoEh8obnYINhHQ2
	 8uCmWnuSjtPZ3q5oobk3wUBromZ+x5EOrqipHvNXy2y3TG6Fd5+v2EBeBxA4Nd9Vrn
	 yu4RHnJD9JlDvPHJRuYlLJjRwy6GJW6nntJtlz3Zs1+RlAwROVQrvYjn/gH+3egXii
	 ikf7UPbQq4X+w==
Date: Mon, 22 Jul 2024 12:41:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Julian Vetter <jvetter@kalrayinc.com>, Jules Maselbas <jmaselbas@zdiv.net>, 
 devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jonathan Borne <jborne@kalrayinc.com>
In-Reply-To: <20240722094226.21602-8-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-8-ysionneau@kalrayinc.com>
Message-Id: <172167365490.4512.1294837213673454855.robh@kernel.org>
Subject: Re: [RFC PATCH v3 07/37] dt-bindings: Add binding for
 kalray,coolidge-ipi-ctrl


On Mon, 22 Jul 2024 11:41:18 +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray Coolidge IPI controller.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3:
> - fixed bindings to adhere to dt-schema
> - moved to interrupt-controller directory, like the related driver
> ---
>  .../kalray,coolidge-ipi-ctrl.yaml             | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-ipi-ctrl.example.dtb: inter-processor-interrupt@ad0000: reg: [[0, 11337728], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-ipi-ctrl.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240722094226.21602-8-ysionneau@kalrayinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


