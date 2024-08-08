Return-Path: <linux-kernel+bounces-279922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F0794C37A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7465A1C2221E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C2D189B8D;
	Thu,  8 Aug 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLECvuLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C16190489;
	Thu,  8 Aug 2024 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137452; cv=none; b=TpP0OZlUA6nOMBtPwcxJ8quyP6KWxPCnlq/kJsrW09M03FuTlNY2S/c4XUkZjzJCpyGi6MLuus9MVESmQUNNP2U7daplENcs+t31sz0YZx3CCLXyFNFqL6PcrWWsCXYmDLLOzVVDzxQCwnZVWdQxDtZMLuCOfKmJk48PqpSmi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137452; c=relaxed/simple;
	bh=+A2ABjowY1uwCXufdD4VYUuq2E3xVfwjhSzZriEGmTk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KPszIQYxUuv5jTlMKwyFKtOrNUe4b0SSJT0bxVmmCMIR0Fu5ufiC1l3ZQkWDXDKAH9+HwjM5VAjZ7aU26wb662UcP7or6PaQMuUypD/pAGo3NOcfNXRWZkC0cHtdJzsj1CBA/n9nIz1E9IyGXNSDKUIWTEFYEG4duI7icS+ce9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLECvuLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724B8C32782;
	Thu,  8 Aug 2024 17:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723137450;
	bh=+A2ABjowY1uwCXufdD4VYUuq2E3xVfwjhSzZriEGmTk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iLECvuLD2ett8jb54Hpj+bA3hMmCpX512SPRuoJwNpMU0EwfjdgHxc8I9LkcYJnMa
	 /16hh6Dq5TkhW4DColyYB/N3DUhQu1WfY9kHyLyzGuclkyg3b2VX77D0KEUB/Nf6ZT
	 xf/8+S71gI9NiaKop7J4Z1FGtB0qINt6tss+bbs6GmUVpMHuU4IyS+EQMG7T84yGoi
	 6Py0QyweroVTrYqQFYfk6EzHwSnFrfE61//DL+PjvxykO9pUfHL4bgdJ5cK1Z5V+Xs
	 xzOU03y5M9HM3z9qWR+D5VAdUD9jyA297KR+Gh0yE576P4l07ynZVwoGtEkXvD3+lr
	 US8cOqlhms30w==
Date: Thu, 08 Aug 2024 11:17:29 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-rockchip@lists.infradead.org, 
 Elaine Zhang <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20240808162258.79271-3-detlev.casanova@collabora.com>
References: <20240808162258.79271-1-detlev.casanova@collabora.com>
 <20240808162258.79271-3-detlev.casanova@collabora.com>
Message-Id: <172313744929.1529145.2568982422354325643.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: Add rk3576 clock
 definitions and documentation


On Thu, 08 Aug 2024 12:20:57 -0400, Detlev Casanova wrote:
> Add clock ID defines for rk3576.
> 
> Compared to the downstream bindings written by Elaine, this uses
> continous gapless clock IDs starting at 1. Thus all numbers are
> different between downstream and upstream, but names are kept
> exactly the same.
> 
> Also add documentation for the rk3576 CRU core.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../bindings/clock/rockchip,rk3576-cru.yaml   |  83 +++
>  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 592 ++++++++++++++++++
>  2 files changed, 675 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.example.dts:24.19-20 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240808162258.79271-3-detlev.casanova@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


