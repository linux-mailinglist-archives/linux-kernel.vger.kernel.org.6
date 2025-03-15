Return-Path: <linux-kernel+bounces-562711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D7A63197
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08A5172642
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F0204C26;
	Sat, 15 Mar 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYHEAY/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76718C930;
	Sat, 15 Mar 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742063483; cv=none; b=BaMgO1MANmBtFWyxiaWT2lreJmXBZpVV1h0sWJWcol5T14kX8o+JVTUuY7dgHAZhy7nS5XtYiaJpiSau7G+edFMQPSoYk2hEKQ6BHdax0VNF7h78WAcQHnBLUqxOlAJk2VZgBetNT+vqjdZd50iBlGgrtBpDgeR5UQoDd7qt/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742063483; c=relaxed/simple;
	bh=0vfRuOck6enEATJsxwnNJ97w8R1LMXCI2iLptXnQIU0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cjKLIF7BmkoRdQXEXHpF+GIk96kje2DKAHyiFtCFW5qUyyrrBbKHpfXhLrXfALzNk2Pdza6Adf8NvmC9z4w++8KnzvexkZfyHEiHFbnbwRWTDdbL6A4FVYdNkK9m3y00Sa4n30Y8d4fSHUeHoLge5lscylOpd5UzZ6jGzgayM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYHEAY/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DE0C4CEE5;
	Sat, 15 Mar 2025 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742063482;
	bh=0vfRuOck6enEATJsxwnNJ97w8R1LMXCI2iLptXnQIU0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=NYHEAY/MlCKSqP3IBOlMPfNYkjroro5RKtI3W7/xGpH4ak32s3UztdI7UqFLOEKr5
	 VYnlEw6gUkiP2DcpIHMgscMlL50A84eTecOIy+sMi3B0NkLhQCzSMfhH5adzm5V64s
	 in6+RuKSPJ7ATi7kQz9a9WVR7C19T7A6Y+SR+1UNQLLSDXlYrBsxvfbim8P79IRrMy
	 CSb0iOjc0S0pXBw1fYyjH7oTqSmpgwvF3qiCSjZ7fgORRQeQfsM5zEInfePjpnmjR4
	 eF3R877fUET0tUeWkysztKsL6DkB/Fdl9GkunMyFo+Gf+GALvu5vQmNesSrjqwcDMV
	 if4uWd9d4MNKQ==
Date: Sat, 15 Mar 2025 13:31:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Crystal Wood <oss@buserror.net>, 
 linuxppc-dev@lists.ozlabs.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kernel@vger.kernel.org
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250315-fslpmc-yaml-v1-1-10ba354a85c2@posteo.net>
References: <20250315-fslpmc-yaml-v1-1-10ba354a85c2@posteo.net>
Message-Id: <174206348097.159805.1044453003821020231.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: powerpc: Convert fsl/pmc.txt to YAML


On Sat, 15 Mar 2025 18:27:05 +0100, J. Neuschäfer wrote:
> This patch rewrites pmc.txt into YAML format. Descriptive texts are
> expanded or shortened in a few places to better fit today's conventions.
> 
> The list of compatible strings (and combinations of them) is based on
> existing device trees in arch/powerpc as well as compatible strings
> already mentioned in the plain-text version of the binding.
> 
> One thing I didn't handle are soc-clk@... nodes as seen in
> Documentation/devicetree/bindings/powerpc/fsl/pmc.yaml.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/powerpc/fsl/pmc.txt        |  63 --------
>  .../devicetree/bindings/powerpc/fsl/pmc.yaml       | 159 +++++++++++++++++++++
>  2 files changed, 159 insertions(+), 63 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/powerpc/fsl/pmc.example.dtb: /example-0/sata@19000: failed to match any schema with compatible: ['fsl,mpc8377-sata', 'fsl,pq-sata']
Documentation/devicetree/bindings/powerpc/fsl/pmc.example.dtb: /example-0/sata@19000: failed to match any schema with compatible: ['fsl,mpc8377-sata', 'fsl,pq-sata']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250315-fslpmc-yaml-v1-1-10ba354a85c2@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


