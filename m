Return-Path: <linux-kernel+bounces-168999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B338BC0BD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49612282D6F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B422F0A;
	Sun,  5 May 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAamZeO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAEB22625;
	Sun,  5 May 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918888; cv=none; b=jSfVGa2kWQdV26l6nrGqBXGXR61CMYZACBYVmEt6S+4QBEY1aGKPOAKEogUtXNUwYsPTrI/ojJbfXigS/4la4wco/OC6AFyzzvbSeo3nlEDM6ADsBW1H1AjJ7eDzeH2cAHQT3mswKK8xKWBa4hrAy01oymNBAKQ+OZRIwt2yhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918888; c=relaxed/simple;
	bh=vcX2OvZvu6X9DYQ6XWaLEsIDPp42KwZN4oit/W4BZU4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=DTgMsg0MaJAp/VRFfRfjecvnogJgyJMmhvBddXoL0a2TQQc69gn6a8VFsAwghqL+013kMlZrJqVKYAUAjgh0PYP8jFQAKwkoyvn7mSH0fm1wzFyqK12nzZLBxNkDBvi40zYB/pJUPnyFtA0zKXQp3n3TSjZjmlDCZW2njHH3jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAamZeO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44082C113CC;
	Sun,  5 May 2024 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714918887;
	bh=vcX2OvZvu6X9DYQ6XWaLEsIDPp42KwZN4oit/W4BZU4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WAamZeO2xqGI0kJ0UF5QCCiw4nVDRIssQZhnnNTJZVz5NxfLYeNBP5LTQ9EGYIZtd
	 IoHP5nNydCGIuoCvqt9ITRaFwI/WMrfKNpqKQVFNkPBYUCIjWvN/yoMlvFYqx7JUGW
	 HpuEc8f4XzHUb2AWg1QfbhVuvNgvam/tDCJZBDSsy1r3XGNjcZRXVG3qr+hTPtzyE8
	 zJqf6yLd5KBUoqheixL3Yhu+kDbj+g5ZMsdbsExbptuZVByq2TTdc77zCHlNTofAQ5
	 PXEkWVesDKM5HwMNytCfZPGuB+hWfzDOyWsQLHNHyx6o9MoQ4l7RWHozBN62GkLM2W
	 8UZok0eh2ZHiw==
Date: Sun, 05 May 2024 09:21:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>, 
 Zhang Qing <zhangqing@rock-chips.com>, linux-arm-kernel@lists.infradead.org, 
 Chris Zhong <zyw@rock-chips.com>, linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org
In-Reply-To: <20240505134120.2828885-3-jonas@kwiboo.se>
References: <20240505134120.2828885-1-jonas@kwiboo.se>
 <20240505134120.2828885-3-jonas@kwiboo.se>
Message-Id: <171491888618.1725063.9283518594556057694.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: mfd: rk809: Add audio codec
 properties


On Sun, 05 May 2024 13:41:12 +0000, Jonas Karlman wrote:
> Similar to RK817 the RK809 also integrates a complete audio system.
> 
> Add audio codec properties to binding to reflect this.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  .../bindings/mfd/rockchip,rk809.yaml          | 34 ++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/rockchip,rk809.example.dtb: pmic@1b: 'codec' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk808.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240505134120.2828885-3-jonas@kwiboo.se

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


