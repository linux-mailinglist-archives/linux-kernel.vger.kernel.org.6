Return-Path: <linux-kernel+bounces-212002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7839059DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DB7B22B10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743301822CE;
	Wed, 12 Jun 2024 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LypDdc56"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54513209;
	Wed, 12 Jun 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213179; cv=none; b=oZaMeQtH1ObpckbJSkEmG1ylWMkrxFirB9CEa5Otk3ad12i20jLJkQj0rrgFIAnwcXBoIeMCIWpYVFEYulGusjdV5AWtP7+mNb5Q4HWyPvZFmlidNQ9C+bYZhSZpGz3r3hsXwwCxFzbJlOc1BGxsKP7jdqCBXsxXkJsbdYoGcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213179; c=relaxed/simple;
	bh=8mAINEWgGiadV1kEJND+F9WvJE3WuJIALswoL9FapSI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sLFLsAUD3jkw6ri8Yt0YKT6vqVJJIR5M6zslCc9qmcwqPwPbkCIeaI+b31YjK1jZH/LRFa0qfoM2IuYIm8KPcD0KHTEp4V3wTeUT/kTV8CChdsAsIkV3MmJHUt6gDK4lr3bGs5WLpfLJuEZaiOUxgsoWxL9cVKtEJM+WNe51WEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LypDdc56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58848C116B1;
	Wed, 12 Jun 2024 17:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718213179;
	bh=8mAINEWgGiadV1kEJND+F9WvJE3WuJIALswoL9FapSI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LypDdc56kiZi2JjvRRlVxTTMRS9WLepzejGCDmQSSqGvE8U5TsAtu5H7PCR7GWD2R
	 +V0vb9dzRZdgXA/g8wDH85Ykf4fzHukdkp1eeNKP+zPvnocP0m15T1hyy8vIZjm+sI
	 hZWYo5G91IrrSKFHkF6uATS6vQeP8wnNmRkjmDh1QI4l330XPyLK7vX1UUO4xEOzSd
	 lSz0C1gpZyZLJ6XEs/TI3I55reyrrvf5ZZS+SB5ArmB+yErQn/fGulgKkQAYUGc0g4
	 RXvFduL9Y9KlCeTYEfQZC/uvOb5lB2e3ERkH+SJHxK8V78Xu8YwttIPlA334EtlbOe
	 AzBB30DTa/aiA==
Date: Wed, 12 Jun 2024 11:26:18 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: skhan@linuxfoundation.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, cristian.ciocaltea@collabora.com, 
 javier.carrasco.cruz@gmail.com, krzk+dt@kernel.org, 
 sebastian.reichel@collabora.com, heiko@sntech.de, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
 s.hauer@pengutronix.de, vkoul@kernel.org, andy.yan@rock-chips.com, 
 kishon@kernel.org
In-Reply-To: <20240612160336.5132-2-shresthprasad7@gmail.com>
References: <20240612160336.5132-2-shresthprasad7@gmail.com>
Message-Id: <171821317822.3213383.11527359300023322395.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: phy: rockchip-emmc-phy: Convert to
 dtschema


On Wed, 12 Jun 2024 21:33:37 +0530, Shresth Prasad wrote:
> Convert txt bindings of Rockchip EMMC PHY to dtschema to allow
> for validation.
> 
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Changes in v2:
>     - Fixed example
>     - Changed file referenced in grf.yaml
> 
> Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
> and `rockchip/rk3399-pinebook-pro.dtb`.
> 
>  .../bindings/phy/rockchip,emmc-phy.yaml       | 79 +++++++++++++++++++
>  .../bindings/phy/rockchip-emmc-phy.txt        | 43 ----------
>  .../devicetree/bindings/soc/rockchip/grf.yaml |  2 +-
>  3 files changed, 80 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.example.dtb: syscon@ff770000: reg: [[0, 4285988864], [0, 65536]] is too long
	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.example.dtb: syscon@ff770000: reg: [[0, 4285988864], [0, 65536]] is too long
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240612160336.5132-2-shresthprasad7@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


