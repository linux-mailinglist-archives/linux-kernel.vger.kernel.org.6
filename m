Return-Path: <linux-kernel+bounces-183225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 856008C9611
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5AEAB20C67
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E16BFD4;
	Sun, 19 May 2024 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV+ciD7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D6168BE;
	Sun, 19 May 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147156; cv=none; b=dMu2ZA/XMPxIrcdl0nUBojk9CpL5ERVT66HWoSEyQGa6botQoOXScqBXkalbijUbf2HIcH3ipcT1ZKkCm6GgMtaHnZ/8EWemLyBqcJWDmPaw10Hb4fGNi8dtpNfF5wfiGhhmaPHtw8XQpSoGNx2haUnXyuwwsgbBJTYRyg6VqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147156; c=relaxed/simple;
	bh=1GvbBfv2XOQYFaJwoRDiUHVxHSxTdIHoGwILpB6AiwQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FpDt+tV7InXXmNU6tYGUAofpd51+Zipeda50cr3xRUXGUc6FePVVHlTtq0vOiHzEOKbL8iD4ZG54ZqOgWE7yBzfiluI7O2oh/DQ7ZJzFK2Ny/AUSX9UkH3bwQEKRL6KKyeiMXu+eyv9Gf6lRiCe2xdVshzLWosbHootDa9CefU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV+ciD7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781EEC32781;
	Sun, 19 May 2024 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716147155;
	bh=1GvbBfv2XOQYFaJwoRDiUHVxHSxTdIHoGwILpB6AiwQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RV+ciD7zn2cE5WPaK6Rr58GtDcZbvGDrRevdKoGmzdpmxR4IwAS90F+AJ8NNUNZlF
	 aqmzascLg5BYDyR6OfAfji8wCDwULp7NONZlZyaGTSKaNj/NI+qk/df77ipsb49oEK
	 oH/Cq96ycdom81nSHCQwDQ+2SAelCcbCw0ilsAfbajpC4c1JbSAb4CP98H/n9neURg
	 3o1ekOeseaBGKMa4uv2enWt2CkciNc6R5bCzlZkq0HVHZ5vCVXVvPiMaX46VmWRFyf
	 Q63Dse0E3zv3p+06Ov1PH3IZvTbQox7eKspaOjRbhl7cY9Y+Qv5R+m5ZnXb+Q9giao
	 2oG3+xER9iqcg==
Date: Sun, 19 May 2024 14:32:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: linux-riscv@lists.infradead.org, 
 Kanak Shilledar <kanakshilledar111@protonmail.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240519175906.138410-3-kanakshilledar111@protonmail.com>
References: <20240519175906.138410-1-kanakshilledar111@protonmail.com>
 <20240519175906.138410-3-kanakshilledar111@protonmail.com>
Message-Id: <171614715439.2941344.11264816105918092609.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: cpus: add ref to
 interrupt-controller


On Sun, 19 May 2024 23:29:06 +0530, Kanak Shilledar wrote:
> removed the redundant properties for interrupt-controller
> and provide reference to the riscv,cpu-intc.yaml which defines
> the interrupt-controller. making the properties for riscv
> interrupt-controller at a central place.
> 
> Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       | 22 +------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/cpus.yaml: properties:interrupt-controller: 'oneOf' conditional failed, one must be fixed:
	Additional properties are not allowed ('$ref' was unexpected)
	'type' is a required property
		hint: DT nodes ("object" type in schemas) can only use a subset of json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240519175906.138410-3-kanakshilledar111@protonmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


