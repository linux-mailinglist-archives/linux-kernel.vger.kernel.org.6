Return-Path: <linux-kernel+bounces-339801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0D986AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5BA1F2269A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850F1714B2;
	Thu, 26 Sep 2024 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MriBpR3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D61C125;
	Thu, 26 Sep 2024 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727315426; cv=none; b=gr1PvCEvZZ0LpZ6HxzY77ndI3Q9j0zidXJLgL21OqqoqjprMKc6luFkuPdLlfkxgYo84n38AFR07uhgOt2cfEihRLPyXWu5hU04FwOEVt0nPeJAT2ACarYGiq2K64BSXEJeOzeJ44iMKiC+vSIbnXvkA3dK/rY9DEiJCfyaj4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727315426; c=relaxed/simple;
	bh=SVN/xnAwYRntnu4COhrWlYvc1k7DTNxN8qZdWnWoQGk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QDf/bEJVVpKyQRzK90kUtjnOWoDfa3fd+SX2zaCFhsFZWStq6JHqDWZZBZcYXC5vMeXLmSjfUefYJZgY2vVMYVXVLXhGFoL8EP7n2VY1+YNaNk/KrZyBLBAF9FxmB3TsUtWsaxbp6B0Khk7EEosMXz1s56y1Aw9d2lsClbx5pCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MriBpR3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2B8C4CEC3;
	Thu, 26 Sep 2024 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727315425;
	bh=SVN/xnAwYRntnu4COhrWlYvc1k7DTNxN8qZdWnWoQGk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MriBpR3J6key0RjEL0crJV0BKK8K+hBK3ZjhYkKZafuLkqAnjgL4FBh4KJqR3HoMS
	 kONaxwAtt4tkuGMrjnJqH5vrp1tDing102YranbIyLq+WD3SeDbAtrQtwToP+9f9fX
	 W+ZBIfobXbwSDa20iKXhyLOfFMdwl5cNDxGLScnkxcYVIodzfF6dMbqzLJqV+S427R
	 +6QmAJT4G6LjMWLmnWMQJ2GVGXkEwlfBJ/AXA0yXAZQrnOeutoEqUxtfSLZgI5VzZ0
	 jBvceL5odd06wZcWG8/w0RESQifxKOJ6N9cCzsPl2Be3SsI+pDlabGyZTYiJ9At0+1
	 SRs+gOVRAd1Cw==
Date: Wed, 25 Sep 2024 20:50:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-kernel@vger.kernel.org, Iuliana Prodan <iuliana.prodan@nxp.com>, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20240925232008.205802-2-laurentiumihalcea111@gmail.com>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
 <20240925232008.205802-2-laurentiumihalcea111@gmail.com>
Message-Id: <172731542455.2226102.16295733328701144555.robh@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: dsp: fsl,dsp: fix power domain
 count


On Wed, 25 Sep 2024 19:20:03 -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Per the current binding, QM/QXP DSPs are supposed to have 4
> power domains, while the rest just 1. For QM/QXP, the 4 power
> domains are: DSP, DSP_RAM, MU13A, MU13B.
> 
> First off, drop MU13A from the count. This is attached to the
> platform device of lsio_mu13. This decreases the count to 3.
> 
> Secondly, drop DSP and DSP_RAM from the count for QXP. These
> are attached to the platform devices of the lpcgs (used as clock
> providers for the DSP).
> 
> With this in mind, the number of required power domains for QXP
> is 1 (MU13B), while for QM it's 3 (MU13B, DSP, DSP_RAM).
> 
> Additionally, two extra power domains may be required in the case
> of QM/QXP DSPs. These are IRQSTR_DSP and MU2A. For the nodes using
> the "-hifi4" compatibles these PDs are optional, while for nodes using
> the "-dsp" compatibles these are mandatory.
> 
> These changes reflect all of this information.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 62 +++++++++++++++----
>  1 file changed, 49 insertions(+), 13 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: dsp@596e8000: power-domains: [[4294967295, 0], [4294967295, 1], [4294967295, 2], [4294967295, 3]] is too long
	from schema $id: http://devicetree.org/schemas/dsp/fsl,dsp.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240925232008.205802-2-laurentiumihalcea111@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


