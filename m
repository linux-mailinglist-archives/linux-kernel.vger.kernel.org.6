Return-Path: <linux-kernel+bounces-259297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5490E9393AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E545282331
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDEB17165A;
	Mon, 22 Jul 2024 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt8BJMSu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68784171074;
	Mon, 22 Jul 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673694; cv=none; b=nfr2WnlT2sPZgqGfnXcKfMNiqMqi9XKe8uP8QhdoU3JUw5eKzQKdEkjPARJEfOagygO1K//HXGzlL3YkUEg1q2yVKXHZ9P1vohZFAmCKBTd9IOBjXLum441D9AnT4j2E4oqCBE82cJnKb2JzitaIgBIx743KS2QrmL0+XAuzmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673694; c=relaxed/simple;
	bh=eKsiKDi83td80Cygwdo0Jd5hcxKG5FKYIIwCibICxeU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Fxj7gfTMNXnV44IPRaKjpL/p+L2YqwR6rpMZOuBwmPfsnt/HBH3TCar/mu0E86pyDVxmty7NcGEUgk/4SdyBPmJ+ZRUedaR9Z3h0v7Zac1WXQgd0fu5/nupwEpufVY+NAm1U171w2fLztW4qhESQnCTdMJKotHlhj+nSeQQD6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt8BJMSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1E5C4AF10;
	Mon, 22 Jul 2024 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673693;
	bh=eKsiKDi83td80Cygwdo0Jd5hcxKG5FKYIIwCibICxeU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qt8BJMSuQq2upIMOTMggPfP+16UkW9bCZz9wp0H6ZY27l85/QzMfKgyICs5AHJEYi
	 7Hlg7BxBY+5EUkuexFy1iiJUzEOls/yYYUG9yLxynAzaAZiVMriYD26OV76+a04P5W
	 galC1KLHunA4IC/xrTEWAWm2ChXVi06Mt7jAKc3pGqWbJMBZtx8B5cM0TS/HF7UNm8
	 azEvHasQOxye3QOsOtfIRJ+X+4uxe56HbBeJ1b6HS8Pboynu8jNEvpHXcMoCbBZEyQ
	 so8rUhUj/BvHYPUJxndv4NgQLy/hlu6ZEXRJcqv+tZFS1nqCrq8zTDMHdEmN6W4N/z
	 JYdgx4v5bSuyw==
Date: Mon, 22 Jul 2024 12:41:30 -0600
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
Cc: Thomas Gleixner <tglx@linutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, Julian Vetter <jvetter@kalrayinc.com>, 
 linux-kernel@vger.kernel.org, Jules Maselbas <jmaselbas@zdiv.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Jonathan Borne <jborne@kalrayinc.com>
In-Reply-To: <20240722094226.21602-7-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-7-ysionneau@kalrayinc.com>
Message-Id: <172167364960.4405.5368780713667799253.robh@kernel.org>
Subject: Re: [RFC PATCH v3 06/37] dt-bindings: Add binding for
 kalray,coolidge-itgen


On Mon, 22 Jul 2024 11:41:17 +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray Coolidge Interrupt Generator.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: Fixed bindings to adhere to dt-schema
> ---
>  .../kalray,coolidge-itgen.yaml                | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-itgen.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-itgen.example.dtb: interrupt-controller@27000000: reg: [[0, 654311424], [0, 4356]] is too long
	from schema $id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-itgen.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240722094226.21602-7-ysionneau@kalrayinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


