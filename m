Return-Path: <linux-kernel+bounces-421366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC989D8A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A14B165ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746811B415B;
	Mon, 25 Nov 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EceNSwEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD201AF0DC;
	Mon, 25 Nov 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551902; cv=none; b=NfhtLoOWTR1zjp2JnQSnt+G3jZOutQ5ubEtvD1op2TPiwl0nMyml+wQ+Tk9q8i/dIZGq7YbK2SxQfg2xRpRVPEdWCIk7XSRZSPnuyggnXwv9LSBa6HjyHpE2r9a5pfhwJhzSL27wvooCTwXaYqILzZpsLDxzbHJP39x5RMsod44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551902; c=relaxed/simple;
	bh=8as9MrIKimIX5awXjOc69Muy8ccgrwOcnR9Pg5tg3RM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rvvq/7IcXmSUrC+EcxFspkkjbf6x7UwJDQQdhMn4XNHrLpLtly5IUaTD3iZW4KYCQzFnMbunzwHfWpfE/qtDwRmhzuY+M2I6mcM3nKJ02f3m+jRnXNnhiajIKSePyAOtrCKEb1N/AfGfioz4KVWnD8EVIaN0wB2MklnWBOQgGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EceNSwEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF32C4CECE;
	Mon, 25 Nov 2024 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732551902;
	bh=8as9MrIKimIX5awXjOc69Muy8ccgrwOcnR9Pg5tg3RM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=EceNSwEX+TgJlehZMy7OR8Mq0G+SB+KHvkETI6gMwm7lsCLWo3i/H95qAjrUfR7TS
	 AVD7FZ4FMBTik47of/SlvlGwHhH4WNYHZNVuJBjVXQTDyjTu8TZxaiIiCW0jxte3fQ
	 xqlNZKfqfifAWCDDFVx3RUhMI0Ls9sBDqtd/2QeoooSMbfp4Vd7Pn9+eWZhbD1i7MY
	 rd/BHKJp4cg3vVoiGykMpmwhOI/+RLBqNQ3I/WuW8AQGwYecoqua5rEQeAxo9SeCXb
	 iuIZbE76a4apVquHSR+plzXN5TDKLPpjEbmg79YqOrFnfhy+NTGQWurOtkQm35vl3j
	 hgTPwpn+iSPcQ==
Date: Mon, 25 Nov 2024 10:25:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
 iuliana.prodan@nxp.com, laurentiu.mihalcea@nxp.com, daniel.baluta@gmail.com, 
 devicetree@vger.kernel.org, festevam@gmail.com, conor+dt@kernel.org, 
 aisheng.dong@nxp.com, krzk+dt@kernel.org, s.hauer@pengutronix.de, 
 shawnguo@kernel.org, imx@lists.linux.dev, shengjiu.wang@nxp.com, 
 a.fatoum@pengutronix.de, frank.li@nxp.com, linux-kernel@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20241125152427.136883-5-daniel.baluta@nxp.com>
References: <20241125152427.136883-1-daniel.baluta@nxp.com>
 <20241125152427.136883-5-daniel.baluta@nxp.com>
Message-Id: <173255190049.1879836.4569049791062626285.robh@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: clock: imx8mp: Add syscon
 compatible


On Mon, 25 Nov 2024 17:24:24 +0200, Daniel Baluta wrote:
> imx8mp audiomix contains a set of registers used to control
> the DSP.
> 
> The dsp will use this to acquire o reference to audiomix registers
> and handle the registers to control the dsp.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/imx8mp-audiomix.example.dtb: clock-controller@30e20000: compatible: ['fsl,imx8mp-audio-blk-ctrl'] is too short
	from schema $id: http://devicetree.org/schemas/clock/imx8mp-audiomix.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241125152427.136883-5-daniel.baluta@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


