Return-Path: <linux-kernel+bounces-567500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEDEA68708
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484C717E51E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6F25178A;
	Wed, 19 Mar 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl29zLb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205328F4A;
	Wed, 19 Mar 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373511; cv=none; b=JvKFbdQ+M6QGcO3a4fJB5cNTh3MGKZIw7c2kXQmuWH9FWcadLlPpM4VvqLVDgyziIIdeFDKQxZRDd8bFeMXAJ3yDYOc3IpC7KuRtMVymlcvxz7fLcIxU15ccObgxh9nfOljzOi/u5Qs+bI+uOio2kDEOnI/3NghUEq6J5/tRXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373511; c=relaxed/simple;
	bh=pMf/64E0I6+rFdDaTCFrvk/ro7kn43RkXMkXNOOl2KE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pK+HeCNmguOZuvdAYQ7+gmhv/xKMipVvBmO9KaSBk1jIMPzfLUTRTXYuQIt+XN7tODFTuSkFSY10I1g5QZjlc/1cQyW3UJJYec8U3mZ9a0TW9+xAO7S0HEbg7dN+/HLVpUCvN76CgtjY7RDxzCJxGCwZKU7MzY7ILFg2aczUIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl29zLb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28FCC4CEE9;
	Wed, 19 Mar 2025 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373510;
	bh=pMf/64E0I6+rFdDaTCFrvk/ro7kn43RkXMkXNOOl2KE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Vl29zLb1ktQPGIFpaNCNSePzZ1tgJ5hKdd5I92dGYAvusEMf8SCjPdQgubq4Ms0t9
	 7SKID+5erdpQG2UtW90kjWUfnXo0vJDKavGDxGxR0hlAxI1Gn+dxBUfVhRALKaAKyg
	 Ot8ENmOEA63ZqhoPlid0lTt3Jr5qNoxH0bRgksNlTy24NAm3Hekae761xiCb0JjP+S
	 eQWRaEJ+T32XrfF59cyYkfJdyI0yYFxgL0wZx66chMPEg04AjlvTUpyoAMRQE+47tr
	 RPd6YRGhnY93+EsgNcdEdtRSZJZxBVEc17kWLzwP1mf24t+Ob98BRT3kfjItJnoe07
	 SmPwDMODRObEw==
Date: Wed, 19 Mar 2025 03:38:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: shuai.li@amlogic.com, devicetree@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 linux-amlogic@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, 
 linux-kernel@vger.kernel.org, zhe.wang@amlogic.com, 
 Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, jian.xu@amlogic.com, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jiebing chen <jiebing.chen@amlogic.com>
In-Reply-To: <20250319-audio_drvier-v4-1-686867fad719@amlogic.com>
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-1-686867fad719@amlogic.com>
Message-Id: <174237350819.971004.1098115771430334211.robh@kernel.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: clock: meson: Add audio power
 domain for s4 soc


On Wed, 19 Mar 2025 15:04:44 +0800, jiebing chen wrote:
> Audio power domain found on S4 device.it need to enable before audio work.
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
>  .../bindings/clock/amlogic,axg-audio-clkc.yaml       | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml:105:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.example.dtb: clock-controller@0: reg: [[0, 0, 0, 180]] is too short
	from schema $id: http://devicetree.org/schemas/clock/amlogic,axg-audio-clkc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250319-audio_drvier-v4-1-686867fad719@amlogic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


