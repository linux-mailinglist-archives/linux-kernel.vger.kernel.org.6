Return-Path: <linux-kernel+bounces-205927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 541AD900241
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD9C1F281E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51B718F2C9;
	Fri,  7 Jun 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOOuwWsj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3992837F;
	Fri,  7 Jun 2024 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760129; cv=none; b=bGj9ogAE6UAX+E0wKdRzs3JNAz9IEjsWK45X1B073wrQhSYW6ZXlbFqjsidx1tpqypNnbpb+3oMy8foTawCwM3Y/kHrbx6nVbrmhcUowxsdI/b7npjM92Nh+AhXy4l6feQpRX0SYIHapwYQJ3C6/E4wRwteVFyzY6CQlSff6gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760129; c=relaxed/simple;
	bh=y7+8ojeWaklXFdnopbOqrkFJH6Oh8Z5R/PffM5vSdfg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=V+dKywj8yaASab290sdb3Gi2kBiHlAVD4GsLCRdI3anyMjVNLPrhpejcNt35VrbVcrRZAITDQkdEtP0TIxuYV7LjS5/3t9fdYPSXXmjIlP8VRczyUoPmWieE0SSKgURV0RKO+ccrAVmh8ertfP03hRCb1CNulFWzzPiSkBlWBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOOuwWsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4913FC2BBFC;
	Fri,  7 Jun 2024 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717760128;
	bh=y7+8ojeWaklXFdnopbOqrkFJH6Oh8Z5R/PffM5vSdfg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SOOuwWsj5QcciH77iaCxUtsiio48wUTC8mcnND+OlApkTD7emSSH/tZ3qCHkG1LYA
	 Brhqf+roHNXGCQKUX9M3eGuUeOYLDdhDvg4FE1MWMxDfwXZehoMsdztnwEQNd6DTZj
	 PVXdjLiWnXLxJzS9I2AScHWqD6FC6Jizn1rSC+2HzL0EJ970MeahFUO9S2CjzOV7wt
	 8SHu/TH8VSVGiagQoQ9c17sT08LM3A76RWzmYsvPt6wTjJWaexzD33E/rNMwgBucaS
	 VW1fg+ErnDwVlk2SMgvdMljfvv6nRWrmrYXz0/YBgjkKjbZRlLQUTji8bEjiEelC65
	 DhAeuLxS94vkw==
Date: Fri, 07 Jun 2024 05:35:27 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Ricard Wanderlof <ricardw@axis.com>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, Baojun Xu <baojun.xu@ti.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, devicetree@vger.kernel.org, 
 kernel@axis.com, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, alsa-devel@alsa-project.org, 
 Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Kevin Lu <kevin-lu@ti.com>
In-Reply-To: <20240607-tlv320adc3xxx-micbias-gpo-v2-1-b140a45ffffe@axis.com>
References: <20240607-tlv320adc3xxx-micbias-gpo-v2-0-b140a45ffffe@axis.com>
 <20240607-tlv320adc3xxx-micbias-gpo-v2-1-b140a45ffffe@axis.com>
Message-Id: <171776012736.1713547.9580962210836921996.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: tlv320adc3xxx: Add
 MICBIAS-as-GPO properties


On Fri, 07 Jun 2024 12:00:45 +0200, Ricard Wanderlof wrote:
> Add properties for configuring the MICBIAS pins as general purpose
> outputs, with some limitations: The voltage on the pin when activated
> may be set using another property to 2.0 V, 2.5 V or AVDD.
> When deactivated the pin will float.
> 
> Signed-off-by: Ricard Wanderlof <ricard.wanderlof@axis.com>
> ---
>  .../bindings/sound/ti,tlv320adc3xxx.yaml           | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml:128:25: [warning] too few spaces after comma (commas)
./Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml:129:25: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240607-tlv320adc3xxx-micbias-gpo-v2-1-b140a45ffffe@axis.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


