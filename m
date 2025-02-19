Return-Path: <linux-kernel+bounces-522510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2979A3CB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D823ADFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26F257426;
	Wed, 19 Feb 2025 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytk9ZN4N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1892566CE;
	Wed, 19 Feb 2025 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999907; cv=none; b=O4vFXjCSt5KqhVg8Dd5ekCuVMJVoYz3rIVynm0icriOPYY4nDHqBl5Vh8OSi30edKq500JQQckPT1jtmx3i/QcgRGM1VgMehmjSYbMkAwZVoI4fpRV4JkkQBDkjYTzm7chZLird6sfgIfGaTUjpbbl4y6qIV+DD/YvljjREDgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999907; c=relaxed/simple;
	bh=zgChJNf/jNRQQ4Q+zy63+Z2ebjGkQIejxO8cpu9ja64=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FZ/C2KQx1SV2Yh5GR+mvMnJf0X/2ZejYBfu4D+6kRyySnDHypqtYiAyd7+hxq27b89akdvGugpXzYLUCXEzfK4fJ5WoV+dvV6OoQcO6wz9Lz/V3iMATn9Knkjd/zDsFjL6xYCkJrOYMEf34Wk2I94Onp7K/m5ix8a13EY2BRc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytk9ZN4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8BEC4CED1;
	Wed, 19 Feb 2025 21:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999906;
	bh=zgChJNf/jNRQQ4Q+zy63+Z2ebjGkQIejxO8cpu9ja64=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ytk9ZN4Nfwb5KfE2wIsscLA2w9BYrtqzRHgMJ7YrVBMdg601+cXGaRNDkSMNiZif/
	 oLzBHncVEM/pt8X9yon0xPE3uAehMpIHrdoED3dL7z83FhwwIThYLQkwWclQcMbF7/
	 8LaFWH/dpMIZgKCOcN1pXi5LTFGHZE8M4OF8O6ghfuGQQEKmSfc/BYEiN8Cr2A8sYB
	 u01BAtD/dQXwvityHrENihfWdCUNeVEuvXp5wRqL/Bzk026J+J6E7b5g2rSyMv4cGu
	 2VRSRFWYVs9PrIRUpVvxGkD4WAAZ7sk6xRBVMLZxE/o0/xkw9V/4vzSABDGoIpPuvt
	 jYMBGdY6sIv3g==
Date: Wed, 19 Feb 2025 15:18:25 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Frank.Li@nxp.com, s.hauer@pengutronix.de, p.zabel@pengutronix.de, 
 mathieu.poirier@linaro.org, krzk+dt@kernel.org, peng.fan@nxp.com, 
 laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com, conor+dt@kernel.org, 
 festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de, 
 shengjiu.wang@nxp.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, 
 linux-kernel@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20250219192102.423850-3-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-3-daniel.baluta@nxp.com>
Message-Id: <173999990554.2971484.2354660652098932942.robh@kernel.org>
Subject: Re: [PATCH v2 2/8] dt-bindings: dsp: fsl,dsp: Add resets property


On Wed, 19 Feb 2025 21:20:56 +0200, Daniel Baluta wrote:
> On i.MX8MP we introduced support for using a reset controller
> to control DSP operation.
> 
> This patch adds reset property which is required for i.MX8MP.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/dsp/fsl,dsp.yaml:183:11: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/dsp/fsl,dsp.example.dts:85.37-38 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/dsp/fsl,dsp.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1511: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250219192102.423850-3-daniel.baluta@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


