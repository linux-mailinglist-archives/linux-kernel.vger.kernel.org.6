Return-Path: <linux-kernel+bounces-337474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D2984A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D684280EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CE1AC895;
	Tue, 24 Sep 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmhXbk8x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255B1B85CA;
	Tue, 24 Sep 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200868; cv=none; b=IvXE1zti5lW02gDSIBFmvB+a7/E6zkIMqTzL0JyzuAwqUSaFLfKNBeoPPDdO28C9cZ66/yQq032JjD/Fzzj72KTDF2n/0pdZooYG+wpe60bP7tbi98O6LQYLw1OP1NXsRIoth1uPxnTDNiCc4v3/E5GkYdqxvlVhLCMt3Jt8J5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200868; c=relaxed/simple;
	bh=FIBb6Xvg+vsgLgLFLONIDRw5APSJqrReEgeIWNL+IS0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VhGrgaPj9HJPqeorVbf0wQwjgbJMQ/qodvAnvJQYdjoX2N7FZqGAtftVbietYmNpkZxTGManeqLsyl2mHOv/cFkTAhpMf4Gc7E7xM3s6QmewIqmlJZdumNULTti1c/8rYlX0MHFUUpdCanTnW2lIhDsX+2IV88XX6e2UTA5iGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmhXbk8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CADC4CEC5;
	Tue, 24 Sep 2024 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727200867;
	bh=FIBb6Xvg+vsgLgLFLONIDRw5APSJqrReEgeIWNL+IS0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SmhXbk8xSfBousexFosmlobUgbqZZT8vkrhy3PqNvfGjguI5C24e74tfAoS288cv+
	 ShVL9IN8zynLttc4j52kERYVOhfxp3spvFLrCL3RJ8PjOp/jl6X38qkw8bi966fmyw
	 IeoCBOh3AId7HJW43JDo/hrV4gHx3Enbz305N0GwFmnOQmX4TKLBXiQjEWiybngqjS
	 oFPmOHpvi9OUFLskXitlQJ2cydCon8zJFtepf6nfOqt2bwFnMyNqJQC1WLrX9NTi00
	 GBabJGQ9D6PXccpqOyjCDKaB6Yv0rmJqzgMHH0v+VGHOLJ+ymo6HqUFhroJrhGokpp
	 JM0D42QcdaScQ==
Date: Tue, 24 Sep 2024 13:01:06 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: andrzej.hajda@intel.com, sam@ravnborg.org, robh+dt@kernel.org, 
 jonas@kwiboo.se, Laurent.pinchart@ideasonboard.com, 
 krzysztof.kozlowski+dt@linaro.org, linux-phy@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, kernel@pengutronix.de, 
 alexander.stein@ew.tq-group.com, shawnguo@kernel.org, linux-imx@nxp.com, 
 mripard@kernel.org, vkoul@kernel.org, dri-devel@lists.freedesktop.org, 
 daniel@ffwll.ch, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, airlied@gmail.com, 
 jernej.skrabec@gmail.com, s.hauer@pengutronix.de, oliver.brown@nxp.com, 
 devicetree@vger.kernel.org, festevam@gmail.com, dmitry.baryshkov@linaro.org, 
 neil.armstrong@linaro.org
In-Reply-To: <b2e1d26f964a03163ec7a1ba6ac8d7c88d6cb111.1727159906.git.Sandor.yu@nxp.com>
References: <cover.1727159906.git.Sandor.yu@nxp.com>
 <b2e1d26f964a03163ec7a1ba6ac8d7c88d6cb111.1727159906.git.Sandor.yu@nxp.com>
Message-Id: <172720086579.2917.61541648754055069.robh@kernel.org>
Subject: Re: [PATCH v17 3/8] dt-bindings: display: bridge: Add Cadence
 MHDP8501


On Tue, 24 Sep 2024 15:36:48 +0800, Sandor Yu wrote:
> Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v16->v17:
> - Add lane-mapping property
> 
> v9->v16:
>  *No change
> 
> .../display/bridge/cdns,mhdp8501.yaml         | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml: lane-mapping: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/b2e1d26f964a03163ec7a1ba6ac8d7c88d6cb111.1727159906.git.Sandor.yu@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


