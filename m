Return-Path: <linux-kernel+bounces-398311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675199BEF6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B77E28471F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736D1DF97B;
	Wed,  6 Nov 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGYIZuVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206A3D66;
	Wed,  6 Nov 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900918; cv=none; b=jpwV1HVLVz0/IcJiRVe+p9j0r5h6qKFl2QdAnpqFTLBkv/9gnZFd7rOOmeiaoQltxutH3TIi4fDmQXHAr1odVNC7LfMYCUOT3MJOnm/jDMZn79FP/VIRcGjDNgEBDLWvzaRlt37eNZkpdlJuJmqTXKgP1kj0jTmAzqNxhbAzr5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900918; c=relaxed/simple;
	bh=c7SeyIvl6VsGmWGuO3Eonlnsp4/I/OGjZxvHqsAte8I=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XZDPBLQgHiX9EtYDNhvUMtByovmr8t6N5UVx2AhM6HSk10F5mBslZa2W1gXtQYLhjy7efYFMSHrHraf/dZt7JfPUuZXqjcy+XSkHwNW7kA+GsvLx/7fIvK7m3ZMO+m7WhQGv2VRGflAjbTCfLZ2j2wO9URVd2lJ2NFdeDx7VMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGYIZuVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6D2C4CEC6;
	Wed,  6 Nov 2024 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730900918;
	bh=c7SeyIvl6VsGmWGuO3Eonlnsp4/I/OGjZxvHqsAte8I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CGYIZuVtUXzuISt/z0zmHlPQsDWE5HyiQz5h12xMLdAnFYwG42Ns6h8zs+1I+N+qw
	 MQGL9Vr2CauQIyD6K0vJ4Jei7Pl4qCv6Mp5Qs8XGjEwtw6wvrwLnAm1xnomWRDe8qi
	 LFq0B6uy5MSwkeK+soGsq9/05b3TExyxCh8ZqwhZy4DZCmYTHLGJbxnsLQ2woHOUDY
	 hNObXqbaxt9B4wZPSRUuqIoBHHa4hGfAoA5gplGmp3Mc1us/vx3LBOCXffVTviXO7E
	 J9AXkK7/r7GwFPJllSjgvIGqab1aHceMPBH5rIuG8LXF5FErRs/DW1qJVnASbHhJDM
	 MvnRaqy69kyYw==
Date: Wed, 06 Nov 2024 07:48:36 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: neil.armstrong@linaro.org, krzk+dt@kernel.org, jonas@kwiboo.se, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 andrzej.hajda@intel.com, linux-kernel@vger.kernel.org, 
 Laurent.pinchart@ideasonboard.com, conor+dt@kernel.org, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, mripard@kernel.org, 
 rfoss@kernel.org, andy.yan@rock-chips.com, jernej.skrabec@gmail.com, 
 quentin.schulz@cherry.de, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com
In-Reply-To: <20241106123304.422854-3-heiko@sntech.de>
References: <20241106123304.422854-1-heiko@sntech.de>
 <20241106123304.422854-3-heiko@sntech.de>
Message-Id: <173090091636.3280912.9491997051985691570.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: display: rockchip: Add schema for
 RK3588 DW DSI2 controller


On Wed, 06 Nov 2024 13:33:03 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The Display Serial Interface 2 (DSI-2) is part of a group of communication
> protocols defined by the MIPI Alliance. The RK3588 implements this
> specification in its two MIPI DSI-2 Host Controllers that are based on a
> new Synopsis IP.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../rockchip/rockchip,rk3588-mipi-dsi2.yaml   | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-mipi-dsi2.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241106123304.422854-3-heiko@sntech.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


